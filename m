Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C616E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 01:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO5gn-0000ts-62; Wed, 18 Dec 2024 20:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tO5gi-0000tS-SU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 20:50:52 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tO5gf-0001IF-Bf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 20:50:51 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso2329025ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 17:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734573047; x=1735177847; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyqB/yemDdd+bXN+c/VxhblpGJJ9RAhVBo1KCY2BifU=;
 b=Knvo6v//30YkfBLGbPU964TprAIPYj9P7c7+pWUaLiqBFcAC4X/2qyEpEdV0oaZLGk
 fUSrOewxR4EUD5P9/MOJiQqpyuUW6lCkJu2gRY/VehZ1CVgkWyuisAPFHTe7xJXWLGFz
 8yYTQSLqXG0EPKEV8U/brL3H/ZV0PqBwaqwTtG2iEr48ZUz0eH0aWtC+9ySLnJRftjwy
 67/3nMd2rmjROJFsnbZg05VLNnN8cMJgoM/QngbpbNG0UZI8U/vu4HHN2VRHzDZGkOZL
 CrpwNw7XUk+Q2zTpAcXuhDMkO23u2chtq5CIM+HrYWiDZlfLo/nYDvtEYWMpMP1/2iCR
 2S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734573047; x=1735177847;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hyqB/yemDdd+bXN+c/VxhblpGJJ9RAhVBo1KCY2BifU=;
 b=VRTeYOggNxlJHhVEXj+FPvU/tCigsX4nzz7TcPFdYLjkjDacLxgJQykon0XK3Br+HA
 2TZe+DCYgc6p2TrGXbZU8M8d6wXB6ouPs1sERAjcxxaNWzLtpJjdkFssI0sqi9fDSmHB
 dVS9iIF0RNQ9C80DlL03+fPc5n+9R1SK6IuojkWwEQqCOtZsMYSLHJ+V/3JMbym8j7Q7
 FTOVM4KVm09AToAQqtS9YLLuqxRMCfR6WVbQS7E48VKvWXTq6saBKvYH5SKvrh5A9plU
 05fdOtlkCnYxghybGMIIPl74WUVcEIZ7r3WoRO27IDzps0UKG+4ZopKpz+TRQ1D2cuvH
 f+fQ==
X-Gm-Message-State: AOJu0YzOvZ2UNW1q/6bqk9uiGHtL4WkC/oROIBYu4NBDCCIkgxaV8djo
 Hb1AhWSFOEXFF0zEuK47RuOR/gYCu+0RBcWYGqg48RYId931pM67MbuhNg==
X-Gm-Gg: ASbGncu1EIdFeurHYh1adLMYjRtnvFjytsgeWXp43OdTE5yyqbkziD5nouLGMwY1d9P
 +aUksSa7pL/RkTYhUsKj8xkKIj+04RnlywHOIrm4QPVNa+h4Sfyr602e29MwhLpZVZ56t0dv4r5
 pvoKYPqCp+V7Ce0YBSZdjA9tY0LAq+C/sGhmxXe+PnBx3RFfXlTt/F5giGfmNgJvkUqyS2PmBNf
 X1vhJZaR+mBdIQ8e1QPiYQNuJmIGfkqy+FAHhEMYG2j38gEDbppdDM0TRAl7I1c4TxDE7DQAJI=
X-Google-Smtp-Source: AGHT+IFoIZQRrsV0TxdRJRp4/MgSXrngRh/5XLCzhY/il8hD3zTtyx03ZEpiZO9oW+NjJ+XMfEk4Ow==
X-Received: by 2002:a17:902:e883:b0:215:8dd3:536a with SMTP id
 d9443c01a7336-218d6fd5e99mr65525215ad.4.1734573046886; 
 Wed, 18 Dec 2024 17:50:46 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96291bsm1909155ad.14.2024.12.18.17.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 17:50:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 11:50:40 +1000
Message-Id: <D6FATQ1ETHB0.2WZ09SFCLAH5B@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Akihiko Odaki" <akihiko.odaki@daynix.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>
Subject: Re: [PATCH 5/8] hw/usb/xhci: Move HCD constants to a header and add
 register constants
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Phil Dennis-Jordan" <lists@philjordan.eu>
X-Mailer: aerc 0.18.2
References: <20241212083502.1439033-1-npiggin@gmail.com>
 <20241212083502.1439033-6-npiggin@gmail.com>
 <CAGCz3vuUoRPk1UN2+_SqLtn_q5qu-RM7kmwTgNeRM2Mf75hoeg@mail.gmail.com>
In-Reply-To: <CAGCz3vuUoRPk1UN2+_SqLtn_q5qu-RM7kmwTgNeRM2Mf75hoeg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

