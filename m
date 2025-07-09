Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96DAC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 11:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZSpH-0000hW-R6; Wed, 09 Jul 2025 07:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSlw-0000S7-6R
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:15:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZSlt-0002BN-7N
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 07:15:31 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4538bc1cffdso47305265e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752059727; x=1752664527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RNwagcWbbHIiyBPFQp4O4joAakwIquLe9khZ1zZRoos=;
 b=LC/VS1Z55Mzeu0nf8Wvht2A9HSkEFcnCSWiHlgsnejOGWlZQkt4YdjTMGIEMbQRPw6
 R7bMmCJXc1ZiOKHI3GUN1QnBV4ezYefuGiqWy+AvHcv2f8AdV+++Xcszqnf9Wu3PA7fx
 cnuux3wGcnoXMStKnZ2NdVU1NQEToljnceRzWxLYzgEG+WBkHXnks+oQCnoaMfYvPf5t
 6mCKD9exv7QaI9CLeAdB5R6TL8LgvlsWrcDMP4RLribjyS5Uc4i8jru3FxoH7yj9M0rb
 fIS/IRTRnROLgEod72z29CV84KvS8KFFPOKnunBjlgoRh3fUNQepxP02QqC5CzMJq5Rj
 7S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752059727; x=1752664527;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RNwagcWbbHIiyBPFQp4O4joAakwIquLe9khZ1zZRoos=;
 b=cuKStP+/0fG5cKn4gTKLUD88D9GoRxlnMNtgT7LzTiADT3bcJYjSIfF8RdKQYrKWJm
 slhpFfRnaknjQnzTxUhZvy2Ebfv59hL92EmkiTcD1oaRjuc4IyTd1kL7ZuklPcWEwh5y
 hofZwXZ1pwLoR2+7eaaL0jbzU6CaN1Zzb+U1qZaeI/BpND2zOPG7Q8+lRTk/p5yTvZEI
 zqpgQMLDyOK6Aye7vZn4SajYMgyzsDXVO3zm+F832IKfFFjANLFe68RVDyFdPb0Q1gv5
 nwDZFLCz5YQMejN6adbwAVZhn9Qlt/QAqIKOgDzHzcZLCGCNb9IlY1UuodqiZ9sXUB0D
 9FKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1hIbk5dN8z2gf4Y+/SKF3WlYx4pUbgVKNhnTa70tfzYeQGQkm8UWbKsYn0K/WhqLUOj5wwMxGseNm@nongnu.org
X-Gm-Message-State: AOJu0Yxwwtkq0ubb0fsW99HsxWyufgAJmz/modUzFtb3PCJ1NvZwLBrB
 2j+AY0ABEWF6spNT9tzEDc5/I4vq61ktIvUQAAOeZjCKdHIQ9p7aajK2uPaC2a3vtqM=
X-Gm-Gg: ASbGncu4l12NOWYy61L7rREGrRAvgYefdqd1rJo/td3idXQ1ADLGPw6TvJgZBvDIDcw
 nf7bQC8ZJyAsdErR7BMKvChwhwq+EBLSxbpzFM7Ph8s4ofamoOOP5qTIv8+PPv6kb6h1NbUs+6w
 ga9sQmTA+2zmKZfW1JcS9FcDT/feHB2DsX7R++hH+9wbl4quNWcKX8WYC771xQEv5Pkd63Dq5up
 ZrDYUsr017mQoNoVrpyF3h/a+UD3w9ChhGsFMsovolpEhZFFazV7csZNKChb9xHjV+D09RpfEK3
 wpxZ0R+jenXXFGFRxGvB1WM39wJhxhOy6QD4tTaWvVum+lhIJJqxUmpcgZELvmbF7WKQTAw6f/6
 HZdIv0LSMdXELB9tKsmgfNjA6rkwycA==
X-Google-Smtp-Source: AGHT+IGYsegGdrI5DFgJRtcmjcohunY2heuqJgocLW+e1/OhducvuCw2ZJYP1adgG1gpdrhiVVnF1g==
X-Received: by 2002:a05:600c:3111:b0:442:ccfa:1461 with SMTP id
 5b1f17b1804b1-454d5325ebemr21343745e9.13.1752059726811; 
 Wed, 09 Jul 2025 04:15:26 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5053725sm20280415e9.16.2025.07.09.04.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 04:15:26 -0700 (PDT)
Message-ID: <5c9f89cb-3416-4f84-bcdc-cf31feb410a0@linaro.org>
Date: Wed, 9 Jul 2025 13:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] esp.c: improve comment in esp_transfer_data()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, qemu-devel@nongnu.org
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
 <20250618061249.743897-3-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618061249.743897-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
> Whilst working on the previous patch, the existing comment was not enough to
> document when the TI command codepath was being used. Update and improve the
> comment accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


