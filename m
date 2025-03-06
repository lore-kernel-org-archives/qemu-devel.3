Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD80C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq5aR-0001GU-IB; Thu, 06 Mar 2025 02:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tq5aQ-0001DH-AV
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:24:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tq5aM-0002PV-TT
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741245838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQ2Xkt7747oQ3agDYwv4ai4Xhq5BOZJYDWi8oGP/Gyk=;
 b=FNwAdCWWd0+egjfYnnj3D7ETsR84cl/Do4QmwyAEsYmJo8q06/OMArdanAUvh8mn5Zq1sV
 uCWAViIZZOn2aXhQc+gqVsOjNnGk+jJ+UAfFaZwneOsj28Bk5JHvm8jG9P7e6XIPBZJhYq
 mESdE4ShTvZqK6agOiiw7Lv4J/3Ikvk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-KzkwLWz4N_msGqpHe4s-MQ-1; Thu, 06 Mar 2025 02:23:56 -0500
X-MC-Unique: KzkwLWz4N_msGqpHe4s-MQ-1
X-Mimecast-MFC-AGG-ID: KzkwLWz4N_msGqpHe4s-MQ_1741245836
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22366901375so36188035ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:23:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741245835; x=1741850635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQ2Xkt7747oQ3agDYwv4ai4Xhq5BOZJYDWi8oGP/Gyk=;
 b=esrsqSZokEvZyk3l2mO0ABIlBsqM6C1R/6sSLuVJVVgcSl6i+1wd6If6geKCfLDvhu
 i9mXWelmjjO3PkvJJsmvqpeJjstc5V0eegRM7iZZ6/3kA4O99CZiYfVGojWP6dSkfWb4
 7+BHbYS55SPoQSyHwyWRVZtHSFp/i7XB73PjQxg6aLNdsxA0GYV3wvBhF/IxTVNWzSy3
 lwb2G6QUMeNbQw6I5RlZphw3EVBejjab6BW881KynJ1cv2MA6RZJ11wldbr9qrFRdJG0
 E2QBGI9vHigLNmgJBCd+xgO2xkQtieRdjRqdUHWsIHNL3TddijgVqc7ovBBToT06Dahp
 VJ+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaikVePfWwsgqtNUT1JjV/DT9FUqsk6OwGQMszecs+tGekU0tqdZnWNd84zVEZs1qzvBGbn1iSuvxF@nongnu.org
X-Gm-Message-State: AOJu0YyfsH5RXN9AoEf26TdwU8DClUxEc7nuWO1Zlqy/UD8ytRquU5b1
 EXlGglcZq4t6eCNDr0zOo7HPhYTHAusnofh4ZL9iAEeu2AVRufYnv24aPaqLpyiS3ffTUmr9Urv
 x+Gu1x9JTDmzzkUe8r+Hm5z8GjU+1wmzOo2W2lJRfhSSDIO3JzhHK8zCnDie3GHQy7EG7bG0W6d
 zCVNWIPUQ/kIUNmizg7i1MAnp9xNw=
X-Gm-Gg: ASbGncuqIR5tLm7+UQ3RfboEJy6nwCfd/Ky32g6L4VSPfmmedlJZPZGymI/h1ngd2bm
 bON/HbU0i8SALOYIoBNomB+J6qTk8DLIrhJfNLzDBU9v0jJOWRygcjDr/O1ltBwT2J/iO9z0=
X-Received: by 2002:a05:6a00:2451:b0:730:9637:b2ff with SMTP id
 d2e1a72fcca58-73693eea7a9mr3964352b3a.7.1741245835216; 
 Wed, 05 Mar 2025 23:23:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6kYkVTltKxIkP5eXKYLs3clLiaa6PNmVux0MrpZiZF8A5U5t9RNDrU11jdrcNAJf165igffmOeZS3B8l13Sk=
