Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6646E87827
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 13:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnGeE-0006cf-Ba; Tue, 03 Feb 2026 08:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnGeC-0006cJ-I3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnGeA-0003eS-3h
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 08:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770126047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgnSI0cbDDbkSCP7huGpDrVnx8OOkSAH7uS6u96Q0Ww=;
 b=ZIaniMxeJE1RepHqYt/lPxwsvSWVgJsCca8zLlbuaLHqG1j4Vlxffpa9MICevV/2raRu70
 ljrYnZZ/YRjPT04BToSI6h4OLlb9sgaEowGsYNY6AWMo71yYT2oWVn0VvziiYOAVRAPnH6
 aDyOhrIP0iXWEQShXCbYh8FH7i7zQ5E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-CSMzgqAVNPyU8o0ABkJs7w-1; Tue, 03 Feb 2026 08:40:46 -0500
X-MC-Unique: CSMzgqAVNPyU8o0ABkJs7w-1
X-Mimecast-MFC-AGG-ID: CSMzgqAVNPyU8o0ABkJs7w_1770126045
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806e7c4220so56233415e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 05:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770126045; x=1770730845; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hgnSI0cbDDbkSCP7huGpDrVnx8OOkSAH7uS6u96Q0Ww=;
 b=Hy7fiDUpwFE48Jude9X2KTAo1xNk5PnprXVMiyxuAc2WhiJODrATeIfqeSZ/xULSf0
 p/GfEppaAsFdd+68+6e9aqwqlfb8CQSTWditfnv3w0nlwHI9q9J0YVeR+LiVbzLSdQK3
 J6EFOtT1Hx+9ugAgFUtV5sTdIx4AVBTNRQ/fnP5vc4ZkMHKE6pOM1kKE+gzWAiqgae8b
 k6p9K3mcWgDl0YcC6XrGf6zn6kfkzdZrE3C4a59URPpSF7UMT/eK2n1Kui2VFxUXfGSA
 iSRe7OtjyuCn2hL1wdpSlXjD14ukAOw1VBFZhFF7aguKJOfoLZQKhtaU4QHgwv17bXgB
 dRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770126045; x=1770730845;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgnSI0cbDDbkSCP7huGpDrVnx8OOkSAH7uS6u96Q0Ww=;
 b=NE/+IZoefxSK9Ti0pWsAEbXRBZwEwzjHRRqAH+MySftrx1Fl6tlSCj09/V1AT2v/Bw
 JC++1ua9+XK2TU1b0PoETh+6HLJTnojQsDyUujMR+nmtMJG2xqDo/GNMiDTqT5kXkdNa
 Z13G6f426ne00/aBRggeoDFYXhRxyuK0Bo78ZmNCY46JVlOaHo5BHh/wM49dc0MVwzzK
 yTPJynlV13x1aFlSejXa8xfmLHF9Ks4r3+sCyWYX72cF2U0JMUKgQ4KEUkP8cPoShMwH
 iHy1CVT6EbBBvd0N2ALToKsWiYTcgFmmGOB1A7VREVe4Mi3C4aF0etYTSzmOP817gxEc
 NjIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVRzHDVh9+QFiBGA+Et1tixRLRMYiKy3II4clM+UEzq6hLzWynUMqkYqEADiNiOm5uMxFQF4TdfrDd@nongnu.org
X-Gm-Message-State: AOJu0YxHnQAiB6wKKOmAkgrNNh7EoV6Ma8GVUU6suRCt7vqD4TTdDgPp
 UlTwIG9VVl+P0ZKr+gLB03lk/CEjY9/PeABSIc4PCw+X8K1Vq3lNPvJGSlvkW+IddhXZxERF4dR
 IK68NISTop5UUB+TEzY77XYcW/et2ZUY9sJpzDVYa/qKHVhg2wrTlq6Ag
X-Gm-Gg: AZuq6aKFDCPFAhzFbkEtksO5cfci4J6atR/V6ElDbCuoPXe2REUKL+cLl3YPGDqKkJy
 HSfLXZtaXqgxReKcfgwj4LJdqoYN4mELtn0bDfA9ZiviN6F73243GFbV0+m6wPv5WVIRIypowQW
 crVHUkZotzZLFcsJFAudzjcwB8H/UJx/reqwcilQPqEZKUA34jPG6yE3hiJM2haj1UyRkJD+KCp
 BDo6KI5qEcyjsxD4K6dk1/L/eW+q2/F6EAqchJYVXp8Dth2K41Jjue3VSEosrtEYBX3hkrqVlNf
 SeUbgro0uoN+TpvQqZUmlv2iRQ3aBwTAXk5VRz61OcJfmnvRQRxuy/jegbbXNRcpGkSFEDixDvk
 XG70DbLQJe3XDEgkVLMk3kw5fDfMsXp2yQA==
X-Received: by 2002:a05:600c:b99:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-482db49a483mr199341565e9.28.1770126044460; 
 Tue, 03 Feb 2026 05:40:44 -0800 (PST)
X-Received: by 2002:a05:600c:b99:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-482db49a483mr199341185e9.28.1770126043979; 
 Tue, 03 Feb 2026 05:40:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051292bcsm95571285e9.5.2026.02.03.05.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 05:40:43 -0800 (PST)
Date: Tue, 3 Feb 2026 08:40:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Wafer Xie <wafer@jaguarmicro.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, angus.chen@jaguarmicro.com
Subject: Re: [PATCH] vdpa: fix cannot get vring base when stopping a
 vhost-vdpa device with multiple queues
Message-ID: <20260203084017-mutt-send-email-mst@kernel.org>
References: <20251029125001.15086-1-wafer@jaguarmicro.com>
 <CAJaqyWf+YxQAxM3e0H2Er=dYSbGHhadJQ5n=Lj_b4Ufa4z=HYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWf+YxQAxM3e0H2Er=dYSbGHhadJQ5n=Lj_b4Ufa4z=HYg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 06, 2025 at 09:04:46AM +0100, Eugenio Perez Martin wrote:
> On Wed, Oct 29, 2025 at 1:50 PM Wafer Xie <wafer@jaguarmicro.com> wrote:
> >
> > When stopping a vhost-vdpa device, only the first queue pair is marked as suspended,
> > while the remaining queues are not updated to the suspended state.
> > As a result, when stopping a multi-queue vhost-vdpa device,
> > the following error message will be printed.
> >
> > qemu-system-x86_64:vhost VQ 2 ring restore failed: -1: Operation not permitted (1)
> >
> > qemu-system-x86_64:vhost VQ 3 ring restore failed: -1: Operation not permitted (1)
> >
> > Fixes: b6662cb7 ("vdpa: add vhost_vdpa->suspended parameter")
> >
> > Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
> > ---
> >  hw/virtio/vhost-vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 7061b6e1a3..2d5e6aca74 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -1481,7 +1481,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
> >          return 0;
> >      }
> >
> > -    if (!v->suspended) {
> > +    if (!v->suspended && vhost_vdpa_first_dev(dev)) {
> 
> I'm sorry I missed this fix!
> 
> Good catch, thank you very much! But the right fix is to move
> v->suspended to v->shared, and then all the vhost_vdpa devices cannot
> have different suspended states.
> 
> Apart from that, please include the tag
> 
> Fixes: 0bb302a9960a ("vdpa: add vhost_vdpa_suspend")
> 
> In the patch description.
> 
> Thanks!


Eugenio do you want to post the fix?

> >          /*
> >           * Cannot trust in value returned by device, let vhost recover used
> >           * idx from guest.
> > --
> > 2.34.1
> >


