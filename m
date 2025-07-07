Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E67BC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 18:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYqzn-0005HB-6n; Mon, 07 Jul 2025 14:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uYqzh-0005Dj-BX
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 14:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uYqzf-0000Zu-Gm
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 14:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751914510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=duuNnGimM3BBVhD3wPxdrHkpz9c4CGWV/3V68tch7d8=;
 b=itpNpjdk/W7Riy1kaSxlI+YfVaq33b0/rjcfjxIpaAkISm1hYRqutC3a0tMvPz1C9M46Tu
 HH7w56om9bJy/6BxlXt06KV/HJrmiPPeeKbpRmyjWUfXRpwKdnWYLMRWyxaOYDqgXPoFNO
 wLFvevu4ZB/kH+iHfrxVTvkdxaWYLiA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-EcQoyv6FNBaxHakSu9OTbw-1; Mon, 07 Jul 2025 14:55:08 -0400
X-MC-Unique: EcQoyv6FNBaxHakSu9OTbw-1
X-Mimecast-MFC-AGG-ID: EcQoyv6FNBaxHakSu9OTbw_1751914507
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d3f03b74so18954525e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 11:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751914507; x=1752519307;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=duuNnGimM3BBVhD3wPxdrHkpz9c4CGWV/3V68tch7d8=;
 b=kPe4D1bCBgMpQkTZeDonLU563s592r+prA1EROU2jmtysnhUgnKdGyLSZC+MwptTaf
 psNm+C0hqjPJgKWM1KlzZILwU3XVRYCcIro6ZJV/7Z5Y9bRMmkyIioTAvakYypYW5IRA
 yT3W+wT/rI96DgI0zyyqUEPxT3OMODCmyuwYOddZHnnsvivlT2BdaEJBek0JI82GM8lZ
 mX6ZfGBcFgpOxDM2ZqZhT7/hzMFMbI0Upakzx+ewdh5KUvC9QwuXNFhdoh7k8SyD+7LX
 dqXDQAaW2izjE+V59zL19yP5E6kyHdabKw6lveBWlT1g0v8ZtEkhDkJmOMm4n2cDeysK
 wwCQ==
X-Gm-Message-State: AOJu0Yx1MQmP5/DNGmE9g2HTpMcHK+zf3BL10IN/cnTGwbI0bvy28eJ0
 YPQQArBjoTLxX1lIPg59aauRhBj5/4ikmbhPT/R21qlfWqyibyEGWSe2jK6lLMIMd5lOaTPzhEx
 q7gfL+DkMLzDHRAl6X0K8gUmvzvDSP/uXrScG1rBIZj0MmTZzxfOPBpnq
X-Gm-Gg: ASbGncuDMCvwxhVCEEqZNJSKYZ/6zc+mzyHEAX5TNkcKNznB+iXw7FB/ZhAg9JCPZBk
 Ie/zchCjwhYM5bEc6Pk0eRUp3fqvBsfXLW/SfOltLNyB7QT5jntAFpqWM+XjDn+ybyY+AGFkIO/
 EMvPo0YSGDr1LmFMSKqX/+C4DxitdNho3CKXCoaQcEEIpAwJqtsb40E07mcNWvVn1Kb17EX/jWb
 I1A9gaaAXjjBrqP3HcF8BJ4TgGxDB/NOJg1gFJp10rUOpJcLmRX89ik7eThPwDlLMrxgNVTKmXE
 EU4/B8uAFRUEADxQehmnt2CjAegIIIst6MNKmYVRuLptvgbV/TVC9t/b7eo1AW8=
X-Received: by 2002:a05:600c:4e13:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-454ccbf082cmr9066285e9.0.1751914507306; 
 Mon, 07 Jul 2025 11:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8g0dyPAYcmB9XZz8SR3JQmfjBarISL3B8Vmyby+IV2d6leHcudpvKoPzHRSGLBrMUM5l0Cg==
X-Received: by 2002:a05:600c:4e13:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-454ccbf082cmr9066155e9.0.1751914506922; 
 Mon, 07 Jul 2025 11:55:06 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-131.pools.arcor-ip.net.
 [47.64.114.131]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd38f03fsm419515e9.5.2025.07.07.11.55.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 11:55:06 -0700 (PDT)
Message-ID: <69248945-a655-403d-a8f7-e763f74d335a@redhat.com>
Date: Mon, 7 Jul 2025 20:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bamboo ppc Linux image URL is 404
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <CAJSP0QX+WARJQ_6oN=vPyzkotQ01W0Jk5S65Z=Npw0BYp3jdpQ@mail.gmail.com>
 <407bcd9b-6f80-4d5c-aa28-5b95cbfd61bd@redhat.com>
 <ffb0c416-a6ef-4669-9f38-56bd41ba3c39@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <ffb0c416-a6ef-4669-9f38-56bd41ba3c39@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 07/07/2025 19.35, Cédric Le Goater wrote:
> Hello Thomas,
> 
> On 7/7/25 19:07, Thomas Huth wrote:
>> On 07/07/2025 16.13, Stefan Hajnoczi wrote:
>>> Hi Thomas,
>>> The following URL is 404 and is causing the functional-system-fedora
>>> CI job to fail:
>>>
>>> qemu_test.asset.AssetError:
>>> http://landley.net/aboriginal/downloads/binaries/system-image- 
>>> powerpc-440fp.tar.gz:
>>> Unable to download: HTTP error 404
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/10592622177#L1047
>>>
>>> Please take action to make the job pass again. Thanks!
>>
>> With a quick search in the web, I did not spot any other location of this 
>> asset. Looking at the MAINTAINERS file, the Bamboo machine is also Orphan, 
>> so maybe it's finally time to deprecate and remove it if the last known 
>> working image has vanished from the internet?
> 
> Linux still has support for the bamboo machine.
> 
> As a replacement for the asset, we could use  :
> 
>    https://github.com/legoater/qemu-ppc-boot/tree/main/buildroot/ 
> qemu_ppc_bamboo-2023.11-8-gdcd9f0f6eb-20240105

Ah, great, that seems to work, thanks a lot for this!

I just sent a patch:

https://lore.kernel.org/qemu-devel/20250707184736.88660-1-thuth@redhat.com/

> I plan to remove ppc405 in the next cycle though.

Only 405, or also 440? (I think bamboo is 440, isn't it?)

  Thomas


