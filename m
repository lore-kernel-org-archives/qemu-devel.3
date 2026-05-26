Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1D9CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 18:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRwCG-0003uB-9x; Tue, 26 May 2026 14:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wRwC8-0003sI-IO
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:08:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1wRwC6-0002dq-Km
 for qemu-devel@nongnu.org; Tue, 26 May 2026 14:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjMgq5vWnidWxHMUaAAVQ9P3Kzn7Zhsab4KIPZA4FkY=;
 b=XeR09yHhFT+xscfxlUKPo/3hvZSCq9hXWggQbXQJDn6HCxIhNdOK55CpmRMLPm1GDN710V
 0PzJkweos4K14hHu30tD7Ons2Rxr4EebqRHOc3W9r7BzfiHwAiGdYsOXB+mfBOHptik/Re
 IR2vL1g0iQBJ5t5JtLmPmGSaVodL27g=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Sr-0UH5lOVyRu5Ch93J5ZA-1; Tue, 26 May 2026 14:07:56 -0400
X-MC-Unique: Sr-0UH5lOVyRu5Ch93J5ZA-1
X-Mimecast-MFC-AGG-ID: Sr-0UH5lOVyRu5Ch93J5ZA_1779818876
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e60b15b7dbso7664510a34.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 11:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779818875; cv=none;
 d=google.com; s=arc-20240605;
 b=BxYX0TNaompJnSQk1/LEajkMAmg/xStSgPlQkPclKwg74szpDDA3+/eHdRLlZQR3O4
 QA/lLz2O5UBpqB8NjnzDaHYG740fKt+PCjnH0IoupiIs2fqkGlXAdRguvkBo+VMN9N7l
 UqYUAaH0nNt58uFHhD190JjQaOUwc8mkV9fHk8YwkJicu3/y1CDvnOL/JVbp1EWqhMC4
 iB7O8McvAGRJpW8xSgAOWCqlDWsvlTLaH5SWFw7bSQv0HmPjF9IjZhyv5XfjuVb8ixSe
 /sTHmSDktmoX3mqy7nllA3rlJ/ud3jXH3p0He9445HOikkKQyR9CvF0UdAxTCMprvCnW
 rmEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OjMgq5vWnidWxHMUaAAVQ9P3Kzn7Zhsab4KIPZA4FkY=;
 fh=SejsGEAgAxOUn69z6BZ2OzJoo0/eIJquqi86ipTa5+I=;
 b=CogRpNKwkmHGWAOUF7HGfuftMz3r4lyVxy4Y6Gpl9wvY/jx4NYgo+U4alb/ZBwL19H
 aT80RqgMEB4LOSydLcXAaSwajMd0cDFTiJ6MSK/SiNUufqLj9+IZ0HLK5vBX4v+lzOSX
 aaAgqsqMk52FLSA6UiPYi4SKIGen71EfDOrPamxlEVFAbOQSMnWCbjtDE2PCoRON2Oxd
 DlamDFIcK7HXekqm42GcfVZbaEDS4hESD3XnS9hh6RzpivOeG2MB8eUAVGWhRnklz5yQ
 9je4VkftmcaqPgUz4DFCy2y+wzLIVsxjYTBTxhiLM+1YILIcIa6ThLdpU0cKggi8VW+K
 fFKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818875; x=1780423675; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjMgq5vWnidWxHMUaAAVQ9P3Kzn7Zhsab4KIPZA4FkY=;
 b=rsO8cYrXcrT+1JGYrUnAU+PptWiOUNieUHE6HYxxVyivckyxk49FEUF+QAWp+tHGYF
 N55lMTtISmQ5hKU9eoaAzBhTsGC8hVm/92EqdwImLzwXiHOQVKqLr+ZTD2RQx4aiZo80
 3UMc5yHQv49hkuZModBRM8x0Zv9XPk9SlbIcqROXc8qKFkVEqPYQD2bbl5su6QHFg/Px
 6uZwrowW6g8LT/p7brPoCAMNC3bLwjmICbI5TQZ69Wo3m2F5JEL6llSMMjFbz87VvA+k
 dTwLUvK7dvwY8u+5Ol+1Nhgx1PJudTu6caowdezxyhbDPstusg2WlI74XIQYU1T/SS/m
 4/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818875; x=1780423675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OjMgq5vWnidWxHMUaAAVQ9P3Kzn7Zhsab4KIPZA4FkY=;
 b=oXI0zQuE5Ainl/kc4z8L7gz9s9qvduD0Q6cdE+QkzGICHBH1NvZmX+fHJUPttyALq4
 79f1JlC4iw/pwrWEOzu8TBXE9vQY+2hqHdfg8PbsgmScUQQgqEj8MWDkzFSz/42FvE0E
 +v3SPPJY+R9d3Xib6+K2yH/aQ9k5kcLDpO8XQyEfmQllH8XfftuJ9NYT9MqClVlZ0Ln+
 EQuTQ7xj7cYjMW2R3X6jr8Vgh39veXtqjTQX6J+w83o+Hqf9MMOTv5tw/sGhP6jWuP+j
 zDHw8IanvF2hu1iariARwp4RkIrpGuOI3gHM1aFW9Y5BtkhUxp/o7mQSvSSC/ocArBGM
 hP3A==
