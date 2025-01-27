Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC34C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 18:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcTrk-0001sP-SG; Mon, 27 Jan 2025 13:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tcTrh-0001rx-3U
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:29:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tcTrf-00066I-CR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738002578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+loXBye3EAweVzTP0a16F0J9pn82TdKoCRiTYEG6sM=;
 b=JzO1teo29KDG9HKWP1Dht0UxL6+C6x30sIsuPH1oJFhuw4um6J49qddeCx/SJjod/9neBU
 /RBg2wQPDyWbLVsVDT5MMmg5zeUozzCNANrukNvHEf/bWbtVn46q2aQYJ8Rg0ZpxbHDE0G
 GQrjwcVnL7Bqwg1FbFYFZVEPyZWMCKc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-E7kskyKEPMuotJNMIXKJLQ-1; Mon,
 27 Jan 2025 13:29:37 -0500
X-MC-Unique: E7kskyKEPMuotJNMIXKJLQ-1
X-Mimecast-MFC-AGG-ID: E7kskyKEPMuotJNMIXKJLQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AF09195608A; Mon, 27 Jan 2025 18:29:35 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.45.224.68])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 752C919560A3; Mon, 27 Jan 2025 18:29:33 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Abdurachmanov <davidlt@rivosinc.com>
Subject: [PATCH v2 2/3] binfmt: Normalize host CPU architecture
Date: Mon, 27 Jan 2025 19:29:23 +0100
Message-ID: <20250127182924.103510-3-abologna@redhat.com>
In-Reply-To: <20250127182924.103510-1-abologna@redhat.com>
References: <20250127182924.103510-1-abologna@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Right now information regarding the family each CPU type belongs
to is recorded in two places: the large data table at the top of
the script, and the qemu_host_family() function.

We can make things better by mapping host CPU architecture to
QEMU target in the few cases where the two don't already match
and then using the data table to look up the family, same as
we're already doing for the guest CPU architecture.

Being able to reason in terms of QEMU target regardless of
whether we're looking at the host or guest CPU architecture will
come in handy to implement upcoming changes.

A couple of entries are dropped in the process: BePC and Power
Macintosh. I'm quite certain neither of those have ever been
reported as CPU architectures by Linux. I believe many more of
the entries that are carried forward could be dropped as well,
but I don't have the same level of confidence there so I
decided to play it safe just in case.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
---
 scripts/qemu-binfmt-conf.sh | 44 +++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 426f075e31..8d9136a29f 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -144,35 +144,35 @@ loongarch64_magic='\x7fELF\x02\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x
 loongarch64_mask='\xff\xff\xff\xff\xff\xff\xff\xfc\x00\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
 loongarch64_family=loongarch
 
-qemu_get_family() {
-    cpu=${HOST_ARCH:-$(uname -m)}
+# Converts the name of a host CPU architecture to the corresponding QEMU
+# target.
+#
+# FIXME: This can probably be simplified a lot by dropping most entries.
+#        Remember that the script is only used on Linux, so we only need to
+#        handle the strings Linux uses to report the host CPU architecture.
+qemu_normalize() {
+    cpu="$1"
     case "$cpu" in
-    amd64|i386|i486|i586|i686|i86pc|BePC|x86_64)
+    i[3-6]86)
         echo "i386"
         ;;
-    mips*)
-        echo "mips"
+    amd64)
+        echo "x86_64"
         ;;
-    "Power Macintosh"|ppc64|powerpc|ppc)
+    powerpc)
         echo "ppc"
         ;;
-    ppc64el|ppc64le)
-        echo "ppcle"
+    ppc64el)
+        echo "ppc64le"
         ;;
-    arm|armel|armhf|arm64|armv[4-9]*l|aarch64)
+    armel|armhf|armv[4-9]*l)
         echo "arm"
         ;;
-    armeb|armv[4-9]*b|aarch64_be)
+    armv[4-9]*b)
         echo "armeb"
         ;;
-    sparc*)
-        echo "sparc"
-        ;;
-    riscv*)
-        echo "riscv"
-        ;;
-    loongarch*)
-        echo "loongarch"
+    arm64)
+        echo "aarch64"
         ;;
     *)
         echo "$cpu"
@@ -309,7 +309,13 @@ EOF
 
 qemu_set_binfmts() {
     # probe cpu type
-    host_family=$(qemu_get_family)
+    host_cpu=$(qemu_normalize ${HOST_ARCH:-$(uname -m)})
+    host_family=$(eval echo \$${host_cpu}_family)
+
+    if [ "$host_family" = "" ] ; then
+        echo "INTERNAL ERROR: unknown host cpu $host_cpu" 1>&2
+        exit 1
+    fi
 
     # register the interpreter for each cpu except for the native one
 
-- 
2.48.1


