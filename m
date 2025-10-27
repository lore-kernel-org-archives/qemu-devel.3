Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B49BCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 13:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMve-0004uC-Oo; Mon, 27 Oct 2025 09:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDMvb-0004pv-HO
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:06:27 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDMvV-0002gq-3k
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 09:06:27 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63e0fa0571fso5429297d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761570377; x=1762175177; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbLnTOZ5dc29klY3Pz6juTMQ43cJEngDbz2ZTNIvbbM=;
 b=DaXWlgNQU2Q4JbY9FRvJ01BfZHEltEZmHTcbQ9B2pCV/tkIfgC/BhN+2dwsewBliiC
 1LB2hkgYyiMVUb7oxYjA4qQo/6Ru5TMBtcOjJE/JOKqOKJRKm0L6Y0x3lWTo+xLOXsij
 sgdoLykwwZ+be5CiUM6uM5vuVbq4gbSPutvPMyThwaNo4J24PMAn916Xoi2WProEwlYR
 z4t4XG5Dur27cR23YZRLFMhRCEyhEfh8g7GnO8/i7pGMt7sF3/9eqAeNTLHijYgqg97j
 Z1icyEtM6NeaGpg9+2D/x7Vjv1Zfuxb+0nufCxsXzVL/zw749VP7/fqXDDyPxNxlhMhu
 gbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761570377; x=1762175177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbLnTOZ5dc29klY3Pz6juTMQ43cJEngDbz2ZTNIvbbM=;
 b=bwr5kDifoRO/pm7KQY+B83husWbcsjRqrU+bTWvhS5rBGZG13LkERq/F3LOb1QX+FL
 W7ZQLWMmrSqM0L2JpL0eacK1Bmqc3Lj5X8pNj0aNNKRAYeZwM6PzM1bNubxtJVvveoZN
 R1P8M7YjA8ox9DehW3L73W4xdGZDaLQX4XcFSi+JXaK2xRCHgiq5FUu4cwV5n8t1K3RF
 fApBzCSojVrRCKpN5eWrfVkk2w1pDset5TwFd6AyrdVCrV800/RcdjIXPpa7ZUYF8joF
 H5/dpBecvW0QP1gtd/E6Nr0JcCQlNySJ6QWjoQs7vgBMqttRpG7JNNFZUtCAXCJrZomK
 D1tQ==
X-Gm-Message-State: AOJu0Yx3c5DmUwMa6DTEc2xNHH86I5LSte4vr22Tlphf7s/yJvpklw8p
 63S9DDcvNeA0BHVpruw0yeW95vaDx2BRvN/AZ555OV8i4q3DE+YStU5MgCFsyFD5JZg0N8o532L
 av9zKTcIhN5yteUCuaqAGhgzulSBio7b8jEFHzdRzsQ==
X-Gm-Gg: ASbGncvDz+XePq/emdVJL3hXuX0ANZ+8wkHTRnxbOHVABHqTVQOwAO3XYTMGLMav1CP
 suQipANxAZ/BdRmy0dRGRkdOwhk9/y/+U5v3NJm+3JmgJUPjhDcP4gPk2v1RZ2mz20PChgqE8wE
 czGWJPtCT0SSSBze67bS2oyTdpbtnfs4FXhHIzNRxKY3rXZ6sGYOOj9nwnZpn/hmDIB+lbnBz92
 swwWB/i/k/LFKfqxhpYMeyTTmVtGOh4P9TZoDE/5sXGOWlHv2Y6fjPSMJQ/TA==
X-Google-Smtp-Source: AGHT+IGSiS318/R5cb6n5eciQERL4NedGwx58KsccbfsAiHZzpd5ajDNJfH+xHztlqXIN0Y5u7P0q8+H2j77GfHfVIM=
X-Received: by 2002:a05:690e:1289:b0:63e:2715:5ac9 with SMTP id
 956f58d0204a3-63e271564e5mr27252237d50.38.1761570376404; Mon, 27 Oct 2025
 06:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
 <20251023121653.3686015-28-harshpb@linux.ibm.com>
In-Reply-To: <20251023121653.3686015-28-harshpb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 13:06:04 +0000
X-Gm-Features: AWmQ_bk2C3lt5IrpBSnm07BQk7ubk6al-dNSNye5GUzuuEWvU8peCuMSI9699pQ
Message-ID: <CAFEAcA-SPmsnU1wzsWxBcFC=ZM_DDhPEg1N4iX9Q4bL1xOnwBg@mail.gmail.com>
Subject: Re: [PULL 27/32] hw/ppc: Preserve memory regions registered for fadump
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>, 
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Thu, 23 Oct 2025 at 13:25, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> From: Aditya Gupta <adityag@linux.ibm.com>
>
> While the first kernel boots, it registers memory regions for fadump
> such as:
>     * CPU state data  (has to be populated by the platform)
>     * HPTE state data (has to be populated by the platform)
>     * Real Mode Regions (platform should copy it to requested
>       destination addresses)
>     * OS defined regions (such as parameter save area)
>
> Platform is also expected to modify the 'bytes_dumped' to the length of
> data preserved/copied by platform (ideally same as the source length
> passed by kernel).
>
> The kernel passes source address and length for the memory regions, and
> a destination address to where the memory is to be copied.
>
> Implement the preserving/copying of the Real Mode Regions and the
> Parameter Save Area in QEMU Pseries
>
> The regions are copied in chunks instead of copying all at once.

Hi; Coverity notes a bug in this code (CID 1642026):

> +static bool do_preserve_region(FadumpSection *region)
> +{
> +    AddressSpace *default_as = &address_space_memory;
> +    MemTxResult io_result;
> +    MemTxAttrs attrs;
> +    uint64_t src_addr, src_len, dest_addr;
> +    uint64_t num_chunks;
> +    g_autofree void *copy_buffer = NULL;
> +
> +    src_addr  = be64_to_cpu(region->source_address);
> +    src_len   = be64_to_cpu(region->source_len);
> +    dest_addr = be64_to_cpu(region->destination_address);
> +
> +    /* Mark the memory transaction as privileged memory access */
> +    attrs.user = 0;
> +    attrs.memory = 1;
> +
> +    /*
> +     * Optimisation: Skip copy if source and destination are same
> +     * (eg. param area)
> +     */
> +    if (src_addr == dest_addr) {
> +        region->bytes_dumped = cpu_to_be64(src_len);
> +        return true;
> +    }
> +
> +#define FADUMP_CHUNK_SIZE  ((size_t)(32 * MiB))
> +    copy_buffer = g_try_malloc(FADUMP_CHUNK_SIZE);
> +    if (copy_buffer == NULL) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "FADump: Failed allocating memory (size: %zu) for copying"
> +            " reserved memory regions\n", FADUMP_CHUNK_SIZE);
> +    }

Here we do a might-fail malloc, and check for error. But the
error case doesn't return, so after logging the error
execution will keep going in the function and segfault
when we try to use the NULL pointer as a destination buffer.

thanks
-- PMM

