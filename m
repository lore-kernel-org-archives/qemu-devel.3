Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48616E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 11:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tObSg-0000Vb-Mk; Fri, 20 Dec 2024 06:46:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tObSV-0000Uf-51
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:46:19 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tObSO-00029L-F4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 06:46:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21631789fcdso19594235ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 03:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1734695169; x=1735299969;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YPoiLD8gKBehzlKwj6kAkLuVYOeeDhdIj7RO75oG5x8=;
 b=qaV1OdMPl5dv4e8+YUKEgDnRO5+iBN6ufloIXHPuzlF5IkrsQXazFqfmFOGznzFO4g
 BstTtMc55DADzwiHjQOkiRWYQjfLToLE0uijLVqTRWSmGWsNamorwm4MEzZrALpDoi9g
 zaXjqL7CiV1xfq8GRQWMFwEQS5a/8BWPOV4gVDKpLpSU4HAXJqRbRAFvj6xH4urC0RZo
 07Dw0UWVNvapJz9E35KrTTOR7KfNaon1N3WX05+r6+o86Bd3h7z1h3mzgzsStbTyenOv
 uo5jVEpSZqSXyteU4ZZq4hwgZHDkr2XL6yzIwbS1mcNqj09o0gYrEzMs1gKWD9aSeezo
 7+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734695169; x=1735299969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPoiLD8gKBehzlKwj6kAkLuVYOeeDhdIj7RO75oG5x8=;
 b=lpnbEEuOdk4NX5ja4t2SPHNwKaUSHK91+m40fAKnubtjPOewTYbbdmGgkWC9HhddzE
 br+6+UAHju3NnXc3HwEh72jTvn/IdjPhOiIslp+T5CDhdSRgdGZErSf5cWRFCDs1UxZv
 o6eCRHjmkKHr3bk623SdV++j7m+gIyOMwk9r1naVs1Ft7oD722Vm4upLtdCoNI7HyIES
 iWdheypJd/cfNQTbQY/HZNsd0enEHualV0tpud+CVrfpXXUkBL3RFWZY+wqtxHVHCIGj
 LDqSBgNSMtJeOPJ8XqvVSgBHL5/CIQmRPVbIzR5wk08uASdzhlzBRc9ye6Skj91D1/R+
 ukwQ==
X-Gm-Message-State: AOJu0YykAM+uqdKfWKPgo6rOCIBJz9iPScM/qYhPk4crcDskzokaiFOE
 WVTjAZSnN/H3QTOj3ZkvBP4osZFhiYsfVFgTxptpOHYBH3DXEZPcd2US+yjoBcpwhVXeNC6ujvF
 Hev0=
X-Gm-Gg: ASbGncs88YNZKuX+QvnHHeOjNHlQJwoEjGZicC7BUeyXHjmGh+Kwex+TvrYhskwVK+1
 J7AXLxYgPQk+SBds1YLL1nXO+wS8s3OCBpvvqvoQSKcToBpyOy+cfLS1P3oQ+jQJuD6TgVsAfMt
 CC06zwLZMNOM53AxXMytle498zT/U+Uougxm3S4KhEuz0oFuu2qRexRonrXcOs/S/DxxBuiSGeG
 uZuQ9hUKMweWQU4VazlyzbdUkvp+yq5zQyvKlY2N1DeLpfj5kRKL+YeN3Qqwza9RH9P/ec=
X-Google-Smtp-Source: AGHT+IEmPAogRnmrkJKWHQ4GUNw1qoNhMd3rCOUhVH+jRsf7UEBAKQFw5ZwtEP29+WWG0A0rFS8J1g==
X-Received: by 2002:a17:903:2cc:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-219e6d5997dmr38435465ad.20.1734695168702; 
 Fri, 20 Dec 2024 03:46:08 -0800 (PST)
Received: from localhost.localdomain ([125.71.92.133])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9cde7esm27162215ad.152.2024.12.20.03.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 03:46:08 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, yong.huang@smartx.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] qxl: Do not use C99 // comments
Date: Fri, 20 Dec 2024 19:45:59 +0800
Message-Id: <155c8974fd72403b9b32d3e2827850b7f08937f3.1734695085.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Do not use C99 // comments to fix the checkpatch.pl error

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 949949d374..ae2d983299 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -50,7 +50,7 @@
 #undef ALIGN
 #define ALIGN(a, b) (((a) + ((b) - 1)) & ~((b) - 1))
 
-#define PIXEL_SIZE 0.2936875 //1280x1024 is 14.8" x 11.9" 
+#define PIXEL_SIZE 0.2936875 /* 1280x1024 is 14.8" x 11.9" */
 
 #define QXL_MODE(_x, _y, _b, _o)                  \
     {   .x_res = _x,                              \
-- 
2.39.1


