Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651B4CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsWJ-0006Ta-Ia; Wed, 03 Jun 2026 16:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUsWF-0006TI-Pb
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:48:55 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUsWE-00038v-8H
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:48:55 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68ad1e513d3so11375055a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780519732; cv=none;
 d=google.com; s=arc-20240605;
 b=Ms28Lj2DAw2eSQPDgAe1pEEB5hfLmnrlb913Y/4tjH2pCqg4un0Q/0QTFOAFQLgoKx
 q1Cc9vh6j5xYZh35QCg5vC+rHDMlx3eGGDwoDNKeIJ3twJpgaTFTOdOUZu4BayxCEz8D
 Qwg1GNCmNfoGuLGCNTy+9jaw78PfHg078p4GsNVrUR4DSRDH0a3TJpdUSw/letAt7LK7
 F4AwJxe1oQN+Pzf92jRV6VhbvA/hp7RKSvYjO9LUwlYrDqpSpGJfL+EDXzTKWjPwVC6m
 ndV9t5qdEUk8fVo7N3R6tgiBNa+eouAI9gk4gwSc81QnAtlPALFMNhnnzs9kYos0tM6u
 EB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B1hRzIwbw6umXYoi4Z9yNSpbx0uoevh2QaSDpvdqXU4=;
 fh=XVN1mmQlwmC7aCY31oVKufP+AuL5701qY9osQkmPEMk=;
 b=HZOt5YXs2fotKTkOtclHkcZIKbGd9OklhMpZgdZHji3ew+LbYTvJe9WxzS8h5YI2YO
 28CemCWlTVn5t7N9+5kXRz2BGoh5QGBe8209Fj4GCx0yGwcDsJ/Waz8ssGR2kXcgQNgd
 FmfwXWnojgm6fMUWCoPG6rNbmg31fSm99s4+CPAO7g/GdcMEvlwr1VyUgI897La+BPG9
 qsT5znHgkz2eeSUMKvcRso4naTPWWxNjlrYM2Zg8mcVGh29wMELRhkbbIY7GNXHHSFGK
 qlZrIpoTBHAGoqfRSQ1fWy6O/bcirvYVHHDWkPFosNHzz5ZLpLmq2IjLnEdAkJ8Z9HLl
 U6MQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780519732; x=1781124532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1hRzIwbw6umXYoi4Z9yNSpbx0uoevh2QaSDpvdqXU4=;
 b=PgluSUfZIsg9hLIEpJyh4gBFvPoQBPb1eTZwYjj6B/KDPWNHD+g8ojqx4JXpaq0216
 n64902XX8kXUu/7CxSknWbMqun3tT9MdUFoPFeDi7zXw8y0SsTRRPoJkj8q69aYkHLr9
 wViyDXzSlsDUyrEytO/RTgwLyqnxL5Tu3PgcuaiOp7JyP7MimH4Y9l1Qd8B4DCdiEggk
 ofTAIyQXbIQw5/fbW+uZR6lvt7pPcypaJrVRdd7viMb6SnFik6sNWYRY4CapD76So7K+
 ooq2lRhPJyD4V2HgXIkiUlwH5/fdYVblARLRmOr/Xcic449kybjV4AerWYW4CgvI+ary
 DU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519732; x=1781124532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1hRzIwbw6umXYoi4Z9yNSpbx0uoevh2QaSDpvdqXU4=;
 b=ioJH45/R4/nuP/ekVCuzCkhGej+wRbLG+O/44cW+wZmv4fVov2QKIMRhzm/FmyAgni
 mOEhJVC5TPoTp/5HNQ0XHYcebZafM6qEvHSYKfiAXd5lKtkH3dBad2Jd2ANMVbGSKiF/
 JGWlAXnXa7QB4az+xB5s91gPl4vK+pCo7yqEdf4FR48aGeoSbObCbxg9kvKIEvjpuhB0
 1GhJ4mR/rCOtjV4ZkciGnzZyx627csCQfeGkG3p0bmnzV5OanBMkpZwyBc0+vOHFKX1c
 zzqhFfeyTp58VfFmKa0tH0rh36h1AIb8Je0thxTp7l1Sf7owLGj8kaTwjWHDUtWx9UtG
 DRoQ==
