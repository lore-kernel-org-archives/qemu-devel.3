Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A94EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1oyU-00070t-Ti; Tue, 30 Apr 2024 11:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1oyS-00070H-US
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:00:52 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1oyQ-0007R3-0v
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:00:52 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so7347833a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714489247; x=1715094047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fSU+ZrS1MIu/d9KmXHLetBql6l0rJVSDX7Igp1Lyz4g=;
 b=NnvzeTwO1R7baugqCPwVJMG3cbtRne1ANd3mzyTlMSV06M5WYw91lV1PVcDf1V6YZn
 zquro0MEaozBeqFF8hwbNuPI3e7YpgafpzFxrT2qeDlYhPgOpKYHT4NvZBgAKyGC1eCb
 RM8m86xL90ZwmD8CQ5Z1VC+gBXSEgBg53PFbhY/LTpprZeWuMepRreuX/APuC/hzUgHd
 1oBaeUISvAxcF3CV2vdOmuoFrHCPO/nDmX4do4dAp5i9vNpKozp+YIKNmEDZ/5u/9lQA
 JRodEeIr/cEbTw5ug2ETyrw37D0yQn2YgHKyNy/fy1M7fHB6mbxUgQ1mWWAg45jRTa+S
 imAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714489247; x=1715094047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSU+ZrS1MIu/d9KmXHLetBql6l0rJVSDX7Igp1Lyz4g=;
 b=Gl123IslkPef3bypq3swcApesEpSG++NCf1oLT5WCYil3YaJ9ZRxpgt2GvD5VaeOqq
 P7jp8J3UIyvt0gerfmRU/uqNHY6nBTzKvWlPO6BVolcmAipkc79dapJUv7nqqV8ooH8R
 fKrw/XXtePGU7RuuCYX32bkrEPA5/jLX0exvTtDbMpy6lIoVsbCOTtovoVtS+Erng4Sj
 HgKfjbvizFSUxMEGMBt627dneOP5qOmqJpwWxq4QLwuMIO++swGSL0Sz5JpAVtvvRhc1
 I3MaKq97Nt21orArGv2ojInMlRl/p47+n5bV1fTF4lOGq3R9ZMtfoV9XTblSErqJU2r+
 eslQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc4G/Wy3dnjM++tbTPKoP/5ZYdoabRdaxv4yHkA8i+Lep9cUI/wMcdmGtNgyOTZ+7d/efMdSE3yiBz5pxmlBNa/JoJtZ4=
X-Gm-Message-State: AOJu0YySHnbKv1XBVi+Rrr+kk9wHJWnUml3djDDcI8FZW+6JJgj/Cp2g
 q0ScI4kCV0aS5BbT/2iepMoigQ80zB6XnuJDFwwaIuwtX0lw8Dw2vIKcnHW4/0apEgWLemf4QeR
 zctxXuBK/RcIEBHfJQ4ZxeneACLDsW7PY6CEuuSfxFYZLzvBn
X-Google-Smtp-Source: AGHT+IGJrN1JofjNJJyHDrmr47rZlfpoB+hgpi/57YcLp1unLknsASa18HDkB6jWLe6Y0OmhKQOZVBg3pCRg6NL0Mmo=
X-Received: by 2002:a50:d55a:0:b0:56a:ae8a:acc0 with SMTP id
 f26-20020a50d55a000000b0056aae8aacc0mr32234edj.21.1714489246764; Tue, 30 Apr
 2024 08:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240428181156.24071-1-adiupina@astralinux.ru>
In-Reply-To: <20240428181156.24071-1-adiupina@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 16:00:35 +0100
Message-ID: <CAFEAcA9TBh8CnvW16hEu5sgLOd4VyKt8JGj0jGRTMw_6iTvP2g@mail.gmail.com>
Subject: Re: [PATCH v4] fix endianness bug
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: Alistair Francis <alistair@alistair23.me>, "Konrad,
 Frederic" <Frederic.Konrad@amd.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, 28 Apr 2024 at 19:12, Alexandra Diupina <adiupina@astralinux.ru> wrote:
