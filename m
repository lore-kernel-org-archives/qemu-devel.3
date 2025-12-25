Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDD7E7AD40
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Dec 2025 05:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYdoq-0008Dt-I8; Thu, 25 Dec 2025 00:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYdom-0008Df-38
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 00:23:20 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vYdoj-0004jb-6Y
 for qemu-devel@nongnu.org; Thu, 25 Dec 2025 00:23:19 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BP5MmsR073809
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 25 Dec 2025 14:22:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=dTtdQ0Z4QFQFtLQoZZjjwWAx4ER+P6KWUhJKreKKqLg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1766640169; v=1;
 b=gf9+qJkODZPm5Y9LOmxPRkIFIfLHrzll5tHhiIiZzcSEF7PrrbQDiF/kVlcrrj+A
 ehpPr8A9XxVtFXZBaUt1dRRK8oTixTvASd19W7scalqnzuisZC1VxeneqLiR76AD
 b/FXGAMTp9w1EQyPIp9LtV8PY/B1tRKiRL0kr3tVZgr+6St7II3DSgNg2cxwHx7b
 7umjQrbDDDqhRrp/5wy6sAegl2N6Fw3u7ucuVvafGYk+G8O2SCIWCuj3bhkhIO2I
 WyDAInIe2S+lRUekpM58QpY0MlyejF9Au5aHNV2v+aq44fmH6LEtRa3aLrvFxEsk
 f2+GBmSZuUJZJIMgVTw2yA==
Message-ID: <752be088-91bb-4d51-8dc8-a1147d19ea90@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 25 Dec 2025 14:22:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Implement memory_region_new_* functions
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@linaro.org
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <3a1bf99d-e011-4589-b7e9-662107befdc1@rsg.ci.i.u-tokyo.ac.jp>
 <a9a43db6-1a1f-58f1-39c8-06213e9e610e@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a9a43db6-1a1f-58f1-39c8-06213e9e610e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/24 22:47, BALATON Zoltan wrote:
> On Wed, 24 Dec 2025, Akihiko Odaki wrote:
>> On 2025/12/24 6:49, BALATON Zoltan wrote:
>>> Our documentation says that memory regions are automatically freed
>>> when the owner dies and the reference counting to do this is also
>>> implemented. However this relies on the QOM free funtion that can only
>>> be set by creating objects with object_new but memory API only
>>> provides constructors that call object_initialize which clears the
>>> free function that prevents QOM to manage the memory region lifetime.
>>> Implement corresponding memory_region_new_* functions that do the same
>>> as the memory_region_init_* functions but create the memory region
>>> with object_new so the lifetime can be automatically managed by QOM as
>>> documented.
>>
>> The documentation explains the existing functions so the discrepancy 
>> between them you see should be fixed by updating them, not adding new 
>> ones.
> 
> Do you mean replacing memory_region_init_* with these 
> memory_region_new_* functions? The memory_region_init_* is still useful 
> for embedded memory regions that are managed by some other way which is 
> also mentioned in the documentation as an alternative so I think both of 
> them are useful for different cases. If you mean we need to update docs 
> to refer to memory_region_new instead of memory_region_init at some 
> places then I think you're right, the docs may also need to be updated 
> or clarified.

I'd like to see a correspondence between the stated problem and the 
solution. If the intention is to solve the mismatched documentation and 
implementation, I think there are only two possible options:

1) Update the documentation and/or the implementation.
2) Delete them.

But this patch series does neither of them. Replacing 
memory_region_init_* with memory_region_new_* does solve as it will do 
2) in the process. An alternative solution that implements 1) or 2) is 
necessary if it's not ideal.

Regards,
Akihiko Odaki

