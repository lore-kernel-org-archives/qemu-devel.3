Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BEEC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 10:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzDkY-00039j-7z; Tue, 23 Apr 2024 06:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzDkW-000388-8x
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 06:51:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzDkT-0006bc-FE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 06:51:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571bddddbc2so5193369a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713869499; x=1714474299; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1YpsJsGLOcexEKLGasuQ7e8Gc33mV0ELll8vIjrfT4=;
 b=RQ8xpj83X4541rrA27gWJAGS7MlNLRZu4uzEKfA9JO2ZibmliNtspO5DHwGyDDqDaG
 b93FSmNDf1lnAgG9lcvd3YBVr4p2WihTNX77vRe3LmBFQp59FT4erUfnJs4ZjKKzi2Or
 s2YXjPWt6FO06GvK4C4VDmH1evUfFf+66tEAudIZKrFabUro+zv1ja/r8TI9q+nqaklc
 Ini9aV7rqmikhMzM0+FwFsgL9UOha4ynyXYrpJSnZB7hDjiRdNa2YsUkHQWwnHzllnIW
 Hi1tkPBrGucXEzV0C34Zo4debz5Lv8eJWN4BvYAgs/tcAZMQgVKmHyYWCRZ8bUPH0nNN
 ipzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713869499; x=1714474299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1YpsJsGLOcexEKLGasuQ7e8Gc33mV0ELll8vIjrfT4=;
 b=qENie25SE3XfT82h6vViA9QH+ILKTdSU9FEI0T+VleTzRnf0OBS3o+bDTKtFL2SRdr
 k3tfCvYcDPGs719GcyKF/YWX5Wtdn+jT5YoHWgHsdxCBgit4RLa0Xt39Wh/MsYi15wAQ
 r4LcL7qvET5b3Nbym3DNWCGjsDCCvh0n7dWC1rNKSCkfwQlDxENhkdHFuFu5Det704Rq
 VTvRlPSOvngHHbJgQabzBHOC/jfMxCJcY5MQ0ud7AVofr4U/PZaRGivDr44R1iyaduSr
 TjELb/5qA5yLBksoD3x96eJZAtaAWvtO4b2c7sXYYHwgeHjqAU8T7sWFXsnZU07U7iu4
 xm8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIj1PbbPKWwj3vCemlEIP6zG165RITCwYa0XfAFTJU34nUgS4X6rA2Gvd4EIoZqg22E+2mMWoXORUQDjqCeUmR2NkNxnc=
X-Gm-Message-State: AOJu0Yyo3IqMPw/258e86BvJPyqjkqLPsv+NtPMTBqGHhiCAmiJZxF9p
 cXINB0HuhjFa9o/SYKXjvgOYD1oyaBwMaNqWjlDKBYu9qBRWE7b0GbDZL/anUcCqRkFwwaoorax
 h56H3X4+fMo8fTX7euOufVrw89MY5rbkTTeUBiQ==
X-Google-Smtp-Source: AGHT+IGaTTKJEvfRL+Yh7sYhby18iJelJQFqB58nDnmPUbXV9LMXZwXdwwR580tdJJp5feijkG8goflMh9E7sBXblPY=
X-Received: by 2002:a50:c31c:0:b0:56e:2ab1:c803 with SMTP id
 a28-20020a50c31c000000b0056e2ab1c803mr9163639edb.0.1713869499076; Tue, 23 Apr
 2024 03:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240412081328.11183-1-adiupina@astralinux.ru>
 <CAFEAcA9wfzpc74iA_2G-YbtQtwGCA9VPQuXagg-Q0FwC92tg+w@mail.gmail.com>
 <CY8PR12MB8411CAB26257B5974DAE2CA2E60F2@CY8PR12MB8411.namprd12.prod.outlook.com>
 <aa967494-d3d1-4896-8006-b5fc2252a56e@astralinux.ru>
In-Reply-To: <aa967494-d3d1-4896-8006-b5fc2252a56e@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Apr 2024 11:51:27 +0100
Message-ID: <CAFEAcA9JXOxkbQP6-1uTK+hG5yvYRcO31PYFZSxGjfrPis1nYA@mail.gmail.com>
Subject: Re: [PATCH RFC] prevent overflow in
 xlnx_dpdma_desc_get_source_address()
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "sdl.qemu@linuxtesting.org" <sdl.qemu@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 23 Apr 2024 at 11:23, Alexandra Diupina <adiupina@astralinux.ru> wr=
ote:
> 17/04/24 13:05, Konrad, Frederic =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Peter Maydell wrote:
> >> Also, this device looks like it has a host-endianness bug: the
> >> DPDMADescriptor struct is read directly from guest memory in
> >> dma_memory_read(), but the device never does anything to swap
> >> the fields from guest memory order to host memory order. So
> >> this is likely broken on big-endian hosts.

> hw/dma/xlnx_dpdma.c defines a dma_ops structure
> with the endianness field set to DEVICE_NATIVE_ENDIAN.
> Doesn't this guarantee that there will be no endian errors?

The endianness on a MemoryRegionOps struct tells the
memory core how to handle guest accesses to the
*registers* that struct is for. So if the .endianness
is DEVICE_LITTLE_ENDIAN and the guest is big-endian,
the memory core will byteswap the data values. That
means that the read and write functions always take
and return "value" arguments which are what you expect
(i.e. the guest wrote 0x12345678 and the write fn
value argument is 0x12345678).

However, if a device does direct accesses to guest *memory* (like
a DMA-capable device will do), that is something it has to handle
the endianness for itself. (The device's manual should say what
way round it does memory loads.)
There are two basic ways a device can do guest memory access:

 (1) we provide functions which say "load from guest memory
 a value of this type with this endianness"; for instance
 ldq_le_dma() will load a 64-bit little-endian value into a
 host C uint64_t, and ldq_be_dma() will do the same for a 64-bit
 big-endian value. There are similar functions for stores.
 This can be the simplest approach but it's a bit less efficient
 because it goes up and down the memory subsystem for each data
 item being read.

 (2) we provide functions which are "load/store a sequence of bytes
 from guest memory". This is what dma_memory_read() does.
 Because it's just a sequence of bytes, the device code is
 then responsible for interpreting what those bytes mean:
 maybe they're just bytes, or maybe they're a sequence of
 little-endian 32-bit values, or maybe they're something else.
 The device code also has to deal with the fact that the
 alignment of these values in memory is not necessarily the
 same as what the host CPU requires. These things together
 mean you can't simply cast the pointer to a sequence-of-bytes
 to a host type, or tell dma_memory_read() to write the
 sequence-of-bytes to a host struct type. We provide functions
 like ldl_le_p() to say "read a little-endian 32-bit value
 from this host pointer location" to assist in pulling
 values out of a sequence-of-bytes array. Or if the data is
 all of the same type (eg it's an array of 32-bit values)
 you can dma_memory_read() it into a host uint32_t[] array
 and then use le32_to_cpu() to convert those uint32_t values
 to the host's endianness.

(I use the dma_* family of functions here as an example since that's
what xlnx_dpdma.c happens to use; the same general principle applies
for our various other families of guest load/store functions, like
the address_space_* ones.)

thanks
-- PMM

