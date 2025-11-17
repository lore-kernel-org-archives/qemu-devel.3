Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362C0CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 04:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKquR-0003Dm-IQ; Sun, 16 Nov 2025 23:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vKquO-0003Ac-72
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 23:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vKquL-0001ES-C1
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 23:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763353922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnz6U0nU+bJLJstQwbNQzNvG0aoWuUd9YgXrbfCr/Pg=;
 b=hIldzefwmdZDmxjxjQXrK5BY2IYee1mQCgjDUWCLVMSeNty6yC+eXX4g4HvI6qkeiDUw3y
 LXyVS5qk6v6JQeB1m2xhHVYBP+qeb5Z7leEfwKzMWuiEnnGxAb/6N1HdESQw6ZZYwETfUf
 /h/mFb91cR3KiETy7x7X9l6dTu+leKs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-oj6IIjHBN5KS2lNhFL3C0A-1; Sun, 16 Nov 2025 23:32:01 -0500
X-MC-Unique: oj6IIjHBN5KS2lNhFL3C0A-1
X-Mimecast-MFC-AGG-ID: oj6IIjHBN5KS2lNhFL3C0A_1763353920
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3416dc5754fso6793830a91.1
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 20:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763353920; x=1763958720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnz6U0nU+bJLJstQwbNQzNvG0aoWuUd9YgXrbfCr/Pg=;
 b=ATXuDQ/lltYclPfGHvv4DPSy3cxDhEfBm9mgcN3s+BxLrA7V671MvmMeujfEYnFG+C
 y1ocoN9x8AxA3mx4SFVBElCFb/6njrUma4opZTHeaKlYx9QD6qSf2f6eUSV4kgnGNOri
 JF/MFNtxDPErHguc9IVJMlRcbtPNHMCp6CwMtwgsEUvA1l9Y39O/ZAfaZI1mMcvo1sHZ
 iBcct8SZnSN2aiQX6pQBYrK7lN+85XxVp8Q+RXF85cUvfmkJa6RXyIAX6FZiyY6u31Kp
 mnPPVNR+bVy8Ae7ljJzUKwzYeL7798PxbJdcJI7G8uBbhqe9OcAr85CSu2jsIRZWdv9f
 YfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763353920; x=1763958720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnz6U0nU+bJLJstQwbNQzNvG0aoWuUd9YgXrbfCr/Pg=;
 b=e79n9zwirCJGcW6VNWKdVTBe3YeuIad5v20OK8Lx0wCNuqZirfKU2h/8hinPQmHMxo
 kDcK/+3v6ACfe45LRMoKAaRJmuBcsoGPUhzelZADkoC9Ze/JwvkXLFiHohLlOU5eKEBf
 PTkA5hjI5heSsSU6OUIlD6GbL37btv36xgHHsiTEqVTMRDVVFWNp/Iv7x6rc/Zxd9GZH
 WoX06gwCszRRmyp5Y/VNAiwq3w0wqpqqZUhIXSD5hFBTOZfljoxgKTkWKjXPN2VlCcjG
 p1FVLtVA43GioqzjrbgGj1EehR3qFGu3gFitw1ITIAI5ROBqjpQvHUYHCY0RzF6fmJ74
 /P0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0kgrQtj/GJsK8h2TUm001vO45UH/qHiMw/FSSX2nqumCuVfARUwRYHrmXkLSQqEKmteGxfvsZFzEW@nongnu.org
X-Gm-Message-State: AOJu0Yy3aghdcIVa9ByvUooPVaNEZF1FuuUvLOK+FJGiJqqQaYgx236K
 5+UEB3/SLsnkm6EVYIJX3sEswB9DfqNEMe9zzMU9wrkv5jNfP7CZWbeZP9JF5I9E1g0INsem+w6
 sp/l2qH77z+CReVwJqs3jhP4NPL4ipcj3SQyrlszAWzdaWgKNV5PTMAl4n+u0XVy+n9LLhNhv4W
 qk+wJMCpVHFgxJHFon8qEuxIb3Vv4HR18=
