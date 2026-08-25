Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0736FC61CE2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyoSb-000689-RI; Tue, 25 Aug 2026 06:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyoSZ-00067t-TD; Tue, 25 Aug 2026 06:32:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyoSY-00083o-28; Tue, 25 Aug 2026 06:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787653930; bh=UoZWT0dYAzmoUg8EOQb6SUrrHuND5b9YWJab98fdYpY=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=hAJCWMDJlFzOEJMUfDBX0f5mBZLtpPWMrWRrb0c6PdPEY//F05JRe5wc5fgfTMj1o
 LCsRBkg7tPkY1/QHfvFXtylNtUtEFkWGLvMDbwZmDqiOIiJLxRXojkJQM0UgRJ2DHB
 xBz7UE/hxX3CB2NYmwQO2U2b6Ae6P14kntr6NNAiBu9BS7I2NdTbbPU7uAV3hEM8BJ
 utvGZusbNY99kKx+nvB0FIrADzsjE1+AuxD32unvbhbs/0ONTQk9QY27be1GdPc/LD
 0X1A1eQcjC20zs65QCZvgWSHKcKRUMzbvF0mzlOxk5vqLTyiUsi5x3Sh7+trHECTXj
 GsHBir1xb4TbA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 469EC1CE45B;
 Tue, 25 Aug 2026 13:32:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 34E85416222;
 Tue, 25 Aug 2026 13:32:47 +0300 (MSK)
Message-ID: <2211581e-9103-4b56-b559-e8de7ba242dd@tls.msk.ru>
Date: Tue, 25 Aug 2026 13:32:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/43] target/arm: Fix SVE2 WHILEWR/WHILERW zero diff
 boundary case
From: Michael Tokarev <mjt@tls.msk.ru>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
 <20260821110101.3971391-14-peter.maydell@linaro.org>
 <fd8ab02f-d134-4241-ae40-1ae32007a9e1@tls.msk.ru>
 <fb9606c6-b629-442c-a482-4ebb54dd232f@tls.msk.ru>
Content-Language: en-US, ru-RU
In-Reply-To: <fb9606c6-b629-442c-a482-4ebb54dd232f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 8/25/26 13:29, Michael Tokarev wrote:
...
> So, this testcase fails on 10.0.x, here: https://gitlab.com/qemu-project/qemu/-/jobs/16088801753
> sve-while-ptr: /home/gitlab-runner/builds/bCHvkPZE-/0/qemu-project/qemu/tests/tcg/aarch64/sve-while-ptr.c:19: main: Assertion `p == 0x1111' failed.
> 
> It seems this only happens on ubuntu-24.04-aarch64-all-linux-static job,
> which is kinda unexpected.

It also happens on linux-user test:
https://gitlab.com/qemu-project/qemu/-/jobs/16089624588



