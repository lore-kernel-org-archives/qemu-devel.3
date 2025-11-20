Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F1ECF8847
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 12:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM3Ov-0000Lp-CN; Thu, 20 Nov 2025 07:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Or-0000Iw-NP
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:04:33 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vM3Op-0004OC-11
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 07:04:33 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c75a5cb752so503159a34.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 04:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1763640270; x=1764245070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HarGE69Xcqz4hsoJV05tBZlKbKycWI9YTMfsZh37Imo=;
 b=Qca5Vc7loXk++X4C4HVC84XJRCy2fQrcg+PP8HBg5SCVprfJ5O5DBoA3/AUS4Mz0HK
 vUXaS+GCut++nPnRmHDsMlNwjzvG+tYPeryiZt1BkDwtZ7BprG2SK+lFKXsDZ7oOPvnQ
 oJSsga2mnOePfdwJC/QLcK8o110B24SLjHyzJH9oDf2wKk4WcfbV4tUhfdeGoJRnDWyO
 SG2mn6D9mIRXKb0jFDVC6jZmybhPOypDmdY2xbVnOMoCVJvdJTd32NBYuVA1UFtYtHw3
 x7UGeeXMiAwaYBEuz8a6YT9sOyTK9oUXJ1r4ZetV0tRhoNSt+DoB5LisbC80rwxBWDKK
 qjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763640270; x=1764245070;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HarGE69Xcqz4hsoJV05tBZlKbKycWI9YTMfsZh37Imo=;
 b=rHpopvWA61+mQ6o+a4QLK10Rqc1/cz8XnpXWZe5SFAxomYoQaWrEq7V3/6gC8lHoB4
 0Ht0F2C+DtlM2bj2knMtVQsXg5/neZp8SGSZI++Mh3MgEL/e176koQ4dujYPsQ6dhJ6X
 CHYKxNkclLV9H6KbW+ZJ3xTydt5og4bkSD5LBEXKRyKk3wc/XjaaBXuDSfPJgAj1Rw8S
 ckdxDoZizteRuML9wsimn/K2H0nUvphWMWn8IRnO07KTGjXVR3snibYjfeNERJzUvS03
 bW4/k/0+ltwQk0viVfyjQUOkEcd99ry+to9qfUU4fz/RTDo1nq+tpZR/6+8osyKb38Sl
 gnSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpvHJxsLoRHNxiXkhoBgXBFSCH32HEaX2IaMDvUMqdjsNFINBWWWZ7x9LpfDOa1ZGnOlKGxjKr3Jml@nongnu.org
X-Gm-Message-State: AOJu0YwIoE3IboJhzxedw9OQhP0AVdtGcnxfMfWszqv9Fs6g5TwoLJGn
 zcJWyNrRu+jGtIpCDcdYCkhAWPlg4YTUmMOWza6PWnXqSGLpisMNCYYNm86QECuM52Y=
X-Gm-Gg: ASbGncvkriNV+fecaaurbwr7f3FVkYacoI8CKI3HpqnPAvxDmu3otYPMPrn0qmL2KZ+
 bdv9bz2xZUqTd3HY2Q27A9rs5Ub0fn7lPKgm072CspV9h+SsH17wWnLArejH9+JdLAOuc2+ls0P
 8gWKfcRbqeT2zotZ9z+WHXEMKMe7g5QKxX9GAJDo+Y1a4d3CXe841ByeQ9k6PamEQHz3ld95vmQ
 VtagcrUfEixmCbdxo6vRRvYyPkx+GUxbYfxiXBQfgbIsHCYJkqrP2k4UENONTp+/oqhUgM4S+fG
 V9WjcuLOhgnuoU+dK+wd3MTgQ7Jq5UTsayBmG8hgrR4Oive3Gnlgzcfgx5rFgAIDF7Q9AabsPx1
 aA7NDM1YW2EexyJi6NmbZNSfZHBESNSLQR9/YPsEIBBonCFdIksWS+JOeocpQagWdqdd0rWWQ/i
 1Z7mCnUjhYYC8GUVb1OG20iXDuwzU=
