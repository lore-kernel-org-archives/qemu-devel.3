Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B241D7831F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Uk-0002iG-6A; Mon, 02 Dec 2024 08:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gx-0002sJ-Ep
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003VZ-Io
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so1912572f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145291; x=1733750091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1acc7zoNKrBVtOlWY+W2T5QYcrfhAL8i8cxJ7BeDz+0=;
 b=XQlqIJTLSmRQh5jxd6vNhueryo+DTAGiZl9wEIQk9Oxi/a5fpV8XwjZtTaiBNC26up
 lYqGiZ/7BXYxzG2iBwlH+evj3nEImv8e7aPz8drMxMwW/QmgpS2F+9aUrGY1qTb0lt1b
 szGIkqIhKkseYaQ6cHHXhCgJV8sJKY1qQk3wfX9OgROzgd52Ce6DTkwJj0oNLWbsw3Gz
 kngMJV94TEeV3qypcxlnbqZvGU35PBOnFHGAwWBcrAFWf36bD2wHtDTFxsDObqsyWjcm
 sqi0XeW+nnGl5i7dE2O7pgpE+8TrMh+6+t8fuNHLFPLsHiC84VU8VbiSQmHzQf6/bFEe
 na5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145291; x=1733750091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1acc7zoNKrBVtOlWY+W2T5QYcrfhAL8i8cxJ7BeDz+0=;
 b=vN4IMGmFnEkdUbSERuFm1x0Ks7kUYdlDpcVMl4X0SqPkD96EFHlP+P7ypM+XUEgxJa
 2VRpF+DKpQutEi6gKEXJ16mwaAIkwiEBw6f7eSEGtkA2NaMdMaZnbDszo3H4ot9nCSsY
 dOq+OiVyBbBN3Nix86+suNl1IG+jWbEvHvAJ2wqIw5PQw4ZbzUOrT43g7yueDrxaeJV0
 CRoPOq7RZnE9SNTWUYdYIRXiVRb2KZYW6MVob2Nrf3WMpHBnEZrCL0pFuECB9Gxvbn+7
 srLmccnoUoBTmMd1ZxoT9blhP6cK93x0pxWlKIO47JJMyPJGViH7w694fBRMwnnZ0fFb
 /1Hg==
X-Gm-Message-State: AOJu0YyzFcBTtSMIU5V8b735VR9gxBGbx1l3U1tMuuOYsDYEtF5FA7Cx
 3RQ9JQ3LO/LOVBNsASgRw8hexZAIb2PkrWHQCQ0gDXkNjYnTEZ4V+A70djjDxdu205vyprkBybV
 t
X-Gm-Gg: ASbGncsYp5KAOTpE2nDIs28BToEcQcmbLtLXM8zOEBrS77xmSP1xBpaHPYeQCossONo
 DHbJjN72NqtxGEGjfkOk7ZpA+Ee42yhYrdXD0diAuqqCuVb2MqgYbgDOI3L7YAE16VnkBrx6eAj
 OKAHauUFL+AcWv/rs1mqimMdUx6vvufvB95Q/GUyvRU8hiSTrkHXDqPLo2+Ujr5DTw8SdUJeAE+
 G8mTUwxYIUn3f78O3M2HxhGBDM8M2bksYAxaCnWOW3SC0Hp3pnsKws=
X-Google-Smtp-Source: AGHT+IHNbge/vZMLc8RGd/dZFXD5GsVkV/6of92W3el18+GZwhG01NfV23T6gs101y0B+U0NJB/gsw==
X-Received: by 2002:a05:6000:178d:b0:385:e03f:7553 with SMTP id
 ffacd0b85a97d-385e03f7608mr10721053f8f.9.1733145289443; 
 Mon, 02 Dec 2024 05:14:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:49 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 44/54] target/openrisc: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:37 +0000
Message-Id: <20241202131347.498124-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Set the default NaN pattern explicitly for openrisc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/openrisc/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f26..3ccf85e95f0 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -111,6 +111,8 @@ static void openrisc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_x87, &cpu->env.fp_status);
 
+    /* Default NaN: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000, &cpu->env.fp_status);
 
 #ifndef CONFIG_USER_ONLY
     cpu->env.picmr = 0x00000000;
-- 
2.34.1


