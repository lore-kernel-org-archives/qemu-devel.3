Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA0FC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Slg-0007rF-MX; Tue, 15 Sep 2026 09:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Sle-0007px-BK
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:00:10 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6Slb-0003jY-Rs
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:00:09 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4ab1ef11so275703d50.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789477205; cv=none;
 d=google.com; s=arc-20260327;
 b=GpypI9duHw7EDBvWvKKnDaRbJPgRbzk+CDwBDTbff8MBT6ig9Vv0tu3shCTZcR9Ydl
 kR+E4+wsouPNsZNVrfkAOWCs7iuhQdAz3Xpe8KGIM4QwG6ItqxAzwDQvJVoBgPKuMVyr
 JNhF3T0vAONimqs4yGn/quIf+OF8186rdUV+MT4aUK78bP5614nYq9fO5oPciENxrtl7
 nh56Zg3pSB66n7xtKJW3oxjfLgiSZ0wOHB1UIiVFP+Ok32rew+e/4eylcZjndu5UynyC
 lc+D4HP6kQkt5sHkNOvbXK4pG6vFeAIRdvCahjfCcWSvLcccAV3Q87vkL6dakKoMXpIr
 nm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JDyGNPLCOD9X+z5KrK0d40w3P/enNWoRFDnx71Her18=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=ae4WGuVciY7R5PGneTAs5hJijpqSQpr6IV42gZdCK/zH75MGfxp4sq3uLtU8W5S0nE
 82eV0Pj4ovUYxEWAFuezIeYBo1OB2xUX8xmoLnceCQ5102nkF/eY1+0zJ+2muUXX6xQx
 IFGJP68/hM6eqQPU1Ya80TzaWu3aV5eB1w8BewafD/R3owKrUCONaP/TRlxJWcf45ew1
 6TvjJ68WOPUESeNnxRycMWNEZEiAVTFmnuaYYy8D5TPp6yHYW/cca/34hX7P3bJ3JxXZ
 2BM1EIx+xF2XHRNzWCRw16s6BNrpFg66hQcKvkZRec0ght4nm0S7CG/A1gzpxOmOWHbo
 DmRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789477205; x=1790082005; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JDyGNPLCOD9X+z5KrK0d40w3P/enNWoRFDnx71Her18=;
 b=Wswy/7CMO1ABx/5Hli1SKAy0B4VI20jGMHKn81EbDqqMoLnS5VTu48CE2I7ZxBqgS1
 sLWDVlWkhyzAeyr6esrmu57AwfpcU5EzE/zuS1nVPBU4M60hrgbxqDzcPoJcYgw3NA76
 vvCXAjOf9c6JrI8dHqiJ2pCela8HyqSsv4HgO3/sXyJYEX7gzL5cfXW9DzhixKLaVy2p
 U8WCNn5ABXfK+yI1mXPbioq9UnJpZnTHOaSUUFxY89K4vUYl2pWJ/inS79o0D3bxUzNo
 CrR1rQbhbe7EPBvfEqDgl2OgVzb7550GD1yspPtoxGUzb6E8187a2S5901y6s+/DUvFE
 q6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477205; x=1790082005;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JDyGNPLCOD9X+z5KrK0d40w3P/enNWoRFDnx71Her18=;
 b=xieWAjpt/02h/PW3Ux6WVCT6ZNbHfl3g/p7tpz5iCL8LnYMRsSYeSFYYNPFqt9aS4j
 BGxoKin83LeHKTfxU/QtiiUe2+r8wsNjH6RDTd+t26sOFei1E71tglnULJNr3jwZPv8m
 IRVIyW22fd4U+0qQJS7ICpw2Jf4lZyQ/V/Lk9htZydLARBfj0h9uDA/SChwxQ2EQCOYk
 lmBVC97ASl6osBKF6Z4v02hNdcSstkVxYuPCUTtUlSIAK2Id0wstRZJtE50bC4g62Szn
 qA8EWOdxmvYp35MBTwa8uuBJN86rvQ5D1GjFIC+CAPhF/T2n4coDxFDl65up1Pc3Nfll
 RIRA==
X-Gm-Message-State: AFuF++lsCfov/YiSRVBT4fPLGu/OOm2Be9ePiwo2Pt4Vq65NdV1hVcAs
 HP8d2oR7GM2lhkEP5b2j67Jaz+sE/X7VznqBSUgklGan7H/xbe/db4oTJffsW8behoas495Ud+u
 9hfMkT/G5pRFnBbGZl926eWnnADcPJYruzSrVZ5gIQA==
