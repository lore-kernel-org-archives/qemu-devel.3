Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E43106F318
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 10:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5heX-0008Kb-RA; Thu, 26 Mar 2026 06:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5heV-0008KL-Kk
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w5heS-0004Vx-JM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 06:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774519758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSjnHIV7d5t6eKAFV+S1cy8B9GKdudycklp9/a/52Z0=;
 b=X7FrrMJAVjZZsfI/ROorHS+rqt38uaybcSBBNEuxTKBtmNZQPOPj/dJFLIbYuA2ZwI3KqJ
 5NFvuw0WBlX7ZSBP8fraontNNCQ5sPXJN3BIA/9iVp2zlVrK/APBpdWupoXYY1rWqcAQ8V
 O1dTUFKE6Bzb5czbKlEm2fNVT3eTa6w=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-6MFoNCA7NJep8XW5FHn_hg-1; Thu, 26 Mar 2026 06:09:17 -0400
X-MC-Unique: 6MFoNCA7NJep8XW5FHn_hg-1
X-Mimecast-MFC-AGG-ID: 6MFoNCA7NJep8XW5FHn_hg_1774519757
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-649df163c11so1573581d50.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 03:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774519757; cv=none;
 d=google.com; s=arc-20240605;
 b=YkaTzulSVKV1HCV9R3Y3HYPattsUw/J1EroAqnxcZhPIma8jlk8vAVTYKNtvEi16bM
 oM3BR10ZwrmGg/IErUQJlikk6D8Znyh1quefoclsppfDtZiUfq9KmOt+5lzPqDlxAspL
 bWYrV5W0eFXg8HOMzIQEGoS6o/5FS/38buKOpaBstOClQOeNGdtf+JMzlCGJx350SYRL
 MHM31fzRD/imu+/oSVTDadQ+F8PCMIEO12Rp+Bv1PRHqQNJfw31T1Df7wIqx2chPPXrb
 qfC8DXZGUxNgd1AUJw9yags22kReJzbO4tf6nxJ7dbj6/cdF5WXVYbE1ZSVGIT3S45nt
 GwyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eSjnHIV7d5t6eKAFV+S1cy8B9GKdudycklp9/a/52Z0=;
 fh=YABNQfmvUMl7qMn0Pg+rjVUhb9BD90dDpz1/2AdAcYo=;
 b=fmnMTHZEH8/RGOvdU9z0WY/f8I9XyeaebmIvo+Tf6pct9OnBIdCQGKoa3G92WX9v0r
 wk2Iy3KoF5C2pXKz457MHnfq7cY+FFvI8pBqr7NSG4jCRCG9/yf24Oxs7Yt3ROpAkNqr
 qSSuBCGxGecU9O7V9RyafhpObPg74wGKk4AsEE10qfC60f7d8z2ElW1mwc+ZrqIPwmfX
 XoR5r4I99+EPtKyuvMI0XXVwPWXgXx7jbrAI8X6F6bFzhj4CtMTjKyM5UcoQPFKrd/wr
 F4Ng3t9lRwEnPtV317IuaIQ8nnll1R4SbcfN89i0W8HjPHwoqYEzzoc2ZsLfZqYAerRe
 PFrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774519757; x=1775124557; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSjnHIV7d5t6eKAFV+S1cy8B9GKdudycklp9/a/52Z0=;
 b=I133E46HFMRupft1PVGPRwCrcCq24oUw35lZItSrCJZ7LQkUqd4leuXeTeSoI3REbH
 QcaaoU77uHhyplguSc6FwbYm1O4hF/wlerzT8OvcZCiTikZzCjVbHp+0xKiLciQu59bs
 B9QDiRuw8Vz5pWA9+Q18+0Z9XO71PmBwoaezVjyX9NRQ9yQ7P5PYiD9gHsHUbxue3R3+
 vz8sA6jOTxOb4TkRhgX65uIXBDT+XbWP/wRuEjckV1cbGE6SIj3tFsEBeMsesluhq3CW
 Lc6dTsdKtI5qjZWZZuahhq6mjdOe/AuBYVKfCji697HeBSJ9T5+qYlKV5v7+FVwc5hR2
 brwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774519757; x=1775124557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eSjnHIV7d5t6eKAFV+S1cy8B9GKdudycklp9/a/52Z0=;
 b=YnCSVoUk7JZwbGANA4HUu3V+w0XG1rREOzbq9QtnVzTiKl00q23CDY3NzND1xB0Gg/
 blcG1S4DJbiJIF9mkpcKkAO3KAjdmlOm6APICyu+OSCmBMp/UeWfvPWwbduzVeNpQuEU
 DoXGifhBWQM71bKuQmkUSJdd1u0p9XtEC7bVT5RNv+WEERUHSwHCxqYKtB3Qo4/qe1Fr
 Y/mB/1QGD1x+3gyRniX5Nf24YgjpcOzNP17UwdXjz4BlllOsFH23Q+TuoNjpTDqYrCwQ
 cqg/uHYi6eyIUPCxYFzeryl2ezXUdIYVbXWvUUWg3zeTdlU+a54TQXwExKGkIytzdnvJ
 HY8A==
