Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC31CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m6U-0006OS-MY; Thu, 25 Sep 2025 09:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m6P-0006OA-Co
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:33:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m5u-0005Jb-BH
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:33:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so5445795e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758807183; x=1759411983; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1uFtQ64q//HiZN3VN0trk6QSdLlHvW4V/dT7OyPvJAE=;
 b=mDBc/IZxsRKLY/S6UVWOnm659y3CFhN25s71jWyAfW62NBTwbWk5hU+STveTb50m0z
 aNP9RE5roMfNlyNexA6Piwb/67c4pPBu42F9F2iWFHi6dtoI1SqOKapC4K+Xv6HQRpDk
 CPkpaPngRuCiVMsLBI6U8X3KktK6VgubaR9SWxCSH2r0yWEK8I1YugdvVBZ2gcOhQaP3
 kx+johYLfGylyS8xAf4RrWnSZqf/LCWh7QvTlLLTGvnYtD6Jl/My/6eO0FnEhzqGFuMp
 7p1RC2RcYa5583tJJ6yZTR/FO3TtG+bHbfWbDUQk83zfrHDQ1BPXLxbFsFDVrzg8Eukd
 Wgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758807183; x=1759411983;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1uFtQ64q//HiZN3VN0trk6QSdLlHvW4V/dT7OyPvJAE=;
 b=tcg7EYmvjmVUFcLbWpFPi/LxQXrNpeM+Y2Qt+WrvlBWnZFBiOP1c4V+CgYO9NlQmK2
 mNreyogjdnuGokzugiB36e/1gR13ssAZyVvWbwyDyHdfjeMyWvwfIgYABXdgNtVEsMN3
 nhor7tfa2hRs5L3iK/4CecKhZXiAePhcH507EWDCggfhLY0hY6skUqkYbUjFuTALAWcH
 fxnRvnsp2dB9IQHJ3QFloHT2p+mgjHguDtt1EM042wpJ5TdBQDTf7G3LNGw+8ebjxQpJ
 hAuFQiDk5l1895BDWB1SL1tw+7FaZuWkHPFczob7VNKpHpN6iGPINqfp3eBXyJ5m+Hw9
 3uIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyDqTLBmHYDG4Faso+xOiPkMFelHLoTfh1DdDwPzV30B8WYlLsjVR3kst3HFz/xPq6lEGtXbnO842L@nongnu.org
X-Gm-Message-State: AOJu0YxxPWuJ9SpURXbFIZK5w4rTNaFrl9hBKC5fgtr12ZcxcA1tGuDU
 eAlQL78ueU52hatyR60Y+fraMX2ayodHAGA21TB3Ys67ehInk2Fd4PofiaGDk2gHBAA=
X-Gm-Gg: ASbGncvvzWdALngDTJ2ZiACSpL6L1c/hOUVuj18LyWBAF0Bhyvm+8rNH7MIzjIqb1jv
 LcZcYZvXixNJsh8ajp+ojE+OWK6VbEmuHXE8fOOTV83OYE+9OLIqGj8AxIYtRIJHlq6Xie8GgAq
 2O9fuTSR6yzLjfdfcmd56GDssNXvWI8oMiEPM4SXEnrlH7+LGYZhaSSOvTark3IAzyIsOK65qQo
 HkQawOxzrXKGeSdN3/XMjAllfX9bGtqSFTkXOm+uW9chk2O8bk8jQbXm4d3dAv4Wy2TMVV4r15l
 TV2qKbW+BrcEP/1fgU9qBmM0dldb5b/ucSD8/zssX/i3yOvytx+CRzlzjMjanXRZn3IhRp3tOuo
 IYjp1zC7wxaI+VogrrFXj7bo+qh6m1vKHG20JiyR1oIQg9tsUS21DNhDqCbeYqupWEY/NkpBmL/
 VJ
X-Google-Smtp-Source: AGHT+IHp0dEewpYwXA0OJHd0ncFojqqPaVR64EaUNaNTy8k3toFMqm1YK+ucb0nAwSwUPsn8ariAyw==
X-Received: by 2002:a05:600c:4f45:b0:46e:1afb:b131 with SMTP id
 5b1f17b1804b1-46e329d1bdamr45553315e9.6.1758807182965; 
 Thu, 25 Sep 2025 06:33:02 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm76022635e9.17.2025.09.25.06.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:33:02 -0700 (PDT)
Message-ID: <f5655322-fc2b-4577-a802-1ea736e08f4c@linaro.org>
Date: Thu, 25 Sep 2025 15:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] esp.c: fix esp_cdb_ready() FIFO wraparound limit
 calculation
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, farosas@suse.de, lvivier@redhat.com, qemu-devel@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>
References: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
 <20250925122846.527615-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925122846.527615-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

On 25/9/25 14:28, Mark Cave-Ayland wrote:
> The original calculation in commit 3cc70889a3 ("esp.c: prevent cmdfifo overflow
> in esp_cdb_ready()") subtracted cmdfifo_cdb_offset from fifo8_num_used() to

"substracted"

> calculate the outstanding cmdfifo length, but this is incorrect because
> fifo8_num_used() can also include wraparound data.
> 
> Instead calculate the maximum offset used by scsi_cdb_length() which is just
> the first byte after cmdfifo_cdb_offset, and then peek the entire content
> of the cmdfifo. The fifo8_peek_bufptr() result will then return the maximum
> length of remaining data up to the end of the internal cmdfifo array, which
> can then be used for the overflow check.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: 3cc70889a3 ("esp.c: prevent cmdfifo overflow in esp_cdb_ready()")

Buglink: https://issues.oss-fuzz.com/issues/439878564

> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3082
> ---
>   hw/scsi/esp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 1d264c40e5..2809fcdee0 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -447,7 +447,9 @@ static void write_response(ESPState *s)
>   
>   static bool esp_cdb_ready(ESPState *s)
>   {
> -    int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
> +    /* scsi_cdb_length() only reads the first byte */
> +    int limit = s->cmdfifo_cdb_offset + 1;
> +    int len = fifo8_num_used(&s->cmdfifo);
>       const uint8_t *pbuf;
>       uint32_t n;
>       int cdblen;
> @@ -457,7 +459,7 @@ static bool esp_cdb_ready(ESPState *s)
>       }
>   
>       pbuf = fifo8_peek_bufptr(&s->cmdfifo, len, &n);
> -    if (n < len) {
> +    if (n < limit) {
>           /*
>            * In normal use the cmdfifo should never wrap, but include this check
>            * to prevent a malicious guest from reading past the end of the
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


