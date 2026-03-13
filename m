Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CA5106FD9A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 07:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xIX-0008Vq-Im; Fri, 13 Mar 2026 03:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xIW-0008Va-OA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w0xIU-0000El-R2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 03:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773388261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hxrJffsXDfc0dqTXCzxSRDyygiSU57eawDECedq5aAo=;
 b=L/9k/euiqt5hlXBnLtgy55OeQ/LR+oQO8x9CAabHx2ndhow6srbFkPfoL/ew6hcbnZ9NTG
 MiX47GgHv68f/Tkk1Qw9gVAOKMYlYxIbQyx9h83ol+ZTKsvGZxuUB84vSEytebsZdCvymv
 xv09/SXJpuCJjwuv+iWn8nHnF9WL/XI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-_4FJXon3MVmE_qjHxEEykQ-1; Fri, 13 Mar 2026 03:51:00 -0400
X-MC-Unique: _4FJXon3MVmE_qjHxEEykQ-1
X-Mimecast-MFC-AGG-ID: _4FJXon3MVmE_qjHxEEykQ_1773388259
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439b8bc43aeso1462093f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773388259; x=1773993059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hxrJffsXDfc0dqTXCzxSRDyygiSU57eawDECedq5aAo=;
 b=oIIBU7TaiEcmnEJy0VZ70iZRpjNFlp8t7Y1SbhebrFW3ux8hXT+VixSv8kpeUk2hHe
 vOQoYJ23Q3DtkpBwZNY1q6gZYHQQ1foMf/4NJn2Q5/awAyIRMqsV+Z75wnuBo0C0HSzk
 FWHaX3iz5zkO+lcb/5TP1R4DImH2j3xJViSoOFCOwgF+6tWPZHwrW6xRYQak2orXl37x
 iZV0DYR+/iEMvOS8wa96OTsgtjr2NmhhNfh4KjRxBT/N3y85mQQ9/wLrBXnKxlikHlf8
 TAg5apuDHEfB+p5x9hGoa0eZDU8LHaW7BtH4Fg7MLawejQEVcP6rsOw2idsbmmLv7aQw
 7TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773388259; x=1773993059;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxrJffsXDfc0dqTXCzxSRDyygiSU57eawDECedq5aAo=;
 b=QHPBOPvmd4RbYdQo7Dxacjm4P0qaVkHgEcSri42Xqw2aB47fQ9VYmAm8Ip2BXyDD+1
 fvFAh29T/c1FR+RnYfKyOxNG18ah0Daw//acFA7UN0bdcHMa0LuBUgNJVGm1hHCX295z
 AgrOds7QbVCPOT73gnuWd4flZehrA1yNPNZy04gf/vmCtKSKLtsLa6r1jhQI8RzAYLrY
 mFUkRaSRUzYI41eY0MQUmBB5O+Ak9Lrv4N7/wjkoJjix1d6LaX2IiCK/ehOZv6ODMuHR
 c9q1JniZ2kk0Eagt7xoLaC/pNU9Rir2jDkYkCZlQJZiBkGWe14qxVaCjesNpx+K7SMcH
 5lcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCpIwlzvOnc0EyEN/uQ1c9IWMbc9kcPQ7saQbxyeH2c+i0UD1rvnUVyl+B1pwuBbIge0lxh1YPg7zi@nongnu.org
X-Gm-Message-State: AOJu0Yzi+kib7qln0cnjUS4hjKwG+ryENF98rJgMRn/5Wihc/svw7Fri
 y7zzBV7N9/3Cd4Yn/8saXt4Y2r4JXrmpbPGUU9XSsZMbT2DJs9amAjXfoOT++aZiT6XQI4Bu2vj
 51qB7w79tCc5YqQpNoGLkX0pOpSQyzRdzyGqNt3jqpg54/pRLMOb7krAm
