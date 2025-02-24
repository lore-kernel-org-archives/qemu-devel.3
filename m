Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82DBC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmfB7-0005CE-Nv; Mon, 24 Feb 2025 15:35:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmfAq-0005A7-NN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:35:33 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmfAp-00022E-5z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 15:35:32 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2211cd4463cso97868355ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 12:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740429329; x=1741034129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kt7gS8BmQi+IL4wbz3L6B79T8ydpItRDtTAfYOHZWGQ=;
 b=nFUYD/AnuGiJpgltGAxIFOIUXkCMOZO5Ak8St7IDSwraJnBZxwSPEEqzi6lAHIJ0PJ
 wnaGAu+5IUpRVlO0joMYbSNqb18RLRfcSMGdlHlqhLqjVOokvozglHTAzZ03zM5I6vqR
 mNww08UINmGoHg8BtFkYCOmMmm0XtfVXS/UQ6Y+nQ6TYAJqR3kb/8x75T+EEn4okolpg
 UTcZgJzOXdEiio57Pd6Dk/BH3o8ndzuGeL3EcP3+vSWYTkKvmZeBDgOZuEK/9aIIEU/Y
 86sWROxhlJCC9Gh4/mlccjJKniu+xxM1YyZe9e1cQwvVjxL2Rxh4JdEx1yECvjHB7QNp
 NGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740429329; x=1741034129;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kt7gS8BmQi+IL4wbz3L6B79T8ydpItRDtTAfYOHZWGQ=;
 b=gpEmbdeCRQnopBli23KNPBtr+oURmJw00+jQ2Y9Mdhs724l+sCZLz3TuDL2p8GUk7Z
 Aff5bFdgMbh3Pl0Uwl6Bxa0YeWHc+Ot4VwG7ut3ew4+utIFLtBIxtcIcFygXJ5WGJXqi
 qknuU6KKyf9e8R8KUdHHGo/SuvLFjjuHOTe3R0uayWG3mY4d8K3VLx9waHlMMoQEFqrH
 uDfcJ//Wh8SJZ8yHjdsrE/OPKpk9eVA73lIechPvWCPv7aWsTuHL5oENteUFrZ9Skg5a
 y/6QlfLmBETZOJcaOEXnQKZf5ODzBbaEiVOQ766RoLIFbmGHJaN9eqQjQ+U0Icqnk7+d
 BpbQ==
X-Gm-Message-State: AOJu0Yy56I5WkvkntywWInJcXZrylz4p9g2vbfjVoXEQlTVAlQhsnarg
 PclecZmxnJsC+975m1Ufyv2xDPd3zOU/Ra0W+tMUtvGR0ljYc3U5HrK6VcPm/oIybyP0KDkEEim
 n
X-Gm-Gg: ASbGncukq/kQJ6YoYnmJvf7Z8O6dLQArQiO1JGvLyjIYPlZ3bsld5gftRXWeXNJn1TF
 xp5KlXbdMzbNWeEPXR+kyBlNEPjaN+zenZs9WohmPzD4fuQHki/5MyHMmZm2/xwyz4++VNZ3OhR
 8LR4rzCU41/6wX+D+NerD1QPcmILI1dyQs5SAlsDv5NIOiY6ufatUUlOLxaIUYK6vHosJAlGPPP
 CfqB0qiyLNvqs1+N8JV0kMRLVrcu//6AYfndC7QbB5meVrMDvjzVwsHxcsBHlF0XUOxCH8iSer8
 2ms9bb4U3jkHz5K6HwClLq93qTi2to3gvYi/0qhBZrHnXbsl0FKrWOBOl9u+HDoya77qgdQjWXB
 4Wj06wD4=
X-Google-Smtp-Source: AGHT+IGGXGdZYHzY9I1FAYx1O8sDqAd2/YMcYNN2+/S2g2EtH+4nSH7PGJyco0l3Xo9/aUCOaLSOww==
X-Received: by 2002:a17:902:f68c:b0:21f:7880:8472 with SMTP id
 d9443c01a7336-22307e675a7mr11480485ad.35.1740429329450; 
 Mon, 24 Feb 2025 12:35:29 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0944a4sm238125ad.121.2025.02.24.12.35.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 12:35:29 -0800 (PST)
Message-ID: <1824fbe1-33a1-40db-8e9a-afc00f13d2b4@linaro.org>
Date: Mon, 24 Feb 2025 12:35:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/61] target/arm: Implement FEAT_SME2
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
 <9e0853e9-b590-4a84-8214-fbb543bd4359@linaro.org>
Content-Language: en-US
In-Reply-To: <9e0853e9-b590-4a84-8214-fbb543bd4359@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 2/24/25 12:27, Richard Henderson wrote:
> On 2/6/25 11:56, Richard Henderson wrote:
>> Based-on:20250201164012.1660228-1-peter.maydell@linaro.org
>> ("[PATCH v2 00/69] target/arm: FEAT_AFP and FEAT_RPRES")
>>
>> This implements the Scalar Matrix Extensions, version 2, plus two
>> trivial extensions for float16 and bfloat16.
>>
>> This hasn't been tested much at all; I need to either get FVP up and
>> running for RISU comparison, or write some stand-alone test cases.
>> But in the meantime this could use some eyes.
>>
>> SME2 is the first vector-like extension we've had that has dynamic
>> indexing of registers: ZArray[(rv + offset) % svl], where RV is a
>> general register.  So the first thing I do is extend TCG's gvec
>> support to handle TCGv_ptr base + offset addressing.  I only changed
>> enough to handle what I needed within SME2; changing it all would be
>> a big job, and it would (at least for the moment) remain unused.
>>
>> Still to-do are few more extensions for SME2p1.
> 
> Ho hum.  I've missed the entire set of counted predicate insns.
> Hooray for Arm sample code!

Oh, duh -- they're in SME2p1, which is I guess not as optional as I assumed.


r~