On Thu Dec 19, 2024 at 1:08 AM AEST, Phil Dennis-Jordan wrote:
> This looks sensible to me overall.
>
> For the new symbolic constants for MMIO register offsets such as
> XHCI_OPER_*, XHCI_INTR_* and so on, I'm wondering if it would be clearer =
to
> give them all an _OFFSET suffix. It's not perfectly consistent to do so
> across the code base, but quite a few device types do follow that
> convention. In my opinion it improves readability, especially in the head=
er
> file, where these offset constants are frequently mixed in with constant
> values that can be written to or read from these registers.

I'm not strongly attached. I slightly prefer suffix, like
XHCI_HCCAP_REG_CAPLENGTH) for MMIO regs, so all the common
part of the name lines up.

Should the entire codebase have a guideline for memory offset
naming conventions? Or does it not matter that much.

[snip]

> > -    case 0x0c: /* HCSPARAMS 3 */
> > +    case XHCI_HCCAP_HCSPARAMS3:
> >          ret =3D 0x00000000;
> >          break;
> > -    case 0x10: /* HCCPARAMS */
> > -        if (sizeof(dma_addr_t) =3D=3D 4) {
> > -            ret =3D 0x00080000 | (xhci->max_pstreams_mask << 12);
> > -        } else {
> > -            ret =3D 0x00080001 | (xhci->max_pstreams_mask << 12);
> > +    case XHCI_HCCAP_HCCPARAMS1:
> > +        ret =3D (XHCI_HCCAP_EXTCAP_START >> 2) | (xhci->max_pstreams_m=
ask
> > << 12);
> >
>
> This doesn't look like it's equivalent to the original code. I think you
> want
> ((XHCI_HCCAP_EXTCAP_START >> 2) << 16) | (xhci->max_pstreams_mask << 12);

Good catch.

>
> That's=E2=80=A6 not particularly readable either though, so if we're goin=
g to break
> up the magic numbers here, how about something like:
>
> ret =3D (XHCI_HCCAP_EXTCAP_START / 4) << XHCI_HCCPARAM_EXTPTR_SHIFT;
> ret |=3D xhci->max_pstreams_mask << XHCI_HCCPARAM_MAXPSASIZE_SHIFT;
>
>
> > +        if (sizeof(dma_addr_t) =3D=3D 8) {
> > +            ret |=3D 0x00000001; /* AC64 */
> >
>
> and then this can become
> ret |=3D XHCI_HCCPARAM_AC64;
>
> or something like that.

Sure.

[snip]

> >      switch (reg) {
> > -    case 0x00: /* PORTSC */
> > +    case XHCI_PORT_PORTSC:
> >          ret =3D port->portsc;
> >          break;
> > -    case 0x04: /* PORTPMSC */
> > -    case 0x08: /* PORTLI */
> > +    case XHCI_PORT_PORTPMSC:
> > +    case XHCI_PORT_PORTLI:
> >          ret =3D 0;
> >          break;
> > -    case 0x0c: /* reserved */
> >
>
> I think it's worth keeping explicitly unhandled case labels documented li=
ke
> this. (This one appears to be XHCI_PORT_PORTHLPMC nowadays, I assume it w=
as
> reserved in an earlier spec version.)

Okay.

>      default:
> >          trace_usb_xhci_unimplemented("port read", reg);
> >          ret =3D 0;
> > @@ -2829,7 +2668,7 @@ static void xhci_port_write(void *ptr, hwaddr reg=
,
> >      trace_usb_xhci_port_write(port->portnr, reg, val);
> >
> >      switch (reg) {
> > -    case 0x00: /* PORTSC */
> > +    case XHCI_PORT_PORTSC:
> >          /* write-1-to-start bits */
> >          if (val & PORTSC_WPR) {
> >              xhci_port_reset(port, true);
> > @@ -2880,8 +2719,6 @@ static void xhci_port_write(void *ptr, hwaddr reg=
,
> >              xhci_port_notify(port, notify);
> >          }
> >          break;
> > -    case 0x04: /* PORTPMSC */
> > -    case 0x08: /* PORTLI */
> >
>
> Hmm. Looks like PORTLI is actually a read-only register, so writing this
> ought to trigger a LOG_GUEST_ERROR. And I don't think it's a bad thing to
> explicitly document PORTPMSC as unimplemented. (And I guess that ought to
> be a LOG_UNIMP, not a trace, sigh.) The improved logging can be a separat=
e
> commit - in fact I don't mind tagging that fix onto my own pending XHCI
> patch set, but I think for this commit we ought to keep the case labels
> (with the new symbolic constants).

Okay I'll add back the reserved cases.

Yeah, memory access handling in drivers is really inconsistent all over
the tree. It would be nice if there was some helpers or something that
added common template for access tracing, unimp and guest error logs,
etc.

Thanks,
Nick

