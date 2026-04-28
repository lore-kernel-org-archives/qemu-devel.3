Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9840FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHkV8-0004d6-7U; Tue, 28 Apr 2026 11:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wHkV3-0004Zp-MD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:37:26 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wHkV1-0007Mk-CG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:37:25 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6720c7968e4so11030541a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 08:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777390640; cv=none;
 d=google.com; s=arc-20240605;
 b=Ms0xWryRm8hzMRAfRG8yurgTD6RLHzjFcBa4jk6/DvIXUfvVtvDG9a+tCHgPV91Rfe
 JBRRK9M2s2tkUHFV8uBwLChfdg2srh/cjm2Rxia6tIivH0dGUsGzP7sxnpqT7DUDSl6F
 c619sUlMD/qbtT54QPHcY0Xl9NnX1vYadsCTeKlxis7rF8wLBdWe2X13wxic1l9u0dih
 NXEvr8Z6InwZwKqy7MqDyIVK9IeGmGbwOZFOdqGN+GKts+EPWIFvuX51+PN/fa+Ebtto
 ppLgyPDjTtNdwbZufy/lg6tlWdIbEBSjuYBT2qHJct94I7/wNLXQCfYYy8u6fJm3SZoK
 m0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dAMXJ68P/Fmr/eSgpxBl6oh1+uHcn8WNIX2TNcymLmM=;
 fh=D9CzFiLxr3Y70oAa1ZIwt3HUZNzfcjTOYmZrFFoRx/A=;
 b=bT4Sg0k3XaiPXYpKkKIjA3fqARZ3yXgiKFtumP4wTA3yEPedxtNpH5SoFwFGKbiWYy
 f1R+pYsXQ0KTvS3m48m5N3x6g+75rLBD4mOp6DMK8KOSjjHhwJOh36TDMKjhcQL9AkeO
 etDR1yhyRohjfyYWwseO5kKSFxwPzek/GZKZpLgMP6AwxCvhOnYKQBQhP6rCEd2IB34w
 WMnh57YICphoEWJ05gzSuCojxDeweKrIKO4MOkcYaCUTnIAKUrpFY0FJKbErWY74xw0u
 s/Z5khVr3yi8vi/u2wy0TUU8czrmLldy1+RhVP+P/EeNApk+TIV9svJR4CNlx7rvaVQz
 Mrpw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1777390640; x=1777995440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dAMXJ68P/Fmr/eSgpxBl6oh1+uHcn8WNIX2TNcymLmM=;
 b=DFZq+L3syG693ABynbhe7WOVXNsgY8D8PK6Fxxd/UyrZUcHJwhumG0ELrRN3PT4tVW
 Tp0P4RGNiTSOBmK7wiZ+osiPP2eDucyfx4csnnf4IOHos771tfcfR6dCgto2sCWEAZpn
 pGgsrxYDn6bP2ywpJCzZPweSxy6Ifirp3+ZYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777390640; x=1777995440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dAMXJ68P/Fmr/eSgpxBl6oh1+uHcn8WNIX2TNcymLmM=;
 b=mh4JAfwQ/PzheZZk0RI0SadUQAkuDv2LGXl8uTvT+NS3TUvlaGhK2jX3BLN8yS24Wv
 P+9g4f7QNs9kWTdghGXy6zinryy1A0i+zVNAbvwqqxIOKpTQPXGr6NZd/+Egvl0MptUw
 LKzE6yCloAWOvk6L1YZfMOU0VsgDlpQ/6YqIM44fKV2IJcSdnfR9EK9nLHRJCcK2LLkb
 Qa3B6z1wCgUTyMuV+4dYY4w9IkjHO9X7m7EnB70CVDS7iNoWJ4eascR/dbkdD1EqjLEL
 Nv6Qsc9DeeYbmJ87ZsW9UArkDu2Ox4tteFvrxTyPDK0b8DPoO5t/c5wTCeD81BMGyT24
 y+7g==
X-Gm-Message-State: AOJu0YxT2HolS/9y77pet6OYKBdkJeH4dJ9O0Zu+pw/cYBUDdgTxgwEN
 lEyBsiWTtLolyMVHZWM0Z1LvLAlnTSOlwlpPnI+oJx+EgABOjoLb+dT2pkUpNcVmh/3g/++T6XV
 rAItlxW1scLl1mAK8l27pkc98+xjYjB7ji7oe9LLfTQ==
