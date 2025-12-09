Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B5ED3B7F3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yq-0001tM-TV; Tue, 09 Dec 2025 15:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3ym-0001Xa-Nu
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:37 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yk-0001KV-LO
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:36 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42e2ce8681eso4140445f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310793; x=1765915593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ed40xnu/OysTcrDHnWWD1d+2jw+gGT2aWZVPYLkNz/4=;
 b=qTAp7y8MjHE/3nHcR7Wm3H2K6eZEWIokdEnHPl7YJkZ2pZCVEV0/0s8mYiq7ynOaP3
 xHh2I75NqqzLrn9WjhzWPiY1yxlqx5qKeM6cM7j/swby97y7x8Bu41dWrUuw7KGVUjg1
 1i8oKeddx7w4XgE40eiUVXYOEAkSEju3k3ryoPzUm3uInRbtCO1S3sC7euSrd3TPW4sY
 qjpJxywetTBcevIvu31mzpWOOm/qfvTR3lTnyQhSKNTeTZecL3V6ZLLpZx9WM1fNaXw3
 hvdrlU5xy4xhwBpkmghiH9ceGnzXfp20svwZPTgAFn5XXuRkcOpvbgbWuvSmeKgK1b/X
 6Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310793; x=1765915593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ed40xnu/OysTcrDHnWWD1d+2jw+gGT2aWZVPYLkNz/4=;
 b=w36Xzx62Hw+QMABUPbQdD1bXSmI1eC1tCHrP+tjYACn5rK0Lbtr+dIdQglB5lNwQvn
 OgNoZJMMg3FrnY0Trs0760l7EnqRypxdEnGuoCLk6Yn8WfUgy6V7pVAEkmh4fhY5qmk2
 fdT8qKsjN2r0rVM6R0YAaL3D6oG+UAsAQY69RPlalC+b92qb5vjI6ncoJXMthOc5lbhm
 xhlZcneIZPFu2vWoFvGnb2E98tLMS1N2PX/ja73DiVBPFZvf+uFZx3uU/RA3UKgebp7b
 NM9eKYaxSjYO89qj4bxWkg42Nob7IwR34kscKPDGqgdKJjwjY0DdPo6TuICdtyQV1+n1
 aacA==
X-Gm-Message-State: AOJu0Yx33Fq3i6SDgC5nx1zVupkmDWPyBAYFXbjSQMPk/Mparr7rjGCV
 HDKz73NTUvOwwCkeGdD9LGf9UgdbdGuKf7ne9FjoXp4jOepeyLoc0a05cVWMtgPAgc9sPV9KG9P
 OMAb+wow=
X-Gm-Gg: AY/fxX5yOSbRNuJ6H96tJy9rc0ohvaasfvkakJaMBZuQIy6MiBQnM4xvpJfDtRt4JAw
 uSLHvdjV5uGm5cQja94qK8i7iA4PbWa7/3CcK/moP2NCBYPFJC5N/f3iBr4wbw5ypAINnLuz36W
 9NTrF/h/kLBVtqMYqgBUvYnpfaXo0sZdgg6r277af8x91eOLGPiHM+uKUK3AFzOxdVYd9iZEHeS
 TDwgtUNZmjIMrlGxYolGBd3frylosD18nQAKgoAjqsn5XFwQRCt+LMC+r9W3YqmyZgYU+z4cHAT
 a1vrSlnqABZ2BsohW2PaKRmINt4yrNFdecrIh7KK7cE9jqH0wP8lbAqDQWV5FQI6Xt7zxP+t+pf
 WMlm4gststozKdCA2wAaAEUmUmffav9nlar5yDIIjbL73eNLKg1fq2MvnpVfDaPC9ck76lIucz9
 QvploKRO9AKm5r6EL8vWJlaTLpfmDQsgEzIi8Bm72Px7DiBYuCZQTSpRH3yWYztVIz5CT0Gk8=
X-Google-Smtp-Source: AGHT+IF4Vw0VQfZGYl/x0KeII0dzR5+MlpJqu4csL7uKbwZewmpHtOmFONmk2WyMhvPhBHk6bYHQmQ==
X-Received: by 2002:a05:6000:2302:b0:42b:52c4:663a with SMTP id
 ffacd0b85a97d-42f89f0af94mr14494971f8f.11.1765310792628; 
 Tue, 09 Dec 2025 12:06:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff352sm34087145f8f.17.2025.12.09.12.06.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] Fix const qualifier build errors with recent glibc
Date: Tue,  9 Dec 2025 21:05:35 +0100
Message-ID: <20251209200537.84097-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Cédric Le Goater <clg@redhat.com>

