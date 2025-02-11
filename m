Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53313C0219E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 07:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thl9e-00061K-Hb; Tue, 11 Feb 2025 02:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1thl9c-00060t-LI
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 02:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1thl9Z-0006rl-UH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 02:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739260676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgatYSWWOFJVI/4uUSny2ftuEGIEEHkoVg6ZMV4i2h0=;
 b=hlxz+/TJlvzPd/aUxU4oxEUaYlUYcOyOe9sQZkKa4XzwnCOOSS6EX0ml+60JzgVKpaOOKJ
 f5CUFBYYbZ9xe3hdEShVH/YKIK/6JFJEU2iNhsH7Va3UmN4LXyOhScvfXf1kq3EfMWjXS+
 58TOSw6gktzPWWpnCZYUMMacd/BzxwE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-kFSsJY69NyeJG-z6uLmSKA-1; Tue, 11 Feb 2025 02:57:53 -0500
X-MC-Unique: kFSsJY69NyeJG-z6uLmSKA-1
X-Mimecast-MFC-AGG-ID: kFSsJY69NyeJG-z6uLmSKA
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e54cb50c3baso6961411276.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 23:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739260672; x=1739865472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgatYSWWOFJVI/4uUSny2ftuEGIEEHkoVg6ZMV4i2h0=;
 b=Yb3sC1eBmnX/VXJ5WYoutPeVubDDzrT/rh08fbdPQT/L4Y1U0cewoEgI+XTo002ebg
 HRBibSOLcpb31JxqLta5K3J4TI25sMoWHzSmgeV59epJVVFqJ+Nz1To0ZD+1RuBtVwIz
 I1CLMUUy55jqYT3ZfXPBkzNx4f441fdnDvo+5Qw3TOPA9yE0yVwNrVc4r/+G+sS5kF5M
 iZclrnKcdpMUZczaOlKT9ipQ2Hkz1Amna4tKk8xB5pZ+doJDWoUrLBJdXKiFOu+64jMm
 hVQMUlhHBOI2ZrTPbJB+r3TB6gx3X4EN9w+8bJr/6hJ474a+CLcZHAM91CTJI26ZYenj
 japg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVlDkpO0rnw/+Zb3hl90vlvCUOtJjtyTz9ElZT+wPNo3/GyiJkPf0g4pab1DnUS9P3ma1GOz7BXiDj@nongnu.org
X-Gm-Message-State: AOJu0YxuI2kbYaIRPf/fDHaedZie7JO1PMA4Lnk66NY9e2F9ZxyafQZM
 MTZ78V92HN9mpQZhuLoxIPqzJDcZi3gTkmubRZTZEWfqCTL9wCSlPiSgpcqrrMQqEuRxu/e88aU
 VLM+5wMQi1/0ZflL+Oxz0S3UfIl/t3KU7Yy9syPB++8CcJ+SAPuTlc6Dg8PKNehOsAnCGRqJWMH
 tLdqH1ZBXgiJEMVHXycNFDicJMU/o=
X-Gm-Gg: ASbGncvVFs+zdgIDdR50YVkFGMsG5d583rI7W/8+0HzwblFlNzYIKZUISdK+MP/WQ44
 WvTPe9SaUQJsARc0frblSktDw0P72gNRJsOy3r/wCJeeiEMQOBz6ooA6J3NMU
X-Received: by 2002:a05:6902:2182:b0:e58:31ee:56c0 with SMTP id
 3f1490d57ef6-e5d94528c2emr2846631276.19.1739260672421; 
 Mon, 10 Feb 2025 23:57:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcf5jh8JF2KbBU+0SGtN0TqoBAsmJ9nMmubthmTKGh2jxfGs08JJRdw28lJfZ05B2pBFtFplKTxWa2rwrz2po=
