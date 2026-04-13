Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7BFF531DB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCPTF-0001Zi-Ju; Mon, 13 Apr 2026 18:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPTD-0001ZZ-V7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:09:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCPTB-00005J-Gs
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 18:09:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ad135063so47331825e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 15:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776118164; x=1776722964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJItwY8PngS/iJBr61aUH13ixYWYfGT0DejHpEoDqno=;
 b=HfaxREI1BBe6mqUozdD8RR2mj8jusHcgbbnRWxkqLMKbbR3qwcziDB+L5WUUtW/ftB
 VUDF6QdDN836609Zzo40WhbN8+RgotBxBmhSGVKT/BVUS9TBnClKtBNgNtQwP7QuTzAG
 xVsF9NPXsAJHmXAqjxuSRSKfUAVz4fPIycNGpwmu/XuJ8rDwS3zaP5MNWvWdcHHoYlhW
 db8goMAW2wSjKlRXVg+T6MCY4S5141FadE2ZOSlSHEZ9cWm3qjomS3DxVa3O3M80367d
 9LkdF7YrpssDtLRZum/g8cqavxGNqACEEfc3DbkZTahIbyAe7FoIs5Lpl8kkMzVC6tEp
 XkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776118164; x=1776722964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJItwY8PngS/iJBr61aUH13ixYWYfGT0DejHpEoDqno=;
 b=rHG7ZFeDs2MCTI8Z0NqBu5IwRVvzJ3gk7+Av+gniZjIz/SQGGGI9eQijvM2NFGWQ0f
 wtIs5hL5sC6S0ZDAKPp0SlDOtccQPqqCTdeNqmNHMT9y/W9QIjAowGoOU7iVmM+/mDkx
 2UW4az6LQwvtYH+1MYOC1ThaVgeRPh6RSN6L9NJyna+2vlV4GUTozKYIqySjY1unIcJM
 DBM/DHRLHxH7cFVkg2ETnoGM7orDJFckeotDdEVgLSly3zuZHBLtYF8TNc4tcfCjkksG
 bf/m/KAT3A8fRTZtz5MND4b7SgLZ3DtoDw7+tKYt8H53qSsJnYXFRisVA6aVmGg5wc1C
 VXxQ==
X-Gm-Message-State: AOJu0Yy8PJgMJzGz/Uf7N3KeNXPIpSYHNTdkDJlYDCyzInJx2YsJXd8a
 IDlQl283VCSMbz2UMNkAGeh7uuKaI85rnbq1QyRV0GfHLGc1W8Ijm+Bpx6Mz4Wk2G18erMDKhjA
 olxakPb4=
X-Gm-Gg: AeBDietEExYZhYORvJU3OEEDGX0OHv1iDlE5O3ODW/KNe73GhHEqDeH1YeZFOSbK3Lh
 cY/ir7qdHyGH/4hLn/tEWqZPY3nUnwjpa9tNwt93JsdEI8Ln56FWfDfJ4v1vZxWXUZoZLl4V0Rb
 ejbP/CRkiIxEEOZcoytibIXG9CVsIiofgefqnKcpq+sArYx9RcbOwJHUDnJWUnOi4jKXSCES3bx
 iIp/OiWc1PSecv9tTFGZHMKCh+rNTvIAnKd/xw3Und6/dihVfKGMD/bM4kYM1tZZWFMTRCsavNo
 6UZmQQkTLCt5MsTaf6kYnNBevK/xRlYIPRfGw8Kqd1I6wZ5kptActDVclcXXhCowamqUPdqi62o
 em46gFnieSbLrhG6olzgVlV/cy4qCgmExRNqoBKRvZnYPjC5t12C+ohjljoI4FLezmxgu/1xnxf
 jImO051j5RUTi6q71bzSvMB4JxfSGjLPYvaiHnQLZTc7TrULXtBIcmk3fINjg7MUVK1Zja9nEJO
 Kp0
X-Received: by 2002:a05:600c:674f:b0:488:a82f:bb9b with SMTP id
 5b1f17b1804b1-488d68cb47amr218256835e9.30.1776118162868; 
 Mon, 13 Apr 2026 15:09:22 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d9fa22sm103224095e9.7.2026.04.13.15.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 15:09:22 -0700 (PDT)
Message-ID: <af54b324-a03f-4251-bcf0-58d457229e0d@linaro.org>
Date: Tue, 14 Apr 2026 00:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0?] target/i386: Mandate monitor 'info lapic' take
 a vCPU ID argument
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260413130748.6631-1-philmd@linaro.org>
 <adztRa80X42EGP4Y@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <adztRa80X42EGP4Y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 13/4/26 15:19, Daniel P. Berrangé wrote:
> On Mon, Apr 13, 2026 at 03:07:48PM +0200, Philippe Mathieu-Daudé wrote:
>> With SMP configurations, using the 'current vCPU' under the
>> monitor isn't recommended, as it changes during runtime. Better
>> to specify which vCPU we want to monitor by its index. Deprecate
>> the default of 'info lapic', mentioning an argument is expected,
>> so we can remove this unpredictable behavior one day.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> The other command with this unpredictable behavior is 'info tlb'
>> which we'll deal with differently, after the v11.0 release.
> 
> Aren't there quite a few more commands that rely on the HMP
> "current" vCPU concept besides these two ?
> 
> info registers  comes to mind,
> 
> There are others whic call mon_get_cpu(), which are not
> directly caring about a specific CPU, eg 'info mem',
> 'memory_dump'
> 
> Why the rush to get lapic deprecated in 11.0 but not the
> otherrs ?

Reading the "Arm OABI and NWFPE" deprecation patch triggered
"oh it is still possible to get deprecation message merged"
and I took that first patch of a bigger branch. Not a smart
move because no rush indeed.

>> ---
>>   docs/about/deprecated.rst | 6 ++++++
>>   target/i386/cpu-apic.c    | 2 ++
>>   hmp-commands-info.hx      | 3 +--
>>   3 files changed, 9 insertions(+), 2 deletions(-)


