Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AE8106ACCB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0izo-0000fQ-79; Thu, 12 Mar 2026 12:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0izm-0000fG-L5
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:34:46 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0izg-00086l-Bp
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:34:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 31B4F80839;
 Thu, 12 Mar 2026 19:34:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id YYKmTK0A2iE0-aUdJ1PmK; Thu, 12 Mar 2026 19:34:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773333275;
 bh=YlOYM2pX+SaemOYfMR3/uh0HsMi3eHZWfdq+uoVG4rg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dg6JccFuWlk82ToPUvc+PMgR1tLXUjU2ccQE/8HDU2oNnLNvv5fLDOKLWHIZ7816I
 s6kAxsEH2eFtTGNOxJ462CXeTGykDwL9IBRwYkZkSWV1sHS/asQ5uc1/+YcOThzv7i
 Gqb77ykAL05P5wpEqdl+gWQhmmM4Wkhl4mB5MV5w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <022c929e-ddda-4f74-8786-d01994107415@yandex-team.ru>
Date: Thu, 12 Mar 2026 19:34:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>
References: <20260302070626.613396-1-dtalexundeer@yandex-team.ru>
 <87y0k5136i.fsf@suse.de>
 <714e4329-6001-4c77-b004-ed7beb11c154@yandex-team.ru>
 <e81360d5-cab4-47a4-840b-7d948b51a5c0@yandex-team.ru>
 <CAFEAcA-m+CZPUchGsh6QU4gm1dO-FP0m1w5gu6sn56wUXBbRAQ@mail.gmail.com>
 <abBcN2B4QNBT_Oh9@x1.local>
 <f37dc7af-7ffd-4a7b-b4fa-552c2d2eb888@yandex-team.ru>
 <abGEwf-AG1rZ3kam@x1.local>
 <a6dafc1e-79d1-4380-a4da-7cbc4ff77ae4@yandex-team.ru>
 <abLc_ppEEbKjNRUi@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <abLc_ppEEbKjNRUi@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 12.03.26 18:34, Peter Xu wrote:
> On Thu, Mar 12, 2026 at 09:30:35AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> You say
>>
>>> .. always pop the VMSD stack then the upper layer may read the SUBSECTION byte anywhere.
>>
>> But it actually can be anything. Of course probability is small that some another state
>> looks like QEMU_VM_SUBSECTION + <existing subsection name>, but we don't have actual
>> guarantee for it in the protocol.
>>
>> Probably, we may also add a protocol change (with some global state property,
>> set to true in new MT) to add a number of subsections into section state, to be
>> sure how many of them we have in the stream.
> 
> Yes, I believe it's always possible to change the streaming protocol to
> make it even clearer.  Actually, that's what I was picturing before I read
> your previous reply.
> 
> For doing that, I wonder if we should just fix "this specific problem" or
> "the bigger problem".
> 
> The bigger problem here, at least to me, is migration streaming lacks level
> information - virtio can wrongly treat that piece of info as its own
> subsection only because the stream doesn't tell which level it's in..
> It's a common issue for migration stream, so I wonder if we need to break
> the streaming protocol then whether we should do even further than that.
> 
> That is the part where I think what you suggested in the previous email may
> be the easy way to go (plus, removing the name check completely).
> 
> But let me double check with you on one thing: before any fix, this problem
> will happen even during a migration between two latest QEMU that supports
> that new subsection of virtio-blk, am I right?
> 
> I am curious why this problem is only reported until today, rather than
> when the new subsection was developed.  I wonder if I still miss something
> that I didn't notice..
> 

Hmm. Probably, that this is the subsection, that exist only in our downstream.
I don't know, was it mentioned clearly before, sorry if not.
This subsection just not exist in master, and we are not going to upstream it.
So, for upstream it's a "theoretical" bug in a protocol, which may be triggered in
some future moment. And that's why there is not specific case in commit message
but only assumption "Let's say there is a vmstate ...".

-- 
Best regards,
Vladimir

