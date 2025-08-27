Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB13CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 05:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur8s2-0005NS-R9; Wed, 27 Aug 2025 01:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur8ry-0005M7-3p
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:38:50 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur8rp-0006kc-Lq
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 01:38:49 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77053017462so2682057b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756273117; x=1756877917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=DumEDsiLE2BMyDsQtn+QP6ikQp2JPurJ228DRcUJ9yY=;
 b=XiiXAsZjIGZXINXF3q7fhfxV+L7Mu/haep6wsBsUt1w8+A6TgD7OIU2DdLEj202C7b
 0HrI+SDS3Iw3rNlgInIj8fdK03dQI1wQereeJG2GtgSYqAHXRSAK/bjfRndZoBn/hIm7
 TLIx48qH/uJFY8Xdoy6VUqig2JoFhRm7nIlhIyjw3VxlKJHOucshe2SPsMTndo9/QDyl
 ePrko4m9E3fu1JdR0KEC1KDTiP06pt1JnFp7Tqhiet0Qr4UAULedud2ZaR3S+Xxs2OXd
 9K/hIxveouZtxBQEyP14Fw4b66d3cBYRqNCt/4lwMka0Dv7U/HpGzOuDWflNrc2uRRO6
 vlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756273117; x=1756877917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DumEDsiLE2BMyDsQtn+QP6ikQp2JPurJ228DRcUJ9yY=;
 b=eFvxJr0jNO2teuIPg4c628v0yqGDzB8coAMJscl+oShYgnbHk9KgQbNLp0S91RUk/W
 6diGppme3gtgRFRRG3M5tx5dzvSjYmlxchEVyNKPqqrTp6N4TwWLRVSrEcc4re3VtGRZ
 mAYpTOOwr+2ug+Vt8C1C/lcJQXZUpFcinAyvJZftTetwCsYdQILcYJwE8654taPgVCmK
 l9WS9B+dYNgrWu8dsMM0Qt8aKo0eQjdW4HLcDFAXSNVSzIr89nDIELhuzYrEPf92PUep
 kk+poPL9UAb9AQR/9vlCQj7O5rO6z9cLHQmZsDAWdmizRUym/iEmiVL+pjEB9oEn+WXA
 bWhw==
X-Gm-Message-State: AOJu0YwM5ei2m5wY+a1tHd9ZVEpmK3yX0ChXU+xPhV0+xSq6JyvrAswS
 3aVdMTr3dnSfrsxIQV3uYWjGNGcY/exhJNyb6NZfYyWpkk4UQ1kc9J9IcCqA7Vri3xcpS7xWocl
 aT7oi8So=
X-Gm-Gg: ASbGncuZ7d3XfWTSGH915Fo3DjEnjNR3SC8FC1hA85R1FdMlqXh2X2lCOvcXSePUAOt
 6eguTFlClg+S6my6jt1MCFkGbi6JZ8UrDhiopjXSqr4l2zF363vRFxydf2FweY+/X+uJA7Ru+6V
 iFVswQ0mGw1eB+9NJZywLdtNK343BBAfAqwJ4lOTdQdfI4q1RbGvkHH2ELETx7pbnXgDx4D20Zx
 2ExTpYrot/yoONvkTtdRlwOd9zwEcLbAcWV8uUzwlFw/yJr6dvSb41QK9LDCTXCqEnVa9Gl0U64
 3P7LlIlbNVRL1yoTFKwN/wDFSgPRkR/DLIeo7JI3H5AUQcW3CEXobMFrb/D7NuaT5K67YmRYyy7
 k/sbbwGRnb7d97JV14hBfHVvw3w==
X-Google-Smtp-Source: AGHT+IHnMK4mjeF/6WIF8F+4JtBjxUK+SiyJxKZp9OdtIS/xH9uGP68BN1/+cmdqDg3b5OhvOiyp5A==
X-Received: by 2002:a05:6a00:398a:b0:76b:d75c:8a76 with SMTP id
 d2e1a72fcca58-7702f9d90b9mr21877441b3a.1.1756273116740; 
 Tue, 26 Aug 2025 22:38:36 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401af6b2sm12071868b3a.56.2025.08.26.22.38.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 22:38:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/core: Don't dump incompletely reset cpu
Date: Wed, 27 Aug 2025 15:38:20 +1000
Message-ID: <20250827053822.4094239-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

The start of CPUState reset.hold happens before any subclasses,
which can result in attempting to dump uninitialized data.
In the case of Sparc, this will SIGSEGV.


r~


Richard Henderson (2):
  hw/core: Dump cpu_reset in the reset.exit phase
  hw/core: Use qemu_log_trylock/unlock in cpu_common_reset_exit

 hw/core/cpu-common.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.43.0


