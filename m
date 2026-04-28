Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC8BFF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHh1p-0001Rq-Hn; Tue, 28 Apr 2026 07:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHh1n-0001RK-Qf
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 07:54:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHh1l-0006JQ-Tq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 07:54:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfce3a195so6446143f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777377295; x=1777982095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xew8rzhK4aE0pcnoV3Ux+s3LBwNRczYRxhIXYQRW+JQ=;
 b=wTqZFlBVfgzz3NuDAeLuxrlRhdmzBntq1WHDZx54RIGN2zsp6iHLEzYsKt9dPOyX2I
 jAjO3Mu81Ja9Jl1Xp5O0lRM5f9cSbcl1331JzCRHEJbldiGPg7UP54YoI6qwh6ZzbR9J
 rfsRL3BcU1d3JIMZhKS9Q9vk8D60Iy4qfd/OLLkZexO6EqUuMjayWo5bQExtuQYkL4Fk
 uMqArIqFO1wkzgfJ01NJwY33N4kD0hIyBZtKzYcwdKSvx1McjBUy+4EMNQcrkX9tyt9j
 XcwwwDStE6/EU8NPnnRhyhu6Qsw5NVjFtruwe8VSJ4EJ3Cmn/PSh4BegMaWYAKn0+4YZ
 uSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777377295; x=1777982095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xew8rzhK4aE0pcnoV3Ux+s3LBwNRczYRxhIXYQRW+JQ=;
 b=S3ShOB90Fn30obnMu+ne1q1TznuSvZ4KfA8Lkn8nx6I19ja/esCfOr9JhyVWSY5Cbi
 oQ+MNPtgMRZhwXnMyVHKqT/PEnQLeQLIXaf4hkpICMmGqM6UfBcHFDmsSzhh1qM/HNh3
 mNBuBIMnz242/18qsptSKe2w6XCZnI6mRx78ncDh/n0ynSE7sElvvZn2UFXWGDcM15XZ
 MTkIzAdtGYROCmVemfrgYDrMrNNORnR6zEBi0nnrrmu7bWwjtYNcEY4LJraHKYtGuST2
 xWoPO8H/0UVP5DcPFiiT7N7U2DrQwQZXKyur18tBZxI8uBEmrx8w6QAUwas7Fge3tCoo
 69LA==
X-Forwarded-Encrypted: i=1;
 AFNElJ91AX6YpEUr7BPLDjX3D0vswHhon6I+Hyx0v12Cc3U2imYRKt+YjP9VuX9UFzfrUVU5zvTM6qcYHAOI@nongnu.org
X-Gm-Message-State: AOJu0YzYNT0RlPTSvRc2Y0hUYz+0cLfp5DFmLhOvVR4sRHMW4jb1XdnG
 0n1uVEd2KdEDMfZqwyPo4y2y6/SneHu84F1Hjcwn77RCtDO1SBi1xLE8om3yy5U2z+s=
X-Gm-Gg: AeBDieueuADaR2iYFT/UDwPewxcd/+SJD8+PbSec3xuZL+9nZ156yJ6PCaTQidFhKQZ
 f/9HeZjNXutQ73DID/Ait5gqKTwjbt+Gi4BB+tFYZ9ehtQ1XPbAR9B9i/GkWUK/W5kW9ky8qA+w
 GmoObETFdG43ZBYT8kVKTj4iCxMoMuvL69auGv8bpPi/yw+V0o5ESHehHJ6Y/VN5wd3Ls3ahooi
 hjmhSouNrT+5c8qvBcf8nh97qOz6mlFvJj7krSWo/UIL7QIS1Vwv3Nlj7Ll5v8q7vXR5mMmio8d
 x6MsPmfQmaiei3I6MiMPj0ocBHJRjRwxwRrR7JPI4plIvSyNKzqefFE7OoobpEOVTRATRZOZY7u
 CU1xkoPKM1MNLyFui3M1HMr5iPzSIDzG2vGC00v5iVQZsMsmkbRHVCooJIjWjOITT8iYEmvEW5W
 j7k6h7scTjrcjV0Ca2cBO/4gk7vPToV3khFJWgop2gtb/jFn82D5qcQDLC5DcgUvyCSW5W0kmmG
 oz3
