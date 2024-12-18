Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703AAE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNtwv-0006Io-OY; Wed, 18 Dec 2024 08:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNtwl-0006GG-I4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:18:40 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNtwk-0006Fq-0z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:18:39 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so3962291b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734527916; x=1735132716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oj/+Bc426eYh9OMfhw7IQd7PlkdQHF7+6nYyfarJhPQ=;
 b=BfoFBSDzFclBbCJftJHhNdqjq+dcIQDp/ukPlfRciT4oRnb5ZXgJ2mxoXj8zsePClv
 gWdxJi92Ww5eIGBZNyCE7meHqMZ5XhKiq98yEZ12DCU1zJRXeEJQIzCOf4kBwBo/hVum
 4NO8YPSHUTTtwAFXeqixbScLhIeoPbfQ+VnFjcvxo1wAyUmkY4/tLhZSLr91GK9Q+08d
 Jb8Y2lcvkOpgctozjmtWpcryu0K4ri4pqAH9fQX8rk5iEkR7tLAdAwHBpAfsIZz9E+iS
 1CLBrZmqTTCYA3Dg2ZxUaUo8x64x9vf7CEdF1TOJJIhvxkrWPyUjTLY0POBi2xwtiJjh
 qavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734527916; x=1735132716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oj/+Bc426eYh9OMfhw7IQd7PlkdQHF7+6nYyfarJhPQ=;
 b=XbgsjKHTNcLiE+zyHObltShc7pA1NFXhmrmaQrbpfdp54PWkNopgQwycGCZWNrH0Mi
 639B920EEd5iU/bc+y6zrLYYX8v8x4HLZkB+vGQRQHVCjWpyByJoWfv+SwrKvPEMSllJ
 xHTefBHRMaKncw7Ja7k6IVFpxEzjJDCG7xxyXIcQGgTetHGaiGd5reKDRZXt2LUjW/KE
 PPQjYKIYM1KEh6XmQGMSxvbli7YMvLeaFqw/zD3X2aA1RRKMP8smBfiqVaa1HbYqOb3T
 5Q0ocLL3mSXAoE67Vv4QAS384yxYKrZEXaiQ7oy3VCdCx6KnYZ0EAgp2WhUbswCUxayq
 9Pjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhprgwl/zbj+IYWch4e9UI49YxH8oC0JfPW4ADu71MceFkDIPTHEwy6aA3Vku4OvhZJH9HI9lpgv8X@nongnu.org
X-Gm-Message-State: AOJu0YwHexKHSMIJreDbKBdjN/5DtSJJeVDqaKqzbwNlXTchlae9WWud
 NUTAv1Hgo50fhG+Dgs1DjPYOFjtT6DtBFBUws7QyB4EbKmWpNovTT6Yv+FRWvvRe+Za0Q75+C0p
 Y
X-Gm-Gg: ASbGncvYiEQM/Hp9VGYGYJfrvjBzhYj+gJtFZnkIRzg0NerenNlrDQATXRg6g/6EwIo
 HyG6Gws4RJa1wQP2yqAdqYE/tdUypNhV0OKpAEKhJCKAnLYCbshJSKDZvsnUZkSPltD5dD+hKOY
 SazCrkTmEk0AcnqbB8KB/FWUTEDZT7uku7zWh3je0V0TxokN45M3Vc9Gc7lN+RBZbwdE40pVOw3
 BbdtJcdeU8iCBrw2bOTyVqzY20YVDKOcwGba2JSZ59rth1+ZgV6M8KMz/Y1mbN2rp8Cwysc
X-Google-Smtp-Source: AGHT+IFBRDVGnOHfVLJawh4Ma3u7QTo5SWCW+GlwaMF7Dx6v/EQMxymnfEbjKuc05wzIM5dRF+vFWA==
X-Received: by 2002:a05:6a21:32a5:b0:1e1:9662:a6f2 with SMTP id
 adf61e73a8af0-1e5b487d810mr5092263637.35.1734527915721; 
 Wed, 18 Dec 2024 05:18:35 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ac84f3sm8792371b3a.24.2024.12.18.05.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:18:35 -0800 (PST)
Message-ID: <f83920e3-b770-4f15-b319-7cb1672fe109@linaro.org>
Date: Wed, 18 Dec 2024 14:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] rust: pl011: match break logic of C version
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/12/24 18:21, Paolo Bonzini wrote:
> Check loopback_enabled(), not fifo_enabled(), like the C code.
> 
> Also, set_break_error() must not happen until the break is read from
> the FIFO.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


