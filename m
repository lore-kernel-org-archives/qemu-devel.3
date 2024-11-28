Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F01CD690FD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 11:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGcrp-0005Vb-OB; Thu, 28 Nov 2024 06:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGcrn-0005UI-Lj
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:39:27 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tGcrk-0006SM-RO
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 06:39:27 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-296b567bc30so225637fac.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732793963; x=1733398763;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TX+a8itqToDqf9COI8aVr0B6wZAA/5HasL2vlyoknro=;
 b=rTomja0Sau38t2yNfwjdtxRh2wDPdBrvJ+ZE0ERTnidLRnwpHhe2dRD6M2zo5kpq97
 aYXEHFoSV7VfMaUKB2QOf+KlIKFHsP0G/Q2OR/KYgaUz+FxxJv7GDbsJeLgDc8/EG7Ta
 brf+M4uXFQZSMjEJzTxC/u2TvfSe690ecFKOoe7DCWg40CPdk+JhA4GmuX+UaN7JQaHv
 wDj/xDCkQjq4qxJnGmdc3srHvcFcSxRCNRdmHiDkYbqMh1+6yBZyEaTQtEJUgyVbW9Cj
 A0YZF+/ukPFbuKNz4pc5TWYa1C83CYKetDCoi3ryFgKFrNXFeQ+HQNbJXGok/gcJOFv9
 lCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732793963; x=1733398763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TX+a8itqToDqf9COI8aVr0B6wZAA/5HasL2vlyoknro=;
 b=w/K8aOWaqNurzwItQpxR+QlkiruQ9x7ZGGDcn57EVeQkmO337GbObEidmWIOpmXhzs
 jheGIkDe8aXRfnHDll81z9QiJnr7hKBBoA8D4AdY3t7F+eRq/YPC6va8SFH/j3dDoxq7
 GW06b+REGKIkdt72KtOSTcYSyaZ4JhVZXK+5AwIxhHK2CYPZ/FicKFH4F3gd58TkU8C3
 iSbHiSNtKfonuFJf3ryAbG68lcjFpAD8FTX9evzrc0eiFkhze9XKBsyEwk4Xd0epjGan
 azswViHFA2c+JBBEa2ESUBNshhXUDg7MhupBMs2i139SmnwqnVZe0W1PGqAohcsOhfYd
 a9QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzk7wrA59IPV0CNgRMIbAHmOS/09HPk8fufVP/BU3zbyt4LFnlo/oSXlT0wg4O9Q41soDSt2hDN1LR@nongnu.org
X-Gm-Message-State: AOJu0YxQu7a0f82FL/tpZFr4PqzNr/HW9VddOAxJsAwsv8DbeylUKEzz
 QPcJPcecUE19JkHi1i48/3svaIUvBzWGh+zC5w27JU2uXHH75ta3h9hCN1dHcXI=
X-Gm-Gg: ASbGnctb2asjV2COCAPqNq8TYnuZGqHgNMAfku6ZZR0dA+JU+469Y2RvsYKo9FiFD9k
 gYwQakgVF4p8EK0hEMKHbu4pJIMk7+mxVsfcFVSox3tQ1WVKlQkCgRjLcbOV1YftHktC2zgOSml
 Pwa8s9g2QopcmhSafFwWIde9N6dHtmqrEAKTp6CsoRFQU07GKtYMCMhmUydF227lWRZk+4o9T7t
 K1BJlQXFuC4aTGtWEN8jfJdcFIQLH6M/ngMjN+5BPWTxAmWkCEZtJThptDmE88=
X-Google-Smtp-Source: AGHT+IHBau/gjZSMbVbpO1H+LQr1o21IsTQHRq9lg/eWA3ZqRIVPFzrD44n8jcswIItEN+AVTsaCQw==
X-Received: by 2002:a05:6871:e805:b0:297:28ee:8d24 with SMTP id
 586e51a60fabf-29dc449d397mr6267381fac.42.1732793963075; 
 Thu, 28 Nov 2024 03:39:23 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725f2d06sm269601a34.70.2024.11.28.03.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 03:39:22 -0800 (PST)
Message-ID: <9eec5182-28d8-46ac-8d00-a3eafb1e4f66@daynix.com>
Date: Thu, 28 Nov 2024 20:39:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241127150249.50767-1-phil@philjordan.eu>
 <20241127150249.50767-16-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241127150249.50767-16-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/28 0:02, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple defines a new "vmapple" machine type as part of its proprietary
> macOS Virtualization.Framework vmm. This machine type is similar to the
> virt one, but with subtle differences in base devices, a few special
> vmapple device additions and a vastly different boot chain.
> 
> This patch reimplements this machine type in QEMU. To use it, you
> have to have a readily installed version of macOS for VMApple,
> run on macOS with -accel hvf, pass the Virtualization.Framework
> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> and pass aux and root volume as virtio drives. In addition, you also
> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
> 
> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>      -drive file=aux,if=pflash,format=raw \
>      -drive file=root,if=pflash,format=raw \
>      -drive file=aux,if=none,id=aux,format=raw \
>      -device vmapple-virtio-aux,drive=aux \
>      -drive file=root,if=none,id=root,format=raw \
>      -device vmapple-virtio-root,drive=root
> 
> With all these in place, you should be able to see macOS booting
> successfully.
> 
> Known issues:
>   - Keyboard and mouse/tablet input is laggy. The reason for this is
>     either that macOS's XHCI driver is broken when the device/platform
>     does not support MSI/MSI-X, or there's some unfortunate interplay
>     with Qemu's XHCI implementation in this scenario.
>   - Currently only macOS 12 guests are supported. The boot process for
>     13+ will need further investigation and adjustment.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

