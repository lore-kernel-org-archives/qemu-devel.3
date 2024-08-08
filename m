Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED34C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 15:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc5Mu-00035V-3p; Thu, 08 Aug 2024 11:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc5Ml-00032o-0H
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:47:52 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc5Mg-0008FS-Us
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 11:47:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6135dso1512667a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723132064; x=1723736864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k5S6mwXnO8hUC/F8h/LQEE0Mk4L9A01oDtRwD34+Tsk=;
 b=ePvfsof/QqTjTlCSywAcyO6k3e90obaPX40UdPSNHJZL4PJUJURVle6fKvszq9fumq
 aYFrZA3VwO0t2suDLoMJtiUdyIug+aN4/YGFggUBPZJ/xmnoZSNfxv/rFArMefBDa9ii
 Tfwu3wxBja0QAczTfuRSR+rWWl8PX3A59Fx3Kg6Anhp/czhI/NoWqCfmGW1L/zNHK2uQ
 pbrax5eVOnQuRlopS1nan7t0Y08rD7DtVo0e3kgrWZZhAFDdLfFlWWFNllCH+MKe7EdG
 eMElRupr7teEbhJDcSHn5x+ylKDlTMKzQx2lqK4XwlRb5m4CZFfwPChn0F4zH81loAaT
 frOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723132064; x=1723736864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k5S6mwXnO8hUC/F8h/LQEE0Mk4L9A01oDtRwD34+Tsk=;
 b=pErwhQAY1jJ24OrNWCFFuBtZzibhJw5EvfsmB+wkKQOXldndobIVcwTKB5ozMpUnVj
 y0pe3VZEMd2u7Ju48YQMPoXSlt1LBFOcHz659PA4SdcsyMOIEsqUdm0eCsCqUzMGoB2p
 P1GHHVYTVhmawXNkTaKq8ntVQcuC4OF1A3ZlISqKpQ3pzvgfB/wCQOZTBzSikEdoN9yH
 Ru0f8IZlW+5p6E5EXcLS8020sTW5u09N6yaOO5BVnn/m3YxCVgs2jAbHLhlWYnPSgHEh
 LojcieGgU/B+qdB165M4b2e+ZTX4eK/TXzJ0NPuaeGsZwgEZva5xBS0iLAc2tJJOJX05
 R9wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3EtDtjQFHhv3Xqum5sAD8wUCMKnRvGLVZKwsTjMwHOU0oIzvc4wP5cAO6+i5mBj6Qy3O32rGe6laCN4r1WPNrim1vc8E=
X-Gm-Message-State: AOJu0YyK4Tl5c+dmC+LHt6PTjdQqVuXRqAXDUxZRZnC/z9cpsd40fR9b
 X8CBJVM43D5IsKzCt0fqkOUPMR1QBW/dcsPes6CwZFFgGQo9AhuSm6jgIkMstoVoVP4f8PV2TIz
 YhDx3zASMYfqt1ELhhW8dXt2QL/80A5TgST/3jg==
X-Google-Smtp-Source: AGHT+IHBZU/e2QkFjjZktvZ+yCHWBckI8yIV3YetP51SwLbCx4sHpoQBaOupFis+twQ0ZbRdvOUYubsLzQbsx/3YlXc=
X-Received: by 2002:a05:6402:378c:b0:58d:81ac:ea90 with SMTP id
 4fb4d7f45d1cf-5bbb235ec06mr1605926a12.38.1723132063780; Thu, 08 Aug 2024
 08:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-4-jmarcin@redhat.com>
 <CAFEAcA8ENru8Cb9DKi_PaQYkox397ZxhPjFbf7ioHjKhAHqKXA@mail.gmail.com>
 <5aabd401-af44-4c2b-9b91-1bf2877d2310@redhat.com>