X-Gm-Gg: AYBFou3NwBkNXB2VgQpc7ZYL9YBx0DkyWfDS88zzk5j6QdgxTV9aFCOQpZOPgaSUpUz
 ItWRYlQ76Jk3f1bQ/CJ3tlTrs2hAX0Ht/CKwxkFx65LSwKKM+SwxajoW/IaC7Emn8q+RgxNbJq9
 txWbz8F5tQH+JhfqoXARnfmn9MvkRt4/E2OvEfqaHqDiueE8O03lOeuhMuFy7uGQLfRKgKc31tb
 NYAHHS6R31CDTdu0g5Mi3dfYjm7YBbn1HvtDMY8YocNLuw8KpH6P1rN7YHimjiFicuGnrlTmqJ5
 tQi+wSk8Th5ASBuRVRXzaB2dNu/LSywGoACWjdd6gubKCKqcndc+YBwT6k2aSiHA6KsVwGWh6Yj
 MCS4Q7QJarUfr/f5sQSUR3YA9uIj6RyNPA9JGtCY=
X-Received: by 2002:a05:690e:144a:b0:671:2e96:860e with SMTP id
 956f58d0204a3-6715cabeef0mr328106d50.16.1789477205181; Tue, 15 Sep 2026
 06:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260914223159.2735262-1-brian.cain@oss.qualcomm.com>
 <20260914223159.2735262-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914223159.2735262-2-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 13:59:53 +0100
X-Gm-Features: AcwNN1XTFiVS_Q0EZeiYZrbsfAZS41AI4M6T5tc08jkWAd9HLXrCMNMKPPB9SmU
Message-ID: <CAFEAcA9EL10xpPx_0YD-q6YcWWP9-iwcyG8x0s1yQhKB-XQGXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/hexagon: fix semihosting OPEN filename
 handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 23:32, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a NUL.
> A missing terminator could overrun that buffer. Use lock_user() with the
> ABI filename length and validate its terminating NUL before opening it.
>
> Fixes: 7711fdba88b ("target/hexagon: add main arch-specific semihosting operations")
> Link: https://lore.kernel.org/all/CAFEAcA9MOs6VfHf2UHZ8z4cdvaB+7DY6hJb2emYZ2aLSe-t6iw@mail.gmail.com/
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 4705e915aea..21e5d630a75 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -28,6 +28,7 @@
>  #include "semihosting/console.h"
>  #include "semihosting/syscalls.h"
>  #include "semihosting/guestfd.h"
> +#include "semihosting/uaccess.h"
>  #include "system/runstate.h"
>
>  /* non-arm-compatible semihosting calls */
> @@ -461,31 +462,17 @@ static void sim_handle_trap0(CPUHexagonState *env)
>
>      case HEX_SYS_OPEN:
>      {
> -        char filename[BUFSIZ];
> +        char *filename;
>          target_ulong physical_filename_addr;
>          unsigned int filemode;
> -        int length;
> +        uint32_t filename_len;
> +        size_t filename_size;
>          int real_openmode;
>          int ret, err = 0;
> -        int i = 0;
>
>          hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
>          hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
> -        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
> -
> -        if (length >= BUFSIZ) {
> -            qemu_log_mask(LOG_GUEST_ERROR,
> -                          "%s: filename too large (%d)\n",
> -                          __func__, length);
> -            semi_cb(cs, -1, ENAMETOOLONG);
> -            break;
> -        }
> -
> -        do {
> -            hexagon_read_memory(env, physical_filename_addr + i, 1,
> -                                &filename[i], retaddr);
> -            i++;
> -        } while (filename[i - 1]);
> +        hexagon_read_memory(env, swi_info + 8, 4, &filename_len, retaddr);

This looks like an endianness bug -- we read 4 bytes of guest-endianness
length into filename_len and then treat it as a host value without
doing any byteswapping. Could we use get_user_u32() here ? That helper
does the memory load and any necessary byteswapping for you.

(This seems to be a problem with a lot of the code in this file that's
using hexagon_read_memory() to read from guest memory into host
variables. If you made it use the uaccess.h helpers instead you would fix
all those big-endian-host bugs and you might find that you don't need
hexagon_read_memory() at all once you've done that.)

>          /* convert ARM ANGEL filemode into host filemode */
>          if (filemode < ARRAY_SIZE(angel_to_host_filemode_table)) {
> @@ -498,6 +485,16 @@ static void sim_handle_trap0(CPUHexagonState *env)
>              break;
>          }
>
> +        /* The ABI length excludes the filename's terminating NUL. */
> +        filename_size = (size_t)filename_len + 1;
> +        filename = lock_user(VERIFY_READ, physical_filename_addr,
> +                             filename_size, true);
> +        if (!filename || filename[filename_len] != '\0') {
> +            unlock_user(filename, physical_filename_addr, 0);
> +            semi_cb(cs, -1, EFAULT);
> +            break;
> +        }
> +

This splits the two parts of handling the filename argument so
that the "check and convert the filemode argument" code is
in the middle of it. Could we put all the filename-argument
code in one place?

-- PMM

