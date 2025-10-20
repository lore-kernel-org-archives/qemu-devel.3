Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E264CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArj3-0007ws-1q; Mon, 20 Oct 2025 11:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vAriz-0007wA-PR
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vAriv-0001fe-M6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 11:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760973778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUgMNf9aswu/jYXKB9PlGnYovQfUiVNT+tmrdrJLFtA=;
 b=Ye1T35PEMhRAEm9k70WPFyKU5V5DI3oLSXL1TmT+y4SqiORaWliku+Fx6sWa45uqNd+ysO
 8M48ls1Uh6OB2fQJmM0f5eVrHck69G9CYW6emD3N1qrUk5FKAXqR/pfj/RcfNI3ACl1v6p
 l0+Fe1TGQa8MwD6q+mCpxaVlL2Ug41A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-aMBmJJlRNdu3ETiDFAzLkA-1; Mon, 20 Oct 2025 11:22:51 -0400
X-MC-Unique: aMBmJJlRNdu3ETiDFAzLkA-1
X-Mimecast-MFC-AGG-ID: aMBmJJlRNdu3ETiDFAzLkA_1760973770
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-471005f28d2so17437695e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 08:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760973770; x=1761578570;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OUgMNf9aswu/jYXKB9PlGnYovQfUiVNT+tmrdrJLFtA=;
 b=vKKSaDeIyEqy1ayVuA6+qbno6XbubxTok74awJpM8HiMRPfK2CkjshWFmM7tFJe6/Z
 ES4vsEPJ3YOm+gOJOdJMVFOy5moCZfjibMk537UtzuhmE4WQwuV1mASpHzazcwX6rveu
 O2wrNhE4HIY5Mc4QxDraFwEhh1EmZez1D88xQyDyP3+t0LRpaPL9TGwe7NwX+9HY43QG
 rq7MVCF1SzILLy2GiCB77K5gMgxVY7dDMn/Vq3lWsEl87NmNFqRQcIqFaIzEjdYOFsnp
 ynRAQC4mGsEppttosSSXWxbaDhEdwLHqw2pVh1ObhePvEPfiD1NYT3vqG/6ONlEniuna
 c7ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbFf0NmQjo5aMJUgFgmkdbkRy1N9aG8r8gIX/idj67l7mZ1fILv3AoTQswzj1r14hEx/B6FuZ8uaa8@nongnu.org
X-Gm-Message-State: AOJu0YxbCoO8nWIzPj/cSILzbPdSujNSmbWBg0SxKL6KfG/RAzwUK0e7
 nrlprqF/0yV+c6QCkonOylThQdpfOrFxEt7Ka+4kOEnF377JVLxTbX0zC01ITTNdjCLGPZF0RT4
 efFExA6AH6110xO5syjzQmb6cfDLtVeUvrLVGIOUgCEsNIL+z2GI7z7vq
X-Gm-Gg: ASbGncvj6vXP6oLDBzZ4+5rkb1A0zfLqQ4wUZfsMCLbUyWdTmk1lC8Kv7iGBKFdmnAo
 1UX+pwOmajNTcurSaioectuwvBc74ndUeockF/UHCYG818reshvs4zaPvfm0epfbyxiO9gUI4Mo
 AEZSJ9XGyLmjxgRJtm+qMYiRLx/LJ6wZwZ+1Foe0MyQFZyOitaNFUsB7E7dH2+Vylvz/KCMaIrc
 GwlfxMZ1LtPP5upMPdrCWeZQkGSrp+VBqcKtd03T+uC1gqR/A8Q4Sll7XNp6/rrjHtWh49uL7Vg
 U2fN7oMjyH9aOJzWwG5wVroAIkCqH5ORKZV3M2znbojTtCJtulqWTbqtm+NjJ8n6RE5KTyfo/Nh
 DDKisWZ64kcji9GsLEz9XP/FUahn/sCP4nTOL0K78TAw2tLiw9XwFZ7m+12rnr47Vcrq7rHsHY5
 HzPA==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-4711791cadfmr118544185e9.32.1760973770123; 
 Mon, 20 Oct 2025 08:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpLXHWRH3qCym5vAAg52XcKtHd2mVkWPjeYVifsQGc/9quw22dFTYi7Eb4KsySPjaDYO/YoQ==
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-4711791cadfmr118543965e9.32.1760973769760; 
 Mon, 20 Oct 2025 08:22:49 -0700 (PDT)
Received: from [192.168.10.27] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-471553f8a3asm174669895e9.16.2025.10.20.08.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 08:22:49 -0700 (PDT)
Message-ID: <cc709134-2d28-4ac5-b7fe-c61bd1c5ccbf@redhat.com>
Date: Mon, 20 Oct 2025 17:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: From HUST OpenAtom Club: Inquiry & Contribution Plan for Rust In
 QEMU
To: "Chao Liu(openatom.club)" <chao.liu@openatom.club>, zhao1.liu@intel.com,
 manos.pitsidianakis@linaro.org, marcandre.lureau@redhat.com,
 philmd@linaro.org
Cc: qemu-rust@nongnu.org, qemu-devel@nongnu.org, dzm91@openatom.club,
 luojia@openatom.club
References: <822f8543-10d0-4669-b484-cbd9837e324c@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <822f8543-10d0-4669-b484-cbd9837e324c@openatom.club>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 10/20/25 12:56, Chao Liu(openatom.club) wrote:
> Our initial plan is to add Rust versions of peripheral models for some
> simple peripherals, such as block devices or I2C devices.

Yes, this is a good idea.  I2C would add a second bus in addition to 
sysbus and could show the limitation of the existing bindings.

Several simple devices in such hw/misc/i2c-echo.c, hw/gpio/pcf8574.c or 
hw/rtc/ds1338.c could be converted to Rust in the same way as pl011 or hpet.

For now, avoid devices that have properties (e.g. hw/sensor/tmp105.c).

Block devices are substantially more complex, so I'd stay with something 
simple for now.

Paolo

> In addition, we hope to get some other suggestions on what other suitable
> work we can do regarding Rust In QEMU.
> 
> We look forward to your reply and hope to contribute to the Rust In QEMU~
> 
> 
> Link:
> 
> [1] HUST OpenAtom Open Source Club:
>       https://hust.openatom.club/news/20250812_intro_to_club/
> [2] RustSBI Github Repo:
>       https://github.com/rustsbi/rustsbi
> [3] Learning QEMU Camp:
>       https://opencamp.cn/qemu/camp/2025
> 
> 
> Thanks,
> Chao
> 
> 


