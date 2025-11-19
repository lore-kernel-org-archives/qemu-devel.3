Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7B9CEE356
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 02:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLYGG-0006rE-3p; Tue, 18 Nov 2025 21:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vLYGE-0006qm-Dn
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 21:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vLYGC-0003oS-0B
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 21:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763520569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFN5787goUW95COx2eIczpPfB9m5zQ8Y7f/ZSM1ROzY=;
 b=YZbsi9N7M/2NbsI251Fo6F0boRaWgWjtik2vcEGsl9bcDCIZc1L7hlccEGFUDQM4YrGHmK
 tH7R93s47kLnXz4t++Hgbp6lJ1qms9LVRXwL+7dMkne4bjGtLbn89b+F1OVeC5TYJy4YfP
 KdDvacOzf7teP8wIkO6g9aGNRfFt3LU=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-pZ41pPAgPaWf5XXHM3TpEA-1; Tue, 18 Nov 2025 21:49:25 -0500
X-MC-Unique: pZ41pPAgPaWf5XXHM3TpEA-1
X-Mimecast-MFC-AGG-ID: pZ41pPAgPaWf5XXHM3TpEA_1763520565
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-5dbfaf0bdb6so4218523137.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 18:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763520565; x=1764125365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zFN5787goUW95COx2eIczpPfB9m5zQ8Y7f/ZSM1ROzY=;
 b=J/EapCLbtyVBl4NIyTljzMhDyaNLQmwY/VX7Td+SmUs64AmWN+94BW4NQwDxe5vliB
 fp9n7h2KaCKTpDXV0NuCgYjrdKhh45kXojPxfbBrgocfVSSivgH2iXKGFL71uRsXatPT
 19LDRa7GNV6jOvVcuaG3X/x7671g88eQ0MpCx7wYRDzeuysqBqDNbXpJxNMM4F9JjPOd
 p/3gEIi8EUUK5rK1R++H9jM5Ze/flD8XeUTzYQfR59qTmedR/oo2KppeATHUJPzpdpp0
 ixwA+KCHF5K/q/ZQylBnh+vxMUiwJ7lRCJGirVXDleh/N+rpR1v/8nKctx6iOszvk8FO
 D+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763520565; x=1764125365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zFN5787goUW95COx2eIczpPfB9m5zQ8Y7f/ZSM1ROzY=;
 b=vGiLBg++qOrOs1xOt9ckJwhRpDK5IRxk/+0YsBiTzrZ13ooyN9edMECXBYZ9aS4VYR
 GYARI+66vKjoFjlbP0rOaey1jhsjDHKepcSTWl/BML4dyfCVpKK4V1EiFcbNJ5UzIP8P
 Zz6+yggkR1v/f/RfngY/kg+m5szaFd+VjDOhCTmiStjC+9BUS/cSa2O3jrbBrV7NpKOe
 KTic3K6mK58ovzbTJ1I7RVu/skpJtipOZCzBa+deHrIBiUwmKW3FSxUBISVb5BEyfQX9
 9+XtZckZqHbod5asO4xG4uBIGxlqB4/B8L9Lo9w+elhEeVJC6kHrjw+Jg8VKxEIbaLpS
 wpMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzQzZ8B6+yTBc5C/WyPgoXlInklYT4erRBx2TMJ7uVM+j+Lk6YMXcIkpQ/3F0V9qnjI+cJm4FRjE/j@nongnu.org
X-Gm-Message-State: AOJu0YxoFwk95r6xrf0d6kVBQZwaDhCLYGGfLoY2BWH9+waRjjohMbFp
 PF7NsRzEU1K7w+UH+Lngf2FiCLewz2CGbcIAcEjepX9WA1Mp/ckNe3DokNPfmw76q14Oh+GyHEA
 aTADN0snNdUHF2vV2nedEGwwpglfPfg/G2dR+3mrQJ9fAgGI9iNqmRApE8xrOxUvCmvVFX/fQtu
 JbQttwLTxVIM95YGoQevzNBez8at0Kpok=
X-Gm-Gg: ASbGnct+g7Mld0BG1f7t+xkKVfip6nO1gHmiQRXjnhJ5fS4eYsKtHcwEyGpshZ3nGjk
 F1wBNhFKPk/xXPekjFRPbG8uU68UeXsxDBKQURLd9Z7qE6ZAIQ4CM9N/ZQi75dbfdlGZJgU7DuC
 NXpp6PbTWyOfpDwpjkRbmqnXblPgA4vL7aQ1D+PrgrbkHCb90Xv6YqQIm7XMrMGMI=
