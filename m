Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A361BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 10:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBXsy-0007cC-Ad; Mon, 27 May 2024 06:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXsw-0007c3-Mn
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:47:22 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBXsv-0000p9-0N
 for qemu-devel@nongnu.org; Mon, 27 May 2024 06:47:22 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-354cd8da8b9so1808537f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716806839; x=1717411639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LpeMjX6D8POMx6WrDZZ8ixRIdP6bS0/MxqegEy9Zk4c=;
 b=a9QqBOZgbouhYoNU7/1MXdIBVYwGcl+3MyS2Wh2pVd3YmEwJyagY5cAViW+CyOaFwX
 gB+R3eCpak0dj0tcaaK9l1jK/6N53VFOs21zkKbqCigycdvcHzFdAC7eV6B/nGOd6rSa
 Ku1CiJHTscLF3GqmBiQLACrHnwapzm1ojlfTylv4fZFddRDbJyoa0Y46gUUFJqc1TDki
 YcPHuQEOp1jyp3LF/t6fSe+T3VeeNUmLHQbbatVJUczj6uel5CZ02ag6ylhag5G438Jy
 tPGWCDBrOy7NOEJzIqT7Xe7TW/fADsclkE98iHPJ8v+ZUdB/+6nz70IEiZvoQIQl+Xa/
 GtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716806839; x=1717411639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LpeMjX6D8POMx6WrDZZ8ixRIdP6bS0/MxqegEy9Zk4c=;
 b=qpIB3qRCoX6nOWoz4TFTdL87VM4ZwKGj6eTlq9IpO8vHUcdpIPNKye1zCxfe/Q/V+Q
 mbXSIAAfAQKppbi+y/KAKWFhEWFcSmVXKOgpxSc5N/gnfeGdyZ8+zzbBQ6PR/ZmdqoHv
 R/LQ/3jIjxMUUO8pALmGOpJwYEI1n1qhCJ31UsS6ZDUxjnuY+aaz358p4aYMKNah5zuH
 Nx8o6bNAAFrVy868xHgHUVBuHIwJFZRPhegDGUfZGtHEYWNR+5tWDmwWaBZ4ACE++Xio
 ALZnM+RAouIvZoG4pmnxPmj3RWE/zDcp90obNqmYGyVKn8bi4l8iIiEcCc/rdt4SizmA
 yaYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGjab3bfFpujW+PTj2H4racB8+h986mPaFKsHf196lhLP84XZdVptyTPb7iJ1ZyD8+mBkgNY69ISLNvQ/ssJEw1BVSmPE=
X-Gm-Message-State: AOJu0YyIO+UdpYDygeJVojpQarCuJoDwU7W5lTqLAcbt3rPVJPUZ7ezk
 dGNJFChmZfeUPJlgTe/XvTvAODiJRFyfDQun6tdh8UnUyEJL03GP1VDEOk9pujI=
X-Google-Smtp-Source: AGHT+IHcI6AT20G0z4JrHsV0358fDgRTC06MUzV7LMDeGe8LfXZMjFvDsRgLAMkBNKnR60rgrOz6bw==
X-Received: by 2002:adf:fcce:0:b0:34b:81b3:2c62 with SMTP id
 ffacd0b85a97d-3552219d1e6mr5778049f8f.35.1716806839180; 
 Mon, 27 May 2024 03:47:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c92e7sm8719629f8f.66.2024.05.27.03.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 03:47:18 -0700 (PDT)
Message-ID: <bf9dc551-49e4-4ed9-941d-c095bab5755a@linaro.org>
Date: Mon, 27 May 2024 12:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] machine/microvm: support for loading EIF image
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Cc: graf@amazon.com, agraf@csgraf.de, stefanha@redhat.com,
 pbonzini@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20240518080753.7083-1-dorjoychy111@gmail.com>
 <20240518080753.7083-2-dorjoychy111@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240518080753.7083-2-dorjoychy111@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Dorjoy,

On 18/5/24 10:07, Dorjoy Chowdhury wrote:
> An EIF (Enclave Image Format)[1] image is used to boot an AWS nitro
> enclave[2] virtual machine. The EIF file contains the necessary
> kernel, cmdline, ramdisk(s) sections to boot.
> 
> This commit adds support for loading EIF image using the microvm
> machine code. For microvm to boot from an EIF file, the kernel and
> ramdisk(s) are extracted into a temporary kernel and a temporary
> initrd file which are then hooked into the regular x86 boot mechanism
> along with the extracted cmdline.
> 
> Although not useful for the microvm machine itself, this is needed
> as the following commit adds support for a new machine type
> 'nitro-enclave' which uses the microvm machine type as parent. The
> code for checking and loading EIF will be put inside a 'nitro-enclave'
> machine type check in the following commit so that microvm cannot load
> EIF because it shouldn't.
> 
> [1] https://github.com/aws/aws-nitro-enclaves-image-format

The documentation is rather scarse...

> [2] https://aws.amazon.com/ec2/nitro/nitro-enclaves/
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>   hw/i386/eif.c       | 486 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/i386/eif.h       |  20 ++
>   hw/i386/meson.build |   2 +-

... still it seems a generic loader, not restricted to x86.

Maybe better add it as hw/core/loader-eif.[ch]?

>   hw/i386/microvm.c   | 134 +++++++++++-
>   4 files changed, 640 insertions(+), 2 deletions(-)
>   create mode 100644 hw/i386/eif.c
>   create mode 100644 hw/i386/eif.h


