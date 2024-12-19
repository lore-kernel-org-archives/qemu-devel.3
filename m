Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48210E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFS-0001n6-AH; Thu, 19 Dec 2024 11:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOFAe-00035H-NE
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tOFAd-0004oc-Ds
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 06:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734609502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oRuEe6ucAO0eYhzom7FI+s0akhObBTVh0rVi/x+C/Cw=;
 b=gh2AgRYIMJ+iH3UE2+6MaEHqxEIX3wJO7xuikKaPKtolBlWWXDuCvup1ORWGLdhNwAntg1
 tT4Wgbt8+2xEHuD17ZkUnvi8au64/q4xbKd2L6UEkasMVZESNvPSrLozvb51MsQqP4f829
 stqIryhS25/noCnx4xkmuAUYSU4BvXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-HieUukpvP8aZ24XU4KG4qg-1; Thu, 19 Dec 2024 06:58:21 -0500
X-MC-Unique: HieUukpvP8aZ24XU4KG4qg-1
X-Mimecast-MFC-AGG-ID: HieUukpvP8aZ24XU4KG4qg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso416560f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 03:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734609500; x=1735214300;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:from:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oRuEe6ucAO0eYhzom7FI+s0akhObBTVh0rVi/x+C/Cw=;
 b=E26Ft82J0z0KI9ZMvoOWMw8KAML6teQV8EXLZDl4xN/8sH8YM/uS2B6I8khM2TKDIi
 3z8G+p15FX37QrozokZsXv0wYqOeNFBfsh5vxiv8tdZjF0hCFg6NaKMBiLzxDoYsprSL
 jQ0biSrKd+YPIg7Ozm4hZvAuLrV4wdGAywP1Lsir+Sswj1rwnsaZwKlFpKOyDWEoy7nH
 +RTkGi7Dl7FZJe5Zhz6ASoJMrebbkCICs11UrnBUyHJ7nTe2wKPPI91v0pHIusCD9epS
 0iaCsPd8dhaoylOe2ySwkMuw2wXRbp1oSGm23oRJ3ZYZfMLnwldyrDvvCYH0586m1r4C
 nY3g==
X-Gm-Message-State: AOJu0YyDrhU3aqwg3Kuit4yyag1jieisFFUIowxLCKMUOjen8ZxljKcP
 m/EYZTlMqX1hpHtYooEyxuripuIwadnCNvf6oI0Jft40VHbT2QGvIqsezJvhSuLsxxNzi7YctZN
 sEXhhWgu2T27ipOOA1K9mXL74BqRzOGDakocUDc6QtbVQHxokEh0E
X-Gm-Gg: ASbGnctEBqKNswSMUbIcylYZaYnmkyXKbf/sNKol39sL962HIVmKK+Jb9P4e/uvjJcG
 N6jqasSolZvIZx9tk8/p4zqCof7Ki0DLczbg/13tn4HPENu8HAmN6scXS4HTUugB0MpkSO6RAsE
 yEHYD/9r+VdFLVLiqN4TnvvuJ5THC4FoiGAeOtbt9w17gE+8kJOBs42VDevVzzZeAY6y7CtKDC7
 zYnDhVroER/m/oVKEnZvxZRwH8RGSgKMzTrhC0Hfizaetp8Yc2TG659liAvXerizug622uh1fOD
 GfgrVDHFAC49GsheaeoxJYN3kFq5BPRv6Nnmps+JfegtyDU8DWNGYThLDHb2nPkwurhIs+9MKo8
 vralgwg==
X-Received: by 2002:a5d:6c6a:0:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-388e4d8fd51mr4948291f8f.41.1734609500307; 
 Thu, 19 Dec 2024 03:58:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE417aVIp18tTrZtgvfHcpUp94db1bbN32d6gPOMshVN8S1Go+rPtYMpfVGARYhp77wJxarWQ==
X-Received: by 2002:a5d:6c6a:0:b0:385:f44a:a3b with SMTP id
 ffacd0b85a97d-388e4d8fd51mr4948262f8f.41.1734609499890; 
 Thu, 19 Dec 2024 03:58:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c749:6600:b73a:466c:e610:686?
 (p200300cbc7496600b73a466ce6100686.dip0.t-ipconnect.de.
 [2003:cb:c749:6600:b73a:466c:e610:686])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832b3dsm1391612f8f.25.2024.12.19.03.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 03:58:18 -0800 (PST)
Message-ID: <d4873e14-7b05-4f70-9abf-2f9d9ed0ea95@redhat.com>
Date: Thu, 19 Dec 2024 12:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] Host Memory Backends and Memory devices queue
 2024-12-18
From: David Hildenbrand <david@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
 <CAJSP0QUoerckBWX=0PD_82jFwVbmtvftWf5QqSWxpK0Ttc+uvQ@mail.gmail.com>
 <2e6400d9-6fee-41ed-a317-329f275912c6@redhat.com>
 <d19ab3d3-737d-4faa-a7d7-639b4ea3b172@redhat.com>
 <ed949070-bb79-4357-b379-9374c40433bc@linux.ibm.com>
 <728b07ae-17aa-49ca-967f-a35d62f8cc32@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <728b07ae-17aa-49ca-967f-a35d62f8cc32@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19.12.24 12:57, David Hildenbrand wrote:
> On 19.12.24 12:43, Christian Borntraeger wrote:
>> Am 19.12.24 um 12:18 schrieb David Hildenbrand:
>>> The following on top seems to make everything happy. I wish the
>>> CONFIG_S390_CCW_VIRTIO stuff would't have to be so complicated, just to
>>> handle odd configs that don't really make sense.
>>
>> WOuld it be possible to rid of this config?
> 
> I was asking myself the same: when does it make sense to build for s390x
> system without CONFIG_S390_CCW_VIRTIO. But other archs that also have a
> single machine seem to be doing the same thing.
> 
> We wouldn't want to have the option to disable it, but "bool" gives you
> the option to do that.
> 
> I suspect something that could work is:
> 
> diff --git a/target/s390x/Kconfig b/target/s390x/Kconfig
> index 8a95f2bc3f..4c99b9cedd 100644
> --- a/target/s390x/Kconfig
> +++ b/target/s390x/Kconfig
> @@ -1,5 +1,6 @@
>    config S390X
>        bool
> +    select CONFIG_S390_CCW_VIRTIO
>        select PCI
>        select S390_FLIC

(- CONFIG_ of course)

-- 
Cheers,

David / dhildenb


