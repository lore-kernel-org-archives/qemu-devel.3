Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E05C9830E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBnTL-0006kH-SL; Wed, 30 Sep 2026 02:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBnTG-0006k4-Sg
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:07:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xBnTD-0007gw-U2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:07:14 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68U66ekv031467
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Sep 2026 15:06:40 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=n9EeWckRL6yPnCWqL87B4Q1rmpcgOtCGb/fby8DSgj8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790748400; v=1;
 b=j73ywqLT8s/YmoQn0zzGbEv7x09ZC9LsM1gOGFeZHjFx4B6Q8bzgO2ZP3KnTT7Ix
 NLE+4RHKixyhT+6b/6x/g23+I6jI+PSHvfZ2kM1ldU/hgZJxHPsuQqPadwibiHOf
 QdCbSQ9XvCjfTkeXisnDZ85izIb8mC38wUlj9V0/cOyyOskrmFAGv3YZJp1UvC4d
 Jk/JsMb8q3h2FCAK52IOGa+XmWw/Ugu/GbvFy8kkK3xXIZkKSkVwdymHbxsQajiY
 JLNbkeqA6mSXsdRg+egMPdJKcnHR/PGilDbyzgpQh34sCInpLIK3RkzuAjKlbpkh
 lXzJZcVCbmBAJhhvwBNg4Q==
Message-ID: <f8554a62-4be5-4ea4-8697-3b0c69f64849@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 30 Sep 2026 15:06:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/17] migration: forbid snapshots under Xen
To: Peter Xu <peterx@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org, 
 mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 clg@redhat.com, den@openvz.org, mark.kanda@oracle.com,
 vsementsov@yandex-team.ru, farosas@suse.de, sgarzare@redhat.com,
 bchaney@akamai.com, dongli.zhang@oracle.com, Paul Durrant <paul@xen.org>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
 <20260929-up-vsock-vhost-v5-v8-4-12bcf1c0b84a@virtuozzo.com>
 <arwCADGhCZenoYke@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <b7d2302dfa4b48480e45423ffaceb93ce2239e7b.camel@infradead.org>
 <arwOl9OvOlXJTtwS@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <arwQBnGBbCgv8srv@zhexu-thinkpadt14gen5.rmtcaon.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <arwQBnGBbCgv8srv@zhexu-thinkpadt14gen5.rmtcaon.csb>
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

On 2026/09/30 4:22, Peter Xu wrote:
> On Tue, Sep 29, 2026 at 03:16:39PM -0400, Peter Xu wrote:
>> On Tue, Sep 29, 2026 at 07:34:50PM +0100, David Woodhouse wrote:
>>> On Tue, 2026-09-29 at 14:22 -0400, Peter Xu wrote:
>>>> On Tue, Sep 29, 2026 at 08:23:23PM +0300, Andrey Drobyshev wrote:
>>>>> The snapshot RAM-saving path does not support Xen's memory mappings.
>>>>> Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
>>>>> same way they are refused for CPR migration modes.
>>>>>
>>>>> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>>
>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>
>>>> Cc: David Woodhouse <dwmw2@infradead.org>
>>>> Cc: Paul Durrant <paul@xen.org>
>>>
>>> Hm, but surely if QEMU is running as a device model for a Xen domain,
>>> all it should be saving and restoring is that device model. It's then
>>> up to Xen and its toolstack to migrate the domain and its memory.
>>>
>>> We've had guest-transparent live migration working on Xen, as well as
>>> in-place update of QEMU on the same host. Surely all of those require
>>> save/load support?
>>
>> Looks like I was wise copying more people..
>>
>> I knew Xen had qmp_xen_save_devices_state(), I was thinking that is the
>> save support wiring together with Xen's facilities.
>>
>> I confess I never know what is the load support, and I was taking it for
>> granted RAM was managed elsewhere, so load perhaps the same.
>>
>> So I suppose this is still a question to the author, or maybe Akihiko?
> 
> Ok, I just noticed xen also has @xen-load-devices-state, so maybe this is
> the answer. I suppose Xen should be using those, rather than the default
> savevm/loadvm.
> 
> Note, that what this patch changes (migrate_can_snapshot()) only affects
> savevm/loadvm command.
That aligns with my understanding as well, so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

