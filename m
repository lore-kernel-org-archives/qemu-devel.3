Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B53E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 03:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsufB-0002fy-F1; Wed, 18 Feb 2026 22:25:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsuf8-0002fg-VG
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 22:25:10 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsuf7-0006SV-Ds
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 22:25:10 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82318702afbso383167b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 19:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771471507; x=1772076307; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uiNPZJyr66Sd6j8uFapnK2mUV86r6wkw15Pmi0Z8chM=;
 b=B2+yiP2Q8uVmw5LiWWsN8BqIqH1O+WTIL/yHrUVPzqW7AG+lqQK5fmHAv/jKqGYtaZ
 XNB1hd3neRLyq4fl0ruv0va4oYvjiOK7+6VUmx4QmCWnz3F72Udrb3FpJxoYlj8t1mkR
 ce+SlcBoNIQiMMHQmC7UX4Bf/4XovYkfYvDemB5ispuQNe+M1hNFkIRNwc/McKW9oEAv
 3QvKb8VmiR9sPhiRp3sSqubTtCyisLhhxxb8l6Ho9KupM/ny7zE2yNJxG1P3fIOMD7Wf
 +KfWh3JF9Ywx5DNX0FwcwTMv9Dvw9WLsmOuYcc4WBYLXbuVgFmFyD6O3gQi3SxXtByJT
 ccDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771471507; x=1772076307;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uiNPZJyr66Sd6j8uFapnK2mUV86r6wkw15Pmi0Z8chM=;
 b=gvXwa9h2/gbVpdRFpIL+0gWV5Le9pmMRLxU9dJE7xxqyTUEG97sriAThOnFxpOUWrx
 L89Y0p8vwGnbbBrzVZRCaRfVYk3l/VDQQc1vE1fCpKydWr1sTIQOGm8dFRJKaLQVw9q+
 NNKtpjEvf+9sYZNBhe3QdEYmO4DZ4xcyF9dprNlyq8k61OAQ8oHIjBuqKVGPZDlJqfOM
 RduhrYtS4kRDIEzJgTLpUdbz8Z1AUzaPGHmW2+D50+Hf1LvYL73w5XQu8Oilo8MOtHG/
 IFleW6rRXBiQDFtOl3G6XQNnnWMBB3znPj9cMYicfOkb2hmIDI9hkMENSSDRPvyeVKoX
 /viQ==
X-Gm-Message-State: AOJu0YxiaiiBdK9ac796Fimy6nfN3aCBDPByU/vhP/vwWCn6kJESyyG4
 ng+x3ljboQ/nM45gsJuzd4sdQniO6dCcudz6EWH317xh/QpxMH0nDmq+8qO21UEpI+LNlHMOTQt
 zTXEY/Mk=
X-Gm-Gg: AZuq6aLZhfYFy1p43f3Hn3W/lyIXSAyVb/UUUMzJfsEEAKaTCXope7+pSM7gGZYQcd0
 0xhTTO2l33r+DgTZUcZ/hE/+DujRK/6tpzxAyVYNSIXH4zN+mJsbFHy0KO45mo9rTEvuthEhxo+
 Ah8VaA8Pfm2VIR6ztlzUs/J0S5Xml+a6LsYUVwXKtVMHvH4YLhXwt1dHkgfr6mvP9SWOmmLpTyy
 RltDO2EjaRTC4fTsYKAtd+ze0WqNMYkFVq/8g8nriFNvig4t41EEbs85FDXWEwku2vgozBowMku
 FIXr6uRWkmzo1tVRCDb7GoFrSnjq2FHqUbPSq/yNI33NKnf9G4nb2h5OcW+fG/H9nqhEyfbuOQn
 noZhVsOoUJFsmljOIsYjIfrH3nlu7oTMXpZMzjeE6eE2eoaT+ipwAGTBCG2KoN96YRw2Md2zP2h
 YGA66v+tLl/cDkxsIOPOCgXhWa2dnhlMX7uoaevpme436yHvtg8qXU30KhWpdmgh0jmKw9UheKk
 JjEvJSL0S2L1eH2ICRDE/dr1QlbWXq3Ba4GvNkCxjrsz19Y/NhN+F3lc8/gEtDS+XW8YCM2uFV/
 i2Q=
X-Received: by 2002:a05:6a00:1d88:b0:81f:4566:cce6 with SMTP id
 d2e1a72fcca58-824d951a255mr15240131b3a.28.1771471506746; 
 Wed, 18 Feb 2026 19:25:06 -0800 (PST)
Received: from ?IPV6:2403:580b:742d:0:a224:e0c2:669c:b307?
 (2403-580b-742d-0-a224-e0c2-669c-b307.ip6.aussiebb.net.
 [2403:580b:742d:0:a224:e0c2:669c:b307])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6a62c48sm17792607b3a.29.2026.02.18.19.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 19:25:05 -0800 (PST)
Message-ID: <1cdf04bb-cea4-4e08-9df0-b9f77eefceea@linaro.org>
Date: Thu, 19 Feb 2026 13:25:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] hw/ppc: Set graphic display dimensions generically
To: qemu-devel@nongnu.org
References: <20260216213121.47122-1-philmd@linaro.org>
 <20260216213121.47122-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216213121.47122-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/26 07:31, Philippe Mathieu-Daudé wrote:
> If a dimension is not set, have the machine init code set
> the default values.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/mac_newworld.c   | 9 +++++++++
>   hw/ppc/mac_oldworld.c   | 9 +++++++++
>   hw/ppc/prep.c           | 9 +++++++++
>   hw/ppc/spapr.c          | 9 +++++++++
>   system/globals-target.c | 6 ------
>   5 files changed, 36 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

