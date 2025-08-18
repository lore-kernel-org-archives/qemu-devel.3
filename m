Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7A4CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 22:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo8Pc-0007VF-Ga; Mon, 18 Aug 2025 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uo8Pb-0007UX-87
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 18:33:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uo8PZ-0001Xj-NO
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 18:33:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-32326e05b3eso3284292a91.2
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755556384; x=1756161184; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yl8vkr5/29swFnBO4u1rw7RwOH6ITTINekQuf8D1fPg=;
 b=No7EsimtevQYnjutPpxeVJ2ZvIzzEX8mY0UIhtG1FGeh5eGQRB3XjgEBbCeGnN550T
 +1sQT5ymx+byyDnm6xVHXuAKKaKTTgmTQAVOYNgacnn4MWvUiu6MWXiVVsKmP7YQFTsN
 MwiA2qn9rTYORHb6tRaZiB7b9oFf5c3pAQDUvVvpT0V9U7GHJBowDXS52FNsDdttg8yU
 3RvPFxFGZ/A1ocJMghc2MmklHqp4ePFnalud025YaPN/YkjlcvUh5S1aWpqdK9JgFmyZ
 GqdSLV+5E5Bm+oHpE2KvUDyyfMrk3VVF1T1p71SyWux4zpRunBHVY63sCxGWVj1vlFi3
 Npcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755556384; x=1756161184;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yl8vkr5/29swFnBO4u1rw7RwOH6ITTINekQuf8D1fPg=;
 b=f+1YceNGKxPLzXXyVuwydYSnzEXDzvukiUgA/CKmXE2rJis7BhhVXDWoq5InT/JOJ5
 BOBMB3AT664m3T62QKQH8ShTOd+D8F/rzT8BNMJy6b9XYK4lY0f8MoPXfWNJWVrwFKKE
 5+qQCOkIGgS3JKY+EDif2v6FqZ5Obq6UNGq9tKYlCBpnK54UePUOF0VOAEhi2d0J0VCp
 j00F6jA3cTSZwGq18S0yCBMQtAgnhuP7oKaWXhlMHxHjt0Q0SdFTgt22VKhDeMonWltI
 c8BF2rM7lP20IAYcDpagvA8nvf6wftF9iMjXJuCMD5a+3VsufVCaAgz6QEVfsZWd3Px2
 ijTQ==
X-Gm-Message-State: AOJu0YyVMrxLzoEVMsDfGBEg6koAXsYBXbBROsTMl2Y8bbwVC52k5Lv1
 Z4M6f+sEmU5kXnlwGw8TvvShgNhjOOG8yvy9gyDSIS2UvNqLWCPT+sW7f8u5jRmBKVc=
X-Gm-Gg: ASbGncvWslHI+Dqag/LqdhNqfZuqBURoqBpkPFADEgCVtznxr5haMH7EjsKzpaKnh7Q
 xcER45g3MeMQEsdtJ+7MCmRsSDaqOdNOnciIs6um7xIpLJR39f2WwP1oXHiCcq6SI1qDhcMbkTo
 D50POBcpQLJBvPkZkKxk3QJCpN4E4NIrDnvQeDVPNV5d2RHqZNQv0DwXmaz3u/pVTe7jvbSKAoE
 5IV7Skorexs9XwjdaS5z5sFsH5mNNZ85LZID9c1oXo3A71a+pC9o6j7IG0vL3dbR1GgAd0OsVBq
 uoTK4gZCNzW6Vc9BjV2ZjPhmH/D91S2PshgxXMDGCZ9VC2gR6X/yJq5j7EQw5fTQzNE1a3jlr1L
 lf8T8wRnOHY0ybI3tk7O5CMOBgtc4SdJ+30PP/iU=
X-Google-Smtp-Source: AGHT+IEy2K5Q75oswKdjgisJo1gd32HWHveSg/63LZgJ0e69BW6pKF1C+L9RbZtkCpqhyjhZ5t1B0A==
X-Received: by 2002:a17:90b:4c02:b0:323:7e80:881a with SMTP id
 98e67ed59e1d1-32476abd6b1mr710766a91.37.1755556383833; 
 Mon, 18 Aug 2025 15:33:03 -0700 (PDT)
Received: from [192.168.1.104] ([206.83.122.207])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b472d735e83sm9076624a12.33.2025.08.18.15.33.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 15:33:03 -0700 (PDT)
Message-ID: <a535b980-153f-4329-b0e4-b255a6b858fd@linaro.org>
Date: Tue, 19 Aug 2025 08:32:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] target/arm: Enable FEAT_MEC in -cpu max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-7-richard.henderson@linaro.org>
 <CAFEAcA8ez8XW9xn+Q=XwCFf+LObEZN9yQSEmEcy3hXTwYe2tCw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA8ez8XW9xn+Q=XwCFf+LObEZN9yQSEmEcy3hXTwYe2tCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 8/18/25 23:42, Peter Maydell wrote:
> Looking at this again, I don't think we should set
> ID_AA64MMFR3_EL1.MEC if RME is not enabled.
> 
> I guess the way to do this that fits in with how we
> already handle "user-facing property disabled feature X
> and that means we should also disable feature Y" is
> to put a check in arm_cpu_realizefn() for "if RME
> disabled then squash ID_AA64MMFR3.MEC to 0" ?

Agreed.

r~