X-Received: by 2002:a05:6902:2182:b0:e58:31ee:56c0 with SMTP id
 3f1490d57ef6-e5d94528c2emr2846615276.19.1739260672085; Mon, 10 Feb 2025
 23:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <f670a48e-73ab-4027-9d2b-d4fafa54cd16@gmail.com>
 <CAJaqyWftS8angT2=XUUFiR_5yjxNOmV4WXHe3cxkb4t6KbQdDw@mail.gmail.com>
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
In-Reply-To: <37880ee7-74c4-47c3-93ce-c2a8b177fc10@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 11 Feb 2025 08:57:14 +0100
X-Gm-Features: AWEUYZkiTFu50jnzPVV_yINbQB7af889t5z8ruZJUU4H0HHrqa28CF9Lb5tAg7I
Message-ID: <CAJaqyWdkMNgXOGCXRCm9y+hOuR1eiNghpKeoiGHrXjzvW5+Grg@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On Mon, Feb 10, 2025 at 5:25=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> On 2/10/25 7:53 PM, Eugenio Perez Martin wrote:
> > On Mon, Feb 10, 2025 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> >> On 2/6/25 8:47 PM, Sahil Siddiq wrote:
> >>> On 2/6/25 12:42 PM, Eugenio Perez Martin wrote:
> >>>> On Thu, Feb 6, 2025 at 6:26=E2=80=AFAM Sahil Siddiq <icegambit91@gma=
il.com> wrote:
> >>>>> On 2/4/25 11:45 PM, Eugenio Perez Martin wrote:
> >>>>>> PS: Please note that you can check packed_vq SVQ implementation
> >>>>>> already without CVQ, as these features are totally orthogonal :).
> >>>>>>
> >>>>>
> >>>>> Right. Now that I can ping with the ctrl features turned off, I thi=
nk
> >>>>> this should take precedence. There's another issue specific to the
> >>>>> packed virtqueue case. It causes the kernel to crash. I have been
> >>>>> investigating this and the situation here looks very similar to wha=
t's
> >>>>> explained in Jason Wang's mail [2]. My plan of action is to apply h=
is
> >>>>> changes in L2's kernel and check if that resolves the problem.
> >>>>>
> >>>>> The details of the crash can be found in this mail [3].
> >>>>>
> >>>>
> >>>> If you're testing this series without changes, I think that is cause=
d
> >>>> by not implementing the packed version of vhost_svq_get_buf.
> >>>>
> >>>> https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg01902.ht=
ml
> >>>>
> >>>
> >>> Oh, apologies, I think I had misunderstood your response in the linke=
d mail.
> >>> Until now, I thought they were unrelated. In that case, I'll implemen=
t the
> >>> packed version of vhost_svq_get_buf. Hopefully that fixes it :).
> >>>
> >>
> >> I noticed one thing while testing some of the changes that I have made=
.
> >> I haven't finished making the relevant changes to all the functions wh=
ich
> >> will have to handle split and packed vq differently. L2's kernel crash=
es
> >> when I launch L0-QEMU with ctrl_vq=3Don,ctrl_rx=3Don.
> >
> > Interesting, is a similar crash than this? (NULL ptr deference on
> > virtnet_set_features)?
> >
> > https://issues.redhat.com/browse/RHEL-391
> I am not able to access this bug report (even with a Red Hat account). It
> says it may have been deleted or I don't have the permission to view it.
>
> It's hard to tell if this is the same issue. I don't think it is the same
> issue though since I don't see any such indication in the logs. The kerne=
l
> throws the following:
>
> [   23.047503] virtio_net virtio1: output.0:id 0 is not a head!

This is a common error when modifying code of the dataplane, it is
unlikely to do deep changes and not see this error :). It indicates
that your code is marking the descriptor id 0 as used when the guest
didn't make it available.

If this is happening in control virtqueue, I'd check if the code is
setting the flags as used in ring[1] when it shouldn't. But my bet is
that the rx queue is the wrong one.

> [   49.173243] watchdog: BUG: soft lockup - CPU#1 stuck for 25s! [Network=
Manager:782]
> [   49.174167] Modules linked in: rfkill intel_rapl_msr intel_rapl_common=
 intel_uncore_frequency_common intel_pmc_core intel_vsec pmt_telemetry pmt_=
