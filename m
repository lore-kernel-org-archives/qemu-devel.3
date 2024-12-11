Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B097E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSs-0001jm-SS; Wed, 11 Dec 2024 11:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSg-0001Cs-2G
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSd-0007sh-Sd
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:21:17 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361fe642ddso6103015e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934074; x=1734538874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zslQ1Gnt7shcKGxYg5Es0RVybgupAdobUOUAJLVJUTs=;
 b=m+XpC6JuQha1T21EEYcFJNdYZio1FJwhfVVMECyz/EXZSzp5Gqg75htOhVbTbt3LwY
 oZE5zGTyWQz5CkHgQBt5o3v17NKiPyPerDRlfZQ/3JExjJz2BoBLay19vJpHhQjPX8p3
 RagNSvQxw+HAjijJVCaXNq+Z13XHHO0OXV9VknIrI7R16dSi3tzRobS2j3Kn5XlexoKc
 LOwM7wjy+/3OiLvmoyxJ0pUXkhmAvwzFwXVjlYxhFkuRLYZ2vLd2EeoHrbSTHsJ1n1Oy
 ZHwUYIYM14GOfS7bqFFaF6BammIdQ/kq4JuFQRfdY2kru3uueGwyU5rma7s8Uj7Vf3+q
 m1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934074; x=1734538874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zslQ1Gnt7shcKGxYg5Es0RVybgupAdobUOUAJLVJUTs=;
 b=fg8OfArnvmTX0UTzVYL8p5ty0FxfvxNVuTT3PVB7/8jI5pplWYVdcWn6LqjOvKpynV
 GNZUsfSm78IlLOf/qrGBTiyPBVBesUesk9BaUFAuz2gzxojSG40sCtk5h5PjTIbFMnzd
 EmYdJ/H6aQ3KcKA8jGgnFhX8uoPs8xr6Qj8bBnWSQo3dJ/Gg3WFPDfi27e1K38jnUWFB
 AhMt8zqKLvFn6X0A/x7OYNB3s7BK2GRXkh8Jtqyl/oNJkV6cNXnaLD6LIGiFW2EnOEEq
 rnJP95AXn+pC+0b51y/AEa9wo/KCQ3s7DFp8aCLZ7eoCDRwU67kXVLYSzI53ce1tRpA6
 xg3A==
X-Gm-Message-State: AOJu0YwgHpB8/77j1OrQoIFsLHRMzMxiUXxra0G8EhUeY7w85FlkYM0d
 rLt3UA1kQAs+nFpqe9iZdF8H/dc4i1IwdRrbHJqi/9newWJUsO/ZG/FaTrEKYn9X9ESmIekzHXk
 B
X-Gm-Gg: ASbGncsjGIiMW53tEHAwN5XFx1MfCa+xtvnaHxzULBjg1cVKL0IV6dEExS4lZLKV79W
 eehP9I+NRnGki7BnURnuzQOnQAtcD6mySfTVaIOkup+thZ5jARrz6ueY8rEcwWSAkAeZ7j7N2wL
 z3M9/lvPckI+KHpfUjYkKOmQ+ujX9vBxNw6E9DkKb+jMozdKf35QFfm7T/Y2UgcGw6tq4rS7ldL
 7k3APnIruNbCEiChGdB+i5MZBPyQKNK54cBwt6OfWvIYmXM1FBNYIdgV92B
X-Google-Smtp-Source: AGHT+IG93sTCS7pfpSte1qaP5ez/rcmVcmwYaqRdTzFjp4auZSL7sdpPOtDZUS/ioLH5aUnPF1W6jw==
X-Received: by 2002:a05:600c:468b:b0:434:fd15:3ac9 with SMTP id
 5b1f17b1804b1-4361c3e3aacmr23674805e9.22.1733934073890; 
 Wed, 11 Dec 2024 08:21:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.21.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:21:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/72] target/tricore: Set default NaN pattern explicitly
Date: Wed, 11 Dec 2024 16:19:51 +0000
Message-Id: <20241211162004.2795499-60-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Set the default NaN pattern explicitly for tricore.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-54-peter.maydell@linaro.org
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


