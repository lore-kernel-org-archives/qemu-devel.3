Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE6FC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 07:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td2MI-0002NZ-V5; Wed, 29 Jan 2025 02:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td2MH-0002MZ-Hk
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td2MF-0003in-K9
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:19:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738135170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wGronELJ6OWPeBDGlDaOp/LLWu+p/rf2MbeqAY3HJdA=;
 b=KQ6yjChbJq3asjzHSN/6k9H4EqW/9xovhDi289Cd+gcijSh+/pfuOKDKHo+Y59X59UChOc
 aljE6COT+uvtYgMGOCuLjO90Ou12Xsij7WF0gS1PcBD1/5iTx9YFlrRHYb+zvQ3CMEQpoS
 GRB+5VRI0Axd91l1LPaxskAHVX/hKtk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-zyiLFtUnPEaXN--yS2iW7w-1; Wed, 29 Jan 2025 02:19:28 -0500
X-MC-Unique: zyiLFtUnPEaXN--yS2iW7w-1
X-Mimecast-MFC-AGG-ID: zyiLFtUnPEaXN--yS2iW7w
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385ed79291eso167908f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 23:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738135167; x=1738739967;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGronELJ6OWPeBDGlDaOp/LLWu+p/rf2MbeqAY3HJdA=;
 b=gUq7X9e52+VPYaTUm/2N+TOzzjR+03DDxu9LEG6ah8Agrm8qBWlSEMBTyeFCt/CBKx
 K+wOduDKk2k1ywpVHn0thvRZg+Y60jughg8onffxnirigPF2kEiqNUclgFrt15s2oULS
 TswEO7K5A0H+NOKiW7CJ/pP8a9B9F6VuZgr+l2hayxplgfQoHBKx6lGvQH26ucefk/P2
 ASyXdlMCQFiEIfQ2K19LKn/iIJKcNlRtj0Zep7sJEcJyK5rfiRtkHxyX9oFQas1cextR
 Uew78UH5W215UE3KdA0tlysqgvCgG/fXKoNdcf0/+PtRXFtiw6vmdenlOGah05pOs2GS
 3crg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXBrbPkDo6NwMR9FtwAk8JEjVjilkRFCn/EMVlXp+OmKkBgXzzrX1L2WrA30Uh3NqwJS1oVTn7I9a9@nongnu.org
X-Gm-Message-State: AOJu0Yy3lKVZy2BBr188Cuf/sDFxZoCO19RdZGsG5R/KlUFruIRFlH/X
 a75LtrVcWstdTzhxAKw0JH4izkg49Bv1yDGLHng+KTSoBLiuLgt0hlnjNk4Q/H4esdffLTRS7T4
 vqs89u0JKudiBXUt6tj6P6ljGh76I7ASNiWarDvdFjT/Gpb7vFTEpFepfEy+A
X-Gm-Gg: ASbGncurf1GzkWu/+Obh3Z3ztwFj8e8XKsjnjfRqRfymuqIAWJtyVbM7xk5SEzSek3b
 /o9YE4Xe39I+xHv1TlkqlOpw2Z3k50+vmHjiaCZ/Fw/ELfxpcLVtCWhE2Q+M6t9wHvN0btegAKc
 4L4KZHDdtkIJySV893CAGZrFDSabm/QUQd5oQR0hEpKwkAWGOQasGcaRHYgbCnObUdgFY93wOZ2
 dGpQhiWoW4O/vhi3p9omPHtKfibf2HeCVPE6PioDlKBr8yU0Xc66AsNMzgWNMIanpEpwe75n9E5
 uXvisej2Zzey0PFVz9u67tBgaagHuSBzLS51JC442Lc=
X-Received: by 2002:a5d:598d:0:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38c49a3807cmr4758027f8f.15.1738135167003; 
 Tue, 28 Jan 2025 23:19:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq7t77RivpRtGRYU7riKMmdCQ4oxFImYoPYcLFlCD5/tFhN7ojB1l/TVbbMZ0MI3KTv5gMYQ==
X-Received: by 2002:a5d:598d:0:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38c49a3807cmr4758012f8f.15.1738135166659; 
 Tue, 28 Jan 2025 23:19:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764e9sm16358818f8f.17.2025.01.28.23.19.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 23:19:26 -0800 (PST)
Message-ID: <78e6b6ad-0422-4b43-95f5-f377ea101f09@redhat.com>
Date: Wed, 29 Jan 2025 08:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] tests/functional: Update Aspeed OpenBMC images
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Troy Lee <troy_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Steven Lee
 <steven_lee@aspeedtech.com>, Thomas Huth <thuth@redhat.com>
References: <20250128214100.1196243-1-clg@redhat.com>
 <bee99a3ef4821f69f6f1a2f6cfc77c3e247e5d87.camel@codeconstruct.com.au>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <bee99a3ef4821f69f6f1a2f6cfc77c3e247e5d87.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/29/25 00:29, Andrew Jeffery wrote:
> Hi Cédric,
> 
> On Tue, 2025-01-28 at 22:41 +0100, Cédric Le Goater wrote:
>> Hello,
>>
>> This series updates the OpenBMC firmware images to the latest version
>> for existing tests and also adds 2 new tests for Aspeed machines
>> which
>> were not tested before : witherspoon and bletchley.
>>
>> Thanks,
>>
>> C.
>>
>> Cédric Le Goater (5):
>>    tests/functional: Introduce a new test routine for OpenBMC images
>>    tests/functional: Update OpenBMC image of palmetto machine
>>    tests/functional: Update OpenBMC image of romulus machine
>>    tests/functional: Introduce a witherspoon machine test
>>    tests/functional: Introduce a bletchley machine test
> 
> The rest of the patches haven't reached my inbox. Did you send them? It
> also seems they're missing on lore :)
> 
> https://lore.kernel.org/all/20250128214100.1196243-1-clg@redhat.com/
I shouldn't send series too late in the evening ...Sorry for the noise.

Thanks,

C.


