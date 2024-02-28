Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7068C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOKr-0007rl-Ly; Wed, 28 Feb 2024 13:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfOKq-0007rQ-2U; Wed, 28 Feb 2024 13:07:16 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfOKn-0006pp-0t; Wed, 28 Feb 2024 13:07:15 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:6c2d:0:640:316f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 1ADFA608CE;
 Wed, 28 Feb 2024 21:07:04 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 27eQ2K2Id4Y0-R3ZKl2qm; Wed, 28 Feb 2024 21:07:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709143623;
 bh=RKcA0N+j6C3zT0o/8lb7nZFYAaQCAE7Co8hswU3MiWo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ao4hKmu48el7h90GHeN6rTl/DtNL37y49WnvL6tQHcd89IWRGsJ1NvHneNLYwd8xp
 hAtQG0KS4gyZYrAI0yyV0xj1HX0jDjY99UDw5CIpMBPl9nDHtKBkq1ngThAdpoT7Ik
 +CbJ+Cq6rLANoqQqwz9Zxv17QkxM9DeuSB1MY9Nc=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1310efb0-e211-46f5-b166-d7d529507a43@yandex-team.ru>
Date: Wed, 28 Feb 2024 21:07:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] mirror: allow switching from background to
 active mode
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <20231009094619.469668-1-f.ebner@proxmox.com>
 <a5c48627-0bef-46cd-9426-587b358fe32d@yandex-team.ru>
 <993bfa5d-1a91-4b32-9bd8-165b7abba4f0@proxmox.com>
 <99dd287b-816b-4f4f-b156-32f94bbb62c2@yandex-team.ru>
 <87o7gbyy8w.fsf@pond.sub.org> <ZUTffE0wfjLH2u+e@redhat.com>
 <87cywqn84g.fsf@pond.sub.org>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87cywqn84g.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 03.11.23 18:56, Markus Armbruster wrote:
> Kevin Wolf<kwolf@redhat.com>  writes:
> 
>> Am 03.11.2023 um 10:36 hat Markus Armbruster geschrieben:
>>> Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>  writes:
>>>
>>>> On 11.10.23 13:18, Fiona Ebner wrote:
>>>>> Am 10.10.23 um 19:55 schrieb Vladimir Sementsov-Ogievskiy:
>>>>>> On 09.10.23 12:46, Fiona Ebner wrote:
>>>>>>> Initially, I tried to go for a more general 'job-change' command, but
>>>>>>> I couldn't figure out a way to avoid mutual inclusion between
>>>>>>> block-core.json and job.json.
>>>>>>>
>>>>>> What is the problem with it? I still think that job-change would be better.
>>>>>>
>>>>> If going for job-change in job.json, the dependencies would be
>>>>> job-change -> JobChangeOptions -> JobChangeOptionsMirror -> MirrorCopyMode
>>>>> query-jobs -> JobInfo -> JobInfoMirror
>>>>> and we can't include block-core.json in job.json, because an inclusion
>>>>> loop gives a build error.
>>> Let me try to understand this.
>>>
>>> Command job-change needs its argument type JobChangeOptions.
>>>
>>> JobChangeOptions is a union, and JobChangeOptionsMirror is one of its
>>> branches.
>>>
>>> JobChangeOptionsMirror needs MirrorCopyMode from block-core.json.
>>>
>>> block-core.json needs job.json for JobType and JobStatus.
>>>
>>>>> Could be made to work by moving MirrorCopyMode (and
>>>>> JobChangeOptionsMirror, JobInfoMirror) to job.json or some place that
>>>>> can be included by both job.json and block-core.json. Moving the
>>>>> type-specific definitions to the general job.json didn't feel right to
>>>>> me. Including another file with type-specific definitions in job.json
>>>>> feels slightly less wrong, but still not quite right and I didn't want
>>>>> to create a new file just for MirrorCopyMode (and
>>>>> JobChangeOptionsMirror, JobInfoMirror).
>>>>> And going further and moving all mirror-related things to a separate
>>>>> file would require moving along things like NewImageMode with it or
>>>>> create yet another file for such general things used by multiple block-jobs.
>>>>> If preferred, I can try and go with some version of the above.
>>>>>
>>>> OK, I see the problem. Seems, that all requires some good refactoring. But that's a preexisting big work, and should not hold up your series. I'm OK to proceed with block-job-change.
>>> Saving ourselves some internal refactoring is a poor excuse for
>>> undesirable external interfaces.
>> I'm not sure how undesirable it is. We have block-job-* commands for
>> pretty much every other operation, so it's only consistent to have
>> block-job-change, too.
> Is the job abstraction a failure?
> 
> We have
> 
>      block-job- command      since   job- command    since
>      -----------------------------------------------------
>      block-job-set-speed     1.1
>      block-job-cancel        1.1     job-cancel      3.0
>      block-job-pause         1.3     job-pause       3.0
>      block-job-resume        1.3     job-resume      3.0
>      block-job-complete      1.3     job-complete    3.0
>      block-job-dismiss       2.12    job-dismiss     3.0
>      block-job-finalize      2.12    job-finalize    3.0
>      block-job-change        8.2
>      query-block-jobs        1.1     query-jobs
> 
> I was under the impression that we added the (more general) job-
> commands to replace the (less general) block-job commands, and we're
> keeping the latter just for compatibility.  Am I mistaken?
> 
> Which one should be used?
> 
> Why not deprecate the one that shouldn't be used?
> 
> The addition of block-job-change without even trying to do job-change
> makes me wonder: have we given up on the job- interface?
> 
> I'm okay with giving up on failures.  All I want is clarity.  Right now,
> I feel thoroughly confused about the status block-jobs and jobs, and how
> they're related.

Hi! I didn't notice, that the series was finally merged.

About the APIs, I think, of course we should deprecate block-job-* API, because we already have jobs which are not block-jobs, so we can't deprecate job-* API.

So I suggest a plan:

1. Add job-change command simply in block-core.json, as a simple copy of block-job-change, to not care with resolving inclusion loops. (ha we could simply name our block-job-change to be job-change and place it in block-core.json, but now is too late)

2. Support changing speed in a new job-chage command. (or both in block-job-change and job-change, keeping them equal)

3. Deprecate block-job-* APIs

4. Wait 3 releases

5. Drop block-job-* APIs

6. Move all job-related stuff to job.json, drop `{ 'include': 'job.json' }` from block-core.json, and instead include block-core.json into job.json

If it's OK, I can go through the steps.

-- 
Best regards,
Vladimir


