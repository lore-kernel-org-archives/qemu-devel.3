Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB8FD149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mqi-0007gV-E2; Fri, 25 Oct 2024 12:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t4Mq2-0007Pg-P9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:07:01 -0400
Received: from shrimp.cherry.relay.mailchannels.net ([23.83.223.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1t4Mq0-0005Ix-AE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:06:58 -0400
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A7CFCC3040;
 Fri, 25 Oct 2024 16:06:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a233.dreamhost.com
 (trex-8.trex.outbound.svc.cluster.local [100.103.220.31])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4B84BC40E0;
 Fri, 25 Oct 2024 16:06:51 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729872411; a=rsa-sha256;
 cv=none;
 b=V7qwKwXGfjoPOO1W8tPd0azPcY8dPZfet73LEYV6T+X8RyvqJP0sSqMlMfyExrkXxSEAG6
 m3qa6S2y5adghKgfzPBHsFTmudP/6zJxjFPxWLHpJSfQiL0AxJwNVlYakZncMG4NysqfJt
 Ved/UHfCY+n7SwIXc2O8VxeFzBj8MWt0uCbjEixrrkKLmFxGiw6x0DrxjLF4BcaSvDu5ev
 ge6MWg0Rkc7s7N4rD8p5AbGJhhUli0Loskp9P50xfROk222yp8lLb4basuMdxFnPcClypM
 crCIx/0K/dYgs9wX3BGCcho7z25FhgG1Xy54P9U1s2h8M8OkK0taOJ1piolXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1729872411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=aEzrN/Nw6UKLvVJs00tshw8NLr2g+/kwairU/76Ypcg=;
 b=21IyleDMZiW8+Gs6qGMxCBbMKun0sK4lU1EP80GQidQhOYp6DhQAv3Y+6axhD/cwCUidnd
 WahPOsm4ulX6UPMTom+G/CBuntWFWgCnP9FKESBFxYKui1chROKThlpYN9Ah3vbn9sPaul
 DLNLHwE6eizB1guwML5QPI7LYyjNM4yk+FRT/rv2S2rEKfs5nzbV4oFuOr7B0af+5Y/4LW
 cwAJWTNOqPW4baHKENfrBhCzYJOB48GYDu5KUBuV94SMauyhxDRTfdLb44KQDR6mo7JsIb
 KQSKu+M2ThV8ZIz4qfLsN5LYEeQBuMgB/zmY2B1Yf61HPO1U5j/yyfyLTe0n2A==
ARC-Authentication-Results: i=1; rspamd-78ff97654b-h696w;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Exultant: 1318d7c20fe6e2df_1729872411543_3769676576
X-MC-Loop-Signature: 1729872411543:3829036414
X-MC-Ingress-Time: 1729872411543
Received: from pdx1-sub0-mail-a233.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.103.220.31 (trex/7.0.2); Fri, 25 Oct 2024 16:06:51 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a233.dreamhost.com (Postfix) with ESMTPSA id 4XZnj64zWpz4g; 
 Fri, 25 Oct 2024 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1729872411;
 bh=aEzrN/Nw6UKLvVJs00tshw8NLr2g+/kwairU/76Ypcg=;
 h=Date:Subject:To:From:Content-Type:Content-Transfer-Encoding;
 b=FIlmumQrfhxA8Ytr/nYF8iyaK7vqXyw/GliHCZJ2/8Ssumllj6eJcoD1s8OZfBBQT
 vqzOxbu7jQdtsJJ8rG8JNpeV2jDmJwKTeviIulereIO9KNVmtFsFZKGKVi33pavLJZ
 NmIYNWoDdaduVNCXzGVltgnGEk4w+ZBzYgJ8pYf0WTAB019ZU9Qzd4jMolCH4/YDks
 VMWJGcAjtBf5vmtsV2JKZMFVFksNttHkCgEu2nKHEakj8Sx8495S8vOLr9035azdnx
 zmCGxQMl3b3tN8bSdsNxdFixdXUjvzoWbnusgcrs29mWz2XxeBBVduzepDJBxcptC9
 ssaChh/0vtklw==
Message-ID: <e424cf07-2c58-460a-8622-dc79c1e5ba30@landley.net>
Date: Fri, 25 Oct 2024 11:06:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please put qemu-system-sh4eb back.
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, jeff@coresemi.io,
 peter.maydell@linaro.org, glaubitz@physik.fu-berlin.de
References: <d6755445-1060-48a8-82b6-2f392c21f9b9@landley.net>
 <9f8b2357-a28a-4b80-aa5c-ff1725e364d9@redhat.com>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <9f8b2357-a28a-4b80-aa5c-ff1725e364d9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.223.164; envelope-from=rob@landley.net;
 helo=shrimp.cherry.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/24 00:44, Thomas Huth wrote:
> On 24/10/2024 02.11, Rob Landley wrote:
>> I use it, and ship system images for it:
>>
>>    https://landley.net/bin/mkroot/latest/sh4eb.tgz
> 
> Oh, that's interesting, I've been told that the r2d machine does not 
> work in big endian mode:
> 
>   https://lore.kernel.org/qemu-devel/87a5fwjjew.wl-ysato@users.sourceforge.jp/

Possibly they were referring to:

https://landley.net/notes-2023.html#16-06-2023

Less-used platforms get regressions and then get fixed again. The reason 
I rebuilt qemu and noticed sh4eb's removal was I was checking if commit 
3c5f86a22686 was still a problem before reporting it, but I see 
68ad89b75ad2 already reverted it... :)

> But yes, your binaries apparently work there, so sorry for the confusion.
> I'll send a patch to revert the removal.

Thank you. (The j-core SOCs are all big endian.)

Rob

