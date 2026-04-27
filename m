Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7D9FF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHUlJ-0004U2-DB; Mon, 27 Apr 2026 18:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wHUlA-0004Te-JG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 18:49:01 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jemoreira@google.com>)
 id 1wHUl8-0005jy-KE
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 18:49:00 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-50e61648f10so212291cf.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 15:48:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777330136; cv=none;
 d=google.com; s=arc-20240605;
 b=BzvOdkpPL7PsBqsfXspULatg8iGdk44iluZePbojjvOcBmZSHsH42Tb1unbA9mRX1m
 0q7Uc+r+nivjB5m7ldCyzSTme4T2GiZbKlJ7mePzsIg9P2OMDUKDqCrW3Ge4uGYws5Js
 SMuOrKzaOZ0PHQvbdA/+V9Q16PxYW86UtusE6/ZdlWbt+3XZ6EYwe1VYbC9f3rxxGz63
 U8r4HmvDyZczEXsXESpy+yIBp3UtQIl5Gs1yqf9rf5zTmU/TTYon3dtafxwibRrBlwPJ
 YRW753Rcm0YrTKSnwEKcfJO1OjeCJloAWzuVf3SQnxQs5KXGpdWdhiyByCG/7i+dnUhS
 uA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ed2wDUq5kRhEpzZd8+rz7p5pqUdkwuSpZWjktccyJ0=;
 fh=Z3ij7Xh4wmDIx5t31UVBxCKsGblFL5fvoxJk3yB7AzE=;
 b=BWMT4u03zJ3igSgVMGUJPg22GVSXqOCVCjev4HujTWZBpigVuQZO3/GI7PnriAqMVq
 sVgNumPGvrJp6qblmTFGxqJ+dnTw0jI9rqMxOqu3EDkU4fJfxUbILxstEnfM7LM5Uyhc
 b01T6jFBWhSaQUncm1Dy/vNUyontXWMvOcNd7VGwxb25/JO9gT7H3ySYJ522yLH5m6Fn
 20zk19vx5GOPwgdOUOKE8d9tdGUhMXliyM8LT8A13rskC/HFUeZ4sbKoCsw+UDIEUHB+
 r+M3W/9OhJF59/pjjulnOkafyqjBwhHisgonM9bAdXZAzAq2RSLvZErEZJRst0Rw5ALN
 ILdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777330136; x=1777934936; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ed2wDUq5kRhEpzZd8+rz7p5pqUdkwuSpZWjktccyJ0=;
 b=ddSoz2rn2P27x/nB0AtNyFn8vDI634xaDQSwlFRSA9tJFRaY37M6pgby2oFxfL8n+V
 Rz+khbvrhGSiv6v+VCBpVLZp20KWZb/s5RCthb5j76FQpee4E1SPrAjb6L/jITv2jGic
 D8MspE/lksp7nCoJtngk3SmUWT81XnfK1ftaRjWSYSoF3HyQ3PE8NMcXLvgcteU1fwPW
 lD5pz7WKzMaMnwsGlG3mvAma3xm3cBZMy2dq1RU4uWn6PZMyO7GcLgOswsajn9u9w4+o
 zMZjhNjU/OL0S/DrYms+Mg2/FrOs7unxUCnm169OvnSjoRbm2lr6PudcCHctcilDjbYr
 SH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777330136; x=1777934936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5ed2wDUq5kRhEpzZd8+rz7p5pqUdkwuSpZWjktccyJ0=;
 b=QCYyahOhnGT7MdYfzBdJajCzqQ0ftCI6gy2HvW8BG8BL6O/kORRerys6J6fA59pOFV
 cXZYlvWlYXD6h0c+hhzHLW5nsC0M/ncRrjPEuqXO09qwGfOBZ+DCxOlNS6dz7C0YhDoX
 gHbWs9SLbTgRSculTBBxjkBr6Do5774B0+EFQftu6eEWgZdfaspV2mCwzxB9HNRYNMMj
 29U9x3qbpMXlIC/5wMAw2XQxgnr+wK1TEFDu5FBg2nYqJKghhh7tqDFBHAVVTR3uRr0i
 bsWOnVzF4cNx7TT6SAZ4+5w/p/71kCmJUVG60xPjaUZ8TFa4JxrzyOQA0w1xdqAqEtas
 J1ZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IrP4vXdkLVBaUyW6iZ2M/QI7XSeDOKkCY518/guK4fgWOcLLuiz1OBVAP9aka2A/7i/dy97Qagdck@nongnu.org
