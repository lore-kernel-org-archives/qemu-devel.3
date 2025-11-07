Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564BBCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 01:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHAsP-00075h-Nb; Thu, 06 Nov 2025 20:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHAsO-00075O-FJ
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 20:02:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vHAsL-000328-8T
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 20:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762477366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iA6R51NppfR5cHA1/MFKh6KbuPuatj6OSELOYsrOzT4=;
 b=avAe5GUAWEY8OoqtRjAoFhGzgzDbFHL34x/5FbyWSAZ8ibBZDQ7hVCw+Fxkk4GFeJvdRjS
 Xp4e/WY1vr3LCriS4l00m6vD1xcX0azM/ud0QMIpDVXDJ3QHd9FRR5xAOvjjyA3K8fM7/0
 4Jh/VkrfLAwN577pqSAecatsSMv+xtA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-Di9P-URSPKifkmRc-W0KdQ-1; Thu, 06 Nov 2025 20:02:44 -0500
X-MC-Unique: Di9P-URSPKifkmRc-W0KdQ-1
X-Mimecast-MFC-AGG-ID: Di9P-URSPKifkmRc-W0KdQ_1762477364
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32eb18b5500so436681a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 17:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762477364; x=1763082164; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA6R51NppfR5cHA1/MFKh6KbuPuatj6OSELOYsrOzT4=;
 b=lMZ+fLoLchJPIJo0OhYT96nFHXLCjnSXLzXAJG0ZOb2yneLAMjhKX3t1dIDLT4c2EU
 qyYGP+N7o2As4qvgCz0BkDrkDQw32Qw9TAXT3tIAtOFWqWbMaSDxeVWcylquXmzWxrjh
 QjLXzk3Ai44XtAVTFNEqt2io5iJBQUWhimZnes98l8WfbzY7rXeXTdB44K7jMjZrRJAU
 Gw5AdJ2SzFSgh8iV4FkkV/kiJGPafUS9tCPW+EzebVgxEzkdEeFvOSfLa9IBgNxmolD2
 wHyDj1EIZyiHpx9VFP6EY56vNLG2ayXAqzrmF2DPEg7COHUKA0K2CK2GnKuMTrvJvPVg
 N4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762477364; x=1763082164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iA6R51NppfR5cHA1/MFKh6KbuPuatj6OSELOYsrOzT4=;
 b=dBGZ6Rg5gVhE8zW2c9Utiqb67+dG+1tPxZ2nk5hlDxiBpanIxtq4PgRhIpn2vkKXo2
 DLiPmmkK9BxHayOn0x66vRhFTwNYR2uJ4QblBP7qCmHfw6UYm3TCSMqN3hOOHMlO9x59
 j8n3N3wvJvc4OmvLpYs9FmnR9w0YWQL5eLsbjf/N2/TMJw6luuZHrp3XYe5xkZoWoMNG
 l2qIxkqU7F+yDoHNm+H3fKhNc7l6zM3bc9hJRTSFzwbJUhtsuzuAgaqIYZSv9WqDBA3j
 9z2yCsnq0ILesqomXPN90V7xj5FOrNQydig43+0Nw8gLu7BEqZb+uzVQ5Umue4qpQnT4
 shkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRs+azNOE6dN7WaYRf52JcpZFCLVCDwAt0Hqib0XLkmU8LuwMgatBILI+CvyzxGmxdarNZkQ8PJuvL@nongnu.org
X-Gm-Message-State: AOJu0YwRRu7yr4Co/6HVQgEyCEYuF6sJZEuThzdtzIWiReeXYcv2obgE
 dzOcea/RmAIEthK3pffgsNWzPMOhSd7omJoCf8gvUa6r1bk1kI+iHeMJjsP50lahdkVBNe6QqYd
 bW4Ci9rUaMaoSl17AWI0hIUchxlD6MI26kd241H0fHdY+dgvj45jIAwNwas2tuY60hZDiCg5ZeK
 U2Dm6iQ1hR3iDjWXIasuo6TOulPRPNY3I=
X-Gm-Gg: ASbGnctQe2oCxBvszNyRr9j9Dw1to7NEAxeZ5MqCxeEKJg/SnZUZtgnFi6aHBUCKpJI
 wfgE2QhRByXdT+5jrLZxzi8R2K7gxt98dTajCqxP6poicYFvgxyutihJFGd0fiJ0vt2gR6Lc12d
 HoSKlkytPITL4apGXZtJ7cCFpUdG6PxMWt1BYr58qC48fEPC+BiBtEkCK8
