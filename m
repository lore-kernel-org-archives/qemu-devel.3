Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C92BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSEaH-0008El-D1; Wed, 27 May 2026 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSEaE-0008Ds-L7
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:46:06 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSEaC-0002V8-7L
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:46:05 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65c09c1d000so9549810d50.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779889563; cv=none;
 d=google.com; s=arc-20240605;
 b=IxqZcGwBRfOOQAIyRYSKjKiI0T/XIOm+bFoslNWbOc0EQcwp8Rm/9g4CRTdTci99R+
 B5ry1vNNnetGnsy0xAUZmGx1CNKpeBzRaA/SX5/tVT1/6HawN0FLxm6abOQnLQzXbJA1
 s6YCIPElUuR20WfwIjXEh/W8XG49S8OO7RpWS0ZAdR8P0UwDaLgwn8ADrt7K7y2+KYcT
 m1fYs55jiAMZ7b7awUknYQcGascoccBRIFWiksvwmS7Tad960jTamUMZgrkjnA9GSPkj
 MVJMil/I3R1z9NqwmYE1y+YRaliDqqnpAwCF3tPfPgDnITMtqeJK7gfJ2lXtPvGwukDX
 A2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zKez7CTsEAnr8w/XmrsR8XNxR2TmTtCqXl2btG1HJcQ=;
 fh=JxaqNUTa3rjBRt2iFCtZ9WPPa8f0nt/IFdycPpB373c=;
 b=LFqgKAiD190O383+qziItvAq+sYzrJcE4LCtebGBUZ2NZnI3g5hIETvq2RbNlaySN7
 C1YppztOedx/0gbuxBFXWfZXoQuW7NWnzNuSNQGFwdBuP/sO+UQtv5goPKFLhhzz1vnz
 vFBY/IFeBXhKUMtTndtZMrryAI6i3A1/hv+k9IWP/doEOvkqPadPvfHrIaH/6ITc7DA2
 K17708gE8hPcWyIlTGJgXzS6Es7nksOXRoQ6r3enLkTgS8atSv3pUKHgJgrhCc3//pLh
 JA6vQBVbO5R9j8Wx69uyO+8UH2ZjVN61QR/VD0iyYjhvhbVUuPc96vsh8ZpggX58VzRg
 7GxA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779889563; x=1780494363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zKez7CTsEAnr8w/XmrsR8XNxR2TmTtCqXl2btG1HJcQ=;
 b=NVeugKAY43G/4VVnqW+pI1zmmYZGp7dsfoQhVAAAIts8zCpSDWe+BmhnCQzf28G/y7
 vMpkmiWiA1TD+weXcXu7PI+iAqctG9WsfuWaM9nAh8xYIW0js+2Dit7kvBpMkKRVsool
 Nl5jHB7HPdTOd1m/tf+Qjxv/fZVPr4Y4NHnVAJcNc0WahN+fJIk/jabXad/W7wVOFKTh
 1SWOaiun4OckH2r5UJvX+evuuDkxGlv+oQB5K2+m3dkflXNaQv37mFUvaltmUQIy8jW8
 vnuF16H5VLAEa3zpmoFcdY9NWqrG8yPCvo4sFpBvJSuLhP6ogto82QARe4yr5vCvPwVH
 ZNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779889563; x=1780494363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKez7CTsEAnr8w/XmrsR8XNxR2TmTtCqXl2btG1HJcQ=;
 b=YNG/4T7xuGXqGhajnm/brBQbCyLu9VF23TNt55nIXwqeFAD4YYnAyncQyPXjVmugdK
 73WmsGQS55XqSdOC1tU5JAuAyaGvvIMbAiJsU3euxzBbtkz3PonJj87NSC/A6N9nPkwZ
 sj+a3T0M2crbX4BHDYVzlPFsNM7G1MP8Svlu+av965fr8MTfmZPSDfIPC3Wnvq2TeLEG
 akl2Aa4HmNhn66r6Di8TzIQ35hRIKSSTwYa6kGAFtCsoYgMk5eHXlohFHDLQyJdTeZ3s
 T71YJM5Rv2LV6UM/BgcT9VXHjVZpmRtVWRb0/7Evy4ngaBKmDuOnNYQmULHEyyWyJApa
 KV4A==
X-Gm-Message-State: AOJu0YyEkEDGCGtbHLPBTQbBCKiD3uVmyStuXLxCb5oIYVcKBM0TqLk9
 gFQWtKwJcHO5b9wROmgFT8IP2GJUoOPRa3oKQqVF+w1dKW84CLmNZALD2brJMSdn2JmGwkKq2RW
 /8iC/Z1EkWsCEbg+WUQe4gTlScnmLCSyBikmmTFp9kA==
