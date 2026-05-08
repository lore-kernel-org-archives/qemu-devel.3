Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDD3CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 07:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLG7C-0007Jl-1M; Fri, 08 May 2026 03:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLG79-0007JJ-Op
 for qemu-devel@nongnu.org; Fri, 08 May 2026 03:59:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLG78-0004WP-94
 for qemu-devel@nongnu.org; Fri, 08 May 2026 03:59:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891f625344so18502185e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778227152; x=1778831952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ldx1CaNqTaWy3ELaBhs3kiXP7JbP6a0ZS4zJ20j+2TM=;
 b=Be/Ikj7tlGAnz8urkR8ul0DRfpOJuFE4bk79HiRI/5o7tuPaLoBT01fcG/++68QMvh
 33e80mFoSp2PhClm8OR1Ke0f0HFHS5mIGf5rLjL6/fRpHyQeDSv1O+yftS/by2vuIuKx
 qCWVMBvt8RDAi0MRe75o5MgfqDv5FDDGaDPt5iEA6Oo/iLtPoA8ETNwly3twNYKjUl54
 4fv4EqommkqC8xWB4DryVJdGLo3JX/ggpYHigDVZGBAbQ4tmwj+bNnLTFrNRSAmpA2jD
 UZnKiXuliOCTj8e7uXh92X/MhioICGpgB6W/dEHK2ZDPCU+8mzWtGhpSj95ScSJNRhbY
 1p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778227152; x=1778831952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ldx1CaNqTaWy3ELaBhs3kiXP7JbP6a0ZS4zJ20j+2TM=;
 b=FsOxgmC85vq//t3sdKL09jQs1pdCdkJCZqibz9CRoZuPl4DdNvNyT5p802qzt3cJSD
 8Gh9+8hjWpXcHPJFURoG6sU1IlromC1OYYwZlYMza6SmXCMI5bqq9M6kjygs6m4CsVgr
 tJxhAtIl1Vnj4y1psDRJFcP02Kf9aN7amdYqYWhLp6xUkuRvsJRS95/wIVlO74P7DIYd
 cIQt6Cx6B3YIaUCyDsf4H7FDiyazW0Lk5aJeY91JsCNmhdpVGcgbBHkE6hu28WZuz7TY
 YUEZCyH5yJuvaedRgJGbl/91IJjT2sQDqPYnDvIkHn1k+bv6qc0XWrzNBIir+lU0TW5b
 FDTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fLRlumIf4X2Ejt52TpfzIcn593DA0k79pg1Jn12jSrZsp5u0xs5X2EaUCwaPnI7ONtgAVrQsFhprs@nongnu.org
X-Gm-Message-State: AOJu0YwwJppCnhFbUOFV5AUDRfBw7S7PrNq5EmSqFszuHSOVc+QrQoO/
 DxYi7dRq9HQvh8GhGrmdF7hbpeXoVRj3tONvYCAkFWo7t63PK3cElRucAw/QSXmXzqg=
X-Gm-Gg: AeBDievHJXKhpZrzZLITmqr/b3xKOjELW3GaeMsYuopWnBxKjahfaDJOKtchNkYkR/d
 If/Al4gU4fRe6Qxhc3yw+bqedf0F8oZbeLWDhRQbjIsG/Y5Ph3vdwwKosxpPKIhvJkMh3YBz7Cj
 ZrALCf6QTGMefkrvpOGMV8KK6ZS40VoDXXiCD6tvde8oNGsfqaKtxlWDXHdorVNtnb86eQdMQ++
 3OtNHSA0xUSwSFUPhaJkgQKhwH0e2M+lJTAj5SP7sjpmtZhD/eSnILu4J+to8b7xgHA2Os8EG1/
 PaRd0LsUXT1yY4bMeNKDgzhdhe35DdcvaxCcS3rydCDXHwYaUhPL6IUpPoiq/mCFf3RO7aSqOZs
 KwN3KjcDC0RrsU7Lix4G3Zmt4i+bsKE1uuAfv5ia4jOqW0vabj8/ozAkxBYyO78VsCX44O3COXW
 IQMcRBheLZruxGykUX5wqGJ4i5G9oV2jgJ4EqjT2SeiFzHwVzMHcoX8S9zzK7edy76
X-Received: by 2002:a05:600c:638e:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48e5e00c1b9mr96731675e9.14.1778227151852; 
 Fri, 08 May 2026 00:59:11 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68e374bfsm20729055e9.0.2026.05.08.00.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 00:59:11 -0700 (PDT)
Message-ID: <53cfc25c-cb3e-4637-8d23-1fb2d1901317@linaro.org>
Date: Fri, 8 May 2026 09:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] tests/functional/test_tuxrun: Restrict to TCG
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507194728.2034696-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 7/5/26 21:47, Peter Maydell wrote:
> The tuxrun tests specify the cortex-a57 CPU; this doesn't work on a
> KVM-only QEMU build, where the default accelerator is KVM but KVM
> doesn't support that CPU type.  Restrict the test to TCG, to avoid
> failures on KVM-only AArch64 builds:
>          Output: qemu-system-aarch64: kvm_init_vcpu: kvm_arch_init_vcpu failed (0): Invalid argument
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_tuxrun.py | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

