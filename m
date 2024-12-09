Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F5E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkhT-00044U-9g; Mon, 09 Dec 2024 15:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkhQ-00044C-TG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:49:49 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKkhP-0004Pi-C7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:49:48 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385e06af753so2140343f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733777385; x=1734382185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2LfcitCnMPp8cosJrqDDGIN0iIT3sziWW4Y54j3KgJ0=;
 b=u9e6/deSbtpfP4KZ27nyrvSLB4jtQH7bupqppb3BxiRHDbbHwBu73zQfQCu+yF0V/Z
 spUtcqhfzdkJFcUCSr+WC0ps8WYrrD4YjR4wFXQk6VeVTUdn8klqYQb0ZNpZ3dtCRuzu
 gswPIqaF+2ZYUMLngyCl9ZqTuvZlvSrK/bXwxwRY/z97ZomgI8hY8CicbwKhj40YW9Gz
 m7nqkRgAeFFhxN4KhRFn568nqCinRtHjEJSwwsd6riCtGzhUEysdI95N1qQnedMOXxOn
 bMYx4rL6a8fbq88Ymo8NPoHjmaRdfkrEjavCje5TAs/nVqAKoow4DrW8CxU/pf2Dzf61
 5/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733777385; x=1734382185;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2LfcitCnMPp8cosJrqDDGIN0iIT3sziWW4Y54j3KgJ0=;
 b=uc+040xKvbtEIRHcx1EBdsbJNgmheNqU9L6Ag8EQp6eC8sPFi19CCrZRbqpbISlyx6
 bSt6LomkWqjhfKD+wlvaDV9CHDcPthsOVzO41zciKKTyFXCIQY8csjKSNRAl8jrj40TQ
 JLK6c+V0W8dRfhf2YUceFOdDDQa3WuhlDpnb9Q6ZidxP6lIRGcEuSKazd+48Y0VL3Drs
 GmPwCZJREhq9jdREDrH8exUzrSc5nPEtIjTKKEk3aj/WpgFfVKlC7ScG97pB9LeGzlaJ
 RwuzDyM8GMnTB1rzDR3oKeW8EQD0s58QCga4N4e+2LS14/d39s/fg+3ALL4LQOdC14//
 tGPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzBcE50eAzVVC2r7maFCl47mfHlxGMeBh2SmOxHVMQX3TFfw1DScYJ4lAy2kAkdpfaH1zPYO6SIfd9@nongnu.org
X-Gm-Message-State: AOJu0YxhvOW9j5/PfMgawnXtZJVcKs5ykOsygF7FcojbXmd3ztqppyR1
 yzxg/ILS/ZUBQmSOri55lp3EWcu4SJ02rel+yw6kU3bpVZUclanrMK7xIIBHpCLIRK4LDDM7rlJ
 0
X-Gm-Gg: ASbGncv0C0ovVEPQllVVlDBIAgOTGl3uMd1p6lVtinqzFu1d8mBBPOC82cCiMEGcd4j
 P/T9TM3IDED0I/coVCIF1t5u3T8jU/CJcIXtgOLfkRN+2R9dp5xOGuj8JyPlUxC4Y7TQgTLZrHK
 tRDDaJeqERqwvczF8q2Y2tgcnB4fLdhc3jgzRPciQPvLPJ6SijYIwgd2KZyVwJKhyQu1qIgSze+
 tL1MWHw6uteeEO0DThn2iAxpj1xYQ9dYShCWQHTwl7DTg3H1FP5yZnos1qEeHo4BMH/rGEp7fVP
 u/RVOB/bYnmjXHbR/UG+1NKP2OSf71eY
X-Google-Smtp-Source: AGHT+IFbrkUSvooDwdIQHuqLUBrCi1w0XK6XVFei192vhAgoGW38UjpSk2XEbFt8X1yEdo+jyAcXbw==
X-Received: by 2002:a5d:5983:0:b0:385:f66c:a4b with SMTP id
 ffacd0b85a97d-386453fe701mr1490019f8f.47.1733777385391; 
 Mon, 09 Dec 2024 12:49:45 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861ecf40a0sm13918626f8f.13.2024.12.09.12.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 12:49:44 -0800 (PST)
Message-ID: <3a2dc416-bb9f-49f7-8f82-cb9ddc8feab1@linaro.org>
Date: Mon, 9 Dec 2024 21:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] i386/hvf: Variable type fixup in decoder
To: phil@philjordan.eu, qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-9-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241209203629.74436-9-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 9/12/24 21:36, phil@philjordan.eu wrote:
> From: Phil Dennis-Jordan <phil@philjordan.eu>
> 
> decode_bytes reads 1, 2, 4, or 8 bytes at a time. The destination
> variable should therefore be a uint64_t, not a target_ulong.
> 

Fixes: ff2de1668c9 ("i386: hvf: remove addr_t")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   target/i386/hvf/x86_decode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
> index 79dfc30408..6c7cfc820f 100644
> --- a/target/i386/hvf/x86_decode.c
> +++ b/target/i386/hvf/x86_decode.c
> @@ -61,8 +61,8 @@ uint64_t sign(uint64_t val, int size)
>   static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>                                       int size)
>   {
> -    target_ulong val = 0;
> -
> +    uint64_t val = 0;
> +
>       switch (size) {
>       case 1:
>       case 2:


