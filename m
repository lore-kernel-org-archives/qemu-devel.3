Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3898DCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSqeI-0003Ce-6w; Fri, 29 May 2026 02:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqeH-0003CF-Eu
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:24:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSqeF-0005EZ-Nn
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:24:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so61158865e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780035886; x=1780640686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UttrV+Y46j2doUg2FXZJijeRKo77/G3MfeXT0Gz2Ztk=;
 b=PBMj6iIWnVXMLhkQfpLGrmxuGmbZJOWl+hr8Hg3LzeDqz7AWn9Xz3g12AkNSJ3HVWy
 dO09E2/mJehVBgR7Gx8VGUX5Swh8wphMaZd0aore9SRLOgd4bDpgb/2iM9QBYLg0FcUA
 LgDd6GQHc1fGx29KvPoeDR3t85NNQaE+Adta403qGYd6jikTxXl9PNmnr8Xr0oGbupWf
 3S/AqCecWsnRfZj1BRf4WaSjzExdiOGYORcedpjffRW372SShScyyuc+g/uwSubH4/gx
 IJY4UbsFOprQpMbJn5iDscq/6A5KdAwZQE/Zn0qF8FVc6KWkJIJiKlQQQr1CstP0Bwwy
 ST7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780035886; x=1780640686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UttrV+Y46j2doUg2FXZJijeRKo77/G3MfeXT0Gz2Ztk=;
 b=NJQ+s06MaIptV1L9hFAhIvwPHY46fk8rMgHO9zm3d0u9jKptbI7kFBgfXj065j3P3h
 uQc6SHInE1VQhWH0uXFDBfSA7vaxhH273albWu6JWz7LrhOtTse4nhoTr3uKZuRGuDYf
 fiVlbWU3EhwHcsnoCCkXwzCR/M5miefv79/DfZWxlUXGiyeovywRr576k5Kdtw6CalOo
 NlSFOhJTkkHb5yktVsQACgGFfHRVefuajvpc0YSFv1ohEMR2n506xCSsuDOpM9hNhEly
 kwZFKWNl/QRDsQJkx929WA+Dpu0YkpiZokurY81VjJtPje9uK2BIhit/OebAUgUOwoxT
 rshA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9U4yeomo3vqMky6h2uuvXakSnkGchgLCMv2j8FHNgSw2r4mw4VWzmb90W4h0y8tnFJhtROwZcxs8We@nongnu.org
X-Gm-Message-State: AOJu0YwLPYjU5IUf5r0ntKl24lxov2U5Rgdht0kug0VDhvmqgYbn5c+8
 qnmHR334+Oo3f7H7jwcVkw6dpuAJ+UYaumBFo4QY+u2MFZE1/WriD4YWP7+26MWpt2Y=
X-Gm-Gg: Acq92OGSzqUz/a97tUZpfzFtHkyf3dyXDv9EUTQaKILX1LeOSzHClzGJOBCq0tPlrhw
 BnTeN6sV22dXka8cgsijmiWubYWbAJpUw2mJwJRpbcthN3ZOBgOATW7Wp19b/J7x463/YIweJ7g
 FD4zFpglIMq6npC7emgg/Q8NNjq7/sm/o0IY/wgk7ku7gJIjnEiDAvTLS/mpdhA+EjTNnxF5Q4h
 08BZjX9tn26dvt7buBFCKkQ/DUBRZ2AmA4qVT4YXwlk1s97azZ2ZSRtsJGEdRSkwN9omVy9OF3L
 FPuazUaKUxneNvg3jrpB/N2uL6O7TZxAG/EtO1nky3S89OoUGlQAdyq1ECwPZAuWf8doTmORM2o
 4ZMfGz/frSXXORvp0VHs6kWgpbdDsedIQ7bqMguVis8M65MSN3FOn1XBRFpAut8OlbyahGuQXma
 PAJN4UcMnLmpUP7k2pfIbEsbgXuxPt4vgNbGpJfMmKppAUt7oSYApjecl6etz0imv1gGECtQ1CL
 u/ncYRICW8Ro/Y=
X-Received: by 2002:a05:600d:8497:20b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-4909c0773d2mr17060675e9.5.1780035885564; 
 Thu, 28 May 2026 23:24:45 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6f35f8sm14553315e9.13.2026.05.28.23.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 23:24:44 -0700 (PDT)
Message-ID: <71168e41-ad83-4a80-aa3d-3a40f042a8ad@linaro.org>
Date: Fri, 29 May 2026 08:24:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i3c: fix CMD/data FIFO depth reset values to match
 real silicon
Content-Language: en-US
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, clg@kaod.org,
 jamin_lin@aspeedtech.com, komlodi@google.com
Cc: nabihestefan@google.com, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260529014034.864722-2-jithu.joseph@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529014034.864722-2-jithu.joseph@oss.qualcomm.com>
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

On 29/5/26 03:40, Jithu Joseph wrote:
> The Linux DW-I3C master driver infers controller queue depths at probe
> by reading two status registers that report free queue slots, which at
> probe (queues empty) equals the full depth.  It then uses those values
> to gate every I3C transfer -- any batch whose word count exceeds the
> advertised depth is rejected with -EOPNOTSUPP.
> 
>    QUEUE_STATUS_LEVEL        (0x4c) [7:0] -> cmdfifodepth  (cmd slots)
>    DATA_BUFFER_STATUS_LEVEL  (0x50) [7:0] -> datafifodepth (32-bit words)
> 
> Per the AST2600 datasheet the reset values are 0x10 and 0x40 (16 cmd
> slots, 64 words = 256 B).  QEMU was advertising 0x02 and 0x10, making
> the kernel believe the controller can only do 64-byte transfers.  The
> visible symptom was -EOPNOTSUPP on any I3C transfer whose payload
> exceeded 64 B (datafifodepth = 0x10 = 16 words = 64 B).
> 
> The underlying FIFOs in QEMU were already allocated at the right size
> (fifo32_create takes word counts; the existing defaults give 16 cmd
> slots and 64 data words).  Only the advertised reset values were
> wrong.  With this fix the guest sees datafifodepth=64 words and
> accepts transfers up to 256 B.
> 
> Fixes: e974c6957576 ("hw/i3c/dw-i3c: Add more reset values")
> Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
> ---
>   hw/i3c/dw-i3c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index 17ff484c5df1..e1bcf083210b 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -282,8 +282,8 @@ static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] = {
>       [R_QUEUE_THLD_CTRL]             = 0x01000101,
>       [R_DATA_BUFFER_THLD_CTRL]       = 0x01010100,
>       [R_SLV_EVENT_CTRL]              = 0x0000000b,
> -    [R_QUEUE_STATUS_LEVEL]          = 0x00000002,
> -    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000010,
> +    [R_QUEUE_STATUS_LEVEL]          = 0x00000010,
> +    [R_DATA_BUFFER_STATUS_LEVEL]    = 0x00000040,

[R_QUEUE_STATUS_LEVEL] = s->cfg.cmd_resp_queue_capacity_words;
[R_DATA_BUFFER_STATUS_LEVEL] = s->cfg.tx_rx_queue_capacity_words;

?

>       [R_PRESENT_STATE]               = 0x00000003,
>       [R_I3C_VER_ID]                  = 0x3130302a,
>       [R_I3C_VER_TYPE]                = 0x6c633033,