X-Google-Smtp-Source: AGHT+IE7T3zLtJLZzoLsBItMOrBxunHBl1jg9y/7kshJBu9cagdI0RFnANqpM80LeRmUMaqt6X37qA==
X-Received: by 2002:a05:6830:7187:b0:7c7:59a1:48d7 with SMTP id
 46e09a7af769-7c78f381e2bmr1004247a34.2.1763640269622; 
 Thu, 20 Nov 2025 04:04:29 -0800 (PST)
Received: from [192.168.68.110] ([177.188.133.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c78d302329sm924384a34.6.2025.11.20.04.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 04:04:27 -0800 (PST)
Message-ID: <4fb0a736-4450-47c0-9f9e-6cb86a3b28ea@ventanamicro.com>
Date: Thu, 20 Nov 2025 09:04:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/core/loader: Make load_elf_hdr() return bool,
 simplify caller
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, mst@redhat.com, imammedo@redhat.com, 
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 alistair@alistair23.me, edgar.iglesias@gmail.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, sstabellini@kernel.org,
 anthony@xenproject.org, paul@xen.org, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com,
 vsementsov@yandex-team.ru, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, xen-devel@lists.xenproject.org
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-2-armbru@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251119130855.105479-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x335.google.com
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



On 11/19/25 10:08 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Nice cleanup


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   include/hw/loader.h |  4 +++-
>   hw/arm/boot.c       |  6 +-----
>   hw/core/loader.c    |  8 ++++++--
>   hw/riscv/spike.c    | 10 +---------
>   4 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/loader.h b/include/hw/loader.h
> index d035e72748..6f91703503 100644
> --- a/include/hw/loader.h
> +++ b/include/hw/loader.h
> @@ -188,8 +188,10 @@ ssize_t load_elf(const char *filename,
>    *
>    * Inspect an ELF file's header. Read its full header contents into a
>    * buffer and/or determine if the ELF is 64bit.
> + *
> + * Returns true on success, false on failure.
>    */
> -void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
> +bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp);
>   
>   ssize_t load_aout(const char *filename, hwaddr addr, int max_sz,
>                     bool big_endian, hwaddr target_page_size);
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index b91660208f..06b303aab8 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -766,16 +766,12 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
>       int data_swab = 0;
>       int elf_data_order;
>       ssize_t ret;
> -    Error *err = NULL;
>   
> -
> -    load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
> -    if (err) {
> +    if (!load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, NULL)) {
>           /*
>            * If the file is not an ELF file we silently return.
>            * The caller will fall back to try other formats.
>            */
> -        error_free(err);
>           return -1;
>       }
>   
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 590c5b02aa..10687fe1c8 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -364,8 +364,9 @@ const char *load_elf_strerror(ssize_t error)
>       }
>   }
>   
> -void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
> +bool load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
>   {
> +    bool ok = false;
>       int fd;
>       uint8_t e_ident_local[EI_NIDENT];
>       uint8_t *e_ident;
> @@ -380,7 +381,7 @@ void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
>       fd = open(filename, O_RDONLY | O_BINARY);
>       if (fd < 0) {
>           error_setg_errno(errp, errno, "Failed to open file: %s", filename);
> -        return;
> +        return false;
>       }
>       if (read(fd, hdr, EI_NIDENT) != EI_NIDENT) {
>           error_setg_errno(errp, errno, "Failed to read file: %s", filename);
> @@ -415,8 +416,11 @@ void load_elf_hdr(const char *filename, void *hdr, bool *is64, Error **errp)
>           off += br;
>       }
>   
> +    ok = true;
> +
>   fail:
>       close(fd);
> +    return ok;
>   }
>   
>   /* return < 0 if error, otherwise the number of bytes loaded in memory */
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index b0bab3fe00..8531e1d121 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -180,15 +180,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry *memmap,
>   
>   static bool spike_test_elf_image(char *filename)
>   {
> -    Error *err = NULL;
> -
> -    load_elf_hdr(filename, NULL, NULL, &err);
> -    if (err) {
> -        error_free(err);
> -        return false;
> -    } else {
> -        return true;
> -    }
> +    return load_elf_hdr(filename, NULL, NULL, NULL);
>   }
>   
>   static void spike_board_init(MachineState *machine)


