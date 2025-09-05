Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188FBCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 11:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuUzK-0001fH-9l; Fri, 05 Sep 2025 07:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUz1-0001cA-7I
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuUyo-0003Yu-Rv
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 07:51:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b7722ea37so10957885e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 04:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757073095; x=1757677895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMEJQTJL/edhgJnuQuFiZysU4+KbfpRG/smBkAD+K1E=;
 b=la7oGrDzLHb5tsc4w+rqxR1isWUSmtxaafMlNHQBIsmHOAPZj9/GI4acBiFEFjC1tF
 9Gpb42+ULFsJTnuY2xVAuEsEjgmuuG4Atp1lmz8jcVUdRFx5h0V30/TlT+5ANYfZjklQ
 eJRROh35xSivNj6eHjEejD338/evZJBqjXSZEikYx8QndQZyKle+eRo7f0+CMGMccCjX
 tIneU3KqAmBWrww4xW2o4AYKaoq+Co04pKNwqtIAjPaE3KTvBYXnrvCQlTRz7fxIpfZE
 90eteDC9blniCM4xAqrFWPI6F0KdXZ2mICc3LF2sLedmoCz5FEFt2Ih2FS+j1gc7JYRD
 mlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757073095; x=1757677895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMEJQTJL/edhgJnuQuFiZysU4+KbfpRG/smBkAD+K1E=;
 b=iKoTMod7ao0VelesKUZ/pJr5Z2awKFskRt2lxM3gmeB2y//m7X/2YogIZR/TutyINi
 ikNAS9Gm9LCZZ1KVcicTU9iNeJ+S+F3czZZw640vdzbLUV+rtC+MBtMehNuTSMI8t3WQ
 hvi7O5gNtj5UmXFbJVdmQ4eM+Bb9MBE/dsOD3moEO4e31XixzUe0fBlNppwh3nbp2W57
 e5dT450qtHMnceSL96CiL8IN6dYzJxULEvMTT6JKaYWLMVmKv8MNQgxfjbN6MVodzoqs
 97Q3RYksP/tO7g1QaTAaP1aM59sZr8UPp7eXNrTq2ZkpzK4bVIHeNM7UsssPWnMSazyk
 yO2g==
X-Gm-Message-State: AOJu0YxmJlBdE4yvS1AhtXvdEAaxQDGu3bTaEwEqKRPji72nIPLOkvXp
 vO4UkS+mNXIwSZLiraIDLPyWkOd0/M+7DNJ4YR7Y+4boEfAVOwy4hkh19209F7TI57Eo4SFKF7l
 IkysbTZM=
X-Gm-Gg: ASbGncv0n5VCvPh+BJjHqV/d2gKVC2KscaJx+n3SLXN2loO9YdA7WAG9SBBnUlN7RMq
 YrCJmhXZx/UR1kLvPbKKRPR0LKkImLj6Y2m/6q/8kC6+3T8L1md54ytjNM/Tk1qi9U1+jq64s93
 FiTUSXrwJVYcLHYRImDwD27ZJiVusEzJF0wIRCZCI3hRSTQestvGOQYjttu7QZI3EuWjsxSoVya
 G6iYyTO7OwXzaxsw5KNXo81zw1rF4Sf+qaY4inlaIHhjK09qxFdTjMtv5z1iRixCID1JoI4g+B2
 kbwuk7Foegze/mlS+Q5iT2GoQk7x+96DFwNjncOTw4f7q9MP8IreoTh1FXdHStIZO117YlhCivy
 MBBGzfj21NXETkWzWqOaNt2eMXVFbWmDimPWSTTeG6rKaeucqH+sCUL1i
X-Google-Smtp-Source: AGHT+IFvjrZ06XXXR4tcqqqdQT2/P1b8d1DsJhZJznY1+lauamW/Nc5VnDDUy4zKe50NPJeoGrFrhg==
X-Received: by 2002:a05:600c:310a:b0:45d:dc6c:9e30 with SMTP id
 5b1f17b1804b1-45ddc6ca1a1mr2190825e9.14.1757073095108; 
 Fri, 05 Sep 2025 04:51:35 -0700 (PDT)
Received: from stoup.dot1x.polimi.it ([131.175.126.3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8f2d3c88sm194285115e9.19.2025.09.05.04.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:51:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH v2 6/7] target/sparc: Loosen decode of RDTBR for v7
Date: Fri,  5 Sep 2025 13:51:27 +0200
Message-ID: <20250905115128.376295-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905115128.376295-1-richard.henderson@linaro.org>
References: <20250905115128.376295-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

For v7, bits [18:0] are ignored.
For v8, bits [18:14] are reserved and bits [13:0] are ignored.

Fixes: e8325dc02d0 ("target/sparc: Move RDTBR, FLUSHW to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 77b2f54fdf..242ec42016 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -226,7 +226,7 @@ WRPR_strand_status  10 11010 110010 ..... . .............  @n_r_ri
 
 {
   FLUSHW    10 00000 101011 00000 0 0000000000000
-  RDTBR     10 rd:5  101011 00000 0 0000000000000
+  RDTBR     10 rd:5  101011 ----- - -------------
 }
 
 {
-- 
2.43.0


