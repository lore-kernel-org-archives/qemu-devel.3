Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFDFC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 15:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2tNr-0004JE-4h; Thu, 10 Apr 2025 11:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2tNo-0004IK-Dw
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:00:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2tNm-0002KR-0p
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 11:00:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso10455585e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744297195; x=1744901995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCmcz2CzAK+UTjRkfiSb14Nnc8/NhBxwkZdIjBJ0OQg=;
 b=e1K1fp+RIavN5aQag7xQ7k7DXvzjkixL6VYLE6X0/rpO+tAxPAPbPeJ+emUDe4gxFB
 EdqjtIqIANOAClRGIOrt0Y/g9zH/h5w4O8AaLp6l+Wh+2qhAAXqRA5qw6mGsZpdd7GDW
 8psvbhG9HSb45kjB8x5l+5y1E/7hiNp5OGRdateqbA8VxKX1Psd6SUUGYaQcxivNPi/P
 DrxcNar+TmuydFgFGki37bzcUhGizixrvzdXuya9+5vIMDD/NxXhnRWNv9Hd/zBp3jpA
 tSgqPUASQ/EOxtS7KQc8roVI0p3CUtgFe3ex+sMC5eBETDeEs8PGSv0koxeGZzHWvhYn
 YEyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744297195; x=1744901995;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YCmcz2CzAK+UTjRkfiSb14Nnc8/NhBxwkZdIjBJ0OQg=;
 b=qW/7CTAaI+JwK7J9r5m6v4+2KEOvCO5JQYb0/9zEWH9hlZjKHs6BdJzPrmmEk8q1f1
 ZmI1tOwCyh6sp8UJREll79YBsuMnp0bMqEAzMlw72HEGCcfc6Rj2et4IezWc6VxypYLc
 7pad6jw/w9nVzCHvGYdoWWp00WeHkUeM1z+2MH5gjM+TtydMC4k5p9ZxmxE5tqcPs2Xm
 VK9NRHyo+YXJnFDHJ2DUW+YtCts7n/UZHjPm/kQTbHc9DNM0eLyFX77BHN//KQeKV8Sw
 rIOL32IhjR3xOP07yanPY6e65KaVnGcKBaC5kIs3Ku7hOxq/lo6BDvhiANDzVmKmWz3i
 DuiA==
X-Gm-Message-State: AOJu0Yz8uYa391FOZQpKs2xWMbsK+IcZir3EOBXagWz5fs5AOJVoRw/C
 WXmc2vpZfB/+2VxMEIJlVxiJdWE8AzTemSEYGHypYBhRi6Q19PG/SkZ/THFVdkk=
X-Gm-Gg: ASbGncvYH20YscoCp6sSMn5ZGMW5vWL/cqhqAgjiWRFdgxMzIh/frq95txPfFjy1Mca
 MsEBE/JAYR6RPPMFS37FSSnOxRyhYPX2ybevEiwGkLurzU83fbm6wtpVkBfgNIRo2uA5yeTC7Gd
 SN3YS6jAobNijuBHnfyDhOrjNiZQbyD0sJ7RDnIaOZiblI5XspNtfRZG1p0HQ5snp9Andq2vvxW
 tkXziRUuO2Z+w0TxjBFJy4r+vouDuuNh4XOfetTSGNM0lvOdrFqRC05k9SSoDqiOTRZ8lIQsra4
 PBj2s30YM7EVyB1+ntWNKjZ1m5LcOguVrT+3BbeEdRg=
X-Google-Smtp-Source: AGHT+IEbdn5uxCqRMQ1nF2JQXpxfhN8Abvua+f79AyPQJa5e+/OFGnnTIVymBBwjdcvVrZk4s2Ir6Q==
X-Received: by 2002:a05:6000:2a4:b0:38d:e6b6:508b with SMTP id
 ffacd0b85a97d-39d8fd3d2e3mr2740642f8f.9.1744297195434; 
 Thu, 10 Apr 2025 07:59:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b14sm5098442f8f.65.2025.04.10.07.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 07:59:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 269015F8B0;
 Thu, 10 Apr 2025 15:59:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: Re: [PATCH v2 2/3] virtio-gpu: fix hang under TCG when unmapping blob
In-Reply-To: <20250410122643.1747913-3-manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Thu, 10 Apr 2025 15:26:37 +0300")
References: <20250410122643.1747913-1-manos.pitsidianakis@linaro.org>
 <20250410122643.1747913-3-manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 10 Apr 2025 15:59:54 +0100
Message-ID: <87ikncf4et.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
> This commit fixes an indefinite hang when using VIRTIO GPU blob objects
> under TCG in certain conditions.
>
> The VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB VIRTIO command creates a
> MemoryRegion and attaches it to an offset on a PCI BAR of the
> VirtIOGPUdevice. The VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB command unmaps
> it.
>
> Because virglrenderer commands are not thread-safe they are only
> called on the main context and QEMU performs the cleanup in three steps
> to prevent a use-after-free scenario where the guest can access the
> region after it=E2=80=99s unmapped:
>
> 1. From the main context, the region=E2=80=99s field finish_unmapping is =
false
>    by default, so it sets a variable cmd_suspended, increases the
>    renderer_blocked variable, deletes the blob subregion, and unparents
>    the blob subregion causing its reference count to decrement.
>
> 2. From an RCU context, the MemoryView gets freed, the FlatView gets
>    recalculated, the free callback of the blob region
>    virtio_gpu_virgl_hostmem_region_free is called which sets the
>    region=E2=80=99s field finish_unmapping to true, allowing the main thr=
ead
>    context to finish replying to the command
>
> 3. From the main context, the command is processed again, but this time
>    finish_unmapping is true, so virgl_renderer_resource_unmap can be
>    called and a response is sent to the guest.
>
> It happens so that under TCG, if the guest has no timers configured (and
> thus no interrupt will cause the CPU to exit), the RCU thread does not
> have enough time to grab the locks and recalculate the FlatView.
>
> That=E2=80=99s not a big problem in practice since most guests will assum=
e a
> response will happen later in time and go on to do different things,
> potentially triggering interrupts and allowing the RCU context to run.
> If the guest waits for the unmap command to complete though, it blocks
> indefinitely. Attaching to the QEMU monitor and force quitting the guest
> allows the cleanup to continue.
>
> There's no reason why the FlatView recalculation can't occur right away
> when we delete the blob subregion, however. It does not, because when we
> create the subregion we set the object as its own parent:
>
>     memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
>
> The extra reference is what prevents freeing the memory region object in
> the memory transaction of deleting the subregion.
>
> This commit changes the owner object to the device, which removes the
> extra owner reference in the memory region and causes the MR to be
> freed right away in the main context.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

