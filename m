Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A6CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNnct-0000kI-AE; Tue, 25 Nov 2025 02:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNncg-0000cD-Sd
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNncd-0005GC-ER
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764056277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hdwmzqEuclG2NXNn2wXrX086nufCB39kCoShCifRCR8=;
 b=g9mT/5GnMeA4kMdcMYPojfZ4aJ5cliqCoA/dzNIIUi+NOUUlZTvmMNYd1ribbZy2kv5vhK
 sQsuHutqbpz/7wEQgZuu0lM23VEGl8TtrRc5xOj7ZkN8HsL8x1oLpenJUt6bgHT2I1aomW
 TUXM1TrKyNNvIA2Me4LzZ4MwMmQjYN8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-lO6CDQhFOuK-DihBaiVmOA-1; Tue, 25 Nov 2025 02:37:55 -0500
X-MC-Unique: lO6CDQhFOuK-DihBaiVmOA-1
X-Mimecast-MFC-AGG-ID: lO6CDQhFOuK-DihBaiVmOA_1764056274
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b30184be7so2498474f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 23:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764056274; x=1764661074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hdwmzqEuclG2NXNn2wXrX086nufCB39kCoShCifRCR8=;
 b=GY6q0bHYEgJVZG6oZVdtW4OnmJgKou0bZYy+Ayv2Ha0zBPM2HFYeaKqoqjvj2VWhLk
 EYloGCFaHDgDMKmxdjuCiEIIwu4Zg9bLsbhnhmxzNpgiqMmIC4ir80BBrHaYLZdAo4hO
 NrdC/0Pq2FLh1HACXIU9OJG0CPuY3ULcfQIcMFjemfsnBAggqZx6+lR2Hsmlehu9L8b2
 9g7LW8xg9o+xvz5QL/B2co2xjeEXuhvu6cwbfOzBUXh1f6ILaphjg6XR3kolnKFU2hYN
 VG02g1GpDGWyvQG1K9BSJx7LOd/oYmDFSQlOoUgR/mQmoUnoDoUsGaLO+dPiSjcYMbxM
 FXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764056274; x=1764661074;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdwmzqEuclG2NXNn2wXrX086nufCB39kCoShCifRCR8=;
 b=nr0Q0dmOUQ9Vg4WnTKY84Jx9F/tDrXZUyaICicqddvj05caRvn69mMc7GEmotQeE+L
 3k2mVqEMkhVBRr8e1x49oMukBRuQoSYNKxQh9MFhGYVX64h1WjXX1w4G9xbt5yHCx8vw
 /4K6pE58t8P9Zt2qXgCluJGKtHEjncUWao2aPX8zHmemtxZK/NvUzsXE9+g/VA5aUnM7
 K84Uhj/qqFE49VEnAUnUIuPB9pzC44bK7FTL/BcoosnWyHLoPvRqLwFUUf8AiAJgQ7c7
 dQlzw0Ie0Rv4j7UTKetruBVnyxD/HHazoloMtF0w1lamxoOcGKswgiPcFQ26xIcCtnB+
 VYJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq37/7m/NuzZzWr+uh2vElyXFIbB/lo9S3jMeU59NLYB1OO2CBAnVLuqH6J2Riyq/CckGwbZiVaPee@nongnu.org
X-Gm-Message-State: AOJu0Yx1gdef1slGJz2wV58v0BEwp0Uo4ByCNHmpJ1ug3824QIul146N
 XB+LKh1Cghb2uJi9ICQyxNhWm+2Yl3lvcWegtaHSHtB1tSJPbgMEJLX7cRv2EQ9rErgg1TqzZHr
 GJARtoSgs6VjKfwMtGrC0ci4iajriX6zK5eZmMtnxgJawS8okSvnY6CUIgkDDOpUj
X-Gm-Gg: ASbGncuXXr+ZgD+OjTVNM4WmNNPh6Auxzz/s7aP1kZ3Aed7ZjrvpKQ3HB9XB3XLVc3l
 T3HE9HkEZeToT9eGUfEY4xl3uc2IG6KgQtq/WCFstX05Ff+HH+FO1kWxDLZE+KOh6+c9FoMojId
 u5H9KFd84mrYEjQ++eazm5TOJbo1QcQltkK73JG5AmK2bJIc1pYyflQrR/Ru07EIJzH9o9n7p0Q
 9PuV1JHfhN+zrVKP7OT2R6go9rwNClLIq1zFnIhPbsMqh826Zt+7WJpdk9ZH8OpaasjHQLB7gPo
 EOaLCUeEOJIe0wqBvZc0sR5nK+3D7UEE0xD4PLnKrjIM0Npgs7t+Kum2dGJtLgj2Q0TdhQ/Bttn
 i4MawSZF59BcwFGutC/rh6XYaFLmjVmri2+2KBMIbVQUpW4ic
X-Received: by 2002:a05:6000:288b:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-42cc1cd9538mr13682127f8f.7.1764056273955; 
 Mon, 24 Nov 2025 23:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmqSAoc25jftBW6aY42upIKvW60phaKVvycsKL+EL++nxFyg8qmMpog7Jt8MAwPNG02VU0rg==
X-Received: by 2002:a05:6000:288b:b0:3ec:db87:e5f4 with SMTP id
 ffacd0b85a97d-42cc1cd9538mr13682105f8f.7.1764056273576; 
 Mon, 24 Nov 2025 23:37:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8d97sm32125536f8f.42.2025.11.24.23.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 23:37:53 -0800 (PST)
Message-ID: <5cec999f-a67f-4370-9e88-bc6d87cc5358@redhat.com>
Date: Tue, 25 Nov 2025 08:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/3] aspeed queue
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nabih Estefan <nabihestefan@google.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20251124070524.240618-1-clg@redhat.com>
 <26fdfa13-48a3-4847-8408-1db6e206cd59@tls.msk.ru>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <26fdfa13-48a3-4847-8408-1db6e206cd59@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On 11/24/25 21:36, Michael Tokarev wrote:
> On 11/24/25 10:05, Cédric Le Goater wrote:
> ..
>> aspeed queue:
>>
>> * Fixed typo in the AST2700 LTPI device
>> * Fixed missing wiring of the SPI IRQ in AST10x0, AST2600, AST2700 SoCs
>> * Updated ASPEED PCIe Root Port capabilities and MSI support
>>
>> ----------------------------------------------------------------
>> Jamin Lin (2):
>>        hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA interrupt failure
>>        hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port capabilities and enable MSI to support hotplug
>>
>> Nabih Estefan (1):
>>        hw/arm/ast27x0: Fix typo in LTPI address
> 
> Are the two patches - "Fix typo in LTPI address" and
> "Fix missing SPI IRQ connection causing DMA interrupt failure" -
> worth picking up to stable (first to 10.1.x, second to 10.0.x
> and 10.1.x)?

Yes you can take these.

> 
> Will there be migration issues with these in place?

I doubt it.

The Aspeed machines are not versioned and we never claimed to
maintain compatibility. I think there are other issues related
to the secure state of the CPU that prevent migration to work
anyway.

Thanks,

C.


