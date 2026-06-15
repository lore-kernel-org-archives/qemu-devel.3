Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C1BCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 08:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ32E-0006K4-Vb; Mon, 15 Jun 2026 04:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ31n-0006Io-MF; Mon, 15 Jun 2026 04:50:45 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wZ31j-00057b-RM; Mon, 15 Jun 2026 04:50:43 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F8oHsB088520
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 17:50:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=/8VapYLl3ShbkfOj4G7hbG3IsazqXHuxJye2UONJEPs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781513418; v=1;
 b=igxDuBvqoa1ym+n39fp27ca4/ruULn5DBvq7XsZLppw6JPKpjLq5dIGnNt7gmTDT
 VN6dCXx4b8Xwzkl7fYsdtsN2tq14CuFBCA1z3l5exu8di+N0byMya8uVIuvR8MF5
 2YFZ7LYm6LthR8OFJbaESh1T//iz2LeSu7q5c2ycfHd94C7UMj7YYBpIdhsDioQS
 owJJT+qfitNP7ROAGE6dMGBHTsr90RRe9fV0EXjiDLmomjUDmWPOAnG/g0ti9w4s
 RHU/+aQJMWluQ719R2DFW8p8AAE5cKPMjcW7K8NXYYJEYBLkhJqJwFdEo4N8iKUh
 GwjuxUZI0mv5m95iq112HA==
Message-ID: <23953462-9a8f-4532-93cb-500abcf36d33@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 15 Jun 2026 17:50:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qom: Reject temporary object resurrection
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-1-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-4-0UkH0uCZwYS@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ai-4-0UkH0uCZwYS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/15 17:34, Kevin Wolf wrote:
> Am 15.06.2026 um 06:11 hat Akihiko Odaki geschrieben:
>> If object_ref() is called during finalization, it will temporarily
>> "resurrect" the object. Although object_finalize() asserts that no
>> resurrecting reference remains before freeing the object, the assertion
>> cannot catch the case where the resurrecting reference is dropped before
>> freeing the object.
> 
> Ok, and why is that a problem?
> 
> In the cover letter, you referred to an earlier patch you had posted:
> 
>      The temporary object resurrection patch originated from:
>      https://lore.kernel.org/qemu-devel/20250906-mr-v2-1-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp/
>      ("[PATCH v2 1/3] qom: Do not finalize twice")
> 
>  From that patch, it's clear that one problem is that .finalize() can be
> called multiple times, which you probably don't want. But what is the
> reason for switching from just ignoring the second .finalize() like in
> the old patch to completely forbidding a temporary refcount increase?

None. I thought merely skipping finalization is not a well-defined 
semantics (e.g., breaking Rust safety guarantee), but, reconsidering 
now, I think that's fine.

> 
>> One way to catch this would be to add a check in object_ref() to reject
>> resurrecting references before they are created. However, object_ref()
>> is frequently called so it is better to minimize the overhead.
> 
> We're talking about a single comparison with zero here. So if that's the
> worse alternative, the other one can't have any drawbacks.

True.

> 
>> To avoid adding the overhead, change how the reference count is
>> represented and let an existing assertion detect resurrection. More
>> concretely, obj->ref now stores the current reference count minus 1. The
>> stored count is therefore 0 after object_initialize(), and the final
>> object_unref() decrements it from 0 to UINT32_MAX and starts
>> finalization. A resurrecting object_ref() will then trip the existing
>> obj->ref < INT_MAX assertion.
> 
> A refcount field where 0 means that a last reference is still remaining
> is highly confusing. If we do want to forbid taking a temporary new
> reference in .finalize() for some reason, the explicit check in
> object_ref() sounds much better to me.

The rationale here is that the field is mostly contained in qom/object.c 
so the awkward semantics won't have a wide impact. But it's just 
"mostly" and there are two exceptions: block/throttle-groups.c and 
tests/unit/check-qom-proplist.c.

I withdraw this patch for the drawbacks discussed above.

Regards,
Akihiko Odaki

