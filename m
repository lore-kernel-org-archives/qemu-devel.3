Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71C3CEBF8A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Nov 2025 06:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKWdF-0002bx-J5; Sun, 16 Nov 2025 01:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKWd9-0002a8-BE
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 01:53:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKWd7-0002lF-7O
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 01:52:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763275975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kF1DIeUOCSGCpUaQscZBqkc4fmRRxAi16pb/d9BjruI=;
 b=FGaNU642yTiZeLJluwnV9bt3osseucjP0NSnKsOyK5g0XA+dcblhgOUDom7B74Qenj+fgf
 DCd3IBVGtyib/YdpNs3rCxIQEfHUaXqVnLA35KENUtdgvTFAfYyXRNS7v9pIKMUWNV7/Np
 454V7Jd8sfPg0pKQ6bwwYfo2xR4aW/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-YdjFf_NdPOq3QU3VvJIe2A-1; Sun, 16 Nov 2025 01:52:53 -0500
X-MC-Unique: YdjFf_NdPOq3QU3VvJIe2A-1
X-Mimecast-MFC-AGG-ID: YdjFf_NdPOq3QU3VvJIe2A_1763275972
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso19355935e9.0
 for <qemu-devel@nongnu.org>; Sat, 15 Nov 2025 22:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763275972; x=1763880772; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kF1DIeUOCSGCpUaQscZBqkc4fmRRxAi16pb/d9BjruI=;
 b=UuQzQ+GhoJLuk8jqO2ZjhaObYpSgZwB9ZgBx4AYuV33TCHzgn2Egghjkb6O3m3o+yd
 Iv/ZAHtbBGscceIe+vtT/oHGx0WHUs6yXtuYQy5f/caNO7o/Jx+Jad36Btem69qXMqmr
 Ek8tpi6F/icNoRIJUzITWl4j3xJ4qgIz5NLn4MbAvhGYeuhspxjhFfZvE7yidesqOmCv
 0L/iW2R2Gi7at/VcUgiaChpTH5lXqx6lq+P07zbcIeEX09tP8j3IW72Sy2zPO1EIinC8
 kMqtOwhaCm2SAkouqQxc3+nUKGJX7P5aMqUmRyPdzL75OaTsqQFIDuH53rEntopbIE31
 KsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763275972; x=1763880772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kF1DIeUOCSGCpUaQscZBqkc4fmRRxAi16pb/d9BjruI=;
 b=s75MMcM+Da+LR/LrsOA2fs67Ej/3t5fZZthmq3W8ueiQDscHZAWM0GVD5Q9genihsB
 aj/AttvxGGzU5K1PO3HWTsYtLPYwxZqpmz9U4KSu7Gs4cIsuoVm2G9bHzDsFgCQG3B/P
 WKli6pg/Or7qdjSpqSikrJWMNjCjamqO5ZZ1bRCKIh3prHfICCh61CKKa8S9q751cqDZ
 R9xyOnVzkTOMoJFxw6HeZXi+BsVAEnpYcC3wsK2FAh1gb+gc9He/f5Y9kum8/R7ghv/z
 yAtG2La4zJDpAcbjdsceNRyvwiZacZVuCTeqMuwO4yzDj4up1LWbKQHdpnWT5mfmU6p1
 x1uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3MlgCkel1xUl5IXTGCbpCOHnFPixYt9CnVNfIYqTGnw52Gxi6eGMJOqpQVoqZHVxFcsxZSz5pLHba@nongnu.org
X-Gm-Message-State: AOJu0YyAONKeX9xGvyWdieRX1GbauwydzIkVbLt4esIzXfk8Phb7jSub
 k4z09HGrnesHY0frBScVA6CjBjIWA5VvP05R4dOr/VI7ndAdrhsSI728d7yVLdS6kVZM28zipRW
 kFy/kwX38UOXZXObVC739kx1ihuUQJNDThUdcuGws9+Id8YGlauCuetgg
X-Gm-Gg: ASbGncsXRh4oGuHTLlLMPkXJZuSEl28mhi/8blf0JqN/rWbRHSRhRq5tfC3CxbpmstZ
 pj1kg0kV0tyJ6tCq81X9a9XaUNH3DQFqaoZxPDndKsmP5IItktMTFTvvO6IdekJR3fq3fLMlAmo
 RN3gHxTWVZu8azjZcy2TSqfwHAH2E5kV0pF78q5nXll0U545tZhu3UTiJlVmdnFp37YVtLK0gGD
 /bA0DfV2J0FVdQUzhOt9qwfyuiLgNag7CM1S3F8L044j1ZRHN9pMoZaPnfXZx6UTPxPrfO7adqN
 I/WBuZsBn9V14gB5SVRNgCyBaEpWv1Aq59vDzEl5EJPYJ5lFaEysTcROZfsRO+f6W5tsbHfSXNK
 XlU7i/FkBWhgrWNS8q6U=
X-Received: by 2002:a05:6000:64a:b0:42b:4267:83d5 with SMTP id
 ffacd0b85a97d-42b5935dde3mr6116135f8f.8.1763275971976; 
 Sat, 15 Nov 2025 22:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7glVwif3DF8yw2PlI0pPn9PeTzwIKCqyfjgNuyyX8z3rojTByCODMHUxIGZttuU3MwXls4A==
X-Received: by 2002:a05:6000:64a:b0:42b:4267:83d5 with SMTP id
 ffacd0b85a97d-42b5935dde3mr6116123f8f.8.1763275971508; 
 Sat, 15 Nov 2025 22:52:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f176basm19260632f8f.34.2025.11.15.22.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 22:52:50 -0800 (PST)
