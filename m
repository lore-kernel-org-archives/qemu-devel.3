Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5FBC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMS8-0004XP-RR; Fri, 21 Aug 2026 06:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wxMS7-0004X9-1S; Fri, 21 Aug 2026 06:26:23 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wxMS4-0004nm-EQ; Fri, 21 Aug 2026 06:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1787307976;
 bh=+vEveJQcUCUQELMQyvX23aLVFXPnC3Kpvz1ifRkjwNY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=SzlIWcZp8U2mxsGGYpAw4kEMT1V2jwWvnQiByh8MrTzvACUIr+345BehDW0p9Slfw
 Qk2QXdzQCWdVN5aCNgtf5nb9iwF5p92/RabN4H3zVtPHM0MQWpFeQvlleC/qKYaDJE
 PVqU8XmG38dwDq+29XIIJr8cZm6Dd7dsckLr19a5Leq94K9jdohX4e/vi7Yblgo2kZ
 0boMbRF1DQKF/gR88h7OpJ0MkdClRseaXs46TyztZR/xzQ+FB06izImxwoIvDjbQ4I
 eYcjqWZ5/DGFNt56zoYpYFBlTERUec1OUdCiOaP0jrumg+cZf3HoUqpmNfItWcQNR/
 nCeBMOeeSuomw==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 9C1A54021B;
 Fri, 21 Aug 2026 12:26:16 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 98656FF852;
 Fri, 21 Aug 2026 12:26:16 +0200 (CEST)
Received: from [192.168.223.47] (unknown [78.240.82.247])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id AED28140046;
 Fri, 21 Aug 2026 12:26:14 +0200 (CEST)
Message-ID: <e824ddbd-4586-42b4-9814-59dfb24e924d@univ-grenoble-alpes.fr>
Date: Fri, 21 Aug 2026 12:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/riscv: Handle [ms]status updates for rv128
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com,
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
 <c459a001-57c5-44db-b292-45adb70d26d5@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <c459a001-57c5-44db-b292-45adb70d26d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Phil,

   I'll send a asap patch with the test cases.
   Frédéric

On 8/19/26 13:17, Philippe Mathieu-Daudé wrote:
> Hi Frédéric,
> 
> On 19/8/26 12:56, frederic.petrot@univ-grenoble-alpes.fr wrote:
>> From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
>>
>> Correct sstatus update and allow support for rv128 in mstatus,
>> provided the cpu is an rv128.
>>
>> Changes compared to v1:
>> - add cover letter
>> - add the Reviewed-by tags
>>
>> Frédéric Pétrot (2):
>>    target/riscv: Fix sstatus update in rv128
>>    target/riscv: Allow UXL to be 3 in mstatus on rv128
> 
> How can we test this series?
> 
> 
> 
> 
> 

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