X-Gm-Gg: AeBDietbdYEZ2tAxoMCZE3iZis6K7DbgExgp77B3YGG9u6A2TjTpAjAqM3u4eN77Y55
 6vk2ylcJwva1RXk9f4VZMIEfi3n4GmwoScR/D4L0x8+p0LNzBDYgiAPYB9BCNPlKNIdnLn1ylVF
 BMU4/YKHIZQyg2+9uPqMor1Jt4D9uTaw9wSkOEowCrTs5ivUqZvJQFsoWBP6UmawBDlbFWwNoj3
 DNfrBRz5+HUyRCla8QK5Vadx4NgA3vVG6ktLZNUZkngbSoWmhNjv/y5eJhjtTaz32B/w7Ceypoy
 oZx5CWEHeUHNwMj3Ww==
X-Received: by 2002:aa7:d7d3:0:b0:66e:103b:6350 with SMTP id
 4fb4d7f45d1cf-679ba673a34mr1186696a12.7.1777390639553; Tue, 28 Apr 2026
 08:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-7-alexander@mihalicyn.com>
 <20260427210343.GG218226@fedora>
In-Reply-To: <20260427210343.GG218226@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 28 Apr 2026 17:38:35 +0200
X-Gm-Features: AVHnY4JngLdSEg1YepzbUkKR8jT0olgn76cX1QR0IXGSjrFZWIXcZYvEdJHKuPE
Message-ID: <CAJqdLroo5_2J3QmyXOrMXf8htn9cw7j+=Ye_cnwPGhOZ8bQ=8A@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] hw/nvme: add basic live migration support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 Fabiano Rosas <farosas@suse.de>, 
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am Mo., 27. Apr. 2026 um 23:03 Uhr schrieb Stefan Hajnoczi
<stefanha@redhat.com>:
>
> On Sun, Apr 19, 2026 at 03:01:37PM +0200, Alexander Mikhalitsyn wrote:
> > @@ -4903,6 +4916,25 @@ static void nvme_init_sq(NvmeSQueue *sq, NvmeCtrl *n, uint64_t dma_addr,
> >      __nvme_init_sq(sq);
> >  }
> >
> > +static void nvme_restore_sq(NvmeSQueue *sq_from)
> > +{
> > +    NvmeCtrl *n = sq_from->ctrl;
> > +    NvmeSQueue *sq = sq_from;
> > +
> > +    if (sq_from->sqid == 0) {
> > +        sq = &n->admin_sq;
>
> docs/devel/migration/main.rst says:
>
>   - The destination should treat an incoming migration stream as hostile
>     (which we do to varying degrees in the existing code).  Check that offsets
>     into buffers and the like can't cause overruns.  Fail the incoming migration
>     in the case of a corrupted stream like this.

Hi Stefan,

>
> Can a corrupt/malicious device state reach this point multiple times
> (i.e. several sqid 0 queues are stored in the device state)? If yes,
> then input validation would be good here to avoid undefined behavior
> later in the sq code.
>
> The same issue may apply to duplicate sqids in general. It seems safest
> to reject them during restore.

Definitely. I'll take care of this in the next version. Thank you!

>
> > +        sq->ctrl = n;
> > +        sq->dma_addr = sq_from->dma_addr;
> > +        sq->sqid = sq_from->sqid;
> > +        sq->size = sq_from->size;
> > +        sq->cqid = sq_from->cqid;
> > +        sq->head = sq_from->head;
> > +        sq->tail = sq_from->tail;
> > +    }
> > +
> > +    __nvme_init_sq(sq);
> > +}
> > +
> >  static uint16_t nvme_create_sq(NvmeCtrl *n, NvmeRequest *req)
> >  {
> >      NvmeSQueue *sq;
> > @@ -5605,6 +5637,39 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
> >      __nvme_init_cq(cq);
> >  }
> >
> > +static void copy_cq_req_list(NvmeCQueue *cq_to, NvmeCQueue *cq_from)
>
> This moves the NvmeRequests rather than copying them. Rename to
> move_cq_req_list()?

Sure!

>
> > +{
> > +    NvmeRequest *req, *next;
> > +
> > +    QTAILQ_FOREACH_SAFE(req, &cq_from->req_list, entry, next) {
> > +        QTAILQ_REMOVE(&cq_from->req_list, req, entry);
> > +        QTAILQ_INSERT_TAIL(&cq_to->req_list, req, entry);
> > +    }
> > +}
> > +
> > +static void nvme_restore_cq(NvmeCQueue *cq_from)
> > +{
> > +    NvmeCtrl *n = cq_from->ctrl;
> > +    NvmeCQueue *cq = cq_from;
> > +
> > +    if (cq_from->cqid == 0) {
> > +        cq = &n->admin_cq;
>
> Same question about duplicate CQs in corrupt/malicious device states.
>
> I reviewed the new draining (busy wait removal). I'll leave the rest for
> Klaus because I'm not that familiar with the NVMe emulation code.

Thanks for reviewing this, Stefan. I'll fix everything and send the next version
in the 2nd half of the next week, cause this week I'm on vacation and next
week I'll be at LSF/MM/BPF.

Kind regards,
Alex

>
> Stefan

