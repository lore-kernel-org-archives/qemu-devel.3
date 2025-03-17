Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2161C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuDLa-0004ok-9b; Mon, 17 Mar 2025 12:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuDLX-0004n5-Gt
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:29:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuDLV-00070B-A8
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:29:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3122840f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228982; x=1742833782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ln4d4gvAzmGJBZmVUDpP7AJPF6NTOHZk/BoHYBhymHg=;
 b=CH7qFLZFeVFCcNcqW475YGxP8voq6QP56ERYRkxz1FqE+LgNxDfPx1sXCdprRMyMZ1
 2Lc0BXmxnK0hvnSRxHuilw6iZDzX2g6KG9o/fyfOq0Pc80qvkvBF2w+/oA3WeVBX7P+U
 dyHRRZvr3S6Rh9T2QsKY1jcrzrCb6oGnejcDExLQ2FIa5CJaqwCn+Oz7MVApcMdl7vsX
 PlfWbW/mXOwJLWGjimKfzftc8cTuqkSfjnUCp561155gUe1AHeEtJMDMnq4C9h5chTGc
 OasahXpHiSlyfeFBjYBOUkhkUlsLzUuCDhzfpH8nSerxqAHo9VpwgchhZr1qoRylY9uK
 Gxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228982; x=1742833782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ln4d4gvAzmGJBZmVUDpP7AJPF6NTOHZk/BoHYBhymHg=;
 b=vwUl4wgIB4wyP/zBq7faMSOHDSGlRn73Nf36PdpGLmvD9z8EDNUVQnp1Vqf8SyrVX5
 i1st4bixpi5sZ8ATilG4rut1tkxlv06YAjH5aVwFeiIPcbum5db/q03J4DP6JF3Uo2Cd
 hCSGlkjSNbz2WGGbRoxEjZYNR8M5PFdRwGbtP1DGwerIzeE+WtiGrOouQuQ0g8jJnHKK
 QhRrz4S6LCqa3n3KmWS3AfA1gJ4RZ4zIRS9bD8YcnUtczgOjHmJgNRWLwvWAsKtme3br
 W0f7Su8klaGeHSu+sZSeTZoeEEYc+wVNIJJEEJ/onxvbKIVWLSXrw6rZy/3xfIJJYwCG
 6TKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGmf6CF380UvqtsX02r61q17ffu/aDjY+3xOFLvsaMy6ltzXIkQxFTZIuSr3SpfVLX5WsABOOxAhUc@nongnu.org
X-Gm-Message-State: AOJu0Yx7ckTQEwCdh1NPEDha+qePz5TGoW+jeIruQmXXaK5ZrtiUT81m
 ydUACTIT7ituIXbCe7m8FyarXrL3eszLnEBnyGepuOykiDCFVv7zTdhkiyBYUy4=
X-Gm-Gg: ASbGncsKmzY/ZGcqbf8iuHCtCua+bw/kSmrskcUzl4noyGaarZtVcIlxOO5QNmxlTFx
 H6MG+AvT32ZIgsgLY87emuRhDTodSLeZN7992kEKe+m9buTc1C2ym9C2Jwfkz53f/9IYVWZ/hVD
 TA2UxMRpLs2KWkvDxC7xOIN0v3aRf8dYHrffyRh3H/HcqNAd+RsIU4vZgBkT0d/EbDuR99cWYIR
 wE/pSt73yD+QDtheNrpJfiNl8BJqppuzamIRiJGJmoAE26khiEs6OBzHfV1fb2xTsPEysoDBgSO
 dG9H/wsiytKpBRSeZUYqsIHe264jtoPv3gDBikcRaGtZyaPIIelTRZOIKSGDJ1PxR+l3jy7IA1V
 vt1anduO4ml800TM=
X-Google-Smtp-Source: AGHT+IEnbvdWzFM0wOapugQMdRzsKA5uXI0rPBbOfF+PLGr6WrdbruKZfHswqyhqanR7edIDxnt/6g==
X-Received: by 2002:a5d:64e5:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-3971d13498dmr13868110f8f.10.1742228982444; 
 Mon, 17 Mar 2025 09:29:42 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8881544sm15142287f8f.43.2025.03.17.09.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:29:41 -0700 (PDT)
Message-ID: <52c5485c-45ff-493a-a98b-59ab5c3963da@linaro.org>
Date: Mon, 17 Mar 2025 17:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: Also include md stubs in case
 CONFIG_VIRTIO_PCI is not set
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>
References: <20250313063522.1348288-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313063522.1348288-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 13/3/25 07:35, Thomas Huth wrote:
> For the s390x target, it's possible to build the QEMU binary without
> CONFIG_VIRTIO_PCI and only have the virtio-mem device via the ccw
> transport. In that case, QEMU currently fails to link correctly:
> 
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_pre_plug':
>   ../hw/s390x/s390-virtio-ccw.c:579:(.text+0x1e96): undefined reference to `virtio_md_pci_pre_plug'
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_plug':
>   ../hw/s390x/s390-virtio-ccw.c:608:(.text+0x21a4): undefined reference to `virtio_md_pci_plug'
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_unplug_request':
>   ../hw/s390x/s390-virtio-ccw.c:622:(.text+0x2334): undefined reference to `virtio_md_pci_unplug_request'
>   /usr/bin/ld: libqemu-s390x-softmmu.a.p/hw_s390x_s390-virtio-ccw.c.o: in function `s390_machine_device_unplug':
>   ../hw/s390x/s390-virtio-ccw.c:633:(.text+0x2436): undefined reference to `virtio_md_pci_unplug'
>   clang: error: linker command failed with exit code 1 (use -v to see invocation)
> 
> We also need to include the stubs when CONFIG_VIRTIO_PCI is missing.
> 
> Fixes: aa910c20ec5 ("s390x: virtio-mem support")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/virtio/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index a5f9f7999dd..cdb1836580d 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -89,7 +89,8 @@ specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
>   system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
>   system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
> -system_ss.add(when: 'CONFIG_VIRTIO_MD', if_false: files('virtio-md-stubs.c'))
> +system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
> +              if_false: files('virtio-md-stubs.c'))

if_false could be tricky.

https://mesonbuild.com/SourceSet-module.html

   source_set.add([when: varnames_and_deps],
                  [if_true: sources_and_deps],
                  [if_false: list_of_alt_sources])

   If all the strings evaluate to true and all dependencies are
   found, the rule will evaluate to true; ...
   Otherwise, that is if any of the strings in the positional
   arguments evaluate to false or any dependency is not found,
   use the contents of the if_false keyword argument.

I wanted to confirm true:ALL, false:ANY. Change LGTM then:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


