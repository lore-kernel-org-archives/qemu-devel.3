Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6836ACFB42B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxASh-00011y-Ea; Sat, 05 Oct 2024 15:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxASf-00011V-CV
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:29:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxASd-00055h-RQ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:29:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b8be13cb1so34178455ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156542; x=1728761342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rJTSfV2iWyaDNftd92ctHia/krstZqOBm1XyqIFifVY=;
 b=KZjrOV3q8OGPcFlqKy3mKqVrfXOPmntcKhFi8lffxowL1qRVBI3eaKuPImyNRRln0Z
 AyFxLfFLkKWOdstDIYc46vph5/3Eg84S3N6VQBOZfgdv0d1br0KuYOJr10VSiui2/Je1
 t053TLkX51Dcz861yE3D16Csz7g7gaviPWwBmNLdwpyeEC9SKq0Hk9T2X0N1yQ5lnWS8
 ymZZXKy9vdvbjzroLvvM64cZ4+MXTytnbYNFHXgo+T7CsQJgKGD2LW5OJqw+mGdJQouM
 A9gLJ1ex550dzniqvlmCE8Xc2HNzBUdVt6RGzxONO7R0wgo280SfENl1ApsfAa6eZHst
 DD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156542; x=1728761342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJTSfV2iWyaDNftd92ctHia/krstZqOBm1XyqIFifVY=;
 b=ACLiE3b7PFoajcqlaqcoUvHft4HmNa1ZW3Ztfs1CcdQQN4LVTjXCEXwunOP9ceWvFl
 LD3ScnQKzq9raJmi4Vgl/SKWNhUz0QbaPXDxobVRDa8BW8wy5N4m3WYvv4fn7LIls4ML
 T+kt88PVuJcE770ImMuDVPa3JxzDlpo1UNdpe/7WfjWIl7xT1ynf0tooLPje8JfIqaOo
 BPV9DP3mvKQrvr9JSnN55/wsVSYkAZXOgqDTekFkWUraxQq7t6uhu13mUdjRd3nacKwQ
 Vy6imVx53hnHH5XVMS6nuWBgDauvY8HqrS6Ca/kj8yYESGfYJRaidy2eapBgFsIlE9yC
 ioHg==
X-Gm-Message-State: AOJu0YyrhkpL7rwQUWjpkxJe/hruFm5xUwFvgrs1tIMH/p8gw0B1S+gs
 LA6+GPFhl5VH3Zg2XutCl7Fu19V+gmqJPCz8eDMgqyz+AZaKAKxHNebnDfUEKRg=
X-Google-Smtp-Source: AGHT+IEQSmL1Jz8q+mNPrCWv7kXji+JkXHOpKW6LZBYGs9n+wHtRcOvppzWWIuiG0CpgAjYNYyNTVA==
X-Received: by 2002:a17:902:d483:b0:20b:93be:a2b5 with SMTP id
 d9443c01a7336-20bfe04ffa5mr99577735ad.32.1728156542238; 
 Sat, 05 Oct 2024 12:29:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1398d184sm16241155ad.263.2024.10.05.12.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:29:01 -0700 (PDT)
Message-ID: <92da02ef-c68d-41cc-b087-d8afb455490d@linaro.org>
Date: Sat, 5 Oct 2024 12:29:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] accel/tcg: Factor out cpu_exec_user()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-6-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 9/23/24 09:13, Ilya Leoshkevich wrote:
> All linux-user cpu_loop() implementations contain the same sequence
> of function calls. Factor them out so that they can be changed in one
> place.
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   accel/tcg/user-exec.c              | 12 ++++++++++++
>   bsd-user/aarch64/target_arch_cpu.h |  6 +-----
>   bsd-user/arm/target_arch_cpu.h     |  5 +----
>   bsd-user/i386/target_arch_cpu.h    |  5 +----
>   bsd-user/x86_64/target_arch_cpu.h  |  5 +----
>   include/exec/cpu-common.h          |  2 ++
>   linux-user/aarch64/cpu_loop.c      |  5 +----
>   linux-user/alpha/cpu_loop.c        |  5 +----
>   linux-user/arm/cpu_loop.c          |  5 +----
>   linux-user/hexagon/cpu_loop.c      |  5 +----
>   linux-user/hppa/cpu_loop.c         |  5 +----
>   linux-user/i386/cpu_loop.c         |  5 +----
>   linux-user/loongarch64/cpu_loop.c  |  5 +----
>   linux-user/m68k/cpu_loop.c         |  5 +----
>   linux-user/microblaze/cpu_loop.c   |  5 +----
>   linux-user/mips/cpu_loop.c         |  5 +----
>   linux-user/openrisc/cpu_loop.c     |  5 +----
>   linux-user/ppc/cpu_loop.c          |  5 +----
>   linux-user/riscv/cpu_loop.c        |  5 +----
>   linux-user/s390x/cpu_loop.c        |  5 +----
>   linux-user/sh4/cpu_loop.c          |  5 +----
>   linux-user/sparc/cpu_loop.c        |  5 +----
>   linux-user/xtensa/cpu_loop.c       |  5 +----
>   23 files changed, 35 insertions(+), 85 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

