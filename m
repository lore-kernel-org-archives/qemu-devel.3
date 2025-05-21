Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56C8C3DA6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 03:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHZqJ-0002xr-Hq; Tue, 20 May 2025 23:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1uHZqI-0002wi-8u
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:10:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1uHZqF-0004iE-PO
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:10:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso6340663b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 20:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747797002; x=1748401802; darn=nongnu.org;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=aTaEOBfOa+9863R+xJOANtp0b5Hads7Q1Ao6wcJpHn8=;
 b=JBf+r2/8cN5JAI6sdGrvCldgRNOASb0+gacFszfMVS9omv2wBTHVTDr+J3q9mFFFIq
 IkWuu0rpYoDpD3UTdIE3F0r0BJ6riUBM1N7AEY6Ls+TvHUgNtTzYLi95q6MZjW0M61Xc
 zaM033zijOYGZUKdj09Oh/qkjXO72CY6MbOPRLLVubfxSsGnFV3jbT+4rwDmh6PqzaLC
 DyP3zv1rKOcs0+ZaZNM4ovZhb1OfzF5GEtAjfEM6H/xok+njBk5UOKrYZz/Mpsa3ejRt
 M+kYmII+/vdWMKOk8rWGEtR309DqDWqjOauFEjZcYv0R1CuEMTk+sgIHMfC8CJTirE2O
 mXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747797002; x=1748401802;
 h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTaEOBfOa+9863R+xJOANtp0b5Hads7Q1Ao6wcJpHn8=;
 b=DyYKb83EtYuQjhvKqYgV/W+XW8fDnFMSG+daxg5NfuZ8nty4954D4fOWatCpEV3zXg
 BAqKV3jXu0m9Oh7q/yQE6p616HnibjsB07M0hrvB4A6FcL5YNsBfWuIq21P2vCBA7rmn
 XK8sv/PQvdrti09dmbTp/cNOX/BWmGJ+BpxCwAR4EGeQZYExm63Qp6mV8SB+O0H6C8vF
 HGgZpmP+ah5F3HmVX++tR2QY0nSMTvLuj1V4K58Y0W2oS/kCWDL2kOTorj+atIK7z3X8
 ey/u77DGf51u2tXUq/garFcf6/8GF0LnsUL/O3Lat3ylZa7vB24F4lN4+NsJs9WwKioC
 VUug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/XtcjuZjStPOV0PGTZUn+YpgHZebxpKmwDVB342WVDImoIrcwQD7FxYD31UaqoKpq6CV9HE5qY/w/@nongnu.org
X-Gm-Message-State: AOJu0Ywb1PpERUqPJuU/3UCDBX1cfhKR70nxO1ZNDB/cGLnpTnq1k0uK
 Fl/kN3MqhUHVAQFEuMg5ASI/EgayCsk/iVv3lyK4qwddDO5bzqWYJynN
X-Gm-Gg: ASbGncvbEqBZYT/pLvAgQ3vBOPwWxxRumyVMMdNehH3Ra8c+u/tu6maAzRACAQzd+C+
 3tByPGwz9QMq2aHMybPnYEOonusDRE8at+7rU7wwIBwrTGeOyQBTp7ItVmoSYFC1DV+ksVos47U
 3b82fjbgKFNzbp5IDwOz0/TVugSmeEzL+AY0mavEcZG4J4CSDbT0jMUYKoHjDBeWhsyFcVALjeB
 uE/OTU3NxZR54RK0FcqfUyzByfPptzQcpWUWpeHjdubRxwJx5pYeif0DrTZTCn3tAKwEvPVHcLi
 NxK0MPHjm999/muBHCOS9F98nKqwPmPRdgyYupfMGAQyhHyQcXuw0rqzwFkvcysirvhE5VT8AMS
 y
X-Google-Smtp-Source: AGHT+IE/fMvq4Oxumu8XFByNpHZrIT92v1cyReQwtxUswnhyq0ewJwn+jpZov7XxQM42+EtQluEAbg==
X-Received: by 2002:a05:6a00:440b:b0:742:a7a8:4135 with SMTP id
 d2e1a72fcca58-742a98daa4amr31334319b3a.24.1747797001573; 
 Tue, 20 May 2025 20:10:01 -0700 (PDT)
