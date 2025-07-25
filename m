Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D219C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 23:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufRXA-0002qA-0a; Fri, 25 Jul 2025 19:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRX8-0002oe-8f
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:08:58 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufRX6-0001oS-Kg
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 19:08:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-23f8df98e41so23106025ad.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753484935; x=1754089735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rJjiNpYq8k65ULjdI+KSiLvLZ8E6sNk39U16k7ksgyI=;
 b=yzoFoXS4nmpOL1Zlus7gsXJXKxeMO6dI8e5xnFmBDXw1iIA2ebOeRlt7nMGM81t9dK
 sWOJz17UXWmA/vnbirmi0GkhtEK2O85yBSyFx1Tgd0Htqf5kxcy+Uy3Q5f/ZsMLTSrYF
 XtdCLBXz2GrTMO/b+pXXtiEMpAhB+8a3a1yxi6Y2UtptZ0nRxeEkwEUuJ3qpB0iHusbB
 pURI/H7BbL1Hok+dZulzVxSlOabeCHIgGF36J2fTMs2c7SBfXPEGB6exbBmD7NCANTFw
 GrmEcMNlII/RWC/k3NeeVYZDo/L8KrSxqmqwXcunTgQnJKS66V5WaYeWPbkV73jbtZKY
 paMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753484935; x=1754089735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJjiNpYq8k65ULjdI+KSiLvLZ8E6sNk39U16k7ksgyI=;
 b=sUma4EUyQhzAkoL9bl+HqL39YlWm2Brc7wfmol76f/k8qmFoEvH9TmH6nhxyxwhg53
 oBCj0qfVLdY31xhOjChXtAbiVeMx3rcdu4g/QseuufB+rquE8a0r4RfiwZvFk3zMQ9Yw
 AothGjNReRlHHQelCQr5GQUv9qJ33KTw5vIFicMdQiHICR0lIswLJE9id9zVIbvlqBg6
 vDenpDQIJo0Jx/GIHb3iSCp4WcNiwCUKlNei/bsCU6r7m4UMx11f3KOrhIj5NNoQZtrm
 hqiKT3cpBrF8F2G+hIKRLA4j22di1UQ9i9Los3Dv2xsT+nXNRSpIpPq5E8LSol7FGoou
 MeUg==
X-Gm-Message-State: AOJu0Yzm5PrlhbOrMH+/ir0oUYHgr7ZTA3WXTRyVNl8FIcs7hj+jg55z
 EK8OaqKm1qqnQoXT7N39pXLMLKHjPzP/f6aUQxNpa/wKC8S6aRoThY4WUBpL+9817aiYa+v06VC
 ZyiIC
X-Gm-Gg: ASbGnctBGE7kezqjjHoJDlhGv64KQQyyAuzgr8qAyXGh/v3krNojG6bJkS62dmeqxkY
 VD4ERMXdABh0ojypnboh/mCiHwuUpUkdCxbdC7S3g7uLTtfSjNlwXo+quH1gYDRSF+VQDFD2Wgh
 jPXnDBUJl06vX2/zQ0M31+Jcu1Q0bBgHj+DJrVFG2O7e0B02m+UPSzKbjfH7wWgQCNxZUoTiLsO
 L4ohM0vohM1Y+yxb4yVA8Mda8mPhN5xoBMnfzACjpRr+htyLZCT4kZN37CYYG+ALSYG/hURg29s
 zJInXWDxTUbjeAFcf1aTOLm0cAg+INLY472OE/LKrPO2tWM1w6Db4U0+N0BUT18XUKfzHtRPZX4
 1mNgtMSrS6DaEK6JUvhEP75JXyb79sGy8ylVc6xEzUyoMozRRFYbVUdJdINP15cgyfXrkWQ3Vk3
 rBdTlVBPi2kw==
X-Google-Smtp-Source: AGHT+IHUEBrbl3psdfb+myW3R4/QoFWBrmQbFt1jEQMS9VoeCCfzNhtZqJajGeAkWnotcQSdAfrf+Q==
X-Received: by 2002:a17:903:1b05:b0:234:b743:c7a4 with SMTP id
 d9443c01a7336-23fb30e42a3mr62942525ad.38.1753484934859; 
 Fri, 25 Jul 2025 16:08:54 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe545368sm5033375ad.172.2025.07.25.16.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 16:08:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-10.2 v2 0/3] linux-user/aarch64: Syndrome fixes and
 enhancements
Date: Fri, 25 Jul 2025 13:08:46 -1000
Message-ID: <20250725230849.13026-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Based-on: 20250725175510.3864231-1-peter.maydell@linaro.org
("[PATCH v2 for-10.1 0/3] linux-user/aarch64: Fix SME/SME2 signal frame handling")

Changes for v2:
  - Split out syndrome handling from cpu_loop (pbo)
  - Enumerate all exception codes and document them.
    Include code for several cases missed by v1.

The FIXME in patch 2 suggests the whole patch set wait for 10.2.


r~


Richard Henderson (3):
  linux-user/aarch64: Split out signal_for_exception
  linux-user/aarch64: Check syndrome for EXCP_UDEF
  linux-user/aarch64: Generate ESR signal records

 linux-user/aarch64/cpu_loop.c | 153 +++++++++++++++++++++++++---------
 linux-user/aarch64/signal.c   |  34 +++++++-
 2 files changed, 148 insertions(+), 39 deletions(-)

-- 
2.43.0


