Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD23F53D69
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2AJs-0007D2-KH; Mon, 16 Mar 2026 11:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2AJq-0007Ci-FS
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:57:26 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2AJo-0008Uv-VK
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 11:57:26 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad8435f46so4918679d50.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 08:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773676643; cv=none;
 d=google.com; s=arc-20240605;
 b=hB1h+hgH5dWLUUzDR3Qm3Or+HWMBO1MLHdjbhHBaS0GrCZ97a0SNfABdJ21XtfwMf+
 dFMouEHpykhL++YJ6DMRQ62Ng94C8PCYL7973rXvFj7FGSwqioNNi7HIuhzMvA5LLjxc
 aj4Hi/Fs5SH6weGyCrjqlw9Yisg6ezdnggmjQfxWp/e59iUgh4bN/1KxRlF4v0AM+N7E
 pcXN4WSPa/Yd26010iT9HSXwWLbWGk3BYIjmjs0DYPt1/jfeFfBYnzRoOV6uk6v/0gh8
 SpR9XwYYLl9FaWfkFxjBHG4z78hgNXYEFnHjfySsBDEewvmftIuliVpitVhtq/MvJn5f
 It8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R1RAxLHuisOEg23Ie34CPIJ5KCkNU9xqAHyp/gYUa+g=;
 fh=Y6kxCTiPZ5b/w2E0dv4AaCuHxR6xokTpt/HocB1Rvxk=;
 b=SMz4d1x5ysqkfg48Pz3RYiuTYSvLMau5k7L3NGGQLRcWPWNVazjJoxqxXfrvuBu4ph
 OwXvLbsNmrONSu8hxCVS0JbVqN4lUBt3v3agGy1dg91ljNivnlnTp9hNwZJdyrvgH+R5
 OYH5cQgapsuWPDqsXIpBPBdenFt7rIKhgZsmQFIz2XQAdpVupW87X/e2rOEsa5sgXTJP
 phI0ZVeNnlwD3RfIbcopPuy5Dmdxod7lnd6Ov0i7fCJngVMoELrfneEg8SMt/A6ZJdql
 8DqTRvtFIMtI/pBN2OflJA4LYp3k8lZme1lOkTZwjhp2inbaiX2lo6qp2Cze1WDu/K+Z
 7KFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773676643; x=1774281443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R1RAxLHuisOEg23Ie34CPIJ5KCkNU9xqAHyp/gYUa+g=;
 b=GnSvXmlUyNb+xYhJs8tDrqHlOLzN9YkfP2I3NCmcwWd1L6qZTgqxuytUBVZUEF/1U+
 OQGaNeAlZ2J7+mcK6ntz59Um9VE3WDWbN4wKTvzJRw1lxm1FFPxfTibNeahtUrMXHBon
 PsRZ1deG2iED64PIIGYEkfAxDrDGFYMENlbUqUfoJ2b3G46c8TrLOPt2k26YkcNCMx8T
 FDrZF2l7E/3np3/LKCdqu/tBQtGwP0h/IIROMRACUNW3EjP1pz7fki/XMCWaSt4Xha+m
 8+m/Z7kJ0HyGEHcZiCEUQW+Vr8A67kFxRUZ76E4ZbW3vBhLijBQl2akG0i9Fe1pgRHUh
 IEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773676643; x=1774281443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R1RAxLHuisOEg23Ie34CPIJ5KCkNU9xqAHyp/gYUa+g=;
 b=aTSKxy5ITZsP6sokvIrr8LBPQqtPVPyZ6FGTUbv3Mq166MlBgWssh72G+EkofXjXZe
 1hJizGI3igc1goICvJAOPkosumYR0/W4Iie7lG+UEVZ5MhOw2xr+kEM7hNlunj7pb/cB
 SiL8V85NK5StOO7CyzRG4j+qeTMMvn9h32fJ0oehb3i1b7HWtCtTAMp3EkS8aruMvhkw
 sXOcVtm6fj4vmz9RRNDipbAQOm/x3AqrylDZt+cwIA0nRKZmsCNDaNFPuN8dpZYqnm7j
 ZRnHbZO7dIf48U+zfcEejn6zWuiJzCYzCijY83VT4lgLI+WrmglS1czzoa+ljRe3OJRC
 ZjDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/syrJ6dk1jSaR1ud9YmleQqEWaX/k9xC1vN8CZoNcnYtZi9K/1u/sc0iu7eF5+4nMVcCEBpHrea2c@nongnu.org
X-Gm-Message-State: AOJu0YxNDurc7EqGVUZc3AlldWl5BxjfzMWp5OzHFbHrpkeWQFGDG/8b
 gIKeXQxInFllLa4OeJ2KbYfWiQZtyU0S6d4xOFwHALDQ0EF1ZHoHvKdhh7PVKxoWFlyjeWH+NeT
 Xi+Aj6b+bg+JaNuiTEsIPiDXyOISSoeYNxak41NTbzXYySrvkejAL1lk=
