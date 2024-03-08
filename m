Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31C9C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVUU-0001D7-Dv; Fri, 08 Mar 2024 03:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riVUS-0001CT-I8; Fri, 08 Mar 2024 03:22:04 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1riVUQ-0000FH-HX; Fri, 08 Mar 2024 03:22:04 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 08E45488A0;
 Fri,  8 Mar 2024 09:21:59 +0100 (CET)
Message-ID: <e8d80672-a5b5-45cc-a203-fa15a1164b72@proxmox.com>
Date: Fri, 8 Mar 2024 09:21:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com> <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
 <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 07.03.24 um 20:42 schrieb Vladimir Sementsov-Ogievskiy:
> On 04.03.24 14:09, Peter Krempa wrote:
>> On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
>>> Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>> On 03.11.23 18:56, Markus Armbruster wrote:
>>>>> Kevin Wolf<kwolf@redhat.com>  writes:
>>
>> [...]
>>
>>>>> Is the job abstraction a failure?
>>>>>
>>>>> We have
>>>>>
>>>>>       block-job- command      since   job- command    since
>>>>>       -----------------------------------------------------
>>>>>       block-job-set-speed     1.1
>>>>>       block-job-cancel        1.1     job-cancel      3.0
>>>>>       block-job-pause         1.3     job-pause       3.0
>>>>>       block-job-resume        1.3     job-resume      3.0
>>>>>       block-job-complete      1.3     job-complete    3.0
>>>>>       block-job-dismiss       2.12    job-dismiss     3.0
>>>>>       block-job-finalize      2.12    job-finalize    3.0
>>>>>       block-job-change        8.2
>>>>>       query-block-jobs        1.1     query-jobs
>>
>> [...]
>>
>>> I consider these strictly optional. We don't really have strong reasons
>>> to deprecate these commands (they are just thin wrappers), and I think
>>> libvirt still uses block-job-* in some places.
>>
>> Libvirt uses 'block-job-cancel' because it has different semantics from
>> 'job-cancel' which libvirt documented as the behaviour of the API that
>> uses it. (Semantics regarding the expectation of what is written to the
>> destination node at the point when the job is cancelled).
>>
> 
> That's the following semantics:
> 
>   # Note that if you issue 'block-job-cancel' after 'drive-mirror' has
>   # indicated (via the event BLOCK_JOB_READY) that the source and
>   # destination are synchronized, then the event triggered by this
>   # command changes to BLOCK_JOB_COMPLETED, to indicate that the
>   # mirroring has ended and the destination now has a point-in-time copy
>   # tied to the time of the cancellation.
> 
> Hmm. Looking at this, it looks for me, that should probably a
> 'block-job-complete" command (as leading to BLOCK_JOB_COMPLETED).
> 
> Actually, what is the difference between block-job-complete and
> block-job-cancel(force=false) for mirror in ready state?
> 
> I only see the following differencies:
> 
> 1. block-job-complete documents that it completes the job
> synchronously.. But looking at mirror code I see it just set
> s->should_complete = true, which will be then handled asynchronously..
> So I doubt that documentation is correct.
> 
> 2. block-job-complete will trigger final graph changes. block-job-cancel
> will not.
> 
> Is [2] really useful? Seems yes: in case of some failure before starting
> migration target, we'd like to continue executing source. So, no reason
> to break block-graph in source, better keep it unchanged.
> 

FWIW, we also rely on these special semantics. We allow cloning the disk
state of a running guest using drive-mirror (and before finishing,
fsfreeze in the guest for consistency). We cannot use block-job-complete
there, because we do not want to switch the source's drive.

> But I think, such behavior better be setup by mirror-job start
> parameter, rather then by special option for cancel (or even compelete)
> command, useful only for mirror.
> 
> So, what about the following substitution for block-job-cancel:
> 
> block-job-cancel(force=true)  -->  use job-cancel
> 
> block-job-cancel(force=false) for backup, stream, commit  -->  use
> job-cancel
> 
> block-job-cancel(force=false) for mirror in ready mode  -->
> 
>   instead, use block-job-complete. If you don't need final graph
> modification which mirror job normally does, use graph-change=false
> parameter for blockdev-mirror command.
> 

But yes, having a graph-change parameter would work for us too :)

Best Regards,
Fiona


