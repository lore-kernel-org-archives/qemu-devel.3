Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E1D78320
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6YY-0000lD-QK; Mon, 02 Dec 2024 08:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gx-0002sK-FT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:32 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GY-0003qI-J8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1430390f8f.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145305; x=1733750105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lx4u5nyS6FnIACOhuZuILUeF3tfNByeD1RldfY5AhvM=;
 b=VtK8m5iuX/NM8saGP8+olK+nfTfGAOGLczn0LSMGSRj+WJANRBoe9z3xnTW9w9PX5B
 0LNA5EmNp8Wt6JAggzZAV0S2jBWKYt6dZsjjhUUxjwwhxHHjNCYND0mtlc/v35yiZ4xL
 NIbPW7FDBxe0MsjxUwJbHQmzcrGeEqdfi+fuzZWIBq/iW8QB9PO52rETZrO+w4zM7HeK
 sl+9FW2SeyWAJ5ISkG+I3rimmzpk4Pcvvj8kih+jx3eMZW1vgvBTxJ8+ijrdRYqLBmwX
 UFoX5eLFjS1KGG7IHTPPNk/oAEAQfG6hFm1EZnbkC+tODNbrnx7/6Zs7eMp0WMAgxXUL
 9LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145305; x=1733750105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lx4u5nyS6FnIACOhuZuILUeF3tfNByeD1RldfY5AhvM=;
 b=vExc6Q+ADCuXav0SIMvICGsZYXu4YIqOLSGjnRQwvpvKV0Q3mFfE1jV5Ug2J3Umfyu
 VKNryszrBYlmF3kD1j7/MZPQSrNXgQEBkRbv4r7YWeyMEtG1i9WIzi5lMiQVTAbFRnxc
 MDRDv4ajKUXf3kh0opXg5he+pKJtKBoZi9J/UFwfuJlMdyWUjXM3DrmVeigRh2Sbis9J
 zlGCaRv1vOhB2ifCwZwYWIXbV1Q8HKPYqQjGNdqqjS9+OoTWQN7tZgpqvR1wTFskbQ1y
 ntdJDwLW+MSvF/6ZPZbab7E5X0w/hFhnVpvohKe7/Fycm0D7mk6zXnNeu8gKFCYilbfp
 HxRw==
X-Gm-Message-State: AOJu0YyDiIzjCvmARiaArPdQLNSdrZmFKMvyA3SK+7LCjKHW04dUjcKM
 +41gBC4fda5gyFOkxLWkdB9Vj6gA+sBsAOyWfKE8MTeO5wA29T8ZW89d/8pgEO+8yeBt2fD+7bh
 K
X-Gm-Gg: ASbGncud9/kCJe9bs3Ee8PPyDM+be3VgRxT7fgKI7d8PLQUaj0Rvnjwhjwpe3WF5Buu
 C7DLmZvpXe/OQvkx5Tm/zoKsyCE73Q6oZvDqFULFk02iMilVzDFJxawMQgEj6Vt+qEYZPaVWyDy
 uL3NxrEUuX9u6EtPy2wZuKuWvohIDDkUxyox+j/PIe7MAk82q6gMU4RYf+dUeFnXoVx2OFytdaP
 uP629sYEtEaQHkgVjVhWPSQLh092nBvSBxO+q7PbVRoxccZOs19cJo=
X-Google-Smtp-Source: AGHT+IE2VGJAnehuVMFVcXwJwWYUFFGthX624YluXZHUiteB7VGRqCKZnI4ZvOYVRTx+MYrc/9o62g==
X-Received: by 2002:a05:6000:a01:b0:385:edd1:2245 with SMTP id
 ffacd0b85a97d-385edd123c6mr4738904f8f.30.1733145299323; 
 Mon, 02 Dec 2024 05:14:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:58 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 53/54] target/tricore: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:46 +0000
Message-Id: <20241202131347.498124-54-peter.maydell@linaro.org>
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

Set the default NaN pattern explicitly for tricore.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/tricore/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 7014255f77c..e8b0ec51611 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -117,6 +117,8 @@ void fpu_set_state(CPUTriCoreState *env)
     set_flush_to_zero(1, &env->fp_status);
     set_float_detect_tininess(float_tininess_before_rounding, &env->fp_status);
     set_default_nan_mode(1, &env->fp_status);
+    /* Default NaN pattern: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000, &env->fp_status);
 }
 
 uint32_t psw_read(CPUTriCoreState *env)
-- 
2.34.1


