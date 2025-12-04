Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32732D1F9DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR8lQ-0007di-Sk; Thu, 04 Dec 2025 07:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vR8lO-0007cQ-K7
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 07:48:50 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1vR8lM-0004dG-1f
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 07:48:50 -0500
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D4ED14017F
 for <qemu-devel@nongnu.org>; Thu,  4 Dec 2025 12:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764852520;
 bh=6k437tgXzlepB135WASR57ExacmDaFi/PP2dGElKvms=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=H94EIO/IXKiy1f8ORBsI9sPov+BkPHn+Q08lFb1li0lwBDZVpW6ZeuwaPvCqb/uvf
 s/feuVYuwmNSYDaXBSVScE3pGogjLO2nXYKlsir9H4n/dZf4LIvKKMR500IZom7ZEr
 tnlLwqAtIeYvPia3S7GOnM9c6TDrHugZEmQ1UcJNtWP/oad7BoTSxG3Xy5W0Qal55p
 YMu2SLq4iICzm+gMBJP+7d5KQAzi0xn14NPQEsoEu56evAiXEeXUE93JJ3HRVYO85Z
 2qElAUaSMEi4Bq6zLr3rHCcBqoeqcGGbnAz5hPg21GmGbcXc2IBzRpQ5yWeoh2/vUE
 ddeCU4S0iYzYA4AJlEzKtmOwGvIoWMmGmqD2/6g7tqIJ/T+WJC/SzatFFxiCPHoX4a
 9sGOh7IX4o4PLRQGikX/AX8JWsP3HrZo/OvB/R2yrrpTPxxXoa5FJ/wpPSB+T+DsbL
 /adYoJirJbbLMkbFeTAjvXUfMlHlkFz68iKcMJ272VNI8P870+DA/KbMgu8bDvQpjs
 VhNUFsBsPG6vaIAh0NhrIIqWel2+oaEJJ8RLF9QQtU0rhqYkwWkwtvT/P8ICJrYGbO
 kFMlK61E4y/1BQnppOXV7rB0qYfgOa8cgJNuWl1xBC+iD4cKC2Cf/stC9s/EHeoW5z
 OPGzkkpHTYl6YrmBfczMzqmY=
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b735eea0bddso63630966b.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 04:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764852520; x=1765457320;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6k437tgXzlepB135WASR57ExacmDaFi/PP2dGElKvms=;
 b=CHrt026xBytTGLzilsmScHyKpeX030xwhrrXtTPtCiGTsGkE5/K1iv9BSDb0cKvRyT
 14oagR+tIS3pGTJ8UE8QxG+Va/unO8FopmKTuB3MBl0HzYXL/eGFBa/P195ZG7W06WHL
 hDw3gUJ1dKv4taiHClrbgAcAMBq9vxtATvIAgk27NFuJs1RAjBU7wZUoJjqzi54jeCgr
 5n7KK6NF8fTWOeBN5CGTFf8cSbHUA2RtywPVYQYzLqqCBSTsSfimKAsVpSFA+pVx7fjk
 ZWfKllOY/IoqTC1mxN939EH9EOKjNqjGF4D9jnj1RLJkJ2mKTgF4VP5XQ6byB8DmLFxi
 Ib3g==
X-Gm-Message-State: AOJu0YznU+rNn5FvGp+TT54DcDadPB9aUOzVSA6cRV8f8BO89j4IkTKg
 JS5kYl4cy3enjiwfIQYZ+OPBXZf7k5UVKvipbNHQfPPb6XL06+FriFUkAKQ7Y4vW4z9eOCvoee5
 ORWw62htd6RFSyJ45Io2nxhrkETjA0uduW9wG5U2Rjpk0rWdDBVbkEIInKF6qI6dnRip1GGl4
X-Gm-Gg: ASbGncvdKmiA1ZgISOwxRUM46ZWMc6tZtFYDM6xE0CVFPlPOfwb1TrnWnlFHuwYCO+0
 1k3bb7BH6gWlDIvfbhZSQVsUmfJ2hsWGqCR4X2t9R6oaHGy8IdmhPooVj/7jU3HiMu3qQuk0Ubk
 t3BmwpX5BYk6e0AFfjNbH5CH34iQ6FnqSTcTx4aaum9IT11iL6ix/GkDytFT3zK/7GBfqkbq28R
 OPNhd/YG/TE9alyHr677hM4eUWNHyMmMW5HeUYmk88tT6cp1lhwg/rhyDAyx2WznmCn00+SYazI
 LyYhcBBKVrGw+HOb/4lbWRZWgCePVPKGGsVZh8KRZk1WHkGAoi5/1sowXB46LcNRRDPlcXBj79D
 BT8InjvbKe1ay/K6d6Uvr+/BBHaNs/b2nCK0VQlyeA34CySqNQuATqTHVjPOM7D4OEkwo2tSyCu
 2mwiHOkzs=
