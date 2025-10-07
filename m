Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76965CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64J5-0006FE-7A; Tue, 07 Oct 2025 05:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64J2-00069v-0D
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:48:28 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64J0-0002ze-Aw
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:48:27 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-633b87e7b9fso5642466d50.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759830504; x=1760435304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jtdlCfNK0BXMpjaqSJ1lzhULTh9YXQ4rUodV2iUELMc=;
 b=dg+tbUEUsvtALy24Fo9rrD5UPRa7qD5xasPZFO88Pb3l858HufGPgx0G7GvuW17ylk
 FloazCHKcGNqc2VNZEgEMpJIUO9bQSkrDKqNNBFJQe5Og+N/9Vtu58azcoaOfysnO0LW
 Ho3N1g5gKymqIYF0Fe4fTkD0nNDUeQ50VbWvJOMMi4DPd0xAL4tqj1z5Jwnnaxz76FRU
 9Sp/dtcPBzLtkgU7EzM6FsiI+eY9LX0zHMTZvbZW+KJU26Yfh9QrpUUTM5iPmLCvDqgk
 x8dMguQh5it5qs0sEqX89RwvoT6IoL8WUnRm5k10kyBfk9RvehTn48gF+ixfo0x+kZ5u
 AS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759830504; x=1760435304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jtdlCfNK0BXMpjaqSJ1lzhULTh9YXQ4rUodV2iUELMc=;
 b=bnDbcJoqBgaUpg9j2wWzHOJEDSuMmW9DToruaNOguw/vECv80LUKrsQquxE5Uak5HW
 rSHFx/Q5Kf7s7v+UzL0mgE6sO3aPzcM0cYYF12FGAdNh/bboKmXVDZqP7+eO/prMHMIA
 fD29+S72AuWXl5RAoiIEvQ2fKBRwZZEbDgd3NQ77PIaOZHJB/V/a7zRP1PiLT3w/BMaL
 wgzD4SUakabnNyuWFTGvnh8CVuFpmXagj5oOwCW3OO4/5umzDBUp1yfJqHF0zx4QVjv8
 Xl/c6nknf2zL8m+6DLSciLNpj2C5SUqh1rr2XvHFiB8WVzKLT5pku25nRL+B4YH7VEPA
 bQ9Q==
X-Gm-Message-State: AOJu0Yw+JLCguwAGaN8PK71fORjEFQkrYQuVgYz3MJXaXkn81b6vPfSp
 9JI2H6biU/KaeI+ErnCeD6Ed/Fld4LuThCfuL8AuVi2XmqdrFuCqAyRePJnt2dkYC2smX8FXN+H
 4LnaPXLJjpRPCg1/DFqNu7GRghFXiuhXe9V9UkqoMWQ==
X-Gm-Gg: ASbGnctd2KnCmodk87Hu3DdIsmZEIx8JMq0j15ATFbcOr10OuI4VmQNQXWGU9Ons5sS
 o7JAU7rZqRImFb069L5j37UpIdVlvuALgizAIHfutVaibK+347hXRYjNiujOMs/fJZjieDtFvYd
 GD8VNBAuu7sb/UfvGqQ4qeaG61LJAClzOvuXGeSRNgQCFC/qOsbLYGfCcwAK04obZAmrMrUYuRn
 NskjIkfFRGG4earVVKCfBt+ArJgycYGLYc7LTgiY4DjsWY=
X-Google-Smtp-Source: AGHT+IFv8wOh9rpER2pUo0PPG+cks4EcxcJbuOqUqnJZod59XJVcFjve/LKT2o2uzKKbkBn2eJ2ISAxYJ1wJfs7wxC4=
X-Received: by 2002:a05:690e:159a:20b0:604:3849:9bd1 with SMTP id
 956f58d0204a3-63b9a085f9fmr14201933d50.17.1759830504655; Tue, 07 Oct 2025
 02:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250926070806.292065-1-luc.michel@amd.com>
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 10:48:13 +0100
X-Gm-Features: AS18NWC-PXH1zuRfPUrWanIwVSwRIedgTNIQUEG3Z6peTTmOBy13hLOpSCZWlFM
Message-ID: <CAFEAcA9xBwNyi3diiNbcFxiic02=ppYxVWchG1nMqSpvcyuV8A@mail.gmail.com>
Subject: Re: [PATCH v6 00/47] AMD Versal Gen 2 support
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 26 Sept 2025 at 08:08, Luc Michel <luc.michel@amd.com> wrote:
>
> v6:
>   - assert that the SoC user provides an FDT instead of creating a
>     dummy one. [Edgar]
>
> v5:
>   - Patch 36 (xlnx-versal-crl versal2 version): replaced `return NULL'
>     with a `g_assert_not_reached()' in the versal2_decode_periph_rst
>     function. [Phil]
>   - Fixed remaining memory leaks in the Versal SoC by adding a finalize
>     function. [Peter]
>   - Patch 39 (cortex-a78ae addition):
>      - Switched to the last r0p3 revision.
>      - Removed the CBAR_RO and BACKCOMPAT_CNTFRQ features.
>      - Fixed the comments referring to TRM sections. [Peter]
>
> v4:
>   - Fixed compilation issues and runtime crashes in 3 intermediate
>     patches. [Edgar]
>   - Introduced a small hack to keep the GEM FDT node order as it was
>     before. This is to avoid kernel iface name swapping (eth0 <-> eth1)
>     in Versal. [Edgar]
>
> v3:
>   - Dropped qemu_get_cpu() usage in the machine code. Added an getter on
>     the SoC interface to retrieve the boot CPU instead. [Phil]
>   - Cleaned the mp_affinity logic. Drop the mask attribute and assume
>     it's always 0xff (the Affx fields in MPIDR are 8 bits long). Use the
>     ARM_AFFx_SHIFT constant instead of hardcoded values in .mp_affinity
>     description. [Phil]
>   - Avocado test renaming in patch 41 instead of 47. [Phil]
>   - Documentation tweak. [Phil]
>
> v2:
>   - Addressed formatting/typo issues [Francisco]
>   - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
>     out if not 0 at realize. I chose this path as I don't have a clear
>     view of what it means to implement that for KVM. It seems to make
>     sense anyway as this property is meant to be used for modeling of
>     non-SMP systems. [Peter]
>   - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]
>
> Hello,
>
> This series brings support for the AMD Versal Gen 2 (versal2) SoC in
> QEMU. This SoC is the next iteration of the existing Versal SoC.



Applied to target-arm.next, thanks.

-- PMM

