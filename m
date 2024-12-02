Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31567D78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6UT-0000kb-6O; Mon, 02 Dec 2024 08:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gl-0002bq-15
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GU-0003Xd-N2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:11 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e1f3f2a6so1544152f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145294; x=1733750094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIjZFE7UkHdsOrQTCFo+cXQ64MiE8Y6c27yOZdc2SmU=;
 b=zJFYt/D0GEtQrN/ejpxfd6evkIstNP7XhktqFPB8YNbdjPT62SKUPA9wcn5GqGjl22
 MlfwUxIr9nxl/HwK9WcpYuUKPXHAFI8cEbFpF8SvGuUsel2+QD7SZIWoT9Ufcya483Pb
 GyV5tuwW0ewMPi0UUa2CCb+e0io64ScZfKyv+Ltnyqlt37s+WQAxysamC+yCHUHozDoS
 uBfljId8BV4YVxFDSIY/yPNISCRu+TmMkkoxmKKQa9EXZi3Vv+TNhPGmNHpBRkVL2Etx
 9MiaD4qVukAed2TOVvYi3VKcve3a/yE4WOploewWQPx2P5+J+l51nTnLksGCU/ijYHLV
 iplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145294; x=1733750094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIjZFE7UkHdsOrQTCFo+cXQ64MiE8Y6c27yOZdc2SmU=;
 b=CYLA0C2C3uz4gHebesLHe8icfUi64JIZ6XZXlQeehgD91ITBczqLodO1hpUSh5fnK5
 hOlUJepmN5coYlNaR9qeAq/a8EC6XSZzdpV0/fAIjxZffarVxXSry9Knl6Gepkpo38aA
 jTaarujCkmmHKTQDLM0lDR2cgwHDDBqA5oCd9ctsN8pAL3vl+yRjagvE3P60lMjpYSKV
 uqJrk9U4is80xHWe/iBDcG0J4DtyoJ4URZRU0LMfmhENDbSk/NG/EwK9WSjxlCu8qsTH
 1g0oOdsbMrUe5TzevFjnHv+/CM4wSoKzWw6huOVWdw3nTUH1pBOVsSxJlwcdUzrglgDC
 B7PQ==
X-Gm-Message-State: AOJu0YwzAhcQvmBtW7N6Ad3kcHH+NEGkqyBOATofA2Jv3228RUzaK+R5
 aloOfQmBksxArEEQuUPmWX96HFbJURYm3vDDYzGZu+7b9sVm31ELPYwiWkryUfjK1R/2tQglrcI
 R
X-Gm-Gg: ASbGnctJGs33nFciOdJbSeXe/nossI9+YYq8dBGKxTXMWBVaS9cSGIecA3+f/D3h/1D
 ECCsrCLQobX9h7WWHKarnqq+ovJmscCyB8My11jxuFsNm1L4KaYvcM9aXpJTtSwtzPZyTvCiyVT
 65YVrmFsq1QVtIlwUEkQrvSsQV4KfbKjFSJ/ZKoMVmS4pr3hYb9H0eBOI/2fR+OgSn/TxDXbviX
 rMj1/Kg/m/RY1GapUMpsl33CXJ8aCdMJK2yh9EDf91iRQCNj4yLAnE=
X-Google-Smtp-Source: AGHT+IFnOp/qmDxoo8maoUW0HNCIhHY/AycOvqAK/YMRFl3NaZIfSnFpJn5BqDRmNnLF2XpRV+ImjA==
X-Received: by 2002:a05:6000:1565:b0:385:f062:c2df with SMTP id
 ffacd0b85a97d-385f062c5d3mr3670273f8f.11.1733145293503; 
 Mon, 02 Dec 2024 05:14:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 for-10.0 47/54] target/rx: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:40 +0000
Message-Id: <20241202131347.498124-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Set the default NaN pattern explicitly for rx.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/rx/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720f..69ec0bc7b3d 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -100,6 +100,8 @@ static void rx_cpu_reset_hold(Object *obj, ResetType type)
      * then prefer dest over source", which is float_2nan_prop_s_ab.
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &env->fp_status);
+    /* Default NaN value: sign bit clear, set frac msb */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 }
 
 static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
-- 
2.34.1