X-Received: by 2002:a17:90b:3c86:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-3434c595d5amr1433947a91.34.1762477363699; 
 Thu, 06 Nov 2025 17:02:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEextbh87DM57SQGIS+bcXmmzLiZFjKMMT4cF29KgvAO4KKGvFJW1udPbK1OdaTSv/0fF+8p9NLlsDIPasE5dY=
X-Received: by 2002:a17:90b:3c86:b0:33b:be31:8194 with SMTP id
 98e67ed59e1d1-3434c595d5amr1433892a91.34.1762477363210; Thu, 06 Nov 2025
 17:02:43 -0800 (PST)
MIME-Version: 1.0
References: <CAMGffE=cZ_TgG=Ae+oVE+emWwuDNssozKNDsidS1+yTrh=cZXQ@mail.gmail.com>
 <CACGkMEtUx0PigJrJSWY8n2N7+znc02aqotNq+Y5w3aOMOvUvjQ@mail.gmail.com>
 <CAMGffE=cqr1awRmhAMg3V82_g1-2aM36oV+hWPuczs6VUCQkgw@mail.gmail.com>
 <aQvM6l04VeZwbUOf@x1.local>
 <CAMGffE=VdsQSTOOpBvaDc=RQ98cMDHYemF7nS5pnqJ7Rsvafug@mail.gmail.com>
In-Reply-To: <CAMGffE=VdsQSTOOpBvaDc=RQ98cMDHYemF7nS5pnqJ7Rsvafug@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Nov 2025 09:02:31 +0800
X-Gm-Features: AWmQ_bme-68IsSDAXWBwh0C1EuuXbrNbdgcwI9arPT4a35udKD21kDMFSKIjcn4
Message-ID: <CACGkMEtMK1_QJM7x33sLO-QOtdttV=8hBfH8YbYSB_-GDE6CTg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D_Migration_failure_between_QEMU_9=2E2=2E4_=E2=86=92_8?=
 =?UTF-8?Q?=2E2=2E10_due_to_virtio=2Dnet_feature_mismatch_=28VIRTIO=5FF=5FRING=5FRESE?=
 =?UTF-8?Q?T_=2F_USO_features=29?=
To: Jinpu Wang <jinpu.wang@ionos.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-stable@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>, Yu Zhang <yu.zhang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Nov 6, 2025 at 10:28=E2=80=AFPM Jinpu Wang <jinpu.wang@ionos.com> w=
rote:
>
> Hi Peter,
> On Wed, Nov 5, 2025 at 11:17=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > On Wed, Nov 05, 2025 at 10:27:59AM +0100, Jinpu Wang wrote:
> > > > > These are not present (or not supported) on QEMU 8.2.10, which ca=
uses
> > > > > the migration state load to fail.
> > > >
> > > > Interesting, we've already done the compat work:
> > > >
> > > > GlobalProperty hw_compat_8_1[] =3D {
> > > >     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> > > >     { "ramfb", "x-migrate", "off" },
> > > >     { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > > >     { "igb", "x-pcie-flr-init", "off" },
> > > >     { TYPE_VIRTIO_NET, "host_uso", "off"},
> > > >     { TYPE_VIRTIO_NET, "guest_uso4", "off"},
> > > >     { TYPE_VIRTIO_NET, "guest_uso6", "off"},
> > > > };
> > > > const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > > Yeah, I noticed the same.
> >
> > AFAICT, this is a known issue..
> >
> > Thomas and I used to suggest we should not turn on USO* by default by
> > probing kernel, but only allow user choosing it explicitly in a VM
> > setup. IOW, dest qemu should stop booting at all when kernel is too old
> > (when user chose the feature).
> I feel this is the approach we should have picked.
> >
> > See:
> >
> > https://lore.kernel.org/all/ZqQNKZ9_OPhDq2AK@x1n/
> Is there any effort to allow migration from new OS support the USO
> features to old OS doesn't support it?

You can teach your management to disable USO via the qemu command line.

> Any hint to make it work?

Thanks

> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
> Thx for the help.
>


