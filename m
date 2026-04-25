Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E6FF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 06:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGWtM-0005sa-Rv; Sat, 25 Apr 2026 02:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wGWtD-0005rh-SH
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 02:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wGWtC-0005w5-39
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 02:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777099996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TXhkLMwpAzzjoRQ5wAmL6QhukTn8uYR1etajkAh+1G8=;
 b=jPdUkUlRyREUWq5CuUnuXoO8YN2yHrBQHtAhLLr/yn3AI8upQDlAizx/HGlF8gfeW/SwRb
 n7MTHy/pSWLjTZ9hPu0+pMIFhZtM0Y4OiD+RqrXTgh1UflJTvc8gvVjoWMMTWCtopQwd0J
 CHeuem6jA7HxriA6TnXarCtNe8GV75U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-rvROsG1KN62pZq1B3C2Nag-1; Sat, 25 Apr 2026 02:53:15 -0400
X-MC-Unique: rvROsG1KN62pZq1B3C2Nag-1
X-Mimecast-MFC-AGG-ID: rvROsG1KN62pZq1B3C2Nag_1777099994
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so75742405e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777099994; x=1777704794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TXhkLMwpAzzjoRQ5wAmL6QhukTn8uYR1etajkAh+1G8=;
 b=XstcL8ztazdXVKyDTQ7cGYcSXuok2YU4Zkoyzz1c73BqYaIhHqmTT4gK/cKruB1wtz
 0YLfV/cGpA542w2KakStv2WpIPQG1ZM30gmw0WugPB9LTKYPYmziitUcu6dqs+ULREsH
 /4YvRL/bgyBTwlgX8mmir0GFh8baOw1ZKTjBeYH2NJb2oQgoi8+fCJbuokMGq0nweWgd
 bg5y2c2USGBQFNISAsWNG5Qt53h0WgK0pp5JNsJit/SOEf0eiJk+rKUMfoeR4ag3I2Gn
 LOJL63ycDP7aVis1+Vy2GDuR25ezGnyitYEOCjBGVLY77cZ+iNRkwK7kGn/tuYNkhvXk
 owow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777099994; x=1777704794;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXhkLMwpAzzjoRQ5wAmL6QhukTn8uYR1etajkAh+1G8=;
 b=kfiw63skeGIZ+cq15SJsUr2zLMG+i7/bk5S956ivzPD6WpYq0N6qCdU2EZbw4PqHqF
 uD6OnT3n4FwIHj+gaOkH1Gjf14qeSefe6TTIN4N8UIvW4rAcukIcrSWmwIFLlC4f+3ua
 Quhb5Vfxr1dGZK/8JIzeTbWzJzI/F93Bs5I27NC8xJC0+AI/e9CXzG9zaJAtD44sR6wk
 hlqaLC+qfiWRrosutRLByj/xR1OYFlFxCrvkMsPHEImyGIFgUmY2yAxo0Zr4aAZ/PTCU
 Uvb0G8jvd++EKS2c2jl4poN1rlXm2BiCgqbBPS16314TOYNsTqyeHbl372id38eKm/hY
 yaqw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eOUd+lWbHATIL5OUt54mqa7n1sz4IaEHIStC+LsiOwnKrJw8NOfR5EFkarMPopyQtAwYF0Mq/Lzyr@nongnu.org
X-Gm-Message-State: AOJu0YyAsLJud2feVDfLITnqU8Dvckp3obc980m3PG4R3CkTKSkoIY4S
 zaibjEdztIn5btYfcw83e1fVnb0F+aRGoLAuJOeKQvElP/DEa11GWPYf6u9MhqilH0MUaB1og6X
 kWjw0+sk2jX5x27AXFmJWEU+aMTHasZIDjFMtTB7lurMB6Mf7smAm3jWA
X-Gm-Gg: AeBDiesXJJboyn81liHP0aSEeRqVygiSNrxSAcBFkanbwvbB/IUILvFUnjqgNB6rF6o
 8sddazBzIvPENgKqVKEkQzfVJOf3phM/n/1JdFdFGT/tfrt+yQs5RIuw1s/qXIRghQ7i2jJh/s6
 65Bn5y5r6zpyk5aCEjjOrTF/vKo7KzmslaFOiabsG4Sb7Rh4E4omOZ/qlyVQTHlJBovrbUzxA50
 XjPEwdt6o6+rTcLu1+Mr0svLj32xaKrMGh5iafJ80s7gT6HClcq4C/7L1so88O684MdhUY8Go/d
 XelMXs7yBct8pOseSNX9+Y7ag/xa9zi/bgFHyKLdSYzbxwhniVBre5/y8j8/TEPV/B186Q3c2A3
 7iX1KHXPlCO+K1C+vH8taFxG/Fd5LhQ==
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-488fb782d91mr527731605e9.21.1777099993909; 
 Fri, 24 Apr 2026 23:53:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:488:7ff6:1f75 with SMTP id
 5b1f17b1804b1-488fb782d91mr527731335e9.21.1777099993479; 
 Fri, 24 Apr 2026 23:53:13 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891978ef6bsm200659275e9.4.2026.04.24.23.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 23:53:12 -0700 (PDT)
Message-ID: <5cad3b14-e2c7-4644-981f-88f44e1d71aa@redhat.com>
Date: Sat, 25 Apr 2026 08:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] gitlab: remove I/O tests from build-tcg-disabled job
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-17-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260424154205.364268-17-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/04/2026 17.42, Daniel P. Berrangé wrote:
> Now that we have dedicated CI jobs for running I/O tests on each
> supported format/protocol, we no longer need to special case a
> run of a hand picked set of tests in the build-tcg-disabled job.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/buildtest.yml | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index d4591d30e9..710dfbcc77 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -446,15 +446,6 @@ build-tcg-disabled:
>       - make -j"$JOBS"
>       - make check-unit
>       - make check-qapi-schema
> -    - ./run tests/qemu-iotests/check -raw 001 002 003 004 005 008 009
> -            010 011 012 021 025 032 033 048 052 063 077 086 101 104 106
> -            113 148 150 151 152 157 159 160 163 170 171 184 192 194 208
> -            221 226 227 236 253 277 image-fleecing
> -    - ./run tests/qemu-iotests/check -qcow2 028 051 056 057 058 065 068
> -            082 085 091 095 096 102 122 124 132 139 142 144 145 151 152
> -            155 157 165 194 196 200 202 208 209 216 218 227 234 246 247
> -            248 250 254 255 257 258 260 261 262 263 264 270 272 273 277
> -            279 image-fleecing
>       - make distclean
>   
>   build-user:

Reviewed-by: Thomas Huth <thuth@redhat.com>


