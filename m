Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEC1CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 07:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCBvz-0004oR-FA; Fri, 24 Oct 2025 03:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCBvx-0004nX-Bp
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:09:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCBvu-0008OD-VW
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 03:09:56 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-475c696ab72so13338145e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761289793; x=1761894593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BbZ9k+vv2489pj0gnO0wSZy4lQoR+D1JoJ0eY8FvxVg=;
 b=nPbYZli2br0DjklLkoEcbQa94amShKG8tmlprfV0vghjgc3nnTMLC/stEICGznnh2U
 XknoIMsa0aoGuNOOeyQ1GPPGbnkAgkdT2I3So8hdMXdK0+VMQzNLyQ8Auqd7duq3a3XV
 PRWElynWbibXvUTwEXXtw1qzdTlr8YKDrg3KAZkTWpESN1MAHpDVuWfs2UU6S3+WdbmS
 slhPMV+LSjGKOxr9OPquw33C5yQhwZenFCRjga+m2yuBhuHi52TIfaTXhpirNuODjvp+
 ULfh0Ba5a7w+W4Ngo3xFSMe8H2VfS1/mbAU3JZwzhTyRtNRIWbKNcPhL7/HNZWVe8T8L
 md8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761289793; x=1761894593;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BbZ9k+vv2489pj0gnO0wSZy4lQoR+D1JoJ0eY8FvxVg=;
 b=iT+X9tDOe3C9YMkIk1fH7xPKL9mVLSqM+L8ZXVDGEUeyGiCabGMHbsoQjZ9qRkmijt
 /gCcZiTW9GRVZEOCrxCmcQiR8veo4s6FOoIVh8X826K59l9DLpvPCX+wMs61tVVTbhzJ
 OtiILuh0arZZJT6UoLsjAqrcPjp+vkWu8NemvLdERDUZu/Mf1Fm3IixVtktTmTC5tNpG
 dhBlybTraBIPUwzxu52c3WPrrWMYfTgR0/E9NqYemxr/pIHVyR55JlzDwRlY33lVrHWy
 ehOLImHZ+Wh9V8EFlnmD2obAdSCbZrHGE+yrrNWtpUXXmOIExj23S6zMRneqm6Yv2qsV
 aFrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmLQhl+vrWG6O+W2FIRkwDoW5NHs8fM7BBCR45V+xYO6wNVymVVebmA2uEwsJTBRzFWJ404h9gYcso@nongnu.org
X-Gm-Message-State: AOJu0YwakvBCXD/slDtZ/U1llJt5ZKkPCY0bhT7VKKP1A5QZ6PKESHPR
 /iLXpdnfTmRpsIoSWHNxx3aUtkVkTqFknVKHKJT0E69L0Om31s1V56Yb0bvU5HDz2kk=
X-Gm-Gg: ASbGncvkMbx/MOdAH/6h/RpcnLm9N+rDzm2wfoybNExhLnvBxr8RKwllFAU5uxv+zot
 57fWa3vPA2LmGCB9N2w5pRQ13QJvz5zEo7Jx9YbjjaPxBHTA/Y13fHN0wfWGeWdNljZqNoexE2n
 IeXEGhBBIOwWevP06NR+VA+q1f2s1BXpLjQBJgsKZYYXkh1lLjsNtrpXcZYKDIre7EWWxHbjvEp
 ilKCkuJ7vQDXFhwFrdMp5tJwtu5yzYEOJUW8W+FSZLTH0deLDKz0W86ZCtd5hATKQmDaExVMIjS
 CADk2Z5/rL9aOeGnM5YaIoWDRzR6yQGTv9doRjjhqOeOHTzqrBoUE1i9zdPp1nbl8Rq5mTkVgPQ
 CSXGDbzpC7VLdNqVUHo2rE2ZzfgYoDUgoXkKjyy/VSZaLaASMj4Zu45+yPoiN6nSRCwMHDtod29
 7MqjVD88XSon31IO8l0pskGnTvBr1oqcHjc7s1NrFTXx2OpfuRvlcihcXPTxDuTCma