X-Received: by 2002:a05:6a00:2451:b0:730:9637:b2ff with SMTP id
 d2e1a72fcca58-73693eea7a9mr3964310b3a.7.1741245834586; Wed, 05 Mar 2025
 23:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <4ee57bd3-5ea0-49a7-969e-c3fe902d8246@gmail.com>
 <CAJaqyWf9g_yAb6oYf_bJ5st9owKOzJDKbcWh6k+ZYZ3-mRSaVg@mail.gmail.com>
 <b5e90abd-9fa0-4ab8-9ad2-2b673f1c0784@gmail.com>
 <CAJaqyWcgEefe8EKeuY_hxPuPfdOk6yPiFw1gaY5fvKYc7vPo5g@mail.gmail.com>
 <91d6b4b3-be87-462c-9a0a-4f3fc8ebe4c1@gmail.com>
 <CAJaqyWfL9sWRgk-zMyW_+K0dAp18iDNw1AxJLoLHoSN=GA5_sg@mail.gmail.com>
 <dd634f4f-1539-44dd-8f97-6d1173dcd626@gmail.com>
 <CAJaqyWe3qTJhQrkP2gkmCeand_63O_R6ZNvWSgGJQpE-3Qz3aw@mail.gmail.com>
 <5ada25cb-405e-4587-b230-b6a3ce7dbdc2@gmail.com>
 <CAJaqyWfkOwC_-3N66Gq2EM+eXz7hNv3n+W_2W6XtJZ0iS8PQPw@mail.gmail.com>
 <360803dd-f1e0-48a3-8917-2477d8a821a9@gmail.com>
 <69a7da95-c050-4a22-b295-ff3c2eb34fb4@gmail.com>
 <CAJaqyWf4OLVmZn+g7B6X97QFUjRV9K=u-Bkr_OhRKUSsJgd6tg@mail.gmail.com>
 <37880ee7-74c4-47c3-93ce-c2a8b177fc10@gmail.com>
 <CAJaqyWdkMNgXOGCXRCm9y+hOuR1eiNghpKeoiGHrXjzvW5+Grg@mail.gmail.com>
 <a4dbfe72-853c-4eff-b2cb-90b363eee9c0@gmail.com>
In-Reply-To: <a4dbfe72-853c-4eff-b2cb-90b363eee9c0@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 6 Mar 2025 08:23:16 +0100
X-Gm-Features: AQ5f1Jq72wmmPdkB6GDAI4r4IXq2WB1CpBXJ16XSfk_e615acNpZQZh11Tp7qzg
Message-ID: <CAJaqyWfV=7XyuXa-U1MvNkaaMg14616DSq0tHe4i-6-AkxFX=g@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Mar 6, 2025 at 6:26=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com>=
 wrote:
>
> Hi,
>
> Sorry for the delay in my response. There was a lot to absorb in the
> previous mail and I thought I would spend some more time exploring
> this.
>
> On 2/11/25 1:27 PM, Eugenio Perez Martin wrote:
> > On Mon, Feb 10, 2025 at 5:25=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> On 2/10/25 7:53 PM, Eugenio Perez Martin wrote:
> >>> On Mon, Feb 10, 2025 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gm=
ail.com> wrote:
> >>>> On 2/6/25 8:47 PM, Sahil Siddiq wrote:
> >>>>> On 2/6/25 12:42 PM, Eugenio Perez Martin wrote:
> >>>>>> On Thu, Feb 6, 2025 at 6:26=E2=80=AFAM Sahil Siddiq <icegambit91@g=
mail.com> wrote:
> >>>>>>> On 2/4/25 11:45 PM, Eugenio Perez Martin wrote:
> >>>>>>>> PS: Please note that you can check packed_vq SVQ implementation
> >>>>>>>> already without CVQ, as these features are totally orthogonal :)=
.
> >>>>>>>>
> >>>>>>>
> >>>>>>> Right. Now that I can ping with the ctrl features turned off, I t=
hink
> >>>>>>> this should take precedence. There's another issue specific to th=
e
> >>>>>>> packed virtqueue case. It causes the kernel to crash. I have been
> >>>>>>> investigating this and the situation here looks very similar to w=
hat's
> >>>>>>> explained in Jason Wang's mail [2]. My plan of action is to apply=
 his