X-Gm-Gg: Acq92OHI7tcAkVCKkEWXByFZspL+TeyzF+hWTfybJrOkT9Fiiqgt+O+np+2XH1LxPnX
 DA+WVdLUjmcIq2XATICIAOgWPsbAgJUqcFyTz4NlqcthQVx83fh49hGmugqU2tVx9EILMk1S7mb
 jnX1MDs172d8sFTjSR5lncIkUO2TLliriNNRij/dzp9j1j3k6Lsh9CkqytK4Jfkm0ZWstgWT4iT
 cBdzi24QcaSCdSP9SEQWkKDHdux7eYCg7ved4/eK/cm6ubafg2HuB71DwFnXsjG2/DogLuZ0XXG
 a5l2FjDxUsuCliuegECPCUU/+MjFG53GcQWdZ4PC6cYBXRLvDwb2itR0kCzJreTfI5BiH7Z0fFK
 YyA==
X-Received: by 2002:a05:690e:408d:b0:65e:275b:1631 with SMTP id
 956f58d0204a3-65eacf56157mr19849173d50.31.1779889562618; Wed, 27 May 2026
 06:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260527091711.3901-1-liugang24219@sangfor.com.cn>
In-Reply-To: <20260527091711.3901-1-liugang24219@sangfor.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2026 14:45:51 +0100
X-Gm-Features: AVHnY4IplAytSYRTBTrgi6tkD1HnCDxWyKPr_VUGUt_3d5RM7v06nx9cCuJFz58
Message-ID: <CAFEAcA8dwHV8F48kb-013rxkG9kKcZhym9_qarKmoeUfeh0YWw@mail.gmail.com>
Subject: Re: [PATCH] hw/net/e1000: Use address_space_stb for Rx descriptor
 status write on aarch64
To: Liu Gang <liugang24219@sangfor.com.cn>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, 
 Ding Hui <dinghui@sangfor.com.cn>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 27 May 2026 at 14:23, Liu Gang <liugang24219@sangfor.com.cn> wrote:
>
> From: LiuGang <liugang24219@sangfor.com.cn>
>
> In x86 environments, writing the Rx descriptor status byte with a single
> pci_dma_write() works correctly. However, on aarch64 with glibc 2.24+,
> the memcpy/memmove implementation uses a branchless sequence that copies
> the same byte three times when count == 1. This results in three
> consecutive STRB operations.
> Ref: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/aarch64/memcpy.S;hb=refs/heads/release/2.24/master#l124
>
> When the guest uses an e1000 NIC and DPDK, this behavior can cause
> packet reception to stop or packets to be dropped repeatedly. Under
> normal operation, DPDK clears the DD flag after processing a packet and
> then updates RDT. But due to the triple STRB from memcpy/memmove, the
> DD flag may be cleared and then immediately set again. This causes DPDK
> to consume the same packet twice, making RDT be incremented by one extra.
> As a result, RDH == RDT, and QEMU mistakenly considers the receive
> queue full, stopping packet reception.
>
> The issue can be reproduced on aarch64 using the adapted test program:
> https://github.com/cdkey/e1000_poc
>
> Replace pci_dma_write() with address_space_stb() to write the DD status
> byte directly, avoiding the problematic memcpy/memmove sequence and
> resolving the issue.
>
> Fixes: 034d00d48581("e1000: set RX descriptor status in a separate
> operation")
> Signed-off-by: Liu Gang <liugang24219@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>  hw/net/e1000.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 202ad40401..f7be035e0f 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -869,6 +869,14 @@ e1000_receiver_overrun(E1000State *s, size_t size)
>      set_ics(s, 0, E1000_ICS_RXO);
>  }
>
> +static inline void
> +e1000_dma_write_byte(PCIDevice *d, dma_addr_t addr, uint8_t val)
> +{
> +    AddressSpace *as = pci_get_address_space(d);
> +    dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
> +    address_space_stb(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);

I don't think there's any guarantee that we won't write
multiple times to the memory in this case either. This
eventually boils down to calling address_space_stm_internal
which for dispatch to RAM calls stm_p(), which for a byte
write will call stb_p(), which is "*(uint8_t *)ptr = v;"
and there's no guarantee in the C standard about that doing
only a single byte store to memory.

I think this change only gives different behaviour by accident,
not by design.

-- PMM

