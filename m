Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D452CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9615-0003WH-Se; Wed, 15 Oct 2025 14:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v9613-0003W9-OO
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:14:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v960w-0008Fh-Am
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:14:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso4384468b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552051; x=1761156851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NLOeSRpRhaoS16aLWmxoq8ko7RPyRjPJb2wfqebKudU=;
 b=aYbIw2ilMb0Fvy0EkEBuKU/04M13GCSbx9abBKuLUxpSs/PWdooAN5AtayJzKIyFFT
 Q62qf88u12rfjE4YzGGDY+hOi5sYJI5Oky1nRYA3Jsm165aMstfAvzanmlcfXPyNAinV
 8TMwT9j+x3i7dRb2uRV5KRHl3iwSEQAM+5CcZcKcFpZXr4gBvZBaPh4n8hYM+OmCuM+X
 MEzahU0QeygJcFL9ScrHmTqELuvX4iJ58LBUlcGg2PsinIjfCr4jurTbJdbDtjU5RkBP
 OZYhwJNUaLDo4Rjx9T4tmmZj5eCErI0sf7I5PyRDMbh3F5KoyYSWmp63q2ZXByAL3SYV
 /R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552051; x=1761156851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NLOeSRpRhaoS16aLWmxoq8ko7RPyRjPJb2wfqebKudU=;
 b=iS8kb6RdStTui07E7hSn3C03Dje3FYpBLt/u8oec3+j/yEGt317Ln05q+npOfax39j
 ySVQjd843Q75fxpNDfxlwJGKMpI2yjFWv1rWVktVKWV9F1XbBbWnITRHKC8VjD2eo4mI
 AMzelkd4DZv4a/bSrK1F8MAmDL8xoHLGyK88TtcQ00rzzYpzrT28yE5eunwKDUSh2whM
 jkFzeZ/un1Pf7kmwJBKkbkxx/a+TC8zd66ObJLGVKw2hXAXrSEnMzv3gUJw0jab5ehrj
 gEV5aFxQIEyIluwqj5+FG/fW5yOClC9tBZzFIXEQ8OA6M1Yj4yM4+bIGxzvBCtKpPJqM
 qfSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS/5Pgho0wy6kigzBN0bJ32GHs3rWOQlOGfKJRufCzmeOfySEm3r6tiEyzowwzZAn/97zFxQpq9DXr@nongnu.org
X-Gm-Message-State: AOJu0YyQdDjA+Y6ULNXC7nuF8O2pXAItTXe/brKmNko8Pg+ps7VkF9oY
 CqMo5XEXUpIRQ4ZUg8fVBngwb0GnBOJBgMb7pT65MgtcIrSZeJCl3enEbZKnBw6QxsQ=
X-Gm-Gg: ASbGncvihGaFwbzzIIYe/xR/9hLGYmbn24B5UOKN3WC/CcKUh0FkkVA4kFsw46cMSx7
 Ev5KdCvUhEYpdrXoSOAYMN69+Pl0bc4lTnsAEBTYc+Ip6Fioo3lbQDxAt/Kg0yyzuAXbgiUb+wz
 fPIefYYf9J8S1YGDTGxZUpzmAEUAjFjUoPbBL/mqEVgceNzlPXsNiVR5gm4dNXwEsvdeQsTvmcI
 6NxXLEr1Bmmh0nW8fXfJ+BnIPLqj/40Cziez8sMquS+av4lzmptCvWx2hMIYUBEA+v+ZqhqBXRu
 X60s4widsjsnwgxutsQpLjuKHy5PPNVI8rENZy+bcfS+swSmCKvk7Luyh+zOB14CmT12JTazblX
 xns45wCl2gTHpFkHdk79qCJNlEPJeWWZ8187z+6jFVVqAj5+0HTKoz5AOAA==
X-Google-Smtp-Source: AGHT+IEU3dZytynKBcJxng7Vi4evaRfLw6saoGl/veGB7f2pxnWoDXqup0pi4U1KINprBBjQxd5LQQ==
X-Received: by 2002:a17:903:2f83:b0:25c:392c:33be with SMTP id
 d9443c01a7336-290273a415cmr381194655ad.59.1760552050593; 
 Wed, 15 Oct 2025 11:14:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29099a7b0d3sm2916105ad.66.2025.10.15.11.14.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:14:10 -0700 (PDT)
Message-ID: <10307c42-8ac3-443d-9046-30c1b7dad12b@linaro.org>
Date: Wed, 15 Oct 2025 11:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/34] target/riscv: Bugfix
 riscv_pmu_ctr_get_fixed_counters_val()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-5-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251014203512.26282-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/14/25 1:34 PM, Anton Johansson wrote:
>  From my understanding the upper_half argument only indicates whether the
> upper or lower 32 bits should be returned, and upper_half will only ever
> be set when MXLEN == 32.  However, the function also uses upper_half to
> determine whether the inhibit flags are located in mcyclecfgh or
> mcyclecfg, but this misses the case where MXLEN == 32, upper_half == false
> for TARGET_RISCV32 where we would also need to read the upper half field.
> 
> Minor simplifications are also made along with some formatting fixes.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> 
> ---
> NOTE: I've not included any reviewed-bys or modified this patch as it's
> still unclear to me whether this change is correct or not.  Alistair
> mentioned that this can get called for MXLEN == 32 and upper_half ==
> false, meaning the lower field would be accessed.  I'm sure I'm missing
> something but this is still not clear to me, it seems to me like we
> always want to access the upper half for MXLEN == 32 since that's were
> the inhibit flags are stored.

In case there is a doubt, having an assert for this situation would make 
it future proof.
g_assert(!(rv32 && !upper_half));

As well, maybe Alistair can point a call site where this combination is 
possible.

> ---
>   target/riscv/csr.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
>

