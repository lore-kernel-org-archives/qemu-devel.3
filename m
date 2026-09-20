Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD4C982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zN-0006Ut-2f; Sun, 20 Sep 2026 01:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zJ-0006Td-Mx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:17 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zH-0002CY-QY
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:17 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6b9cb8883ecso1719819eaf.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881675; x=1790486475;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1zatXEJ5/HWhuX9eMKCpKoJSgdEmP3aYxWkf1E2+qLY=;
 b=bQG9vBSiLJms+UrjUUv0WsT7DaZuHX5xl9b6/S2YCKvJzLW7FudYzz7KLjV09iQNUn
 XL7UygCICmUk6rWWb754s7njHdb4JM9vfQ10inZ3Evg/FDxY4Lziyji8OUF735cwXmdS
 L89tednrs4hC7PzyichMJHNnNJdyMgkRapFFzLCI9cgVQPG4GCg0x+cTCpB/BUYczlLx
 BkGPKz8RhWcgAy7osXlJVc2TZtoK8GNw7UBFpOucThIRIjAKz2ziELOICIRO+G0XaFNK
 ZIqclEawSeclcd+8zy7S7BkkrqXfeTFxRCeu4BVBm8gEOFVVijs9bbSDAGhNi11HM5HU
 UHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881675; x=1790486475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1zatXEJ5/HWhuX9eMKCpKoJSgdEmP3aYxWkf1E2+qLY=;
 b=b5uFLWERFgehSXMJsXKFcSvhU/q0XQKsWozBEqCmup9YRlJf29YfBMdrWoxMj3MNdp
 TZBNgfsaiRbstIg35qvXZG4/b/l1IoIjqK2IFfPCySY/WvfZzxpEW2NVaBc2m+vzjCW0
 7WbzK3qj1bxpa8F0o3Vdf6VIfESB34zwuQ1EX80GeFTaSslV7z/X5/e5O1Ueh2BgCkMU
 sy7fwPMkiq9lwRSjzF0kLQ+q05IhcvxwHLegHcNY62OSE+BEIf0P2Z/UfrtuFMV56iGv
 C5tZ5TJvBLyApqYnJ9/JWDUUJjBuyufCWfHQ1QL86zqm1mbcgcPYC9YChGYKms2Yb+P+
 i+xA==
X-Gm-Message-State: AFuF++mpiuVdHlENeP69uEoGweVOSIq6wHCeRD30wtuJbgKb7U8l2Egx
 dW3DdYS+uHFObJsgmyr68rrxDk6w/V6culo7qPYqg++0ugZJGgUV2fsgZxisH1iPQ4k=
X-Gm-Gg: AYBFou2SCHkfiptXK10q6LBgm0YLDHHhOwocNjd7v5XZg1XjSeQ//sSlEd/+QDNPbFJ
 6TxTJ4mp3VnNiCf7owRMMFNelBDIxh5qImsjD3kK0vjB15zqZ8Y+DU/pv+6AFeO9977VdpQvPA4
 EVLYsvYMIKmc8gtbC+9aAg/QJ4bWt9wqr8SdxfQCGoEuo2xUg/kRdru/TAxZPjI0gZ8k0JMj62F
 gSBqWC5bkXSuyj1O4YT+aqoFhecLjmphzmbhLKoGnBDc/AyczK+/4beIOJ7WYqQUN2THKVmM0bB
 lwEX78bmeLcr78ANx/SlekOZmHpWU2xkF7qo9BKDaSJgdNU0ajFsYAngEYMR6eRHipTxJpKCerY
 vJupaKfU8+66ejM5ga1WYQis1R3NawCk9RwxAef7VIjVfxuFij8cPo7L14OdRWhFdnTbAjC3LXJ
 Jek3cweRxIAizHmWiMrfiPGMmMJ3fm0WXurOpGCoX3JxBAh4XT8I/Mq1J6KQ==
X-Received: by 2002:a05:6820:c93:b0:6c7:6c8c:148e with SMTP id
 006d021491bc7-6c8fe7cd3f0mr8371198eaf.30.1789881674696; 
 Sat, 19 Sep 2026 22:21:14 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:47 -0600
Subject: [PATCH 11/14] bsd-user: Eliminate unused regs arg in load_elf_binary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-11-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=UVa2n9fM8fauFTHkE+KHPPWyhZsZOgXJnAV0xmE+tmk=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20xc9ugOpmuWVIn47U1EdQVvMSUkJm1NEsyp
 Z69u0WRbvOJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCveRAAvZ5okQazw4dguYXSSGwsmkJQgwKW6mE
 CxaYJvI4I/Gk43OBvdkkxQitMWszEjQW3kMec3NgbVQz1G8JHRCJJGzaQ7O09UMdSKKuVUDO5uo
 QweHPw43hvIQ19qqx0Zj5ka4WQaF3tw55+GOJiWoucUPbnqkUDTuSHihC5BLaxm0LmvzgvOsD+l
 Wx8CqSe6Tlgo1OPSCmiO43ffQNoXzOfu4lxIxC2CFjo+ZV3iIsBMVPxUOToN4mwAyEK1Tv5uWL4
 GTIyQXfvrnIJwLzja2V/Kbp8zhfLk9Fo1gKaVkYwTFwVY59lfGFEWcXyuVKg7QXwiyU9icWG/PP
 Sfxdf1NkwY0TBJTIr/a5a2hAB9un940zBQ7HDXqgpvRCr/h65/BqMPnfLtEPy0jcN3o7L7cRhE7
 kFYC3zNHaTiUfL0tqWrcmBMjAtcHXmCKMefOvjwFpyd8donZLHZAZQbjkjbacivfC/R6tJibKXa
 r5d2osNUVZYr/dgPbjqEaE/yiNFm3qXUv8d/zq9i26rKcPn776e1f9/tzemNVtbTXVbJO9JbhA8
 YokbhjN/VakJi7tngWQT7sL4TXlXozMJAnTxHHjF6NcJB9jZ1Cfa/SGkhrPGuNZgX84hFv8eDk7
 VWNQrNavDsPq+xqUAo/231OmY8CDMdHKPsuXABq6uDUvym7OgbqI=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2b.google.com
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


