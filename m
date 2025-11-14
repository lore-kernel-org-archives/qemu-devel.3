Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21462CD8CBF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 01:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJige-0003wE-IE; Thu, 13 Nov 2025 20:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJigV-0003lp-FU
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJigS-0000so-At
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 20:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763083981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5tusvnpNp8NbQcC7mNmB7wz1RMWtk496Zu0b9yFPZ60=;
 b=IlR6IqPPJ/wFee5BOQ4xW4hC27UATLbF+nRh3xEp3eCd5KVdypwvFC1f3Aejf5sUPY1gq0
 5aoygiOqiUob7+kKUdva/XbGJTPNkXdIxR4WPB4NHzFWd5eBi3lzWCtMJw1qv4pZWpi5O2
 R/HqtGvRkap+yHRuw2O/jtVBciX92hs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-MSOVyyyeOeCfCd1kBX-R8A-1; Thu, 13 Nov 2025 20:33:00 -0500
X-MC-Unique: MSOVyyyeOeCfCd1kBX-R8A-1
X-Mimecast-MFC-AGG-ID: MSOVyyyeOeCfCd1kBX-R8A_1763083979
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-295595cd102so35357445ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 17:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763083979; x=1763688779; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5tusvnpNp8NbQcC7mNmB7wz1RMWtk496Zu0b9yFPZ60=;
 b=OTUNM6IZSk/lPVAAjVP/U5DbL5mtBbn5cFgCxnBSGsrBOc6qd87Oz/QIGVcOAgc0NA
 8QH8l7lzzcJjidsQVB7kXgxwIIqM0Zefw56G/ECoCvmaYN1T7hiMOVaaIVq1Bhsf55nG
 vYebFRrLTXmMs7xvNnGIV4d/0aAaxZgrM7nICoqrf5nAtGGNMMJyIBF4qVxvyVdDVgT/
 mbOlaXYGjlHnLxE1DpLjkeaOyrjnpBnUOsI0wUsBecGh2DFUsLiJPyVKWZCHR+NkKkFX
 wkD4w5gJy7HvhehKgpP3HNBFD3QbBi70JLSbETb5wUWZ6TRwWHGqnP6DvW+n9our8gn1
 UK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763083979; x=1763688779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5tusvnpNp8NbQcC7mNmB7wz1RMWtk496Zu0b9yFPZ60=;
 b=dQHOllzELanFk5mpZeS1LmpLewbETecEmpoHMsNmpWBXQR+caYM3zMSlacHna3dHPo
 BjJZRmSyhHkLz93xwFxLmIjItFRY73CcD9OSKeuIizxr981gXpRTZvTKZyubzAEzkC17
 u5W4Bbhx3cPjB/7uxM8AEiSkv8lALzOOcGS/rNO4N6qR3fI94Npzn+5EtzAsdcAbcSol
 oPqT9sh4Nu2WpL0B6IVM2gKpHl9YBhpuTlWZeWXF8um3h8xKqhjmdzUqyElyms+lfWnF
 Mb+8oOSFwHCWOyCo/Qt00i0B1a97YPlJc7NYhKAEo2UNAZvcrPTtqukKmE6BZyJS1O3s
 J0Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+OokFw5Jh2nV82Ov5Wq8Y4j9duFG97BuSl5jtnz7v5Y2FJZ3MH3IKuUeFv6wwtlXp4bedyEJp7vCT@nongnu.org
X-Gm-Message-State: AOJu0Yx0zo25vsjZe2ypLeja+3q7KbGw+89GShp/OUtncwJQq6+eFh2V
 V8L0VfTK2QxmzDQJr+pxDSsVLt5NDQW91PMeICGUzXQIO2tlvnFo6n99sjeLgKOCqnEYhbONQcW
 Rp3mh8+GigMceNvIsiv4wrsEs5YiWh/g+h1yotTS6ChPsFf0eVZdfVoCmqObd3RdiD4nvoBYtjy
 R3wGoR8Pi/iKv3Z1Ji8VSo5bzv0vK+Lt8=
X-Gm-Gg: ASbGncvFz+BP14blxth5Z3Quj4DziRpHbIoWGX2mHNFVcf14KWmVELHvZdYm1isocJF
 XEH92sgYRDqRk2e8/8B5yNVIr4icsWT48IA5UzNxhlwZ3LQp3w8PRk5dQ0YvjvpA/u1ohR/sUyv
 MTyULDXMbr4BtMkNZgrE2W5X5YcKB4k8k6UxaWDeFzdUOLWzRK9IH32F8AfaiHoNIZ
X-Received: by 2002:a17:903:1211:b0:269:6052:3536 with SMTP id
 d9443c01a7336-2986a7569d3mr10589895ad.45.1763083978891; 
 Thu, 13 Nov 2025 17:32:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaDf1IrwBil6hgbSDQya/BHGycx/ApZMj5Te/YQ2kRlbPS6VJFueI/1g/P4mqlQ9M13l5mx/6gR3m+iCRGZSo=