X-Received: by 2002:a5d:5c84:0:b0:43f:e990:2f5d with SMTP id
 ffacd0b85a97d-44649ba18ffmr5036283f8f.35.1777377294856; 
 Tue, 28 Apr 2026 04:54:54 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f2a2sm6039790f8f.10.2026.04.28.04.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 04:54:54 -0700 (PDT)
Message-ID: <a19adcf8-de59-4c34-8e19-0234fa8e68d1@linaro.org>
Date: Tue, 28 Apr 2026 13:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i3c/dw-i3c: Fix incorrect BCR/DCR extraction during
 ENTDAA
Content-Language: en-US
To: Ashish Anand <ashish.a6@samsung.com>, qemu-devel@nongnu.org
Cc: komlodi@google.com, clg@kaod.org, jamin_lin@aspeedtech.com,
 nabihestefan@google.com, saurabh@samsung.com, vishwa.mg@samsung.com,
 y.kaushal@samsung.com, ashish.anand202@gmail.com
References: <CGME20260428102910epcas5p3980610701ef7374b681f74d75bc34f29@epcas5p3.samsung.com>
 <20260428102503.1641162-1-ashish.a6@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428102503.1641162-1-ashish.a6@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Ashish,

On 28/4/26 12:25, Ashish Anand wrote:
> The target_info union in dw_i3c_addr_assign_cmd() declares pid, bcr,
> and dcr as separate union members, causing them to all alias b[0]
> rather than their correct positions in the ENTDAA response buffer.
> This results in dw_i3c_update_char_table() being called with BCR and
> DCR both read from b[0] instead of b[6] and b[7] respectively,
> corrupting the device characteristics table on every ENTDAA operation.
> 
> Fixed this by replacing the broken members with a nested struct using
> uint8_t fields, matching the I3C spec wire format: six bytes of PID
> followed by BCR and DCR.
> 
> Signed-off-by: Ashish Anand <ashish.a6@samsung.com>
> ---
> 
> The nested struct approach avoids bitfields and __attribute__((packed)),
> both of which introduce implementation-defined behavior for this layout.
> 
> This bug was discovered during end-to-end ENTDAA testing where BCR and
> DCR values observed in the char table register did not match the target's
> actual BCR and DCR values.
> 
> A follow-up patch adding a standalone DW I3C test machine and qtest
> coverage for ENTDAA, private transfers, and IBI is planned.
> 
>   hw/i3c/dw-i3c.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
> index d87d42be89..1c5e09ccbb 100644
> --- a/hw/i3c/dw-i3c.c
> +++ b/hw/i3c/dw-i3c.c
> @@ -1507,9 +1507,11 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
>       for (i = 0; i < cmd.dev_count; i++) {
>           uint8_t addr = dw_i3c_target_addr(s, cmd.dev_index + i);
>           union {

                uint64_t d;

> -            uint64_t pid:48;
> -            uint8_t bcr;
> -            uint8_t dcr;
> +            struct {
> +                uint8_t pid[6];
> +                uint8_t bcr;
> +                uint8_t dcr;
> +            };
>               uint32_t w[2];
>               uint8_t b[8];
>           } target_info;
> @@ -1544,9 +1546,12 @@ static void dw_i3c_addr_assign_cmd(DWI3C *s, DWI3CAddrAssignCmd cmd)
>               err = DW_I3C_RESP_QUEUE_ERR_DAA_NACK;
>               break;
>           }
> -        dw_i3c_update_char_table(s, cmd.dev_index + i,
> -                                            target_info.pid, target_info.bcr,
> -                                            target_info.dcr, addr);
> +        uint64_t pid = 0;
> +        for (int j = 0; j < 6; j++) {
> +            pid |= (uint64_t)target_info.pid[j] << (j * 8);

Directly use .b[] instead of .pid[]?

> +        }

Or (untested):

            dcr = target_info.b[0];
            bcr = target_info.b[1];
            pid = extract64(be64_to_cpu(target_info.d), 16, 48);

or:
            pid = be64_to_cpu(target_info.d) >> 16;

> +        dw_i3c_update_char_table(s, cmd.dev_index + i, pid, target_info.bcr,
> +                                 target_info.dcr, addr);
>   
>           /* Push the PID, BCR, and DCR to the RX queue. */
>           dw_i3c_push_rx(s, target_info.w[0]);


