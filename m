Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15586C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 13:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scPaV-0002Yg-Qj; Fri, 09 Aug 2024 09:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1scPaT-0002Y2-Sr
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 09:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1scPaQ-0000Aw-EB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 09:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723209796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-cc:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=k8vsZ7+2xUSSP50M6ZK7c7vSGv3mUDo2cnafMUIL3Vw=;
 b=MXyJAuIQnW9U/CTP9JQrKXFKoyGP2RuMJo2OUVRF39Ap2uV0Aw9MVozatOxYIlIfYqQJu9
 0vtGHVVWU4aE4EmDlM+/IY530lV0NlH4YgRlif5ueS6IVdbIA90FLmEolo3VEc+nt20JmX
 IZRj4gFCWjHba5QPay6KZnxzMmYAoZM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-BzWcTbQqPJ24WCzf5O9EVQ-1; Fri, 09 Aug 2024 09:23:15 -0400
X-MC-Unique: BzWcTbQqPJ24WCzf5O9EVQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3687529b63fso1170482f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 06:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723209794; x=1723814594;
 h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
 :references:date:mime-version:resent-message-id:resent-date
 :resent-cc:resent-from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8vsZ7+2xUSSP50M6ZK7c7vSGv3mUDo2cnafMUIL3Vw=;
 b=j4QZTU0IPVYTurhPOm4od9aB4pVqdahDSAC85HbVtRFClzArUCIWgnhyFUbqLldrYT
 VbJ6PmKnmG6ObKRExRHRlxsSsbrVpqN5M+DfIVntEma69DscpMI1U7bfEbKSFVa3ejjR
 ykCHmcNv5XiS19gaK3Seysh2xbts05v4PHGRuCoOhjiFT9YC7j3GJTvxEW3nT8e7f5DF
 x1vnBckxh3Nqiv0EFIzW4E7wLZv2HIFKhbh2QYSI9LBSH74pchP7EIrjLVrtyazpH320
 nBjJS/IefFI0lBifkAw7KxB9vdqF5y8uqRs047OfynKKYpBiOuweXhrYFI4oAN8ELZZN
 7AEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+aWDXnmc3Wi9dYTnPePtU0q4/DbM5kdU2+45AGke8sY2+Ciy0dUsFcaEw348sDrQarJ2n+ZnBCL+AoYzfZ4mHMNYn1fQ=
X-Gm-Message-State: AOJu0YwdxrV/2v9dDFya9T84hLCL3CD64lhRMmh/bMtATKoSNiTXSP/t
 vjKL9QVCANgnjjxKMEX5q65SFLsMkABRwZsrgzqHhhWov55KBw+87Sf1wy2VoB6Pwxu8zPyIYe8
 Gjx49kmpbpXzI3fABhLSU4gUC2R35lu/sCmn/a/mQ/vxbIZk60XwyqHuYlIq2CpGxa1YkIadc//
 DxBLFQaECE5I69pWp+oR8uUqzgBbmvWBAnXFXEZQ==
X-Received: by 2002:a5d:474e:0:b0:367:9828:f42d with SMTP id
 ffacd0b85a97d-36d61ccf882mr1342926f8f.53.1723209793809; 
 Fri, 09 Aug 2024 06:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIxNjy1PSNwo4czp21BJmi7j1yMmy+oYcro4CgxUsIKDb1dDj4Lyl8JZF25CCtXuqXgfFmQA==
X-Received: by 2002:a5d:474e:0:b0:367:9828:f42d with SMTP id
 ffacd0b85a97d-36d61ccf882mr1342886f8f.53.1723209792952; 
 Fri, 09 Aug 2024 06:23:12 -0700 (PDT)
Received: from [10.43.2.64] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272290c2sm5337527f8f.92.2024.08.09.06.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 06:23:12 -0700 (PDT)
Resent-From: Juraj Marcin <jmarcin@redhat.com>
Resent-Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>
Resent-Date: Fri, 9 Aug 2024 15:23:12 +0200
Resent-Message-ID: <466bf5a5-3506-43fc-8aa0-982409a0da48@redhat.com>
MIME-Version: 1.0
Date: Fri, 9 Aug 2024 15:06:15 +0200
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-4-jmarcin@redhat.com>
 <CAFEAcA8ENru8Cb9DKi_PaQYkox397ZxhPjFbf7ioHjKhAHqKXA@mail.gmail.com>
 <5aabd401-af44-4c2b-9b91-1bf2877d2310@redhat.com>
 <CAFEAcA96KgndqYt27i_3buivFPEXr8Dxp8ucf3mT4m1nqkbQSQ@mail.gmail.com>
