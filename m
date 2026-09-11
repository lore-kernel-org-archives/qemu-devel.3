Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC18CC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yqz-0001lK-9G; Fri, 11 Sep 2026 06:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4yqw-0001k9-KJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:51:30 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4yqs-0001O6-QA
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:51:30 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so745720a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789123885; x=1789728685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yeYwL6Yng/g4bmLIbyzt+iRDyW61rZSKyC+iiBoG0tk=;
 b=a8OeaGo9TjgkcLW/FL+IaqFMg2nyX3dmYpQO1aIwn2Bc/v434lKcRU3vFwsgf0p4p6
 iuyhvpXfficDnyoK2u31mJ8GCNtmqolHZskG+YCiRwdvdkcTBNqk1WrjIl25rBP8jaOs
 9SGahpMr4Z6VT3AyeBaUYHbEg707NWPVn1gh3z1div00LF5Mil8Y+1As7XuUR0BGDILX
 Uis4ABWO81w6gq1AuGyJWWx1LLQ4BryVOi9QUwJidFi3Ctlv6R8HpL4FX0KEqq6xnm74
 38c1Mm9fruCWIapkIZnLZ+qokghPazXcmKPLvK9wxRPykdM96xoYAWLL3rrZWIhzH6I4
 L0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789123885; x=1789728685;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yeYwL6Yng/g4bmLIbyzt+iRDyW61rZSKyC+iiBoG0tk=;
 b=qX47Zf9FHlxG0miCCWbDnfqN0V0ouuod0nECsLYl+e5PkLjG7gRVB7sZmj86IWDWpZ
 OsUHYZjPDbXRipiISNnnB4ngoAkreRw8XoODNNiaPWooF/meTv8CTcM1eWhcqj4oGpou
 ZlMUbDE7CwkAWSuGPafes/M3HKDQhbv4IIS75Snvs50D2gT7AqZ6gEWsmWIM4A/Upzdc
 qN0RNm5g1Exj/UU9lSerIuW9qnobA6n/QOcYsG3J/MWXXX3Z2Gt818fBCSulAm2IkH2j
 ndPcQWeXgTykeBRQiDzKI/KWVgRaTNn+zTyztBvM8iw83YiB3Kj9HYIPMmVyP7WpxBB2
 2ckg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaEWO68N7IgXMGY7MJVvbyovDfib9t38LcEgqAhKkoRSxGkyDn+C6h/1du5T016k19xvsV/lEsMy3n@nongnu.org
X-Gm-Message-State: AFuF++n/XqUcossm/pas7A3qhN32XmgFdUTJXpKFoQvvHVb1V40B21W7
 nyJybcmJT5hKgzi4Zs+RpCr42inKG6qQoXj3Q2rX+1T5TB9rHdkwU3NYYJVxmhIz8MM=
X-Gm-Gg: AYBFou2UqxAnFWruDq8rSmZeteiFV2VwiZdYHxBUvuOddBoMVbnTOPuM2kpTOW+WD53
 MQAAE4Vb7jRCeT65eKgBWeMpeqSnH5XUsi4iDK+XDkN9k4UdfMXRSsfgI8Fxt21W0hlka2ByKBj
 pPVsp7LaNeLilQcPHAh56JiIAuzv0p72kvTAk+kRqJ74N214iKmcTq3QuIZX2FQMx1fHCezKrtc
 8ddyXQS4BX+xBLJtZOIe+nmUcgcsEEOyXMmqGSY4ZRih9NzIzuR3vXRq6jp1gf4OdgxkATWBl2v
 lnnj4SgK4gvsO6rXAdhdiOQxDnpFBhH7cOfBQJ5zIYeGYXy1p8rdaBT8kuAPM3GoSadfPL3LMGO
 MAX+KvfD37Q3ueq/JN/Zwbil4kKZcb4/MLYHuZqcwpkavq9/Fyb6GoQ5OoK/0x1NstAMcz4UzdW
 iOTxAM5zQa+u89E0pIw2GJenWeyW78vmekOrv1a2He9lxq72Xp7z2Xq6vUv9LFd3GD2/zyonvx5
 xHvqfvAqGNpxTmPV926qgHldCatNl+wJLwLbHAmaon8P/HBvgi2AVyx6yk=
X-Received: by 2002:a17:90b:3dcd:b0:399:ea1:5a82 with SMTP id
 98e67ed59e1d1-39d9bc66ab9mr6503365a91.3.1789123884999; 
 Fri, 11 Sep 2026 03:51:24 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:20b:7d3e:6a30:1f63?
 ([2603:800c:7900:ed00:20b:7d3e:6a30:1f63])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4cf31c1sm5747284eec.1.2026.09.11.03.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 03:51:24 -0700 (PDT)
Message-ID: <5ef36fa1-3b60-4534-a346-ba2c9b089655@linaro.org>
Date: Fri, 11 Sep 2026 00:51:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Qtest patches for 2026-09-10
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20260910202559.916866-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260910202559.916866-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/10/26 10:25, Fabiano Rosas wrote:
> The following changes since commit 257bf4f160c50ca8c4ebd603f519f5c786013fb7:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-09-10 11:08:04 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/farosas/qemu.git tags/qtest-20260910-pull-request
> 
> for you to fetch changes up to bc4f7b451e1f38578427e5df186aa1327d739ee2:
> 
>    tests/qtest/ahci: fix a racy deadlock in the engine stop test (2026-09-10 17:22:02 -0300)
> 
> ----------------------------------------------------------------
> QTest pull request
> 
> - Improvements to fdc-test execution ordering
> - Fix to a deadlock in ahci-test under host load
> - Leak fixes to migration and IDE

Applied, thanks.

r~

