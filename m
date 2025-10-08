Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DB7CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Tdv-0005fo-Ji; Wed, 08 Oct 2025 08:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Tdt-0005fT-WB
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v6Tdq-0000be-7k
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759927892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LI6AUphzBVvs4dHAToO5jengAv6Y4sMj8+O2yMUJzgQ=;
 b=UJB5BSzpSm3ZJCYV8pudf5ZITEWKzygtJGAcTlkezxuEX7vHHOhhaWS62GG1DtPNyugYM4
 pddDBaEvhmmCUa5wwxlOgaAHG0EdQG1aLQeWq1ryg5I1wI8jkVqKecdRXEKcL+7ae7GYyZ
 i5tjICF6JXHqMME2LWTV6Yai+I2jrXU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-5FfQuHw1MEa1HDSbH0APfw-1; Wed, 08 Oct 2025 08:51:31 -0400
X-MC-Unique: 5FfQuHw1MEa1HDSbH0APfw-1
X-Mimecast-MFC-AGG-ID: 5FfQuHw1MEa1HDSbH0APfw_1759927890
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so3811534f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 05:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759927890; x=1760532690;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LI6AUphzBVvs4dHAToO5jengAv6Y4sMj8+O2yMUJzgQ=;
 b=JFARnpqeXuawgcQOD9KfWVu7paiIqv8sgDBp8hasP6cEUA2f/wfhmuqog/g65xOrtA
 2KYacgUe/4wXCYGRj1Bffxi8ZbN4tTW39kQA7Z33Brla6nNAEuzpNUlNlNF2Bv1Zpic4
 LuaoaSKfV/ig9m89w16DDf5JIuDNzH1rtfep3pwh4b6CxXzeZTTzopI8EAU4SQgmQdGk
 T5LEHBiL9BPpbMmmTMtemg3IMGDn53592pcl8kuShYEn8xrYWEyU8PmZM8C+bkx5G7v/
 vSnUnHWJlqTXuodBpM0U5pdq+a9m9f7twRi9JthY8d90h5CnHrdmPU855+6NWTnQZaVu
 a4QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgpp0Cp/Nvw5N3EgxShv76CYSvQ6x4o8++HJ/YIAdwMObPO6Z0HMd0cCaacPuTLSXWbQfBfvMCPeZ7@nongnu.org
X-Gm-Message-State: AOJu0YwU/bGeNJypbtTWe1xlh/igzw5QL3i/1iX0Uv/ye1Ul1/YnIMwk
 dwKicCZ5NpoUFR7tccpiFyUWwuPn3hM2aTsp77kyTdsR6HsWtZe/BNkv2J/HYE2Xmr2WfONTV2f
 rM4nDE5vRhFKhrPp+Qo4vYed/M6gqiohpWQifLdfXDGRFjznwhMcQh2t5
X-Gm-Gg: ASbGncumjPZyTQ9WSHL5I+zc4r2QSoXeSgAG3oWWodhruxoUEEq6vDLu63FqcnOd23h
 OlhJAw3YxLtOM7MxOfoadmPm6P31THIQc1QOFlDmjyNpMympUwvrqgkSqVet1muiWgcr+ziUAE+
 +TgKoMOMAm5hMyp3zzBXqCzTrC3EXqsbkbeCoujPTo7GD2TlJC4GeYOouXc7l1gGdNG5ctH9XDn
 bnxaWw4SHGhFj1UZRbI8liFD+yXDqggQBdVzczKHUMdEXZU1wDvcmuV6WZ7gjvQ82qeg8P1V+8w
 4QdYuG0/YPzpwWuvLEDrdogxepUv4zoaoIGwT0888bQDcNvVMjyGXRMK95P1mhcX0CUHnIFhz5V
 WrK4hNb4Vcg==
X-Received: by 2002:a5d:5d03:0:b0:425:8539:ed8e with SMTP id
 ffacd0b85a97d-42667177e89mr2037887f8f.23.1759927889928; 
 Wed, 08 Oct 2025 05:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpwqCLKoHkrxKT8mPNrz2jwFGrRqE6ThqK0h9cfMiESTWsC8Ef4gzjvb4wKnhrzvOWjAeAUw==
X-Received: by 2002:a5d:5d03:0:b0:425:8539:ed8e with SMTP id
 ffacd0b85a97d-42667177e89mr2037873f8f.23.1759927889551; 
 Wed, 08 Oct 2025 05:51:29 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-083.pools.arcor-ip.net.
 [47.64.112.83]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm29828137f8f.6.2025.10.08.05.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 05:51:29 -0700 (PDT)
Message-ID: <9e04c38e-507a-4b68-a522-7e9c4a130d9a@redhat.com>
Date: Wed, 8 Oct 2025 14:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x/pci: set kvm_msi_via_irqfd_allowed
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20251007205614.188365-1-mjrosato@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251007205614.188365-1-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 07/10/2025 22.56, Matthew Rosato wrote:
> Allow irqfd to be used for virtio-pci on s390x if the kernel supports
> it.  This improves s390x virtio-pci performance when using kvm
> acceleration by allowing kvm to deliver interrupts instead of QEMU.
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
> v2:
>   - add review tag
>   - tweak commit message (David)
> ---
>   hw/s390x/s390-pci-bus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index e8e41c8a9a..88852acf45 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
>       s390_pci_init_default_group();
>       css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
>                                S390_ADAPTER_SUPPRESSIBLE, errp);
> +    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
>   }

  Hi Matthew,

this unfortunately fails to compile without KVM (e.g. on x86 hosts):

../../devel/qemu/hw/s390x/s390-pci-bus.c: In function ‘s390_pcihost_realize’:
../../devel/qemu/hw/s390x/s390-pci-bus.c:903:5: error: 
‘kvm_msi_via_irqfd_allowed’ undeclared (first use in this function); did you 
mean ‘kvm_msi_via_irqfd_enabled’?
   903 |     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~
       |     kvm_msi_via_irqfd_enabled
../../devel/qemu/hw/s390x/s390-pci-bus.c:903:5: note: each undeclared 
identifier is reported only once for each function it appears in

  Thomas