X-Gm-Gg: ATEYQzy9dEq2KbV6ew2pdDlmjp9bV49Hf1/EwQRfJtIl7aKuc25/OwDQKwYXdsA6ReP
 7y23+5eKOL87NA/4pseotT6lTiUGIdNk+okDAm2wezdiQ5bos41slJeGcqxsbp2TOJvohLo5tGI
 BiEj8u7ZriTDv2yRFR7nP9sI4qrcl9yXOtjinGC+Mh54C/2Mfhc2fH0Vgj9V6Dp8fUWUvm56vv+
 gGLuziiqkz5LaJ8y2/Qf0dfjBOUPKU3CWkC5cMEqjlp9ESwpVCM9X0421n4hh22887JryNPD7O+
 2w3ysGWsAGpWHt7XXo8H0b078PIjLYIdxI1S1ElKZWUX/905uFgwcH12IP2LzlybAd8=
X-Received: by 2002:a53:ba4b:0:b0:649:443f:ab2a with SMTP id
 956f58d0204a3-64e62fb58efmr8679674d50.37.1773676642796; Mon, 16 Mar 2026
 08:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260313233538.1519319-1-rkir@google.com> <87341zsvmc.fsf@suse.de>
In-Reply-To: <87341zsvmc.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 15:57:11 +0000
X-Gm-Features: AaiRm51DhNjVmPQM15KKYcid7ez71cLqy2ZJI3g7h23oIV8ybPQdOmP2ymXBxPc
Message-ID: <CAFEAcA9BzSp9F8yv4eZv5eeUM4JXSy9T-QnRr_UbJZpNmhtHyw@mail.gmail.com>
Subject: Re: [PATCH v3] vmstate: validate VMStateDescription::fields upon
 registration
To: Fabiano Rosas <farosas@suse.de>
Cc: Roman Kiryanov <rkir@google.com>, peterx@redhat.com, qemu-devel@nongnu.org,
 whollins@google.com, jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 16 Mar 2026 at 14:22, Fabiano Rosas <farosas@suse.de> wrote:
>
> Roman Kiryanov <rkir@google.com> writes:
>
> > The vmstate_save_state_v() function does not support
> > NULL in VMStateDescription::fields and will crash if
> > one is provided.
> >
> > This change prevents this situation from happening
> > by explicitly crashing earlier.
> >
> > Suggested-by: Fabiano Rosas <farosas@suse.de>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Roman Kiryanov <rkir@google.com>
> > ---
> > v3:
> >  - Also added assert to virtio.c to validate
> >    VirtioDeviceClass instances which bypass
> >    vmstate_register_with_alias_id.
> >  - Updated the commit message to "Reviewed-by".
> > v2:
> >  - Moved the assert from vmstate_save_state_v to the registration
> >    path (vmstate_register_with_alias_id) and the qtest validation path
> >    (vmstate_check) to catch missing fields earlier.
> > ---
> >  hw/virtio/virtio.c | 6 ++++++
> >  migration/savevm.c | 5 +++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 0ba734d0bc..e4543de335 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -4054,6 +4054,12 @@ static void virtio_device_realize(DeviceState *dev, Error **errp)
> >      /* Devices should either use vmsd or the load/save methods */
> >      assert(!vdc->vmsd || !vdc->load);
> >
> > +    /*
> > +     * If a device has vmsd, it either MUST have valid fields
> > +     * or marked unmigratable.
> > +     */
> > +    assert(!vdc->vmsd || (vdc->vmsd->unmigratable || vdc->vmsd->fields));
> > +
> >      if (vdc->realize != NULL) {
> >          vdc->realize(dev, &err);
> >          if (err != NULL) {
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 197c89e0e6..20c2b99231 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -861,6 +861,8 @@ static void vmstate_check(const VMStateDescription *vmsd)
> >      const VMStateField *field = vmsd->fields;
> >      const VMStateDescription * const *subsection = vmsd->subsections;
> >
> > +    assert(field || vmsd->unmigratable);
> > +
> >      if (field) {
> >          while (field->name) {
> >              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
> > @@ -900,6 +902,9 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
> >      /* If this triggers, alias support can be dropped for the vmsd. */
> >      assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
> >
> > +    /* If vmsd is migratable it MUST have valid fields. */
> > +    assert(vmsd->fields || vmsd->unmigratable);
> > +
> >      se = g_new0(SaveStateEntry, 1);
> >      se->version_id = vmsd->version_id;
> >      se->section_id = savevm_state.global_section_id++;
>
> Looks like we'll also need to fix some stubs that define empty vmsds:
>
> qemu-system-mips64: ../migration/savevm.c:864: void vmstate_check(const
> VMStateDescription *): Assertion `field || vmsd->unmigratable' failed.
>
> Maybe something like the following. Peter, what do you think?

Ah, I was about to report this -- commit 7aa563630b6b0 ("pc: Start
with modern CPU hotplug interface by default") broke the MIPS Malta
board migration, which now segfaults when you "savevm" because
the stub vmstate_cpu_hotplug struct has a NULL fields pointer.

This used to work because the relevant vmstate had a "needed"
function that meant we never used the stub vmstate structs, but
that commit dropped the "needed" functions.

If the change you suggest is the right way to fix this then it
ought to be its own patch with a Fixes: tag pointing at 7aa563630b6b0.

thanks
-- PMM

