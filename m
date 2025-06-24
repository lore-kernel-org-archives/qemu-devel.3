Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51853C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJd-0000aS-3o; Mon, 23 Jun 2025 21:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJb-0000Zg-2E
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:11 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJZ-0005oQ-5P
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-748e63d4b05so2865456b3a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727948; x=1751332748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S67UPro4B0nfkkspRfqxPQxazBoANRUB0NMG6SLVuGQ=;
 b=QPDpfX1FbhXmP9aSRhm1ciHrMvAK1g4vjyvnxZeTfxjTtVVxJdFlzVbHZkJIGLDMc2
 55Em3MDTx+O/sO/2sbXWyXwUXwQ9oCSTPjBoiHSrcOLlLMbFuX8cx33QgE801nyQ2Ubw
 Li9xAZj2UVKTCA7B7LsxvxarxOcum2C+f6j9NU9LUZFZYgGCAF+GGQISgDjkeVZ6uOZQ
 fwoMkhLBoLBML3Z9bogg6R6TAuxy8OVvxQWASbzlC/1Kd9Ij9qXTUyi0Is2hEthFSnEe
 DpEUzZYigj2PXfBKBVRHgenNR/+RyznBcfyll2/bK2JEq+8B1ncsD2Sq8KE4k3eIcB9d
 tHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727948; x=1751332748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S67UPro4B0nfkkspRfqxPQxazBoANRUB0NMG6SLVuGQ=;
 b=TYSXEZj77FhY/UlKoa9xOgbON69zi1RpGupXMWy0rhx2z9Lj018j1en60m488f8dXx
 D18T/oBhDW6UZ42QzZt+LCBHYtD4BkcpAtokaULMRPHTxbUEK3V6P5zeWyL0HeFrvDCQ
 5PuWGc8Iu735pGIQwAIJZ7H60q7D2wbiTVejmP5LAEYveM4AsrVG7pRvVjchifX3xG7X
 4IRw1regDvuyPJMgGJFWtTuvLGI0U0NyRV6WYGGHoRJQZ5lXQG/FkyYiHl1dTZSrm7Hx
 2/fWoRgXEPx5RiiXx4XT9ZuIU4rGzt1ywVy5SFUEDlYgLM5ccv+MmB2SGXz3vJn/hi+t
 pDvw==
X-Gm-Message-State: AOJu0YwSaERfYIXV9hmB3mu+dIatB8H11zw0SI1Ym3URsXPP1pzgF4x5
 B7IlnvbNXzPhCbbe8yUkJtMQNpCVf7Az7v0scuAS5QxTHkUjVqhAkCZsNyujmzkRSsw4iuwxnjk
 greoEz2U=
X-Gm-Gg: ASbGncsEvq30ofkOe7/729hg7vjx3+DtcPHDkwPdM8jxYLyVts4s+bLrsrzqq48oyzk
 xMRV36keo8tX35ijZ3Qmdy0aldyJkelJq5dIJu0jeJgKcYWN9s7s/fjGZ/g4iqv4s/i1myupWlo
 VBjKKaaeW1MDG3jf6f+mAKlIo7pVXEpn+k4tRZRySQ/p+8d7LQWOY9fhVKN+dt5EpP/4+nv8I89
 idtLrjUMKsBmHb0mupF1jWLPtAUMwTisuVyO4gAr9zc+m8eZgJnOfriIYYexhh06jkRNN26F86r
 uhx8vd528zw2EQZRe5zrzsViDrCC6/27P8M0sBKJHdMFdfniFL4c1orySGBWw8x7y6Z8STqWVC2
 X7alnpjBV4tFHifrdDumwJwhCRPWB0r4=
X-Google-Smtp-Source: AGHT+IHtS89juOAlQwcnBgeZqKXlipsFgYQfCM/rE6p999D0zkGNSwWxu9gr+ThmamkKR7ZMTK01Uw==
X-Received: by 2002:a05:6a00:1903:b0:748:f1ba:9b0d with SMTP id
 d2e1a72fcca58-7490d6fae3bmr20331243b3a.11.1750727947726; 
 Mon, 23 Jun 2025 18:19:07 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Arusekk <floss@arusekk.pl>
Subject: [PULL 11/11] linux-user: fix resource leaks in gen-vdso
Date: Mon, 23 Jun 2025 18:18:59 -0700
Message-ID: <20250624011859.112010-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Tested-by: Arusekk <floss@arusekk.pl>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250513150346.1328217-1-berrange@redhat.com>
---
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
     }
-    return EXIT_SUCCESS;
+    if (inf && fclose(inf) != 0) {
+        ret = EXIT_FAILURE;
+    }
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
2.43.0


