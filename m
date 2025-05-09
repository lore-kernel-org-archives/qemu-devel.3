Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C6EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 16:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDQEm-0000wy-Jy; Fri, 09 May 2025 12:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uDQEi-0000w9-PI
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:06:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uDQEe-0004qe-Jq
 for qemu-devel@nongnu.org; Fri, 09 May 2025 12:06:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so2488766b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746806763; x=1747411563; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z2yaJ0pL1euNiCnTksE7VBIOgOUtO//eXIA50dSUXMY=;
 b=ZtFOL3BGEXom1hskJkVQx39UYBqqvZB/nB+Tpwe1d414RJ+0+L+qTgiu3kyrTYzy2D
 dt+6rTon9ot15CRl0vQx9iiq2NqqGs49KCRdfUXxQ03l5S8DRuJjmMu7pWAjDIiZxDI0
 2SjE6nmpKHjwqDwMF3nb5ZdFdq93rG2EJTdvkTv/ko37EW0bdq7zjvmv0r2uQm2oBkR5
 pyvtjfMxrI8uBjjnOWCN/p0+/LIlbhwcNeX2VtYaOe7KVZJBO5GMuR7kmnCbNLxSEScZ
 hiOCvMx4cw8VFjNKi19wEj7q+dD1sGlKrNUlob5w3kp6OhcAXhycFaGgTEHDbGFKr55q
 LgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746806763; x=1747411563;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z2yaJ0pL1euNiCnTksE7VBIOgOUtO//eXIA50dSUXMY=;
 b=GwAxCRevlZ4LFo5WrOumwn9jh9gsNUUyJUvRsO8sH8LwnngTAsRSRbGFP4xgyWEJNb
 +K90UB2Ob3VOQtkANwMTqWGnZwrFkhEm3PRZt5zr4AXYPBA/A+SVODNG78m1eLltgEQX
 YK3aVmfF+UvMX1WAHBPpZyKU7U841ETdgHQLJmmzVYiODhBmY7M0bY6n/RnNIwciokxX
 /mhsjJlw1J2xTKpaRCEbMgYHOx5eUo1J/dg4daWg0s+Xb3i+7tEvcs/MDrZhyg1h9l2W
 QM44SfIowTVWpRVMHaKiOYvwuqiwwQu0BTro97Irl4IvVFEeJujoYmLKJJDruBL9+u3u
 uPrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDASHrwbeaDO3onywDKH7UOxiNo5Ym1aHPym2qg9ewTgi9DS00whsLcsUpiqsUIJyRNdlSUVoVh0lQ@nongnu.org
X-Gm-Message-State: AOJu0YxYcqVH0dAa92/c5g6sy2BzDXVRDmvkka0P+8Q3I7hDwYrhl5x/
 UTZDtIaA8DcSkQHnq+i/VJKtwWMfbSbM2oWHQw7qqqdLuoTUXhJurpQ7BAdGPr0=
X-Gm-Gg: ASbGncsPKweUCdn1WbvYuzxjPuGFtUG/8h3q8F41qBZYhXC6/6Ozlrw3d+gpFUbecA8
 L3LGxeGP6cDMeHpKzGnyavZb8aoAcDS3wz4MkPPeK4/A2S6sXw8r+JvliOq00yHunsdRW8wEJ2F
 tkmVykZTdiatZ8rBzFQ5rCKGAE1cLc0yy/DxbLubgRKtpmpHBiaEAMSW0qeER9blc+rLIRoccCM
 gIOOoLOUtUl8CSGPlZpUZkIUApm9Ljz3bDK8Q0EnadETi6/gYh0a+knuJ2I0hQfaYz3iASm89Fl
 U9WNRcKoyW2BAizWFyQUSp/ffzPoAY35d42QMGWrCLcRgXHHUUKx26P2T2Fl9amm
X-Google-Smtp-Source: AGHT+IGVaYiYkBCQy3tKe8x23JzS3yULFypnRuQB8p4VFgsFpyIcmLI7flQI2deeUzwmWKondGrfsw==
X-Received: by 2002:a05:6a00:ac0a:b0:736:31cf:2590 with SMTP id
 d2e1a72fcca58-7423bfeb4admr4885086b3a.16.1746806762877; 
 Fri, 09 May 2025 09:06:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7423770424bsm1904236b3a.30.2025.05.09.09.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 09:06:02 -0700 (PDT)
Message-ID: <61a8993b-b976-4840-af96-5df583db1cfc@linaro.org>
Date: Fri, 9 May 2025 09:06:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] semihosting/uaccess: Compile once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250509110721.90447-1-philmd@linaro.org>
 <20250509110721.90447-3-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250509110721.90447-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

Hi Philippe,

On 5/9/25 4:07 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   semihosting/meson.build | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/semihosting/meson.build b/semihosting/meson.build
> index f3d38dda91d..d0819891bc3 100644
> --- a/semihosting/meson.build
> +++ b/semihosting/meson.build
> @@ -3,9 +3,7 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>     'syscalls.c',
>   ))
>   
> -specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
> -  'uaccess.c',
> -))
> +system_ss.add(when: 'CONFIG_TCG', if_true: files('uaccess.c'))
>   
>   common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
>   user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))

It doesn't compile applied on master [1].

Does it compile on your side?
If yes, could you include the additional patches allowing you to get rid 
of CONFIG_USER_ONLY in included headers?

My previous answer on v1 was giving a solution, and an associated meson 
patch. In case we can't remove CONFIG_USER_ONLY from the headers 
included, it's the only possible solution I still see today.

[1] 
https://github.com/pbo-linaro/qemu-ci/actions/runs/14927715244/job/41936282521

Regards,
Pierrick

