Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D4EC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiDiF-0005pO-3N; Wed, 12 Feb 2025 09:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tiDiD-0005oZ-1v
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tiDi9-0004Gy-LW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:27:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739370451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cTSP2wrGuZ2rSCKOmZIbG5wD8NYLsXJmAvX+Q6Mx0T0=;
 b=ctsC8qEyuMHCGLrmVoEn4JE1rkiC06yZfNkKLg3dOKq+Sw8LaR+eLyhEywQLNYYNGtddrK
 b9/dd7QRU3+Ijb/No5XY87ajpJjjc6CTmeOu4Kd+k6g43YO49uRVzDnuMkJuXbs8LHlBm5
 BcsieCoccpUlKGL4Z6FCMJWqJV73yEQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-HcVh1BlDOsCKWNyMybKUEw-1; Wed, 12 Feb 2025 09:27:29 -0500
X-MC-Unique: HcVh1BlDOsCKWNyMybKUEw-1
X-Mimecast-MFC-AGG-ID: HcVh1BlDOsCKWNyMybKUEw_1739370449
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dc6aad9f8so417629f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739370448; x=1739975248;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cTSP2wrGuZ2rSCKOmZIbG5wD8NYLsXJmAvX+Q6Mx0T0=;
 b=Cr8f9Lz8iVQWewp0AIXLTje/EDHGrxVskNRf0UAXxCqaCFgY8JTGvWnkqIP9hc/vyk
 +FM01dDOCf7fMFXtyG853IfhteWFSIWJGN80495qD6jY5VVT6D1goMxNhYx/Hx702sy/
 N5CK6jzON8SpWQImT/tcvet8WCnujZz3ZFewZeWy0Cyn2G7IF6qQdQTuTiXmQs9K3G4R
 ehybaXmbaaga5L1mUN2PzagJlBI7zOAzP54eukd0pDFkQ3HFwavItQR8/fn0D4NxF6kF
 kJCTwFbLYv63oFJzp686Jy4CgdWI5/vTlsg6OxZzOcMfii+OZ+J7quqEZvkbKMCdeZ56
 Zdcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmui9smtVnhyolZQvlsCc7MjLTONDAd1lIDMHSEF3uRy0J4FhWX7bB5xdlnl7kYRGiD9Ri4OTyeyxd@nongnu.org
X-Gm-Message-State: AOJu0Yyh2XEg3R/Eg8Cu6Ih/Qeorn5z2YqUuiHWa6/Jpi1FGvF+hjLUJ
 gznasf4saFDmzt1FtN6QQtKxtGlAvAHmPPWSCe8TMsL9Sah/gEZe4//MfwEEd77lLgsxuZ/+Xkk
 62nbVKbEmApO+hYPoIfyxw9CQVxmz/+CmUfRZw1bHJeyZE2gmyRDt
X-Gm-Gg: ASbGncuNhNuj8U9+Kox5MC7gWI8VlB57fQil11QcEtcqSBmV3BPoTlLlOb1kN/8DNX1
 9zt3v4cTvhSfWYQ4Zt5Er8phScSbmAfuJc3pn1YJ5ox4xmTgVhYCySvQn5hUtS0MjpcWq0g1jh0
 8DHXwAF6WjQK0EOA5jwMBgEnS+rbWLbMTh4Soty7lVT2lghocMQ66USGrBC4cWDGcBCFuJ2lXj4
 yLpHbKlTSE1C1LVlqE2BQwe5lrPtQ/URS70tDOXAIXEKHdbtrSg1D2gTxJoKI/FO+iQHrP+PG+G
 oa8PsiJBARtUtcUACPIKvtN9i0YlyGEKYHyqrMCyQK/C9EqgNNfl5xB1zVQH2vFjRoitweEJPeG
 wQH8iVT1kxWKCfugcDi5OfIvK2h7XY13P+A==
X-Received: by 2002:a5d:47ae:0:b0:38d:b349:2db2 with SMTP id
 ffacd0b85a97d-38dea253a91mr3167302f8f.22.1739370448414; 
 Wed, 12 Feb 2025 06:27:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjuuqoZ2p/Y7Oz1drgBFvF4xxnkuUoVp4K+9SZmzqCONwMTQcamDbT3C+iBtnlWS60tt4sKQ==
X-Received: by 2002:a5d:47ae:0:b0:38d:b349:2db2 with SMTP id
 ffacd0b85a97d-38dea253a91mr3167275f8f.22.1739370447924; 
 Wed, 12 Feb 2025 06:27:27 -0800 (PST)
