Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E971C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2QW-00059Q-PZ; Tue, 12 Mar 2024 09:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rk2QU-00058I-N2; Tue, 12 Mar 2024 09:44:18 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rk2QQ-0003zr-NH; Tue, 12 Mar 2024 09:44:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:30ad:0:640:87bc:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 56D7660A5B;
 Tue, 12 Mar 2024 16:44:09 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4b6::1:f] (unknown
 [2a02:6b8:b081:b4b6::1:f])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7imGCA1InGk0-zCZ5X7ax; Tue, 12 Mar 2024 16:44:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710251048;
 bh=TX/iPFoZBL/XOzeaYns9qnFHuswxWFdHgqCbyd+6dXc=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=dyBVe4UsfMdGaI9WXt6IU2aceVe0lprN+A9EcyafC7Ji983BvQPXOoU9E1qZ8rTtT
 Bw+6seJDcjd40nM7pFAwMqKaPBQk5B30TZpPiPYBpO9fuaC9N5+hp9ohq5c6GD9loY
 Fo0OcvgWTdVBJQdrBLN4XZmb/jzFYtSAVv+X0Fjs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1d6ba74e-b1d8-4292-9825-ea53d9bc77af@yandex-team.ru>
Date: Tue, 12 Mar 2024 16:44:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
 <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
 <ZeWnFhLKCamlP97y@redhat.com> <ZeWr3ZGrRUrciHH4@angien.pipo.sk>
 <65f517cd-3a1b-41bd-b326-e509cb208b92@yandex-team.ru>
 <ZerRzZj-NrDZUeAF@redhat.com>
 <306d2ca4-de7d-4318-b461-a06354e3b975@yandex-team.ru>
In-Reply-To: <306d2ca4-de7d-4318-b461-a06354e3b975@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 11.03.24 18:15, Vladimir Sementsov-Ogievskiy wrote:
> On 08.03.24 11:52, Kevin Wolf wrote:
>> Am 07.03.2024 um 20:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> On 04.03.24 14:09, Peter Krempa wrote:
>>>> On Mon, Mar 04, 2024 at 11:48:54 +0100, Kevin Wolf wrote:
>>>>> Am 28.02.2024 um 19:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>>>>> On 03.11.23 18:56, Markus Armbruster wrote:
>>>>>>> Kevin Wolf<kwolf@redhat.com>  writes:
>>>>
>>>> [...]
>>>>
>>>>>>> Is the job abstraction a failure?
>>>>>>>
>>>>>>> We have
>>>>>>>
>>>>>>>        block-job- command      since   job- command    since
>>>>>>>        -----------------------------------------------------
>>>>>>>        block-job-set-speed     1.1
>>>>>>>        block-job-cancel        1.1     job-cancel      3.0
>>>>>>>        block-job-pause         1.3     job-pause       3.0
>>>>>>>        block-job-resume        1.3     job-resume      3.0
>>>>>>>        block-job-complete      1.3     job-complete    3.0
>>>>>>>        block-job-dismiss       2.12    job-dismiss     3.0
>>>>>>>        block-job-finalize      2.12    job-finalize    3.0
>>>>>>>        block-job-change        8.2
>>>>>>>        query-block-jobs        1.1     query-jobs
>>>>
>>>> [...]
>>>>
>>>>> I consider these strictly optional. We don't really have strong reasons
>>>>> to deprecate these commands (they are just thin wrappers), and I think
>>>>> libvirt still uses block-job-* in some places.
>>>>
>>>> Libvirt uses 'block-job-cancel' because it has different semantics from
>>>> 'job-cancel' which libvirt documented as the behaviour of the API that
>>>> uses it. (Semantics regarding the expectation of what is written to the
>>>> destination node at the point when the job is cancelled).
>>>>
>>>
>>> That's the following semantics:
>>>
>>>    # Note that if you issue 'block-job-cancel' after 'drive-mirror' has
>>>    # indicated (via the event BLOCK_JOB_READY) that the source and
>>>    # destination are synchronized, then the event triggered by this
>>>    # command changes to BLOCK_JOB_COMPLETED, to indicate that the
>>>    # mirroring has ended and the destination now has a point-in-time copy
>>>    # tied to the time of the cancellation.
>>>
>>> Hmm. Looking at this, it looks for me, that should probably a
>>> 'block-job-complete" command (as leading to BLOCK_JOB_COMPLETED).
>>
>> Yes, it's just a different completion mode.
>>
>>> Actually, what is the difference between block-job-complete and
>>> block-job-cancel(force=false) for mirror in ready state?
>>>
>>> I only see the following differencies:
>>>
>>> 1. block-job-complete documents that it completes the job
>>>     synchronously.. But looking at mirror code I see it just set
>>>     s->should_complete = true, which will be then handled
>>>     asynchronously..  So I doubt that documentation is correct.
>>>
>>> 2. block-job-complete will trigger final graph changes.
>>>     block-job-cancel will not.
>>>
>>> Is [2] really useful? Seems yes: in case of some failure before
>>> starting migration target, we'd like to continue executing source. So,
>>> no reason to break block-graph in source, better keep it unchanged.
>>>
>>> But I think, such behavior better be setup by mirror-job start
>>> parameter, rather then by special option for cancel (or even
>>> compelete) command, useful only for mirror.
>>
>> I'm not sure, having the option on the complete command makes more sense
>> to me than having it in blockdev-mirror.
>>
>> I do see the challenge of representing this meaningfully in QAPI,
>> though. Semantically it should be a union with job-specific options and
>> only mirror adds the graph-changes option. But the union variant
>> can't be directly selected from another option - instead we have a job
>> ID, and the variant is the job type of the job with this ID.
> 
> We already have such command: block-job-change. Which has id and type parameters, so user have to pass both, to identify the job itself and pick corresponding variant of the union type.
> 
> That would be good to somehow teach QAPI to get the type automatically from the job itself...


Seems, that's easy enough to implement such a possibility, I'll try. At least now I have a prototype, which compiles

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0ae8ae62dc..332de67e52 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3116,13 +3116,11 @@
  #
  # @id: The job identifier
  #
-# @type: The job type
-#
  # Since: 8.2
  ##
  { 'union': 'BlockJobChangeOptions',
-  'base': { 'id': 'str', 'type': 'JobType' },
-  'discriminator': 'type',
+  'base': { 'id': 'str' },
+  'discriminator': 'JobType',
    'data': { 'mirror': 'BlockJobChangeOptionsMirror' } }


to


bool visit_type_BlockJobChangeOptions_members(Visitor *v, BlockJobChangeOptions *obj, Error **errp)
{
     JobType tag;
     if (!visit_type_q_obj_BlockJobChangeOptions_base_members(v, (q_obj_BlockJobChangeOptions_base *)obj, errp)) {
         return false;
     }
     if (!BlockJobChangeOptions_mapper(obj, &tag, errp)) {
         return false;
     }
     switch (tag) {
     case JOB_TYPE_MIRROR:
         return visit_type_BlockJobChangeOptionsMirror_members(v, &obj->u.mirror, errp);
     case JOB_TYPE_COMMIT:
         break;
     ...



(specifying member as descriminator works too, and I'm not going to change the interface of block-job-change, it's just and example)

BlockJobChangeOptions_mapper() should be defined by hand, like this:

bool BlockJobChangeOptions_mapper(BlockJobChangeOptions *opts, JobType *out,
                                   Error **errp)
{
     BlockJob *job;

     JOB_LOCK_GUARD();

     job = find_block_job_locked(opts->id, errp);
     if (!job) {
         return false;
     }

     return job_type(&job->job);
}



-- 
Best regards,
Vladimir


