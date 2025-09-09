Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C895CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvtFA-0003Tr-5J; Tue, 09 Sep 2025 03:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uvtF4-0003Nw-Tr
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:58:20 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uvtEx-00060K-Gb
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:58:18 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b047f28a83dso881138666b.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 00:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757404685; x=1758009485; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FaRLH3DhroeR+6Lh/DNs+YiJ7TJJDCt7NZn4YtxdyGU=;
 b=GSsB7M6l3xxEsKmI3j+W8PHmHUlCzG70C2No5/FY+hO9l3/pd8TlkCRBUeXqJXhNaV
 qLUw5bPCRzVjz3PIPEjZTfbGL33U1T7kRlPku/4AgJEdF4NQJBZNwzOb6NbjozvpVltG
 i3AyBni4KiVPrfjgl/kFjF/8hSJE4Pr0YRfLgUymxOdP6YTI/1UhjXOJqO0sbsoTJMwR
 NYtBkj+1grrBQWfPXxk96JnAAhVOpxz8+wBbFx91RSTR2C+FmnpepD18+h2TbUUifk09
 gKq20FcoAn3Zj4FFp18SwySqYsnjQazOYFtqmqNKyVcTVTYzoQ1ItFDOd1pqbszCpifF
 jfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757404685; x=1758009485;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FaRLH3DhroeR+6Lh/DNs+YiJ7TJJDCt7NZn4YtxdyGU=;
 b=mU/GWPKkRbggh4JMYltbz9I/+JWYuHL/rF8H4Q/L3WvSP/4QyJPiAsEymfz4wed1tI
 Ur3SfuSysM5QRjaa6OsNHsDgcR6N9Up7Wynab2ykDSmNC97KY6zibTnLM5t7jiG5xe26
 Y7IRlMBfLZk3UVFjhHVdIEcNQgFTxDT2XEHKTWFtURTrCmbpfaf3xk/HWuBxXRgqY/vH
 gEWM0TQEe1Z9iGTSx0FTkux9BV9pqidRTk1+fLnBgES0/MM3raAKkkancOiLW87F0iu9
 g7kDEkoXbXMOCbQwDPWqcLiafB+J5NEmNlyHFM3lgTWFpwyVvR25xn3xirEd2fbfxVJv
 0ecw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmbMa86FN0JjjLBLbQZ7HoFgtSwfaSmB0fQ0Rln9fqYBHxvkGO1bhCMcBMn0a/ugpfwjMBrHvWNqee@nongnu.org
X-Gm-Message-State: AOJu0YyB9qpj1ItIVKoinIEsmWuFsd5dYNS3TzlaHR/w52oK0BdDPhH3
 E5nbLOl+68qoQV2DIQssUqJJYR6J0ZBFL8BHWT5Kv+NeAAi8oAw66p+yPLNLraaMmqE=
X-Gm-Gg: ASbGncsdLTqIpC2an/u0PT61WuqK79/gWHX3EyEXQzuBA04iJWuKuwMs2PCdWF+Qu6B
 TaeSEqcPqsoDa0FoFeKOulMABhwzJmv6VpeQPgW6ZyNQ00pPI14kfEYPenRsIcBfI9fJTuVK6n6
 V4zNJ+rwqS8f3tR5OFaOLXfY5zU8VvCinDDx9Hw5IAHSiHG87huMJ8inG18tsilrpD03rd7o1U1
 ivMOdbLPkDj6NjjxfKTU904dGWAkD86rOHpnidGUjzfextJeDpVYpkjXajYfNYcVOQq3f6VZgE4
 66oDK+SIy7Z61S0rPsi9amSOGzxb0Xop6WsqNjOLp/0Ara12XLOTuTKUYVj3az+mot0wWttMdBP
 RY7LCPFwtYZlZy5RPiD+ADjKX+2q/z1ai2bidabJtCtWrThsWTzzLeOBDvoJ4foYW0hoPY0i4Nj
 R2FklltAyK4PJaVEwG
X-Google-Smtp-Source: AGHT+IF7G0N5gJj5fC0AIA/Tvuc5KilLiInWEnuYxaF8MttGGavrpBT1iYUNJu0/l8JrSKxVkiJe8g==
X-Received: by 2002:a17:907:d8f:b0:b04:5a74:b674 with SMTP id
 a640c23a62f3a-b04b1719e89mr1035598166b.58.1757404684714; 
 Tue, 09 Sep 2025 00:58:04 -0700 (PDT)
Received: from ?IPV6:2a01:6f02:331:6601:e160:1208:59c9:40f2?
 ([2a01:6f02:331:6601:e160:1208:59c9:40f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff03e9ba10sm2585362866b.52.2025.09.09.00.58.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 00:58:04 -0700 (PDT)
Message-ID: <14dfdfc5-c56b-4f1a-b83b-836fe43ec15b@linaro.org>
Date: Tue, 9 Sep 2025 07:58:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/36] linux-user: Remove qemu_host_page_size from
 create_elf_tables
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
 <20240215062018.795056-5-richard.henderson@linaro.org>
 <56a7b332-e848-4e58-ac06-9da6b56ffa5d@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <56a7b332-e848-4e58-ac06-9da6b56ffa5d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/9/25 07:36, Michael Tokarev wrote:
> On 15.02.2024 09:19, Richard Henderson wrote:
>> AT_PAGESZ is supposed to advertise the guest page size.
>> The random adjustment made here using qemu_host_page_size
>> does not match anything else within linux-user.
>>
>> The idea here is good, but should be done more systemically
>> via adjustment to TARGET_PAGE_SIZE.
> 
> Hi!
> 
> This change broke execution of armhf binaries on 16k-pagesized
> aarch64 host.  See https://bugs.debian.org/1114725 for a few more
> details and the reproducer.
> 
>  From the commit message this seems to be intentional to remove
> such support.  But is it really intentional that it doesn't work
> anymore?  Should the mentioned adjustments to TARGET_PAGE_SIZE
> compensate for this change?

We have only trivial support for host page size != guest page size.
Any time it does work is purely by accident.

Older systems like arm32 and i386 are more likely to fail than others, due to program layout.

The only reliable solution is to use softmmu with linux-user in these cases, so that host 
and guest page size, memory layout, etc are properly disconnected.  This is a significant 
amount of work which no one has volunteered to do.


r~