X-Received: by 2002:a17:907:86a7:b0:b76:da45:e3d6 with SMTP id
 a640c23a62f3a-b79dbe8e703mr592148666b.16.1764852520214; 
 Thu, 04 Dec 2025 04:48:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6wnggro/wD/Q9wOoweNJ0+HUutW6BYaIeiN5kqgbJYaemuCzgGzTa5o2NeeptvA0YNLqpyA==
X-Received: by 2002:a17:907:86a7:b0:b76:da45:e3d6 with SMTP id
 a640c23a62f3a-b79dbe8e703mr592147166b.16.1764852519799; 
 Thu, 04 Dec 2025 04:48:39 -0800 (PST)
Received: from [192.168.103.124]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f449d181sm131201466b.26.2025.12.04.04.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 04:48:39 -0800 (PST)
Message-ID: <970c4c36-bccb-40c1-bcf5-28be7c78ec02@canonical.com>
Date: Thu, 4 Dec 2025 13:48:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
To: Luca Bonissi <qemu@bonslack.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/31/25 14:23, Luca Bonissi wrote:
>>From 6ddab7d3ba1035b5e2a6016bde4776436267c18b Mon Sep 17 00:00:00 2001
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Fri, 31 Oct 2025 13:29:19 +0100
> Subject: [PATCH 1/7] Add termios2 support to linux-user
> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>

This patch fixes the detection of the tty console in foreign 
architecture Docker containers when the host is using glibc 2.42 as on 
Ubuntu 25.10 and 26.04.

I tested with an x86_64 host and foreign architectures aarch64 and riscv64.

@Luca:

Patches should provide a commit message explaining why the change is needed.