Date: Sun, 16 Nov 2025 01:52:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251116014625-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
 <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Nov 14, 2025 at 09:32:47AM +0800, Jason Wang wrote:
> On Fri, Nov 14, 2025 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Nov 13, 2025 at 12:12:38PM -0500, Peter Xu wrote:
> > > On Thu, Nov 13, 2025 at 11:47:51AM -0500, Michael S. Tsirkin wrote:
> > > > On Thu, Nov 13, 2025 at 11:37:25AM -0500, Peter Xu wrote:
> > > > > On Thu, Nov 13, 2025 at 11:09:32AM -0500, Michael S. Tsirkin wrote:
> > > > > > On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > > > > > > We used to clear features silently in virtio_net_get_features() even
> > > > > > > if it is required. This complicates the live migration compatibility
> > > > > > > as the management layer may think the feature is enabled but in fact
> > > > > > > not.
> > > > > > >
> > > > > > > Let's add a strict feature check to make sure if there's a mismatch
> > > > > > > between the required feature and peer, fail the get_features()
> > > > > > > immediately instead of waiting until the migration to fail. This
> > > > > > > offload the migration compatibility completely to the management
> > > > > > > layer.
> > > > > > >
> > > > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > >
> > > > > > This is not really useful - how do users know how to tweak their
> > > > > > command lines?
> > > > > > We discussed this many times.
> > > > > > To try and solve this you need a tool that will tell you how to start
> > > > > > VM on X to make it migrateable to Y or Z.
> > > > > >
> > > > > >
> > > > > > More importantly,
> > > > > > migration is a niche thing and breaking booting perfectly good VMs
> > > > > > just for that seems wrong.
> > > > >
> > > > > IMHO Jason's proposal is useful in that it now provides a way to provide
> > > > > ABI stablility but allows auto-ON to exist.
> > > > >
> > > > > If we think migration is optional, we could add a migration blocker where
> > > > > strict check flag is set to OFF, as I mentioned in the email reply to Dan.
> > > > > As that implies the VM ABI is not guaranteed.
> > > > >
> > > > > Thanks,
> > > >
> > > >
> > > > All you have to do is avoid changing the kernel and ABI is stable.
> > > > Downstreams already do this.
> > >
> > > But the whole point of migration is allowing VMs to move between hosts..
> > > hence AFAIU kernel can change.
> > >
> > > Downstream will still have problem if some network features will be
> > > optionally supported in some of the RHEL-N branches, because machine types
> > > are defined the same in any RHEL-N, so IIUC it's also possible a VM booting
> > > on a latest RHEL-X.Y qemu/kernel hit issues migrating back to an older
> > > RHEL-X.(Y-1) qemu/kernel if RHEL-X.(Y-1) kernel doesn't have the network
> > > feature available..
> > >
> > > It's also not good IMHO to only fix downstream but having upstream face
> > > such problems, even if there's a downstream fix...
> > >
> > > This thread was revived only because Jinpu hit similar issues.  IMHO we
> > > should still try to provide a generic solution upstream for everyone.
> > >
> > > Thanks,
> > >
> > > --
> > > Peter Xu
> >
> > failing to start a perfectly good qemu which used to work
> > because you changed kernels is better than failing to migrate how?
> 
> It doesn't:
> 
> 1) the strict feature check will be only enabled in new machine types
> 2) if kernel ABI is stable, qemu will keep working after upgrading
> kernel even with strict check otherwise it would be a bug of kernel
> 
> So I don't see it breaking anything if we make it start to work at 11.0?

Using QEMU from git suddenly requires upgrading the kernel or figuring
out obscure flags? Ugh.


> >
> >
> >
> > graceful downgrade with old kernels is the basics of good userspace
> > behaviour and has been for decades.
> 
> Peter has given the example of how hard we can define gracefulness
> (e.g migrate from a kernel w/ USO to a kernel w/o USO) and fix.
> 
> Maybe we can think of a usersapce fallback to emulation of USO or
> others, but I'm not sure if it's an overkill.
> 
> >
> >
> > sure, let's work on a solution, just erroring out is more about blaming
> > the user. what is the user supposed to do when qemu fails to start?
> 
> It's the first step as it's much better than silently clearing the
> feature which may confuse both user and migration. We can use warnings
> instead of errors but I'm not sure how much it can help.


Well with this first step we have successfully blamed the user and
the second step won't ever be taken.

> >
> >
> > first, formulate what exactly do you want to enable.
> >
> >
> >
> > for example, you have a set of boxes and you want a set of flags
> > to supply to guarantee qemu can migrate between them. is that it?
> 
> Mostly, it should work as a CPU cluster.

the reason it kinda works with CPU cluster is simply because
there is a final set of CPU models and you can not easily
switch your CPU to a different model.

> So it's the responsibility of
> the management layer, maybe we can develop some tool to report this or
> via qemu introspection ("query-tap" ?). Or if the management can do
> this now, we don't even need to bother (or it can help to uncover
> bugs). Anyhow, clearing a feature silently is not good and can cover
> bugs of various layers.
> 
> Note that this issue is not specific to TAP, we may meet this for
> vDPA/VFIO live migration as well. Basically, it should be the
> responsibility of the management layer to deal with those migration
> compatibility policies instead of using hard coded policies inside
> Qemu. For qemu, it can simply error out when there's a mismatch
> between features that are supported and features that are asked to
> enable. We've suffered a lot in the past when trying to deal with this
> by Qemu.
> 
> Thanks

Yes but QEMU currently gives management no tools to figure out
what is important for it. 



> >
> >
> >
> > --
> > MST
> >


