Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6816DC88E45
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nHJ-0006WI-3a; Thu, 10 Sep 2026 18:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4lNv-0003bA-1v
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4lNf-0000fF-Rj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:28:30 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so208230a91.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789071865; x=1789676665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=roY7InVnKLtcFtdiGuYzbujDolfoQqbOpkrZybN/QJI=;
 b=oSaxCjkcbtbZJ8zeNIBYlD4NBYgVexERphdr4AVz+HF8RHrqHQSfh9GIi75qBEng0k
 a8Ra9X7Rw1BQJXNNz+Jt6rnKjnOLNL1uBEzfRrjpaevBu3bheg/VbIhlJk7oGMKr6Yj4
 QIQB01K/kmSWqLDY3M2hVOawO3VRKoZoLOMldO83m5jgSGEyaR34RVN0Q4nbbcgdAC7S
 mpyFSYnBNx0qzmXIIf6DKks5s388CVdbpBGy0QV9wmAsbqnl19lKQPGBk1lAhWESWcE/
 AmdN2e7RREp+cj/YSPXMvWZat41yJ8Y55zsvUFCKgdC6gtfdlvZL2k/iR5PGNRmDp/1w
 o/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071865; x=1789676665;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=roY7InVnKLtcFtdiGuYzbujDolfoQqbOpkrZybN/QJI=;
 b=sBQJZWUATeC0okX9TTU86sxHTJN8KlA2ix9DG63ApdkKWyUHUXBcIRbLSt6ybXE1Nk
 BDTrorJB5Asi0zfFBM5u4h95rT8ODvBlHmXsVpJEgAlzOJVc+Wqe1g4P8GU/Wx0liEya
 uKfeFSUfn0UlXIoEnCIn+o62sSWRFtLRQf0l4ZgRYdgo9aMcJFJTbEatxbEB9k8KgmG6
 GhpBIhYIoFUdIb7xWeOJO2wsFLfocStsvdXZnBC10SUeuqQr2irHyNJoX5aDhfRqOTl5
 gVgpKTBOXa3KMeiobZ8JoLJKvZxhvQ0SZksDI7rQjOpOfALuYOWnP0MVOt8IcLzXtlkD
 HhiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxrM0IfcSrtO3iA5unjJwMiBqQIbx69DS3+nsYhyPLtSWrf5yd7G7XiuOz2tuINbFGbUck/Omb3O4d@nongnu.org
X-Gm-Message-State: AFuF++n8vFaUPpuxhv06XLOm5nmdmauFVO5KiS5/b/3eklc/laveuMmv
 +Sn74wnxVNmXjA2xqJlltbVEoLreMfop4g2Sqonmw8OYClQHaYKe0FCyEQO4n+TKilaEjvguRNG
 CHje9ZgA=
X-Gm-Gg: AYBFou1kXUGjDutrFh0DKGC2QHwtXOigUcYeY0aNyF/JgEjMTDDe4fR2xrUu8sySCEG
 Gk0MoTGSPwJClSgDadL4fqZEfOxvIgnZv53AW8CPUMmVgFcTM/TyjuwUsJNq6ITaomIviTNM1EJ
 Qc5cJRUaNfdqgOG5c2G+V1cjkaZcS9p8Pr5EQ5xxiS3Wqdeg6v3ahFyRT6p6IGb28IryEQJLdLs
 Ec+eX9YAZFWtw2e0r+/rFxDDbqdWSHbDEurQDTGHPvpK56vxgZGfmaTW7PuMxnmuKYl3kkmjcAW
 9dcUG1dWyCS5vrNuKE0Uqsv+Ae5PdZbfD/XFUWo2X4FJz8TdHPfWt9J4SLcwa548LCMdTunya/4
 FzL2YIjSnpo0cvqNRPnwR9YGutmPortBICp3JW1s6ti6GE6Gd433ri3/gk5C6ylZ9KWfUS1MrHU
 wgUrc8U5wsfyAC++tG4SuPnQpfJ0NyGPywl+K3HoMsYb3PDA46Sanbcog7OXfwMwWHI60e1FVeq
 d+eHTrb1ppfMXc=
X-Received: by 2002:a17:90b:57ce:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-39d9c212c05mr562930a91.14.1789071131902; 
 Thu, 10 Sep 2026 13:12:11 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm447242eec.15.2026.09.10.13.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 13:12:11 -0700 (PDT)
Message-ID: <27678d57-3b8b-45a3-9a27-08d96675ef8d@linaro.org>
Date: Thu, 10 Sep 2026 10:12:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/mips: Use tcg_gen_lea() for [D]LSA and MXU S32LD*V
 opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260831062630.58771-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260831062630.58771-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 8/30/26 20:26, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Based-on:<20260828224451.1564072-1-richard.henderson@linaro.org>
> ---
>   target/mips/tcg/mxu_translate.c        | 3 +--
>   target/mips/tcg/translate_addr_const.c | 6 ++----
>   2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, I've queued this with the rest of the lea patch set.

r~