X-Gm-Gg: ASbGncuS+r+2VpqjV78AaxhvFC5y/WEIXyBPF2BnD/8/Qf1GpzjEWswkfAb+U6KhuYg
 9Gz25WQT9N35x7mK4ASMS5oZjoSiqFbgARdgdn09BCPgXf3ELdYkje0L+1mFPjy3ZP7pNN9rzw3
 2jIr2Lm6JU9LlIuRejJwwDPA3sjI6CHssgZm4tVF1+vReS3XbZZo+WTMQnbgmZgMKIXDg=
X-Received: by 2002:a17:90b:2e0b:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-343fa774e3cmr13710487a91.37.1763353920008; 
 Sun, 16 Nov 2025 20:32:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdJ9YEivO6odkvpPz+NfwN6jbab+J5NKa/eD/EsEzai8Cks028O4rTGfY+clkCA5PF1B9I8sG6Nfn0n2yYzyQ=
X-Received: by 2002:a17:90b:2e0b:b0:340:d1a1:af8e with SMTP id
 98e67ed59e1d1-343fa774e3cmr13710462a91.37.1763353919515; Sun, 16 Nov 2025
 20:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
 <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
 <20251116014625-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251116014625-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Nov 2025 12:31:47 +0800
X-Gm-Features: AWmQ_bmAk86lXMMtI2gyG4cdNms2Q8un-yKYYyaT0_aNy0dBm4gTVxIKe0YgQrA
Message-ID: <CACGkMEsxZvzyeqa_-9qQRfwNGAeCg5pLgu5MtEHr0OFWpA4_-g@mail.gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com, 
 thuth@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Nov 16, 2025 at 2:53=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Nov 14, 2025 at 09:32:47AM +0800, Jason Wang wrote:
> > On Fri, Nov 14, 2025 at 1:47=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Nov 13, 2025 at 12:12:38PM -0500, Peter Xu wrote:
> > > > On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wrote:
> > > > > On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > > > > > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wr=
ote:
> > > > > > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > > > > > > We used to clear features silently in virtio_net_get_featur=
es() even
> > > > > > > > if it is required. This complicates the live migration comp=
atibility
> > > > > > > > as the management layer may think the feature is enabled bu=
t in fact
> > > > > > > > not.
> > > > > > > >
> > > > > > > > Let's add a strict feature check to make sure if there's a =
mismatch
> > > > > > > > between the required feature and peer, fail the get_feature=
s()
> > > > > > > > immediately instead of waiting until the migration to fail.=
 This
> > > > > > > > offload the migration compatibility completely to the manag=
ement
> > > > > > > > layer.
> > > > > > > >
> > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > >
> > > > > > > This is not really useful - how do users know how to tweak th=
eir
> > > > > > > command lines?
> > > > > > > We discussed this many times.
> > > > > > > To try and solve this you need a tool that will tell you how =
to start
> > > > > > > VM on X to make it migrateable to Y or Z.
> > > > > > >
> > > > > > >
> > > > > > > More importantly,
> > > > > > > migration is a niche thing and breaking booting perfectly goo=
d VMs
> > > > > > > just for that seems wrong.
> > > > > >
> > > > > > IMHO Jason's proposal is useful in that it now provides a way t=
o provide
> > > > > > ABI stablility but allows auto-ON to exist.
> > > > > >
> > > > > > If we think migration is optional, we could add a migration blo=
cker where
> > > > > > strict check flag is set to OFF, as I mentioned in the email re=
ply to Dan.
> > > > > > As that implies the VM ABI is not guaranteed.
> > > > > >
> > > > > > Thanks,
> > > > >
> > > > >
> > > > > All you have to do is avoid changing the kernel and ABI is stable=
.
> > > > > Downstreams already do this.
> > > >
> > > > But the whole point of migration is allowing VMs to move between ho=
sts..
> > > > hence AFAIU kernel can change.
> > > >
> > > > Downstream will still have problem if some network features will be
> > > > optionally supported in some of the RHEL-N branches, because machin=
e types
> > > > are defined the same in any RHEL-N, so IIUC it's also possible a VM=
 booting
