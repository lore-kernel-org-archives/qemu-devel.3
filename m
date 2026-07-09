Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7FCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjgj-0007id-CH; Thu, 09 Jul 2026 04:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjgg-0007iM-5L
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whjge-00089E-M4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:00:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so11744905e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783584046; x=1784188846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KOdS9++3RCBJ5n/5baGA7jC2ZmuejliLWV7+473Em5A=;
 b=AfpkpC6n13JBTynUpC3slF9kG6FNuu6dq4Qie4BzQk4pCyKXRos1+zEaeHSqg15IAz
 KsXE9pJeFVTiE52UEIhID2rstHPyiic+WKUA6En3jXR0pGBPkTPKTP1i4IGJTdo5Pk5b
 sl1TW3KlKBLiayaTbsoV2U1aksxPI3w1c9FoqPP/5d1I4iZw2tDaNCi1h6j0ZwioT2JS
 tOVVlMMTJh4LfmzxYI8cLwfEIc2GuyuYKjqrz41cTFKB2bQ79OBR7DW4MAGI04Tt54z0
 MhJPxfyEAN9xzDv6h/h2bpb990ZNsRVvdat21HVnmf3D+1ECwSksQIhsQd26HlrspKQB
 qoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783584046; x=1784188846;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KOdS9++3RCBJ5n/5baGA7jC2ZmuejliLWV7+473Em5A=;
 b=kN2mB8M8eVlsT++5ja4wVKpcUHV1zhHNJOr8nXnRmbE6eKpFTZ/YxBBAeg6ay8hK88
 jpGx9beS0KOwShKyDrUv/+6/bNEqzZq0K9cG/HO/HzqrnuCsmS7F4ihsswRlurn2Uzfk
 ztkqCOesOfJP6mOFwZQZURhxrIXW3Yn/035yeI6nWJ9f5CVDu03sr4n9edjPXoYgUgKV
 CdHYEhLD1eofI+WlXklvX5vlVNca7A53EOE+42FM2sVZeDNrPkdpyqLknnuCIgXQf+PU
 VDbWkYZnlsC9vRzene1ju1C4gzrRFjQzgwBfebh+TJK+WGe7o87Q7uUquUSX/4L4ULTw
 KDnA==
X-Gm-Message-State: AOJu0YyaeQGd32z5dHpPbgqDAomKzL/YhRiSwOdeBvpP2dr7at673JCJ
 oGBO/JR2+pUuDCZuoU2IjNjICs5yoPnmLt1QiQx6kctqt9PCJkRc2POX0DWPmOAtGlw=
X-Gm-Gg: AfdE7ckHGcHPM6ak7vktOGWL7KEJ5xgPV7GY4XUK05HkhJsqzfBI4O225reP/kl1MiN
 sZ7VqY0AKtTUvWGilztksgxrBOekbeRHk+44cDJPbbdZtabqVTvKH68LfsfFldbDoycE1mzC4hJ
 1q7tO2AEFggmbDIzasNM32tP06sHN0yndBMXVJ1sPoqlCcPoC4M3JRkYO9ih7QLjbwddp4DhPw8
 KKQLTRQC+gMBPwEy5blp8j7OW3wYaT/acuwMS0Fo/amkfsTDokfh2au/nNkTSDwpoIPkw++nuNc
 YS24uHZeaHvljzhgTU1GIMQZ/JqUPjnEhTKPGO55lwapGGaLdCvQwLGuTRZUkDDmAi216CIRbmr
 ssgr2SvcVT7YsOdUyNzBX1As2qbhy6qJxwvfxhc/taQsKyftsq0X+YpCq8W4PvfGHZZiS5Z6u2F
 8nkX0e7o7U+Hii
X-Received: by 2002:a05:600c:6206:b0:493:a573:179b with SMTP id
 5b1f17b1804b1-493e68d145dmr59202385e9.30.1783584046021; 
 Thu, 09 Jul 2026 01:00:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa09608d4sm50545463f8f.25.2026.07.09.01.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 01:00:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A56A6007A;
 Thu, 09 Jul 2026 09:00:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 5/9] contrib/gitdm: add Nicholas to the IBM group map
Date: Thu,  9 Jul 2026 09:00:35 +0100
Message-ID: <20260709080040.4157324-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709080040.4157324-1-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Let me know if this should be under "individual contributor".

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
---
 contrib/gitdm/group-map-ibm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/group-map-ibm b/contrib/gitdm/group-map-ibm
index 39c53a42ca1..22b2f8778f9 100644
--- a/contrib/gitdm/group-map-ibm
+++ b/contrib/gitdm/group-map-ibm
@@ -5,3 +5,4 @@
 jcfaracco@gmail.com
 tommusta@gmail.com
 idan.horowitz@gmail.com
+npiggin@gmail.com
-- 
2.47.3


