Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F9BD232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve79x-0000te-NU; Fri, 09 Jan 2026 02:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve79v-0000lV-VW
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:43:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve79u-0001ky-DJ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:43:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so28803145e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767944625; x=1768549425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rh4DNYaJEQ9BCU+Rjd3YMjzWwIHRs+cy0wF8O/Siu0w=;
 b=yX7cxQ8V5UHLCp7MDuWgMIy3xqibbOeXM4luk6+1D560LDhq7rZ50GZx58yR+dOCKG
 7NTXhc0btB1jbG1d9tn950RCoSWLAt2yv0sfLeZ4PqMX58JmmA+NoONHG6vjYNxoepaF
 /yzjcuEpLVZw8qu9tcS0Y8DvztmEAqlsTpDocHkTc89etibMJLKzrtmlxAP4Ld8DmF7K
 jeVHJ9O95HONdbWKfGKUD+TjpVuH/qIbcPR+MNkVARCf6cYDdXYwkUaOlxj+UMUruP7i
 aC8z05SWRuWHO/3n2rLSJw+4a7H1ziam5C2cvR5JTpfpNQPwXebdautQQvVkFRXXHl5N
 zQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767944625; x=1768549425;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rh4DNYaJEQ9BCU+Rjd3YMjzWwIHRs+cy0wF8O/Siu0w=;
 b=Pl8M0TvrB5E3SMGhHGxRnqxnofB1l1w4daPM8o+pp0X21rp1WDmW9CgMmmwRyydxCO
 DD8I23T1RdW43cQvGmfqm/zt/KKPm51AsfrDrg8Y+u8752cZFgsukC6H84z+dcf8VO6a
 RJWpjmflD/BQIuh0Z68TTY1XJ7zoFLKoojrN9MynP5zGX3gqUGSa/KDsoyOq6ONQtR4r
 0cM+GR8sjXHBpeIe3Bicc1SenjeXYKyau47jXUrMeoXJmVe2ZHGKOKHVWFhvKPPbC7/J
 Jt9u71MoI2OQkAAxRVQ7WMSjV+X3G2WuHrk+rqgg/zB3UTSm310Gzr9BGnktKpHepXgs
 czGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhLrlZJV3rR1dH/A0S0GadrAdbpYghPgNwp2rRJuv/RB3DutpS8RMklwC7MUSMxVnijL3pFXR/KYFS@nongnu.org
X-Gm-Message-State: AOJu0YyGS98DPUr/C5ag2tCUR0cc8Kx5STQhtQ3E/kjYpdym2xpRT0mB
 //VbdBby/xY8vANoBBK5Uo+nyk+Bsyd9yGTORVhCajLYqrs7Ws/lMRf5bfNy08KRY1Q=
X-Gm-Gg: AY/fxX7G056PKZ1JaqbLYaEj7coB0fig/wHxGAJFZ8WDJeZFo8OeFyuUZs0y6GQY2T+
 SfrqWzylsie2hSHqhVaDx2/GtyIkjic6RaunGXlS1UcTDr4lhQbyTyBXfkso+Pgac1uk1TTE3iy
 lBaZrb+5asOK6TIhySqdVwsPUMMPnjT93CMjZYl8Q94NycFQOncMqbdzGxoWPGu92Pnw7RgfWAu
 NTBFLIplBJv2O330cdu/yPFx3zqLUDTp6gIlbLhuijfjAHhSKyja7PcaQgwF2zXxO9LsvcOQXY3
 ZRjYXBEkJz4BCymyrDDP1ExQWa6snBnxsVN3qM3uFZUOWSN04v8Gm3f7+0tsVdCJPeSqZ7rBi1N
 sIpwakvlWuXHwohlxuez8unCmWBST0lwhh4txFhvng7Wid4+pnD8IGopd+wMbN1xgi4TRtvXQLR
 0Tn9eaVxJiLA3MiJyhvgy6mvuHVI5T18z0zxXBgGWa1K2By9nuUxEcvg==
X-Google-Smtp-Source: AGHT+IH4IWbFZk7IrJhZlRefLkfOKtcy+u+NdT1bqFrc8PXkXjmauIZS4kiyY8P1znrZRpHQnIRLFQ==
X-Received: by 2002:a05:600c:45c7:b0:477:994b:dbb8 with SMTP id
 5b1f17b1804b1-47d84b2cf22mr100571985e9.11.1767944624635; 
 Thu, 08 Jan 2026 23:43:44 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86641e99sm55810895e9.7.2026.01.08.23.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:43:44 -0800 (PST)
Message-ID: <9615a5b5-36f6-473c-977c-1ff011da4d8e@linaro.org>
Date: Fri, 9 Jan 2026 08:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/29] target/arm/arm-qmp-cmds.c: make compilation unit
 common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-5-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-5-pierrick.bouvier@linaro.org>
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> Move gic_cap_kvm_probe to target/arm/kvm.c to remove #ifdef CONFIG_KVM.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/kvm_arm.h      |  3 +++
>   target/arm/arm-qmp-cmds.c | 25 +------------------------
>   target/arm/kvm-stub.c     |  5 +++++
>   target/arm/kvm.c          | 21 +++++++++++++++++++++
>   target/arm/meson.build    |  2 +-
>   5 files changed, 31 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


