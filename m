Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAC1C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkgvl-0002ZO-Hb; Wed, 19 Feb 2025 05:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkgvj-0002Ym-6n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:03:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkgvg-00064z-Ei
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739959422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=idliG5uxF6AgCEF+s9s1MFO4Q+TRtQNZHksc0RSvRig=;
 b=EFt3AiJJje4bsi7vGX2VIrcl99BE08YeZuxUpOeugA0w1cXJvVu+hfSyL0xXtMbEl0blGQ
 j9d67WjJ2NmbIG+Qm8Wci2QhcwFsCo2D/l3o+hb2UFcJ7tAl+nR9+nQWp+myRtfA3zTCfW
 UQ2PTwSs6xlcsxRuWIeO5CCoRgSkDZs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-cjl7kcbeNZSoYVqDf3HBng-1; Wed,
 19 Feb 2025 05:03:39 -0500
X-MC-Unique: cjl7kcbeNZSoYVqDf3HBng-1
X-Mimecast-MFC-AGG-ID: cjl7kcbeNZSoYVqDf3HBng_1739959419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79F61800264; Wed, 19 Feb 2025 10:03:38 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.135])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F7B61800941; Wed, 19 Feb 2025 10:03:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] linux-user: fix resource leaks in gen-vdso
Date: Wed, 19 Feb 2025 10:03:36 +0000
Message-ID: <20250219100336.1696758-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 linux-user/gen-vdso.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index 721f38d5a3..88d94b19eb 100644
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
-    }
-    return EXIT_SUCCESS;
+    ret = EXIT_SUCCESS;
+
+ cleanup:
+    free(buf);
+
+    if (outf &&
+        fclose(outf) != 0)
+        ret = EXIT_FAILURE;
+    if (inf &&
+        fclose(inf) != 0)
+        ret = EXIT_FAILURE;
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
2.47.1


