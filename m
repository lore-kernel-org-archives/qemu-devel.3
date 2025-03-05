Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E62C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpn3S-0003te-Sd; Wed, 05 Mar 2025 06:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpn3Q-0003tM-Qb
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:36:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpn3O-0000AK-PZ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:36:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-390e702d481so3126207f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741174604; x=1741779404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ytYA27Q3s5BIPQaX3M7QzuY4tIcbxkYiXbP3wMfjwa0=;
 b=tTFKPWf+8VqlkhZTLUEWHNT+Dlho1oTmBta9MR9CdXKVbcea6256RzccNqH4m/eAAd
 cfYHijmUR+GwnQ2ff4GLKQ9UyVuewPXKDIfxXphVwvRJaNC6EbXNE6U3oEhuVY4/XDFb
 4UX9DAOlJbwKIvkFcvGl78q2EtcJS1f98Q1+nSGx08vlsi+I4xzXzpEORwwQzobmPoTr
 J6TH/dnqtyV9IMDocBgXxlbMzaucl4Bvaybe4gwfOuRWpk8wX/TXMBWrONMZTnsa6gAk
 R8WNlrU+l2X+m3Qpe/T7vSwQGmkRCHHMz8JNN4OFMU63D6zCndfAKZ1jmD23ti0U5cXw
 0/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741174604; x=1741779404;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ytYA27Q3s5BIPQaX3M7QzuY4tIcbxkYiXbP3wMfjwa0=;
 b=PlEiyNTji1PEEK+/RIrXCMW24i/CrXfC/kClCNQbyhwJTytwGEvxavEJ65CAQeHBg4
 TwHNjOzV9VOE3CRMuEJWB8gRSEb37EkHpJp7Jir0eYxqlzo+qvt5FQyvWG5I+ksgbDs7
 QDQtOL56TOfz5KGFR8IaaQ4txxChz32l7Ku+oG+/FNRbDEODvLytCbJsJqElYV/Om2X1
 qEVSDgd2rUUeZNfsTreZtgdv1J5wVIHfr+iM3Eh8jDtG74WUE/nbZaEo3r/SR92DFxcX
 h1eN0axgvSkGNPf1jS8605xzY4fEAILD6BjIFoztMn88bofpfzGIG96Y3EZph3CkoJts
 f1nA==
X-Gm-Message-State: AOJu0Yw6n0j56QcxY7DEBSQGj+PYMuQ28FmDabmrqAIgKfgDRZp2NXd9
 4Ns1TUxBG3waMtUQ0jHpomTUZxe9m/ELFkIUv+FoDXuGyWXI1q8IEsaUTQWukvg=
X-Gm-Gg: ASbGncsqA/Oa52O1h+83XuRP2T0DLkMyYHAuaImtXb6uEnXHk1Psj7hY/4kNq+r2BpB
 8lCWvFS/qVeAtxYm3JuJIPL1rzsodLecs/FHWV/cZsKfYwZUxsJXbmgON4iqBJ6jGVriLUImh2D
 A//JG4Ex7CdpktYtVUWJrK3SXvno1luFUV4pbbTkJdv5U2oqEmjsXCBsrv8J7DSELOXdi+dl+2F
 pUMoU7sPuHgEsNdv7BKxmMqvZk3RVyMEir8w4N2EHZDRZe8LUeo0DNpn0odt6lOo5D+NQVY6h5R
 CLB5zvHRsQnKvHullfodhGyUj5GAGMn9NgCSu3D86CwpdLoQ1KVJwhfBuAtlEu41IPjzRLpB031
 zaaVYkNFfOPbO
X-Google-Smtp-Source: AGHT+IHS7ox2raWPac2OCgOsENuCnOaLuTc68kOatvk52CTF4CGabjxFi4zOceeDr8v1AgNdlgThrw==
X-Received: by 2002:a05:6000:381:b0:38f:2f0e:980c with SMTP id
 ffacd0b85a97d-3911f7d2fc9mr1894786f8f.47.1741174604570; 
 Wed, 05 Mar 2025 03:36:44 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39123939bbdsm1095415f8f.3.2025.03.05.03.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 03:36:43 -0800 (PST)
Message-ID: <a0982117-5602-49ee-9e0c-ef2f7c716e7b@linaro.org>
Date: Wed, 5 Mar 2025 12:36:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v5 09/11] hw/arm: introduce xenpvh machine
To: Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 Stefano Stabellini <stefano.stabellini@amd.com>
References: <alpine.DEB.2.22.394.2306151649350.897208@ubuntu-linux-20-04-desktop>
 <20230615235254.1366267-9-sstabellini@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230615235254.1366267-9-sstabellini@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/6/23 01:52, Stefano Stabellini wrote:
> From: Vikram Garhwal <vikram.garhwal@amd.com>
> 
> Add a new machine xenpvh which creates a IOREQ server to register/connect with
> Xen Hypervisor.
> 
> Optional: When CONFIG_TPM is enabled, it also creates a tpm-tis-device, adds a
> TPM emulator and connects to swtpm running on host machine via chardev socket
> and support TPM functionalities for a guest domain.
> 
> Extra command line for aarch64 xenpvh QEMU to connect to swtpm:
>      -chardev socket,id=chrtpm,path=/tmp/myvtpm2/swtpm-sock \
>      -tpmdev emulator,id=tpm0,chardev=chrtpm \
>      -machine tpm-base-addr=0x0c000000 \
> 
> swtpm implements a TPM software emulator(TPM 1.2 & TPM 2) built on libtpms and
> provides access to TPM functionality over socket, chardev and CUSE interface.
> Github repo: https://github.com/stefanberger/swtpm
> Example for starting swtpm on host machine:
>      mkdir /tmp/vtpm2
>      swtpm socket --tpmstate dir=/tmp/vtpm2 \
>      --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
> 
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>   docs/system/arm/xenpvh.rst    |  34 +++++++
>   docs/system/target-arm.rst    |   1 +
>   hw/arm/meson.build            |   2 +
>   hw/arm/xen_arm.c              | 181 ++++++++++++++++++++++++++++++++++
>   include/hw/arm/xen_arch_hvm.h |   9 ++
>   include/hw/xen/arch_hvm.h     |   2 +
>   6 files changed, 229 insertions(+)
>   create mode 100644 docs/system/arm/xenpvh.rst
>   create mode 100644 hw/arm/xen_arm.c
>   create mode 100644 include/hw/arm/xen_arch_hvm.h


> diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
> index 26674648d8..c7c515220d 100644
> --- a/include/hw/xen/arch_hvm.h
> +++ b/include/hw/xen/arch_hvm.h
> @@ -1,3 +1,5 @@
>   #if defined(TARGET_I386) || defined(TARGET_X86_64)
>   #include "hw/i386/xen_arch_hvm.h"
> +#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)

I suppose this is a typo and you meant TARGET_AARCH64 :)
Luckily TARGET_AARCH64 defines TARGET_ARM.

> +#include "hw/arm/xen_arch_hvm.h"
>   #endif


