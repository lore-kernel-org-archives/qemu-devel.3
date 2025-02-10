Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE463C021AD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZYZ-0002bY-QO; Mon, 10 Feb 2025 14:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZYJ-0002ZK-5w
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:34:44 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZYH-0000aL-Bd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:34:42 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f5660c2fdso61451605ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739216079; x=1739820879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bIdm4av7GLP1JPzPapTIBAyshQn9iabCTSasGhMRmXk=;
 b=KbutRqOwlgX53BWOvMScPeKKq93/+TYk9s/QWFeyA8YHL6HhxG3n8HZnapSm1GF2Sa
 KINxH51Y6EyOPQ4vklC/Lxwf1UbrRNdrKQjB7Zxfygpsi6HP5yQ4zPdD8r9e9FwhIsfr
 F8llu6OO8Flh0mYbwlV5f9U6+ylsic9jcYSE5a2ZcBYZ8puoxKYFRqBM7gJdhpsXVn12
 orr0VgELch+/2zMlc4s5Cl3YjLO9kBvtzxAhwopfR/olCIybE5g/RKlHBDsNwChUkSQm
 k+S6OfFR6CTpPSQZ8FOPpxuZWVls545LXjq3naRdTJnnk5fxTPL66/RWKvgyV5xqpdiM
 zSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739216079; x=1739820879;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bIdm4av7GLP1JPzPapTIBAyshQn9iabCTSasGhMRmXk=;
 b=cyHEhPJizbKZp/J9V4UsqRYN932rzKSa4K0EDvMW+UBjN0TWQTZiDTiox5hmMf1ks4
 Fl+j1FZDsYcW42METpm32CLYCR6NMlCXM54QIvvCuQfw9r1l/yy8QqFQpRfoTWyjtB0e
 0v2tEgwMBw5f7U932fZxk0JFuI/fxbM2Xllpey3keVX33CSL/4zhkzpGex7PWQL9qe/R
 MQmS3e93BONK3xWO85H6FS+NfKgEM6obcSIX9NhGNkx4K6Ky8um32tyikZKI+MjJudRs
 EvsorG0KUk7xezLgYbwWnIFGokUXttS/h89njIuMkTA/GJEeK/QXfz4rj0stoWK81O2X
 sIOQ==
X-Gm-Message-State: AOJu0YzWwuCrzkGyEB0wXabv0LO/k6dLcaSTyb4Cz/MVqIY1c6GGkEYH
 QFzimauvtI/FQYjo/bmf0MNSrTMo5aOm+AoZGSbR3lliKvkzziMsdmCyHDchwFJbhSqYNvjkBd4
 U
X-Gm-Gg: ASbGnct0HkZPouIwZqZD3o0hfDxQUi4cWiVbxVPQxVfHk+7+9QkcxXOS9uqm2ZmolYC
 TKXXGU7oPcgQxNihlpZ+ID2JRZkWuUGKH0g7poQsvKeTij0kB1NFpH9uYdeEljUtQZ/i5wnL9qA
 NbOTr/eXY6xtncl6x2Uiim9pmLpr7p/p9Q86Ywze2BMpH/mvX443suz8oCY2C+LeL0HbsOSoAWo
 f82EDDFiKz3qQuMo87HpMFOU9rRy/1ljRYhMu646lI3ZgN05tueHjKmos7Y2z/DW1dqPelaMKZ4
 6rjgrUJCB9wu6Mvy0Tkx7Ky5cakb4rV8FjDGTtB+KEoiadfZgyHz8ZM=
X-Google-Smtp-Source: AGHT+IGQbkyyawmd0b9p/BSe0dd3Sn8zvfnqaJM47USsc8gTiC5G/soDCTYFtaG7CMa6ghx4DVqogQ==
X-Received: by 2002:a17:902:d512:b0:215:a60d:bcc9 with SMTP id
 d9443c01a7336-21f4e6a113bmr188975675ad.2.1739216079650; 
 Mon, 10 Feb 2025 11:34:39 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d59asm82464075ad.132.2025.02.10.11.34.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:34:39 -0800 (PST)
Message-ID: <d8abfef6-36cd-47a4-b05b-e5d3d504683a@linaro.org>
Date: Mon, 10 Feb 2025 11:34:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] target/arm: Remove CP_ACCESS_TRAP handling
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-13-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> There are no longer any uses of CP_ACCESS_TRAP in access functions,
> because we have converted them all to use either CP_ACCESS_TRAP_EL1
> or CP_ACCESS_TRAP_UNCATEGORIZED, as appropriate. Remove the handling
> of bare CP_ACCESS_TRAP from the access_check_cp_reg() helper, so that
> it now asserts if an access function returns it.

Wording from an in-development patch? How can an access function return CP_ACCESS_TRAP 
when it has been removed?

That said, the code is correct.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

