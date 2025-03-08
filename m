Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3B9C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 05:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqmwZ-0007c5-KR; Sat, 08 Mar 2025 00:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqmwT-0007bj-I8
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 00:41:47 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqmwN-0008QN-Vv
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 00:41:43 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so169531f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 21:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741412497; x=1742017297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5WFaEsFe3qJ3kisaRibeM8uEMSNgoI4JChQW9/9rnjs=;
 b=dB0vUsZ6SB3RCerDKovcghIdvx4ck0uFQwT5WH0r9+jC2KgldwLIoWlJt43c93lxpM
 wFaCeHadJsZ7T8fLoroh3GITycznVnxTaJ7uuIfRszbDudsxhrd+uC0bJBwhsqxozZn2
 yU2S/q/ydrlKctZ8+T9Q5+OZ5Gc/+JkdCCLWLiq60Vw8cR7iwLr5b4l9zx0k24w2s5U8
 jnKoqmBaYC+buFHOyhel35KlRWrje9MdtBpYNdQ9ZNLdIru23pqJIAC5rPGNYUoIwNPt
 0qMii73LoKIRRQ9Pym2KiPLMLL9iTuzR16PxnADjWoXLT4JhV5sJs3ON1RN/dOIkFgKf
 e4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741412497; x=1742017297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5WFaEsFe3qJ3kisaRibeM8uEMSNgoI4JChQW9/9rnjs=;
 b=vYdsUoYOCx/06YnRCMp0dO57Bwrqf5V/ml/1skHo9SSbjyxzZVJNkdVAoQ45uQvLHd
 3a4NsixVxX2FHsTuNTTGsehqzA3NzGSuqiR1bjqM5K9x+CzY+nHxQ2PkI1+s6IAS0SIm
 RzSDbazgBKMp5oZ99Ly5qPG4b/1FQWXgr8eeVEb/hqUnjPijBTL//0lH6VWulD+Sn6Co
 JQ+G8qYBXFBM8ESjZcXhnp2Y2h3labZD8nVIaV/A5aEB1HBCkD6H7TyP1yXXlz+J/eCa
 dLa3T82ww6wP82N/7pEv9H/nmSfEpOe1+VdJbHE3qXKhGi3oU/vG6+h6SK/7gQMKzjJl
 WHvA==
X-Gm-Message-State: AOJu0Yx7BqSKbWoK9Nr6o+tr4+krQn9PXFjAT1c2eBR8gxbXWk1VgslC
 GTjDyR6KQWCo/xOZSlHEFrOsM63HWt6V8j/zQYqYdH+FwDXWPl6SbZE0pzapADWKSVZkDC6T2/i
 /b7w=
X-Gm-Gg: ASbGncvf6fIaSVXJpAfH2mc6qvGjxFI03QbLrekECFnjXO59ExUEny3e8xKamicgccl
 VTgVoRWAg09xmn2lAJH39SIIRSxlV8h3gIbHjqtr7Tyd0DF2j1uxXT7xBVorGELMsgi65ly27r6
 a0n9Us++fQ+lFmt4EiBJntT6CpgYCXZcF1wfuXU0yqBTvHnnum08KAbmAJE+m3E4/OEmzEDqPYt
 eYZ1cEuv9zNzLTGdp/2bWOZJBSb9VrNTt9+ZRNk77Vhow8gKVMrbtBgmk5kRVVuha2nLPlf0PKs
 KgAx5RZdrYf0gE2ulXuqDQyXiqszUtyxlRqIa8ggjorYIwpKMSY3BmqqNUei3Yr0BTL0Kmp07TI
 Ks9WucDwMoRW4wmDplr23X+I=
X-Google-Smtp-Source: AGHT+IEWXgzid5cKL9T0Gj+zmtqkohiWE2cP5/FrOuRqO8ng4EIrhtIhHMa2IfQYaS3uw44UmAPcWQ==
X-Received: by 2002:a5d:6482:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-39132d2affemr3489222f8f.7.1741412497513; 
 Fri, 07 Mar 2025 21:41:37 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01952dsm7483354f8f.45.2025.03.07.21.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 21:41:36 -0800 (PST)
Message-ID: <d3d441cb-933d-4ec5-b263-1235d7553a53@linaro.org>
Date: Sat, 8 Mar 2025 06:41:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250307223949.54040-1-philmd@linaro.org>
 <20250307223949.54040-6-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307223949.54040-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 7/3/25 23:39, Philippe Mathieu-Daudé wrote:
> Use qemu_arch_available() to check at runtime if a target
> architecture is built in.
> 
> Consider the maximum extent size of any architecture built in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio-mem.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)


> @@ -170,13 +171,24 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
>    * necessary (as the section size can change). But it's more likely that the
>    * section size will rather get smaller and not bigger over time.
>    */
> -#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
> -#elif defined(TARGET_ARM)
> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
> -#else
> -#error VIRTIO_MEM_USABLE_EXTENT not defined
> -#endif
> +static uint64_t virtio_mem_usable_extent_size(void)
> +{
> +    uint64_t size = 0;
> +
> +    assert(qemu_arch_available(QEMU_ARCH_ARM | QEMU_ARCH_I386 | QEMU_ARCH_S390X));

I'm not sure this assertion is doing what I thought it'd do.

For example, building with --target-list=aarch64-softmmu,riscv32-softmmu,
this device is now linked in. However, riscv32 machines won't be able
to plug it until they allow TYPE_VIRTIO_MD_PCI in some of their
HotplugHandlerClass handlers. Still I'd like to catch this case here
to avoid bad surprises.

> +    /*
> +     * FIXME: We should use the maximum of instantiated vCPUs ARCH, but
> +     *        for now it is easier to take the maximum of any ARCH built in.
> +     */
> +    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
> +        size = MAX(size, 2 * 128 * MiB);
> +    }
> +    if (qemu_arch_available(QEMU_ARCH_ARM)) {
> +        size = MAX(size, 2 * 512 * MiB);
> +    }
> +
> +    return size;
> +}


