Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D017CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qy-00063B-B9; Tue, 07 Oct 2025 10:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qq-0005yM-3s
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QY-0002NJ-UI
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so49727675e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846345; x=1760451145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KSc0ams8oTJrngGOePz/vyrE7HMZyBOFuHXIPVZb+bY=;
 b=iYaogQaaPKq2pQnOP5bNOvjQg+8tIWk6k301JpfGOysFWXkjz/R0azysgRzANuxt00
 1f3LFTxRyENExikViGupgO0kCx7FnEi090MULyu3SoQ8sAAm479IoZR4wLiu7SoBjtlT
 llZZQEYaZU4Wjgc1eSLV0hGrwC4h8bvoVQluMAVI+mfoydc7QP5hTUE4KiWr0cjaAkEl
 jWX6QSy4wW+ajfpAR34Ul8rqJVWdNRj4KUBG30tgQN+6oW22texh6qimKsVauGG/g89H
 7WGubVDB0koKPyeX3i7TQo6HDh14gTwnt/DU2UR6QWGgFR+/Z6PxlYKKXUqGn+JWnhRK
 3apA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846345; x=1760451145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSc0ams8oTJrngGOePz/vyrE7HMZyBOFuHXIPVZb+bY=;
 b=ByG2j3DDeEG2x6dNiAPdH7k/Yl60xuqss/BthFIrasKpoGwfP8DL/pqYj5n94taDgH
 NNSToTy/9nHPtSxavwq7HQmEdtyP3oG3BRMA9unSK4OtQvSoDXUCZx25D31NQDV7peB2
 ctyw+/vMUZqcSyAre72kJ2cjAwOnE8uy9aIn3fjElErrR0Xj/nC1G971DzTc1qLQRf9D
 cJh+hmVY10/9hAzK0q+TFNBbshhnt4prFNlWPfacNPQM4Ot0ltW7yHsO98/rG5r/uCnX
 GYD4pip8M+SKT7Ns+14FZ8kjHRiiq/j7nfSglCajDzxqKFfVTv1GR7Fi8fzSEsIENHUu
 ATpA==
X-Gm-Message-State: AOJu0Ywcpyx5BHqiJ9TrYvbyQ+/I/m7OIkkH2ci2apgu2OIOOO6A6LbX
 LO93O7iP45VUMhuagniMZ12R6IleCpvVcyCaHEZ0sUKtlIvUBfv7LFfPjouNKN2IrVR0tX8+Bqz
 Lmen4
X-Gm-Gg: ASbGnctEORe30db1vqJehYo4mPSWm6FyT4yglaMPq8UqOAb9blhxoIcrA07clpMMT08
 zaOw9Rrdw1irNdt/TnHH8BGuDYFp8Y+cI/XzBeO7ahDE4KaBvsNQWb06UKkFcy8+Hq9kOM2S42q
 Ay5ajCW7IAdjq15N5yVVlQuGE/kLz1J4mj5CDeS2/iyUnJM2kc7bqQ46QNJhyZWaFJj9v+vpWOE
 OcekrxRtEsEqfbTTMzS0Ig9amUkLsW34emOTR3PjmNH1B9yGpXm1cqDdDqcWWlO3OVYnpDoalYH
 cdGyhwufLLJjz05Yvy1YMn/n2S69YS7b9rw+MqvweH4fWFB2nkV6c3/t9YlLkhGmcZeYi+uvrcz
 Ljoixc4lFnb9q0eOIvQ8AYidc9GvwXGyF6s/Vd/VnPzWIdr4JpcfmH9pH
X-Google-Smtp-Source: AGHT+IEnfZppIC/+/HslLxTrxh6gDQ6NdayqWcjvXsDmuDIKgKwVeAXT01mVcMqi87yxCOYLH3UekQ==
X-Received: by 2002:a05:600c:8591:b0:468:9798:2043 with SMTP id
 5b1f17b1804b1-46e7114ea2cmr86693425e9.26.1759846344649; 
 Tue, 07 Oct 2025 07:12:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/62] target/arm: Add GPCCR fields from ARM revision L.b
Date: Tue,  7 Oct 2025 15:11:14 +0100
Message-ID: <20251007141123.3239867-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2b9585dc80a..41414ac22b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1995,13 +1995,19 @@ FIELD(V7M_VPR, MASK01, 16, 4)
 FIELD(V7M_VPR, MASK23, 20, 4)
 
 FIELD(GPCCR, PPS, 0, 3)
+FIELD(GPCCR, RLPAD, 5, 1)
+FIELD(GPCCR, NSPAD, 6, 1)
+FIELD(GPCCR, SPAD, 7, 1)
 FIELD(GPCCR, IRGN, 8, 2)
 FIELD(GPCCR, ORGN, 10, 2)
 FIELD(GPCCR, SH, 12, 2)
 FIELD(GPCCR, PGS, 14, 2)
 FIELD(GPCCR, GPC, 16, 1)
 FIELD(GPCCR, GPCP, 17, 1)
+FIELD(GPCCR, TBGPCD, 18, 1)
+FIELD(GPCCR, NSO, 19, 1)
 FIELD(GPCCR, L0GPTSZ, 20, 4)
+FIELD(GPCCR, APPSAA, 24, 1)
 
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
-- 
2.43.0


