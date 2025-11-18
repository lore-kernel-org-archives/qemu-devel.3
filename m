Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19512CED265
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLId0-0003vq-VC; Tue, 18 Nov 2025 05:08:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLIcy-0003vP-Lh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:08:00 -0500
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLIcv-0005rU-Hf
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:08:00 -0500
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-9490b441c3bso77154439f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763460475; x=1764065275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OqoMSfRSiGMaBYlctVk6O3Ph/aO6VH8ek256eIclBg=;
 b=SoZjhnnqjohQHA3J7mEswVibujZ50d3qxFhc87z5SX6vKvP92tMB/DhubWNkXilHno
 xi4W6XaKhjawfxIFthvcypSUx1b+ibTYmUJ4A0LezbZlYvJ7OveHZQb04alCZU7JEehH
 36fYIuRUG/5KL6VyFPNSaBRhLJ7YCkzYDnVB2kF8P2+Oykp+zoAYUfdQg9+0D3/dAdhB
 O2F98R4H/5/ZCGaT/Asfn87/+4Jy0F42sqzJKKmV0NHbKfxmhTpNP2y4+rG83Ir7HdSU
 DDYj/B3Yo/nHWIxyyEA+ST//UKDU+bnIpHS5muqxpbENBQpYIB0pinteS0x0Xzy6Nffb
 U3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763460475; x=1764065275;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9OqoMSfRSiGMaBYlctVk6O3Ph/aO6VH8ek256eIclBg=;
 b=gbnggue4Em6maQ3HXzmG1NYL6Oy/vJ7Kb44JZZtOs1aJMqD2k5M2WwrVTRuE7W3yWW
 EIxW7johkC+x+H6hHrSSM4lLWjzhKl/PcOdMIE+xe0v1HD1+WUsut8wQ/LYolNfRgVNJ
 IyrSjgB7umjcNfJUT7jazlVnViFdQTLzp7hCWxb7ZWLVLWoTl6S1vRTrikOVIDJo65RN
 hOLvHGdyRpjBMMC3uTMPlaqLUR7iHW0+aiLpQQo/gZCOqrvXHdkAhWoqA9FCZPtBks4l
 LFJfTpLqGbpOKYIhesnBcRJSbL8c6fbrBZlzQKEaiy/z4VwxBrtGVHtj95Eu55h66Xui
 A1dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYOIB8ZybyC/3eQoKHircHjDUhZjvKYLHKrtIlInBJVYhuH8SC99UERW22B1D8cVVINOVQ/ASf8FEx@nongnu.org
X-Gm-Message-State: AOJu0YxbxjUTY6m3xHZh137gzLvv7qFLZi4qbUgW+WPWES17N4G1ZMsT
 /9Uc21DatVfWR+Ko4hlRflpj/xT+GjzGSmU/HucksHa65tFoaC6bb3+psYpMUSRU6oE=
X-Gm-Gg: ASbGncuE6gUNZxrSMWaw+ClgTpDSSa7rNtQoo6YfAlCPzqn1V2XL50Otx1a1ARNGulI
 DkaflXp6e6iZrgwV6gtBSV7g22J/CS5X0zDbVWjSIzrOHSuSxfBnBnAv3W6zR+nsp9kd7BVfB6Y
 E6Hx9GCjE97tPqRQbf2dAPW7sR9COMa9cKEC80s+2qQehyo0atU28WEU1nBeQ0O6tP25Ivj7gEb
 EfykrXiciehRFwuUWCCKPZeHJi6KIMXJaJhUJN4n8byrhQgJS0OsvhulJczT/Aax44/D7INd5Vx
 OTuCs7B7N9xhM7WB/aIq/3YhR+3DoV7jtG9ckgadxo10w1hKOZ0hEnDA442tbgcYKkXEre6tvRm
 I+a2x6kpVB1y1e+kTzgbR7cpoyaUnynmUkq8QlSbvCvQRs5ahl9qMymTd4aS7/yGxFa+LM8Al1G
 NcRjbpOjhWiihjtuucFZ/mhuPb2V0igg7jyki1k5P2m1JfCXGFNyi2rwe6SUo82OWc+vG5ELobe
 flbfeMYmnElzkKP
X-Google-Smtp-Source: AGHT+IET8bj7eX974k9ENpB5hpsMrebY4Gu8A6SwDc0+lbR4YbEcMYiBa+mUKc+fa1ZfMRi6YS7Rkg==
X-Received: by 2002:a05:6638:1393:b0:5b7:aba4:ccd5 with SMTP id
 8926c6da1cb9f-5b7c9c69d91mr13165003173.5.1763460474840; 
 Tue, 18 Nov 2025 02:07:54 -0800 (PST)
Received: from [10.89.10.227] ([172.59.191.229])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7bd3171cbsm5881506173.32.2025.11.18.02.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 02:07:54 -0800 (PST)
Message-ID: <973da932-97d5-46f0-ac0e-14136720955e@linaro.org>
Date: Tue, 18 Nov 2025 11:07:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/18] testing updates for 10.2
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20251117155237.4124861-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251117155237.4124861-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd31.google.com
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

On 11/17/25 16:52, Alex Bennée wrote:
> The following changes since commit e88510fcdc13380bd4895a17d6f8a0b3a3325b85:
> 
>    Merge tag 'pull-target-arm-20251114' ofhttps://gitlab.com/pm215/qemu into staging (2025-11-14 17:59:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-171125-2
> 
> for you to fetch changes up to 8bec7b9874235e60f14172618121c60fdbd39302:
> 
>    gitlab: add a weekly container building job (2025-11-17 15:51:00 +0000)
> 
> ----------------------------------------------------------------
> testing updates for 10.2
> 
>    - fix emsdk image for podman
>    - update lcitool and clean-up ENV stanzas
>    - include coreutils for io tests
>    - move a number of assets due to linaro changes
>    - add ppc64le custom runner
>    - rationalise the gitlab custom runners with templates
>    - clean-up the custom runner rules
>    - add a scheduled container build

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