X-Google-Smtp-Source: AGHT+IEBlxP3uYiHCHbHVWLkDClRzjddyK59Wj9WgQd26HRQgKAW1HG0Zxl/RWMr4nkLrNqS0P2PbA==
X-Received: by 2002:a05:600c:a02:b0:46d:5189:3583 with SMTP id
 5b1f17b1804b1-475d2c2ffaemr8548455e9.0.1761289792849; 
 Fri, 24 Oct 2025 00:09:52 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898eac60sm7615738f8f.39.2025.10.24.00.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 00:09:52 -0700 (PDT)
Message-ID: <8bbfa678-1568-4290-8b24-ed34a7559dbc@linaro.org>
Date: Fri, 24 Oct 2025 09:09:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 2/5] core/loader: capture Error from load_image_targphys
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com,
 richard.henderson@linaro.org, alistair@alistair23.me,
 alex.bennee@linaro.org, deller@gmx.de, pbonzini@redhat.com,
 eduardo@habkost.net, minyard@acm.org, gaosong@loongson.cn,
 maobibo@loongson.cn, laurent@vivier.eu, edgar.iglesias@gmail.com,
 hpoussin@reactos.org, david@redhat.com, chigot@adacore.com,
 konrad.frederic@yahoo.fr, atar4qemu@gmail.com, jcmvbkbc@gmail.com
References: <20251024052707.1852358-1-vishalc@linux.ibm.com>
 <20251024052707.1852358-3-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251024052707.1852358-3-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 24/10/25 07:27, Vishal Chourasia wrote:
> Add Error **errp parameter to load_image_targphys(),
> load_image_targphys_as(), and get_image_size() to enable better
> error reporting when image loading fails.
> 
> Pass NULL for errp in all existing call sites to maintain current
> behavior. No functional change intended in this patch.

If you want "No functional change", then ...

> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/alpha/dp264.c         |  4 ++--
>   hw/arm/armv7m.c          |  2 +-
>   hw/arm/boot.c            |  5 +++--
>   hw/arm/digic_boards.c    |  2 +-
>   hw/arm/highbank.c        |  3 ++-
>   hw/arm/raspi.c           |  2 +-
>   hw/arm/vexpress.c        |  2 +-
>   hw/core/generic-loader.c |  3 ++-
>   hw/core/guest-loader.c   |  2 +-
>   hw/core/loader.c         | 32 ++++++++++++++++++++++++--------
>   hw/hppa/machine.c        |  5 +++--
>   hw/i386/multiboot.c      |  2 +-
>   hw/i386/x86-common.c     |  4 ++--
>   hw/ipmi/ipmi_bmc_sim.c   |  2 +-
>   hw/loongarch/boot.c      |  5 ++---
>   hw/m68k/an5206.c         |  2 +-
>   hw/m68k/mcf5208.c        |  4 ++--
>   hw/m68k/next-cube.c      |  2 +-
>   hw/m68k/q800.c           |  7 ++++---
>   hw/m68k/virt.c           |  4 ++--
>   hw/microblaze/boot.c     |  5 +++--
>   hw/mips/boston.c         |  2 +-
>   hw/mips/fuloong2e.c      |  9 +++++----
>   hw/mips/jazz.c           |  2 +-
>   hw/mips/loongson3_virt.c | 10 ++++++----
>   hw/mips/malta.c          |  9 +++++----
>   hw/nubus/nubus-device.c  |  2 +-
>   hw/openrisc/boot.c       |  5 +++--
>   hw/pci/pci.c             |  2 +-
>   hw/ppc/amigaone.c        |  4 ++--
>   hw/ppc/e500.c            |  5 +++--
>   hw/ppc/mac_newworld.c    |  9 ++++++---
>   hw/ppc/mac_oldworld.c    |  9 ++++++---
>   hw/ppc/pegasos2.c        |  5 +++--
>   hw/ppc/pnv.c             |  9 ++++++---
>   hw/ppc/ppc440_bamboo.c   |  3 ++-
>   hw/ppc/prep.c            |  8 +++++---
>   hw/ppc/sam460ex.c        |  3 ++-
>   hw/ppc/spapr.c           |  8 ++++----
>   hw/ppc/virtex_ml507.c    |  5 +++--
>   hw/riscv/boot.c          |  7 ++++---
>   hw/rx/rx-gdbsim.c        |  2 +-
>   hw/s390x/ipl.c           |  8 +++++---
>   hw/sh4/r2d.c             |  8 +++++---
>   hw/smbios/smbios.c       |  2 +-
>   hw/sparc/leon3.c         |  4 ++--
>   hw/sparc/sun4m.c         |  8 +++++---
>   hw/sparc64/sun4u.c       |  7 ++++---
>   hw/xtensa/xtfpga.c       |  3 ++-
>   include/hw/loader.h      |  8 +++++---
>   system/device_tree.c     |  2 +-
>   51 files changed, 160 insertions(+), 107 deletions(-)


> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index c9782d67e8..48dd4e7b33 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -48,6 +48,7 @@
>   #include "qapi/error.h"
>   #include "qapi/qapi-commands-machine.h"
>   #include "qapi/type-helpers.h"
> +#include "qemu/units.h"
>   #include "trace.h"
>   #include "hw/hw.h"
>   #include "disas/disas.h"
> @@ -70,14 +71,18 @@
>   static int roms_loaded;
>   
>   /* return the size or -1 if error */
> -int64_t get_image_size(const char *filename)
> +int64_t get_image_size(const char *filename, Error **errp)
>   {
>       int fd;
>       int64_t size;
> -    fd = qemu_open(filename, O_RDONLY | O_BINARY, NULL);
> +    fd = qemu_open(filename, O_RDONLY | O_BINARY, errp);
>       if (fd < 0)
>           return -1;
>       size = lseek(fd, 0, SEEK_END);
> +    if (size < 0) {
> +        error_setg_errno(errp, errno, "lseek failure: %s", filename);
> +        return -1;
> +    }
>       close(fd);
>       return size;
>   }
> @@ -118,23 +123,34 @@ ssize_t read_targphys(const char *name,
>   }
>   
>   ssize_t load_image_targphys(const char *filename,
> -                            hwaddr addr, uint64_t max_sz)
> +                            hwaddr addr, uint64_t max_sz, Error **errp)
>   {
> -    return load_image_targphys_as(filename, addr, max_sz, NULL);
> +    return load_image_targphys_as(filename, addr, max_sz, NULL, errp);
>   }
>   
>   /* return the size or -1 if error */
>   ssize_t load_image_targphys_as(const char *filename,
> -                               hwaddr addr, uint64_t max_sz, AddressSpace *as)
> +                               hwaddr addr, uint64_t max_sz, AddressSpace *as,
> +                               Error **errp)
>   {
> +    ERRP_GUARD();
>       ssize_t size;
>   
> -    size = get_image_size(filename);
> -    if (size < 0 || size > max_sz) {
> +    size = get_image_size(filename, errp);
> +    if (*errp) {
> +        return -1;
> +    }
> +
> +    if (size > max_sz) {
> +        error_setg(errp, "%s exceeds maximum image size (%" PRIu64 " MiB)",
> +                   filename, max_sz / MiB);
>           return -1;
>       }
> +
>       if (size > 0) {
>           if (rom_add_file_fixed_as(filename, addr, -1, as) < 0) {
> +            error_setg(errp, "could not load '%s' at %" HWADDR_PRIx,
> +                       filename, addr);
>               return -1;
>           }
>       }
... these changes must be in a distinct patch. The first patch
being the one adapting the API by propagating the NULL **errp parameter.

If there are no other comments on this series, I can split while
queueing your series; but if you don't mind doing it I'd rather let
you repost a v9 ;)

Regards,

Phil.

