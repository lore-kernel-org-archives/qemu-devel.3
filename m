Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E08C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2rv0-0003tc-Tq; Fri, 03 May 2024 08:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2ruy-0003tE-RF
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:21:36 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2ruw-0008Vi-Co
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:21:36 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e09138a2b1so68702161fa.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714738892; x=1715343692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/WhA8PWmZFguuR+94hT9+dK8WwdgBURR3x26GDG6l34=;
 b=uazbWUF5dVfJpF8emTPiFUfB5NcBGxXbxKKJPS4o7FmCVx+FRsmxvhshB0/nLnJegU
 2E1NV1UN+5svNlH+r/ZmMy3NzYjZBH88NxFBbR/P5O3MkL69vySBW0zzyWUjmhSKflPH
 TzQRuNWwWB4/mElCyRgEn7FkZ/kizoTDMXydZ7zL2MRUMBoXa6gmxlhExtfnvZS/U7RU
 asMPo6yfcGzFg7dijPuIbxofyUZ+Ab+1eNuabjc/nY2o3eQx1M7BWOxOdctB3HZjC1A7
 y6C5Kbd2hST9d6UmzSUzCpXWkRabYMRttKuY6vsHGi7Frg4JwcfoQTubK1ztjbaN1fX6
 SE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714738892; x=1715343692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/WhA8PWmZFguuR+94hT9+dK8WwdgBURR3x26GDG6l34=;
 b=RVi3ERj7mJsrs+ISkS1YK/qmUl2cTuCx7g/fdROLd8D5/OHXJ1UAF59Ifbk1A8qmJy
 h40LpDKKy/bbVXRJ1OvGHHaZ9ayetzemy7pDTSXf0BOQ50Rymqdk9W8feRXauhFNFahp
 68EQwDrcZFv5HHSjPvuIXzhMaL4Ao0N+3+y7f+rV5I/rdMaVEck/yKCnEN9J00/eO/Ty
 5cJ90ULiBUo/fO3mg57+L2fB1CQONRfc+mEwyG46EAZdwT2Y2CivgRHnYW7SxuwkqmN1
 fMzK7HzVqmgM7PxoKw69IN5TBDhE0XkFOETjUL6Kj+qnTqpsgc35ar8VcdVRXRwpCnaB
 9tbg==
X-Gm-Message-State: AOJu0YwhyQl97G1dV69OCg94aDUK2E3VyrHh9VEfDJdTsSBlK+Yl2XfH
 UXsRiZUFBOPhqxcF8IOoilU862fh+xGvWaspnS+M6Po2tFWJ1jWC+3+VFOwAFlE=
X-Google-Smtp-Source: AGHT+IH0u79X8htM0WanVpOOinvbiFKfqO9T3SD35Mb7/Tm064KyxXoRxYh65/82NMALMNd/QXwOKQ==
X-Received: by 2002:a05:651c:553:b0:2dc:d2c5:ee9 with SMTP id
 q19-20020a05651c055300b002dcd2c50ee9mr1979052ljp.2.1714738892038; 
 Fri, 03 May 2024 05:21:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 r20-20020a2eb614000000b002e0e3467465sm515941ljn.12.2024.05.03.05.21.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 05:21:31 -0700 (PDT)
Message-ID: <da078202-63b4-49ff-b7c2-526b940687a4@linaro.org>
Date: Fri, 3 May 2024 14:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] accel/tcg: Simplify meson.build using subdir_done()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240503091657.26468-1-philmd@linaro.org>
 <20240503091657.26468-2-philmd@linaro.org>
 <CABgObfb7QQYdc5iqLME+eBhZG6nay0oacYFz+ANO2eenQOonqg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfb7QQYdc5iqLME+eBhZG6nay0oacYFz+ANO2eenQOonqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 3/5/24 13:16, Paolo Bonzini wrote:
> On Fri, May 3, 2024 at 11:17 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> If CONFIG_TCG is not defined, skip this directory calling
>> subdir_done(). Then since we know CONFIG_TCG is defined,
>> we don't need to check for it.
> 
> You can only remove the check if you assume that TCG (unlike e.g. KVM)
> is enabled for all targets. Of course this assumption is true right
> now, but in principle it does not have to be - a long time ago,
> qemu-kvm had ia64 as a KVM-only target for example.

Got it, thanks.

> So I'm not sure this patch is a good idea. A lot of it is just
> replacing tcg_specific_ss with specific_ss.
> 
> Paolo
> 


