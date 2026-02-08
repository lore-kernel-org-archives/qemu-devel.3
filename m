Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD370EF06E9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpARX-0000iN-Nh; Sun, 08 Feb 2026 14:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQq-0000c9-3G
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:27:01 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vpAQR-0008UW-RS
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 14:26:34 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-669287780f5so2381944eaf.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1770578789; x=1771183589;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0R9osrusvMqOtfeu461Tq5czaq6FMTAxple3ghg+3rU=;
 b=Uqx+s3LIJASjr0nzI7TVuughDri3MswY1wHX58e8Lsu6470jpgQuqG7nGv0JoaXmPP
 b6NOhiQ8pPtBamIfdqqaNVaThoaV5AcDDKyjnAykLOaMFdzder+yhN5FXlN0VZ0H7zIb
 3yayErP3K4P9tVRTeRBJaIuoUFeQRu7lNpTPU5zal4tL+yJs06R/MlL6J+9hDQmz9B54
 GarELvQsnaY5PSbsS2sOL9q3kgLskcDw9H7cjwvZXXZFIJCEsUF2NBvV9/ECwN906kxd
 W5liU1Nuve3oYUPjd3gzxJ+szgCiQGyIIEV60wL6b8b0HHBjhWoL1F30Li1YpxJDFWPy
 l5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770578789; x=1771183589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0R9osrusvMqOtfeu461Tq5czaq6FMTAxple3ghg+3rU=;
 b=Zc4WRNl5FKT8VT7uRaGncnmC/1Ibak2cVeWD/FehgJINbQY7f63jRs6Bl1yYmJ7NVt
 /DDlWBuBHQ6CbIWSLc5Cj3ywvozmIo4ziRuuD0WwWFuLu3jYTkXOf6d7KFngnLWBU/ON
 VSYVAceN4YvgkH3Qj7Di7tQGVJ6azTn7/TeEX09f3/DQ53dUI0MYJqykhI3/Fy52qDKX
 BhN2aF/KuUWcyJBoZSLA7fNXeLVQcxFEtW6jrJiVgymv/M91gsgOZ1phlarrYTjp5g0K
 cmQDDQtnVLAn+L0H/E0G4dh5anax6xQ3IT0PbvelFRr2dHYWzr5yjv5sF8MpgIskt/1a
 Vtog==
X-Gm-Message-State: AOJu0Yw0aEqFEKaDwy1TskS+8xdeOHoSiq98aGfIBeZZGyeXWRCexILv
 o/SvXamIltCeNkyrZiihdmoOzJ6JAYFoTfTdwmD+xznpgFy2jBCpyC9AdDMNlbCQdmw=
X-Gm-Gg: AZuq6aLdjuUlfX2KDmuZln530JmMTBMJFkVlLwl93aH9ULfCX8nM/Am2i9zvDjifLlG
 cNk2i7vIgoIrdep58OKuPBKTRNrv03u08i9xBkS8/LSp4FYmo7F7wAQlgUD0RN1DCYSGu2eiaNM
 qQIRWN3k5PPTdv8rQpcLdrfLUKsBSSIMocGIFoI/q82GoNZ341cLVA+lZowmfnf8U8xjNU3+2A9
 s017Czqeg0msjlQaeLXCdi8lbzKHsQtDVxKy1e9yb92Vc8NAxM5zkcThhZDsQcglJ481WDueTCo
 xQ5tPS7xHNp1BqO7jjNFE9H2qltcD6eobsnBbtRI5RBSPp6VrcHTLLD0ZAdEwteT+ljzmpD3Jk/
 T75E/fSgleMes1fsOeJ+Sn/83xAtE3WzTToivYnxy8tFY7rQaOzhH6QGrYAhoKAyvtw1oGp8vVw
 ==
X-Received: by 2002:a05:6820:2288:b0:66f:f316:b238 with SMTP id
 006d021491bc7-66ff316b660mr1037433eaf.18.1770578788832; 
 Sun, 08 Feb 2026 11:26:28 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66fdf303607sm1741301eaf.14.2026.02.08.11.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 11:26:28 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 08 Feb 2026 12:26:13 -0700
Subject: [PATCH v2 04/24] bsd-user: Add target_uuid structure for uuidgen
 syscall
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260208-bsd-user-claude-v2-4-58e5fcfdb84f@bsdimp.com>
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
In-Reply-To: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>, 
 Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=7q8w7XEaRecIKFdkMtineBuFnLZB0KTZoHDJ/HelWDA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpiONgte3NKSHu49kswJTCzRppt0iTDyzDJYUAv
 c7zGD07ULKJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaYjjYAAKCRBsHNEofbAR
 AAtJD/9kjIlVEBS2fY46wj41tbz3IyWzKCKBGIeM3dBasuGrgchxaM02mxLL/tOR1KfnjsvdQQ3
 EspzL24HWohYX96lwasOriqY2yG342L1KDVpVLU2aoZwHKiDOuSjM911aSg+wyHtpfRR2IrJXr3
 6KTYoUaXJAdN58/0bb++hPb90ng/miA/y68I0PYc9SGdknN+yXqKdZZq3a0PH/BR0ePuC26QRnx
 iYdrIiS2vlpIgRR47mHGBkexd2/Lti4B4mjj/dNld+gvU9jiLyWv4fsFIngPE3wUT9ceM/Bdifx
 wVAauBMSlZFagBzWvaUGUAqbUzOA6tlwyhaVT6K3Mgq7PAU6L5IWa3SJ9iGi4CSvEMllWRhHpoJ
 mUrhX4GZZvUWKfxboQyw3UrgcWyzapA3aJw1U+5NEu5G32JcZFORLIsT30JlzErFAyBZCZXCCwi
 oGCCvmt+AdI5SM4cY8x2KGQuxSE0rL8vuWVajcidFGzZgE6mDcwgZ7X1H6szphrpRXLM73Pk9oO
 d/xR2hTKPf3uvxZD0ctBWAWTTazcHWEL/mK1ZoyfqqlcG+JnqvxXkVuZiBwN89A8Cx+9qbmRRpJ
 Va2RIOR7+RKk9y1RHQaNn9nkKVY8M16+t8CNRha/MaqbUqGjykeeATl4GbMNgAOjFF+5A4z44kS
 9Ja0Xcb09Ul0R1w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2e.google.com
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

Add the target ABI definition for struct uuid, needed for uuidgen(2)
syscall emulation.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 92fec12acd..972bcc425e 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -503,6 +503,20 @@ struct target_procctl_reaper_kill {
     uint32_t rk_pad0[15];
 };
 
+/*
+ * sys/uuid.h
+ */
+#define TARGET_UUID_NODE_LEN    6
+
+struct target_uuid {
+    uint32_t    time_low;
+    uint16_t    time_mid;
+    uint16_t    time_hi_and_version;
+    uint8_t     clock_seq_hi_and_reserved;
+    uint8_t     clock_seq_low;
+    uint8_t     node[TARGET_UUID_NODE_LEN];
+};
+
 
 #define safe_syscall0(type, name) \
 type safe_##name(void) \

-- 
2.52.0


