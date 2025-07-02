Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D0EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz2e-00033Y-Q6; Wed, 02 Jul 2025 11:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz2Z-00033H-4M
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:06:27 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz2W-0000qj-0G
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:06:26 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-73b1b1b3cb8so853041a34.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468781; x=1752073581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fn3zX4i3hRh4g4oV0CxqW5j2V3Q4yZPJOY4VbK7dbaQ=;
 b=u/8bMlPag+6Wav6q59TdBaQyQLWTa+9Blmdz/Yd6vPf3+B+NaWesm0HpuPtdbHOqLR
 3CQT7g3wvR/2XHbmfiMt+krHJ+vpDHdN2u7Tpj5v+mqEs/XxmR73ln9cLCzC1LnBXfLC
 P1B2xNW3KozdupHSR8k/YUNO6N1eEvN1z6Tva4r2Yabv2tBIUUme7+yP5PPImqKQQINS
 HaV4kH5Pq7Ut4RqPkyYw/kMd5AZib3506deS+kUXBCIP0etOAJ/QBtUJwRKfgNMPfkCh
 a1R/0/CJnaAmSLVFFqBAg20wco+3PlY7ncIvGlZIze8n8XlrX3CSkJe6/3H551LdHg/P
 0bRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468781; x=1752073581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fn3zX4i3hRh4g4oV0CxqW5j2V3Q4yZPJOY4VbK7dbaQ=;
 b=YbapcwXOC+PFK4nyA7GhKcHUrgM+2B6etWK61BUvA8TxD7jZoTfaxPTNDMgczLsnWK
 Qx/ovhcnk3WyJ9/cTr6+T9RMXRlklfzXjMnMBvoqeXlXAjG5xmUqK2dImEoZxsVY0LQh
 DjSk1Jc/c1I57f2HEmbU5YaS8tZtMq7QQxfpb4KVSMF0WBjvDLFgOEQhGAiacnsVNKtw
 uYm+y0Un9Q0L2bM5jlrhKnTZyNLTrLdBxuBymLUWzzcb7LPHku3BQICcbH0IkJWeaQy7
 oktX4JKFxFqQfKhnyJDAnvxzwt4G2jmws95EucHgQHJ8HPyyJX3PiEAdAlT8Ilsj6Hod
 Vylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYh/AeR+uEdLr2mj1+vNszekAtLNn3/2qYhg+BlKLoZHzH0/Ug1/HZJdGv5ekRBKC+leH0837+XOAV@nongnu.org
X-Gm-Message-State: AOJu0Yw/YqsQVTpUGPBgfSKd1BaLtQIo+oysLGiBk50/Sx+nfe8GDQoP
 njKtGJaTIKVJ7hEX7hZW3efGzkIxYbvsGTT5AFWZVNAEe7bqS9KTpOQVq4BcXBBeIGs=
X-Gm-Gg: ASbGnctemRCVmrhr0Gool525P0IE+m8w6s4omWwG+F3w2S8Ox3fbs9r60BRsaiIBpQW
 WjooNpzDnIbUsiwFkd0hBQqDiphsnhGUsvGIvZD5sQMV9RopGdz6w/y+gVxaAcFf90unkEOHUqn
 eVKfirGBgBJOFDnIUHkEsOtzutxbHLLnoCL8mAkP0wnUgE7zK6YSp9vZNKtGAG6LV7axt/k0ups
 LKN5DE71cUgbmbpQBy3KnswwCB62CDo2w9NFfah0P3XheMiyTHGlF2y199KQIL/rXQa+x123C1E
 icRb7ai+u67+p+yY5EAQ56pJvf2qvcmkTeQf+JGuSu4zYoA3rFU5F04zaSUyUpqB47vG/0EBCMz
 7
X-Google-Smtp-Source: AGHT+IEfhKFz/1Zgp8oif9SJACE4rI6eLgcC2+2OUH89RQ2b/1Nca6E4hdjUpS426upJAIZi2ZEEgg==
X-Received: by 2002:a05:6830:911:b0:72b:943f:dda8 with SMTP id
 46e09a7af769-73b4cdecfc0mr3157376a34.26.1751468781046; 
 Wed, 02 Jul 2025 08:06:21 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e47f8sm2549875a34.43.2025.07.02.08.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:06:20 -0700 (PDT)
Message-ID: <0f2353bd-68fa-4a96-9eba-12397b0c5554@linaro.org>
Date: Wed, 2 Jul 2025 09:06:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/68] system/cpus: Defer memory layout changes until
 vCPUs are realized
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> vCPUs are not really usable until fully realized. Do not attempt
> to commit memory changes in the middle of vCPU realization. Defer
> until realization is completed and vCPU fully operational.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/physmem.c | 8 ++++++++
>   1 file changed, 8 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

