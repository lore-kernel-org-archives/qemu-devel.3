Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E9BE8B386
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnRto-0002IX-0z; Tue, 03 Feb 2026 20:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRtn-0002IP-5f
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:41:43 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRtl-0001aA-Gf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:41:42 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso5068005b3a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169300; x=1770774100; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PlKNKODjsVVAFC8y7nwDaksAqyva+DFRP4APkCCPUWs=;
 b=LY38aYKoKH6Wwgmw5O9Y4B3Igm96h1nA3kE5CFiOErWUoHBeKDtNLp0fN7KZJW7K0K
 JJpy7t6Drmwq0NIdYSpKYxVrxYMedK8yOr5Gspy6IK4VPw86TjbZi119HS6oB0HIsvWu
 Nb9ggHfhvDuowYjZP4WQ+H4qZZBEpXp9pnA1VMarNkUqTyvgpk/nZ6lFJU7RiqeVVi5c
 ZyLNOJZfMD6x0gAZ3NxYhujitiOPdFhA7TFi15A1VSkztFpsxpo7XvkTZn95YtRqlhnw
 KeMOShW54i/UzWjGHSutDaQrEtqV0IfOR4XFp0/HyleW/+bicyFickPBnvk+bX/gDzkl
 YvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169300; x=1770774100;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PlKNKODjsVVAFC8y7nwDaksAqyva+DFRP4APkCCPUWs=;
 b=KlAXg/rI7dAH4NqgTI7g9kkW70CN1msEvyAvij7RQ5tvgFDjhLfeGioYZQXZQ57y5y
 9/w2UItiucOC3OyNwt7+69YdkBVUo8U66uC0obyzmyohLWxQHh2etuDoQyZRIkb9VCDz
 MH/lp8ryeRIIv6o5LbDWe1OREQ5/8ofOm6sOrTmmzFe0SMNaUyalAEnmcPDKRGJA9UUV
 QHJJnPlL445P2tKNmVJ4P789aLEL3sHmLu4oOG4ns/gB88X4MXKxAW9oQlrhdDV/IsUw
 cw4gjH1ZNfYc0VsA+n4DWytyjHdaYFV+hh2sH76mpKVQPN7eiURF94Lgxn0bVSAXpq3P
 k9fA==
X-Gm-Message-State: AOJu0YxVtSBlPlhyzxqzcDBbocdNRXjlcPp1K9UsUcwzfIGi6oEFpRe0
 M5utyiV3kTpkWrvVzPP6OwcVEByiuB8p6Pjsyq+yOXzs/yEMFf86rCRSXqhGvI7tkfgFugKzGGS
 ndo65fMbUKw==
X-Gm-Gg: AZuq6aIGX0vUjRevdvaYzXBsdX5Cd316a9eLU50UwLX5I2YvO6u2nl0vEbGKqTKoM0p
 ptqL4mQv08iotyd7jrjd9J98HoYNtOr0G8iP6LtFFky2vmSs+S8gYCgD70qXhlsZ7ozKFqBoxG2
 Lqn0eEYHly8fc0z7RdsFnpMo6BIxe+yk8D4pFQRuO+vGG9VaqB9nO4/qHJmxKvypXGJG0CunKY0
 NnbK/vHxQHJ+uDRxUZS9aX/OYBmVHzMnAEH2QU6K8VYbYeJrzw05QlvTg078JstoTGupSQjN2hv
 BlJr6PfzHp0snq0bXPBjFAFqZFE8iI8IlVumYXiVdcbioXeli0XgT+2khDtvw+VuHsokKkLXgb0
 WAhVO7UT2QjHu+LA/cxKRzYGL6WlLb/MeaJXpI1Wi4BfCZ2W18To9aN5hivyCTAXKKXoVli3Gi8
 0+8BG2D3kb2PKsOalIlwJYVEgwcwz84w7Mi5g452yG4odcGpYGEiYvAtYrKg757q0f3d44xE5hC
 3ym3wlVr0uFFz48qWFn2SejQR3irTBhNZRv
X-Received: by 2002:a05:6a00:4fd1:b0:823:f51:192e with SMTP id
 d2e1a72fcca58-8241c64be45mr1385476b3a.51.1770169299609; 
 Tue, 03 Feb 2026 17:41:39 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d48789dsm580502b3a.58.2026.02.03.17.41.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:41:39 -0800 (PST)
Message-ID: <944ba895-bbd1-49e3-bd08-ac64fab4d7c7@linaro.org>
Date: Wed, 4 Feb 2026 11:41:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] riscv: Add support for Zibi extension
To: qemu-devel@nongnu.org
References: <20260203082144.2183253-1-hongzhibo@bytedance.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260203082144.2183253-1-hongzhibo@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 2/3/26 18:21, 洪志博 wrote:
> +    uint32_t cimm = (inst << 39) >> 59;

sextract32(inst, 12, 20), I think.


r~

