Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582ABD185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoSS-0007ZQ-C5; Thu, 08 Jan 2026 06:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdoSQ-0007Qf-Rp
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdoSP-00085M-9v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767872735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VV8aHsdG4bXP/Y74+Vv48G1FCbBcY4QApp1MuxVpA9M=;
 b=c8//u5VMTBuPzjuVv9jjXj5hIgn9u55P7vOcYRdZ9Kzf2J5fKl3WGa33Q2La9QlUsqMsu/
 brkeN48RW6IYvXeuQXjN8SvZXlkKt541nwsRcbTY1PmQvQPaDvm4HCsA4XW7/2BogHt+nN
 DUUBOJ5QRgC3gEDsQGfNM3KZhoBeQDI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-0PBB7WX4OA6TmU_5pMP1GQ-1; Thu, 08 Jan 2026 06:45:34 -0500
X-MC-Unique: 0PBB7WX4OA6TmU_5pMP1GQ-1
X-Mimecast-MFC-AGG-ID: 0PBB7WX4OA6TmU_5pMP1GQ_1767872733
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so15632115e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767872733; x=1768477533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VV8aHsdG4bXP/Y74+Vv48G1FCbBcY4QApp1MuxVpA9M=;
 b=I/lNgrTMC6vKn0UJmUewi42HuNXOuvArM00JzHGx9UvToOGHSdngjll1ibFvYeMP0I
 5/2RP1Yo23Ybg6S5LjOWNDdnrVoH5c/Pdf99gh0G569pqmj3V2tmxXQr1BYL5f0pkAxY
 4VPa/XG7e1/rFdPbH1LrVz2yRlEouBFcxUflkVGFBby7bGRuErtRq1/04u8V2QkqeRky
 rFAj0IrSuYkivaMdBGKMq54TVI95Ol/ABRPH4mBFe/PpnMKGWoNGZl0qbrkUiIsJNU+X
 mBgAL3TIAVXSLrISRtSyw825mdofG86jcp1v0FFapjo9iSpgOt563Rw50hd1cOk11nQA
 vO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767872733; x=1768477533;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VV8aHsdG4bXP/Y74+Vv48G1FCbBcY4QApp1MuxVpA9M=;
 b=mhCqdTInU1u6AsYoToEcgfTbunqUAJ1S9ecpSto1vQf1exDD/9h5Oo/u+lxd86LKMt
 FZhEMeYxrICUZL50fsrPvFZ/tHaRB3XJoMHKOzPmhSgX6FfxAxYo/5gP0bxJFgcCAiF8
 FCzIrZegMhrEdt8/L7VIpEmVPrkP4bsx2xp7M/gbNbxHS77k8A1Xr5QusZVSGJ8iKGY/
 jr6HtWloB2XSb5XtH0AV68SD0/NgKQlY58aCMMlo6h4tm5SJwqHOY50OAlr0nkfW/CiD
 g/8YoXJUVNOjs12jMu5+rlzOxnEVa/i7mNE1gq5U/09HYAuQfQfcfL+0RGh87d3AH3dI
 1gBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIIE1kJ7IvDHVFqxLEJcPYKjq6tO51hdkD06+8zpMza9EIA2XW3AO8W1nXeBqrkK+PfapAVFQ9R9uo@nongnu.org
X-Gm-Message-State: AOJu0YzpBZdN7z56aYLWoNApwO/5ThkphZWTvw32JWbVBW2ekd1gPACI
 AjG9VFfq0Nmlk8Z86FK/5JU6YhBbaD4Hd9y5CN0BCYoiNnJQlxSFfOeWW85p6pbw3LAY5bF4Hiv
 YqMXJ4sfZVkD0qnR6rBm5x3r8Wdrbcvnc+hrgh0FZXTb4MnlMh8YpDrwL
X-Gm-Gg: AY/fxX5OFQ99Xxkxfh1RpqE3kIvgUXDLbjfMQY6lsj/DD4a7pFtsoOKXjR7G038fopx
 gEATmvWErKToQhQRPOx0nB56aO9y8FNnjCY0DkqLOzn2nvgtpEq9QsJwYniZkQOQ/1bw3iPv9ue
 4w5HmYXdb99fnIasuXkz8x+D3orziTHZ46rwRcy3un7ccj31Xsq9rbTI10QG9AP3F3eR/SeoFy7
 +BxDBe0DgF2uizUYVZCP9nnIf+pfXdnsxXy8x8o/stvM0X1/WL4ajT3ygmYkjVQiMrG+73X6N5m
 PVqq3FI/3z5qVlPn/UPw9gFaSLRa+uN66rma75bajhlwofh4jt+KvFfBjh1NXWw6f85bhE0zOfH
 8Jyq3lx8=
X-Received: by 2002:a05:600c:8b44:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-47d7f410cc8mr115567235e9.7.1767872732963; 
 Thu, 08 Jan 2026 03:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBZ3Ddb3jdhiMjahSaVTDkAwAG3bCsyqAU/vZrv1I5BuO209U9EY1Z/nhcA+4I3Wv9F8rtCQ==
X-Received: by 2002:a05:600c:8b44:b0:477:7588:c8cc with SMTP id
 5b1f17b1804b1-47d7f410cc8mr115567055e9.7.1767872732575; 
 Thu, 08 Jan 2026 03:45:32 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee243sm15713128f8f.31.2026.01.08.03.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:45:32 -0800 (PST)
Message-ID: <d9297389-c33a-440d-b27a-5b5f71e0626d@redhat.com>
Date: Thu, 8 Jan 2026 12:45:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/50] tcg: Remove INDEX_op_brcond2_i32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-20-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/01/2026 06.29, Richard Henderson wrote:
> This opcode was exclusively for 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  1 -
>   tcg/optimize.c           | 99 ----------------------------------------
>   tcg/tcg-op.c             | 32 ++-----------
>   tcg/tcg.c                | 34 --------------
>   docs/devel/tcg-ops.rst   |  7 +--
>   tcg/tci/tcg-target.c.inc | 17 -------
>   6 files changed, 4 insertions(+), 186 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