>
> Add xlnx_dpdma_read_descriptor() and
> xlnx_dpdma_write_descriptor() functions.
> xlnx_dpdma_read_descriptor() combines reading a
> descriptor from desc_addr by calling dma_memory_read()
> and swapping the desc fields from guest memory order
> to host memory order. xlnx_dpdma_write_descriptor()
> performs similar actions when writing a descriptor.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: d3c6369a96 ("introduce xlnx-dpdma")
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
> v4: remove rewriting desc in place
> v3: add xlnx_dpdma_write_descriptor()
> v2: minor changes in xlnx_dpdma_read_descriptor()
>  hw/dma/xlnx_dpdma.c | 63 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
> index 1f5cd64ed1..e9133e9dcb 100644
> --- a/hw/dma/xlnx_dpdma.c
> +++ b/hw/dma/xlnx_dpdma.c
> @@ -614,6 +614,63 @@ static void xlnx_dpdma_register_types(void)
>      type_register_static(&xlnx_dpdma_info);
>  }
>
> +static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
> +                                    uint64_t desc_addr, DPDMADescriptor *desc)
> +{
> +    if (dma_memory_read(&address_space_memory, desc_addr, &desc,
> +                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
> +        return MEMTX_ERROR;

You should return the return value you got from dma_memory_read() here.

> +    }
> +
> +    /* Convert from LE into host endianness.  */
> +    desc->control = le32_to_cpu(desc->control);
> +    desc->descriptor_id = le32_to_cpu(desc->descriptor_id);
> +    desc->xfer_size = le32_to_cpu(desc->xfer_size);
> +    desc->line_size_stride = le32_to_cpu(desc->line_size_stride);
> +    desc->timestamp_lsb = le32_to_cpu(desc->timestamp_lsb);
> +    desc->timestamp_msb = le32_to_cpu(desc->timestamp_msb);
> +    desc->address_extension = le32_to_cpu(desc->address_extension);
> +    desc->next_descriptor = le32_to_cpu(desc->next_descriptor);
> +    desc->source_address = le32_to_cpu(desc->source_address);
> +    desc->address_extension_23 = le32_to_cpu(desc->address_extension_23);
> +    desc->address_extension_45 = le32_to_cpu(desc->address_extension_45);
> +    desc->source_address2 = le32_to_cpu(desc->source_address2);
> +    desc->source_address3 = le32_to_cpu(desc->source_address3);
> +    desc->source_address4 = le32_to_cpu(desc->source_address4);
> +    desc->source_address5 = le32_to_cpu(desc->source_address5);
> +    desc->crc = le32_to_cpu(desc->crc);
> +
> +    return MEMTX_OK;
> +}
> +
> +static void xlnx_dpdma_write_descriptor(uint64_t desc_addr,
> +                                                DPDMADescriptor *desc)
> +{
> +    DPDMADescriptor* tmp_desc = (DPDMADescriptor *)malloc(sizeof(DPDMADescriptor));
> +    memcpy(tmp_desc, desc, sizeof(desc));

The descriptor structure is not very big, we don't need to malloc it.
So we can do:

       DPDMADescriptor tmp_desc = *desc;

(adjusting the code below to match).

> +
> +    /* Convert from host endianness into LE.  */
> +    tmp_desc->control = cpu_to_le32(tmp_desc->control);
> +    tmp_desc->descriptor_id = cpu_to_le32(tmp_desc->descriptor_id);
> +    tmp_desc->xfer_size = cpu_to_le32(tmp_desc->xfer_size);
> +    tmp_desc->line_size_stride = cpu_to_le32(tmp_desc->line_size_stride);
> +    tmp_desc->timestamp_lsb = cpu_to_le32(tmp_desc->timestamp_lsb);
> +    tmp_desc->timestamp_msb = cpu_to_le32(tmp_desc->timestamp_msb);
> +    tmp_desc->address_extension = cpu_to_le32(tmp_desc->address_extension);
> +    tmp_desc->next_descriptor = cpu_to_le32(tmp_desc->next_descriptor);
> +    tmp_desc->source_address = cpu_to_le32(tmp_desc->source_address);
> +    tmp_desc->address_extension_23 = cpu_to_le32(tmp_desc->address_extension_23);
> +    tmp_desc->address_extension_45 = cpu_to_le32(tmp_desc->address_extension_45);
> +    tmp_desc->source_address2 = cpu_to_le32(tmp_desc->source_address2);
> +    tmp_desc->source_address3 = cpu_to_le32(tmp_desc->source_address3);
> +    tmp_desc->source_address4 = cpu_to_le32(tmp_desc->source_address4);
> +    tmp_desc->source_address5 = cpu_to_le32(tmp_desc->source_address5);
> +    tmp_desc->crc = cpu_to_le32(tmp_desc->crc);
> +
> +    dma_memory_write(&address_space_memory, desc_addr, tmp_desc,
> +                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);

I know we don't check the return value at the callsite, but we might
as well do "return dma_memory_write(...)" here.

> +}
> +
>  size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>                                      bool one_desc)
>  {
> @@ -651,8 +708,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>              desc_addr = xlnx_dpdma_descriptor_next_address(s, channel);
>          }
>
> -        if (dma_memory_read(&address_space_memory, desc_addr, &desc,
> -                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
> +        if (xlnx_dpdma_read_descriptor(s, desc_addr, &desc)) {
>              s->registers[DPDMA_EISR] |= ((1 << 1) << channel);
>              xlnx_dpdma_update_irq(s);
>              s->operation_finished[channel] = true;
> @@ -755,8 +811,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
>              /* The descriptor need to be updated when it's completed. */
>              DPRINTF("update the descriptor with the done flag set.\n");
>              xlnx_dpdma_desc_set_done(&desc);
> -            dma_memory_write(&address_space_memory, desc_addr, &desc,
> -                             sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
> +            xlnx_dpdma_write_descriptor(desc_addr, &desc);
>          }
>
>          if (xlnx_dpdma_desc_completion_interrupt(&desc)) {
> --
> 2.30.2

thanks
-- PMM

