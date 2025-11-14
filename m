Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E6BCE8D49
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvwB-0004y4-9R; Fri, 14 Nov 2025 10:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJvlC-0006JB-F9
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:30:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJvl9-0007oa-LK
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763134241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TmknJCZrc9DY/f44OvYULegMzpz4ssCah9OyrbLp8TY=;
 b=f1b5T5zQApkb2roXM62qCuNeUgV3TbEFWvGkYekaFSdbPKGbCG0XTwLy2jPtyt+OY8l++f
 gye1tgjKcXArOdnquHmXIVp8YyvoeW7AWOhRD6luV/YX014f3ioWYYhpRnkQzMb5DhKNfH
 nP8PqTxnNz07yop1/9fG47zaI33Zig4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256--SdHeuJGORKBsuNNd4468w-1; Fri, 14 Nov 2025 10:30:38 -0500
X-MC-Unique: -SdHeuJGORKBsuNNd4468w-1
X-Mimecast-MFC-AGG-ID: -SdHeuJGORKBsuNNd4468w_1763134237
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4edad305681so47500601cf.3
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763134237; x=1763739037; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TmknJCZrc9DY/f44OvYULegMzpz4ssCah9OyrbLp8TY=;
 b=QsES3J7GF0Ov/QaROBkFtx2lLvnWFBKmJVlkllLCyYCTADB+dMp9+b8QqijUais2Pm
 OaRHQyjpwCJvKLW7vTSWVDOPgNuz5CLyIs/tNKuaGkQvm9MLd9+B2imESSBDJYvcczyz
 YR3AMe+PaVg7oagaZBpBKvOM07t3t6Dyz5+4IvhV01I9Hxzs5hZSANv7cP5PGeuNFEl3
 txDhXM9MIb8oPZq1MYhJEbOVWHyF9xNj4+LmY3Do+/6BoLa55MT4PVImFuOGQjkIYTEa
 YMy+o4n4foVk2keEuCvd9QUaMeX4Cn2sW/TCvm9GbG8S+bcg8WvKbmbjQsepHUr1erD1
 MylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763134237; x=1763739037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmknJCZrc9DY/f44OvYULegMzpz4ssCah9OyrbLp8TY=;
 b=HNSBYlSvL6Be7OlXANhMj3UePTHoGMDyheShU+jHa30fgrcHz1SDvMh8HsRQnVCnqP
 xxzxLue8Shau7uEtxPHXwrpojdtSQkAOhU3MNJrtOw2iXsr4Aam3P3x7xQiSDKKzaAEH
 beDEvHIBGBrMw9qKqyEp+/x/Mc6pF1FdqMdZ1BUkZchrFKB6HY32hLPZKwUjkphjr7PU
 JR1fj7KnC+OOQXPTlGnoOzZ3wwUU3Mchy9ZJF7AjkWq2REvcflPrJDEGnj75oKdDuCVT
 WZwyVUDd3Kv5TYXZJ2uXkVDTHbiJyrtTiIXwx7XGxj34sB+Uu57+2O4GP13rErqfdSvn
 8dnw==
X-Gm-Message-State: AOJu0YwNSnt7NYgqzSTxezpB5Zn9ZOBGyDSHupLbQm4ZEzLnvpamrFfm
 rq22eY0kQNMSPao1hzBk22rJ97PMTVjDW3BK0Gi6k3L8FhTY7WqQbFhMqq/slRZhQ1TiOftizUe
 gOH6pCbK6cO7E/N3gjOutk+U4kmjjdlHMcw+tQAxsxnfNzVpAaNt+PPa8
X-Gm-Gg: ASbGncsBq14G/h7j94Ebp56Jjd5iSaIiREAH88hGtQbZLhuqYG3NQxNMRl8FKB9AlH2
 F9aGiaZYJOIdo01fte3b2KESAx8W4thm+/TVbRDqVDt0DVt8C5kHYyWpA/SURbWXERVmQJn0Rij
 Qmsi8vThs9WhOII6/yXb6r11Nk18/yHz8JnF4nPDOLJwE1lan81VtUUqw2Nmhvr5uofhVatc5SB
 fJMXX6Nd7pQIMJWfQx8IBejrvKnVKad/t8FPuRgvNUEzn1VUTNd6rRCKbhlJAS8FNmlyaFwtyGg
 YPOd2S8SS/pMUiLYTSnuhqbsSC/ShLOxSQzp+/HJxohkqMNJ3zx7uSnpLdOfp599YJygNra3gEN
 RMQ==
