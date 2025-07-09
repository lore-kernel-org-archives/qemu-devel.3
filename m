Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCA5C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSgH-0003jz-Rh; Wed, 09 Jul 2025 07:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSg5-0003cX-JG
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:09:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSg3-0001MX-8F
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:09:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso38030055e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752059364; x=1752664164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c0OyoIlDbTovuZetW4sc3ZIVjCisywC1wpI9kf3GL1w=;
 b=TG/bu5jYpFkt4tULyhKgWEhnlLkUeyM1N57gwFKHUjxEa77CHnoCQCAg00DizvVEh6
 fOymTcJhCjNyI9IQuqM7a9p9cv3D98P7H/UckFEmy4ULhaXmZp3vOAYQ22eyX/BSuTio
 mgqZgc/Rgisy/xwhcSW0Kzcn2Az70NVmVlqeCI/e/rzRyP1nKhaMPJFbDHk1IBuGuKjV
 JOgb3f3Ey9dVpKmUb8uQuFXmQJfjwIukP7kFf9Z0s2Cv6b2P9AGvZDwD3HO4PpTSViQX
 NBF6IVOtrZzV2YuKHCTtwqXFOlD/Ayqq6O8LpJ29UOjrWcHyur16XvzcvCzn8R75oVLf
 Lf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752059364; x=1752664164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c0OyoIlDbTovuZetW4sc3ZIVjCisywC1wpI9kf3GL1w=;
 b=frSrjh1LC2XJqr5P4epY/UgWWBKkcdT3hSDbx89yVdrvihzWn9Qm/q/cWtVmAhLvVD
 fwLvSsrYU/R2VksyUCyospUs2TM54azfPp0x4qYGT4pKv+ZR8PGrgk2P9c5qOjP26LQR
 jK4ssI5hODdnK1qltlzWM3rBRPCmzaeTbzsnfHN3IS3PEylKPsTesVyEd2lRwa8+aKjy
 q/YNvs/LSEvvVnURB8ln5qN8hi0EyqF7yjj7VcK2oKlftZUVIN8YoqGj2COFV2Ran+Bu
 Wrtq70LRBuFH+WeKX30Ac13gagyC/V3JQxKx05jnQSofXF9hn+M86qy+2+W3XXtQQWqR
 TmCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Y3fNzXI4a5h9bv9kLzozyzh9QeP5dV5jeg9ZvyIjawS51yt5VEAfuDMA0g765i9gL355rjzVV1pN@nongnu.org
X-Gm-Message-State: AOJu0YyTJDbSP5dCbCuOHRX0yrbyqC2ycX/EonmqpiduQ0wr5LWHf+47
 gGOdubEbISduH5jnRXSnAL4ozXn/KpyiXAIxGtEedT/c51YmItqNJEfoXKCjZsvK4Og=
X-Gm-Gg: ASbGnctnuYti7qZ9id0nOVVFEa5D0am2JLbXuEH6gR3kJaGgeUZItS6WoqaFmx/OlrL
 FAMnY7uqqeeajohrxAQnc8+Z2fJS039deFs80CXdCDnnadCWjLgmZrjOdCLv619OsUJvTkg998X
 vnAiFF98DcSRdhg/QcMCQ/9wQ2jymatRuxhU5BaiRFExfkjISPEPrhFAUsrFg7pwvn6cZkJydah
 Vh6qHIIZRZz+ol1H3GyC9qBtKER+j7V0LPzI5t21uil1zdKxYp66ChW+e8zTm20xiYnzqCgKtZK
 990sBiKVDJDXW6yeKZGprO5f+U8sw4vSaIee6NMC0OCTR/oK56gTWWYErLD8LDfPpEoKiChfJtg
 va7YBZMkEdXvdBYLlBj2NkqrVHyDqHA==
X-Google-Smtp-Source: AGHT+IGgpeoAyCFEH2GPiSafNbIT+h9KgJqwwpR/INNNiHWroRKD9bJwJD7S4veYuD9fcjlFr2BICg==
X-Received: by 2002:a05:600c:3b12:b0:454:aedd:96fb with SMTP id
 5b1f17b1804b1-454d53d65b9mr18452615e9.29.1752059363836; 
 Wed, 09 Jul 2025 04:09:23 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e4ceb587sm1213180f8f.101.2025.07.09.04.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:09:23 -0700 (PDT)
Message-ID: <068ed887-f571-46e8-929a-9dc450624ee1@linaro.org>
Date: Wed, 9 Jul 2025 13:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] esp.c: only raise IRQ in esp_transfer_data() for
 CMD_SEL, CMD_SELATN and CMD_TI commands
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-2-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618061249.743897-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/6/25 08:12, Mark Cave-Ayland wrote:
> Clarify the logic in esp_transfer_data() to ensure that the deferred interrupt code
> can only be triggered for CMD_SEL, CMD_SELATN and CMD_TI commands. This should already
> be the case, but make it explicit to ensure the logic isn't triggered unexpectedly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index f24991fd16..9181c8810f 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -1012,6 +1012,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
>                */
>                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
>                s->rregs[ESP_RSEQ] = SEQ_CD;
> +             esp_raise_irq(s);
>                break;
>   
>           case CMD_SELATNS | CMD_DMA:
> @@ -1022,6 +1023,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
>                */
>                s->rregs[ESP_RINTR] |= INTR_BS;
>                s->rregs[ESP_RSEQ] = SEQ_MO;
> +             esp_raise_irq(s);
>                break;
>   
>           case CMD_TI | CMD_DMA:
> @@ -1032,10 +1034,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
>                */
>               s->rregs[ESP_CMD] = 0;
>               s->rregs[ESP_RINTR] |= INTR_BS;
> +            esp_raise_irq(s);
>               break;

Should we log unexpected CMDs? Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>           }
> -
> -        esp_raise_irq(s);
>       }
>   
>       /*


