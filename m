Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F5AD2E009
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRP40-00036p-DR; Fri, 05 Dec 2025 01:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRP3z-00036h-1y
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRP3x-0006UA-OI
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764915184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=y/ioC6v0fitr+9bI0+I28I1WU7k34dOzlA4FfhqAZHY=;
 b=X8C53/Z1CPJSWivHBTgw3rYL6EYyBJYsTyJ7lLddde/Lzby9hNDvNMiKKxGyp7azxf8Or8
 wePfpYVVnkS1mAuuvbS9nojKXx7sWXLmh4b4wSDGsZ/LgDuWdwJ8DtjsVozMrkreq1Hq3R
 a84bT95MnSKH3Mrvwm7efHE7fAIiyks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ooyHxl67P5eMuo_a3UQbEg-1; Fri, 05 Dec 2025 01:13:03 -0500
X-MC-Unique: ooyHxl67P5eMuo_a3UQbEg-1
X-Mimecast-MFC-AGG-ID: ooyHxl67P5eMuo_a3UQbEg_1764915182
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a0ddd1d4so8720585e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 22:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764915182; x=1765519982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=y/ioC6v0fitr+9bI0+I28I1WU7k34dOzlA4FfhqAZHY=;
 b=M9eO768yACWnaRbwazoUO6JA/J1ZWulfC+9gIUonlTv3WaAm9W+vwjfaIqh/Ms2RqV
 +miTC4JtM4AAZnhhLN/hNsiSb5JBaxWnE3Bf43f74p5Opp/41T8/Hwxwyvb1aJXDlZLx
 QunLR8HnV1lXAMWyMX79iVcZSOvMZNC9LOGE8sq6QE9yl0Ch3ZOI+5Mn49UTPX3iMqPH
 t8fyURnXi+Im7odJQ7ibp4jq5HPcRNDzZY6q4nRmIFqlwxBUYKtOvDK57U9raO/J4KxB
 Wc/s8chpLlzstFTtzl3GRgSU88FnTeJgoY5UhE1YF+MPpE/wW2/s0hG/pVSNBgOa0yEk
 wfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764915182; x=1765519982;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/ioC6v0fitr+9bI0+I28I1WU7k34dOzlA4FfhqAZHY=;
 b=R6c5THjitVY2Q/65ypwHUJsGoYXubH6c+SUvw9LtSkP7iLYA8HfB8mDWQcC3+MIqpf
 MUVcnkkzgnGo64sOD21A+k8hN9YAkx8KKeGjYMGIGy4zD+MuT1+fuFF58XYjgOv9efqU
 3Rs2TF/H8bkY7HjPxFFC+eqjs0aAZZsM9jBs2zlrP9y27JBojzObkFbNGxh5L/UlvG6Y
 LfdZFz8hX8Qirj4teJVnp1fIqlU1zfGUpv6IkXxmRJMNwKPeMmXM6okWQMoKsUW3Wwif
 FmXj0VfNuEsDDHav74jEjLZf4xbb5C/QjXMgRvPrXn6loXvKAMLvEpCPGR+ZdbZpkfkq
 fGgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNZE68MSTmujMQiyFdxBHDynMFoV66+nPxBFhCwDKZ/1vNo+a1BS4po06wOmw5U23NFTL5ZKtyu8Jy@nongnu.org
X-Gm-Message-State: AOJu0YzDrAoOtArbe0j2e8iifX6Yf6kOdlZVCj4wcj99GsEA8mnUl+fK
 IHYmsobFk+gnCDjR8EBUHLrWAiEJIh3WkdcCtjBLcizPp3fkZxH8SfYwuMUMGVqf8Phy6/H+DMh
 SVaN+cCliiidyFjYqLD15f6ZaSR3NkwicbG8zcUjZ7ntvNoGAVo++AUeG
X-Gm-Gg: ASbGncvqpcuJIDdE34pV31i1evfn/gLD9w5bR6WkiDxQIfG1+sEDqE800ldoK5HZYO4
 DyUjMn93BxxndlOsSfNu9EVZLXYmIqQFn1TtvnuGpMPkdscrLNFVRGk29fzVVKc8JdsK59YCTEW
 tVt8uBBttdztOJOm3hSK8MQaeZfoZsTBb+o8jkiBmr4mbwdqd6DqOU/vfdix+GtlR7KBE4rItBF
 xdUnFl7BCe5jRXPn4IIYGV7DPcKra/sguTXgNjGETDoVbk8AgmRxT6W0CLUcy1lZ7c5hBy3YwGo
 NH3tXe/CnFzzqhQttLPdFRj05EW7QDq8IGckPVE2LNB2aUy+z8qLRK8cP8oOK/zSntIOk2Bq60m
 B7Hi+hHM=
X-Received: by 2002:a05:600c:5491:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4792af3e01bmr81422645e9.26.1764915182022; 
 Thu, 04 Dec 2025 22:13:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7NwW53FlXsElpwSx3N38/Th3fvbJNRAP0gNdZBMUjpeX1uTdGZPlfCM5cTY4HY+MhQhofvA==
X-Received: by 2002:a05:600c:5491:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-4792af3e01bmr81422395e9.26.1764915181609; 
 Thu, 04 Dec 2025 22:13:01 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b693csm63828745e9.4.2025.12.04.22.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 22:13:00 -0800 (PST)
Message-ID: <c1866333-5ee6-4a52-a0db-87a4dcf40ef1@redhat.com>
Date: Fri, 5 Dec 2025 07:12:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.2?] gitlab-ci.d/cirrus: Update the FreeBSD job to
 v14.3
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>
References: <20251204205025.2423326-1-mjt@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204205025.2423326-1-mjt@tls.msk.ru>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/12/2025 21.50, Michael Tokarev wrote:
> The FreeBSD 14.2 job fails since the image disappeared
> from the cloud.  We already bumped FreeBSD image to 14.3
> in tests/vm in c8958b7eb4 (part of v10.1.0).
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   .gitlab-ci.d/cirrus.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
> index 75b611418e..a8faaf8d08 100644
> --- a/.gitlab-ci.d/cirrus.yml
> +++ b/.gitlab-ci.d/cirrus.yml
> @@ -37,7 +37,7 @@ x64-freebsd-14-build:
>       NAME: freebsd-14
>       CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
>       CIRRUS_VM_IMAGE_SELECTOR: image_family
> -    CIRRUS_VM_IMAGE_NAME: freebsd-14-2
> +    CIRRUS_VM_IMAGE_NAME: freebsd-14-3
>       CIRRUS_VM_CPUS: 8
>       CIRRUS_VM_RAM: 8G
>       UPDATE_COMMAND: pkg update; pkg upgrade -y

Reviewed-by: Thomas Huth <thuth@redhat.com>


