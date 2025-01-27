Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6773C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 18:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcTrp-0001tq-0H; Mon, 27 Jan 2025 13:29:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tcTrk-0001sn-W6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1tcTrj-00067U-9t
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 13:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738002582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhvSXP/l9pmazB5rnyKjJUSw4LbbFj03DD9BsGHeBlQ=;
 b=iGY8OlwJOoCVsxYKjoBv/MqDSFC4EHQzwAL44X8X3gzthtHBOJbjjKCSsvJhm6rRstolMo
 Trjrin+q54HkIeRVAVAAXGP/Ld3ylD83hF1j7YZZ39BTlPM7vpI4qXToNPHsUz5viZO8Z2
 ZXR/6L17CbglxAoeCOH4Igvse3R19UU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-0crCdkelOryFcqA4cT5YkQ-1; Mon,
 27 Jan 2025 13:29:40 -0500
X-MC-Unique: 0crCdkelOryFcqA4cT5YkQ-1
X-Mimecast-MFC-AGG-ID: 0crCdkelOryFcqA4cT5YkQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 193501800268; Mon, 27 Jan 2025 18:29:39 +0000 (UTC)
Received: from harajuku.usersys.redhat.com (unknown [10.45.224.68])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1305319560A3; Mon, 27 Jan 2025 18:29:35 +0000 (UTC)
From: Andrea Bolognani <abologna@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Abdurachmanov <davidlt@rivosinc.com>
Subject: [PATCH v2 3/3] binfmt: Add --ignore-family option
Date: Mon, 27 Jan 2025 19:29:24 +0100
Message-ID: <20250127182924.103510-4-abologna@redhat.com>
In-Reply-To: <20250127182924.103510-1-abologna@redhat.com>
References: <20250127182924.103510-1-abologna@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Until now, the script has worked under the assumption that a
host CPU can run binaries targeting any CPU in the same family.
That's a fair enough assumption when it comes to running i386
binaries on x86_64, but it doesn't quite apply in the general
case.

For example, while riscv64 CPUs could theoretically run riscv32
applications natively, in practice there exist few (if any?)
CPUs that implement the necessary silicon; moreover, even if you
had one such CPU, your host OS would most likely not have
enabled the necessary kernel bits.

This new option gives distro packagers the ability to opt out of
the assumption, likely on a per-architecture basis, and make
things work out of the box for a larger fraction of their user
base.

As an interesting side effect, this makes it possible to enable
execution of 64-bit binaries on 32-bit CPUs of the same family,
which is a perfectly valid use case that apparently hadn't been
considered until now.

Link: https://src.fedoraproject.org/rpms/qemu/pull-request/72
Thanks: David Abdurachmanov <davidlt@rivosinc.com>
Thanks: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Andrea Bolognani <abologna@redhat.com>
---
 scripts/qemu-binfmt-conf.sh | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 8d9136a29f..5fd462b1d1 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -205,6 +205,9 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
        --persistent:    if yes, the interpreter is loaded when binfmt is
                         configured and remains in memory. All future uses
                         are cloned from the open file.
+       --ignore-family: if yes, it is assumed that the host CPU (e.g. riscv64)
+                        can't natively run programs targeting a CPU that is
+                        part of the same family (e.g. riscv32).
        --preserve-argv0 preserve argv[0]
 
     To import templates with update-binfmts, use :
@@ -337,7 +340,12 @@ qemu_set_binfmts() {
         fi
 
         if [ "$host_family" = "$family" ] ; then
-            continue
+            # When --ignore-family is used, we have to generate rules even
+            # for targets that are in the same family as the host CPU. The
+            # only exception is of course when the CPU types exactly match
+            if [ "$target" = "$host_cpu" ] || [ "$IGNORE_FAMILY" = "no" ] ; then
+                continue
+            fi
         fi
 
         $BINFMT_SET
@@ -355,10 +363,11 @@ CREDENTIAL=no
 PERSISTENT=no
 PRESERVE_ARG0=no
 QEMU_SUFFIX=""
+IGNORE_FAMILY=no
 
 _longopts="debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,\
-persistent:,preserve-argv0:"
-options=$(getopt -o ds:Q:S:e:hc:p:g:F: -l ${_longopts} -- "$@")
+persistent:,preserve-argv0:,ignore-family:"
+options=$(getopt -o ds:Q:S:e:hc:p:g:F:i: -l ${_longopts} -- "$@")
 eval set -- "$options"
 
 while true ; do
@@ -418,6 +427,10 @@ while true ; do
         shift
         PRESERVE_ARG0="$1"
         ;;
+    -i|--ignore-family)
+        shift
+        IGNORE_FAMILY="$1"
+        ;;
     *)
         break
         ;;
-- 
2.48.1


