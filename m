Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3D4CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 09:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umUGr-0004tq-7t; Thu, 14 Aug 2025 05:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1umUGm-0004tP-Je
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:29:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1umUGh-0005FZ-MF
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755163743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJQU2dJhM8k7W6Tc9QVIQCkiynz7zJDHG0DLkQ453OY=;
 b=cFWtuofdiDMlilfmrIzEl/mKNOfgURc4F4aXmOwi+xWSc1vmEfeVR5HgkT0oR2XPkP6F6u
 UW2WJpyhUCJh0GlqtZppgj6adCq4Ex8ZMzjR+VyHLNQeDfvKCFFuBq7hw0GJoeWoVyxd4W
 7vDEmxjARr7xtEELMv8+0zYjqeoYL0U=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-muXoAqOrNuWxjQdJEaxiIA-1; Thu, 14 Aug 2025 05:29:02 -0400
X-MC-Unique: muXoAqOrNuWxjQdJEaxiIA-1
X-Mimecast-MFC-AGG-ID: muXoAqOrNuWxjQdJEaxiIA_1755163741
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-32326e6d8a9so793660a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 02:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755163741; x=1755768541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJQU2dJhM8k7W6Tc9QVIQCkiynz7zJDHG0DLkQ453OY=;
 b=m2IEqBk4DEmlP8SwLlQ3Zz/T8jwKOx4jKQHznIQ5XAN/e2A18Bn9DND9u3idTiw4X0
 PglNxA4q+lEoI3Yg0ES2f20pRvW8rPDr54vvOgYCXWJ5wYK+sY/1E9qHsVf4na1fSPW1
 7xYZPP8sKx4Mtw3D050fdXOY3lQ53s6GSxMXO++ErNmG7ulZRZ0m2UDep6nmBgMoH00B
 sHBPRUMEB1GfaKfwIyumz818Et39+F7Ec8s3iCcHO1b5NLETsM3yN/pRd4JYU9wPK9gt
 9hx9r16L55q3V2t2y4RZtVEhlDn2qDRrh5HYXfoR1z9qG61PeGYqFztDCTPecRCeU2Xf
 Updg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdoyshzkiKKi45I1yZG5JS9I/iI33+yXcxBYEs9WdrVNqL3thldumU2RgAPRyK7yfNH3DjfiZY9sj9@nongnu.org
X-Gm-Message-State: AOJu0Yy5Wmhi91UnT7qbW05mAtUA/sIc7EY+TH7G35M9OxWvhRM5NiM8
 aZFCtUA/tK9QDzku6WT7HE14RTy4o+3AWJ9DRb7yXx2d0t1y1bSpE28DdDNJmW1/QB4d7/zjQp1
 xJIeMVJ2a4BzUpebAy6WBfVnp1o94i0m4LUMV8YUfKJKbf2bJUG/HyhXK9QjzUtABYtkkBH1OwM
 Lc0/u1jNOhkYxoFPHp0X7yoZkmyPc7A00=
X-Gm-Gg: ASbGncuZNVY9qq/iKDJZikztScu+8KImOBlD+piwFMbM88vAHSA+E4ly1mTuey+ln1i
 fr+rmNfd631OuGhYgnUrw3YvwMi0a+tLk4fs4Xsaw2e5HsD3+hSp4CyhIOLBv9yt8/a+lc9/eKE
 A91MzeHrpaSfGqZnx62gz+
X-Received: by 2002:a17:90b:3dd0:b0:31c:15d9:8ae with SMTP id
 98e67ed59e1d1-32327ad20a1mr4163340a91.33.1755163740963; 
 Thu, 14 Aug 2025 02:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEntVFJtHWTSEfqi9kXqfwWfUbJZQzhoMsizLYCrut4gFcdJS5j8eSb1Krd2L+mNxMnjxc1q3Efs2tlHZ68CCw=
X-Received: by 2002:a17:90b:3dd0:b0:31c:15d9:8ae with SMTP id
 98e67ed59e1d1-32327ad20a1mr4163309a91.33.1755163740529; Thu, 14 Aug 2025
 02:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com> <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com> <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com> <aJnydjxFzKwVzi7Y@x1.local>
 <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com> <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
