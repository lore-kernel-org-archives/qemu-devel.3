Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54A8C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 19:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU9TM-0001vd-11; Tue, 24 Jun 2025 15:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU9TK-0001vB-G9
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:38:22 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uU9TI-0005rR-MN
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 15:38:22 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-747abb3cd0bso121650b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 12:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750793899; x=1751398699; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZgxDcSG3Q0RrAc5rHHyxfLjMeZMDX/JwP6cyXLNAA24=;
 b=ATve3VlRtm1GNKeaxXHa/ucbH/H9x0my8DZ/l3DMeOysvKUaYIEoxCkG9VRUjZRz8l
 9b/eJcqkdoNmhSlaSnN4RB7FlUu98hZt9JOyGkwBKZuQDwvQ0TZevyR6wAUURTGZ+psk
 gXgnWeFpQ2h9I9RTK+fvAPI/+Iq3uBFn2U1wS32RK3Pw9uFM1uA7t3NvROZ26WfQkojm
 YT4x2ig5mqj0PrIp7vVjqPGIIOIELZQEGflM9rE99vv1xW3bq/XuSLEjbfHLrlc4jEKa
 Uq+M7qvKv9bJpPuUKQ6UDGiEV0hzBzHJKiCpzXqzwUPXj4agU1d0QZeKI03d7Z5fElz2
 QMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750793899; x=1751398699;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZgxDcSG3Q0RrAc5rHHyxfLjMeZMDX/JwP6cyXLNAA24=;
 b=RRdG6MUx/zUtfq0JBi1qVAKkR8sZO/5FI9oCDIn3qg+0SXuW4sErJ5kaRsDpX5qUlV
 D1HFriXcY2s2drAbcsxHeFlL1ijHudoQQSHVxE8m4VTZJkbUumEtJXFNKi2a5o2NOkhj
 1ujS39XPg9eX0fHJqu7p1LoI8eiWYy091kl784TI1RF9CGtsWTX/Q7U0Z8QvZJaJj2+f
 xx6Ahw09UbsMSJELg7hNNiKYYNxpJd18yqIRe/lCIaA/kYZWY7Z6Kz1e/gkt4TrkTgh8
 2U4Ntsmecffwz4MkQdCdpFDINMim7SwWPDUtmlPlLvqDacJKpARi8/4XKgaL2vat5vc2
 jIOQ==
X-Gm-Message-State: AOJu0Ywd3HusRADcCstPG6XAAquXDl3lO+oKxrgbrTE1jmOng05MQYJz
 PpTCDicvAUjkxiB0JY2G0wo3XCdJR5YCxPIPTYCA4HdQCFebSyQ8hbP2e/M9YylpbAw=
X-Gm-Gg: ASbGnctfEKUhEm7WMxH2Qh63IfzVaFs68mmlU50W9GwOMEQaHBtEHTVbqxB7QTSMXI/
 t9wtUh/saARlvz9k88iJnXZHi3YNyg7iy3T61vxdtFdI25kM2Vi+WsgR3JzIkBNE3b3eOsEATMF
 PjSB1WHv1o/fVy9ucD0wxuhZgbpjAuW6Y7SoPbMuPG/dqGp4kMnZsGASufnsNN3WTA5KTP0GW1b
 x0GFc6nGNk+V9Bfd8V1MNi22KqAFXjXoF6+1nxSaOt6pXdHc3WuFT1vMiNVSJfvjFtMLCo4E9Jd
 BMrDfPLbg1vi0z3SAtpf6rAk5l/GbpvPlv0B7voXWfSQyolFaYw1Ywj6yk06ih8TqehTrXgUK1w
 d1teEkOTP70bm8sd8hgIVzCbcliBg
X-Google-Smtp-Source: AGHT+IHTCj/4xiiLX84InuuVtk6rmzdMXrITpK7YjPuNFkqyQ+4FRN/7cr7Ya0a+DJJlfYG9u/Eo3Q==
X-Received: by 2002:a05:6a20:1582:b0:1f3:3547:f21b with SMTP id
 adf61e73a8af0-2207f20b186mr316698637.5.1750793898764; 
 Tue, 24 Jun 2025 12:38:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c882f594sm2553714b3a.98.2025.06.24.12.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 12:38:18 -0700 (PDT)
Message-ID: <692638ee-0bef-4e6c-b8d3-1bef6d341094@linaro.org>
Date: Tue, 24 Jun 2025 12:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 091/101] target/arm: Implement SME2 counted predicate
 register load/store
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-92-richard.henderson@linaro.org>
 <CAFEAcA95y+y_uXM0mhRY3VqHtV8Uagd38pBDmvrWO6WrBgf0ag@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA95y+y_uXM0mhRY3VqHtV8Uagd38pBDmvrWO6WrBgf0ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/24/25 07:21, Peter Maydell wrote:
>> +TRANS_FEAT(LD1_zcrr, aa64_sme2_or_sve2p1, gen_ldst_zcrr_c, a, false, false)
>> +TRANS_FEAT(LD1_zcri, aa64_sme2_or_sve2p1, gen_ldst_zcri_c, a, false, false)
>> +TRANS_FEAT(ST1_zcrr, aa64_sme2_or_sve2p1, gen_ldst_zcrr_c, a, true, false)
>> +TRANS_FEAT(ST1_zcri, aa64_sme2_or_sve2p1, gen_ldst_zcri_c, a, true, false)
>> +
>> +TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
>> +TRANS_FEAT(LD1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, false, true)
>> +TRANS_FEAT(ST1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, true, true)
>> +TRANS_FEAT(ST1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, true, true)
> 
> These seem to be missing the
> 
>    if IsFeatureImplemented(FEAT_SVE2p1) then CheckSVEEnabled(); else
> CheckStreamingSVEEnabled();
> 
> SVE-enabled checks that the pseudocode has?

Fixed, thanks.


r~

