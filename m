Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1471AC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAfN-000591-MW; Wed, 26 Aug 2026 06:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzAfL-00057w-7O; Wed, 26 Aug 2026 06:15:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wzAfI-0007uW-OB; Wed, 26 Aug 2026 06:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787739316; bh=DPe1Ldwgu4kxpfI6VvSkRL1QOL4Rh8NWxDkTp/WDd0c=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=PmhBtAOqmUqEBij5QeZNEZ+b0azexo8GoXDzND7geIhjwsbUKjKPHNiaECp8sYRE1
 kaPEh/ifa5u6R0AUWLk8hFIVr+9Y2D/WDbmmfPqX/07/z5u/hcdh0hw8wnDZYjwcMt
 hLLpDA0gFIFnmQhNO/5GLqFl+A+u5LZmEaBBuwOQtueWruM1h6DU4wFo3+7C04DTdK
 x2kU0zFKVOgmEqE2MsCS5KMIUSZJ3j37b7XfhPwUd5i83E9J+59c2pZQE81fxzH/vf
 SBc9VgYLpfLLgeLMSeVYs1oYND8Q8uS61palFPGR9e1ufTQ64O3og2GbL3K1gb3wrx
 d2zX41zcn9w6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB33B1CEB22;
 Wed, 26 Aug 2026 13:15:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 67154418308;
 Wed, 26 Aug 2026 13:15:17 +0300 (MSK)
Message-ID: <73e4dbf1-9b9b-44a3-8032-9fc443028bb5@tls.msk.ru>
Date: Wed, 26 Aug 2026 13:14:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
From: Michael Tokarev <mjt@tls.msk.ru>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>
References: <20260728153849.601939-1-den@openvz.org>
 <52e606b3-507b-4869-bf29-97437d4ff84f@tls.msk.ru>
Content-Language: en-US, ru-RU
In-Reply-To: <52e606b3-507b-4869-bf29-97437d4ff84f@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/30/26 09:32, Michael Tokarev wrote:
> On 7/28/26 18:38, Denis V. Lunev wrote:
[..]
>> Denis V. Lunev (9):
>>    parallels: fix integer overflow in header size calculation
>>    parallels: read header/BAT table in bounded chunks
>>    parallels: fix bat_entries overflow in image creation
>>    parallels: reject BAT entries pointing outside backed storage
>>    parallels: validate bitmap L1 table size before allocating it
>>    parallels: skip loading a genuinely empty bitmap L1 table
>>    parallels: avoid fatal abort on large bitmap L1 table
>>    parallels: validate BAT capacity against advertised disk size
>>    MAINTAINERS: update parallels tree location
> 
> Hi Denis!
> 
> This is a bugfix pull request.  Is it worth to pick it up for
> the stable series, or is parallels not used much outside of
> openvz (which sure uses locally patched qemu)?

Ping?  Denis, what's the status/usage of this driver
outside of openvz?

I don't think these are very difficult questions :)

Thanks,

/mjt

