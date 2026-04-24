Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F937FED3CD
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGyK-0003qL-2a; Fri, 24 Apr 2026 09:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGGyH-0003pt-Vr
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:53:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGGyE-0002JM-SL
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777038805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g/wKAagH1dcjZAA5T2bgUBg3cF+5bAJO+s7AkWjtQZM=;
 b=aIg2D4l6ziCy1OHgdpE2ykLC68jZdRz3MrNt3UrMiZsYMmsm3eweXY7hh/ydCJUwtRIsbK
 2KvQH3o1oAYHrMOEvN+KSOkqluTJ+N79H85uY2RQRi9Ff2ZZMjk0Q8KefbAMQfXAhDw4jP
 D6tHfFJiXI41pMAvBYHo23GaJu4zq7U=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-U67iLC_HOiijnf1Z3Fyaug-1; Fri, 24 Apr 2026 09:53:20 -0400
X-MC-Unique: U67iLC_HOiijnf1Z3Fyaug-1
X-Mimecast-MFC-AGG-ID: U67iLC_HOiijnf1Z3Fyaug_1777038800
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50fbc70cfbdso94742451cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777038800; x=1777643600; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g/wKAagH1dcjZAA5T2bgUBg3cF+5bAJO+s7AkWjtQZM=;
 b=cLW/hFgwdMfq/Q6oSR2s0divU+6RKwiWWL1v7ajREV7EazJKaCQkCbM9V7M5lJbvQE
 Q6a3/+Q9BkS64UcCjGDYte//fBeLopPIPqCe4+ewZ1FUOt++kNuO6t2I8SJ0TcGfe9f7
 ek38izVbyBT7ThwGWFWeMcIj2TdrT2xmbrHmbPs3thZR/cfmxjj2EJ6H89hYE5V/q4Rf
 evllm/G2WjqEpGPisNGdzOjyKW5kRbdAb4cCvYSbe0RnsnU60hMyAV7LMOT02RCmDcy7
 U02Z514+Zc8IdCPeB8RTcBnlObTqDbldBc4qtRmP67BM7xa4Q+sIlorwwY2dAImsDszw
 uLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777038800; x=1777643600;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/wKAagH1dcjZAA5T2bgUBg3cF+5bAJO+s7AkWjtQZM=;
 b=dCO0UxkekomOsrV1a5/DhQ6xXvi8X5cLNJB+nOVME3uwSe4xQHmUx8UgTTUOY2Y/XS
 GHVJCJ64Oq9c08H4LWO5E7LUX9mqSCd+nmgcyPzQcn11jxCCvno/jALfctK0v6jxT3hx
 y2VaftvfcDM9Mly8MKuIfiocNJf1Api9LZIgYXYOoWmaDXVDzn9FAfD4HK7oiMPWPjEL
 oQOBvGfqgGm5KOhN9StHK8wFjXkhrGhhcNX3jR95PNPuSTvVf2FWaB+KWQUF5U9VCTGv
 xEa5ebR9qJ3sYPxazF8NhucJBRqGu18MdHSm8xbYcvbz/jzO5Sx02My3EXsZHFB9I8S7
 EPig==
X-Forwarded-Encrypted: i=1;
 AFNElJ+k4qeP+73cs4aEc2ulDkz7u7Xlh4klsbKwQ6nI4fV/t4ON75zm1SOu3sd1L6xVzbqDdXn5kdav8z2/@nongnu.org
X-Gm-Message-State: AOJu0YyyjiOeb0tcz31+ESCptdieMY0Hw8jRyMCbtg/aUZC9j6enXD5C
 DWIzVVjLU4ey4Iy2fxc8cwdV8pkq1aqn3VShxqmZZtKq5RuIyZ4kFGfNVKgwL/3H+9XodBB61HI
 yTnZpj8/OwVgf1ZscpvjmXJYuUY30ecuzTeWB0mX1cHxHuL39bh9P+/lo
