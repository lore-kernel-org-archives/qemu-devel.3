Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A75E75448
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 11:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYMzP-0006iL-EY; Wed, 24 Dec 2025 06:25:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vYMzM-0006i2-2k
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vYMzK-0000gJ-BQ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 06:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766575505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SUquDkfqeE9wbnLT4HJuq866sRB0NKo/tK8aWQmE63Q=;
 b=HOb03WomJtjHiLcYCuwxoHJNcPjM/hLSt+Vg7MbqhpxhshWIzviRimWuibIsUZyOgp8T5b
 QgJV4s70g6dSs3yVHymvGFMwAPgPIzhY3nWa/pjm92IVSPlyv3eeocYFtdQ/GUdnzchMlD
 16yoeq8RrRKmKlfS6+kruEKyUOwHgTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-MIqy0FIOPI6sgagKoObSTQ-1; Wed, 24 Dec 2025 06:25:03 -0500
X-MC-Unique: MIqy0FIOPI6sgagKoObSTQ-1
X-Mimecast-MFC-AGG-ID: MIqy0FIOPI6sgagKoObSTQ_1766575502
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47910af0c8bso38478145e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766575502; x=1767180302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SUquDkfqeE9wbnLT4HJuq866sRB0NKo/tK8aWQmE63Q=;
 b=gAPgOveXS4es4HAtL9yCp8p0eBkLJBF3EMJcEl3k4690ed9OviNzKP2+WpMpJ7Slon
 C9jFF8u0TSSG1ZI3mfHSXx8LzNWSehL9lRvL0avrR0nd4j+ouNN1GGP5HeZOwxakl/gz
 P8qQ2LmEjKs25QNIXi12bQE/UCRWRdnpR5xdFcpUhNHXqfNyxz7mAw4eEcAFJww6w3Wi
 kV0ebcuW/JrdUaSJE6vCiScLOqRSs29GJMwi/+Sklh6u+ZObpWsZizCG2/2oafjHg16n
 Hd9peGXei3ZdilNwJF+s7aSdC5rAODrXvwjmGTBw8hQKFxS6bo7IEs4vJShwPzodxXTh
 n+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766575502; x=1767180302;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUquDkfqeE9wbnLT4HJuq866sRB0NKo/tK8aWQmE63Q=;
 b=nlrM5fmtrJavaUXJeOa4JjufBU1uBge/F6klXCDHDhnZeB0KXTspIAfJVhGrNpfRux
 0gHyTR3CWdkDSp3nozk72zGS1N/a586m3wWIRuq616W+w+FBEaMIsl8P8c4yqzEsi0Xw
 SK7tfOas8s0gOrZMep/ECXgvuupE91oFpinPu3SjDyzAJ7dPZ23TvTPq0HYLGvZMtOwt
 Hk4Sl0nfUU+HYIfADOwULTLGN/J8wjAKA3utWhlhN4jPxSU0/tBvSI0QHXE38xU4NCEv
 1aZ9/JcGDDLcOOlItPzG+o4MZURWr/RJOPuF3kscx5NXgx1dl/NjIG/bAjV48axAKKa9
 zyhQ==
X-Gm-Message-State: AOJu0Yw4+GLh+qeJhZWIuwDvVp/SterdAW3kTY9S4nS8DcOrtZLewEYT
 uOsLh57nGWO+MWEspdZCiSleJQmnpVlOvRjU58MAOA3un5s+WvZDSzhWFDFZY4z9GY82smTvkBA
 I2OVFNV2/4lHVUlLgNREBo4or5dGpMohXLnjYPXKZM1SGLwgAhn/hOw7O
X-Gm-Gg: AY/fxX4fCCZGUiFMAKcTEhEgFruZnAEBQepLlCMjbXOgY+pqaefp5c1ScKoKA46RpUC
 XCx2TbFfu/zhArMZESFJmflrFN49UsSpCzXanCKXSGiDvYviClxb9sbGA/3RMl6+GTyP2FN0JtE
 WKhp7Ti+l6pKhtv2aml7BPSHPb2krm+9Vu5yu5tpnTOXIbgMNCFGUXrXLspe1KCRq0euOV/L5l7
 +BKqGvPRLiVJj1P7X5eNxXD6ODgKH3Yx+xHIr3CBkHYtuU7UlkodT/pCQNalU1eCTbnC8OguNca
 bWfH9b3ndNM1jAPl06Fl08tSRMIfbNkRBl50PZD5LTiVmwxtg2v9rQ94fM4+QKYsqClxWFSgXEL
 e5E1RiqNMS6gtSB4pOKHiWuZUciEhkuIfMlD/MFIroiLmYA==
X-Received: by 2002:a05:600c:1d1d:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d1953b8acmr163189365e9.8.1766575502298; 
 Wed, 24 Dec 2025 03:25:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAs7683m4OKFC2YJl+RPLAei8hSOgOGfrHjzrOpsBIUWUZqk8WJWPtMkvoN+Ht8SNnbNT4fA==
X-Received: by 2002:a05:600c:1d1d:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d1953b8acmr163189165e9.8.1766575501884; 
 Wed, 24 Dec 2025 03:25:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:165:d60:107a:63db:9521:6057?
 ([2a01:e0a:165:d60:107a:63db:9521:6057])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3acdb87sm133831645e9.16.2025.12.24.03.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Dec 2025 03:25:01 -0800 (PST)
Message-ID: <d65e8cb7-7370-434f-89f2-d35bbfede01a@redhat.com>
Date: Wed, 24 Dec 2025 12:25:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Fix URL of gb200nvl-bmc image
To: Patrick Williams <patrick@stwcx.xyz>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Tanous <etanous@nvidia.com>
References: <20251222073351.166720-1-clg@redhat.com>
 <100505ae-4d33-4bd4-800b-6ab21b99738a@redhat.com> <aUsTpG0EGPh29pUL@heinlein>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aUsTpG0EGPh29pUL@heinlein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/23/25 23:11, Patrick Williams wrote:
> On Mon, Dec 22, 2025 at 01:52:19PM +0100, Cédric Le Goater wrote:
>> On 12/22/25 08:33, Cédric Le Goater wrote:
>>>        ASSET_GB200_FLASH = Asset(
>>> -        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
>>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-bmc/openbmc-20250702182348/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
>>>            'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
> 
> Should we make these commits or tags rather than `master`?  Right now it
> seems only Catalina uses a permalink where as all the others appear to
> use `master` references.


The main objective is to be able to add new images without breaking existing
tests. As long as there is some version number in the fw image file, I don't
think it matters much. I would opt for master.

Thanks,

C.


> 
> functional/arm/test_aspeed_catalina.py
> 14:        'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
> 
> 