X-Received: by 2002:a05:622a:13ca:b0:4ed:dfd6:ec44 with SMTP id
 d75a77b69052e-4edf217781fmr47347541cf.78.1763134237162; 
 Fri, 14 Nov 2025 07:30:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLcDDhAloLfEsIX7rHurLwGRqNDhBrE3xdNx266+HFbvXXtUu/L7AoWeocnu5+tN6LUG+yyA==
X-Received: by 2002:a05:622a:13ca:b0:4ed:dfd6:ec44 with SMTP id
 d75a77b69052e-4edf217781fmr47346801cf.78.1763134236628; 
 Fri, 14 Nov 2025 07:30:36 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ede87eed39sm30044571cf.24.2025.11.14.07.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:30:36 -0800 (PST)
Date: Fri, 14 Nov 2025 10:30:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 4/5] rcu: Wake the RCU thread when draining
Message-ID: <aRdLFwxzJwjsXFpY@x1.local>
References: <aQJbd5qYR10qcbr7@x1.local>
 <38c07d37-1b4d-42d2-ab41-fbe1c860dd3b@rsg.ci.i.u-tokyo.ac.jp>
 <aQu2_izqViAbJ3A9@x1.local>
 <b419584d-f1af-4c05-81a6-35f533e8ff37@rsg.ci.i.u-tokyo.ac.jp>
 <aQ0Ys09WtlSPoapm@x1.local>
 <5279f15f-bf46-438e-9c1f-0873b08b59e7@rsg.ci.i.u-tokyo.ac.jp>
 <aQ37hd0fVJltYtt-@x1.local>
 <5002e5b4-0493-4dff-af11-402cebecbcc2@rsg.ci.i.u-tokyo.ac.jp>
 <aRYPXh_9m5ZvTi2w@x1.local>
 <ded7ef38-8c99-4d37-87b2-2f5ba1dc93fc@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ded7ef38-8c99-4d37-87b2-2f5ba1dc93fc@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 14, 2025 at 10:24:40AM +0900, Akihiko Odaki wrote:
> However it creates another problem. Think of the following sequence:
> 
> call_rcu_thread()              |
>                                | call_rcu1()
>                                |  qatomic_fetch_inc(&rcu_call_count)
>                                |  qemu_sem_post(&sync_event)
>                                |
>  qatomic_read(&rcu_call_count) |
>  enter_qs(false)               |
>   wait_for_readers(false)      |
>    qemu_sem_timedwait(         |
>     &sync_event, 10)           |
> 
> qemu_sem_timedwait() incorrectly interrupts the RCU thread and enters the
> force quiescent state.

First thing to mention is, IIUC above can't happen because if
call_rcu_thread() is already waked up and reaching enter_qs(), then there
should have been, for example, a prior call_rcu1() that incremented
rcu_call_count and posted to sync_event, hence rcu_call_count cannot be 0
anymore in the call_rcu1() above, because the sub happens later:

call_rcu_thread:
        ... sees rcu_call_count > 0, quit loop ...
        ...
        enter_qs(sleep);
        qatomic_sub(&rcu_call_count, n); <-------------------------
        ...

That means the concurrent call_rcu1() above will not post sem anymore
because it will only post it if rcu_call_count==0.

Besides, IMHO replacing the event with sem shouldn't change similar
behavior comparing to when using events.  Because any spot that can post()
concurrently can also does qemu_event_set() concurrently... after all, we
only have a few spots resettting the event in the original patch, after the
reset a concurrent qemu_event_set() will re-activate it.

Sem does introduce possible false positives on events, but as I was trying
to justify, a generic VM boots and shutdown should need less than 1000 rcu
calls, so worst case is we loop read rcu_call_count 1000 times... I also
didn't measure how many of such call_rcu1() will see N>0 so they'll not
post() to sem at all, I believe it'll be common.  So the perf overhead
should really be rare, IMHO.

Note that I was not requesting you to replace this event to sem before
merging.  Frankly, I think your work is good enough to land.

However I still want to discuss a sem replacement, not only because this is
the best place to discuss it (after all, force rcu starts to introduce a
genuine second user of the event besides call_rcu1, hence the "being able
to remember more than 1" will start to make more sense than avoid resets),
it looks also cleaner to remove some new code force rcu adds.

When reviewing I found it also hard to justify qemu_event_reset() are
proper all over the places.  Sem will remove that problem.  So at least to
me, if you agree with using sem is better, it'll at least make me more
confident to ack the series (not that merging needs my ack.. but I do feel
more uncertain when the event needs explicit resets).  OTOH, false positive
causes some loops in rcu thread which looks much safer even if happens
(however in reality, I think sem shouldn't be more than 2).

Thanks,

-- 
Peter Xu


