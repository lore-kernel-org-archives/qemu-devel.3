Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4BEC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 14:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuBvB-0007cA-5A; Mon, 17 Mar 2025 10:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuBv5-0007Tp-O4
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:58:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuBv3-0006rd-To
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 10:58:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so10698835e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742223499; x=1742828299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtBDnoytVrSXWrmefF2oQKVF4Cyc5aWWmZDXAn4aPgI=;
 b=nDh9j2XMKSwRDhye/zRYAKB5sphwvgrD71ZenP37hG1rx4QDZttY03BRIAd25QRjQC
 alTWLbj4A3H9u4VcMxsdhJP/2Eq/vKNDq7xxq2b2EzpOWv+LkCX1TiiawvEV6KE1nBHn
 Dx7FNFS2ToURqRi35Mhycait2ahWXOIn+b8wXmjMQanSinCOdYdTCSXG01DC8IDm9MXP
 608bu4Mees8urmfUQFglErkk/DRx01Fblzx/rL2DWdYCN0kBsDFDkYvHDObG3W0do6bj
 qSAh87Q5PyjejWNDiOXLN6wYBo2f0Zqq3fCoFzeevIO3t+uL8lWIiv0hQWiwqW42j/Qw
 yl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223499; x=1742828299;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WtBDnoytVrSXWrmefF2oQKVF4Cyc5aWWmZDXAn4aPgI=;
 b=VrKOzAk34JzQbcFfTRmbHmqPkVNLStb0PacpfinERly5zYbJyQMXJZTMrs/sn3YsDv
 UjqBnJc8WKkBj5DPkGa8NrIHMjuzG4k8sZcXZ3fdrxnqpDZzWza+QvncL/+mK33Aw/FI
 srDIertZbMSPVYSGxhbKFqKvumhJUGjPk3JUsV2XChi+Jv7Ko9xRf9LVUzw75S+jVAeR
 3Jqv98l3XZ7Y+PB5p18WuzAt+OpHzqeuhSQx4RI56Opk3axfcS3aoWLvmKyicgxXpj1M
 Xpc3gITmnY0Rp/e3SyHmXjLud4tQ38d6zSu8qGEoHQ/lYpnxX7nPoxmFZCKrVt1KtnFa
 QUUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGy+A+JVN/yJnA9cCuZGKF6XviFkmldh7DPS9UlmoGww0eXV8wxBLz1NGXYDljLwq7K4lQhOslWTmb@nongnu.org
X-Gm-Message-State: AOJu0YzjHg0SO0h8mscOAEbR/WRxtP/5wYkeKoUzVd4vAnQ4z62X4FYG
 7LFaHMhecUin07ZZ0UiPht8TChccAigVHrMvv6gk2xj2W9Gj2X7TswGgI3xsklc=
X-Gm-Gg: ASbGnctRmGzLkTqD1gmRGwdUniHIOpzrTYUdBUiyooy8t/EVcqWmOHikWlK9d1CrIz0
 ERs+8w8Uvd00dApFT+0w4gWb4SERksrpyNk1WkGzcBNr1Ljdx/OMsls5YowXeH/0uEmoO3/6Hn2
 DIKpNIv8bXiN35Zzy1gyoXLm3XJya0nPQhtcJThT+Sttw2Mi/FP61Zyb20p61pkFMnF/CbxPGsb
 sZqNiad3ez+Lj6OHafyHy7DwUXKb5Axjvat5V2dUZmAuMm+BjiyzpJN8fL7qGDZtrmtYUYHvCTF
 M73RXW1ndkXoUG7XAPieIH3+Ukf00Eck1QyDHIWX+C+mMO8=
X-Google-Smtp-Source: AGHT+IFNn32XkjhzEsDAlpP//+ffN5sBSqW8fUVNC5xF0zuxtyk4l0lzgjrfHZLh9Hb/DrMq5GSHag==
X-Received: by 2002:a05:600c:1d21:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-43d38970606mr1755405e9.10.1742223498867; 
 Mon, 17 Mar 2025 07:58:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe524ccsm107485935e9.0.2025.03.17.07.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:58:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 90B4F5F892;
 Mon, 17 Mar 2025 14:58:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH for-10.1 1/9] core/cpu.h: gdb_arch_name string should
 not be freed
In-Reply-To: <20250317142819.900029-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 17 Mar 2025 14:28:11 +0000")
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 17 Mar 2025 14:58:17 +0000
Message-ID: <87o6xzogae.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The documentation for the CPUClass::gdb_arch_name method claims that
> the returned string should be freed with g_free().  This is not
> correct: in commit a650683871ba728 we changed this method to
> instead return a simple constant string, but forgot to update
> the documentation.
>
> Make the documentation match the new semantics.
>
> Fixes: a650683871ba728 ("hw/core/cpu: Return static value with gdb_arch_n=
ame()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

