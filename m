Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37DFC87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 20:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugqpK-0004Kj-Hb; Tue, 29 Jul 2025 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugoLh-0006DX-0E
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugoLe-0004OA-Lu
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 13:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753810963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E7/I74AC1rrFP+gZJJ0tI/rnFJU1iV0QY7ExSYXyKXE=;
 b=Ix1pHdiU7EDDXJq6oc+Cy+2XXjxY8oHk7kJTweNQBaEHEtvadoDQRNuJ7r9e1GvQ717JWG
 +tKflzmm6js8oiN/CdfXFvpbrJCXsWOUyFpl93cP313BewJnqV7j37Ida2TwWhcT3GOB1w
 iL3B/9iz5O41V6FkRJ1Mr5POEZWQJbg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-yIPWddCyPwKDM0eY_YkQpA-1; Tue, 29 Jul 2025 13:42:41 -0400
X-MC-Unique: yIPWddCyPwKDM0eY_YkQpA-1
X-Mimecast-MFC-AGG-ID: yIPWddCyPwKDM0eY_YkQpA_1753810960
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b788e2581bso1326804f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 10:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753810960; x=1754415760;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7/I74AC1rrFP+gZJJ0tI/rnFJU1iV0QY7ExSYXyKXE=;
 b=wB5jE9/c4pZ6bWJhPXizq+hj7LAi4Ztr86v3uEV5jlzjHc/zXEuE7+7wyT+SlqJlX+
 sckOoic/bN3STKW3Dd8T5X+xhajWmbHT+41dkQCaYUa8kltO5mK90xISRn/VeQnDv6uG
 dgGLYnb9PNAcocWoKmxG6O+IIsUwL16oYZZnwMGGqnYgvPwlJ2LFZO4vFVltzfCWj6pJ
 8oV5RCMM2rFRwMZLlX0ihsC+AL91nskJsvQlsU1yh0myaXXJyYe2xmO1s6CxOFjlmx9H
 rLZMEN4s+gcA6lgfmgFFpkU1K0l3IWAAOkVg5hfgR59WLP22XbDZZr2gJ6DiIUONCP7G
 QKPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRUDGYVjGUHfYw6TsWos4dKS00muCfukIopiFVTurXcXVEtiS8LQwKxfYTZ3eYZ6brOMNCivEXCEjK@nongnu.org
X-Gm-Message-State: AOJu0Yz4YfGbPKOaX9YrI0xfc6WyZhfZSwyt1gLjCIQfZBFax93AkUJo
 YTGTpgIwrUX2QYYKi+V8Pr9aDfMePCoV0nb4YUXx99qF56Mc5vlRBh0uE0SFC7X+epJ7YYOrxVU
 3OPJwUK6DRV5ORDVhEIw5XgviYwAXHQrkpO8dg3q/nPDVJcK3n3g9Y9xe
X-Gm-Gg: ASbGncuWY4yGM1m62q+i+9oTktvIM6HDALlo3iqz0a73F1yiomSR/m3jzIE6EkFIoMj
 9FYBCiH46m0P1/psnxdqcgspluVyvh/GlRSirdYWzvRVh9+3U+B5Bt4jFYjqb9GxuRxxbbFeVsS
 5avDKvtWdsHyxFTRAIzJK5eh+F/joBUruFWp9GXjrKh48p+i6kL5eBIlfk/4Hok/q8oiuFdjmbG
 l4+ek2Hbi+DaR0vEaQuVv4BZpLqI1ugM3UPtDM0Wx61k6axq8zob+VHRGsLVYJVHKmewRHu1u2a
 MrPOyqy97BkWI3Rg5y2b2PpCAZ0SA4Cm4fqoUtSNIjemCwpqGFgp3sw4g3czRHvBm2fMqfchJl4
 Bdg==
X-Received: by 2002:a05:6000:240a:b0:3b7:79a5:3e53 with SMTP id
 ffacd0b85a97d-3b794ffe6c2mr455510f8f.45.1753810960109; 
 Tue, 29 Jul 2025 10:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6afnn2lXTjcVkqEB7JuKRN8JRlCrY42bSZVmPSs3hrupeqyI0hWNTjNWaKFwADMw4wux6Lw==
X-Received: by 2002:a05:6000:240a:b0:3b7:79a5:3e53 with SMTP id
 ffacd0b85a97d-3b794ffe6c2mr455492f8f.45.1753810959643; 
 Tue, 29 Jul 2025 10:42:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4d91sm214054885e9.23.2025.07.29.10.42.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 10:42:37 -0700 (PDT)
Message-ID: <eaa6f448-ef07-47c6-b442-50bee9179a52@redhat.com>
Date: Tue, 29 Jul 2025 19:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] aspeed: Update vbootrom image
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>
References: <20250729170800.678363-1-clg@redhat.com>
 <a6ebd7c7-95b7-4d31-a0cc-a2b84bbde4f7@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a6ebd7c7-95b7-4d31-a0cc-a2b84bbde4f7@tls.msk.ru>
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

On 7/29/25 19:20, Michael Tokarev wrote:
> On 29.07.2025 20:07, Cédric Le Goater wrote:
>> Hello !
>>
>> Michael provided changes to fix the build of the vbootrom image of the
>> AST2700 SoC machine in [1]. However, a workaound in roms/Makefile was
>> still necessary to build ast27x0_bootrom.bin correctly. This was later
>> fixed in [2].
>>
>> This series is an update of [1] including a vbootrom image matching
>> the new commits.
> 
> Thank you for this!
> 
> I guess we should also update npcm bootroms now, - 

Of course. Let me respin.

> does it need any
> additional handling (the two changes related to npcm)?

"roms/Makefile: fix npcmNxx_bootrom build rules" was merged.
commit 653a75a9d7f9.

> And I'd say we should include all this in 10.1.

yes if Hao agrees.

Thanks,

C.


  


