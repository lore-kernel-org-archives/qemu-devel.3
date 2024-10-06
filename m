Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5217ECFB424
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Oct 2024 15:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxT6P-00047n-Bc; Sun, 06 Oct 2024 11:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxT6K-00047I-SS
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 11:23:16 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxT6I-0000An-96
 for qemu-devel@nongnu.org; Sun, 06 Oct 2024 11:23:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71def18fe1cso1055534b3a.0
 for <qemu-devel@nongnu.org>; Sun, 06 Oct 2024 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728228191; x=1728832991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4fjyxKJ3/G0u/DLnGLPBRV7MnMS/uyjpHWFTpctEvg4=;
 b=vvgA2YHqVAynY+k0J0sAQHVGDhKdcq6W62lI04ff9P+0PFJPgYhsbMYLiGL3IkC4Vv
 d7r5ly1bA8AdEE5hSgIcLI7a1anyQC61u926QUwPKAI8GA8lD9za75RC5qdnjHgbQV5n
 zlV1VnBlDCZOXXvbZGDeUo7XSDxgJXheFBjFuNvrzjCYogqRs+4/W9PY0PXeDgBdDTaP
 oYofRx09Un2UT6xo1CotzSCLpTEwCO3o3+CNHSmWQxo+Jtce03aWMajkE0VKKlc4LGrJ
 qB6bBDYuGgBFRsTbkrFaFurN2E4hGjdptHvmXq9vaKYCayUmf75lmQOqLi5WOEqlD6TW
 ibcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728228191; x=1728832991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4fjyxKJ3/G0u/DLnGLPBRV7MnMS/uyjpHWFTpctEvg4=;
 b=GjQ7mlSlZOOlpjgDIEeIm1UOSx/69HxmVRfy4AMlMHa6ZetwOxDZ1cNrhdpzbfbCOt
 NgvEVX0RSXCSmRRnhcNjLf/L9mtrZR4wNy4s2ZVnjw3pKPPpPUXuvcpdYaBcPgZeo+Yl
 86YyTjozRo3+/T2R02eEEYKwRN7kLWYWf0TtA7C9zMwzv8U6suBQl4NxBjx72fovLm6c
 K/Y5yjQhndmb9FHB9w9xmGGSrc7MPG47T4WhAuDWL84nt8acl8nTEYEgcsQHVk6m48Yu
 5kOrPP1WESRPORa6+n1GVfhpfEaDU0vLxyUBKvWO4UjH0W4vbCo2dX0z0F7lsq+FwMzr
 MQTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJXtyiIt1hlapXukyWIV4hqaoJcOP/CDw/isF1yuAOWFmXEq3Qu/wkdoj0nLkpQwnDPus0MWKiyvmE@nongnu.org
X-Gm-Message-State: AOJu0Yx2M/X0a6ssQ5IMeJgdtwfXeoB9QJzLW5QuFDcGujgfKGRtMe52
 Utzqjhdele2ch40HZfaOI1REoSOjYleqC37zeG52tbVgfnJ0O77sK/DjQkbiiLo=
X-Google-Smtp-Source: AGHT+IEflkAsWcI3OnNWIwdI7EqsWI9Nv4u8s4uS0vZNxuMzhHFAP64UHuxWFn6IF9TDebpiHFzh2A==
X-Received: by 2002:a05:6a00:997:b0:714:28eb:ff5d with SMTP id
 d2e1a72fcca58-71de23b5549mr14274817b3a.8.1728228191018; 
 Sun, 06 Oct 2024 08:23:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d4538bsm2891667b3a.104.2024.10.06.08.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Oct 2024 08:23:10 -0700 (PDT)
Message-ID: <66c2c949-ccb2-45d6-8d13-2c34ccbf5760@linaro.org>
Date: Sun, 6 Oct 2024 08:23:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] linux-user/flatload: Take mmap_lock in
 load_flt_binary()
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240822095045.72643-1-philmd@linaro.org>
 <20240822095045.72643-3-philmd@linaro.org>
 <d7d4d868-08e5-40d5-9a19-5854db9828f8@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d7d4d868-08e5-40d5-9a19-5854db9828f8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 10/6/24 01:51, Michael Tokarev wrote:
> 22.08.2024 12:50, Philippe Mathieu-Daudé wrote:
>> load_flt_binary() calls load_flat_file() -> page_set_flags().
>>
>> page_set_flags() must be called with the mmap_lock held,
>> otherwise it aborts:
>>
>>    $ qemu-arm -L stm32/lib/ stm32/bin/busybox
>>    qemu-arm: ../accel/tcg/user-exec.c:505: page_set_flags: Assertion `have_mmap_lock()' 
>> failed.
>>    Aborted (core dumped)
>>
>> Fix by taking the lock in load_flt_binary().
>>
>> Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2525
> 
> This one seems like it should go to -stable, is it not?

Yes, I think so.

r~

