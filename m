Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134C0E6ADCA
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 22:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEcVa-0005l3-Q5; Fri, 22 Nov 2024 17:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVY-0005jk-QC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:12 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEcVX-0003jk-3p
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 17:52:12 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-724e14b90cfso866748b3a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 14:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732315930; x=1732920730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rsX5kj893cpBfdd4jZXYOKhLAvMEb0p0E578a2RbpHA=;
 b=WGUKvQUPrriEC4aPw7KpHUR6txHie67m7Sw8mQBgl10tqKSMpkuyNaAkjA42HFsUR7
 k/rX8jg1UNLWn7y2Xy5rnLegkVB1OXI9JN81vtXrKyqSTMaF6iWj2OTDAiwBonMFeOua
 sGHurPan6UFujurRvj0UHeCQPV4bQsOF2wgptf6s7/AkMZMNv2rJxrdbaUgf7ACcKkV/
 KctCo45afqzG/o2i7XNt+6muVI066cTriYOut5kNpFDr7DnSpJHJPeGQNAgpDcwi2xjV
 yVAj/wtZmZWWUXfFgBgNIdwVbrIOj6PEK4wjhxFUdsqL+O8sg9uP7sz46Esv/OGHjmON
 6jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732315930; x=1732920730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rsX5kj893cpBfdd4jZXYOKhLAvMEb0p0E578a2RbpHA=;
 b=YXghHTZv8+IbsCIFJmjsZt8UeWSiSlrCQsACf1SBvQOV7JuUgY6WdZuMXsVYCLyowl
 NpuSD3PKUpGareaT15gxK0yO15rhZTl8fCstDujVUL9uAf2Use1AFyZpl0o1iV1t0ix7
 2Utrr8sPxZ8IxnGf0hHVsGQUwhX0MpSU72lcGPW61+jKZWs/DqqUMbJKjSf5pR0SUaFW
 auMmKnc6lKh6SjysTxSTo+rVJq2pgM3+kigIB8KG0aMmG744o3rKpz2PTuk4iawDeCPO
 Z+sU39U4VzshE9jbQwMTpWm5b4+IJFzNGgsoClI91qq6o+IODF88QUOYb3UUtz/x34D8
 TZZQ==
X-Gm-Message-State: AOJu0YzU/TKWgOMNFsX8SZqH9n7k3pR45gN0q1DtTJkAOvg1a85nmOhC
 KZByDvlrDwRA6IFpxPdguk2yBqIVsnylkl5HyKC+iZSiYgn3n+7DZjaZJFrg1Ne/kq40+QpR6xS
 R
X-Gm-Gg: ASbGnct47Isi3fkS9sYuxtGIzILx0WHSy4yj04vsQnO2Gi5lemC0imqIvgvwph0vnJ8
 zi682ED2TCu883xis2WAMR1jKoNHKSyW6ynBbeaktUJvGmweCsJrBajEsl4/qbFYUBg7eguMxhM
 pWN73wNee6c8DGQQoOoRlO6l9/u0J0xGl6jipYHf6v+M1V72ug2ew0oLMGqwWK/p/+XrzQfjPUR
 bwbiJOhJIUfiFR0b7Dh594OWIeLZvMjo7OWH95TnV/USKtuJIU7ReR7FwvmAN26xmhq8BKTfxVc
 IWwJ9t2dRjoo7Q==
X-Google-Smtp-Source: AGHT+IG/tmVLKYc9cq6ROZfv5TFa26YTZp7M3WOFjIEMBi9PTwoXnkjQMYEHBfuP1N3sLCldzJwfsQ==
X-Received: by 2002:a17:902:ecc9:b0:20b:38fe:60d7 with SMTP id
 d9443c01a7336-2129fd0f6b8mr69302235ad.22.1732315929808; 
 Fri, 22 Nov 2024 14:52:09 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1539fsm21450335ad.192.2024.11.22.14.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 14:52:09 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 06/12] docs/system/arm/: add FEAT_DoubleLock
Date: Fri, 22 Nov 2024 14:50:43 -0800
Message-Id: <20241122225049.1617774-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 47f5123a31d..38534dcdd32 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -37,6 +37,7 @@ the following architecture extensions:
 - FEAT_CSV3 (Cache speculation variant 3)
 - FEAT_DGH (Data gathering hint)
 - FEAT_DIT (Data Independent Timing instructions)
+- FEAT_DoubleLock (Double Lock)
 - FEAT_DPB (DC CVAP instruction)
 - FEAT_DPB2 (DC CVADP instruction)
 - FEAT_Debugv8p1 (Debug with VHE)
-- 
2.39.5