Received: from [10.3.188.223] ([61.213.176.8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970c8a8sm8941139b3a.60.2025.05.20.20.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 20:10:01 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------nhqGEpFEcHvOyp0BkUL0YJ0X"
Message-ID: <506bb92a-1aea-45cc-b74b-040bb38eb82a@gmail.com>
Date: Wed, 21 May 2025 11:09:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] migration/ram: avoid to do log clear in the last round
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Yanfei Xu <yanfei.xu@bytedance.com>, qemu-devel@nongnu.org,
 zhouyibo@bytedance.com
References: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
 <87zff75ch6.fsf@suse.de> <aCznLilrKAn5jkWg@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aCznLilrKAn5jkWg@x1.local>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------nhqGEpFEcHvOyp0BkUL0YJ0X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025/5/21 04:33, Peter Xu wrote:
> On Tue, May 20, 2025 at 04:05:57PM -0300, Fabiano Rosas wrote:
>> Yanfei Xu<yanfei.xu@bytedance.com> writes:
>>
>>> There won't be any ram sync after the stage of save_complete, therefore
>>> it's unnecessary to do manually protect for dirty pages being sent. Skip
>>> to do this in last round can reduce noticeable downtime.
>>>
>>> Signed-off-by: Yanfei Xu<yanfei.xu@bytedance.com>
>>> ---
>>> As I don't have proper machine to test this patch in qemu and verify if it has
>>> risks like in postcopy, colo and so on.(But I tested this idea on my rust VMM,
>>> it works and can reduce ~50ms for a 128GB guest). So I raise the patch with RFC
>>> for suggestions.
>>>
>>>   migration/ram.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/migration/ram.c b/migration/ram.c
>>> index e12913b43e..2b169cdd18 100644
>>> --- a/migration/ram.c
>>> +++ b/migration/ram.c
>>> @@ -838,7 +838,9 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>>>        * the page in the chunk we clear the remote dirty bitmap for all.
>>>        * Clearing it earlier won't be a problem, but too late will.
>>>        */
>>> -    migration_clear_memory_region_dirty_bitmap(rb, page);
>>> +    if (!rs->last_stage) {
>>> +        migration_clear_memory_region_dirty_bitmap(rb, page);
>>> +    }
>>>   
>>>       ret = test_and_clear_bit(page, rb->bmap);
>>>       if (ret) {
>> Well, it looks ok to me and passes all my tests.
>>
>> Tested-by: Fabiano Rosas<farosas@suse.de>
>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
> Thanks both!
>
> I plan to test a bit on this patch later to see how much perf we can get in
> QEMU.  Since it makes perfect sense on its own, queued it for now, and the
> plan is with below comments squashed in.  Let me know if there's comments.
>
> Postcopy unfortunately still cannot benefit much from this change, but I'll
> prepare some patches soon so that this should ideally also work for the
> whole lifecycle of postcopy.  After that done, I am expecting some further
> page fault latency reduction with this change.

Thanks for Fabiano's test and Peter's elaboration in comments.

Look foward to the performance data.

Regards, Yanfei

> diff --git a/migration/ram.c b/migration/ram.c
> index db70699f95..fd8d83b63c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -831,14 +831,20 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>       bool ret;
>   
>       /*
> -     * Clear dirty bitmap if needed.  This _must_ be called before we
> -     * send any of the page in the chunk because we need to make sure
> -     * we can capture further page content changes when we sync dirty
> -     * log the next time.  So as long as we are going to send any of
> -     * the page in the chunk we clear the remote dirty bitmap for all.
> -     * Clearing it earlier won't be a problem, but too late will.
> +     * During the last stage (after source VM stopped), resetting the write
> +     * protections isn't needed as we know there will be either (1) no
> +     * further writes if migration will complete, or (2) migration fails
> +     * at last then tracking isn't needed either.
>        */
>       if (!rs->last_stage) {
> +        /*
> +         * Clear dirty bitmap if needed.  This _must_ be called before we
> +         * send any of the page in the chunk because we need to make sure
> +         * we can capture further page content changes when we sync dirty
> +         * log the next time.  So as long as we are going to send any of
> +         * the page in the chunk we clear the remote dirty bitmap for all.
> +         * Clearing it earlier won't be a problem, but too late will.
> +         */
>           migration_clear_memory_region_dirty_bitmap(rb, page);
>       }
>
--------------nhqGEpFEcHvOyp0BkUL0YJ0X
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025/5/21 04:33, Peter Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:aCznLilrKAn5jkWg@x1.local">
      <pre wrap="" class="moz-quote-pre">On Tue, May 20, 2025 at 04:05:57PM -0300, Fabiano Rosas wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Yanfei Xu <a class="moz-txt-link-rfc2396E" href="mailto:yanfei.xu@bytedance.com">&lt;yanfei.xu@bytedance.com&gt;</a> writes:

</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">There won't be any ram sync after the stage of save_complete, therefore
it's unnecessary to do manually protect for dirty pages being sent. Skip
to do this in last round can reduce noticeable downtime.

Signed-off-by: Yanfei Xu <a class="moz-txt-link-rfc2396E" href="mailto:yanfei.xu@bytedance.com">&lt;yanfei.xu@bytedance.com&gt;</a>
---
As I don't have proper machine to test this patch in qemu and verify if it has
risks like in postcopy, colo and so on.(But I tested this idea on my rust VMM,
it works and can reduce ~50ms for a 128GB guest). So I raise the patch with RFC
for suggestions.

 migration/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index e12913b43e..2b169cdd18 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -838,7 +838,9 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      * the page in the chunk we clear the remote dirty bitmap for all.
      * Clearing it earlier won't be a problem, but too late will.
      */
-    migration_clear_memory_region_dirty_bitmap(rb, page);
+    if (!rs-&gt;last_stage) {
+        migration_clear_memory_region_dirty_bitmap(rb, page);
+    }
 
     ret = test_and_clear_bit(page, rb-&gt;bmap);
     if (ret) {
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Well, it looks ok to me and passes all my tests.

Tested-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
Reviewed-by: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Thanks both!

I plan to test a bit on this patch later to see how much perf we can get in
QEMU.  Since it makes perfect sense on its own, queued it for now, and the
plan is with below comments squashed in.  Let me know if there's comments.

Postcopy unfortunately still cannot benefit much from this change, but I'll
prepare some patches soon so that this should ideally also work for the
whole lifecycle of postcopy.  After that done, I am expecting some further
page fault latency reduction with this change.
</pre>
    </blockquote>
    <p><font face="monospace">Thanks for <span
        style="white-space: pre-wrap">Fabiano's test and Peter's elaboration in comments.</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">Look foward to the performance data.</span></font></p>
    <p><font face="monospace"><span style="white-space: pre-wrap">Regards,
Yanfei 
</span></font></p>
    <blockquote type="cite" cite="mid:aCznLilrKAn5jkWg@x1.local">
      <pre wrap="" class="moz-quote-pre">
diff --git a/migration/ram.c b/migration/ram.c
index db70699f95..fd8d83b63c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -831,14 +831,20 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     bool ret;
 
     /*
-     * Clear dirty bitmap if needed.  This _must_ be called before we
-     * send any of the page in the chunk because we need to make sure
-     * we can capture further page content changes when we sync dirty
-     * log the next time.  So as long as we are going to send any of
-     * the page in the chunk we clear the remote dirty bitmap for all.
-     * Clearing it earlier won't be a problem, but too late will.
+     * During the last stage (after source VM stopped), resetting the write
+     * protections isn't needed as we know there will be either (1) no
+     * further writes if migration will complete, or (2) migration fails
+     * at last then tracking isn't needed either.
      */
     if (!rs-&gt;last_stage) {
+        /*
+         * Clear dirty bitmap if needed.  This _must_ be called before we
+         * send any of the page in the chunk because we need to make sure
+         * we can capture further page content changes when we sync dirty
+         * log the next time.  So as long as we are going to send any of
+         * the page in the chunk we clear the remote dirty bitmap for all.
+         * Clearing it earlier won't be a problem, but too late will.
+         */
         migration_clear_memory_region_dirty_bitmap(rb, page);
     }

</pre>
    </blockquote>
  </body>
</html>

--------------nhqGEpFEcHvOyp0BkUL0YJ0X--

