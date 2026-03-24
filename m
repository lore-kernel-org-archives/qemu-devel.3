Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78996F54ACC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w534s-0007vR-CH; Tue, 24 Mar 2026 10:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w534m-0007uv-TM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:49:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w534h-0000sH-Nl
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774363782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=42rfXHUhkoO+9n7mi+skumEq8We0Ou5LmnwZqMb3WxM=;
 b=NEdVSBvH14BDf56nSASIW012IDPlC1X7paJlhDL8SwU57Rf3IUY0+O5qrQLB8Z6qGcx8/o
 RJ5XC2YAe155GdIqWm+eCKcZwTSW5wI4+I2CaIogPMV7NwEBPjZ5jNFLJTVD98IBPB6C59
 /61DKLf/l8wPOeO1JyiY3WPK6RGqnAM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-Dq86nfmENVqmYC0STzamcg-1; Tue, 24 Mar 2026 10:49:40 -0400
X-MC-Unique: Dq86nfmENVqmYC0STzamcg-1
X-Mimecast-MFC-AGG-ID: Dq86nfmENVqmYC0STzamcg_1774363779
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b3a675316so1150472f8f.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774363778; x=1774968578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=42rfXHUhkoO+9n7mi+skumEq8We0Ou5LmnwZqMb3WxM=;
 b=CNX1Ibm0OhhbkrQbJu7S35+NntD7Z0jY3z7WBrsMQz0E76Mjhdvu+FlaY+gSYr2bgb
 mX173Nt4qaGQFiOKqy+As2LH+3CtamWSfRvIgiEvNj4O7s+Fhc1IWxf3theL9k0grezL
 C4CVY7zaqVkaTup/m19UZF8cuUZULPlryjMGRyxEJT1+Ll+mDdXfkrekoiOa1t+E309Z
 rM32FfZCjxue//4eJR+ovWnOd7NI24xM1mx7SmwYp0dO09Ch70kztdagZq6E3ozddCg7
 NiIsM7w4kavf6QUYH/zHSwstG/FxK4mU6cmRLss0ydzWDLJCigkEUswJY0J126e14eEZ
 t5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363778; x=1774968578;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42rfXHUhkoO+9n7mi+skumEq8We0Ou5LmnwZqMb3WxM=;
 b=kIJDUiVUBo2OxUwcvQSUrt1DOy2rbWI0aJ0onSfbE1GKsG6VgRgKREauRKYL1vTP35
 YhVzFhaPejye7IhI3PvxoxXCnRas85WGldAYogr5K24A6/58p3OTtNcHEhNmi7ENUBjE
 4QyPaPVPl8EmEBVGJSZhPi7Pt4UzWENjRL8BfG928en4nso15BrSKuVLm61DXo22If4+
 sG0JeektSu8nMNXczA1uVAVYhfcgskJVNl5dXbc+B6Ota/vQ/Mu3wJ7dL8SfwVNIyfKq
 Nbqa6dKfukff3GFE8bghm8WJoK/t2DTOGvr+MxxDNkjHoQMGNHbgsE8Rezp7WDtoC8Ok
 4WEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWase6nm7bztOqccS7+6r5E9V5ZOfNfuPFPgamo9Nh2xdLnG6Tyfp4NXv/YpfN4d0kQmHLEPqbkfSiB@nongnu.org
X-Gm-Message-State: AOJu0Yyk/dS227BGIzc4hws21kDK8cdKKrUb/JcTML4innUFSEpUd84J
 WKG6A9y9L+Q/9phyonQqgCI5L8zpc5hfq6+Q9R9SqpxzcDbqcPRtAi8vgUXt1BaRB84xvzlwwLP
 6cBcefC2L8yV8g7fGhfawZNjigM0Yyy0MFVBXrQbLg9NA6eDWNfKcTlAo
X-Gm-Gg: ATEYQzzF7jfjp04u9iBfpw4HLrOf2IgfVUBGc4qPd96jpvbudg5lGcytmKTLbxOXkhr
 wdeDD5DY+UpDNpp+l9D9Box67x13MCM6WP5kbYNRlGieYLBV+EHfjbzTfJXWmFHYX0c95FbRtnR
 59Gh6za9yQIbXOvjakHKYUf/QhNRY+MEcn7CgWf/rCgZuNkMASojh6bakHXlOKrqy+OztUR9cTs
 MSvR90EcxfFcWMQrhDCampHfV5G4Kd8iibKwweQiawgdAUisINwcroXbzBdsbIsQPC7UQzwcs7L
 ZZ2fUavScc1M1l6zDV3jfwakOtBVVwsHmD0oCxlqnSpt0tX4bknE0o7QyWFAxxeYF72Qv4JyVpy
 Zutpkl3rmpzNeyu4L7P67d4VF/A7F41m+nRXQxQ6vs54e6LKiR326Fq8Qm1rN
X-Received: by 2002:a05:6000:26d2:b0:43b:3d4f:e18d with SMTP id
 ffacd0b85a97d-43b64287044mr25834285f8f.39.1774363778481; 
 Tue, 24 Mar 2026 07:49:38 -0700 (PDT)
X-Received: by 2002:a05:6000:26d2:b0:43b:3d4f:e18d with SMTP id
 ffacd0b85a97d-43b64287044mr25834251f8f.39.1774363777925; 
 Tue, 24 Mar 2026 07:49:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b86fbb195sm2212716f8f.14.2026.03.24.07.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:49:37 -0700 (PDT)
Message-ID: <db70df33-a60c-4439-9717-c6c8acafa9c5@redhat.com>
Date: Tue, 24 Mar 2026 15:49:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ftgmac100: Improve DMA error handling
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260323125545.577653-1-clg@redhat.com>
 <20260323125545.577653-3-clg@redhat.com>
 <112ff466-cf09-4fe5-9945-7871683cb7a4@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <112ff466-cf09-4fe5-9945-7871683cb7a4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Michael,

On 3/24/26 15:45, Michael Tokarev wrote:
> On 23.03.2026 15:55, Cédric Le Goater wrote:
>> Currently, DMA memory operation errors in the ftgmac100 model are not
>> all tested and this can lead to a guest-triggerable denial of service
>> as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.
>>
>> To fix this, check the return value of ftgmac100_write_bd() in the TX
>> path and exit the TX loop on error to prevent further processing. In
>> the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
>> flag as appropriate.
>>
>> The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
>> AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
>> Nevertheless, since it is supported by the Linux driver and it should
>> be safe to use in the QEMU implementation across all SoCs.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
>> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> Link: https://lore.kernel.org/qemu-devel/20260322215732.387383-3-clg@redhat.com
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> 
> Shouldn't this be picked up for current qemu stable series?

It should be safe to do so.

The overall fix for the reported issue needs :

   https://lore.kernel.org/qemu-devel/20260324124131.1053711-5-clg@redhat.com/T/#u

Thanks,

C.



