Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE19FA1FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaK7-000360-Eu; Wed, 22 Apr 2026 12:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFaK6-00035E-9T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFaK4-0000QL-AH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776874867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D3oZ+nvxWZxC+L1bBsE3B1EU3wg6dfaeSq3qR93WOyk=;
 b=YxbpbiYXkHWjsW+ayvba/kht741+yZuqAGb0SywiOvV/GFbVKMNrRx5Dr+Em+ueoiv+pym
 jd2HTlrIurjF7PDDCTSaQ6Zrf3vWIF003B/P/vZYbbF/rItxTVefCpWarI1r/m+mVd6VeS
 mF6dfgx7ioLWzpEGaIGz/HV71UelVt8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-0YbGGXqhPq22ucQQ96TtIg-1; Wed, 22 Apr 2026 12:21:04 -0400
X-MC-Unique: 0YbGGXqhPq22ucQQ96TtIg-1
X-Mimecast-MFC-AGG-ID: 0YbGGXqhPq22ucQQ96TtIg_1776874864
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8acadca1ac4so165862176d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776874864; x=1777479664; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D3oZ+nvxWZxC+L1bBsE3B1EU3wg6dfaeSq3qR93WOyk=;
 b=KJTQktGRpwTnOeNsueISKJpI9soaamMEWx6EkNBEKJOnZ7ol5fX0neiJ+NS7jGjV+n
 9iDJ3IfCi8PrFxHR3wsChqI+9mlezEPehgy+K6hyGNCxNidYbIGbsMFv/u2ALyuC17lP
 GhPpxsX3V9jm66htBhIrHYAtDny/V1av7s6LDdsV31Jg55fc6gethgZaBrokMzxHUifW
 J5TCow1G2FPctDODH8KypbHpMXOuNS/ZXDCzuJ4rg4glp3kLfTA93lx8Gg7A5/itWMvY
 6JfnmM5NeYWYxyMSQXGLwkZujfeRcirRohvBQ4aujavDAqoEwKuvAtxiqGkZR/goSzEX
 TQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776874864; x=1777479664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3oZ+nvxWZxC+L1bBsE3B1EU3wg6dfaeSq3qR93WOyk=;
 b=BmIv3/FUA80S6r54+L4NueQ8DJzsMKEgSFER36WpPzb7FyxKFnCFvJGwywlBdzoVKV
 SL+zuA1idQ3s5cc6Veizv/lzsRv1ZN4pli0tU+e7U6g0Alwx0DnMAVUO/G9CRDuOfKjE
 6b5axOUT+fDVeiGGkGAWYgNe/p/+lV/duwRhIa9SPjXKVC+M+eFdoQq2S8XC4kfX1KOJ
 2M+53JfKZPUzfGw7zM/1y/d0qnMJIg2EbxTiaIirw4Pe6X9+Mxb49yet6bYq5xcCQ4ku
 HAt2We7qeI/0dXNc5CpEveaDN6wHM9D8sZE9tFObwFT4/HFFBMR6P5NjTrWZ2zZazrQp
 C8mA==
X-Gm-Message-State: AOJu0YwipxfMKMPM4s/tR/bHyAAAVBTBTeeYL9G+nwnkTmE89zwIlywU
 ypv/wwW4x7ttpBOp0cIoy0MsobjH74Da8hlCkKXiZrEjjBSt09NaoGMV2NeJqOGBTuwsAs4uDDd
 IqwXYwdz5U8SQrToN7+k8cpCqGeop75iS1hNI8iWoYGt1p+JMb81vebgO
X-Gm-Gg: AeBDiesRiVHqYlXf+WA4NtkIaEORAewn/VHpmtmQ1hFngGI1gGbHiLA99RuwzkOeGrr
 E2faiCWNvPTHF3McyVrviqDwUra3WlBJL7XwPervbpAr2f/qfpW5z/r5YLRM4Rluc6PjfxJ6hRI
 +pwA4aqjCEKEdULClvSowxZoFKcfrUQqlP4b+7AzvHAPAOnY9wkuc0ChGcv72U8c6ynJkWVg+OX
 UGm8ybA0UXZrLnspVz2Bb5AzZLt+LVajzNhm8lylqFh3DEJ5cri/f/6TU/kQ0kbn4XrjHgXN+ZR
 S6ObBgJyspjBA7r4o5pdCzv1xQe4kmF4Ga7MtvrAN87FsXg8vqmjzKfdJX57TmckNk3rduYbHpz
 NG8e115VktC+nU9Hzz5mX5IF5x6q/0UqXRW+eRZh9YTr0BQV98rCOQi00cw==
