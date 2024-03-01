Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C05DC5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 14:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg47c-0002Zs-3s; Fri, 01 Mar 2024 09:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg47a-0002Zi-TJ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:44:23 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg47X-0001YG-7L
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 09:44:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9328:0:640:5832:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 80A95609E6;
 Fri,  1 Mar 2024 17:44:14 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a531::1:29] (unknown
 [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id CicDUP3i7eA0-tE04pECW; Fri, 01 Mar 2024 17:44:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709304253;
 bh=ZpEiX+/kodI5EkSuz59LFwbvSw6BmRysBKz7+YQWBic=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lZwLxUtAd7ngu4I/bMyBsjnFMAtmjok0TMGsJAphtNzuyC/Yv3gLTskqrQIeeLo8i
 tA0pYcv2I74e2DX/KzT3Ujd+m+gm9RzpG0BO2vzRqQGkwFhRnVHZFowjVeooUM8hZI
 8Y47NyDU1+fhOp02E+68Hm2UyG/ysraXQqZRLEpo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <626d7918-b96c-48ba-8891-a0f519f2023b@yandex-team.ru>
Date: Fri, 1 Mar 2024 17:44:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/21] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
 <20240227180345.548960-7-clg@redhat.com> <87zfvj3hnd.fsf@pond.sub.org>
 <86d70a2e-7250-440b-bcd6-7877fe3b3dba@yandex-team.ru>
 <bea4ca16-a2ea-4a06-bb8d-27b485d63cc1@redhat.com>
 <875xy7xv6t.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <875xy7xv6t.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29.02.24 16:21, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 29/02/2024 08.20, Vladimir Sementsov-Ogievskiy wrote:
>>> On 29.02.24 09:32, Markus Armbruster wrote:
> 
> [...]
> 
>>>> Anti-pattern: fail without setting an error.  There might be more
>>>> elsewhere in the series.
>>>>
>>>> qapi/error.h's big comment:
>>>>
>>>>    * - On success, the function should not touch *errp.  On failure, it
>>>>    *   should set a new error, e.g. with error_setg(errp, ...), or
>>>>    *   propagate an existing one, e.g. with error_propagate(errp, ...).
>>>>    *
>>>>    * - Whenever practical, also return a value that indicates success /
>>>>    *   failure.  This can make the error checking more concise, and can
>>>>    *   avoid useless error object creation and destruction.  Note that
>>>>    *   we still have many functions returning void.  We recommend
>>>>    *   • bool-valued functions return true on success / false on failure,
>>>>    *   • pointer-valued functions return non-null / null pointer, and
>>>>    *   • integer-valued functions return non-negative / negative.
>>>>
>>>>          }
>>>>          qemu_put_be64(f, STATTR_FLAG_EOS);
>>>>          return 0;
>>>>      }
>>>>
>>>> When adding Error **errp to a function, you must also add code to set an
>>>> error on failure to every failure path.  Adding it in a later patch in
>>>> the same series can be okay,
>>>
>>> Personally, I'd prefer not doing so. Creating wrong commits and fixing them in same series - better to merge all fixes into bad commit:)
>>
>> I agree - that might create issues with bisecting later. Please fix it in this patch here already!
> 
> Depends on the wrongness, really.

In my understanding, unset errp on failure path is wrong enough.

For example, simple pattern

Error *local_err = NULL;

int ret = foo(&local_err);
if (ret < 0) {
     error_report_err(local_err);
     return;
}

will just crash.

When I write code, I expect that "errp is set" === "ret < 0", for all functions returning negative integer on failure.

Also, we have enough code that relying on errp for failure checking:
$ git grep 'if (local_err)' | wc -l
373

Of course, most of this should be checking failure of functions that return void, but who knows.

> 
> We don't want broken intermediate states, no argument.
> 
> But intermediate states that are merely unclean can be acceptable.
> 
> For instance, my commit a30ecde6e79 (net: Permit incremental conversion
> of init functions to Error) added such Error ** parameters to a somewhat
> tangled nest of functions, along with FIXME comments where errors
> weren't set.  The next few commits fixed most, but not all of them.
> Later commits fixed some more.  The one in tap-win32.c is still there
> today.
> 
> This was acceptable, because it improved things from "bad error
> reporting" to "okay error reporting in most cases, unclean and bad error
> reporting in a few cases marked FIXME", with "a few" over time going
> down to the one I can't test, and nobody else seems to care about.
> 

-- 
Best regards,
Vladimir