X-Gm-Message-State: AOJu0Yy6Q83GoDXiKi0glXhsnAMHA/kWiy2l/qgYrLjWOlhAZhtTY8G0
 qhJHgQ8WoizMbSc67dHFSaqJyTN5O8xKr+QFuZ/7NSNVaTPsZrjvFWn/GGKJlaXbYq/1cCt+Ov6
 XqqVOKTicgxCAtYk4ngSMBunpPa3poWYUVGBqABsH
X-Gm-Gg: AeBDievIRETqBaxXexsRIBFfBgH/MjIRWj4C2ZUrupUp1A+BhsvmFbqlbxokyNoO921
 z5eUwyTNOBZGV3q9T7boCn6J3n2wgmw1bzP3KEp+Ax0nfVYQSPhntcuodHuBrfuH9uRn/mQRAzO
 JBsf1YumOe9RiM9hPfsXoGfM2uEJvR8eJ5BzWZ+W/vi/gHLnpG2ySrO4nQeI2Er3sDg5rVL9d3J
 Ylg6gRi3wPkcBDqEYMjQOGoGh+hbmy9un/ksqjgXE9xV/SrFYGAEta8dKwwY9e0R4tTdFC4/bSa
 cQ68xzy4tCr0E96R/nvkP/rX3AVZCtWq55L2w1vOQCa1RgCCicizEIzy7Zv0g+X50NTjKcB+Gdr
 cOKZgRwkRaOxwWQaZS8CPeKzacPb/V1B7K6I1cDwtKXEflZ4zqhiGH888Cw==
X-Received: by 2002:a05:622a:1e13:b0:509:15b6:f6a0 with SMTP id
 d75a77b69052e-5100cbe85e2mr5018741cf.6.1777330135926; Mon, 27 Apr 2026
 15:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260411021205.3592118-1-jemoreira@google.com>
 <aeYvCK2qhZd1W9sA@sgarzare-redhat> <20260420181818.GC405461@fedora>
 <CAJi--PPzd_fqcsBU-aA11624apoKTtEW6GTKE3_OyZ4SJ90DzA@mail.gmail.com>
 <20260421211237.GC466778@fedora>
 <CAJi--PP6gsR5E7RtQ_RwV8fG9Xivk0fXTfNxWuZ6cX+uWBPV=A@mail.gmail.com>
 <CAGxU2F7UJhbikjFKMgMcFenFx35vmic-hj4pFm7vM0-gk-nCyg@mail.gmail.com>
 <CAJi--PNoJmei-076Y5geaft98w-nB3OFK2e093EWkN+ZTaQK1Q@mail.gmail.com>
 <20260427224545.GH218226@fedora>
In-Reply-To: <20260427224545.GH218226@fedora>
From: Jorge Moreira <jemoreira@google.com>
Date: Mon, 27 Apr 2026 15:48:44 -0700
X-Gm-Features: AVHnY4IoMLuUfxMXv5ddONmzCmIM0noS8fYSO-OgkBQeK5wqJVt5PTvgNK4zpz0
Message-ID: <CAJi--PPPVc3-z8G3E_qucWhE4bn7hdKYJK4iOcP0Db4tUAw8zQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Explicitly allow front-end to write to
 kick FDs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, hreitz@redhat.com,
 gmaglione@redhat.com, 
 "Michael S . Tsirkin" <mst@redhat.com>, Hanna Czenczek <xanclic@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=jemoreira@google.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Mon, Apr 27, 2026 at 3:45=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Wed, Apr 22, 2026 at 12:20:52PM -0700, Jorge Moreira wrote:
