Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595A3CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMtc-000181-9k; Wed, 07 Oct 2026 04:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEHNb-0003di-QQ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEHNU-00009Z-U2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:27:38 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6972Oaim068752
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 11:24:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ar5Zw42vm3kIwbmZJVWl8gEIk5e3AXoMK4M12wC9V7E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791339877; v=1;
 b=eigla2J4Zwl/AxFYPPyCcTg7uTV83gjzZXfAHwYa8awGXULbcWPAyU9LuTgCU/x5
 DXNZhAQeZtCvHcA9w4urOrzHIORkZtaPmxjP4pDrptO7mKVNu5Ejb+T9ttsLN2ul
 72mTjXf8XMl9Sx/plrJ+Mzo4XEpD3VqzgNhXaRecIt3ujmrisLZfnV4t5l5Lz1JT
 zFa9+3Zens7bYivUwe35n+kL3eF0pbLLEg1Pxl1ZS5YSIqmsVqHt17tfUO1oShLS
 miQtrgR+3QywYo4hv0sSDIIXWSlcW9ma038wMCuiOCq3H8m/9Y1Zqnk7jikcTRPV
 qRYIcCRqFuWdt0Ek/WvCkA==
Message-ID: <30912a3c-d401-4d38-82b1-5e3b63fd5e5b@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 7 Oct 2026 11:24:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 16/22] migration: add incoming migration failure
 notifiers
To: Peter Xu <peterx@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, maciej.szmigiero@oracle.com,
 dwmw2@infradead.org, dongli.zhang@oracle.com, bchaney@akamai.com,
 den@openvz.org, farosas@suse.de, clg@redhat.com, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
 <20261006-up-vsock-vhost-v5-v13-16-2ea78fd1b7ed@virtuozzo.com>
 <asUCSERCr0EkHu4j@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <21631cbe-5b7f-42dd-90ae-e2266fba6f4c@virtuozzo.com>
 <asVAZWDo4mAxpke4@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <asVAZWDo4mAxpke4@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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

On 2026/10/07 3:39, Peter Xu wrote:
> On Tue, Oct 06, 2026 at 06:19:29PM +0300, Andrey Drobyshev wrote:
>> On 10/6/26 5:14 PM, Peter Xu wrote:
>>> On Tue, Oct 06, 2026 at 04:58:39PM +0300, Andrey Drobyshev wrote:
>>>> A device may take over a resource from the source in post_load(), e.g.
>>>> vhost-vsock acquires the device ownership on a CPR target.  If the
>>>> incoming migration fails afterwards, there's currently no way for the
>>>> device to give that resource back before the source is told about the
>>>> failure, over the return path or via the MIGRATION event, and resumes,
>>>> or before the target exits.
>>>>
>>>> Add a notifier list for that, called from the failure path of
>>>> process_incoming_migration_co() before the failure is published.
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>
>>> Should we better reuse migration_state_notifiers[] and introduce
>>> MIG_EVENT_INCOMING_FAILED?
>> So far I can't see why this wouldn't work.  Should be functionally
>> identical to what I've done in this and subsequent patches.  So if you
>> think adding a separate event is cleaner - I can certainly go this way.
> 
> Yes I think it's cleaner.
> 
> Not only because I want to reduce possible global list of notifies only to
> be used in migration (we still have another global notifier for postcopy
> that only vhost-user uses..), but also in this case you didn't introduce
> per-mode notifiers, stop matching with what the source notifiers can do.
> 
> When reused, it should then only register it against CPR_TRANSFER|CPR_EXEC,
> IIUC.
The logic in the current series looks sound, and I don't see any gaps. I 
look forward to reviewing the next version with the suggested 
refactoring, and will likely give my Reviewed-by for the entire series then.

Regards,
Akihiko Odaki