When respinning a patch it is preferable to mark it with a version 
number (e.g. '[PATCH v2 1/7]) and to provide a change history under a 
'---' line.

Maybe you could resend the series with a proper commit message and mark 
it as v3.

     git format-patch --cover-letter --subject-prefix='PATCH v3'

Please, use git send-email so that the patches of the series and the 
cover-letter arrive as related mails. git send-email sets the 
In-Reply-To header for this purpose.

Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   linux-user/ioctls.h         |  6 +++
>   linux-user/strace.c         | 69 ++++++++++++++++++++++++++++++
>   linux-user/syscall.c        | 84 +++++++++++++++++++++++++++++++++++++
>   linux-user/syscall_types.h  |  3 ++
>   linux-user/user-internals.h |  3 ++
>   5 files changed, 165 insertions(+)
> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 2f62fd2cb9..6ecfe6306e 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -1,5 +1,11 @@
>        /* emulated ioctl list */
>   
> +#ifdef TARGET_TCGETS2
> +     IOCTL(TCGETS2, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +     IOCTL(TCSETS2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +     IOCTL(TCSETSW2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +     IOCTL(TCSETSF2, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios2)))
> +#endif
>        IOCTL(TCGETS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_termios)))
>        IOCTL(TCSETS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
>        IOCTL(TCSETSF, IOC_W, MK_PTR(MK_STRUCT(STRUCT_termios)))
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 758c5d32b6..7afb94544f 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1935,6 +1935,75 @@ print_termios(void *arg)
>       qemu_log("}");
>   }
>   
> +#ifdef TARGET_TCGETS2
> +void
> +print_termios2(void *arg)
> +{
> +    const struct target_termios2 *target = arg;
> +
> +    target_tcflag_t iflags = tswap32(target->c_iflag);
> +    target_tcflag_t oflags = tswap32(target->c_oflag);
> +    target_tcflag_t cflags = tswap32(target->c_cflag);
> +    target_tcflag_t lflags = tswap32(target->c_lflag);
> +
> +    qemu_log("{");
> +
> +    qemu_log("c_iflag = ");
> +    print_flags(termios_iflags, iflags, 0);
> +
> +    qemu_log("c_oflag = ");
> +    target_tcflag_t oflags_clean =  oflags & ~(TARGET_NLDLY | TARGET_CRDLY |
> +                                               TARGET_TABDLY | TARGET_BSDLY |
> +                                               TARGET_VTDLY | TARGET_FFDLY);
> +    print_flags(termios_oflags, oflags_clean, 0);
> +    if (oflags & TARGET_NLDLY) {
> +        print_enums(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
> +    }
> +    if (oflags & TARGET_CRDLY) {
> +        print_enums(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
> +    }
> +    if (oflags & TARGET_TABDLY) {
> +        print_enums(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
> +    }
> +    if (oflags & TARGET_BSDLY) {
> +        print_enums(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
> +    }
> +    if (oflags & TARGET_VTDLY) {
> +        print_enums(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
> +    }
> +    if (oflags & TARGET_FFDLY) {
> +        print_enums(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
> +    }
> +
> +    qemu_log("c_cflag = ");
> +    if (cflags & TARGET_CBAUD) {
> +        print_enums(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
> +    }
> +    if (cflags & TARGET_CSIZE) {
> +        print_enums(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
> +    }
> +    target_tcflag_t cflags_clean = cflags & ~(TARGET_CBAUD | TARGET_CSIZE);
> +    print_flags(termios_cflags, cflags_clean, 0);
> +
> +    qemu_log("c_lflag = ");
> +    print_flags(termios_lflags, lflags, 0);
> +
> +    qemu_log("c_ispeed = ");
> +    print_raw_param("%u", tswap32(target->c_ispeed), 0);
> +
> +    qemu_log("c_ospeed = ");
> +    print_raw_param("%u", tswap32(target->c_ospeed), 0);
> +
> +    qemu_log("c_cc = ");
> +    qemu_log("\"%s\",", target->c_cc);
> +
> +    qemu_log("c_line = ");
> +    print_raw_param("\'%c\'", target->c_line, 1);
> +
> +    qemu_log("}");
> +}
> +#endif
> +
>   #undef UNUSED
>   
>   #ifdef TARGET_NR_accept
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8546f48a05..920bf23406 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -86,6 +86,7 @@
>   #endif
>   
>   #define termios host_termios
> +#define termios2 host_termios2
>   #define winsize host_winsize
>   #define termio host_termio
>   #define sgttyb host_sgttyb /* same as target */
> @@ -5885,6 +5886,89 @@ static const StructEntry struct_termios_def = {
>       .print = print_termios,
>   };
>   
> +#ifdef TARGET_TCGETS2
> +static void target_to_host_termios2 (void *dst, const void *src)
> +{
> +    struct host_termios2 *host = dst;
> +    const struct target_termios2 *target = src;
> +
> +    host->c_iflag =
> +        target_to_host_bitmask(tswap32(target->c_iflag), iflag_tbl);
> +    host->c_oflag =
> +        target_to_host_bitmask(tswap32(target->c_oflag), oflag_tbl);
> +    host->c_cflag =
> +        target_to_host_bitmask(tswap32(target->c_cflag), cflag_tbl);
> +    host->c_lflag =
> +        target_to_host_bitmask(tswap32(target->c_lflag), lflag_tbl);
> +    host->c_line = target->c_line;
> +    host->c_ispeed = tswap32(target->c_ispeed);
> +    host->c_ospeed = tswap32(target->c_ospeed);
> +
> +    memset(host->c_cc, 0, sizeof(host->c_cc));
> +    host->c_cc[VINTR] = target->c_cc[TARGET_VINTR];
> +    host->c_cc[VQUIT] = target->c_cc[TARGET_VQUIT];
> +    host->c_cc[VERASE] = target->c_cc[TARGET_VERASE];
> +    host->c_cc[VKILL] = target->c_cc[TARGET_VKILL];
> +    host->c_cc[VEOF] = target->c_cc[TARGET_VEOF];
> +    host->c_cc[VTIME] = target->c_cc[TARGET_VTIME];
> +    host->c_cc[VMIN] = target->c_cc[TARGET_VMIN];
> +    host->c_cc[VSWTC] = target->c_cc[TARGET_VSWTC];
> +    host->c_cc[VSTART] = target->c_cc[TARGET_VSTART];
> +    host->c_cc[VSTOP] = target->c_cc[TARGET_VSTOP];
> +    host->c_cc[VSUSP] = target->c_cc[TARGET_VSUSP];
> +    host->c_cc[VEOL] = target->c_cc[TARGET_VEOL];
> +    host->c_cc[VREPRINT] = target->c_cc[TARGET_VREPRINT];
> +    host->c_cc[VDISCARD] = target->c_cc[TARGET_VDISCARD];
> +    host->c_cc[VWERASE] = target->c_cc[TARGET_VWERASE];
> +    host->c_cc[VLNEXT] = target->c_cc[TARGET_VLNEXT];
> +    host->c_cc[VEOL2] = target->c_cc[TARGET_VEOL2];
> +}
> +
> +static void host_to_target_termios2 (void *dst, const void *src)
> +{
> +    struct target_termios2 *target = dst;
> +    const struct host_termios2 *host = src;
> +
> +    target->c_iflag =
> +        tswap32(host_to_target_bitmask(host->c_iflag, iflag_tbl));
> +    target->c_oflag =
> +        tswap32(host_to_target_bitmask(host->c_oflag, oflag_tbl));
> +    target->c_cflag =
> +        tswap32(host_to_target_bitmask(host->c_cflag, cflag_tbl));
> +    target->c_lflag =
> +        tswap32(host_to_target_bitmask(host->c_lflag, lflag_tbl));
> +    target->c_line = host->c_line;
> +    target->c_ispeed = tswap32(host->c_ispeed);
> +    target->c_ospeed = tswap32(host->c_ospeed);
> +
> +    memset(target->c_cc, 0, sizeof(target->c_cc));
> +    target->c_cc[TARGET_VINTR] = host->c_cc[VINTR];
> +    target->c_cc[TARGET_VQUIT] = host->c_cc[VQUIT];
> +    target->c_cc[TARGET_VERASE] = host->c_cc[VERASE];
> +    target->c_cc[TARGET_VKILL] = host->c_cc[VKILL];
> +    target->c_cc[TARGET_VEOF] = host->c_cc[VEOF];
> +    target->c_cc[TARGET_VTIME] = host->c_cc[VTIME];
> +    target->c_cc[TARGET_VMIN] = host->c_cc[VMIN];
> +    target->c_cc[TARGET_VSWTC] = host->c_cc[VSWTC];
> +    target->c_cc[TARGET_VSTART] = host->c_cc[VSTART];
> +    target->c_cc[TARGET_VSTOP] = host->c_cc[VSTOP];
> +    target->c_cc[TARGET_VSUSP] = host->c_cc[VSUSP];
> +    target->c_cc[TARGET_VEOL] = host->c_cc[VEOL];
> +    target->c_cc[TARGET_VREPRINT] = host->c_cc[VREPRINT];
> +    target->c_cc[TARGET_VDISCARD] = host->c_cc[VDISCARD];
> +    target->c_cc[TARGET_VWERASE] = host->c_cc[VWERASE];
> +    target->c_cc[TARGET_VLNEXT] = host->c_cc[VLNEXT];
> +    target->c_cc[TARGET_VEOL2] = host->c_cc[VEOL2];
> +}
> +
> +static const StructEntry struct_termios2_def = {
> +    .convert = { host_to_target_termios2, target_to_host_termios2 },
> +    .size = { sizeof(struct target_termios2), sizeof(struct host_termios2) },
> +    .align = { __alignof__(struct target_termios2), __alignof__(struct host_termios2) },
> +    .print = print_termios2,
> +};
> +#endif
> +
>   /* If the host does not provide these bits, they may be safely discarded. */
>   #ifndef MAP_SYNC
>   #define MAP_SYNC 0
> diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
> index 6dd7a80ce5..ac45705acf 100644
> --- a/linux-user/syscall_types.h
> +++ b/linux-user/syscall_types.h
> @@ -1,4 +1,7 @@
>   STRUCT_SPECIAL(termios)
> +#ifdef TARGET_TCGETS2
> +STRUCT_SPECIAL(termios2)
> +#endif
>   
>   STRUCT(winsize,
>          TYPE_SHORT, TYPE_SHORT, TYPE_SHORT, TYPE_SHORT)
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 7099349ec8..067c02bb93 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -129,6 +129,9 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
>   #endif /* TARGET_ABI_BITS != 32 */
>   
>   void print_termios(void *arg);
> +#ifdef TARGET_TCGETS2
> +void print_termios2(void *arg);
> +#endif
>   
>   /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
>   #ifdef TARGET_ARM