X-Gm-Message-State: AOJu0YzZJsG5nRFdZA8GMDbJEDDtuM2LCuqyxoNfZwLGO2ygxAkiHVPw
 +4Wb6szR3YXo2LZavvLhOM8CsyoshSRZr4HsQ3v1IIRTdwVFe0OpRnEkSHftsbQu9b5HllDFwcT
 F2ZJS0l8qXwT/a7UreY9rkE8COnJE6Wid5wDCsJgRrzc+RO/EjX2cY63OWshvoKvlY3hnns3Vnv
 ibZ6DevaHCtrkCQ2UwsKLrsUQXHc7d6lw=
X-Gm-Gg: ATEYQzwLGwC8BsbisDmTIzoFh/x/AhPx0UD3WZUmYVFbU5R/sia3iT8MUo2lt+qt+ME
 U1VvI6t4NU8zsOPd4UH8ns68iTclUO5qYhndQnU3BU/J8CiCsfnkl0ks5eQE7GG9jYgTTX3Wv86
 cwE8ssJSoA6Ua0tz0LCHBy/5PqAPv1/04VegiHVTJ9g7Qg42qpBI3pE7WLxkIuFUXc5Uhc9cPlv
 3V60A==
X-Received: by 2002:a05:690e:1242:b0:64e:ebb4:1bcf with SMTP id
 956f58d0204a3-64eebb41e05mr4463142d50.34.1774519756681; 
 Thu, 26 Mar 2026 03:09:16 -0700 (PDT)
X-Received: by 2002:a05:690e:1242:b0:64e:ebb4:1bcf with SMTP id
 956f58d0204a3-64eebb41e05mr4462816d50.34.1774519751429; Thu, 26 Mar 2026
 03:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-5-jonah.palmer@oracle.com>
 <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
 <654f2356-9c78-45df-95ff-de103557948b@oracle.com>
In-Reply-To: <654f2356-9c78-45df-95ff-de103557948b@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 26 Mar 2026 11:08:34 +0100
X-Gm-Features: AQROBzDv1M9ANZAq1fIePNWbClFDxRab5tzaJrU8lH8UsCYNnU6xE1XdXbcY-u8
Message-ID: <CAJaqyWdN7AYQnugLjwRr4sWDj_dGNg8JpmgBXprgLej_UD8ZUg@mail.gmail.com>
Subject: Re: [RFC v2 04/14] virtio-net: detect VirtIODevice status
 mid-migration change
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 24, 2026 at 4:02=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
>
>
> On 3/24/26 6:45 AM, Eugenio Perez Martin wrote:
> > On Fri, Mar 20, 2026 at 3:20=E2=80=AFPM Jonah Palmer <jonah.palmer@orac=
le.com> wrote:
> >>
> >> This patch introduces the mechanism in which this series will use to
> >> detect VirtIODevice & VirtIONet state deltas, starting with the
> >> VirtIODevice's 'status' member of a virtio-net device.
> >>
> >> Before we send the device's state early, we save each piece of its sta=
te
> >> in a temporary structure via virtio_net_early_pre_save. Later, once th=
e
> >> source VM has been paused,
> >
> > While I ack this approach should cover 99% of cases=E2=80=94as I think =
it is
> > unlikely the guest changes device properties during a live migration=E2=
=80=94I
> > still believe these changes should be sent when the guest modifies the
> > property, before it is paused. That way we shrink the downtime even
> > more. This comparison fits naturally: Instead of sending one state and
> > then the deltas at the switchover, we send the state and then the
> > delta for every change.
> >
> > However, I'm happy enough with this approach because it is more
> > self-contained within the migration code. It also reduces the state
> > sent over the migration channel if the guest changes its device status
> > many times.
> >
> > CCing Juraj as we discussed this at the virtio-net upstream meeting.
> >
>
> Right. I agree it would be optimal that, for every change made during
> live migration, the destination is updated with this change and it's not
> left to be handled once the source has been paused, which would impact
> guest-visible downtime (especially if it's an expensive change).
>
> However, the only way to handle mid-migration changes like this is via
> the SaveVMHandlers framework. I did give a stab at this approach in my
> v1 RFC series:
> https://lore.kernel.org/qemu-devel/20250722124127.2497406-1-jonah.palmer@=
oracle.com/
>
> However, Peter believed that this early-migration work would be better
> suited using the VMStateDescription framework instead. And the VMSD
> framework does not support handling these mid-migration changes before
> the stop-and-copy phase.
>

Right. But we can extend the VMStateDescription framework to support
asynchronous state sending as well. At first glance, it should just
add a new VMStateDescription to the struct SaveStateEntry, let's call
it live_vmsd, and call it at the same function that calls
SaveVMHandlers->save_live_iterate, which is
migration/savevm.c:qemu_savevm_state_iterate. The load version also
needs to be called when .load_state is called.

While this extends the series, I think little code is needed and I
believe it's the right long-term decision to avoid adding multiple
ways to solve the same problem. Again, is this ".early" version is the
best we can do, I'm pretty sure it solves most of the cases so, sure,
I'm all in :).


