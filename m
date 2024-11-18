Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66745D43FE6
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 07:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCwUS-0002zX-Tz; Mon, 18 Nov 2024 02:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwUC-0002yq-Cs; Mon, 18 Nov 2024 02:47:52 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tCwU5-0006Gb-6d; Mon, 18 Nov 2024 02:47:48 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3b05:0:640:71ba:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B608560B85;
 Mon, 18 Nov 2024 10:47:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:210::1:15] (unknown
 [2a02:6b8:b081:210::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id alKhHl7VsiE0-Q4hGhLf4; Mon, 18 Nov 2024 10:47:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1731916057;
 bh=f1Zi7HTZL2bupJ2cnuN134CV7D668fiXAe6Yem7nOnI=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=CpjYjmKP+vrnUz3nWm/Vu6qjkiPjrPTwCtvwU92xv/HZ6gPSwGIvCX/IwIdUMCCuj
 Xgn5qIol+xOlSGkP+QIA2unIaipLh5xAd8lsJin0pObg77eaBht5Dd+EuMFkdhGdc6
 QEw9bYuPc+Vsox9lGZL/jiZYfwZ4WUkidLqGjZxY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <92cb6c3c-fb08-418c-ae35-4e4a34ec74ac@yandex-team.ru>
Date: Mon, 18 Nov 2024 10:47:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] block: refactor error handling of commit_iteration
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
 <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
 <578cf48d-1917-455f-922e-dff99a2416ca@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <578cf48d-1917-455f-922e-dff99a2416ca@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.11.24 10:37, Vladimir Sementsov-Ogievskiy wrote:
> On 26.10.24 19:30, Vincent Vanlaer wrote:
>> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
>> ---
>>   block/commit.c | 61 ++++++++++++++++++++++++++++----------------------
>>   1 file changed, 34 insertions(+), 27 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 078e54f51f..5c24c8b80a 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -129,51 +129,58 @@ static void commit_clean(Job *job)
>>   }
>>   static int commit_iteration(CommitBlockJob *s, int64_t offset,
>> -                            int64_t *n, void *buf)
>> +                            int64_t *requested_bytes, void *buf)
>>   {
>> +    int64_t bytes = *requested_bytes;
>>       int ret = 0;
>> -    bool copy;
>>       bool error_in_source = true;
>>       /* Copy if allocated above the base */
>>       WITH_GRAPH_RDLOCK_GUARD() {
>>           ret = bdrv_co_common_block_status_above(blk_bs(s->top),
>>               s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
>> -            n, NULL, NULL, NULL);
>> +            &bytes, NULL, NULL, NULL);
>>       }
>> -    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
>> -    trace_commit_one_iteration(s, offset, *n, ret);
>> -    if (copy) {
>> -        assert(*n < SIZE_MAX);
>> +    trace_commit_one_iteration(s, offset, bytes, ret);
>> -        ret = blk_co_pread(s->top, offset, *n, buf, 0);
>> -        if (ret >= 0) {
>> -            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
>> -            if (ret < 0) {
>> -                error_in_source = false;
>> -            }
>> -        }
>> -    }
>>       if (ret < 0) {
>> -        BlockErrorAction action = block_job_error_action(&s->common,
>> -                                                         s->on_error,
>> -                                                         error_in_source,
>> -                                                         -ret);
>> -        if (action == BLOCK_ERROR_ACTION_REPORT) {
>> -            return ret;
>> -        } else {
>> -            *n = 0;
>> -            return 0;
>> +        goto fail;
>> +    }
>> +
>> +    if (ret & BDRV_BLOCK_ALLOCATED) {
>> +        assert(bytes < SIZE_MAX);
>> +
>> +        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
>> +        if (ret < 0) {
>> +            goto fail;
>>           }
>> +
>> +        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
>> +        if (ret < 0) {
>> +            error_in_source = false;
>> +            goto fail;
>> +        }
>> +
>> +        block_job_ratelimit_processed_bytes(&s->common, bytes);
>>       }
>> +
>>       /* Publish progress */
>> -    job_progress_update(&s->common.job, *n);
>> -    if (copy) {
>> -        block_job_ratelimit_processed_bytes(&s->common, *n);
>> +    job_progress_update(&s->common.job, bytes);
>> +
>> +    *requested_bytes = bytes;
>> +
>> +    return 0;
> 
> With this extra semicolon removed:

I meant "fail:;"

I'll will touch this up when applying.

> 
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> I'd also add an empty line before "fail:".
> 
> 
>> +fail:;
>> +    BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
>> +                                                     error_in_source, -ret);
>> +    if (action == BLOCK_ERROR_ACTION_REPORT) {
>> +        return ret;
>>       }
>> +    *requested_bytes = 0;
>> +
>>       return 0;
>>   }
> 

-- 
Best regards,
Vladimir


