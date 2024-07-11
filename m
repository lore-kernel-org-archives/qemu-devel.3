Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4520C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRuJl-0001ci-Oq; Thu, 11 Jul 2024 09:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRuJi-0001Nz-9n
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:58:39 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRuJg-0004JS-1C
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:58:38 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so12714291fa.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720706314; x=1721311114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m5dOC5H/wMog01cJKZJXPxkW39qJjTtVw0zjotPI1gA=;
 b=ddQgpATegcZFCcATTpqN3tzFTQyNWOnaCmirZdL18TteE4I8GdVvgUHMVzbIcEmDzL
 1tx+A3cIfgvt2HHp+mCCDW0b6in6hRfUeDtIVLytLEFTZkVUlviASOGLJ/p1/wuruIUP
 7kqPUSXzxSXxxbdxmKkp6OSlpM/ZmNSU2ypvUsTP7gSrzKfdDDvOfRKBv77lq2KJXyWx
 sMAfGoA+f+i3Cdlmz4E8G7W0tDIv7KxapzlIJN6uFNMd88fWa5EM2XyHZem45kOCQSHj
 kwgu7At5kUs8oN/js8OywTlg2PIw2KYWqG2ilHTdji4rLfWwNToUr0eMvnF3TTQ/KjTv
 0J5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720706314; x=1721311114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m5dOC5H/wMog01cJKZJXPxkW39qJjTtVw0zjotPI1gA=;
 b=UPVhYrW9ddXxZs65mxVHTBzo5bd0w7ZbFEkMCPg+vV02CdzLxKyJO6tbSswKyabVky
 ahCTOWrEQUg9t9n/bQ12QYa/wYjQiWkGyNkqqlqB/s0Vel0cy2KgyARcMQBy/HVM5399
 V+xNrzqdHISk9WiVBoQJx9e5DDsq3w+On9xcT0hHXteK8vhyQ8ewSNIHJI7GK6ngGo3f
 MfsNvB+IDdHaywQYEhIMcvkQPrAngi2PhnQpEmz3ezOe/Gr/J73I+jlANawyD64+6nXj
 RduHm5n4iuy379/giafWyHJ0Dfg2CThmOq2xWEhYpzSWRayyna0FPKlaK8pdRTF7UaYw
 cdGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpahlDPDsCVlLuDlbzaSinHMfzvBWrSsvn1h2chV2LrQdThdnFxgMVAq5gnAU+jMaqQp9+BXMcGmCHLNmrtKLJpUwvBpY=
X-Gm-Message-State: AOJu0YxsQeZC1su2icvF77yMWVz5QLNm6gNj3HFnZ6nXOx7/2c+Y4TQk
 AhJEeyYUT6ZaiQSX5PM0k0hOFthO0i+7dWfV/pqAH6jRDjUcf+4FmgammL9Sn7o=
X-Google-Smtp-Source: AGHT+IHqJjnSSHnFMbNChZug6emU/0XfOBg4Dtdj+yOCmyC9DKX0VL5tyh1tFdOJSyVLbHfzGmbJqg==
X-Received: by 2002:a2e:b052:0:b0:2ee:8bc6:6817 with SMTP id
 38308e7fff4ca-2eeb30e511emr57348581fa.16.1720706313959; 
 Thu, 11 Jul 2024 06:58:33 -0700 (PDT)
Received: from [192.168.123.175] (212.red-88-29-184.dynamicip.rima-tde.net.
 [88.29.184.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42725d2e132sm99047875e9.32.2024.07.11.06.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 06:58:33 -0700 (PDT)
Message-ID: <17142a76-0c05-49e7-8e8b-722eecf22ff0@linaro.org>
Date: Thu, 11 Jul 2024 15:58:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loader: remove load_image_gzipped function as its not
 used anywhere
To: Ani Sinha <anisinha@redhat.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
References: <20240711072448.32673-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240711072448.32673-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

On 11/7/24 09:24, Ani Sinha wrote:
> load_image_gzipped() does not seem to be used anywhere. Remove it.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   hw/core/loader.c    | 13 -------------
>   include/hw/loader.h |  4 +---
>   2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index a3bea1e718..c04fae55c0 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -845,19 +845,6 @@ ssize_t load_image_gzipped_buffer(const char *filename, uint64_t max_sz,
>       return ret;
>   }
>   
> -/* Load a gzip-compressed kernel. */
> -ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
> -{
> -    ssize_t bytes;
> -    uint8_t *data;
> -
> -    bytes = load_image_gzipped_buffer(filename, max_sz, &data);
> -    if (bytes != -1) {
> -        rom_add_blob_fixed(filename, data, bytes, addr);
> -        g_free(data);
> -    }
> -    return bytes;
> -}

Indeed last one removed in commit 68115ed5fc ("hw/arm/boot: take
Linux/arm64 TEXT_OFFSET header field into account").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


