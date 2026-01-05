Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16184CD0426
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 23:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcu2f-00035Z-GV; Mon, 05 Jan 2026 18:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcu2X-00033v-Q9
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 18:31:13 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcu2T-0006tD-GQ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 18:31:09 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c21417781so522377a91.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 15:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767655864; x=1768260664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wr8JtvqDJtvtrmkimEV+VVoi2qDkZ7OUrc9cihgdCAQ=;
 b=zDbjGdyCJ7PASPzWl08x+sjwq6mCf1vWME//nvEEhb3jBLYLw8/3Gsi/KO7BTNbYmh
 M1Ac5wq8YWPp+YlBtv8gTsp9HEFZoeVwGhwl9TAUfHsjbi9Bn4XDthLYqgXVFK8f0ZuB
 mvMiKAk7qkI60DofYIB8fG70wkB4ynUUZQ4XpU33s+hTWFR9iTC8zAMmQ183FgAQO6pi
 SOWI/dVIqn+6aejB6I7PbM+B2OzXF1tdLdOOsJ88DzvV8Zqqn0cQR8t9hoyWrzW6Nh7H
 u1GVqmXICgiytCw7WTaLHzLFu+C177bRLXEOipc0/sV850k0Sh8/me5IoUAoi1nJ1Eax
 xfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655864; x=1768260664;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wr8JtvqDJtvtrmkimEV+VVoi2qDkZ7OUrc9cihgdCAQ=;
 b=cjtugvu3Z1kaEokXjyvSuGlYPwySYMV/+pyfNIvmw45brMysoXSWWDjQk00ICjeoci
 WcQqyix1dTCaFPpspXaCYeh3rDrxGgKTaDcuJV0zTM9gBoYJHedXH23Bjt956MdI5QTx
 YUzTC+20ZFKSMRWIN0vLS2dCrvLFDWp2uB20TF1O/R+3Ye/O7HgZe7u8m+10X30JTKkx
 MO+CPa7msGKqR0JVZB0BTC2rWYz6cDXsTaTyF1QJ5GDD7qhAcGPjki1QjVICFZuFdFFt
 uL/n9obGaUe+4Ti9kq3gMxH6gplQs/fJ3aE9vGv5ameF0e2glQt+OawusJ+7X4qTL5Fv
 sayA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ0QwZFDzauywnHEBI4IwPDYQWRl033P5gYZ1kSo96DkJ1L1a4eF0JXqAW/QZWO+mYM+SjDSaNFbzE@nongnu.org
X-Gm-Message-State: AOJu0YxKP9kXRJqal8UoFA32jR7xX6q+s3ixe2K+huwv6H4YlYTnKaFk
 4ltH0i8CeSrsIvL6eM0vzTZB6PbrNaPkfzt5osMq4dLfzmNq+xmro1yQ7o3TT5ZVbXw=
X-Gm-Gg: AY/fxX4D0fdyv0QxuQaJfopUHyfKUwKURCKRR+DukezA2lGPNmQw6UwqjbP+pDhzy5h
 /3/Haqq8BnlNAJpeI2EgT0RGG6+a5vbr4Gmaz1upcic/cZfWVDoyD4PzJIM/qBYKjEuSXYdmTNK
 5oM3+N8OCdGV91womZaDRwNIZ12eqGV9IioxcNLFWMbwGAT+zy9tQZ/hlqvUmKxZ/KUOxXSNPIY
 8Jxy6d3qYAi+XRE2llexg+0jDWMDvBqPPW6NgwQnYqgvuvtAoMlrd5So+tKkq4/F2+kk5qXJLMd
 k2zJ5sk0iTCaRK3qkv5zXPgpzK1byfooF7IztyANs39THaAlsWnOWXpLbjvJGY9zBdw/MmyzWxo
 UfcQxrius2Y7whBBiln+Xm+xyK+w019VO7Q3LVmpNRGb9g4/lizrt1JJBpdQuPv8AbIrZdm0GXq
 hWp+tuZZcuCfJUCILNdsMHMfryyN6I+w==
X-Google-Smtp-Source: AGHT+IFDRUfkhwCeErHzW6X4TRsi+0fF6MrVJk7eQxIBEGkFw22twoOnKnRguq2ajlU6chjQnZvFig==
X-Received: by 2002:a17:90a:c890:b0:340:bb51:17eb with SMTP id
 98e67ed59e1d1-34f5f287947mr734721a91.15.1767655863838; 
 Mon, 05 Jan 2026 15:31:03 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60056166sm165352a91.1.2026.01.05.15.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 15:31:03 -0800 (PST)
Message-ID: <b256c705-808f-41bc-bbbc-69a436bb6fe8@linaro.org>
Date: Tue, 6 Jan 2026 10:30:57 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/12] target/arm: removed TBI bits from MTE check
 logic
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
 <20260105-feat-mte4-v3-5-86a0d99ef2e4@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105-feat-mte4-v3-5-86a0d99ef2e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/6/26 05:14, Gabriel Brookman wrote:
> Previously, the TBI bit was used to mediate whether MTE checks happened.
> This dependency isn't described in the ARM ARM. See D10.4.1, Tag Checked
> Memory Accesses, specifically.

I disagree.

See R_DRGYL: "Logical Address Tagging is disabled for the VA range being accessed", and 
R_TQHWL: "TCR_ELx.TBIn".

I can agree that you might want to factor this logical address tagging enabled test, since 
with FEAT_MTE_NO_ADDRESS_TAGS it then includes TCR_ELx.MTXn.


r~

