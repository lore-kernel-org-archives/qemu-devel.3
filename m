Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F56CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 04:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYGEY-00007S-6O; Sat, 13 Jun 2026 00:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wYGEW-00006t-3X
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 00:44:36 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1wYGEU-0004MP-Au
 for qemu-devel@nongnu.org; Sat, 13 Jun 2026 00:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1781325871;
 bh=yeY/Z5Hf0K7qrNmXTbL3WvAycSf4j9vidKHEOgSHOfk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=kSojg68R1aXk/JnW5TJS+yyr5uVYAwsMKQQck3rBsx3V6sINf7WWuHp6sO2VZ0sRc
 jOZ+YQwdxuJzW7BySUgVd/qNK+7ilmfL8714g2X7hdQuMcXAHu6XZ8sTxDkawNcBMG
 VYiI1pZwyt9Xv6vXj8+Ge2uOaFlXlhUaluiJxAoba3sVgByaGGsWBQ7DgmaBfmLwI+
 Stt/QxFTsznhnOSHZMEt0gHkU37dk0I/ZAWYWwZLOT68PZLD5/7V7ghC4XbEqUvSZR
 PfqkPxJa01zERgclqZvjBsBq9m65A8K8w7R0YGbV2lHLeH0kuY6VxV9yGum1L5jxVO
 vXXDqDOLKwd3w==
Received: from mailhub-1.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 507E040295;
 Sat, 13 Jun 2026 06:44:31 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub-1.u-ga.fr (Postfix) with ESMTP id 4CD1AFF852;
 Sat, 13 Jun 2026 06:44:31 +0200 (CEST)
Received: from [192.168.0.190] (226.168.185.81.rev.sfr.net [81.185.168.226])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id CCF29400F3;
 Sat, 13 Jun 2026 06:44:30 +0200 (CEST)
Message-ID: <6b252347-3ee3-40bf-b071-0b28a3c1146d@univ-grenoble-alpes.fr>
Date: Sat, 13 Jun 2026 06:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] include/qemu/bswap.h: Add support for Int128 byte
 swaps
To: Richard Henderson <richard.henderson@linaro.org>, philmd@mailo.com,
 pierrick.bouvier@oss.qualcomm.com, mst@redhat.com, qemu-devel@nongnu.org
References: <20260612180346.890429-1-frederic.petrot@univ-grenoble-alpes.fr>
 <7e681b2e-48fb-48c3-b143-cb9c15c76747@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <7e681b2e-48fb-48c3-b143-cb9c15c76747@linaro.org>
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

On 6/12/26 20:27, Richard Henderson wrote:
> On 6/12/26 11:03, Frédéric Pétrot wrote:
>> The recent introduction of endianness support is providing
>> a clean framework for the standard integer data types.
>> This patch adds support for the non-standard Int128 type QEMU provides.
>> Note that the ldn and sdn functions still keep an uint64_t as argument
>> and return value to avoid performance overhead.
>>
>> Signed-off-by: Frédéric Pétrot<frederic.petrot@univ-grenoble-alpes.fr>
>> ---
>>   include/qemu/bswap.h | 63 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 59 insertions(+), 4 deletions(-)
> 
> Who is going to use this?  I won't add this for no reason...

   It is probably a bit artificial but the idea is to use that in
   gdb_get_reg128. It currently uses two uint64_t arguments, while
   the Int128 seems meant for that.

   Frédéric

> 
> 
> r~
> 
> 
> 