X-Received: by 2002:a05:6102:6899:b0:5db:23ce:3db with SMTP id
 ada2fe7eead31-5dfc5535475mr6821179137.11.1763520564854; 
 Tue, 18 Nov 2025 18:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBqVgrgd0HzHRISrJ9GnkLzQ566DnGWivN+W4Uc+u2E/eeGEXUhNM4/Hdo9MSBgdvxhxV+zAYWJseUUfxU0Yo=
X-Received: by 2002:a05:6102:6899:b0:5db:23ce:3db with SMTP id
 ada2fe7eead31-5dfc5535475mr6821166137.11.1763520564307; Tue, 18 Nov 2025
 18:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
 <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
 <20251116014625-mutt-send-email-mst@kernel.org>
 <CACGkMEsxZvzyeqa_-9qQRfwNGAeCg5pLgu5MtEHr0OFWpA4_-g@mail.gmail.com>
 <20251117034940-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251117034940-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 10:49:11 +0800
X-Gm-Features: AWmQ_bkHSY_ruiYn3j5p7ioYW82b3xa8jxyDqhEQQ7yZVCam2bmXeQqzajSAH00
Message-ID: <CACGkMEsxTSG66StYpkStDqqJJmcTOSLjLH9DzNQ9WN=ffsUkDw@mail.gmail.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Nov 17, 2025 at 4:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 17, 2025 at 12:31:47PM +0800, Jason Wang wrote:
> > On Sun, Nov 16, 2025 at 2:53=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Fri, Nov 14, 2025 at 09:32:47AM +0800, Jason Wang wrote:
> > > > On Fri, Nov 14, 2025 at 1:47=E2=80=AFAM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Nov 13, 2025 at 12:12:38PM -0500, Peter Xu wrote:
> > > > > > On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > > On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > > > > > > > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirki=
n wrote:
> > > > > > > > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrot=
e:
> > > > > > > > > > We used to clear features silently in virtio_net_get_fe=
atures() even
> > > > > > > > > > if it is required. This complicates the live migration =
compatibility
> > > > > > > > > > as the management layer may think the feature is enable=
d but in fact
> > > > > > > > > > not.
> > > > > > > > > >
> > > > > > > > > > Let's add a strict feature check to make sure if there'=
s a mismatch
> > > > > > > > > > between the required feature and peer, fail the get_fea=
tures()
> > > > > > > > > > immediately instead of waiting until the migration to f=
ail. This
> > > > > > > > > > offload the migration compatibility completely to the m=
anagement
> > > > > > > > > > layer.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > >
> > > > > > > > > This is not really useful - how do users know how to twea=
k their
> > > > > > > > > command lines?
> > > > > > > > > We discussed this many times.
> > > > > > > > > To try and solve this you need a tool that will tell you =
how to start
> > > > > > > > > VM on X to make it migrateable to Y or Z.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > More importantly,
> > > > > > > > > migration is a niche thing and breaking booting perfectly=
 good VMs
> > > > > > > > > just for that seems wrong.
> > > > > > > >
> > > > > > > > IMHO Jason's proposal is useful in that it now provides a w=
ay to provide
> > > > > > > > ABI stablility but allows auto-ON to exist.
> > > > > > > >
> > > > > > > > If we think migration is optional, we could add a migration=
 blocker where
> > > > > > > > strict check flag is set to OFF, as I mentioned in the emai=
l reply to Dan.
> > > > > > > > As that implies the VM ABI is not guaranteed.
> > > > > > > >
> > > > > > > > Thanks,
> > > > > > >
> > > > > > >
> > > > > > > All you have to do is avoid changing the kernel and ABI is st=
able.
> > > > > > > Downstreams already do this.
> > > > > >
> > > > > > But the whole point of migration is allowing VMs to move betwee=
n hosts..
> > > > > > hence AFAIU kernel can change.
> > > > > >
> > > > > > Downstream will still have problem if some network features wil=
l be
> > > > > > optionally supported in some of the RHEL-N branches, because ma=
chine types
> > > > > > are defined the same in any RHEL-N, so IIUC it's also possible =
a VM booting
> > > > > > on a latest RHEL-X.Y qemu/kernel hit issues migrating back to a=
n older
> > > > > > RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have th=
e network
> > > > > > feature available..
> > > > > >
> > > > > > It's also not good IMHO to only fix downstream but having upstr=
eam face
> > > > > > such problems, even if there's a downstream fix...
> > > > > >
> > > > > > This thread was revived only because Jinpu hit similar issues. =
 IMHO we
