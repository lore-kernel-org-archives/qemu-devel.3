Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9387C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE75n-0006uP-Vx; Mon, 03 Jun 2024 08:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE75h-0006mY-T9
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:47:11 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE75d-0000GW-Lx
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:47:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a69024f2433so137729866b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418823; x=1718023623; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUA0fyegu9ZB0F4X4CGTHMzAks3Tvy915F8Z/2yDD+k=;
 b=SRy9WQrNSq9ncXINxfGobrZMPQKphwky+uVjeYNLcrXjhAZxxUDaUsvgHEl+q/fRY7
 VWVu74AZNBc6AUzfDJrd8aHAqTdv9ECyw+YrE8hwmf5138UTqkyUusR5RBPj34qCrnxK
 GDwXUzRJ1Bdk2XGHWiYyFazd56/AokQgudIZ0sr4l0O54Q3DAhxqAK4sOvipkvZSP4iA
 0+udmx3zv4WQw/Y2Oxb5lprA78tbxv858xLs9bUnQcP9ohBTd145ivBhJSAHvOuNloBp
 pZjIuKlGgOqRsVGAf6lTuQIxiFWKgz6d6SsFzrf0odd3vEDo3+1C+KR5vRVuqmD9Ovjw
 LSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418823; x=1718023623;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JUA0fyegu9ZB0F4X4CGTHMzAks3Tvy915F8Z/2yDD+k=;
 b=DGNb5xLJDMDdEsqnWy+Ly+uXR0g0xaJplpdjq4teYJTTS/1APLfJb+tqbLXDjnc790
 p+3Io3m6X1KCwpqhiAkVvE6kIO5u095EeWYD3+HAnT0LkTb7TURfj0SP/fm3TQ761uq7
 XPFMbQgucbDM1U1GEExrXFY0UdxkNrg35m0d/IWZJyqEoQ97FiGrgIwR5yO9caIETm1J
 LKSvrn0TZI9HIHc/LZsHqnApy/zTmSrTLvz4vh0YAieEYNZ3InRSmQnbnHG9awSiLuh8
 wBkBDuxm5w7GU2eOKhN83XEZDMvKqqRjlFd9MKzf9bwid3Y6iM8l/T/wDchJSFoi2ZuV
 y71g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSwIfJKumtTQ2fs43JW05m1poGinYAHfVEWUnVV1kzB+rZFOEVvF2y+o001/7U5w+ZKhIlIgnGpvdQ7yzpJ01Hu29YQwM=
X-Gm-Message-State: AOJu0YzYg0rADDwvRP3ox/p8COyKPcy73wPqydmDwBxbvHupxTNgsG9y
 zB+2C53wb1qlRB+mw1HAf0eIf65phc7ZWRdhUvHmMprPo3OoIcDY/C2W+eWrSlI=
X-Google-Smtp-Source: AGHT+IFfq6sGRcZgV1yCl0dbgCpTT2iw+jU9Vq/XFryL9BiS/9eCCRkppOA2ynzEGB8mhvu4nlmayg==
X-Received: by 2002:a17:907:9483:b0:a68:f6b7:1fe3 with SMTP id
 a640c23a62f3a-a68f6b7227emr317583566b.43.1717418823250; 
 Mon, 03 Jun 2024 05:47:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67ea586910sm483102866b.113.2024.06.03.05.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:47:02 -0700 (PDT)
Message-ID: <7687c5ee-2ad2-4c72-8754-5e84083dd484@linaro.org>
Date: Mon, 3 Jun 2024 14:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma/xlnx_dpdma: Read descriptor into buffer, not into
 pointer-to-buffer
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alexandra Diupina <adiupina@astralinux.ru>
References: <20240531124628.476938-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240531124628.476938-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 31/5/24 14:46, Peter Maydell wrote:
> In fdf029762f501 we factored out the handling of reading and writing
> DMA descriptors from guest memory.  Unfortunately we accidentally
> made the descriptor-read read the descriptor into the address of the
> buffer rather than into the buffer, because we didn't notice we
> needed to update the arguments to the dma_memory_read() call. Before
> the refactoring, "&desc" is the address of a local struct DPDMADescriptor
> variable in xlnx_dpdma_start_operation(), which is the correct target
> for the guest-memory-read. But after the refactoring 'desc' is the
> "DPDMADescriptor *desc" argument to the new function, and so it is
> already an address.
> 
> This bug is an overrun of a stack variable, since a pointer is at
> most 8 bytes long and we try to read 64 bytes, as well as being
> incorrect behaviour.
> 
> Pass 'desc' rather than '&desc' as the dma_memory_read() argument
> to fix this.
> 
> (The same bug is not present in xlnx_dpdma_write_descriptor(),
> because there we are writing the descriptor from a local struct
> variable "DPDMADescriptor tmp_desc" and so passing &tmp_desc to
> dma_memory_write() is correct.)
> 
> Spotted by Coverity: CID 1546649
> 
> Fixes: fdf029762f50101 ("xlnx_dpdma: fix descriptor endianness bug")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/dma/xlnx_dpdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued via hw-misc (except if you rather your arm tree).

