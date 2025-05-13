Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8C5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErAr-0006qN-Jk; Tue, 13 May 2025 11:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uErAo-0006pc-Uy
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uErAm-00035L-CJ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747148638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jIgGRdk4wDHR13EIann1hKkSdob6KVG0A8frMh8d7tU=;
 b=SMKpK/WFo4EAGObBWUy0dy1Ay0F/7i6cH/JohRXF9hJXdelE2gzksrFS/q0BxFlrVZCe9U
 uUK95O5hqwIIUpMFQmVZSeEghS6dYQ3zsLzbDkZjn0bImgaGlKAdxWueQpJVJ5DPXrNyv1
 V01pn4GChpdb/+RvS+lM6fp2DdOcDv8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-lKbiCQq7M0W36j--oADmRA-1; Tue,
 13 May 2025 11:03:55 -0400
X-MC-Unique: lKbiCQq7M0W36j--oADmRA-1
X-Mimecast-MFC-AGG-ID: lKbiCQq7M0W36j--oADmRA_1747148634
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78CE91800374; Tue, 13 May 2025 15:03:54 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E139618003FC; Tue, 13 May 2025 15:03:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2] linux-user: fix resource leaks in gen-vdso
Date: Tue, 13 May 2025 16:03:46 +0100
Message-ID: <20250513150346.1328217-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are a number of resource leaks in gen-vdso. In theory they are
harmless because this is a short lived process, but when building QEMU
with --extra-cflags="-fsanitize=address" problems ensure. The gen-vdso
program is run as part of the build, and that aborts due to the
sanitizer identifying memory leaks, leaving QEMU unbuildable.

FAILED: libqemu-x86_64-linux-user.a.p/vdso.c.inc
/var/home/berrange/src/virt/qemu/build/linux-user/gen-vdso -o libqemu-x86_64-linux-user.a.p/vdso.c.inc ../linux-user/x86_64/vdso.so

=================================================================
==1696332==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 2968 byte(s) in 1 object(s) allocated from:
    #0 0x56495873f1f3  (/var/home/berrange/src/virt/qemu/build/linux-user/gen-vdso+0xa11f3) (BuildId: b69e241ad44719b6f3934f3c71dfc6727e8bdb12)
    #1 0x564958780b90  (/var/home/berrange/src/virt/qemu/build/linux-user/gen-vdso+0xe2b90) (BuildId: b69e241ad44719b6f3934f3c71dfc6727e8bdb12)

This complaint is about the 'buf' variable, however, the FILE objects
are also leaked in some error scenarios, so this fix refactors the
cleanup paths to fix all leaks. For completeness it also reports an
error if fclose() fails on 'inf'.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---

Changed in v2:

 - Add missing braces

 linux-user/gen-vdso.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index 721f38d5a3..fce9d5cbc3 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -56,13 +56,14 @@ static unsigned rt_sigreturn_addr;
 
 int main(int argc, char **argv)
 {
-    FILE *inf, *outf;
+    FILE *inf = NULL, *outf = NULL;
     long total_len;
     const char *prefix = "vdso";
     const char *inf_name;
     const char *outf_name = NULL;
-    unsigned char *buf;
+    unsigned char *buf = NULL;
     bool need_bswap;
+    int ret = EXIT_FAILURE;
 
     while (1) {
         int opt = getopt(argc, argv, "o:p:r:s:");
@@ -129,7 +130,6 @@ int main(int argc, char **argv)
         fprintf(stderr, "%s: incomplete read\n", inf_name);
         return EXIT_FAILURE;
     }
-    fclose(inf);
 
     /*
      * Identify which elf flavor we're processing.
@@ -205,19 +205,24 @@ int main(int argc, char **argv)
     fprintf(outf, "    .rt_sigreturn_ofs = 0x%x,\n", rt_sigreturn_addr);
     fprintf(outf, "};\n");
 
-    /*
-     * Everything should have gone well.
-     */
-    if (fclose(outf)) {
-        goto perror_outf;
+    ret = EXIT_SUCCESS;
+
+ cleanup:
+    free(buf);
+
+    if (outf && fclose(outf) != 0) {
+        ret = EXIT_FAILURE;
+    }
+    if (inf && fclose(inf) != 0) {
+        ret = EXIT_FAILURE;
     }
-    return EXIT_SUCCESS;
+    return ret;
 
  perror_inf:
     perror(inf_name);
-    return EXIT_FAILURE;
+    goto cleanup;
 
  perror_outf:
     perror(outf_name);
-    return EXIT_FAILURE;
+    goto cleanup;
 }
-- 
2.49.0