class kvg
> [   49.188258] CPU: 1 PID: 782 Comm: NetworkManager Not tainted 6.8.7-200=
.fc39.x86_64 #1
> [   49.193196] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   49.193196] RIP: 0010:virtqueue_get_buf+0x0/0x20
>

Two possibilities about this part:
a) You're spending "too long" in the debugger in QEMU. From the kernel
POV, the function virtqueue_get_buf is taking too long to complete so
it detects it as a lockup. You can check this scenario by not running
QEMU under GDB or disabling all breakpoints. You can ignore this
message if you don't find the error this way. If you still see the
message, goto possibility b.

b) The kernel has a bug that makes it softlockup in virtqueue_get_buf.
The kernel should not soft lockup even if your changes were malicious
:(, so it is something to be fixed. If you have the time, can you test
with the latest upstream kernel?

> Maybe I was incorrect in stating that the kernel crashes. It's more like
> the kernel is stuck in a loop (according to these blog posts on soft
> lockup [1][2]).
>
> In the above trace, RIP is in virtqueue_get_buf() [3]. This is what
> calls virtqueue_get_buf_ctx_packed() [4] which throws the error.
>
> What I don't understand is why vq->packed.desc_state[id].data [5] is
> NULL when the control features are turned on, but doesn't seem to be
> NULL when the control features are turned off.
>

Due to the net subsystem lock, CVQ handling is not as robust / secure
against this error as the dataplane queues. There is an ongoing effort
to make it more robust, so maybe this is something to fix in that
line.

Can you put the whole backtrace that prints the kernel?

> >> However, when I start
> >> L0-QEMU with ctrl_vq=3Doff,ctrl_rx=3Doff,ctrl_vlan=3Doff,ctrl_mac_addr=
=3Doff, L2's
> >> kernel boots successfully. Tracing L2-QEMU also confirms that the pack=
ed
> >> feature is enabled. With all the ctrl features disabled, I think pingi=
ng
> >> will also be possible once I finish implementing the packed versions o=
f
> >> the other functions.
> >>
> >
> > Good!
> >
> >> There's another thing that I am confused about regarding the current
> >> implementation (in the master branch).
> >>
> >> In hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_vring_write_descs() [1=
],
> >> svq->free_head saves the descriptor in the specified format using
> >> "le16_to_cpu" (line 171).
> >
> > Good catch, this should be le16_to_cpu actually. But code wise is the
> > same, so we have no visible error. Do you want to send a patch to fix
> > it?
> >
> Sorry, I am still a little confused here. Did you mean cpu_to_le16
> by any chance? Based on what I have understood, if it is to be used
> by the host machine, then it should be cpu_to_le16.
>
> I can send a patch once this is clear, or can even integrate it in
> this patch series since this patch series refactors that function
> anyway.
>

Ok, I don't know how I read the function to answer you that :(. Let me
start from scratch,

In line 171, we're copying data from QEMU internals, that are not in
the guest memory, to other QEMU internals. So no cpu_to_le* or
le*to_cpu is needed.

> >> On the other hand, the value of i is stored
> >> in the native endianness using "cpu_to_le16" (line 168). If "i" is to =
be
> >> stored in the native endianness (little endian in this case), then
> >> should svq->free_head first be converted to little endian before being
> >> assigned to "i" at the start of the function (line 142)?
> >>
> >

No endianness conversion is needed here for the same reason, all is
internal to QEMU and not intended to be seen by the guest.

> > This part is correct in the code, as it is used by the host, not
> > written to the guest or read from the guest. So no conversion is
> > needed.
>
> Understood.
>
> Thanks,
> Sahil
>
> [1] https://www.suse.com/support/kb/doc/?id=3D000018705
> [2] https://softlockup.com/SystemAdministration/Linux/Kernel/softlockup/
> [3] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L2545
> [4] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L1727
> [5] https://github.com/torvalds/linux/blob/master/drivers/virtio/virtio_r=
ing.c#L1762
>


