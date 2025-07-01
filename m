Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947BC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 12:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWaXg-0001XJ-Gb; Tue, 01 Jul 2025 08:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWaXZ-0001Wr-2N
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uWaXV-0000Pz-56
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751374601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1wS2L/KM4IhtQPrW9Iuevb5MkghEZ7QX7EPNbtSoRM=;
 b=EFOJOdeypUQtxNL1t/NGVF2ZUWqb7qzX5RMf1ql9hhDnlGFhmbPiM+T7Ngb48OE4W0yuxf
 TWr30WV/2hvt6dVQ5O0dXgJiainqulYpxCcbQQuRqo83Bxxk180szU81uUXOxhrOA+ngfI
 cx0cuaqHsUGx8tNvkAt/D9aiqXhnc/I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-W0Pp7fHXNQSBRj7FNkD9gQ-1; Tue, 01 Jul 2025 08:56:40 -0400
X-MC-Unique: W0Pp7fHXNQSBRj7FNkD9gQ-1
X-Mimecast-MFC-AGG-ID: W0Pp7fHXNQSBRj7FNkD9gQ_1751374599
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a523ce0bb2so1785770f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 05:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751374599; x=1751979399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1wS2L/KM4IhtQPrW9Iuevb5MkghEZ7QX7EPNbtSoRM=;
 b=l9fIXfLt6f84+FHZU6OI0I8Yh1A5U9P3J9PFF3twfDtGS/5XTaP2+NWT6dqN1DOBBs
 f8iVhQS1AdD8vjgmn/oen34UQIC14sBUtFXANrJAxJtIiQC223lGwq5oZ7XCkgZwBtPf
 6Eb0AxG7ecji6XyysHVAZ1bc4TkV2KY9nhQXeYF1hIzd0Vw+hVacMZZboj0ckXM/BAq1
 bKwj1Yjqkd1noMMU2GHHKfjMuhyeGdVGV6u+JnEk+MVnm3+38ad2niGti8e1A/mzIoei
 J5ucEPvuleVdUvx/ELQxdFo8GlJaXN4DK0t+/HbaGVBsTE9+CRzYAtsJl+7LgVLONKyi
 ACiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr72Q/etsHpXfti9UYdFXztSGdXVK9dad6f3oQjGFgwHYwmWdZE/JhYnVCWHOhO1Nay/xNJsRdJrV/@nongnu.org
X-Gm-Message-State: AOJu0Yxlv1bGUGsUL2i2xE1DNS4hVld9WlK+36nbwjeLpptNk2IiGHey
 qeylGqmcfe1aWCMbjVTxptSlZv+aanBRVu3RdvzXBIu/TAgd3CVPA6rRMXQb2kp6tfTay3onI6N
 FsVVgIFUJegik4kJ5J+lPX8YXE9wqFrX4CDY+NHtSKQK2YLoScO1uVeeb
X-Gm-Gg: ASbGncvZ2BuTTkR8R/Uyjfo9W66Zj8WSjuHwY2Rryzj2DvkdnXxtVfBF73kK/58lR7x
 zANHCMmCLy1Rp23pWCTOydWPljN/E369qoQETNPACnGJgKKgtUtxJdxp+AiJwGrkMiHiAvmZ0I4
 FZVxKdEgGWxYoxpoW8GMe2//Upa4fI7SMxtURD+ITKPJdTy4+SpkIZX1+rFEHHDW0miOPYYsBFP
 ClzVM8HmIi8c00/6t8lXUMWInKyD1RsLv9Pbmkfc1QUTt80WoN9GMo8dytl++JBR20U5HHYpRzD
 AWlHBMko+JttQA4pCFdH9u4hdTyKBKtCyDnVWmY1yjfkK+1CTTL6l7Z3b5j5Z8YX
X-Received: by 2002:a05:6000:23c4:b0:3a4:f038:af74 with SMTP id
 ffacd0b85a97d-3a8feb70384mr10419135f8f.51.1751374598866; 
 Tue, 01 Jul 2025 05:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhY6fY0vW0A1tRTCKngCcUlYQb+E48N59lMhA7r02PzqgdYQvyiDJ6Pbl4GwMVVgLxbQg2VQ==
X-Received: by 2002:a05:6000:23c4:b0:3a4:f038:af74 with SMTP id
 ffacd0b85a97d-3a8feb70384mr10419115f8f.51.1751374598346; 
 Tue, 01 Jul 2025 05:56:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52c23sm13320882f8f.52.2025.07.01.05.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 05:56:37 -0700 (PDT)
Message-ID: <5618feb5-f826-4436-993d-4486465dc877@redhat.com>
Date: Tue, 1 Jul 2025 14:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-3-shahuang@redhat.com>
 <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
 <ba75ac62-db52-491e-8944-2bf27106d0a6@redhat.com>
 <8c3cce88-fab5-4bf1-bc6b-804730e9889d@redhat.com>
 <3s45ekea2lotfcyrldxjmaybxujmfjrxemozoivnc2tq3qxfew@naef2yhuealw>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <3s45ekea2lotfcyrldxjmaybxujmfjrxemozoivnc2tq3qxfew@naef2yhuealw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Gerd,

On 7/1/25 2:04 PM, Gerd Hoffmann wrote:
>   Hi,
> 
>>> If those machine types need to set it to true. I think they can set it
>>> after they have this property.
>> nope it does not work like that. In case we really need to take care of
>> this, this must be handled by compats.
> 
> ramfb is a sysbus device so it can only used for machine types where it
> is explicitly enabled:
> 
>   # git grep machine_class_allow_dynamic_sysbus_dev.*TYPE_RAMFB_DEVICE
>   hw/arm/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>   hw/i386/microvm.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>   hw/i386/pc_piix.c:    machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>   hw/i386/pc_q35.c:    machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>   hw/loongarch/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>   hw/riscv/virt.c:    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
> 
> So these six are the only machine types we have to worry about.
> 
> The three x86 machine types (pc, q35, microvm) will actually use the rom
> (when booting with seabios).
makes total sense. So microvm is needed as well.

Thank you for the confirmation!

Eric
> 
> For arm/riscv/loongarch virt we want disable the rom.
> 
> Everything else doesn't matter much because ramfb can not be used in the
> first place, you'll get an error like this when trying:
> 
>   # qemu-default -M isapc -device ramfb
>   qemu-system-x86_64: -device ramfb: Parameter 'driver' expects a dynamic sysbus device type for the machine
> 
> HTH & take care,
>   Gerd
> 