X-Gm-Message-State: AOJu0Yyot2pEA1bYQILnGV+hGk7JpU+wICqAd/cozJjjGNsvSG/nhJrA
 Wcb1rO3oE/n+08Ktx8tdP9E/KfOREP3szO5nzb5NPXsZqRWIu5BXv+Yfh6+4g0+8scdcuKZW9vr
 8ZYhHDGy7X9km80FqeP4wFXZgJMyd4am1Y8lynr8/hO8Df63Obo58028xn209FTDIkm5w4wB4Wn
 s38eMrZL2VN3MqdruVBloNokJke5Ewwe4=
X-Gm-Gg: Acq92OFO1YbdgOxZESpugWsaR9c/nC+wX3WpGtLEyVxqXpYOpa1zok7IaIZS5swunpG
 rM243VAicb7wnC1MDqj33Zq5XmbRyVeH+Zb8Ojia3F3xpp61a4op8ni8u4O5Ivg6nB+3ceOUmOt
 mLp/snQosKUXHH4kMidJsFIGyyaDsSgd8axBbrVEoik1wpUNkzihoLtIKL4Knoh6/MrrVsehgcD
 ILg
X-Received: by 2002:a05:6820:200e:b0:69d:64a3:6320 with SMTP id
 006d021491bc7-69d6dfebeefmr10194869eaf.6.1779818875617; 
 Tue, 26 May 2026 11:07:55 -0700 (PDT)
X-Received: by 2002:a05:6820:200e:b0:69d:64a3:6320 with SMTP id
 006d021491bc7-69d6dfebeefmr10194846eaf.6.1779818875129; Tue, 26 May 2026
 11:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260526164716.689664-1-mbawa@redhat.com>
 <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-+VDZ+6Z2ZfRmcsYFa9jg-66q7T60Pcf9ZKBeMUfFG+Q@mail.gmail.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Tue, 26 May 2026 23:37:38 +0530
X-Gm-Features: AVHnY4IKzKoL-1QkbMUahumAwhOZhoDbSM-72Jsy5ZJYnZvr5555wsxH23sPFwc
Message-ID: <CAJg9Kkw8FLUS7dqxbm04yBHW84TM-cF9TpMVE6sJMkfLJ2f=dg@mail.gmail.com>
Subject: Re: [PATCH] tpm_tis_sysbus: move PPI memory region setup to realizefn
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 26, 2026 at 11:13=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Tue, 26 May 2026 at 17:49, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > memory_region_init_ram_device_ptr() requires the target page
> > size to be finalized, which has not happened during
> > instance_init. Calling it from tpm_tis_sysbus_initfn() causes
> > an assertion failure when the device is introspected without
> > being realized, for example:
> >
> >   $ qemu-system-aarch64 -device tpm-tis-device,help
> >   qemu-system-aarch64: ../system/physmem.c:2524:
> >   qemu_ram_alloc_internal:
> >   Assertion 'target_page.decided' failed.
> >   Aborted (core dumped)
> >
> > Property introspection only calls instance_init, never
> > realizefn, so moving the memory region setup to realizefn
> > avoids the crash while keeping the device fully functional
> > when actually used in a VM.
> >
> > Move the PPI buffer allocation, memory_region_init_ram_device_ptr()
> > and the corresponding sysbus_init_mmio() from
> > tpm_tis_sysbus_initfn() to tpm_tis_sysbus_realizefn(), placing
> > them just before the existing vmstate_register_ram() call.
> >
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
> > ---
> >  hw/tpm/tpm_tis_sysbus.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> > index 6bec30c36f..33fe9e332c 100644
> > --- a/hw/tpm/tpm_tis_sysbus.c
> > +++ b/hw/tpm/tpm_tis_sysbus.c
> > @@ -100,7 +100,6 @@ static void tpm_tis_sysbus_initfn(Object *obj)
> >  {
> >      TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
> >      TPMState *s =3D &sbdev->state;
> > -    size_t host_page_size =3D qemu_real_host_page_size();
>
> This is asking about the host page size, so why does it wind up
> asserting about the target page size not being fixed ?
>
> thanks
> -- PMM

The host_page_size line itself doesn't cause the crash -
qemu_real_host_page_size() is safe to call anywhere. It was
moved simply because it has no other consumers in initfn.

The actual crash comes from memory_region_init_ram_device_ptr()
- which calls qemu_ram_alloc_internal(). In there, line 2522
evaluates TARGET_PAGE_SIZE: align =3D MAX(align, TARGET_PAGE_SIZE);

With CONFIG_DEBUG_TCG, TARGET_PAGE_SIZE expands through
TARGET_PAGE_MASK which contains: assert(target_page.decided)

That's where it blows up: the target page size hasn't been
finalized yet during instance_init.

Thanks
-- Faiz


