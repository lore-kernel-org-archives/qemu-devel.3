Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A9CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 18:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMAoF-00010l-M2; Fri, 13 Dec 2024 13:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMAoA-0000zt-5g
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 13:54:38 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMAo7-0002lj-OH
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 13:54:37 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-71e2dccdb81so1194177a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 10:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116073; x=1734720873; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sX0Yf0gF+ESVvKAXl3LC1Mv89Ckmh0JbyX7l3UT8Amk=;
 b=Y/6RgH2g5bXio8HIAz9FJ+hzIN245aSUzipG6+oP2nbdMcHUY4z3WOQams6FHzAjMh
 78CV8yXKFdsoJRgANg8MNcWk0kuY27RdTfZ4RjE3qMtTQRFeJBrJmFjE0mXG2DG5h6gu
 YPV1fbmXHkyTypoqYDdiw7uEd6BSUyGnuJb5rN4lDCkCrBjBvZD5dmL7ioliwZUt+j+M
 1+WmwTlEjUn9IUHnUs2XGriHOo4yOW9+YoAcwx1uaBqH08WhXt1aSgB5sBOtZxMKKfTh
 GMaoN8fhYc0DTiCcA2EN6I/5kH92TitIlfqvZkqvz4SA3fPiDIAju0uDgXvr09isdXuZ
 hw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116073; x=1734720873;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sX0Yf0gF+ESVvKAXl3LC1Mv89Ckmh0JbyX7l3UT8Amk=;
 b=XAenX0hzM5k3v7m3RDu/zNMSDD86kQLQ5BRYXBFinqgXAnTv0wIdSVqPXJxOJjCdmE
 5D9HL9ac4gmjbBaiQYEs+ZVCyB7097gVOX1FMJ4E1YcU2dO0MZa+PKO/gDrYhAk+qR/0
 /O6rVuocqMLOdDoEnWQ5h3x949WNdKN3Svs4Cng6TJdzZAgZ6U3LyJnOJEfndGRPp0uj
 NVRMSBztOXV+Y7BnVyJcetJFiSXctzx0kCar+2a0u2k37lzrjcvlJOrlh0D8MIBXhl00
 bV4NogkyTaQv5DBf0LSuzeaShHUTEhCIT0cfqga6ysZk4IEv/pHCimRxKlIwdtNlPVK9
 Y4zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfYEeYR759m6+RvJyV4/PFGn2Lck1bJv7JNoLzV5ObbHMX9khsNF6z2BtbGScOoLJbPXIVcrI6LIvR@nongnu.org
X-Gm-Message-State: AOJu0YwFttHwzGdgw/yJ+lM3lu+2MPYLV+g7az2uxQm2HNzRY9SZ9MAl
 THZZ4xT2CTvt0feYRtX4l/WfRaovwSBk70Sx15xsLK8v2R+A1GBCHlvUJIl0u14=
X-Gm-Gg: ASbGncs4zN1E3wSB3FNmB5ujn2P7vbMc0X2piqjSdnI3HPa0sRjvgbpSkQ9585YNr9i
 hQC0QxsVLJcOlw2sBXNX//D9LmsCE6AK936GcZq+9FH7ejDPupWH+rB3c5WAOy0muQSrxtCH3Ad
 ZsBe6U9f5ATzPPz8byIb24XpEixFka0/20ILYN2bZBDPttnWTTxmTSuD840Ta93X3N3FJfCz5V5
 oWlFw4H1NafssxkWIGyoHxId/Nt4ZnHPFy4fm7NuYTVwtR1kldbtRMMMpxtrtFPnu0YePzOKQ==
X-Google-Smtp-Source: AGHT+IF4dKwHvXJrm3Hl84mC/nXOh17iSh0DQhyW6yx4770ZOuC5Ozq9yk9MqBPSihyQNHwkmKn4sA==
X-Received: by 2002:a05:6830:2aa7:b0:71e:1c5:4f87 with SMTP id
 46e09a7af769-71e3ba9bd60mr2209179a34.19.1734116073450; 
 Fri, 13 Dec 2024 10:54:33 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f33a6e1f19sm44425eaf.13.2024.12.13.10.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 10:54:32 -0800 (PST)
Message-ID: <6659428f-1ebb-4e0b-bab8-3b4e2e703f70@linaro.org>
Date: Fri, 13 Dec 2024 12:54:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/arm_gicv3_its: Zero initialize local DTEntry etc
 structs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20241213182337.3343068-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241213182337.3343068-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 12/13/24 12:23, Peter Maydell wrote:
> In the GICv3 ITS model, we have a common coding pattern which has a
> local C struct like "DTEntry dte", which is a C representation of an
> in-guest-memory data structure, and we call a function such as
> get_dte() to read guest memory and fill in the C struct.  These
> functions to read in the struct sometimes have cases where they will
> leave early and not fill in the whole struct (for instance get_dte()
> will set "dte->valid = false" and nothing else for the case where it
> is passed an entry_addr implying that there is no L2 table entry for
> the DTE).  This then causes potential use of uninitialized memory
> later, for instance when we call a trace event which prints all the
> fields of the struct.  Sufficiently advanced compilers may produce
> -Wmaybe-uninitialized warnings about this, especially if LTO is
> enabled.
> 
> Rather than trying to carefully separate out these trace events into
> "only the 'valid' field is initialized" and "all fields can be
> printed", zero-init all the structs when we define them. None of
> these structs are large (the biggest is 24 bytes) and having
> consistent behaviour is less likely to be buggy.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2718
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/intc/arm_gicv3_its.c | 44 ++++++++++++++++++++---------------------
>   1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

