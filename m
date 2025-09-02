Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C5DCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utR4C-00063e-Sz; Tue, 02 Sep 2025 09:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utR3s-0005tn-F0
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:28:40 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utR3c-0007AW-K2
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:28:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b045d56e181so36326666b.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756819689; x=1757424489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JFbB9Q2psToFUA4lfVcQsnYUZJXGFtMbHRgW70lEc+M=;
 b=k0ApspkI8183cSnWIEZ0fBfS6oAocpJwT36yie1Ol1hT1jTwFDaouOmdIxeSUbAsY7
 BLUMvNlGILYOaAthSgMnS2cbWIyDyE+W68s6Ttf+vavvuw7pcdq8+2jRWpA3Ip7NcICO
 pv/gwNADumk83YL/t81F+9J9uB67udppr7cvnG2mi921QUQU0IMOF5mdrcY3wWgnAVYt
 6MlHtz6yHLEq09AQNRMwoTgBVzwMfa2Hth4oTOJ8M96Ts6Pb0Bu0MtPZ0ASHxX5eQtZB
 FZQm6+j1qPMQoBw/fYRraawe/iIvFZx7183RH/gjsb2JnXOeWRV3SZX3f2KCKNECRBGV
 n45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756819689; x=1757424489;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFbB9Q2psToFUA4lfVcQsnYUZJXGFtMbHRgW70lEc+M=;
 b=uJDQh4gPOEStaDMGKKxDbenB9F4RhS6idkXNd1KFEh3FYKphphO47XyIwlbpIRuVrU
 2tfmi0mRscK81JTsRyKlDZbbC7S4BAAsZTEyfE6un12x+uoOKzgWxA3efSoXCiM9Yrj0
 eZR6s4wFTTZuHbrSmsTPFpiYvmPUVsZnmpz6tkz3qyZX+Ldb3w25JgD3nQj7T+oxc/0A
 ldnWFCE+QMdrMh9dnhJsJG7FE+EqdlhbqYwe9/QBB9xfmSBw/qynHXcjdVzq4lgoL64q
 I8tCUEeFInBwpeVL0Vbghu6Ppadk+KSuMqg8XLSFAaohLwBkolkee03gZH1oM+YheAP3
 2Yvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnoFfD2TM2Lg4rLM9eOtWccVpHbTe9pAV2Ra0e2bXpTPEEWTwJrmazjB1wx1F0vs+RbiqxwUUBJk1J@nongnu.org
X-Gm-Message-State: AOJu0YwG/wrYJKui2vpxoUia6iAdIRDDcXpcs071mXQUp62jTP4L6x5b
 mT8P/7NCBHo/dHwfFpZrJKGnV+qRWH3XsCwhqTUaCSJ19u6ThZ3InjO8W7fjuU5Vh0qfcOvhZtu
 dOHaQuiA=
X-Gm-Gg: ASbGncuvfsjfrEkqkbh4Wg1SK6hFNPPhJXbSsPyZ1EXKdWwtO9Pth+3yYb1hPAAP2/n
 HMgUEbdmyumgRGORaw8qcOGJoAQ4eadNdL/o0Wap4NOurWE0kgPvy+3sLqc68Boc6bBWJE28gyO
 MoS2PgWzik1AMRp5WHOthX0K/89k1cmcg/HLVlgT7m8dCrlMMMNyWovlw2jDTb61uXFsO1bA+rw
 KtsQ9UFsbjOn8CJYMJRNKmX0SKeYKmTJy6kb0g1ZaI6QhbNtRxY7iZ4XQJw8/dPRB6fc/F2iwU/
 P4zCfsTVsj/mzvxVpZRFwSOiCHTLdEP4iCk1MyhzBI4NdBfO24zJrmIX/oUEV/wvuZAgAOXOYlr
 APNBhRA30IsbYo6iNpiv/RQqYr1+BBNGTRrCi7RCJYbp13R6hO+RYIy3geJxJP1Hy+Czq3Xg=
X-Google-Smtp-Source: AGHT+IHPXtpNC7qRfEZpSKyVpMuN1HMRA+oJ5+kVgmy7TvahlpSvdvJ7Fi/eeMLnU/4P2FFuTz2Wpg==
X-Received: by 2002:a17:907:c29:b0:b04:5a04:c721 with SMTP id
 a640c23a62f3a-b045a04d063mr152469766b.20.1756819689024; 
 Tue, 02 Sep 2025 06:28:09 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b04110b94cbsm706073566b.93.2025.09.02.06.28.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:28:08 -0700 (PDT)
Message-ID: <b2dba0a6-6c16-4d97-a8af-dd697b1a43c2@linaro.org>
Date: Tue, 2 Sep 2025 15:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] tcg/i386: Use canonical operand ordering in
 expand_vec_sari
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250830033926.372955-1-richard.henderson@linaro.org>
 <20250830033926.372955-4-richard.henderson@linaro.org>
 <7617dd28-7682-45a3-9c8b-2b81d1b6c2d3@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <7617dd28-7682-45a3-9c8b-2b81d1b6c2d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/1/25 16:44, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 30/8/25 05:39, Richard Henderson wrote:
>> The optimizer prefers to have constants as the second operand,
> 
> Should we document this somewhere?

It's not a requirement.  It's just how tcg/optimize will canonicalize things.  Deviating 
from that unnecessarily just doesn't feel as clean.


r~