> >>>>>>> changes in L2's kernel and check if that resolves the problem.
> >>>>>>>
> >>>>>>> The details of the crash can be found in this mail [3].
> >>>>>>>
> >>>>>>
> >>>>>> If you're testing this series without changes, I think that is cau=
sed
> >>>>>> by not implementing the packed version of vhost_svq_get_buf.
> >>>>>>
> >>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg01902.=
html
> >>>>>>
> >>>>>
> >>>>> Oh, apologies, I think I had misunderstood your response in the lin=
ked mail.
> >>>>> Until now, I thought they were unrelated. In that case, I'll implem=
ent the
> >>>>> packed version of vhost_svq_get_buf. Hopefully that fixes it :).
> >>>>>
> >>>>
> >>>> I noticed one thing while testing some of the changes that I have ma=
de.
> >>>> I haven't finished making the relevant changes to all the functions =
which
> >>>> will have to handle split and packed vq differently. L2's kernel cra=
shes
> >>>> when I launch L0-QEMU with ctrl_vq=3Don,ctrl_rx=3Don.
> >>>
> >>> Interesting, is a similar crash than this? (NULL ptr deference on
> >>> virtnet_set_features)?
> >>>
> >>> https://issues.redhat.com/browse/RHEL-391
> >> I am not able to access this bug report (even with a Red Hat account).=
 It
> >> says it may have been deleted or I don't have the permission to view i=
t.
> >>
> >> It's hard to tell if this is the same issue. I don't think it is the s=
ame
> >> issue though since I don't see any such indication in the logs. The ke=
rnel
> >> throws the following:
> >>
> >> [   23.047503] virtio_net virtio1: output.0:id 0 is not a head!
> >
> > This is a common error when modifying code of the dataplane, it is
> > unlikely to do deep changes and not see this error :). It indicates
> > that your code is marking the descriptor id 0 as used when the guest
> > didn't make it available.
>
> Right, I explored this a little further. I noticed that there were
> a few issues in my implementation with the way packed vqs were being
> handled (apart from the lack of implementation of
> vhost_svq_get_buf_packed). After making the relevant changes and
> implementing vhost_svq_get_buf_packed, I couldn't see this issue
> anymore.
>
> > If this is happening in control virtqueue, I'd check if the code is
> > setting the flags as used in ring[1] when it shouldn't. But my bet is
> > that the rx queue is the wrong one.
>
> The flags were one of the issues. I hadn't initialized "avail_used_flags"
> correctly. Rectifying them seems to have solved this issue. However, I se=
e
> two new issues (described further below).
>
> >> [   49.173243] watchdog: BUG: soft lockup - CPU#1 stuck for 25s! [Netw=
orkManager:782]
> >> [   49.174167] Modules linked in: rfkill intel_rapl_msr intel_rapl_com=
mon intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry p=
mt_class kvg
> >> [   49.188258] CPU: 1 PID: 782 Comm: NetworkManager Not tainted 6.8.7-=
200.fc39.x86_64 #1
> >> [   49.193196] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >> [   49.193196] RIP: 0010:virtqueue_get_buf+0x0/0x20
> >>
> >
> > Two possibilities about this part:
> > a) You're spending "too long" in the debugger in QEMU. From the kernel
> > POV, the function virtqueue_get_buf is taking too long to complete so
> > it detects it as a lockup. You can check this scenario by not running
> > QEMU under GDB or disabling all breakpoints. You can ignore this
> > message if you don't find the error this way. If you still see the
> > message, goto possibility b.
> >
> > b) The kernel has a bug that makes it softlockup in virtqueue_get_buf.
> > The kernel should not soft lockup even if your changes were malicious
> > :(, so it is something to be fixed. If you have the time, can you test
> > with the latest upstream kernel?
>
> I wasn't running QEMU under GDB, so there may indeed be an issue in the
> kernel. While I don't see a soft lockup at this exact point after making
> the above described changes, I do see a soft lockup issue in another part
> of virtio-net.
>
> When testing my implementation with the control feature bits turned on,
> the kernel throws the following warning while booting.
>
> [    9.046478] net eth0: Failed to disable allmulti mode.
>
> This is printed as a dev_warn() in drivers/net/virtio_net.c:virtnet_rx_mo=
de_work [1].
> The kernel doesn't continue booting beyond this point and after a few sec=
onds,
> it reports a soft lockup.
>
> >> Maybe I was incorrect in stating that the kernel crashes. It's more li=
ke
> >> the kernel is stuck in a loop (according to these blog posts on soft
> >> lockup [1][2]).
> >>
> >> In the above trace, RIP is in virtqueue_get_buf() [3]. This is what
> >> calls virtqueue_get_buf_ctx_packed() [4] which throws the error.
> >>
> >> What I don't understand is why vq->packed.desc_state[id].data [5] is
> >> NULL when the control features are turned on, but doesn't seem to be
> >> NULL when the control features are turned off.
> >
> > Due to the net subsystem lock, CVQ handling is not as robust / secure
> > against this error as the dataplane queues. There is an ongoing effort
> > to make it more robust, so maybe this is something to fix in that
> > line.
> >
> > Can you put the whole backtrace that prints the kernel?
>
> I haven't tested these changes with the latest kernel yet. I think this w=
ould be
> a good time to test against the latest kernel. I'll update my kernel.
>
> Here's the backtrace that is printed in the kernel that I currently have =
installed
> (6.8.5-201.fc39.x86_64), in case this is relevant.
>
> [   65.214308] watchdog: BUG: soft lockup - CPU#0 stuck for 51s! [Network=
Manage]
> [   65.215933] Modules linked in: rfkill intel_rapl_msr intel_rapl_common=
 intelg