Received: from ?IPV6:2003:cf:d712:443f:6a1f:db8b:c80f:66e5?
 (p200300cfd712443f6a1fdb8bc80f66e5.dip0.t-ipconnect.de.
 [2003:cf:d712:443f:6a1f:db8b:c80f:66e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf81f3aesm13969119f8f.51.2025.02.12.06.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 06:27:27 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------h2YF0FofhTADY1gbF5rywQJC"
Message-ID: <807a4908-d087-4c69-ba56-07c60545405e@redhat.com>
Date: Wed, 12 Feb 2025 15:27:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/rbd: Do not use BDS's AioContext
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Ilya Dryomov <idryomov@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250212093238.32312-1-hreitz@redhat.com>
 <Z6yhczeIJ1XIej3M@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <Z6yhczeIJ1XIej3M@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------h2YF0FofhTADY1gbF5rywQJC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.25 14:26, Kevin Wolf wrote:
> Am 12.02.2025 um 10:32 hat Hanna Czenczek geschrieben:
>> RBD schedules the request completion code (qemu_rbd_finish_bh()) to run
>> in the BDS's AioContext.  The intent seems to be to run it in the same
>> context that the original request coroutine ran in, i.e. the thread on
>> whose stack the RBDTask object exists (see qemu_rbd_start_co()).
>>
>> However, with multiqueue, that thread is not necessarily the same as the
>> BDS's AioContext.  Instead, we need to remember the actual AioContext
>> and schedule the completion BH there.
>>
>> Buglink:https://issues.redhat.com/browse/RHEL-67115
> Please add a short summary of what actually happens to the commit
> message. I had to check the link to remember what the symptoms are.

Sure.  The problem is, I don’t know exactly what’s going wrong (looked 
like a coroutine being rescheduled after it was already done), and I 
don’t know how this fixes it.

>> Reported-by: Junyao Zhao<junzhao@redhat.com>
>> Signed-off-by: Hanna Czenczek<hreitz@redhat.com>
>> ---
>> I think I could also drop RBDTask.ctx and just use
>> `qemu_coroutine_get_aio_context(RBDTask.co)` instead, but this is the
>> version of the patch that was tested and confirmed to fix the issue (I
>> don't have a local reproducer), so I thought I'll post this first.
> Did  you figure out why it even makes a difference in which thread
> qemu_rbd_finish_bh() runs? For context:
>
>      static void qemu_rbd_finish_bh(void *opaque)
>      {
>          RBDTask *task = opaque;
>          task->complete = true;
>          aio_co_wake(task->co);
>      }
>
> This looks as if it should be working in any thread, except maybe for a
> missing barrier after updating task->complete - but I think the failure
> mode for that would be a hang in qemu_rbd_start_co().

Yes, I thought the same thing.  All I could imagine was that maybe 
reading task->co returns the wrong result, but given how long ago that 
must have been set, it seems quite unlikely (to say the least).  In 
addition, qemu_rbd_completion_cb() already reads the object from a 
different thread, and that seems to work fine.

Really, all I know is that the notion of a BDS’s AioContext no longer 
makes sense in a multiqueue I/O path, so this should be scheduled in the 
I/O’s AioContext (just conceptually speaking), and that this seems to 
fix the bug.

>>   block/rbd.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/rbd.c b/block/rbd.c
>> index af984fb7db..9d4e0817e0 100644
>> --- a/block/rbd.c
>> +++ b/block/rbd.c
>> @@ -102,7 +102,7 @@ typedef struct BDRVRBDState {
>>   } BDRVRBDState;
>>   
>>   typedef struct RBDTask {
>> -    BlockDriverState *bs;
>> +    AioContext *ctx;
>>       Coroutine *co;
>>       bool complete;
>>       int64_t ret;
>> @@ -1269,8 +1269,7 @@ static void qemu_rbd_completion_cb(rbd_completion_t c, RBDTask *task)
>>   {
>>       task->ret = rbd_aio_get_return_value(c);
>>       rbd_aio_release(c);
>> -    aio_bh_schedule_oneshot(bdrv_get_aio_context(task->bs),
>> -                            qemu_rbd_finish_bh, task);
>> +    aio_bh_schedule_oneshot(task->ctx, qemu_rbd_finish_bh, task);
>>   }
>>   
>>   static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
>> @@ -1281,7 +1280,10 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
>>                                             RBDAIOCmd cmd)
>>   {
>>       BDRVRBDState *s = bs->opaque;
>> -    RBDTask task = { .bs = bs, .co = qemu_coroutine_self() };
>> +    RBDTask task = {
>> +        .ctx = qemu_get_current_aio_context(),
>> +        .co = qemu_coroutine_self(),
>> +    };
>>       rbd_completion_t c;
>>       int r;
> Nothing wrong I can see about the change, but I don't understand why it
> fixes the problem.

Me neither.  But if this patch had been part of one of the original 
multiqueue series (without pointing out the linked bug), would there 
have been any argument against it?

Indeed it is a problem that I don’t understand what’s happening. But 
even more honestly, I’ll have to admit I can’t ever claim to understand 
what’s happening in a multi-threaded asynchronous C environment; even 
more so when the reproducer is installing Windows on RBD.

Hanna
--------------h2YF0FofhTADY1gbF5rywQJC
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 12.02.25 14:26, Kevin Wolf wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Z6yhczeIJ1XIej3M@redhat.com">
      <pre wrap="" class="moz-quote-pre">Am 12.02.2025 um 10:32 hat Hanna Czenczek geschrieben:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">RBD schedules the request completion code (qemu_rbd_finish_bh()) to run
in the BDS's AioContext.  The intent seems to be to run it in the same
context that the original request coroutine ran in, i.e. the thread on
whose stack the RBDTask object exists (see qemu_rbd_start_co()).

However, with multiqueue, that thread is not necessarily the same as the
BDS's AioContext.  Instead, we need to remember the actual AioContext
and schedule the completion BH there.

Buglink: <a class="moz-txt-link-freetext" href="https://issues.redhat.com/browse/RHEL-67115">https://issues.redhat.com/browse/RHEL-67115</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please add a short summary of what actually happens to the commit
message. I had to check the link to remember what the symptoms are.</pre>
    </blockquote>
    <br>
    Sure.  The problem is, I don’t know exactly what’s going wrong
    (looked like a coroutine being rescheduled after it was already
    done), and I don’t know how this fixes it.<br>
    <br>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:Z6yhczeIJ1XIej3M@redhat.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Reported-by: Junyao Zhao <a class="moz-txt-link-rfc2396E" href="mailto:junzhao@redhat.com">&lt;junzhao@redhat.com&gt;</a>
Signed-off-by: Hanna Czenczek <a class="moz-txt-link-rfc2396E" href="mailto:hreitz@redhat.com">&lt;hreitz@redhat.com&gt;</a>
---
I think I could also drop RBDTask.ctx and just use
`qemu_coroutine_get_aio_context(RBDTask.co)` instead, but this is the
version of the patch that was tested and confirmed to fix the issue (I
don't have a local reproducer), so I thought I'll post this first.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Did  you figure out why it even makes a difference in which thread
qemu_rbd_finish_bh() runs? For context:

    static void qemu_rbd_finish_bh(void *opaque)
    {
        RBDTask *task = opaque;
        task-&gt;complete = true;
        aio_co_wake(task-&gt;co);
    }

This looks as if it should be working in any thread, except maybe for a
missing barrier after updating task-&gt;complete - but I think the failure
mode for that would be a hang in qemu_rbd_start_co().</pre>
    </blockquote>
    <br>
    Yes, I thought the same thing.  All I could imagine was that maybe
    reading task-&gt;co returns the wrong result, but given how long ago
    that must have been set, it seems quite unlikely (to say the
    least).  In addition, qemu_rbd_completion_cb() already reads the
    object from a different thread, and that seems to work fine.<br>
    <br>
    Really, all I know is that the notion of a BDS’s AioContext no
    longer makes sense in a multiqueue I/O path, so this should be
    scheduled in the I/O’s AioContext (just conceptually speaking), and
    that this seems to fix the bug.<br>
    <br>
    <blockquote type="cite" cite="mid:Z6yhczeIJ1XIej3M@redhat.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> block/rbd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index af984fb7db..9d4e0817e0 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -102,7 +102,7 @@ typedef struct BDRVRBDState {
 } BDRVRBDState;
 
 typedef struct RBDTask {
-    BlockDriverState *bs;
+    AioContext *ctx;
     Coroutine *co;
     bool complete;
     int64_t ret;
@@ -1269,8 +1269,7 @@ static void qemu_rbd_completion_cb(rbd_completion_t c, RBDTask *task)
 {
     task-&gt;ret = rbd_aio_get_return_value(c);
     rbd_aio_release(c);
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(task-&gt;bs),
-                            qemu_rbd_finish_bh, task);
+    aio_bh_schedule_oneshot(task-&gt;ctx, qemu_rbd_finish_bh, task);
 }
 
 static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
@@ -1281,7 +1280,10 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
                                           RBDAIOCmd cmd)
 {
     BDRVRBDState *s = bs-&gt;opaque;
-    RBDTask task = { .bs = bs, .co = qemu_coroutine_self() };
+    RBDTask task = {
+        .ctx = qemu_get_current_aio_context(),
+        .co = qemu_coroutine_self(),
+    };
     rbd_completion_t c;
     int r;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Nothing wrong I can see about the change, but I don't understand why it
fixes the problem.
</pre>
    </blockquote>
    <br>
    Me neither.  But if this patch had been part of one of the original
    multiqueue series (without pointing out the linked bug), would there
    have been any argument against it?<br>
    <br>
    Indeed it is a problem that I don’t understand what’s happening. 
    But even more honestly, I’ll have to admit I can’t ever claim to
    understand what’s happening in a multi-threaded asynchronous C
    environment; even more so when the reproducer is installing Windows
    on RBD.<br>
    <br>
    Hanna<br>
  </body>
</html>

--------------h2YF0FofhTADY1gbF5rywQJC--