A recent change in glibc 2.42.9000 [1] changes the return type of
strstr() and other string functions to be 'const char *' when the
input is a 'const char *'.

This breaks the build in various files with errors such as :

  error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
    208 |         char *pidstr = strstr(filename, "%");
        |                        ^~~~~~

Fix this by changing the type of the variables that store the result
of these functions to 'const char *'.

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251209174328.698774-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 backends/tpm/tpm_passthrough.c | 2 +-
 block/vmdk.c                   | 2 +-
 block/vvfat.c                  | 2 +-
 gdbstub/gdbstub.c              | 2 +-
 qga/commands-linux.c           | 7 ++++---
 ui/ui-hmp-cmds.c               | 2 +-
 util/log.c                     | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/backends/tpm/tpm_passthrough.c b/backends/tpm/tpm_passthrough.c
index b7c7074c2aa..a9f35ab7d60 100644
--- a/backends/tpm/tpm_passthrough.c
+++ b/backends/tpm/tpm_passthrough.c
@@ -211,7 +211,7 @@ static size_t tpm_passthrough_get_buffer_size(TPMBackend *tb)
 static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
 {
     int fd = -1;
-    char *dev;
+    const char *dev;
     char path[PATH_MAX];
 
     if (tpm_pt->options->cancel_path) {
diff --git a/block/vmdk.c b/block/vmdk.c
index 3b35b63cb59..89e89cd10e3 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1089,7 +1089,7 @@ vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
 static int vmdk_parse_description(const char *desc, const char *opt_name,
         char *buf, int buf_size)
 {
-    char *opt_pos, *opt_end;
+    const char *opt_pos, *opt_end;
     const char *end = desc + strlen(desc);
 
     opt_pos = strstr(desc, opt_name);
diff --git a/block/vvfat.c b/block/vvfat.c
index 814796d9185..e334b9febb1 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1826,7 +1826,7 @@ cluster_was_modified(BDRVVVFATState *s, uint32_t cluster_num)
 
 static const char* get_basename(const char* path)
 {
-    char* basename = strrchr(path, '/');
+    const char *basename = strrchr(path, '/');
     if (basename == NULL)
         return path;
     else
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index dd5fb5667cc..5b2fc06e58d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -362,7 +362,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
      * qXfer:features:read:ANNEX:OFFSET,LENGTH'
      *                     ^p    ^newp
      */
-    char *term = strchr(p, ':');
+    const char *term = strchr(p, ':');
     *newp = term + 1;
     len = term - p;
 
diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 4a09ddc760c..c639a60a941 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -403,7 +403,8 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
     int i, offset, nhosts = 0, pcilen;
     GuestPCIAddress *pciaddr = disk->pci_controller;
     bool has_ata = false, has_host = false, has_tgt = false;
-    char *p, *driver = NULL;
+    const char *p;
+    char *driver = NULL;
     bool ret = false;
 
     p = strstr(syspath, "/devices/pci");
@@ -543,7 +544,7 @@ static bool build_guest_fsinfo_for_nonpci_virtio(char const *syspath,
                                                  Error **errp)
 {
     unsigned int tgt[3];
-    char *p;
+    const char *p;
 
     if (!strstr(syspath, "/virtio") || !strstr(syspath, "/block")) {
         g_debug("Unsupported virtio device '%s'", syspath);
@@ -575,7 +576,7 @@ static bool build_guest_fsinfo_for_ccw_dev(char const *syspath,
                                            Error **errp)
 {
     unsigned int cssid, ssid, subchno, devno;
-    char *p;
+    const char *p;
 
     p = strstr(syspath, "/devices/css");
     if (!p || sscanf(p + 12, "%*x/%x.%x.%x/%*x.%*x.%x/",
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 980a8bbc518..6c93d452c9c 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -418,7 +418,7 @@ err_out:
 void sendkey_completion(ReadLineState *rs, int nb_args, const char *str)
 {
     int i;
-    char *sep;
+    const char *sep;
     size_t len;
 
     if (nb_args != 2) {
diff --git a/util/log.c b/util/log.c
index 41f78ce86b2..c44d66b5ce7 100644
--- a/util/log.c
+++ b/util/log.c
@@ -203,7 +203,7 @@ static ValidFilenameTemplateResult
 valid_filename_template(const char *filename, bool per_thread, Error **errp)
 {
     if (filename) {
-        char *pidstr = strstr(filename, "%");
+        const char *pidstr = strstr(filename, "%");
 
         if (pidstr) {
             /* We only accept one %d, no other format strings */
-- 
2.51.0


