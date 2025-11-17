Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D616CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKv3R-0006NT-7e; Mon, 17 Nov 2025 03:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKv3P-0006LR-Cn
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:57:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKv3N-0007sK-Gr
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vYN0adOkO4/lh5yoFDJwk47zhsjwyBHAOsAxIerVHMs=;
 b=QwtB0neRlEs9sFSEd5d4q+HBHAXS0v0W61GAAYfIXN+an1r2YsjgVBUrVQvIfAg+4gOJ7Z
 sBDa/w4+LHmafPYe/WgtITEqT4ZCs6rjtAMVL6CoNCJ//PPen25Tv4E6AJjLr2fJZHVS79
 EXTovsAHVuqbSQG+W/5HeiPsZtxD9+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-p_xTLZYPOMWwTH9q5coNLw-1; Mon, 17 Nov 2025 03:57:38 -0500
X-MC-Unique: p_xTLZYPOMWwTH9q5coNLw-1
X-Mimecast-MFC-AGG-ID: p_xTLZYPOMWwTH9q5coNLw_1763369857
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c7b0ae36so2196051f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763369857; x=1763974657; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vYN0adOkO4/lh5yoFDJwk47zhsjwyBHAOsAxIerVHMs=;
 b=DfQFcIF8kWJRXKTO2y8Khy0fNwl78UxDY9KzI4vziBtuaRPnDgJe/lN3fDn5ISRYUs
 0RMFQdyfocMEvhVhT2k/5xdyIYJv0bspMfFyzk3jNvSsC5RF4OW9B1qplzaD5eEnfDvW
 e4RekcBGQVHvmUjgYsUxUVjH8V8u2faWYFqbPAY9euedNIQj71wJ0NKUpnCQcilYt31F
 OgDwBpzqMZov4KZzbXFRqbZSHY4vM1bJAsKPZ0Q+HS8JKMqA1/0DxP3TtbZt3IFC/jr7
 sj8ufsYU0vDHJ8sZVlhcbttaeqXi7HqFoWq95spdvZAVD6FuQrtKtvWQgo+UvfDT1feC
 Uk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369857; x=1763974657;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYN0adOkO4/lh5yoFDJwk47zhsjwyBHAOsAxIerVHMs=;
 b=B+2AI7WZQQnh3B3o2ZT+VaQECx4yqtTaHwbq7LSACcc+r4xvkp8vaLG0aN61DCvq2w
 YNWsotShRQu469gB42Do3lt+ItarLR1k2bEcbfruCSnJBKuR/GiyTxt8S+vy+H2SttvV
 kribxAVbC28g7+lQwTw7RarZ/DgtHCOq+U8K2H23t9bqB3QjWnhH7aq/Gq6Iw7qApxQb
 iYN9l9+nVIBDu5UZ+iKhte9U5qiC87vdPYjICIjYl5UXPA3vixnYhIExLVlZN3CHjixn
 VC7eYQ/oZt3cNECbMmrnc9Xoz+DA28g5Qe1iXDTLVEt/GQvHLvUCGu4c1nyxi0ZcgD9i
 235A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPTf7Dd/PVzTKx/dJN4TuTPl39ljuxkN+FAt5WwBJEqA7Pn8WfK6MgTIBVbdV3JwwQgOBz9XjzfshP@nongnu.org
X-Gm-Message-State: AOJu0Yy83ndYzEp2J1tCGm8F5rHwSgUbMx2h4GZSm9VPb+84kf+pxwXL
 jpLVqFWeNpZ1650RjwBFoME/hWBMWF6nIQNV8cQK6n82l0wBV+bixt+07TkH0iPxx2w842z4+UE
 7c6IRRX8LEeFM2n6pc3RgTVEt4Tkzwib17eirGdo4jRdjj6i6v8x44HWbag7JddZS