X-Received: by 2002:a17:903:1211:b0:269:6052:3536 with SMTP id
 d9443c01a7336-2986a7569d3mr10589685ad.45.1763083978430; Thu, 13 Nov 2025
 17:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251113124207-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 Nov 2025 09:32:47 +0800
X-Gm-Features: AWmQ_bkUIOwbqttSHdfCUpv79bLywXbuc7-o1IWsdpcH-Z7ISwgdOpS2_dfsYuA
Message-ID: <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com, 
 thuth@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 14, 2025 at 1:47=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Nov 13, 2025 at 12:12:38PM -0500, Peter Xu wrote:
> > On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wrote:
> > > On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > > > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> > > > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > > > > We used to clear features silently in virtio_net_get_features()=
 even
> > > > > > if it is required. This complicates the live migration compatib=
ility
> > > > > > as the management layer may think the feature is enabled but in=
 fact
> > > > > > not.
> > > > > >
> > > > > > Let's add a strict feature check to make sure if there's a mism=
atch
> > > > > > between the required feature and peer, fail the get_features()
> > > > > > immediately instead of waiting until the migration to fail. Thi=
s
> > > > > > offload the migration compatibility completely to the managemen=
t
> > > > > > layer.
> > > > > >
> > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >
> > > > > This is not really useful - how do users know how to tweak their
> > > > > command lines?
> > > > > We discussed this many times.
> > > > > To try and solve this you need a tool that will tell you how to s=
tart
> > > > > VM on X to make it migrateable to Y or Z.
> > > > >
> > > > >
> > > > > More importantly,
> > > > > migration is a niche thing and breaking booting perfectly good VM=
s
> > > > > just for that seems wrong.
> > > >
> > > > IMHO Jason's proposal is useful in that it now provides a way to pr=
ovide
> > > > ABI stablility but allows auto-ON to exist.
> > > >
> > > > If we think migration is optional, we could add a migration blocker=
 where
> > > > strict check flag is set to OFF, as I mentioned in the email reply =
to Dan.
> > > > As that implies the VM ABI is not guaranteed.
> > > >
> > > > Thanks,
> > >
> > >
> > > All you have to do is avoid changing the kernel and ABI is stable.
> > > Downstreams already do this.
> >
> > But the whole point of migration is allowing VMs to move between hosts.=
.
> > hence AFAIU kernel can change.
> >
> > Downstream will still have problem if some network features will be
> > optionally supported in some of the RHEL-N branches, because machine ty=
pes
> > are defined the same in any RHEL-N, so IIUC it's also possible a VM boo=
ting
> > on a latest RHEL-X.Y qemu/kernel hit issues migrating back to an older
> > RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have the networ=
k
> > feature available..
> >
> > It's also not good IMHO to only fix downstream but having upstream face
> > such problems, even if there's a downstream fix...
> >
> > This thread was revived only because Jinpu hit similar issues.  IMHO we
> > should still try to provide a generic solution upstream for everyone.
> >
> > Thanks,
> >
> > --
> > Peter Xu
>
> failing to start a perfectly good qemu which used to work
> because you changed kernels is better than failing to migrate how?

It doesn't:

1) the strict feature check will be only enabled in new machine types
2) if kernel ABI is stable, qemu will keep working after upgrading
kernel even with strict check otherwise it would be a bug of kernel

So I don't see it breaking anything if we make it start to work at 11.0?

>
>
>
> graceful downgrade with old kernels is the basics of good userspace
> behaviour and has been for decades.

Peter has given the example of how hard we can define gracefulness
(e.g migrate from a kernel w/ USO to a kernel w/o USO) and fix.

Maybe we can think of a usersapce fallback to emulation of USO or
others, but I'm not sure if it's an overkill.

>
>
> sure, let's work on a solution, just erroring out is more about blaming
> the user. what is the user supposed to do when qemu fails to start?

It's the first step as it's much better than silently clearing the
feature which may confuse both user and migration. We can use warnings
instead of errors but I'm not sure how much it can help.

>
>
> first, formulate what exactly do you want to enable.
>
>
>
> for example, you have a set of boxes and you want a set of flags
> to supply to guarantee qemu can migrate between them. is that it?

Mostly, it should work as a CPU cluster. So it's the responsibility of
the management layer, maybe we can develop some tool to report this or
via qemu introspection ("query-tap" ?). Or if the management can do
this now, we don't even need to bother (or it can help to uncover
bugs). Anyhow, clearing a feature silently is not good and can cover
bugs of various layers.

Note that this issue is not specific to TAP, we may meet this for
vDPA/VFIO live migration as well. Basically, it should be the
responsibility of the management layer to deal with those migration
compatibility policies instead of using hard coded policies inside
Qemu. For qemu, it can simply error out when there's a mismatch
between features that are supported and features that are asked to
enable. We've suffered a lot in the past when trying to deal with this
by Qemu.

Thanks

>
>
>
> --
> MST
>