In-Reply-To: <5aabd401-af44-4c2b-9b91-1bf2877d2310@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 16:47:32 +0100
Message-ID: <CAFEAcA96KgndqYt27i_3buivFPEXr8Dxp8ucf3mT4m1nqkbQSQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-mem: Implement Resettable interface instead of
 using LegacyReset
To: David Hildenbrand <david@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 8 Aug 2024 at 13:37, David Hildenbrand <david@redhat.com> wrote:
>
> On 08.08.24 14:25, Peter Maydell wrote:
> > On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
> >>
> >> LegacyReset does not pass ResetType to the reset callback method, which
> >> the new Resettable interface uses. Due to this, virtio-mem cannot use
> >> the new RESET_TYPE_WAKEUP to skip reset during wake-up from a suspended
> >> state.
> >>
> >> This patch adds the Resettable interface to the VirtioMemClass interface
> >> list, implements the necessary methods and replaces
> >> qemu_[un]register_reset() calls with qemu_[un]register_resettable().
> >
> >> @@ -1887,6 +1897,7 @@ static const TypeInfo virtio_mem_info = {
> >>       .class_size = sizeof(VirtIOMEMClass),
> >>       .interfaces = (InterfaceInfo[]) {
> >>           { TYPE_RAM_DISCARD_MANAGER },
> >> +        { TYPE_RESETTABLE_INTERFACE },
> >>           { }
> >>       },
> >>   };
> >
> > TYPE_VIRTIO_MEM is-a TYPE_VIRTIO_DEVICE, which is-a TYPE_DEVICE,
> > which implements the TYPE_RESETTABLE_INTERFACE. In other words,
> > as a device this is already Resettable. Re-implementing the
> > interface doesn't seem like the right thing here (it probably
> > breaks the general reset implementation in the base class).
> > Maybe what you want to do here is implement the Resettable
> > methods that you already have?
>
> TYPE_DEVICE indeed is TYPE_RESETTABLE_INTERFACE.
>
> And there, we implement a single "dc->reset", within which we
> unconditionally use "RESET_TYPE_COLD".

That's the glue that implements compatibility with the legacy
DeviceClass::reset method.

There's two kinds of glue here:

(1) When a device is reset via a method that is three-phase-reset
aware (including full system reset), if the device (i.e. some
subclass of TYPE_DEVICE) implements the Resettable methods, then
they get used. If the device doesn't implement those methods,
then the base class logic will arrange to call the legacy
DeviceClass::reset method of the subclass. This is what
device_transitional_reset() is doing.

(2) When a three-phase-reset device is reset via a method that is not
three-phase aware, the glue in the other direction is the
default DeviceState::reset method which is device_phases_reset(),
which does a RESET_TYPE_COLD reset for each phase in turn.
Here we have to pick a RESET_TYPE because the old legacy
reset API had no concept of reset types at all.
The set of cases where this can happen is now very restricted
because I've been gradually trying to convert places that can
trigger a reset to be three-phase aware. I think the only
remaining case is "parent class is 3-phase but it has a subclass
that is not 3-phase aware and tries to chain to the parent
class reset using device_class_set_parent_reset()", and the
only remaining cases of that are s390 CPU and s390 virtio-ccw.

For TYPE_VIRTIO_MEM neither of these should matter.

Other places where RESET_TYPE_COLD gets used:
 * device_cold_reset() is a function to say "cold reset this
   device", and so it always uses RESET_TYPE_COLD. The assumption
   is that the caller knows they wanted a cold reset; they can
   use resettable_reset(OBJECT(x), RESET_TYPE_FOO) if they want to
   trigger some other kind of reset on a specific device
 * similarly bus_cold_reset() for bus resets
 * when a hot-plug device is first realized, it gets a
   RESET_TYPE_COLD (makes sense to me, this is like "power on")

I think these should all not be relevant to the WAKEUP
usecase here.

> Looks like more plumbing might be required to get the actual reset type
> to the device that way, unless I am missing the easy way out.

I think the plumbing should all be in place already.

thanks
-- PMM