X-Gm-Gg: ASbGncslfI/+zWhNLiteAmEmtmmwW/ACZ08GQTg8UBKG4Hw56KiFYoAu1YOxH/GaQPH
 xRCW/j/eqsjSV1Y2zUqagbZYDlvnRM74E9Fa1NOvxMQzf9OlEGEWoinkoyCKsZUo0VJXS2IQQlH
 Mq7LGbohs20JwYBD453xig0gFdw15bVRYGv58cmeSt8RbGkn9wUAVVf0fep5LMEH46fkaSLHMFB
 52PreQXtY/4K33Cx91OvoWqHStK4j49Xg4r3iqVAZM6EP/lLjjkrYqAhgFrU4BaIvc+8kns0JID
 4VFFtlfnqVxF9j+OLNxlwSnsEc/cd8OjlhfN3jfSbWFYuJiuIZ+iJ5ot9HbrO2yORMtMjaJ+wH3
 MUpysDhoz3muJVZPqyVE=
X-Received: by 2002:a05:6000:178d:b0:429:ca7f:8d6f with SMTP id
 ffacd0b85a97d-42b58db7c27mr11824662f8f.15.1763369857048; 
 Mon, 17 Nov 2025 00:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJcWmA/Y/EKwRuZRxSHSp0kNYHECSdtJhoZjVd22zimf72axgkqNPdaX7DsXPDjYKxd7FvSA==
X-Received: by 2002:a05:6000:178d:b0:429:ca7f:8d6f with SMTP id
 ffacd0b85a97d-42b58db7c27mr11824628f8f.15.1763369856494; 
 Mon, 17 Nov 2025 00:57:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e97a87sm25802607f8f.20.2025.11.17.00.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 00:57:35 -0800 (PST)
Date: Mon, 17 Nov 2025 03:57:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251117034940-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
 <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
 <20251116014625-mutt-send-email-mst@kernel.org>
 <CACGkMEsxZvzyeqa_-9qQRfwNGAeCg5pLgu5MtEHr0OFWpA4_-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEsxZvzyeqa_-9qQRfwNGAeCg5pLgu5MtEHr0OFWpA4_-g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Mon, Nov 17, 2025 at 12:31:47PM +0800, Jason Wang wrote:
> On Sun, Nov 16, 2025 at 2:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Nov 14, 2025 at 09:32:47AM +0800, Jason Wang wrote:
> > > On Fri, Nov 14, 2025 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 13, 2025 at 12:12:38PM -0500, Peter Xu wrote:
> > > > > On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > > > > > > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> > > > > > > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > > > > > > > We used to clear features silently in virtio_net_get_features() even
> > > > > > > > > if it is required. This complicates the live migration compatibility
> > > > > > > > > as the management layer may think the feature is enabled but in fact
> > > > > > > > > not.
> > > > > > > > >
> > > > > > > > > Let's add a strict feature check to make sure if there's a mismatch
> > > > > > > > > between the required feature and peer, fail the get_features()
> > > > > > > > > immediately instead of waiting until the migration to fail. This
> > > > > > > > > offload the migration compatibility completely to the management
> > > > > > > > > layer.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > > > >
> > > > > > > > This is not really useful - how do users know how to tweak their
> > > > > > > > command lines?
> > > > > > > > We discussed this many times.
> > > > > > > > To try and solve this you need a tool that will tell you how to start
> > > > > > > > VM on X to make it migrateable to Y or Z.
> > > > > > > >
> > > > > > > >
> > > > > > > > More importantly,
> > > > > > > > migration is a niche thing and breaking booting perfectly good VMs
> > > > > > > > just for that seems wrong.
> > > > > > >
> > > > > > > IMHO Jason's proposal is useful in that it now provides a way to provide
> > > > > > > ABI stablility but allows auto-ON to exist.
> > > > > > >
> > > > > > > If we think migration is optional, we could add a migration blocker where
> > > > > > > strict check flag is set to OFF, as I mentioned in the email reply to Dan.
> > > > > > > As that implies the VM ABI is not guaranteed.
> > > > > > >
> > > > > > > Thanks,
> > > > > >
> > > > > >
> > > > > > All you have to do is avoid changing the kernel and ABI is stable.
> > > > > > Downstreams already do this.
> > > > >
> > > > > But the whole point of migration is allowing VMs to move between hosts..
> > > > > hence AFAIU kernel can change.
> > > > >
> > > > > Downstream will still have problem if some network features will be
> > > > > optionally supported in some of the RHEL-N branches, because machine types
> > > > > are defined the same in any RHEL-N, so IIUC it's also possible a VM booting
> > > > > on a latest RHEL-X.Y qemu/kernel hit issues migrating back to an older
> > > > > RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have the network
> > > > > feature available..
> > > > >
> > > > > It's also not good IMHO to only fix downstream but having upstream face
> > > > > such problems, even if there's a downstream fix...
> > > > >
> > > > > This thread was revived only because Jinpu hit similar issues.  IMHO we
> > > > > should still try to provide a generic solution upstream for everyone.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > --
> > > > > Peter Xu
> > > >
> > > > failing to start a perfectly good qemu which used to work
> > > > because you changed kernels is better than failing to migrate how?
> > >
> > > It doesn't:
> > >
> > > 1) the strict feature check will be only enabled in new machine types
> > > 2) if kernel ABI is stable, qemu will keep working after upgrading
> > > kernel even with strict check otherwise it would be a bug of kernel
> > >
> > > So I don't see it breaking anything if we make it start to work at 11.0?
> >
> > Using QEMU from git suddenly requires upgrading the kernel or figuring
> > out obscure flags? Ugh.
> 
> Only the setups are buggy that might meet this.