In-Reply-To: <CAFEAcA96KgndqYt27i_3buivFPEXr8Dxp8ucf3mT4m1nqkbQSQ@mail.gmail.com>
Message-ID: <CAC2qdxA9rCwc-o6uog8KsAKp4JQnQRt_XqhJUo4e6d1U5yExnA@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-mem: Implement Resettable interface instead of
 using LegacyReset
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 8, 2024 at 5:47=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Thu, 8 Aug 2024 at 13:37, David Hildenbrand <david@redhat.com> wrote:
> >
> > On 08.08.24 14:25, Peter Maydell wrote:
> > > On Tue, 6 Aug 2024 at 17:08, Juraj Marcin <jmarcin@redhat.com> wrote:
> > >>
> > >> LegacyReset does not pass ResetType to the reset callback method, wh=
ich
> > >> the new Resettable interface uses. Due to this, virtio-mem cannot us=
e
> > >> the new RESET_TYPE_WAKEUP to skip reset during wake-up from a suspen=
ded
> > >> state.
> > >>
> > >> This patch adds the Resettable interface to the VirtioMemClass inter=
face
> > >> list, implements the necessary methods and replaces
> > >> qemu_[un]register_reset() calls with qemu_[un]register_resettable().
> > >
> > >> @@ -1887,6 +1897,7 @@ static const TypeInfo virtio_mem_info =3D {
> > >>       .class_size =3D sizeof(VirtIOMEMClass),
> > >>       .interfaces =3D (InterfaceInfo[]) {
> > >>           { TYPE_RAM_DISCARD_MANAGER },
> > >> +        { TYPE_RESETTABLE_INTERFACE },
> > >>           { }
> > >>       },
> > >>   };
> > >
> > > TYPE_VIRTIO_MEM is-a TYPE_VIRTIO_DEVICE, which is-a TYPE_DEVICE,
> > > which implements the TYPE_RESETTABLE_INTERFACE. In other words,
> > > as a device this is already Resettable. Re-implementing the
> > > interface doesn't seem like the right thing here (it probably
> > > breaks the general reset implementation in the base class).
> > > Maybe what you want to do here is implement the Resettable
> > > methods that you already have?
> >
> > TYPE_DEVICE indeed is TYPE_RESETTABLE_INTERFACE.
> >
> > And there, we implement a single "dc->reset", within which we
> > unconditionally use "RESET_TYPE_COLD".
>
> That's the glue that implements compatibility with the legacy
> DeviceClass::reset method.
>
> There's two kinds of glue here:
>
> (1) When a device is reset via a method that is three-phase-reset
> aware (including full system reset), if the device (i.e. some
> subclass of TYPE_DEVICE) implements the Resettable methods, then
> they get used. If the device doesn't implement those methods,
> then the base class logic will arrange to call the legacy
> DeviceClass::reset method of the subclass. This is what
> device_transitional_reset() is doing.
>
> (2) When a three-phase-reset device is reset via a method that is not
> three-phase aware, the glue in the other direction is the
> default DeviceState::reset method which is device_phases_reset(),
> which does a RESET_TYPE_COLD reset for each phase in turn.
> Here we have to pick a RESET_TYPE because the old legacy
> reset API had no concept of reset types at all.
> The set of cases where this can happen is now very restricted
> because I've been gradually trying to convert places that can
> trigger a reset to be three-phase aware. I think the only
> remaining case is "parent class is 3-phase but it has a subclass
> that is not 3-phase aware and tries to chain to the parent
> class reset using device_class_set_parent_reset()", and the
> only remaining cases of that are s390 CPU and s390 virtio-ccw.
>
> For TYPE_VIRTIO_MEM neither of these should matter.
>
> Other places where RESET_TYPE_COLD gets used:
>  * device_cold_reset() is a function to say "cold reset this
>    device", and so it always uses RESET_TYPE_COLD. The assumption
>    is that the caller knows they wanted a cold reset; they can
>    use resettable_reset(OBJECT(x), RESET_TYPE_FOO) if they want to
>    trigger some other kind of reset on a specific device
>  * similarly bus_cold_reset() for bus resets
>  * when a hot-plug device is first realized, it gets a
>    RESET_TYPE_COLD (makes sense to me, this is like "power on")
>
> I think these should all not be relevant to the WAKEUP
> usecase here.
>
> > Looks like more plumbing might be required to get the actual reset type
> > to the device that way, unless I am missing the easy way out.
>
> I think the plumbing should all be in place already.

I have gone through the code once more and I also think that. I think
that removing the interface from VirtIOMEM type info (as it already is
in the parent) and then overriding the Resettable methods in
virtio_mem_class_init() should be enough. This should also include
setting rc->get_transitional_function to NULL, so the
device_get_transitional_reset() does not interfere with the 3 phase
reset.

>
> thanks
> -- PMM
>

--=20

Juraj Marcin