> [   65.238465] CPU: 0 PID: 784 Comm: NetworkManager Tainted: G           =
  L   1
> [   65.242530] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.14
> [   65.248474] RIP: 0010:virtnet_send_command+0x17c/0x1e0 [virtio_net]
> [   65.251505] Code: 74 24 48 e8 f6 b1 40 c1 85 c0 78 60 48 8b 7b 08 e8 2=
9 92 43
> [   65.260475] RSP: 0018:ffffb8038073f298 EFLAGS: 00000246
> [   65.260475] RAX: 0000000000000000 RBX: ffff8ea600f389c0 RCX: ffffb8038=
073f29c
> [   65.265165] RDX: 0000000000008003 RSI: 0000000000000000 RDI: ffff8ea60=
cead300
> [   65.269528] RBP: ffffb8038073f2c0 R08: 0000000000000001 R09: ffff8ea60=
0f389c0
> [   65.272532] R10: 0000000000000030 R11: 0000000000000002 R12: 000000000=
0000002
> [   65.274483] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [   65.278518] FS:  00007f2dd66f2540(0000) GS:ffff8ea67bc00000(0000) knlG=
S:00000
> [   65.280653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   65.284492] CR2: 00005593d46e5868 CR3: 000000010d310001 CR4: 000000000=
0770ef0
> [   65.286464] PKRU: 55555554
> [   65.288524] Call Trace:
> [   65.291470]  <IRQ>
> [   65.291470]  ? watchdog_timer_fn+0x1e6/0x270
> [   65.293464]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [   65.296496]  ? __hrtimer_run_queues+0x10f/0x2b0
> [   65.297578]  ? hrtimer_interrupt+0xf8/0x230
> [   65.300472]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
> [   65.301680]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [   65.305464]  </IRQ>
> [   65.305464]  <TASK>
> [   65.305464]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   65.308705]  ? virtnet_send_command+0x17c/0x1e0 [virtio_net]
> [   65.312466]  ? virtnet_send_command+0x176/0x1e0 [virtio_net]
> [   65.314465]  virtnet_set_rx_mode+0xd8/0x340 [virtio_net]
> [   65.317466]  __dev_mc_add+0x79/0x80
> [   65.318462]  igmp_group_added+0x1f2/0x210
> [   65.320541]  ____ip_mc_inc_group+0x15b/0x250
> [   65.323522]  ip_mc_up+0x4f/0xb0
> [   65.324491]  inetdev_event+0x27a/0x700
> [   65.325469]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [   65.329462]  notifier_call_chain+0x5a/0xd0
> [   65.331717]  __dev_notify_flags+0x5c/0xf0
> [   65.332491]  dev_change_flags+0x54/0x70
> [   65.334508]  do_setlink+0x375/0x12d0
> [   65.336554]  ? __nla_validate_parse+0x61/0xd50
> [   65.338510]  __rtnl_newlink+0x668/0xa30
> [   65.340733]  ? security_unix_may_send+0x21/0x50
> [   65.342620]  rtnl_newlink+0x47/0x70
> [   65.344556]  rtnetlink_rcv_msg+0x14f/0x3c0
> [   65.346509]  ? avc_has_perm_noaudit+0x6b/0xf0
> [   65.348470]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [   65.350533]  netlink_rcv_skb+0x58/0x110
> [   65.352482]  netlink_unicast+0x1a3/0x290
> [   65.354547]  netlink_sendmsg+0x223/0x490
> [   65.356480]  ____sys_sendmsg+0x396/0x3d0
> [   65.357482]  ? copy_msghdr_from_user+0x7d/0xc0
> [   65.360488]  ___sys_sendmsg+0x9a/0xe0
> [   65.360488]  __sys_sendmsg+0x7a/0xd0
> [   65.364591]  do_syscall_64+0x83/0x170
> [   65.365485]  ? syscall_exit_to_user_mode+0x83/0x230
> [   65.368475]  ? do_syscall_64+0x90/0x170
> [   65.370477]  ? _raw_spin_unlock+0xe/0x30
> [   65.372498]  ? proc_sys_call_handler+0xfc/0x2e0
> [   65.374474]  ? kvm_clock_get_cycles+0x18/0x30
> [   65.376475]  ? ktime_get_ts64+0x47/0xe0
> [   65.378457]  ? posix_get_monotonic_timespec+0x65/0xa0
> [   65.380535]  ? put_timespec64+0x3e/0x70
> [   65.382458]  ? syscall_exit_to_user_mode+0x83/0x230
> [   65.384542]  ? do_syscall_64+0x90/0x170
> [   65.384542]  ? do_syscall_64+0x90/0x170
> [   65.387505]  ? ksys_write+0xd8/0xf0
> [   65.388670]  ? syscall_exit_to_user_mode+0x83/0x230
> [   65.390522]  ? do_syscall_64+0x90/0x170
> [   65.390522]  ? syscall_exit_to_user_mode+0x83/0x230
> [   65.394472]  ? do_syscall_64+0x90/0x170
> [   65.396532]  ? syscall_exit_to_user_mode+0x83/0x230
> [   65.398519]  ? do_syscall_64+0x90/0x170
> [   65.400486]  ? do_user_addr_fault+0x304/0x670
> [   65.400486]  ? clear_bhb_loop+0x55/0xb0
> [   65.404531]  ? clear_bhb_loop+0x55/0xb0
> [   65.405471]  ? clear_bhb_loop+0x55/0xb0
> [   65.408520]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [   65.408520] RIP: 0033:0x7f2dd7810a1b
> [   65.413467] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e=
8 09 3b
> [   65.420593] RSP: 002b:00007ffcff6bd520 EFLAGS: 00000293 ORIG_RAX: 0000=
000000e
> [   65.425554] RAX: ffffffffffffffda RBX: 00005593d4679a90 RCX: 00007f2dd=
7810a1b
> [   65.428519] RDX: 0000000000000000 RSI: 00007ffcff6bd560 RDI: 000000000=
000000d
> [   65.430509] RBP: 00007ffcff6bd540 R08: 0000000000000000 R09: 000000000=
0000000
> [   65.434723] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000=
000000a
> [   65.438526] R13: 00005593d4679a90 R14: 0000000000000001 R15: 000000000=
0000000
> [   65.440555]  </TASK>
> [   71.028432] rcu: INFO: rcu_preempt self-detected stall on CPU
> [   71.028432] rcu:     0-....: (1 GPs behind) idle=3D7764/1/0x4000000000=
000000 s9
> [   71.036518] rcu:     (t=3D60010 jiffies g=3D2193 q=3D1947 ncpus=3D4)
> [   71.041707] CPU: 0 PID: 784 Comm: NetworkManager Tainted: G           =
  L   1