I do git pull on qemu and have an old kernel. My setup just
became buggy. No?


> >
> >
> > > >
> > > >
> > > >
> > > > graceful downgrade with old kernels is the basics of good userspace
> > > > behaviour and has been for decades.
> > >
> > > Peter has given the example of how hard we can define gracefulness
> > > (e.g migrate from a kernel w/ USO to a kernel w/o USO) and fix.
> > >
> > > Maybe we can think of a usersapce fallback to emulation of USO or
> > > others, but I'm not sure if it's an overkill.
> > >
> > > >
> > > >
> > > > sure, let's work on a solution, just erroring out is more about blaming
> > > > the user. what is the user supposed to do when qemu fails to start?
> > >
> > > It's the first step as it's much better than silently clearing the
> > > feature which may confuse both user and migration. We can use warnings
> > > instead of errors but I'm not sure how much it can help.
> >
> >
> > Well with this first step we have successfully blamed the user and
> > the second step won't ever be taken.
> 
> Are you suggesting to fix the management? E.g patching libvirt to
> probe tap features?

host features generally.


> >
> > > >
> > > >
> > > > first, formulate what exactly do you want to enable.
> > > >
> > > >
> > > >
> > > > for example, you have a set of boxes and you want a set of flags
> > > > to supply to guarantee qemu can migrate between them. is that it?
> > >
> > > Mostly, it should work as a CPU cluster.
> >
> > the reason it kinda works with CPU cluster is simply because
> > there is a final set of CPU models and you can not easily
> > switch your CPU to a different model.
> 
> We can define a set of TAP features as well, but I'm not sure it's
> worthwhile to do this.
> 
> >
> > > So it's the responsibility of
> > > the management layer, maybe we can develop some tool to report this or
> > > via qemu introspection ("query-tap" ?). Or if the management can do
> > > this now, we don't even need to bother (or it can help to uncover
> > > bugs). Anyhow, clearing a feature silently is not good and can cover
> > > bugs of various layers.
> > >
> > > Note that this issue is not specific to TAP, we may meet this for
> > > vDPA/VFIO live migration as well. Basically, it should be the
> > > responsibility of the management layer to deal with those migration
> > > compatibility policies instead of using hard coded policies inside
> > > Qemu. For qemu, it can simply error out when there's a mismatch
> > > between features that are supported and features that are asked to
> > > enable. We've suffered a lot in the past when trying to deal with this
> > > by Qemu.
> > >
> > > Thanks
> >
> > Yes but QEMU currently gives management no tools to figure out
> > what is important for it.
> 
> Using Qemu might be problematic as usually it doesn't not have privilege.
> 
> We can extend iproute, or a dedicated tool or ask libvirt to do this.
> If libvirt could do the probe by itself, could we start from that?
> 
> Thanks

All I am saying is that I want to see how is management supposed to
know what to enable.

qemu already probes tap features. To me, it seems natural
for management to do the probing through qemu.
in fact your patch is a way to do that, is it not?
what it lacks though is a structured way to tell management how
to fix the problem.

> 
> >
> >
> >
> > > >
> > > >
> > > >
> > > > --
> > > > MST
> > > >
> >


