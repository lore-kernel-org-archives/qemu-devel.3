Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B01BE7718F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 21:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQvMJ-0000um-Ko; Thu, 26 Dec 2024 16:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvMI-0000sn-0s
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:25:30 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQvMG-0003jD-Bl
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 16:25:29 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-219f8263ae0so42913225ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 13:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735248326; x=1735853126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZAO8PRz58dbluLAzLjGAfYeZTwfBRg4MB+QVkc0/pY=;
 b=tuILOqZFFUgCdLTXnqeG4AvxDbwf95CPDOXA4JjuOf3Y97qtOBGUvQQvmMV+sOcpUm
 1vES72pj7gpff+/Oe9O9ihE+KNNfvS+GUDoSwc+Ecz8cy0ZWsbo4Jp4AbfALhtndRB5p
 BT9u6l20Sko/GBstypQ2YAlstBH/v+/Gvf54vWFBB2nHDXJWlBfdBSbQDCngBPvHBEfk
 AiHA/fIHpVmpNYHcfQiKDW5XxIXIxe0QCUviWmpVr0nn4u8EhdcxAPJyhMUHK1RwyhPS
 Dxb9xosfxnmgeTPfAWQZOrE//Qik4Pr2QQoRqHtHGWUrq4EJlNBeWzlwc4If9Xi2zXwh
 LseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735248326; x=1735853126;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZAO8PRz58dbluLAzLjGAfYeZTwfBRg4MB+QVkc0/pY=;
 b=iepQ+w91qZfxya+kH9iAsJRER/mlwt0Kf7dvP7QY3bDIvymMa9X76XYFCCUNow+dBj
 mc6PWIGemIqsrFf/5g26+YwdZRxdijaitaiWUNNVaJmGcAlgFRDcqaNT/pFBXjLBo5N7
 Ykn/3ikmFirw9lqbdUfHXMOrkiGJci6E7zje8Yx2d1KGY+vK66MmlnOpgpJnbEZnYPEK
 C7g9GFddWR9fgnMYLTbATF9vNlBSIouk0SIMU1j8lXyFytcyWt/6TcLDUH2R4vMqb6PW
 7IxJpPl33hNyAIxxxI9etE2fctf4P6rj4a8YhEw9PLkvThIaY5rNjLus4VEtrcoYOlvO
 ta6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFiApZHgDHosuRv1ItdFsSFVD46TU08vJEa/9jmPkK/ksLh9tE5SJqiv5CROKUDhYo9yFq9NJwD4qF@nongnu.org
X-Gm-Message-State: AOJu0YwU9gvEBU86Jf8kB1C/hyX1bxL3Bl77eLN8kwLGjK0ciKzsEojw
 yOAU0UEkHqYupCOsoE4ww6zYA39iih1jv+jb15g+RsQ8Wbfx93LUBwI9aYk8d04=
X-Gm-Gg: ASbGncuH8mDMrQBV47RuU6KqQPf3tS0/2UuH+r1JWFkprHwTMXNqU8FyLuNVhMIg92K
 3OFsmBSK+HTPzNnitNU9xzy6+SGs+gDBJFzQZEwwvOUDh209RSdFRWteYH8szUoZsDNfCdYRD3l
 U4XrC7bZt824MfCwITWRE7dQpbBRDolakh52GrBNcMPkL1RoiAarpdYcx/28IMbjhS9B23MOl5p
 arlSW4SCVoxpTuOLFl31eVQLrgHO4HuRQcKKJocA+OcbR7+fVXnM70VmjBv7PQLFn00+92VHm9e
 35ELp62eePKkmdDEx6rhEGukNKk6I8dHY3dyTZU=
X-Google-Smtp-Source: AGHT+IFpZsYJB/sXGcWUm/Y0sRy4CvTD7xgYZcRCRe7EfxBELTaGHp57hBakGayae6J+zmB0ZMTJ5g==
X-Received: by 2002:a05:6a00:3a19:b0:72a:8b90:92e9 with SMTP id
 d2e1a72fcca58-72abde405e2mr36816950b3a.5.1735248326657; 
 Thu, 26 Dec 2024 13:25:26 -0800 (PST)
Received: from [192.168.125.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90c225sm13351742b3a.197.2024.12.26.13.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 13:25:26 -0800 (PST)
Message-ID: <6740687a-07cc-48a5-9add-c9231102364f@linaro.org>
Date: Thu, 26 Dec 2024 13:25:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/23] target/loongarch: Fix address generation for
 gen_sc
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-2-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-2-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 12/26/24 13:19, Jiaxun Yang wrote:
> gen_sc should use make_address_i to obtain source address
> to ensure that address is properly truncated.
> 
> Another temp value is created in middle to avoid data corruption
> as make_address_i may return the same memory location as src1.
> 
> Signed-off-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/loongarch/tcg/insn_trans/trans_atomic.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