> [   71.050455] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.14
> [   71.055661] RIP: 0010:virtnet_send_command+0x17c/0x1e0 [virtio_net]
> [   71.059518] Code: 74 24 48 e8 f6 b1 40 c1 85 c0 78 60 48 8b 7b 08 e8 2=
9 92 43
> [   71.065526] RSP: 0018:ffffb8038073f298 EFLAGS: 00000246
> [   71.067651] RAX: 0000000000000000 RBX: ffff8ea600f389c0 RCX: ffffb8038=
073f29c
> [   71.069472] RDX: 0000000000008003 RSI: 0000000000000000 RDI: ffff8ea60=
cead300
> [   71.071461] RBP: ffffb8038073f2c0 R08: 0000000000000001 R09: ffff8ea60=
0f389c0
> [   71.075455] R10: 0000000000000030 R11: 0000000000000002 R12: 000000000=
0000002
> [   71.078461] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [   71.079579] FS:  00007f2dd66f2540(0000) GS:ffff8ea67bc00000(0000) knlG=
S:00000
> [   71.083577] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   71.083577] CR2: 00005593d46e5868 CR3: 000000010d310001 CR4: 000000000=
0770ef0
> [   71.087582] PKRU: 55555554
> [   71.090472] Call Trace:
> [   71.091452]  <IRQ>
> [   71.091452]  ? rcu_dump_cpu_stacks+0xc4/0x100
> [   71.095487]  ? rcu_sched_clock_irq+0x32e/0x1040
> [   71.095487]  ? task_tick_fair+0x40/0x3f0
> [   71.100466]  ? trigger_load_balance+0x73/0x360
> [   71.100466]  ? update_process_times+0x74/0xb0
> [   71.103539]  ? tick_sched_handle+0x21/0x60
> [   71.107494]  ? tick_nohz_highres_handler+0x6f/0x90
> [   71.107572]  ? __pfx_tick_nohz_highres_handler+0x10/0x10
> [   71.111477]  ? __hrtimer_run_queues+0x10f/0x2b0
> [   71.111477]  ? hrtimer_interrupt+0xf8/0x230
> [   71.116489]  ? __sysvec_apic_timer_interrupt+0x4d/0x140
> [   71.119526]  ? sysvec_apic_timer_interrupt+0x6d/0x90
> [   71.119526]  </IRQ>
> [   71.124489]  <TASK>
> [   71.124489]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   71.127499]  ? virtnet_send_command+0x17c/0x1e0 [virtio_net]
> [   71.127499]  ? virtnet_send_command+0x176/0x1e0 [virtio_net]
> [   71.132613]  virtnet_set_rx_mode+0xd8/0x340 [virtio_net]
> [   71.136474]  __dev_mc_add+0x79/0x80
> [   71.136474]  igmp_group_added+0x1f2/0x210
> [   71.139469]  ____ip_mc_inc_group+0x15b/0x250
> [   71.140473]  ip_mc_up+0x4f/0xb0
> [   71.143492]  inetdev_event+0x27a/0x700
> [   71.144486]  ? _raw_spin_unlock_irqrestore+0xe/0x40
> [   71.147600]  notifier_call_chain+0x5a/0xd0
> [   71.148918]  __dev_notify_flags+0x5c/0xf0
> [   71.151634]  dev_change_flags+0x54/0x70
> [   71.153529]  do_setlink+0x375/0x12d0
> [   71.155476]  ? __nla_validate_parse+0x61/0xd50
> [   71.157541]  __rtnl_newlink+0x668/0xa30
> [   71.159503]  ? security_unix_may_send+0x21/0x50
> [   71.161954]  rtnl_newlink+0x47/0x70
> [   71.163680]  rtnetlink_rcv_msg+0x14f/0x3c0
> [   71.165468]  ? avc_has_perm_noaudit+0x6b/0xf0
> [   71.167506]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
> [   71.170499]  netlink_rcv_skb+0x58/0x110
> [   71.171461]  netlink_unicast+0x1a3/0x290
> [   71.174477]  netlink_sendmsg+0x223/0x490
> [   71.175472]  ____sys_sendmsg+0x396/0x3d0
> [   71.175472]  ? copy_msghdr_from_user+0x7d/0xc0
> [   71.179465]  ___sys_sendmsg+0x9a/0xe0
> [   71.179465]  __sys_sendmsg+0x7a/0xd0
> [   71.182526]  do_syscall_64+0x83/0x170
> [   71.183522]  ? syscall_exit_to_user_mode+0x83/0x230
> [   71.183522]  ? do_syscall_64+0x90/0x170
> [   71.187502]  ? _raw_spin_unlock+0xe/0x30
> [   71.187502]  ? proc_sys_call_handler+0xfc/0x2e0
> [   71.191500]  ? kvm_clock_get_cycles+0x18/0x30
> [   71.191500]  ? ktime_get_ts64+0x47/0xe0
> [   71.195472]  ? posix_get_monotonic_timespec+0x65/0xa0
> [   71.195472]  ? put_timespec64+0x3e/0x70
> [   71.198593]  ? syscall_exit_to_user_mode+0x83/0x230
> [   71.199571]  ? do_syscall_64+0x90/0x170
> [   71.202457]  ? do_syscall_64+0x90/0x170
> [   71.203463]  ? ksys_write+0xd8/0xf0
> [   71.203463]  ? syscall_exit_to_user_mode+0x83/0x230
> [   71.207464]  ? do_syscall_64+0x90/0x170
> [   71.207464]  ? syscall_exit_to_user_mode+0x83/0x230
> [   71.211460]  ? do_syscall_64+0x90/0x170
> [   71.211460]  ? syscall_exit_to_user_mode+0x83/0x230
> [   71.211460]  ? do_syscall_64+0x90/0x170
> [   71.216481]  ? do_user_addr_fault+0x304/0x670
> [   71.216481]  ? clear_bhb_loop+0x55/0xb0
> [   71.220472]  ? clear_bhb_loop+0x55/0xb0
> [   71.220472]  ? clear_bhb_loop+0x55/0xb0
> [   71.223704]  entry_SYSCALL_64_after_hwframe+0x78/0x80
> [   71.225564] RIP: 0033:0x7f2dd7810a1b
> [   71.227495] Code: 48 89 e5 48 83 ec 20 89 55 ec 48 89 75 f0 89 7d f8 e=
8 09 3b
> [   71.235475] RSP: 002b:00007ffcff6bd520 EFLAGS: 00000293 ORIG_RAX: 0000=
000000e
> [   71.239515] RAX: ffffffffffffffda RBX: 00005593d4679a90 RCX: 00007f2dd=
7810a1b
> [   71.241643] RDX: 0000000000000000 RSI: 00007ffcff6bd560 RDI: 000000000=
000000d
> [   71.245469] RBP: 00007ffcff6bd540 R08: 0000000000000000 R09: 000000000=
0000000
> [   71.247467] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000=
000000a
> [   71.251479] R13: 00005593d4679a90 R14: 0000000000000001 R15: 000000000=
0000000
> [   71.251479]  </TASK>
>