X-Gm-Message-State: AOJu0YwFcFtdMA89LcMvNvF2ZN5i+HIHMpaipff7dVr8UDTGPD4deLrz
 IZ751m8c9KsDSjqrKUXfCGKIe9XeJumrBM4f0Fa9VvnBjpxUI+B09d8n/V3tw8kgHWhH08mBmZ4
 QaQSvDCV1mF2MdhPkfplprPwTI/PfdGQ=
X-Gm-Gg: Acq92OGCUaCP8O9GqYt0HANNr18kwDOsMAdDNHz/Wv/0j8kj4HfuhZspko3Gh/f9IRU
 aU83kBPO2qMW+KuUPfj3/4U27w2OJb3nCC+W7N9JGbWy3OVzHp/m/5+Kx++D4Txn+61uY1kixqD
 9YuU7cNOlIGIXNfysEZpQ9X2pH+FnxCOE1T86JFU0w4ZuLWivUjCTgjDAhlMlPZ8AGWAHapDUMo
 secjypi1MHHo6tbv42MR1l9Ofe5MjKqjjDvSUETqqPdJv4LBzhimQWFPndqmK8wqoHPKsJXgtxo
 SSMdnLEM4JGFwXR0DbQqqR04Aa76SgKS8D0+N3cQvYHUfZ37Mls3
X-Received: by 2002:a05:6402:ea2:b0:687:285d:44a3 with SMTP id
 4fb4d7f45d1cf-68e710eb761mr2581081a12.15.1780519732379; Wed, 03 Jun 2026
 13:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260603193813.2327596-1-farosas@suse.de>
In-Reply-To: <20260603193813.2327596-1-farosas@suse.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 3 Jun 2026 16:48:38 -0400
X-Gm-Features: AVHnY4K6SvHrcL6Uiho8lDaKfrddmoRPLEU-wrxzL4mNHgJIYS4vIhrPLngzSOw
Message-ID: <CAJSP0QU+6yU+dwEdeei5nqTBMmBD0b4QJ+y-jeNNrmXzu8ChvQ@mail.gmail.com>
Subject: Re: [PATCH v2] qed: Don't try to flush during incoming migration
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Jun 3, 2026 at 3:39=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> It's not possible to access the image file while there is an incoming
> migration in progress, the QEMU process doesn't hold any locks to the
> storage at this point so nodes are inactive. Attempting to flush leads
> to an assert at bdrv_co_write_req_prepare():
>
>    assert(!(bs->open_flags & BDRV_O_INACTIVE))
>
> The issue is reproducible by running iotest 181 on a host under cpu
> load. The migration must coincide with the header already containing
> the QED_F_NEED_CHECK flag.
>
> The sequence of events is as follows, with the respective call stacks
> referenced below:
>
> During block device init, bdrv_qed_attach_aio_context() starts the
> 'need_check' timer. The timer will not fire during incoming migration
> as it uses QEMU_CLOCK_VIRTUAL (to avoid this very issue, as the code
> comment indicates).                                                   (0)
>
> However, there's still bdrv_qed_drain_begin() which uses the fact that
> the timer is live to decide whether to start the
> qed_need_check_timer_entry() directly.                                (1)
>
> The qed_need_check_timer_entry() eventually calls into
> qed_write_header() -> bdrv_co_pwrite() leading to the assert.         (2)
>
> Skip creating the 'need_check' timer whenever the image is inactive.

I was concerned that some parts of the code might call
qed_start_need_check_timer() or qed_cancel_need_check_timer() without
checking s->need_check_timer !=3D NULL. However, it only happens in the
write code path, which is not taken when BDRV_O_INACTIVE is set (see
bdrv_co_write_req_prepare()'s assert(!(bs->open_flags &
BDRV_O_INACTIVE))). So this patch looks good.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