X-Received: by 2002:a05:6214:226c:b0:8a6:1216:fb6f with SMTP id
 6a1803df08f44-8b0280ef2ecmr362950966d6.32.1776874863495; 
 Wed, 22 Apr 2026 09:21:03 -0700 (PDT)
X-Received: by 2002:a05:6214:226c:b0:8a6:1216:fb6f with SMTP id
 6a1803df08f44-8b0280ef2ecmr362950136d6.32.1776874862822; 
 Wed, 22 Apr 2026 09:21:02 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac6f670sm161996986d6.14.2026.04.22.09.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 09:21:01 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:21:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration/vmstate: replace NULL pointer assert with
 proper error
Message-ID: <aej1bZlPKPuhT32C@x1.local>
References: <20260421155219.14506-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421155219.14506-1-viking4@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 21, 2026 at 10:52:19PM +0700, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> vmstate_load_state() contains an assert added in commit
> ("migration/vmstate: split up vmstate_base_addr" [1])
> to catch NULL pointer dereferences early:
> 
>   assert(first_elem || !n_elems || !size);
> 
> However, the assert fires as an unrecoverable crash in a valid user
> scenario, for instance: loading a snapshot saved with -icount auto
> into a QEMU started without -icount. The "timer/icount/warp_timer"
> subsection is present in the stream, but icount_warp_timer is NULL
> because icount was never initialized. QEMU aborts with:
> 
>   qemu-system-x86_64: ../migration/vmstate.c:185:
>   vmstate_load_state: Assertion `first_elem || !n_elems || !size'
>   failed.
> 
> Replace the assert with a proper error_setg() and -EINVAL return so
> QEMU reports a clear diagnostic instead of crashing.
> 
> Also remove the error_prepend() in vmstate_subsection_load() that
> wrapped the error at each subsection level, producing a redundant and
> noisy error chain. The original error message is now propagated as-is.
> 
> [1] https://lore.kernel.org/qemu-devel/20170228124056.5074-4-dgilbert@redhat.com/
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2736
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
> Steps to reproduce:
> * 1. Start src with icount config:
> ./qemu-system-x86_64 \
>   -icount auto \
>   -<other_options>
> 
> * 2. Save snapshot
> (qemu) savevm snap1
> 
> * 3. Start dest without icount config:
> ./qemu-system-x86_64 \
>   -<other_options>
> 
> * 4. Load snapshot
> * As-is:
> ~ # QEMU 10.2.94 monitor - type 'help' for more information
> (qemu) loadvm snap1
> qemu-system-x86_64: ../migration/vmstate.c:185: vmstate_load_state:
> Assertion `first_elem || !n_elems || !size' failed.
> Aborted (core dumped)
> 
> * To-be:
> ** Before removing error_prepend()
> ~ # QEMU 10.2.94 monitor - type 'help' for more information
> (qemu) loadvm snap1
> Error: error while loading state for instance 0x0 of device 'timer':
> Loading VM subsection 'timer/icount' in 'timer' failed: -22:
> Loading VM subsection 'timer/icount/warp_timer' in 'timer/icount' failed: -22:
> VM load of device 'timer/icount/warp_timer': field 'icount_warp_timer'
> is a NULL pointer but snapshot contains data for it.
> 
> ** After removing error_prepend()
> ~ # QEMU 10.2.94 monitor - type 'help' for more information
> (qemu) loadvm snap1
> Error: error while loading state for instance 0x0 of device 'timer':
> VM load of device 'timer/icount/warp_timer': field 'icount_warp_timer'
> is a NULL pointer but snapshot contains data for it.

Thanks again for help looking into QEMU opened issues, Trieu.

I had a feeling the user was requesting for successful migrations with
modified -icount parameters, rather than a prettier failure.  In that case
this patch won't be enough.

I've added a comment in the issue to check with reporter.  If we need that
feature, we may want to check with TCG developers on whether it'll work
out.

PS: we shouldn't mention "snapshot" in the error message, because it can
also be a live migration that triggers this path.

Thanks,

-- 
Peter Xu