X-Gm-Gg: ATEYQzy7vNMeCOVNinuyuVN7plNAHbXhBvKst6EloC3oRAsjm19FJf4H1NceAMbbnoK
 8LfKpTbXaZG9wuO8UtAzLUlGKfAIj5OEq4+zipL37Z4njAx1vbp+GZCR+/tsXzPllt2b0v+Ilr+
 kf/3mYCYJf+73r7i4Gmrh939dixbHtBTFKkha+T5hcpXQTTxd4lmmDytsXuwpe1FtWlbgh7bHpe
 mOQTI2RQpzm8wu2ZaFV6+kpS8nldlrnotHSXPYzgsOBGdP8LS7MADGM1Hyp7MaTEz1FtF1u759D
 FNpgaDIKc+P7Y0wRzITcCEJFd+MczCxJNQdU2VJOUijScM/duzzXaYT4xUWLc3WAucyt6rZ9hxL
 dQ2WUZx02XmtLCEA2DXPQkWjN8gs6xEuZ5qQctqruLZr+Y+gipSTAkk+8hDO1
X-Received: by 2002:a5d:588e:0:b0:439:cb20:f30c with SMTP id
 ffacd0b85a97d-43a04d8708dmr4401443f8f.23.1773388258766; 
 Fri, 13 Mar 2026 00:50:58 -0700 (PDT)
X-Received: by 2002:a5d:588e:0:b0:439:cb20:f30c with SMTP id
 ffacd0b85a97d-43a04d8708dmr4401418f8f.23.1773388258298; 
 Fri, 13 Mar 2026 00:50:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm16054276f8f.7.2026.03.13.00.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 00:50:57 -0700 (PDT)
Message-ID: <61656692-dc0f-4e34-8b81-c2422928d017@redhat.com>
Date: Fri, 13 Mar 2026 08:50:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] hw/vfio: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/12/26 23:44, Pierrick Bouvier wrote:
> This series makes changes to hw/vfio to compile files only once.
> Changes are pretty straightforward and are mostly extraction of kvm/other config
> specific functions to proper files.
> This is the last hw/* subsystem that needs to be changed for single-binary.
> 
> Pierrick Bouvier (8):
>    hw/vfio/listener.c: remove CONFIG_KVM
>    hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>    hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>    hw/vfio: eradicate CONFIG_IOMMU from sources
>    hw/vfio/pci.c: eradicate CONFIG_KVM
>    hw/vfio/ap.c: use full path for target specific header
>    hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>      hw/vfio/kvm-spapr.c
>    hw/vfio: all vfio files can now be common files
> 
>   hw/vfio/kvm-spapr.h          |  12 +++
>   target/s390x/kvm/kvm_s390x.h |   2 +-
>   hw/vfio/ap.c                 |  11 +-
>   hw/vfio/ccw.c                |   9 --
>   hw/vfio/helpers.c            | 172 -------------------------------
>   hw/vfio/igd-stubs.c          |  20 ++++
>   hw/vfio/kvm-helpers.c        | 192 +++++++++++++++++++++++++++++++++++
>   hw/vfio/kvm-spapr.c          |  47 +++++++++
>   hw/vfio/kvm-stubs.c          |  35 +++++++
>   hw/vfio/listener.c           |   4 -
>   hw/vfio/pci-quirks.c         |   5 -
>   hw/vfio/pci.c                |  37 +++----
>   hw/vfio/spapr.c              |  30 +-----
>   hw/vfio/meson.build          |   8 +-
>   14 files changed, 331 insertions(+), 253 deletions(-)
>   create mode 100644 hw/vfio/kvm-spapr.h
>   create mode 100644 hw/vfio/igd-stubs.c
>   create mode 100644 hw/vfio/kvm-helpers.c
>   create mode 100644 hw/vfio/kvm-spapr.c
>   create mode 100644 hw/vfio/kvm-stubs.c
> 

I am glad we are getting rid of #ifdef CONFIG in the code. I wonder
why we stopped using stubs in the past.

Anyhow, as said, what bothers me with this change (which I like OTOH)
is that it is exposing IOMMUFD support at the UAPI level. But,

1. only i386, s390x and arm have IOMMUFD support. Not PPC for instance.
2. downstream can compile support off

That said, support should reach all platforms one day. So we could
say that relying on a runtime check is preparing the future. I am
not against the change but it needs more thinking on the consequences.
IOW, a bit late for 11.0.

The idea is great. Let's try for 11.1

Thanks,

C.