In-Reply-To: <aJyb6n9Vf4BhHqpb@x1.local>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 14 Aug 2025 11:28:24 +0200
X-Gm-Features: Ac12FXwfYph7_O90_yMZI9s2kHXjvM2t8NeDq7MrsXLB-DrZcY3kNAATHE8NhVU
Message-ID: <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Peter Xu <peterx@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, jasowang@redhat.com, mst@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, 
 Dragos Tatulea DE <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 13, 2025 at 4:06=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
> > On Mon, Aug 11, 2025 at 11:56=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> > >
> > > On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
> > > > This effort was started to reduce the guest visible downtime by
> > > > virtio-net/vhost-net/vhost-vDPA during live migration, especially
> > > > vhost-vDPA.
> > > >
> > > > The downtime contributed by vhost-vDPA, for example, is not from ha=
ving to
> > > > migrate a lot of state but rather expensive backend control-plane l=
atency
> > > > like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters=
, offload
> > > > settings, MTU, etc.). Doing this requires kernel/HW NIC operations =
which
> > > > dominates its downtime.
> > > >
> > > > In other words, by migrating the state of virtio-net early (before =
the
> > > > stop-and-copy phase), we can also start staging backend configurati=
ons,
> > > > which is the main contributor of downtime when migrating a vhost-vD=
PA
> > > > device.
> > > >
> > > > I apologize if this series gives the impression that we're migratin=
g a lot
> > > > of data here. It's more along the lines of moving control-plane lat=
ency out
> > > > of the stop-and-copy phase.
> > >
> > > I see, thanks.
> > >
> > > Please add these into the cover letter of the next post.  IMHO it's
> > > extremely important information to explain the real goal of this work=
.  I
> > > bet it is not expected for most people when reading the current cover
> > > letter.
> > >
> > > Then it could have nothing to do with iterative phase, am I right?
> > >
> > > What are the data needed for the dest QEMU to start staging backend
> > > configurations to the HWs underneath?  Does dest QEMU already have th=
em in
> > > the cmdlines?
> > >
> > > Asking this because I want to know whether it can be done completely
> > > without src QEMU at all, e.g. when dest QEMU starts.
> > >
> > > If src QEMU's data is still needed, please also first consider provid=
ing
> > > such facility using an "early VMSD" if it is ever possible: feel free=
 to
> > > refer to commit 3b95a71b22827d26178.
> > >
> >
> > While it works for this series, it does not allow to resend the state
> > when the src device changes. For example, if the number of virtqueues
> > is modified.
>
> Some explanation on "how sync number of vqueues helps downtime" would hel=
p.
> Not "it might preheat things", but exactly why, and how that differs when
> it's pure software, and when hardware will be involved.
>

By nvidia engineers to configure vqs (number, size, RSS, etc) takes
about ~200ms:
https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvi=
dia.com/T/

Adding Dragos here in case he can provide more details. Maybe the
numbers have changed though.

And I guess the difference with pure SW will always come down to PCI
communications, which assume it is slower than configuring the host SW
device in RAM or even CPU cache. But I admin that proper profiling is
needed before making those claims.

Jonah, can you print the time it takes to configure the vDPA device
with traces vs the time it takes to enable the dataplane of the
device? So we can get an idea of how much time we save with this.

> If it's only about pre-heat, could dest qemu preheat with max num of
> vqueues?  Is it the same cost of downtime when growing num of queues,
> v.s. shrinking num of queues?
>

Well you need to send the vq addresses and properties to preheat
these. If the address is invalid, the destination device will
interpret the vq address as the avail ring, for example, and will read
an invalid avail idx.

> For softwares, is it about memory transaction updates due to the vqueues?
> If so, have we investigated a more generic approach on memory side, likel=
y
> some form of continuation from Chuang's work I previously mentioned?
>

This work is very interesting, and most of the downtime was because of
memory pinning indeed. Thanks for bringing it up! But the downtime is
not caused for the individual vq memory config, but for pinning all
the guest's memory for the device to access to it.

I think it is worth exploring if it affects the downtime in the case
of HW. I don't see any reason to reject that series but lack of
reviews, isn't it?