Yes, the kernel does softlock waiting for a reply if the CVQ does not
move forward. This is a known issue that is being fixed, but it is not
easy :). To achieve the packed vq support, we can either disable CVQ
entirely or try to process the message the kernel is trying to send.
Both approaches come down to the same functions in SVQ, so you can
pick the one you feel more comfortable :).

> When I test my changes with the control feature bits turned off, I see an=
other
> issue. The kernel boots successfully in this case, but I noticed that no =
new
> elements in the dataplane are added to the virtqueue. This is because, in
> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_translate_addr() [2], when g=
pas
> is not null and QEMU tries to retrieve the IOVA address from the GPA->IOV=
A
> tree, the result of map is NULL in the following line [3]:
>
> map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle)
>
> Due to this, vhost_svq_vring_write_descs() [4] simply returns false and n=
othing
> is added to the virtqueue.
>
> This issue is present even for split virtqueues, when I test my changes w=
ith
> "packed=3Doff". However, I don't see any issues when I build QEMU from th=
e master
> branch. I think the issue might lie in how memory is being allocated to t=
he
> virtqueues in my implementation, but I am not sure. I have a few ideas re=
garding
> how this can be debugged. I'll let you know if I find anything else.
>

Understood! In case you run out of ideas, it seems like a good
candidate for bisection.

Thanks for the update!


