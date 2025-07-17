Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B3BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 11:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucN7N-0001Ie-Mx; Thu, 17 Jul 2025 07:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucN6U-0000xx-RV
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:48:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ucN6M-00016I-SQ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 07:48:45 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so10015515e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752752914; x=1753357714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W8HFzqgJFP4xmEo5cf9y12gqgjUETQ8YXtR8ZKv57p4=;
 b=opy5r4JLbq0EP95oNWA3U9oOWJmHsXUHTSfyFvfd1JIDM7fjQ224WMhFF+A/Vr1Zxv
 qPtEI3zZ6dxqDa/2EQIjRFZHVI7sTaulvC2n49XGqAHcMf/CAxz0UCd8hCnQYbpjUlvT
 VJ8SXR6W+K3XksN6PDpxeWyTWluWpFce3B2CdfNds20XKhvs3kzCSJmRjsZGvZeUNEZZ
 fkhSO0gnajo2dR0327W2w1zQ5IiJ8jHu9e+lWYXt2KeLrzqUcfBITcD0lhXX4jsSW277
 ivLXlyXGZjw5bbYxYMSTBnLQhzDTZs0HYx20WQ3slWj7dpUuClTVHZVr1SZdAHH1JlOt
 RiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752752914; x=1753357714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W8HFzqgJFP4xmEo5cf9y12gqgjUETQ8YXtR8ZKv57p4=;
 b=Bl6RJuRwmtzlLgyQahPsTmci3ULTb4TFtyvIQwtlVDItgl1dF3hR4ffGLzMjQzl0vt
 cw0BY6FmADUOCtTY7f3YAsK6kDgGMkplwSvSfrjS+NBC/ejYQN76iihlryRo9/CvVV7q
 9gyWGUzh805I4jjauA02lSvKDI7NdLWPzn+tnB0WkWfSsC10cuZ40ZeKqzwHkmHGK0BA
 QqGQc2JBkXUXn5wXwlMMYvRBujPqNU/k+nu/20hPybMyDsDYG9X6WaUZ61NqHdhzxnZj
 TJ9KV7lLZGhcFdw3u3ezGH/1yvgqBJjVBMXZE3U+B930mRkjqSbk0vgDuJX5WGPLa2DJ
 WcqA==
X-Gm-Message-State: AOJu0Yx2o5ou7RpQPzSvj6NQtYQBpt96t9Tkrgz2uQwsJccpDav+NlV9
 4wSC+eCbI8qmQyWHw5jP9djJOsxjegYF8M5HmZy6NISKZU0jonT1WmdMVQcLr8AOx6Iyw1f1Dzg
 b2bBoCjM=
X-Gm-Gg: ASbGncv7ZpSd1v99KTprYzqZwWqpCEI4vLqTkuM2GqpYvWM3CUkOjuluuTAR8goirus
 8nEEsYN46Aey7XcJcgR+yfqRvVVMWO983LcGv3sI4xhPtLM8sDw6XR0D+7y1Z0OXonB2uEbCUWh
 owDhnZbIm9PvsE2LhPvBML5nmD+hi/f6K0MfI/IGgucaycDgvt1/LpLy4AWnJrjgE/1EtulcF7v
 JkyC8ZbxONq/f2kRdjhwpyboSB5JQmC9mUjvxZR/Cuoc0JQMkPjD15MBTWCghYvChYOn+1B6ukO
 B08l3wY2LaKoq4yEbdw5xRPyNaxOmVf+TQSzC+bDbQsVpQhILUGw7Lm1qwh9+PiEx1obATVl/in
 XLuqDNiJvb6MGvpkWlb6onQLIIcaN1jjYW1lZu5TTQ1+0nL9fRs7EamcXEefN2B60X7FQBdLnHB
 VS
X-Google-Smtp-Source: AGHT+IHCXgQrMwxDW+NKdSNn0W6iJDG6C9eTXtFEHIhZORvJTsemVhzt3M8Q7c7lVjICuBrMvo7G1w==
X-Received: by 2002:a05:600c:8505:b0:450:cf42:7565 with SMTP id
 5b1f17b1804b1-4562ee44601mr49582655e9.23.1752752914367; 
 Thu, 17 Jul 2025 04:48:34 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45634f9be79sm19630035e9.31.2025.07.17.04.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 04:48:33 -0700 (PDT)
Message-ID: <4319b447-5e85-4e14-8146-b8615d497171@linaro.org>
Date: Thu, 17 Jul 2025 13:48:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/17] esp.c: only call dma_memory_read function if
 transfer length is non-zero
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20250715061918.44971-1-philmd@linaro.org>
 <20250715061918.44971-15-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250715061918.44971-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Mark,

On 15/7/25 08:19, Philippe Mathieu-Daudé wrote:
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> In the cases where mixed DMA/non-DMA transfers are used or no data is
> available, it is possible for the calculated transfer length to be zero.
> Only call the dma_memory_read function where the transfer length is
> non-zero to avoid invoking the DMA engine for a zero length transfer
> which can have side-effects (along with generating additional tracing
> noise).
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20250711204636.542964-5-mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/esp.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 62ba4061492..ec9fcbeddf4 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -487,8 +487,10 @@ static void esp_do_dma(ESPState *s)
>       case STAT_MO:
>           if (s->dma_memory_read) {
>               len = MIN(len, fifo8_num_free(&s->cmdfifo));
> -            s->dma_memory_read(s->dma_opaque, buf, len);
> -            esp_set_tc(s, esp_get_tc(s) - len);
> +            if (len) {
> +                s->dma_memory_read(s->dma_opaque, buf, len);
> +                esp_set_tc(s, esp_get_tc(s) - len);
> +            }
>           } else {
>               len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
>               len = MIN(fifo8_num_free(&s->cmdfifo), len);
             }
             fifo8_push_all(&s->cmdfifo, buf, len);

Coverity reported access to uninitialized buf[]:

 >>>     CID 1612373:         Uninitialized variables  (UNINIT)
 >>>     Using uninitialized value "*buf" when calling "fifo8_push_all".

Do you mind having a look?

Thanks,

Phil.

