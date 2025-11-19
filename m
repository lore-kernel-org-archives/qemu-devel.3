Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07866CF256B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 09:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLeLs-0005vv-NH; Wed, 19 Nov 2025 04:19:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLeLq-0005vf-JA
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLeLn-0000XR-G7
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 04:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763543978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7U1mz7xDFpvdIm55OpDuGdDJdvQZIJLlaAcwifW7MDo=;
 b=Cb2JEpJtC0mVX9TWhHrv+AAujDetlIWlc4S1+h2svxuqhER2BZd0R/KDGuzF1G74T/JB+K
 FciGqm6mirrXI7Ns6qXrYfoP2pnpfM/4U/nQkKK8fL+nsRSErFwTuBg2o44/ObaxGrM5LG
 D6vYb31LsNXf+5H4V+Ey/D+tGg6cuF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-R43aCrx5PpiKWEgNOxFuDQ-1; Wed, 19 Nov 2025 04:19:35 -0500
X-MC-Unique: R43aCrx5PpiKWEgNOxFuDQ-1
X-Mimecast-MFC-AGG-ID: R43aCrx5PpiKWEgNOxFuDQ_1763543975
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so31115565e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763543974; x=1764148774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7U1mz7xDFpvdIm55OpDuGdDJdvQZIJLlaAcwifW7MDo=;
 b=GMl/zcdMJ+YTby42rjikcYug44iBhfXT62ASqLIhqeA/ZQTxQecFVT+PDTUTU0TKzY
 5pWv6UurXDM3mZ1l3ymKdK0LGhDR3682GGTuqmbCZ9N9+DikTmSvi+9pTjgFvBixzEIe
 jr9K9LXczV4ZvKm9xh3lXb+YVOVZB0ebSrEwFOh2iSlS3wM3Y8axIhFWLcuqckN514vz
 PN00Cz0h+ItvPQuSRKHpLCeB3mZiQvJsyn1LYROvPMIP9wUHFABQ1x60fr4rksNz+Tlx
 giPUiQtPtf3rk1mT5/XPOtl359Q1+1RPEhfhIiiXYDiGZJL6pPyXPo8uSg5xNRuqmiqZ
 C0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763543974; x=1764148774;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7U1mz7xDFpvdIm55OpDuGdDJdvQZIJLlaAcwifW7MDo=;
 b=Bn4Xlmn1oRKyTk2nwQbHVD33O+98VU2PqylsmpLrq2pk2ka2gkgNUknv/JMGikfrGg
 81M4o16HEAn/rAZtRyr5BLZ9jDPdxtr1z601vOx7wBQR2mouqL5/O7TMKNwwKh1MfBJ5
 fA2EdOgXNFbhW+xf+HbmDte7wZb37G1p92O9mcVVGKOrwVLYSyYhGy6JDS3it5J4tHk3
 glHjIB/GvwH5/wDbHUuuqfw/vrLKXgqmlKZygj7qEHtMOcfBFKT3okyJYRl2r6bfvedx
 7m6vyuvkKoU3XmwiohDdbXxTNmvXRbRCzAEkxr6oGh6EwyZcMDPBMarxXi6HAftlkMWz
 KNlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg+hlFTTmPPuTERLK3s/NmW/XDCAAsovsyB++vvaC9pu8S2xnd+cMC3EylZ0xY7NVncSLJCb9Omep3@nongnu.org
X-Gm-Message-State: AOJu0Yy6aXSUAScVoyH4vrj5SD9nb3/FVthcZaSKExPiHlmtVyfAIDUK
 /jMBJy2e5fGndqsWsiJUcJYRaj4sOOgZ54JBwrxkok8KjcigtIbirXBAPoXlnXRex9lZOImISF4
 xSjtay4NLITu6+oJY7PZBgZWyRc8BYEFXoCHwoeXGFgKV8PETf4M8OoiQ
X-Gm-Gg: ASbGncucovgbBDsiFg6Rk28xeVuuqv4RNCw+fQiwgbMrhxnH8uiYIuGK64eeqEd3vct
 muRMjgKgUIDvrlNNUES9Z/XySuMQixfN5NxwiYolFydHJYnXbLDYHY6IChbReWfc5fnu3ThxHSF
 RElWZASZKssvmmqs2xHImvOIOeP5/oGjdPv+Szvmr0nfKQltWV7dhabOlNmvuvSg609l/qv9neN
 dbwAOLKjJIudeIXcvcz+BvKDRsb/N24zeTdHLntJxy6e8Ze4mxjd/szK+/oY9sPNzcniPu/UKjD
 Pnwr2Pfw/IogKqwo3JRatoIrVGK+1p4f71HAOLA4503NsZP7wef6KHL6YAGDjPY5BVo1dCc0uss
 laMwXeZkmIpwTqKTaOE/MjODu0bQ3A+4W0LU=
X-Received: by 2002:a05:600c:138d:b0:477:7cac:508d with SMTP id
 5b1f17b1804b1-4778fe5e947mr217302535e9.16.1763543974644; 
 Wed, 19 Nov 2025 01:19:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXgPKBAnXoem4unqeoa9rEMbWRqnAoNGVosOX1/0vffC6wc0Yn33jEp9YW9EeXLZtn0jirVQ==
X-Received: by 2002:a05:600c:138d:b0:477:7cac:508d with SMTP id
 5b1f17b1804b1-4778fe5e947mr217302215e9.16.1763543974266; 
 Wed, 19 Nov 2025 01:19:34 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1025707sm36601165e9.6.2025.11.19.01.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 01:19:33 -0800 (PST)
Message-ID: <a3b2509d-fa97-4627-ab88-7e0175c6bae1@redhat.com>
Date: Wed, 19 Nov 2025 10:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] python/mkvenv: bump 'qemu.qmp' dependency for
 testdeps
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-6-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> First up, use the newest v0.0.5 instead of the older v0.0.3.
> 
> Secondly, the use of a period in the key name does not behave as
> expected when installing and checking for dependencies, so quote this
> string instead.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index 98e99e79005..1657953ff65 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -32,5 +32,5 @@ sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
>   [testdeps]
> -qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
> +"qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }

Question from a still-python-ignorant: Isn't a dot in a python module name a 
bad idea after all? I mean if at one point in time, the "qemu" module comes 
to live and also contains a "qmp" submodule, isn't this calling for trouble?

Maybe it would be a good point in time now to start populating 
https://pypi.org/project/qemu instead?

  Thomas