> > > > on a latest RHEL-X.Y qemu/kernel hit issues migrating back to an ol=
der
> > > > RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have the ne=
twork
> > > > feature available..
> > > >
> > > > It's also not good IMHO to only fix downstream but having upstream =
face
> > > > such problems, even if there's a downstream fix...
> > > >
> > > > This thread was revived only because Jinpu hit similar issues.  IMH=
O we
> > > > should still try to provide a generic solution upstream for everyon=
e.
> > > >
> > > > Thanks,
> > > >
> > > > --
> > > > Peter Xu
> > >
> > > failing to start a perfectly good qemu which used to work
> > > because you changed kernels is better than failing to migrate how?
> >
> > It doesn't:
> >
> > 1) the strict feature check will be only enabled in new machine types
> > 2) if kernel ABI is stable, qemu will keep working after upgrading
> > kernel even with strict check otherwise it would be a bug of kernel
> >
> > So I don't see it breaking anything if we make it start to work at 11.0=
?
>
> Using QEMU from git suddenly requires upgrading the kernel or figuring
> out obscure flags? Ugh.

Only the setups are buggy that might meet this.

>
>
> > >
> > >
> > >
> > > graceful downgrade with old kernels is the basics of good userspace
> > > behaviour and has been for decades.
> >
> > Peter has given the example of how hard we can define gracefulness
> > (e.g migrate from a kernel w/ USO to a kernel w/o USO) and fix.
> >
> > Maybe we can think of a usersapce fallback to emulation of USO or
> > others, but I'm not sure if it's an overkill.
> >
> > >
> > >
> > > sure, let's work on a solution, just erroring out is more about blami=
ng
> > > the user. what is the user supposed to do when qemu fails to start?
> >
> > It's the first step as it's much better than silently clearing the
> > feature which may confuse both user and migration. We can use warnings
> > instead of errors but I'm not sure how much it can help.
>
>
> Well with this first step we have successfully blamed the user and
> the second step won't ever be taken.

Are you suggesting to fix the management? E.g patching libvirt to
probe tap features?

>
> > >
> > >
> > > first, formulate what exactly do you want to enable.
> > >
> > >
> > >
> > > for example, you have a set of boxes and you want a set of flags
> > > to supply to guarantee qemu can migrate between them. is that it?
> >
> > Mostly, it should work as a CPU cluster.
>
> the reason it kinda works with CPU cluster is simply because
> there is a final set of CPU models and you can not easily
> switch your CPU to a different model.

We can define a set of TAP features as well, but I'm not sure it's
worthwhile to do this.

>
> > So it's the responsibility of
> > the management layer, maybe we can develop some tool to report this or
> > via qemu introspection ("query-tap" ?). Or if the management can do
> > this now, we don't even need to bother (or it can help to uncover
> > bugs). Anyhow, clearing a feature silently is not good and can cover
> > bugs of various layers.
> >
> > Note that this issue is not specific to TAP, we may meet this for
> > vDPA/VFIO live migration as well. Basically, it should be the
> > responsibility of the management layer to deal with those migration
> > compatibility policies instead of using hard coded policies inside
> > Qemu. For qemu, it can simply error out when there's a mismatch
> > between features that are supported and features that are asked to
> > enable. We've suffered a lot in the past when trying to deal with this
> > by Qemu.
> >
> > Thanks
>
> Yes but QEMU currently gives management no tools to figure out
> what is important for it.

Using Qemu might be problematic as usually it doesn't not have privilege.

We can extend iproute, or a dedicated tool or ask libvirt to do this.
If libvirt could do the probe by itself, could we start from that?

Thanks


>
>
>
> > >
> > >
> > >
> > > --
> > > MST
> > >
>