> > > > > > should still try to provide a generic solution upstream for eve=
ryone.
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > --
> > > > > > Peter Xu
> > > > >
> > > > > failing to start a perfectly good qemu which used to work
> > > > > because you changed kernels is better than failing to migrate how=
?
> > > >
> > > > It doesn't:
> > > >
> > > > 1) the strict feature check will be only enabled in new machine typ=
es
> > > > 2) if kernel ABI is stable, qemu will keep working after upgrading
> > > > kernel even with strict check otherwise it would be a bug of kernel
> > > >
> > > > So I don't see it breaking anything if we make it start to work at =
11.0?
> > >
> > > Using QEMU from git suddenly requires upgrading the kernel or figurin=
g
> > > out obscure flags? Ugh.
> >
> > Only the setups are buggy that might meet this.
>
> I do git pull on qemu and have an old kernel. My setup just
> became buggy. No?
>
>
> > >
> > >
> > > > >
> > > > >
> > > > >
> > > > > graceful downgrade with old kernels is the basics of good userspa=
ce
> > > > > behaviour and has been for decades.
> > > >
> > > > Peter has given the example of how hard we can define gracefulness
> > > > (e.g migrate from a kernel w/ USO to a kernel w/o USO) and fix.
> > > >
> > > > Maybe we can think of a usersapce fallback to emulation of USO or
> > > > others, but I'm not sure if it's an overkill.
> > > >
> > > > >
> > > > >
> > > > > sure, let's work on a solution, just erroring out is more about b=
laming
> > > > > the user. what is the user supposed to do when qemu fails to star=
t?
> > > >
> > > > It's the first step as it's much better than silently clearing the
> > > > feature which may confuse both user and migration. We can use warni=
ngs
> > > > instead of errors but I'm not sure how much it can help.
> > >
> > >
> > > Well with this first step we have successfully blamed the user and
> > > the second step won't ever be taken.
> >
> > Are you suggesting to fix the management? E.g patching libvirt to
> > probe tap features?
>
> host features generally.
>
>
> > >
> > > > >
> > > > >
> > > > > first, formulate what exactly do you want to enable.
> > > > >
> > > > >
> > > > >
> > > > > for example, you have a set of boxes and you want a set of flags
> > > > > to supply to guarantee qemu can migrate between them. is that it?
> > > >
> > > > Mostly, it should work as a CPU cluster.
> > >
> > > the reason it kinda works with CPU cluster is simply because
> > > there is a final set of CPU models and you can not easily
> > > switch your CPU to a different model.
> >
> > We can define a set of TAP features as well, but I'm not sure it's
> > worthwhile to do this.
> >
> > >
> > > > So it's the responsibility of
> > > > the management layer, maybe we can develop some tool to report this=
 or
> > > > via qemu introspection ("query-tap" ?). Or if the management can do
> > > > this now, we don't even need to bother (or it can help to uncover
> > > > bugs). Anyhow, clearing a feature silently is not good and can cove=
r
> > > > bugs of various layers.
> > > >
> > > > Note that this issue is not specific to TAP, we may meet this for
> > > > vDPA/VFIO live migration as well. Basically, it should be the
> > > > responsibility of the management layer to deal with those migration
> > > > compatibility policies instead of using hard coded policies inside
> > > > Qemu. For qemu, it can simply error out when there's a mismatch
> > > > between features that are supported and features that are asked to
> > > > enable. We've suffered a lot in the past when trying to deal with t=
his
> > > > by Qemu.
> > > >
> > > > Thanks
> > >
> > > Yes but QEMU currently gives management no tools to figure out
> > > what is important for it.
> >
> > Using Qemu might be problematic as usually it doesn't not have privileg=
e.
> >
> > We can extend iproute, or a dedicated tool or ask libvirt to do this.
> > If libvirt could do the probe by itself, could we start from that?
> >
> > Thanks
>
> All I am saying is that I want to see how is management supposed to
> know what to enable.
>
> qemu already probes tap features.

Only part of the features.

> To me, it seems natural
> for management to do the probing through qemu.
> in fact your patch is a way to do that, is it not?

Yes and no.

> what it lacks though is a structured way to tell management how
> to fix the problem.

Probing through management seems to be better. For example it can
calculate the cluster in advance without the need to launch qemu
everywhere.

Or consider the case when USO is not supported by the kernel in the
destination, even if qemu reports this, I'm not sure what is expected
to be done in the management layer?

Thanks

>
> >
> > >
> > >
> > >
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


