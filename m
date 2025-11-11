Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407DACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIldI-0000lV-Ms; Tue, 11 Nov 2025 05:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcR-0007q5-K7
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:29:00 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcI-0000JU-Vx
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:28:59 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b3e9d633b78so127773366b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856929; x=1763461729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPA9BBHhs/TsW5+dpgEf0Zc+XHikxM0HQ0hFOJxJLVk=;
 b=SKPIw+nqkZP+WJxcRgmWuRjKt+aRWOj6wYU5bBHgONPy67lLx3MyT9wTPkWyDjxTBA
 8cZnagHz/31Wv1fUlEWvXsu3bV+7F2Y00u+EwAZG3lg/ww5c8iTY7pws1oMyLGALgbmB
 cwaoyJ0I63AA8egoJkH4bZEUSIgeuE3LCy7qG+CnusZO6PtISMYIT05DEKkHdbk30USd
 ZdmbRNXLPq1AQqf9m4FL9CtfoyBdyBFs1oRXrzb/ktGdPmnOTOlFC5tTDqoYpknqVxC1
 quh1N8s5dIlEatnTI6EulEuqwIuNXL0V64mygkF7+Kp6vZgOJRb6et/ktYKNaEyOcClv
 67TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856929; x=1763461729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VPA9BBHhs/TsW5+dpgEf0Zc+XHikxM0HQ0hFOJxJLVk=;
 b=Dl5K9FszcapINObZdom/JSknKS33/ia59w5ASa5rQ3grq6MbWSecRf1wwebYd5DX24
 ipsGLXYFv/AUbFUy2ryCnyC4GaPF704UON9pQtsNK+Ifk6AJmWL4mQl0Cd6TyZcI5PtD
 LIggAvDqAcA4+nzNJPd1WML1+2KR0Aazv7xRoGM/wbpnXO9Fc9HQVOVyhSdV7rm4lM18
 YKRjvefTKcMskriCx8+hx+zzNYm/AP+Z13GtrP+ynOvs6KtgCInF5/xTtf7Syp0PFfxM
 977n774C5brKr90Oru7biEEJmFEabrlQKyjocxCC/+J1hO1Q8rbFe2OiiqoXFrkN/77v
 xzFA==
X-Gm-Message-State: AOJu0YwzyWbG+aLEm+SDnnjIY98u80YzcozhEFQjJ3yvuxuJtf3f9eeU
 816W5O5vE9wrnRT4VTzryCS43TnloVvcNfcWOaC1op0uvA7jVILG68V4weByXlLV
X-Gm-Gg: ASbGncuLHHGfyd3oG5c66xGmDtY4NxsOh0SKUe8nLWOuICkMEP91nz3aVPf2Pfxy1Lw
 YBB1933CerRwhqYih0/11zDpuMcauTNPZ4mqR5MaY/84jye5/pEKgjBKdaUfj6ysTm5RnA1199i
 s0uMBKev35ILuM6U4wgRJnumYQnOtZmza3X+07wg8Wo5bI8HXtY8ekyOZPH0hQNjnIVEeASjYip
 vdee/uhGDrf8oUZUdoBbjz6TPapfTkJKBblCgVbvtV0FPERSHNWUAqPSV+1sgCrIO2FAuZNIeDn
 9hHbnXtARpFW6NCiFSHuv4veC+SSEWHU1pozrZrJtMxK4XG1o5aW9DWOXnkTnj+Iik8+NXpCP+8
 kzeYaJh/hgL2Zl8Z71fODgeK6nPUVOXU4x8ymt/+3o/uVx74E7nTrT/mV07ovOlW8MN16X3MIHS
 L63qhtwKjN9ebmyMTFsthMAS7g3iifZOOuQD2zaCwihWw=
X-Google-Smtp-Source: AGHT+IGCRduyFuXU75h7mCMK+Zkr20TKPpGS5xq1c+FKZ6EProEttvhzCdsoQGo/l27ublulbNDyOQ==
X-Received: by 2002:a17:907:9625:b0:b72:8e31:4327 with SMTP id
 a640c23a62f3a-b731d35c2f2mr277776766b.25.1762856928768; 
 Tue, 11 Nov 2025 02:28:48 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:48 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v4 12/15] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Tue, 11 Nov 2025 11:28:33 +0100
Message-ID: <20251111102836.212535-13-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b84c6afb32..4c9d79ec44 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.47.3


