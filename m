Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4ABBC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taV4q-0007OH-F9; Wed, 22 Jan 2025 02:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taV4h-0007NF-U7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:22:56 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taV4g-0002fw-9V
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:22:55 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385dece873cso3510400f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737530572; x=1738135372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kxDywc+PaqfHI3B/kt0vZYsEnpNikBpJlvxBI8J94zA=;
 b=j5moPesgMyyjZlaVFzOU0AKLsFW55/TQlhbkNjRR6/nVmrzWf13owRIH7gkqn+Q/qX
 kXdSgVGCdFQ4WlZs3bXW9rvQU3q20G/CyQwttiaQXQsKLZcZp/97NO7coxS0tNz0rnJE
 9tiSk6gPa8/5kUyTcfRPOKqfRwAl8cZgGtXODdAMSk8kk01EvxYmZLFqp1mmbLHcYLA1
 HcFe1Bj1m4g0OqudRrJPkxkN52R9Prcwmh2FWBuH572nwLnq3SHIG9Cn5Ac4Ihy+tfqd
 ZtBP1iGzta2zeeySYNOaMr/xJ7VSgYzdSK9EgvOcR43MK1L5qDuEp3FGEyU2xTYfZ8hB
 VuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737530572; x=1738135372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kxDywc+PaqfHI3B/kt0vZYsEnpNikBpJlvxBI8J94zA=;
 b=G7GcJ8OQjQr5hsfWOhSsyLDPe6o1HKeYy6kaHPWaOwMxQQNy2BJjhbvJIvkpWQR13f
 WoTfef7mOD68IDn5tpsWNkAwNymJKTSKsAWGTT70qrAtgA/I4OL4uApJQcYpzNK1frk7
 JpHwmHNH+fsY91tMVjnGG/UUpoCFARnx3160cGkoORcRMKUlolRfm84J8ejRjPiEPowQ
 /9ykXfCGZxBjaxwZAPb+BhJoCs3zxMO1HkeZQjbWa5+1qyUlDUGs2egnNGvsDO3rjQz0
 uaTeMXdxcs66gGbE8HZ0PC3DFeSf6Xs2CsnsgErlpNcO9MuGKQOR/BF26nstsRWK/yik
 o8sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPiafoWdLguijtpeuLNCVBoK0cG1secCKjn5GDwyhiMvQyZA7Uve/cdyEAha+tgygxX1sbwOQVdWWF@nongnu.org
X-Gm-Message-State: AOJu0Ywm5RkDyzf+Y26iFOru3EAVOmRGYypOkesPEy0WFfz9kduMRYkZ
 yeQu/+p8brwn6siB3xc72Cwefr0OnR3V1Hb0r+Pmj2ta7pHEnVt5bbOwOo6tUUg=
X-Gm-Gg: ASbGnctSCda+EHLqoB0DpqZBDOvImULbhh9qSk4dH/rFgrL+3szfMidIrIv5IoLDdii
 lBNZ6XHrJNSmk2/7km7FaCZAluWi/QAz28oJPQmu60iwjkZp2HAU29X575OOxuBwRNikIFxTX0J
 7ybvA0zGWhc5VJFZlb+GR4AnwEplN2TzYzp+roJI/j2j1FUo9pS/BTzmVlZUwNnKTb6cctuOiRI
 9S+fPrEKf2FKapJT2BBMzLyTR9aZPe5gGHMPyWTjqueZYKs8Odr65/umfFg1RyBVPnKfo++68gF
 VWK9dUV9O9KNYY9RBgr1faOQn5Kesu9zg2L7Wg==
X-Google-Smtp-Source: AGHT+IF9BKMhPxTb9aIcd2SHo3oF/bQiPEZc1+pZn7U8puslnDLQ+qfipX9axFZff4jSSI3Va5NvJg==
X-Received: by 2002:a05:6000:188d:b0:385:f349:ffe7 with SMTP id
 ffacd0b85a97d-38bf565727amr18856902f8f.2.1737530572045; 
 Tue, 21 Jan 2025 23:22:52 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3282a63sm15597090f8f.96.2025.01.21.23.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:22:51 -0800 (PST)
Message-ID: <8eadb49c-aabd-4cf4-b3a4-bf31a3bcab45@linaro.org>
Date: Wed, 22 Jan 2025 08:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] Add support for emulation of CRC32 instructions
To: Aleksandar Rakic <rakicaleksandar1999@gmail.com>, qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, kwolf@redhat.com,
 hreitz@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org,
 pierrick.bouvier@linaro.org, berrange@redhat.com,
 Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
 <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112164130.2396737-3-aleksandar.rakic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 12/11/24 17:41, Aleksandar Rakic wrote:
> Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
> Reuse zlib crc32() and Linux crc32c().
> 
> Cherry-picked 4cc974938aee1588f852590509004e340c072940
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
> ---
>   target/mips/helper.h             |  2 ++
>   target/mips/meson.build          |  1 +
>   target/mips/tcg/op_helper.c      | 26 ++++++++++++++++++++++++++
>   target/mips/tcg/rel6.decode      |  5 +++++
>   target/mips/tcg/rel6_translate.c | 14 ++++++++++++++
>   target/mips/tcg/translate.c      | 25 +++++++++++++++++++++++++
>   target/mips/tcg/translate.h      |  3 +++
>   7 files changed, 76 insertions(+)

Thanks Aleksandar, could you add a pair of tests in
tests/tcg/mips/user/isa/mips64r6/?


