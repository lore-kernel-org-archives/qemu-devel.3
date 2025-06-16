Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86517C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR26o-0000KB-Uy; Mon, 16 Jun 2025 01:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR26h-0000FC-NL
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:10:07 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR26g-0003eS-2c
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:10:07 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so45162705e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750050604; x=1750655404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3Pb09QRezOqh74pvUD+Nx4AuD9S8qvfhDsxnfBPdZA=;
 b=hHYf1kNHYmxXrEPxDeJj6dx6oc3O5vzT9jeGLzBcYb3nWrYN26CjfunXjkpPBiojDs
 If65qiUkSkQq7o31LTm4I/TQhCxZRP0zImNRu5BuMrlHLb82YM/0oDcnCmw+UF5MfEYX
 BZMLM/hHoBVWC0wfu1zciL1OVQ+oleva6vCz9O3uEHa3ZFDUG1TF6W9lgsOT7102g7GH
 G+dMmv9s6VzlzR/Ip1zaYrbJ5BezXyU9mEwybIFNdtxwlMWilWUHwsLpO8K4mjU+1whC
 n6A0I6zyd/1KSVCcLMLAlxqE4scgkUOjHHT97UJNBY9KDNilpibUKkV/wmUznsxZLtrN
 jYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750050604; x=1750655404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N3Pb09QRezOqh74pvUD+Nx4AuD9S8qvfhDsxnfBPdZA=;
 b=NGQrF/IZw4aJBSt5W0Op9mEm5CyNgyVCQVYGAOqwdp61wIcU5YLNGwv6weVdEZSSTa
 EHyEMUN0NEW389V3P6VIZT+A0ta8BLyKDipUjq88DFr55jrz9UuovJQtoWGHfzST6GSH
 9go5Lqr5DECkr0a1a2dXmRQ/rAYWHRRdmMjLlGtGhmMTE6WUqk2SjjKymqcs1zVyp2T/
 aUYnCMjxhS3sOiUEEUy5elW3V+JdD2iFKd/0GyDmMN0Q5GSSNyQ59841rRqfz9x9Z9gy
 O+PPvaACf/AWOCnuYhpYzGgpDYS9qr/lEWspd9JcxqXBFrDHjAQ3lWZk4h58iljG12rE
 5RyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKRbw/9A5+C2PIpo8tKlJHgVRPEIzVs/hTaCtOwXWWWWRiKJLwJEUlV6Uh7wcouKJazQjlI67KPKeh@nongnu.org
X-Gm-Message-State: AOJu0YztkunR6JWGZdpOj9t0P3B3GZCd21CyEkpoCIu27Fr8xz8E5OlH
 U6Q6i4UYXt4x2tic1zX/TPsBNwjmCQUy5Wi0kv/cSOwPt/wozo6gk5dOULogKWwepRidc40OP+7
 4+Tmvdig=
X-Gm-Gg: ASbGnctE+uNb2Rj92UZX91E2iCU3UXOQEiAhm7SOTSOJnktJEIx726Qbm7T3hXYm7X6
 dgZpieFnzoIF46Cyd/saSUTCrPBpRmPOk52mkN7Q+ZKOJdx55SgdzjfvH6ab7pZYLjB9V9uavdi
 WcXFP2zETss69NdH02m7qZVcwlgXb77FTBYxV0yj8aYvaYmnR+sx6wmJRlOMEI8Gb2S2SWDt7ii
 MsjtLejLNi+o5p3GR6Z8nId33m2fOmofDC12sfx0L/8F5YpIXU8E8CymzQiHE815rm/igumgtyg
 eMzc7k5ixhMRxgw8PjHwx5iC2ngNQBZEnlWOPzbGsMiINcPLksksFaCgXV/WLVQVhhgof5kmM+3
 zb575kdo6pjOm41+5zDOP52FmHOpR/w==
X-Google-Smtp-Source: AGHT+IEzdxrm0R8Ij7DYRJ9982k8devAZJPjqjGDWKX/XQllYVLaRqIk0mHk3fbD48RU+nKdkqc3tw==
X-Received: by 2002:a05:600c:674a:b0:453:dda:a52e with SMTP id
 5b1f17b1804b1-4533cad28b6mr64764705e9.33.1750050604536; 
 Sun, 15 Jun 2025 22:10:04 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e256b95sm134317515e9.30.2025.06.15.22.10.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:10:04 -0700 (PDT)
Message-ID: <476eed49-bb19-41e5-842d-7a69e971067b@linaro.org>
Date: Mon, 16 Jun 2025 07:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fsdev/9p-marshal: move G_GNUC_PRINTF to header
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
References: <20250613.qemu.9p@sean.taipei> <20250613.qemu.9p.01@sean.taipei>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250613.qemu.9p.01@sean.taipei>
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

On 14/6/25 04:08, Sean Wei wrote:
> v9fs_string_sprintf() is annotated with G_GNUC_PRINTF(2, 3) in
> 9p-marshal.c, but the prototype in fsdev/9p-marshal.h is missing the
> attribute, so callers that include only the header do not get format
> checking.
> 
> Move the annotation to the header and delete the duplicate in the
> source file. No behavior change.
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   fsdev/9p-marshal.c | 3 +--
>   fsdev/9p-marshal.h | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