X-Gm-Gg: AeBDievZfa0x8MrPcVBWV4NBvkioMtURKpGbiBq0rzqXxNGQvsS/IYCvaZ9Od6kMYa4
 vsJQnMHJtur2EoKL68LmjsgntrJUCj4HUr15KyM4oOnfoI6ffJTjA7sRksl7WjfUjvo5ucQWS4X
 mUjuzEJGbcVIUNw+vJ6baVBpb02mPFfQmsasCTNcW0zWk8ZeJ0xTQN4RNboIeiOIxo97vPNomSf
 qIXY2u2M8raaxlGvlQsW/vRgl0UMvYlHPPAOQS9i4TuDdo3QPBKs5eyRaMmrJuRmEItuI5VXnCV
 LQMNQ1QuvaYvJaEgVa4GLYQz9enbAjuOApN08kTqo+niFAr2rbMmuAw1nFyhx0zV7R1bDZakmzx
 AnBNOiv9R/RY4qdqDBIy5OST/ys8CAYkZxktpz3ijDdqYxocW6JR14gbtuQ==
X-Received: by 2002:ac8:5a90:0:b0:50f:b2e4:ebb with SMTP id
 d75a77b69052e-50fb2e41217mr243960621cf.10.1777038799771; 
 Fri, 24 Apr 2026 06:53:19 -0700 (PDT)
X-Received: by 2002:ac8:5a90:0:b0:50f:b2e4:ebb with SMTP id
 d75a77b69052e-50fb2e41217mr243960141cf.10.1777038799220; 
 Fri, 24 Apr 2026 06:53:19 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e394c1fddsm195883181cf.30.2026.04.24.06.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 06:53:18 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:53:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
Message-ID: <aet1zMrfXzShXeuS@x1.local>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com> <87o6jaeig8.fsf@suse.de>
 <aepFf11lBgdXK6CB@x1.local> <87ik9hee95.fsf@suse.de>
 <aepokJ2N1w7fA2Ye@x1.local> <87fr4lea6k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr4lea6k.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 23, 2026 at 04:41:39PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Apr 23, 2026 at 03:13:42PM -0300, Fabiano Rosas wrote:
> >> Looking again at this argument I put (too many variables), I notice we
> >> also have multifd_send_state->channels_ready and
> >
> > channels_ready seems to be special?  In busy systems I think it should
> > normally always be less than the number of threads on sender side, because
> > some of them will be busy.
> >
> 
> Argh, sorry, I meant channels_created!

Yeah, this one looks like a slight duplicate over channels_ready.  However
it's still slightly different in that it's also used in failure path of
channel establishments.

IOW, multifd_send_channel_created() can be invoked in failure paths where
multifd_channel_connect() won't.

We could still consider reusing channels_ready, but it will introduce a few
complexities, namely:

- The name becomes slightly ambiguous: we may need to listen to
  channels_ready even if the channel creation failed..  if to be fair,
  channels_created also implies a success.. s I assume not a major concern.

- Multifd sender side relies on channels_ready to be posted by default when
  migration just starts (says, "all channels are free to use").  It means
  if we consume that sem here waiting for channels, then we need to kick
  all threads once more just to give it back, hence one more roundtrip of
  sem notifies.  We also need a small touchup in send thread to allow that
  to happen; patch attached at the end to show what I mean (not tested at
  all, please treat it as pesudo code.. so it's definitely not a complete
  patch).

I think we can still leave it there to make the establishment path simple.

What's your take?

===8<===
diff --git a/migration/multifd.c b/migration/multifd.c
index 035cb70f7b..570ff8c017 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -736,16 +736,9 @@ static void *multifd_send_thread(void *opaque)
              * multifd_send().
              */
             qatomic_store_release(&p->pending_job, false);
-        } else {
+        } else if (qatomic_read(&p->pending_sync)) {
             MultiFDSyncReq req = qatomic_read(&p->pending_sync);
 
-            /*
-             * If not a normal job, must be a sync request.  Note that
-             * pending_sync is a standalone flag (unlike pending_job), so
-             * it doesn't require explicit memory barriers.
-             */
-            assert(req != MULTIFD_SYNC_NONE);
-
             /* Only push the SYNC message if it involves a remote sync */
             if (req == MULTIFD_SYNC_ALL) {
                 p->flags = MULTIFD_FLAG_SYNC;
@@ -964,7 +957,14 @@ bool multifd_send_setup(void)
      * past this point.
      */
     for (i = 0; i < thread_count; i++) {
-        qemu_sem_wait(&multifd_send_state->channels_created);
+        MultiFDSendParams *p = &multifd_send_state->params[i];
+
+        qemu_sem_wait(&multifd_send_state->channels_ready);
+        /*
+         * Re-kick the thread to recover the channels_ready event we
+         * consumed for detecting channel establish event.
+         */
+        qemu_sem_post(&p->sem);
     }
 
     if (ret) {

-- 
Peter Xu


