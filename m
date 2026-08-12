Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9249DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuEUR-0002aQ-58; Wed, 12 Aug 2026 15:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuEUP-0002ZG-Sp
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:19:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuEUO-0005at-Bv
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 15:19:49 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2d004f135b1so20185905ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786562387; x=1787167187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ehvAXe7x7L5kcboD1700O5NrmDLTAFVRc74cjLN/zOs=;
 b=mbD3icrzOykUqqjsL/V6kgaq/8qLeleGwyiLTgjHHg8i/iW6INd4JFRDDcs9WuGd0K
 u5LUVbAKJA8NFfJT4vwsbMSZozSp1T6yVgUuC0ZAUbKdZgv6F18YFFNprfXDkJx7jJbW
 OAX4dO9SZpawA6tDmWyLaouz0OTiAF6wsOJBJ8JSoLSJGzNBGA0kKlMpNSAxIhyZIUET
 OS2x4imWFFd1zwKVLjIqEy/fyu0q54hFKucbCa/Bql62qWeDVS2zXKq8lIMjoMM7ZBS4
 I5smM6yn5m/PgtRigr2CWH/N5ThJ2nGEVoPnZcykDuGpWmdgkN06t7K5xKiMuSUXzq+P
 QNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786562387; x=1787167187;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ehvAXe7x7L5kcboD1700O5NrmDLTAFVRc74cjLN/zOs=;
 b=lkqCPDAS6rKYt/dZWMDZbEvJ+CM4UF3xM0cuVN0DiyPhwXjRHLWQRfx7OFIn6Yz2CI
 uMlDSMOjqG/29s66ZrHA5LANYGCajY7seJJOcilxlvSQtqUz7Trayhy9yZn2wal3Rk3j
 uwOavNWovwHpnngGlAqAmqzs8pFUW6u9spboPKWbKUn9h8i14iM8KRS2IJLTfu3AMN16
 bLlbuq/Y4E5a43HHctRyN6CDJ6loOQbCgmkOcdrfl1iiBJeYXQbsIuDiDmVjUPO/IjFl
 3a7GeopFCADoMGdF2jY1oIGCqVfy1Wf95+c6ixS5l8eVuSB6gJRqFKm7ip/VUKmc7JUt
 fxTw==
X-Gm-Message-State: AOJu0YyjMeEPw3zALUipG3Zj2oyrwyLjGUnkji3JVob8iTeRZ5wSCwIW
 Ko//80QUhAPc9sy3cmnl3KM6cbylTKb6Iuag+nfnNtbX6h+vkyrqaTGnwBgW5PkdQNdarhy20EG
 ldsuH
X-Gm-Gg: AR+sD130OAiba48z9LNDCsMmth4pkHmnh4UlBkEUQczqb+PIObZYL99HskUGJNFYybo
 D26Hs77OowWRdVzMgI6lqphGap2uA+AZn3SifxG/v82oRPjuIeyf3YuBC777SLt2jYJqQdxapQo
 jYEAuSQAixL/RGgaWueDJPv9deKxcVB66fe2LamOa7zHYrvWMO5nJhYgsFAjNmOEQZ4Db3EybJb
 vhMZcZESRQmq1/HVPWxkKWSa9IMlRSo3/XE7skFIAAutFnr4kBYISkvgYm1cxBxwjVlFWDtXDdo
 9C7h02V+CYz5YMqKAZCdIFRcHEEyvSIpyfCoDcgK1NH8cdSMRiDArv0OMahMLhj05Wc/x6YKYdu
 XNZ3elm2RBk0h3uozBbgfPAGBgyBmDAs4JzWAii4gx/SbsX39H0rpT+JlURw4WT2eRBeWLRW0KF
 +0+cAo4HzkIK4XVbiUZtLvGQjNWCQK63Af+5e0e+SCKKq0GH9P2KvaqgIAX/q/O97IkrLT2tjwn
 C3mTMBVhvV3uPH/9yYlaTfLtnrx
X-Received: by 2002:a17:902:cf09:b0:2d3:716e:e2ae with SMTP id
 d9443c01a7336-2d37d57d0aemr3568435ad.6.1786562386604; 
 Wed, 12 Aug 2026 12:19:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d37c49ce11sm844885ad.67.2026.08.12.12.19.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 12:19:46 -0700 (PDT)
Message-ID: <5aa94dc0-9887-499b-9901-3f21646ca342@linaro.org>
Date: Wed, 12 Aug 2026 12:19:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/41] hex queue
To: qemu-devel@nongnu.org
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/12/26 08:41, Brian Cain wrote:
> The following changes since commit e8d693e12af9cbb89d724baadfcc08559669e279:
> 
>    tests/qtest: Do not use versioned pc-q35-5.2 machine anymore (2026-08-11 16:12:34 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20260812v2-1
> 
> for you to fetch changes up to 2e555f5b44d1586517e44d47f73afa6062f48b93:
> 
>    tests/hexagon: add tests for HVX bfloat (2026-08-11 23:45:45 -0700)
> 
> ----------------------------------------------------------------
> Hexagon queue
> 
> v2 fixes build errors introduced while mitigating a checkpatch
> failure.
> 
> Fixes:
> * ssub32_saturate, ssub64_saturate fixes
> 
> Features:
> 
> * l2vic device
> * qtimer device
> * HVX-IEEE instructions (v68+)
> * HVX GVec overrides for v{avg*,absdiff,sadd,*}


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

