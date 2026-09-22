Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5B7C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x964K-0000sQ-0y; Tue, 22 Sep 2026 15:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963g-0000YX-QI
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:41 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963e-0002Oy-FL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a2c0356so179166b6e.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104897; x=1790709697;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/gahCdwhNyoj1EzcQ2l7HrXiy+uDLWpRnTZHx44GnwI=;
 b=N7YOLcUBg/Xvu/cJXrmEDbBJ9ptubb50V1yPzSTDSF4QZiKXFwC3gPejJqIeQT6wBt
 1Je6MRGbmU1ljw8fHvS1UtwYSEWjco7oxBd7E1VyuyFOmirBO7aJJ52uxqC7gAcABKzW
 P0U0zv5JnFwTP2v8OILykeodiCk/Ka4Y6I3ARie/jkXzg+lDrJrGZI3ZkRgry2cNCKn/
 QIVq8ePPnnzSTfKKBpqya6Bu/psp8pce/7LUqzt4PwakBF7bR494DUqibEMycqZUuy00
 1icMyXZKQgFWGvo8vTcZg+13THxUc90dOZnXIQO6DygvUW+GVZeC7R79L3vv8QQAbAtH
 p74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104897; x=1790709697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/gahCdwhNyoj1EzcQ2l7HrXiy+uDLWpRnTZHx44GnwI=;
 b=GwZJhighXb65umnutlsId5Xl2i5QeTtA8k6INLp5yWT+EKzdym6OK++QKuV6X9SPSK
 Lj+eh/LBjDi8PM+64TqwtciKVEcm7wSSspKaPEsfTAuOjotqLgrqp5yZW8EXkoy4gb/m
 cFZYLsyT5Mc0Qn9Y5x6s+s+vmtzZHdv1PEdMpmOtuqQ+tv7pPR5qxHH6R5nzAeMjbqE5
 IcTa84UseYchYesO+uNJYe31BkPnP7Gm9Dss8rGatkQOCCeLVJ3w7i43uv2A/AycJlih
 SzqAQSSUYWMa2miKEeb0q32UvjYc7GmKfp7tJnJwQhGcCC7rt0bFnLqNeQoM0gdCRt/S
 vyJQ==
X-Gm-Message-State: AFuF++li5pEN+77Nu3/cAAPs66orUl9TZF+zVQOoCaY8aaKOgmNEVqTq
 dCXhWBCQRgMQXLwcZwV2G8l0bnnBogjSkERNkHhdKKcifNSP1tKfSggt+zbLYrmqeudWWNaafQH
 GfQ1M4z8=
X-Gm-Gg: AYBFou1V7GbmOvlUOFuUELw7jvfAtvmQagqYxxjq5dvgjk1/oj8wM8jiNNlroTJawup
 t2lExA98eJJ1lSNddKU8T2XcPwC98ZH7p/ghXGjavcQa8RwElFnk9JadEI4cQAE6sEAu3mCfRy5
 YSsuJUzCKupL2s1MjoHeufuGb2+L/aHHmeRdALMAXGZD8dzR4q0KVlZ/Gm5gT5JUpHnKX+gtH6w
 Ywen21Unn0bNTE7Xjk4NfIFJdAHix2pLF6rGKZ4fPBNhpZHgNiMGujbwouxcNHXkAAbp/Hnp5gP
 eITwl16DYFRmd/0UxzNoRB8+Q590jIpV8USwOUqI18rvkN36smFE1L5PR/sz3aSrtfgRljXDb5c
 WGCWISiLEaQwMfTk/mG7/YxAD/UHhAMibqm8UiwNN7wmXsgFD50eRdcarvPCjx/Ti+93Oif/02g
 0JOOf4iPM7v5JVsccYweQAUMYyGUmv/HZQiZZ2/d6hVGH9y5cBxO/cJgi/HA==
X-Received: by 2002:a05:6820:290b:b0:6d2:8d32:be45 with SMTP id
 006d021491bc7-6d2cff42f47mr403781eaf.19.1790104897333; 
 Tue, 22 Sep 2026 12:21:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/11] bsd-user: Eliminate unused regs arg in load_elf_binary
Date: Tue, 22 Sep 2026 13:21:07 -0600
Message-ID: <20260922192109.98467-10-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsdload.c | 2 +-
 bsd-user/elfload.c | 3 +--
 bsd-user/qemu.h    | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/bsd-user/bsdload.c b/bsd-user/bsdload.c
index 5b3c061a45..dcf3ca14fc 100644
--- a/bsd-user/bsdload.c
+++ b/bsd-user/bsdload.c
@@ -193,7 +193,7 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 && bprm->buf[1] == 'E'
                 && bprm->buf[2] == 'L'
                 && bprm->buf[3] == 'F') {
-            retval = load_elf_binary(bprm, regs, infop);
+            retval = load_elf_binary(bprm, infop);
         } else {
             fprintf(stderr, "Unknown binary format\n");
             return -1;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index a87a892eb8..295dad4643 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -598,8 +598,7 @@ load_elf_sections(const struct elfhdr *hdr, struct elf_phdr *phdr, int fd,
     return 0;
 }
 
-int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info)
+int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info)
 {
     struct elfhdr elf_ex;
     struct elfhdr interp_elf_ex;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 851b0c2c5f..5baaa333ed 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -167,8 +167,7 @@ int loader_exec(const char *filename, char **argv, char **envp,
                 struct target_pt_regs *regs, struct image_info *infop,
                 struct bsd_binprm *bprm);
 
-int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
-                    struct image_info *info);
+int load_elf_binary(struct bsd_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
                     struct image_info *info);
 int is_target_elf_binary(int fd);
-- 
2.55.0


