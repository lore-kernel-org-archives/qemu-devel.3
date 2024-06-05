Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232E6C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 06:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEjnb-0007uo-Cx; Wed, 05 Jun 2024 02:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sEjnZ-0007tq-C0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sEjnX-0000EK-Ph
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 02:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717567618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4bfhLrQ/uip2L0IrRikn1dd5SD9XBOyv+RolHsnUq0=;
 b=NCyqXuwl6AQzRHN8mGWd6uW/fgz0i59so0VASXujOpUNJslGYHtFr4UtqBLIsg31VN0GMt
 tBmxTkuEnr4gQYd1TbDHTjv+mT//ru9ijwPrQe+WTTqlFeGPMPmm2xsfRRPifbIooIvWfn
 a99Ddq5dRNQ636rkuGeSf6LqU++D0AQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-u9kKswQSNh-amaYEN43Ysg-1; Wed, 05 Jun 2024 02:06:55 -0400
X-MC-Unique: u9kKswQSNh-amaYEN43Ysg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2eaa9f99958so13345841fa.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 23:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717567614; x=1718172414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c4bfhLrQ/uip2L0IrRikn1dd5SD9XBOyv+RolHsnUq0=;
 b=By+XvQc8wjpEhv1QB3fhNgFZhtpc8Lt2tmC6QG/E4iqzwkq3ZY7I2jtb3QN4aJFj3t
 s0pfcDqAGIfgadvILKpVC1M0Rp0EKjax3IzEBOj53diF5bzBKtPHoFNAH8JfGcjDSYiX
 Dvwx9+JiCSiCv9zkeW2VgtT820XCGG4Ut6lPT5nY8vL99fMOahqfxYUJBONd9KjeNNyS
 FVaOri0BJHd2mluzaGrMcEJ08+hv3ut+CI5T9N09zF8nJ6foP0cmb9I+KaSnPjHig3Fh
 egkxumcEKktyLsTmmyf9HScoMldveDJ/uv4sRpQmrcDYE8BVns1vtgEnrN+dxDeXFLHH
 ysIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyQV26kCfvbCnML04eBNkJG2znOc483M28nM42Bfa1juhllZU6Aw/iBdCP52kSGxAuwDymXl7/2Qu13JulLoeV1PqxWW0=
X-Gm-Message-State: AOJu0YwToDDJCoJdP+a6vyqq+XR+hwXHimkjtPiABNX3fwVn/TIb236L
 h8RN5ZVk0hJ8QI4S7fWK/Di12bOPS0eH5/oqKLWTtr1U9pG472do29VjbwBGr0fMml/D5CP064P
 UpuQHrdfXVWGFFtJ/BKANgUaUkdK6d9idJ/XpLfRcCwM+wx0//jUV
X-Received: by 2002:a2e:904b:0:b0:2ea:8abf:3a62 with SMTP id
 38308e7fff4ca-2eac7aadaa2mr6612971fa.51.1717567614205; 
 Tue, 04 Jun 2024 23:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEur4LBm2IB+OynHKTrmHYkNBm47r8x+PdxdhpsAbhhtFmaHala8NLp0CTP6YpOG4vyt5dieQ==
X-Received: by 2002:a2e:904b:0:b0:2ea:8abf:3a62 with SMTP id
 38308e7fff4ca-2eac7aadaa2mr6612771fa.51.1717567613798; 
 Tue, 04 Jun 2024 23:06:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421580fe3cfsm7989315e9.9.2024.06.04.23.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 23:06:53 -0700 (PDT)
Message-ID: <1e041dd1-4298-4607-9aba-1996022e6431@redhat.com>
Date: Wed, 5 Jun 2024 08:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add reviewers for ASPEED BMCs
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: steven_lee@aspeedtech.com, troy_lee@aspeedtech.com
References: <20240605060310.1946803-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240605060310.1946803-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/5/24 08:03, Jamin Lin wrote:
> Add ASPEED members "Steven Lee", "Troy Lee" and "Jamin Lin"
> to be reviewers of ASPEED BMCs.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 951556224a..0f63bcdc7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1158,6 +1158,9 @@ F: docs/system/arm/emcraft-sf2.rst
>   ASPEED BMCs
>   M: Cédric Le Goater <clg@kaod.org>
>   M: Peter Maydell <peter.maydell@linaro.org>
> +R: Steven Lee <steven_lee@aspeedtech.com>
> +R: Troy Lee <leetroy@gmail.com>
> +R: Jamin Lin <jamin_lin@aspeedtech.com>
>   R: Andrew Jeffery <andrew@codeconstruct.com.au>
>   R: Joel Stanley <joel@jms.id.au>
>   L: qemu-arm@nongnu.org


