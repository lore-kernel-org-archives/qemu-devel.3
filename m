Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3536CF8843
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 14:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swjOL-00087i-CF; Fri, 04 Oct 2024 10:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swjOI-00087D-6Z
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:34:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swjOG-00051o-Bc
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 10:34:45 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b0b5cdb57so24086665ad.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728052483; x=1728657283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2UQSOFZOXFOIsHv2FYyOkZS02FnMoxlh+2uM5cIO4o4=;
 b=FrNWONzticDKqQ/EjqPomvSidxpth+tZIfvKwoDvGI8sVND0qzno1X4kg8VQemDhEM
 HL0Y0BpszBQIPTnDxpLowmkEKXSzWBJaQRpSUV3EcNUUG5vaPH6QbTVs3fbWSGbGAAR0
 AQVnh+WNWItpokx/1pIoefwOfFzTzhXbUFlwZpY/afdjz0gBie5/NvBCqyzQtO/jfqOJ
 EtSUqpG5adUx4JQ9Ti+jEw6z8Hrbqt0h+lD96yCQQQtl6tsvAz8A0wFn3xY8mOTjWQrx
 Ci9ZxN0XJQrFunaw4HnfDprxkGO/gpjHOmj1z87nLywW4xL3NIzfX6WttsjAzs7xjAGb
 BNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728052483; x=1728657283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UQSOFZOXFOIsHv2FYyOkZS02FnMoxlh+2uM5cIO4o4=;
 b=k5wzbqJCk2OMYSUDyhfLZAcNwEiv0bP2L5uJ4H2Z5bnlEDdS45GngiMPlHvyooVVOw
 YHP99ENmsYRwcQwi8zQGrLC34/uJz0JUMwHE4ia+btKgGKJTBV0fjitx1QYOpxIuApOE
 /Nf65clnbmg+h/tlenJJsWOC6bLtbPcjWlk2UcQrV0vcKVKRIahbt7reh3L4k6LQk0jy
 glA80phe0sSbYqFYFas1NRiIkR2IDXpRUcVsk7fxEv8/7noT97RCNDYu5l7xcSCPhzhc
 2RkSbyLcqmjBAUP7lj3y0iiz6IlxPF1cqX5KC102U0rUqMcGD4LIJ/qTeVXUr6AzKWKs
 NwCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ2NUt7lIECUkFGhLQofxZAzfZUgCDAFv3YkoB6/wvCMlR/ADomhBnhYhbj1ez+Rzti7tsrZd6B2/c@nongnu.org
X-Gm-Message-State: AOJu0Yxc9opwkfDHx6BPjN1AQhV8d8Ig7/3odoWZNHH7mpKeM0bbWA1p
 PwYGgcnNd+iZtcTIdZry8IbNkWI0A14Q5VoX4emQJvMyBXTYFUZDmbUiwlg8+cY=
X-Google-Smtp-Source: AGHT+IH43yvgDJ0NBkBWHrotLQgavmlwJ1QkHushaUnYRKAa3L8LNPzyZ1PN2m8obROzWBogiGm4rg==
X-Received: by 2002:a17:902:e94e:b0:20b:831f:e905 with SMTP id
 d9443c01a7336-20bff497da0mr47766445ad.12.1728052482531; 
 Fri, 04 Oct 2024 07:34:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beeca49ccsm24807595ad.66.2024.10.04.07.34.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 07:34:41 -0700 (PDT)
Message-ID: <1de09840-4689-47d1-bc26-47f19e050a08@linaro.org>
Date: Fri, 4 Oct 2024 07:34:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] accel/tcg: add tracepoints for cpu_loop_exit_atomic
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20241004135226.903570-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004135226.903570-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 10/4/24 06:52, Alex Bennée wrote:
> We try to avoid using cpu_loop_exit_atomic as it brings in an all-core
> sync point. However on some cpu/kernel/benchmark combinations it is
> starting to show up in the performance profile. To make it easier to
> see whats going on add tracepoints for the slow path so we can see
> what is triggering the wait.
> 
> It seems for a modern CPU it can be quite a bit, for example:
> 
> ./qemu-system-aarch64 \
>             -machine type=virt,virtualization=on,pflash0=rom,pflash1=efivars,gic-version=max \
>             -smp 4 \
>             -accel tcg \
>             -device virtio-net-pci,netdev=unet \
>             -device virtio-scsi-pci \
>             -device scsi-hd,drive=hd \
>             -netdev user,id=unet,hostfwd=tcp::2222-:22 \
>             -blockdev driver=raw,node-name=hd,file.driver=host_device,file.filename=/dev/zen-ssd2/trixie-arm64,discard=unmap \
>             -serialmon:stdio \
>             -blockdev node-name=rom,driver=file,filename=(pwd)/pc-bios/edk2-aarch64-code.fd,read-only=true \
>             -blockdev node-name=efivars,driver=file,filename=$HOME/images/qemu-arm64-efivars \
>             -m 8192 \
>             -object memory-backend-memfd,id=mem,size=8G,share=on \
>             -kernel /home/alex/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image -append "root=/dev/sda2 console=ttyAMA0 systemd.unit=benchmark-stress-ng.service" \
>             -display none -dtrace:load_atom\*_fallback,trace:store_atom\*_fallback
> 
> With:
> 
>    -cpu neoverse-v1,pauth-impdef=on => 2203343
> 
> With:
> 
>    -cpu cortex-a76 => 0
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Cc: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/user-exec.c          |  2 +-
>   accel/tcg/ldst_atomicity.c.inc |  9 +++++++++
>   accel/tcg/trace-events         | 12 ++++++++++++
>   3 files changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

