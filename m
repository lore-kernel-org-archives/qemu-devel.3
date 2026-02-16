Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CE0E7BDB5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 12:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrxm2-0000YQ-AX; Mon, 16 Feb 2026 07:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrxlu-0000Xj-6R
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:32:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vrxls-0002A7-2H
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 07:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771245129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gq0plVVf4kuDVVW/Aqn2h1TxoGHLRI3+ZIHmmKTDCpc=;
 b=XwGAp2VNUVglxdg1JWb+MohyGq5YRCqgclGorioHnSeTxRa70aaKGGTkA28v3aRzXTLsL8
 BBBkvSk24ayg0qHSYK+6zvNAGsonihwZ1YTaJtB/uJ9lj1ZmgraiyHqPxtvZrozdp5L0/f
 mKD75FeejBlBKwJXR9mGGRMp4q+ghTU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-x6Rpg6U2NGGKL5BBfWp0jg-1; Mon, 16 Feb 2026 07:32:08 -0500
X-MC-Unique: x6Rpg6U2NGGKL5BBfWp0jg-1
X-Mimecast-MFC-AGG-ID: x6Rpg6U2NGGKL5BBfWp0jg_1771245127
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so34435125e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 04:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771245127; x=1771849927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Gq0plVVf4kuDVVW/Aqn2h1TxoGHLRI3+ZIHmmKTDCpc=;
 b=X4NllFjqBZtIaRt22eKo4d44FWqaRd55Wh090rOE3H5Fv1EGJ6UVxEpNFRRm+XZgAp
 iYcKx/EFxb8nfnTRRGDudLoGlobWF+kdoWXVxH9CG2Xazh25CJ5r/yQ5ZtGvCJe9snyJ
 +Jx8ZBS6Y3B7FTxvtOtosnjV6BW7DVK++Ai8QbUoBzoWizVnjo5eDeE4WnHn38ljJWEi
 rQzfYc2WiFzFb/kf3dnBYqIT6jI/ewbbUGkeoapI76XlbLEB9TU9alCOOpohOmXlluSG
 x4Vn5FZZTNJX8gjIzOuo41QvhRwXSMfGPIMbjDPpWkaTz9wdesBO2XIvPVZtegO39gNQ
 2nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771245127; x=1771849927;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gq0plVVf4kuDVVW/Aqn2h1TxoGHLRI3+ZIHmmKTDCpc=;
 b=RWEsVH1MdatfqmY2OzZYQinOs5B/rnUCGpJ5xP/ywcOvTIlYA0v5cutQ2fssLor6mq
 Bi9DsxLihD+v9FGEoLUD+WC+KBYvpgmB+qeH1vjjfWM6iSiJhUrAETLEZAR2DIQ6UX/U
 59nTHw+iQLlsD/H3cOt8Hhebc6cczPyFjHj/lHs8ou1wd/EcuoMhxrU5drxu0bfcpEx6
 9qIsvJag/D/XEQu9b1YrQBo5JcRIpuRvwnR1yFxK91KuOsnTE057GBr77D1SfdiaFHhk
 J07WCiiyQCFIR6CY9PsxD9RB7tLDS0jgQ7+UAqqcKSHC/GYiF/4kYm1MyR/TS2yMpcl1
 Rvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB5CxmJhZb7urU6s6y56ZzS0Mb5Zy9UJY9sdZChB4YkhdQuqY/wQlazn8U90KuIDf/c4Knvdub36ZR@nongnu.org
X-Gm-Message-State: AOJu0Yz6ybgYfP4o0EtyT9AvhzhIi2c/4ky/SdQSDjgLs5a/rLDCGgZC
 l8jjFXqsBkDxD2EYLG8BSE41gIhq4fbzip0S5o3vTUyQid0CriyfRmV+bXHWInaHyKawdAaw6id
 Kl823u/J4YeBiBU1jH0OFRUosgZ/XDw7x6J8ZgvxFb5CqGAtuW4BAdtLB
X-Gm-Gg: AZuq6aI1d+UA0vYYcIMFVWd0IsG/rfctgISYb11TrIJO+gXGuPvRyruem+uMA7OAlih
 1GVZbGHEYlLm2GSG5k0+dqSFHeKeLWkkrOUA5IafTAhefkjciYv1mnRj7hAcIX6W12RI1UNFV8L
 UoLHqLXQxwVdPbNkzMZKJiQWNNGb/VDg0opRL1427ouu4b5Wdm4IKv0ne8vJ47inUCRZhOISq8e
 seMJsfpdlMM5P50/H46LVnDRPIsgiQ4FVsq8kg8fiOrw7r+g/uh/tXbSJLraBynUOuB4j6kQc54
 wNCqb0ldmsQHqXe4TQ9Qs03vBl96w1RdYJs8fOIOV/WTZJA1VLnpCnPQLGEdoACaW1LesZgwM9k
 wsrykJTbkgwo/8L7zBWk0mwgZg7IRqGGY9EsD0OIU2+naMxy31LpudutqWdKe
X-Received: by 2002:a05:600c:6098:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-48379ba08a6mr130359765e9.12.1771245127072; 
 Mon, 16 Feb 2026 04:32:07 -0800 (PST)
X-Received: by 2002:a05:600c:6098:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-48379ba08a6mr130359205e9.12.1771245126529; 
 Mon, 16 Feb 2026 04:32:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm502112985e9.6.2026.02.16.04.32.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 04:32:06 -0800 (PST)
Message-ID: <6d3238b8-51b4-4879-9367-e8fa2f0ab9ab@redhat.com>
Date: Mon, 16 Feb 2026 13:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/16] tests/functional: Add SDK tests with Linux 5.15
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Kane Chen <kane_chen@aspeedtech.com>
References: <20260212213955.2225662-1-clg@redhat.com>
 <20260212213955.2225662-3-clg@redhat.com>
 <CAFEAcA_oJgTc2SyRr11QTeTkmCPgvKiwngAaDiDNw5nUcTFA2w@mail.gmail.com>
 <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA_9Np04vouA-m99xB8yU-JhduwxxLj_dTG0QM=AnDbHoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

+Jamin,

On 2/16/26 12:17, Peter Maydell wrote:
> On Mon, 16 Feb 2026 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 12 Feb 2026 at 21:42, Cédric Le Goater <clg@redhat.com> wrote:
>>>
>>> Add functional tests for AST2500 and AST2600 machines using the
>>> OpenBMC SDK v11.00 with Linux kernel 5.15. These tests complement the
>>> existing SDK tests and verify that QEMU correctly boots older kernel
>>> versions on these platforms.
>>
>>
>>> +    ASSET_SDK_V1100_AST2600_515 = Asset(
>>> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2600-default-515-obmc.tar.gz',
>>> +        'ece1a934095378929780f03e7d092e562f4b33b2841b80ad7c3d12a85744c0f6')
>>
>> This asset file is over a gigabyte in size, it takes forever to
>> download, and our functional test asset download framework has
>> no mechanism for giving any kind of progress indication for
>> downloads (or even for telling you the URL it is downloading
>> until after the download is complete).
>>
>> Can we have a size limit for test assets please, at least until
>> the framework can support large assets a bit better ?
> 
> Followup: we have six test assets that are over 500MB in size,
> and they are all aspeed tests. Please can you have a look at
> slimming these down?


Yes. There has been a considerable increase in size over the last 6m.

Thanks,

C.




