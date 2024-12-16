Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A168DE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:00:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFNu-0006Pu-06; Mon, 16 Dec 2024 12:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNFNp-0006NC-R3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:59:55 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNFNl-0006pV-Rj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 12:59:52 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2166651f752so46762865ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 09:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734371988; x=1734976788; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SrQvYRnEHbox0g5DuQ0j8Y65TKsmOnM8siW8nf4t5ic=;
 b=Vcg0CFpUG2PVfUXyqUHPUKHnH23liX42AtPZXlng7t5QEKqm8J+PfiurkBzAev43IO
 ihZezTr3nkSUPpXKqWa7WTL/RsSUXQerhGwvEB0cGsi0WIi8naQSeT4M2yEUzzmi/5FU
 9xnAa/qqKgEUJTTzR/pRVAKVXi9RwcddIZsbIjuZ32RqNABe0yKL8cBaa2qnOqkCUizK
 /0bVFnwuQib2leo0ulA1N+DAkMsSM/JnX5RQ5jwm5qNNVgoLqqWyZ/3mJCY2+nm/DK+B
 yloZF/eM2Aueg9XL8GIGzIrUX7cWnoFBkWEPcZNn6MIVfmdV6pmqeQlZebVvROz6lKaB
 zTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734371988; x=1734976788;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SrQvYRnEHbox0g5DuQ0j8Y65TKsmOnM8siW8nf4t5ic=;
 b=mdjUyHrxRQLYKpiQOt3OWHwmFwVkLbqL3NHIxHyxX40jk6BoTWsixW5WeOGcrZwLjW
 zirX3MmGaCcddL/7cfYjqCO5sqEkzDaAJIdRgkyaEvbIxBosUAipy/+LFz1wVf1PYIHb
 38li96dBGknTCyLstRtBkr0dI6q//kqH8PaQmxsEOA4YirWlrXSk6emMGF59LvVg+7aS
 KwPiBJsAPW1BuY3h1HZgQKNUPRG0507xbOtQOv1/8S6skJPEaXAXYPZlSQiWPx0RDGcF
 Z1cZh+/6ruAyn7om/vrrFJyTdHqyerecQlzKAw4OelsUtrVx7sDmx2w+/x088Ng6xC6x
 iZBg==
X-Gm-Message-State: AOJu0YyugzekzODxV/6IIPyuFeCkgZNBmV2HBSWKG4aMraeC735rgAMU
 yQyVX5WFc7Ynm5dS57LLs3e3GI4+edbf6flMdyL/RZqBn8RFbxAMaErn37WkDhpG97wKNoXj7Sy
 waZE=
X-Gm-Gg: ASbGncvVPh6nSW3MbuM9QgJdAbdTG2h+jhSDj+JEhzyZLEn8Rr+Vez3cbcGEhdTXHh3
 TWGYj0IRCdhfu4zxSzj0k4G2iiUJaHb77yc2jWT+jo4FJrCeLBJ47uDO9SOYKfc9HFJIAYURaaD
 +28GKbvTz1feuiA8R/D2r2ryGPqCovfOx8X7AKybZwvcOHDM4kg8vzuSpk4p3WPTLusQWes7sUl
 7eFn57/TPR5ZGx0i7qrRXPZ7lLVkYO8e925fIyYh3L7k70BoWb7CGbH/MVQ3INHjkpA4cubFS60
 XxdFOkOqeBio0ueGLZUl22FB738/
X-Google-Smtp-Source: AGHT+IH8bmhskgo3ftpNbwKR076K51ON8MkL81sGZUp+Y52DJhqKJkzMI/kndUCDGNNJ38nJBXuNqA==
X-Received: by 2002:a17:902:d2c5:b0:216:3297:92a4 with SMTP id
 d9443c01a7336-21892a76f80mr201271325ad.46.1734371988006; 
 Mon, 16 Dec 2024 09:59:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1db757bsm45668355ad.26.2024.12.16.09.59.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 09:59:47 -0800 (PST)
Message-ID: <131c11d3-853b-4c7c-aee6-f9c7103b179a@linaro.org>
Date: Mon, 16 Dec 2024 09:59:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vvfat: fix ubsan issue in create_long_filename
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, alex.bennee@linaro.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 peter.maydell@linaro.org
References: <20241204195111.2921141-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241204195111.2921141-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

Hi everyone,

gentle ping on this series.

On 12/4/24 11:51, Pierrick Bouvier wrote:
> Found with test sbsaref introduced in [1].
> 
> [1] https://patchew.org/QEMU/20241203213629.2482806-1-pierrick.bouvier@linaro.org/
> 
> ../block/vvfat.c:433:24: runtime error: index 14 out of bounds for type 'uint8_t [11]'
>      #0 0x56151a66b93a in create_long_filename ../block/vvfat.c:433
>      #1 0x56151a66f3d7 in create_short_and_long_name ../block/vvfat.c:725
>      #2 0x56151a670403 in read_directory ../block/vvfat.c:804
>      #3 0x56151a674432 in init_directories ../block/vvfat.c:964
>      #4 0x56151a67867b in vvfat_open ../block/vvfat.c:1258
>      #5 0x56151a3b8e19 in bdrv_open_driver ../block.c:1660
>      #6 0x56151a3bb666 in bdrv_open_common ../block.c:1985
>      #7 0x56151a3cadb9 in bdrv_open_inherit ../block.c:4153
>      #8 0x56151a3c8850 in bdrv_open_child_bs ../block.c:3731
>      #9 0x56151a3ca832 in bdrv_open_inherit ../block.c:4098
>      #10 0x56151a3cbe40 in bdrv_open ../block.c:4248
>      #11 0x56151a46344f in blk_new_open ../block/block-backend.c:457
>      #12 0x56151a388bd9 in blockdev_init ../blockdev.c:612
>      #13 0x56151a38ab2d in drive_new ../blockdev.c:1006
>      #14 0x5615190fca41 in drive_init_func ../system/vl.c:649
>      #15 0x56151aa796dd in qemu_opts_foreach ../util/qemu-option.c:1135
>      #16 0x5615190fd2b6 in configure_blockdev ../system/vl.c:708
>      #17 0x56151910a307 in qemu_create_early_backends ../system/vl.c:2004
>      #18 0x561519113fcf in qemu_init ../system/vl.c:3685
>      #19 0x56151a7e438e in main ../system/main.c:47
>      #20 0x7f72d1a46249 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>      #21 0x7f72d1a46304 in __libc_start_main_impl ../csu/libc-start.c:360
>      #22 0x561517e98510 in _start (/home/user/.work/qemu/build/qemu-system-aarch64+0x3b9b510)
> 
> The offset used can easily go beyond entry->name size. It's probably a
> bug, but I don't have the time to dive into vfat specifics for now.
> 
> This change solves the ubsan issue, and is functionally equivalent, as
> anything written past the entry->name array would not be read anyway.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   block/vvfat.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/block/vvfat.c b/block/vvfat.c
> index 8ffe8b3b9bf..f2eafaa9234 100644
> --- a/block/vvfat.c
> +++ b/block/vvfat.c
> @@ -426,6 +426,10 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
>           else if(offset<22) offset=14+offset-10;
>           else offset=28+offset-22;
>           entry=array_get(&(s->directory),s->directory.next-1-(i/26));
> +        /* ensure we don't write anything past entry->name */
> +        if (offset >= sizeof(entry->name)) {
> +            continue;
> +        }
>           if (i >= 2 * length + 2) {
>               entry->name[offset] = 0xff;
>           } else if (i % 2 == 0) {