> > On Wed, Apr 22, 2026 at 1:32=E2=80=AFAM Stefano Garzarella <sgarzare@re=
dhat.com> wrote:
> > >
> > > On Wed, 22 Apr 2026 at 03:16, Jorge Moreira <jemoreira@google.com> wr=
ote:
> > > >
> > > > On Tue, Apr 21, 2026 at 2:12=E2=80=AFPM Stefan Hajnoczi <stefanha@r=
edhat.com> wrote:
> > > > >
> > > > > On Mon, Apr 20, 2026 at 05:48:13PM -0700, Jorge Moreira wrote:
> > > > > > While starting the vrings on SET_VRING_KICK could solve the sta=
te
> > > > > > machine issue, it still won't notify the back-end that buffers =
are
> > > > > > ready (the driver won't do this). Non-polling back-ends depend =
on this
> > > > > > kick, especially for queues where data flows only from the driv=
er to
> > > > > > the back-end. Most implementations likely attempt to read from =
the
> > > > > > queue only after receiving the kick.
> > > > >
> > > > > This is an interesting question to clarify in the spec.
> > >
> > > Yep, which is in part related to what I wrote in the other reply:
> > > "I think the main issue to clarify is what the device should do
> > > when the vrings are configured, but the driver has already been
> > > initialized (which is usually the case after migration)."
> > >
> > > > >
> > > > > Stefan
> > > >
> > > > This is the question that interests me most, to be honest. I'd rath=
er
> > > > have the discussion about when to activate the vrings in a differen=
t
> > > > thread and keep this one focused on whether the front-end should se=
nd
> > > > the kick or if the back-end is expected to check if there are "new"
> > > > buffers in the vring after restore.
> > > >
> > >
> > > IMO we don't need anything from the VMM. When the device receives
> > > SET_VRING_KICK, it can check if the vring already contains buffers
> > > (and this is the part we might need to clarify) and wake-up the other
> > > threads (or always wake-ups them, as crosvm does IIUC, and let them
> > > perform this check).
> > > After sending the SET_VRING_KICK message to the device, the VMM has
> > > the exact same knowledge of the vring state as the device, therefore,
> > > it's still unclear to me why we need to inject that kick.
> > >
> > > Stefano
> > >
> >
> > Is it possible to activate a vring after it has been deactivated with
> > VHOST_USER_GET_VRING_BASE? If yes, does the front-end need to send the
> > kick file descriptor again with VHOST_USER_SET_VRING_KICK to
> > reactivate it?
>
> Hi Jorge and Stefano,
> Yes, VHOST_USER_GET_VRING_BASE -> VHOST_USER_SET_VRING_KICK occurs when
> a VM is paused and then resumed.
>
> You can stress test this by driving I/O using iperf (virtio-net) or fio
> (virtio-blk) inside the guest and sending 'stop'/'cont' commands to
> QEMU's monitor.
>
> Here is QEMU's code for starting (including re-starting) rings:
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost.c?ref_=
type=3Dheads#L1341
>
> QEMU does not inject a kick. The back-end must check the rings itself.
>
> I'm not sure that all vhost-user back-ends actually check the rings. I
> think back-ends should do it, but we should also update the spec with an
> front-end implementation note recommending injecting a kick after
> VHOST_USER_SET_VRING_KICK completes in order to maximize compatibility
> with implementations that follow the current spec wording. And at the
> same time I think the spec should also be changed to say that
> VHOST_USER_SET_VRING_KICK starts the ring and back-ends SHOULD check the
> vring upon processing the message.
>
> That seems like it would clean up the issues without introducing
> compatibility issues or making existing implementations non-compliant
> with the updated spec.
>
> What do you think?

Sounds good to me

>
> Stefan

