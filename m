Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853CEE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLTeu-0000kV-Cz; Wed, 11 Dec 2024 15:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLTet-0000k7-Oe
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:50:11 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLTes-0008RB-4h
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:50:11 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-29f88004a92so2816864fac.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733950208; x=1734555008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AT2ErS5F2KlqM9vcZQKioZ12NuStd5AkCEXeMUEZnTc=;
 b=m22qhkY/nTWBwvJJP0qJ47h7HMgBJF/LmacTME9oouIDUgnRaBMtqRE724kLhLQk4s
 6/M8F0I9gwjQx3N/OYH2onlqPl+Po2i1BqoTF0k2iMpfwmHEwxUTNdTstYUHbPuKcwEx
 cBGDS0pEAnhXItnBbGABs2tSFkGC1QatfU7gsTgdlDOV4cTsivdBeSOlrOE7wT3Xi3rS
 O62GDDeiUY0uJdfNgYnIVvj0JWWnHq5Ft25GF0QtxIsmwKmuqw9XapI9kG16rzkMJbjr
 AADN9bMOmGc97MVehEU955caaz+/4PbJDBSrDhJe83+PFf/72Q/1rnfA5Rs1BWbtEh5k
 mbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733950208; x=1734555008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AT2ErS5F2KlqM9vcZQKioZ12NuStd5AkCEXeMUEZnTc=;
 b=pRFSo4wMngyTpdETO23+GH/vz0qahtRCcx/3MEcrROSjgDBYnU6CHFNEOdWn6KXwIt
 4AgTyUOXXihWRK4xwH5RcU6ZkbxjoBjjPEQfg9TvPG0wpxmUOjLlVyfM9oDjSNoq8Nj7
 NBggYn/NWJZDzk3cKidn4WM0a+n9BWW0itQDulSvICEMfoz3Bftfggxf7NTdjDYhrmpD
 QGp5Hl07AYgwSF/Y9plEOXh6TaMCclerm9xYMGYgW4D6RimEykA7DuE71hrJjsrmRRLH
 89AMM0VL65PSdjv1JVCfwkAnTHAlNVt4fcqBURJq3ie5uq0uIdxVeg/2PKuFVQTxILsD
 3ZOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0+/O61A3BqBbwREtvUBo6tV8pLpOTuXTB3ZCxo8CMbzWkdrCZJqWvMJPmAtzEXEs1VmBTPs6Yg/6c@nongnu.org
X-Gm-Message-State: AOJu0YxMkd8v61vAhhDo+MfQelmgwl0Jr19wQW6P1chGctHtAy++CzZs
 OST/LpkO/d4dDPy99z2+T9dYYMmNx15XflHykWigS1Mpk6YiP8BXn2W7u5A/yRE=
X-Gm-Gg: ASbGncvlOCFtgNf30ZuaOxy3IkElILROCghiLyvyvsOLtDxznoSDwQAYwGBcDJ2c8AP
 wUsulOdHey4VPECmEpMJTKOWVUDJhNN8t94X7EP7KLd9TZDNDSKsG44NZRGaD/oWCYAMsg6b55h
 KBu/8gq2HnlND32rDb4qXzXW/FuLsLQpJMqW9s2VsqZkN6M/72aHYd2xR1i0v1nDP/5Hlz8bY3T
 wF7eEkYdQvN5X7Um7jSwHx/U9n+QKilbpKWbJRTDIxx+wrv3i+9LfeHhBu7HbJ+xl3DyuEmcmWq
 dII2jt8EYECJRnW5f+5a+Gy3iDHEEwvg
X-Google-Smtp-Source: AGHT+IGK6gkPQz9z7CkDiz6fhQ5Jo+mzinn7xqlIKNKsCgRyzE2qtRQyimjZMJySvl6jgvNQOIuZXw==
X-Received: by 2002:a05:6870:440c:b0:29e:4c80:422c with SMTP id
 586e51a60fabf-2a012d1b85dmr2096540fac.34.1733950208641; 
 Wed, 11 Dec 2024 12:50:08 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f5677528bsm4024250fac.28.2024.12.11.12.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 12:50:08 -0800 (PST)
Message-ID: <0670aff1-5dfb-425e-97d6-64e8e2826f62@linaro.org>
Date: Wed, 11 Dec 2024 14:50:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/31] tests/functional: simplify 'which' implementation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-5-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211172648.2893097-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

On 12/11/24 11:26, Daniel P. Berrangé wrote:
> The 'access' check implies the file exists.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/cmd.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index 4106f1ee7c..600e0509db 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -25,7 +25,7 @@ def which(tool):
>       paths=os.getenv('PATH')
>       for p in paths.split(os.path.pathsep):
>           p = os.path.join(p, tool)
> -        if os.path.exists(p) and os.access(p, os.X_OK):
> +        if os.access(p, os.X_OK):
>               return p
>       return None
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

