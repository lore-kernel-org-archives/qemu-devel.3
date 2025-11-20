Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30BCCF64A1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLtkf-0006WZ-QY; Wed, 19 Nov 2025 20:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vLtkd-0006WO-P9
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vLtka-0004Zg-V6
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763603177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k89F0khPDUcgNmmCeg8Pek1zVzXVjEAYp8yvB29CtmM=;
 b=GzIU+yEnN6BxqUM1fr/+mPnH6o9inblCmSvEBQIE0hkrZl9oYbFS2uuu5W+Z++Qq98iuSx
 r4uR2gZyZFsJbsanNDolhOihHXabE4/Dg8dlAEahbNf4ZayXj+uLAuaAu5NkRfYQMyhSAs
 8FpliOFA5vjNy7b0GXKjCvvAMkwjDlA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-05kTa8BXM6SmtXbWtehmUQ-1; Wed, 19 Nov 2025 20:45:38 -0500
X-MC-Unique: 05kTa8BXM6SmtXbWtehmUQ-1
X-Mimecast-MFC-AGG-ID: 05kTa8BXM6SmtXbWtehmUQ_1763603137
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3437b43eec4so462173a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 17:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763603137; x=1764207937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k89F0khPDUcgNmmCeg8Pek1zVzXVjEAYp8yvB29CtmM=;
 b=A2ZL4IPyfg9T2/tbo8QUzHqw/gm0KamtnzrDwCi97MsFcricw2AmVJgGnCfx62iY/O
 wguBv+2XvIXlRe8buK3uCR3E4gc1KfjDDadJ7zrfndLTx4iUBvTVcyss8KTFqDVARukv
 qThe2ZD+nfUJEJRLbMiFiyzUeqy/xmkP305F0h4F4SpLhfJezUbPvmJQ9psLNpEZWwmF
 132RfEOo0TQT+cQ3fHlcvlmPdeYEWDMJe46qrIM3j7ksxF+L2kcb/7bqCMVMfzfcn+NY
 MYG/hpJi7Qvgc27hRuOqttxRuLfg4uBjq/FFtaBv+pOKZZtuMg/G1zK05aUwgiDvBY5A
 YoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763603137; x=1764207937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k89F0khPDUcgNmmCeg8Pek1zVzXVjEAYp8yvB29CtmM=;
 b=NFFx/hDdfGZYcoqyK9/9vvPWOdWkvZ9Mn/y6njeQKRGU6+rPpNhyF50rAdgtgr1kNu
 2L4u+j2AlW+1JuZ04nln61M9y9N9t2XiVlEgdR1KlPTMgmwWEZu/F4E8gg4LXLXo6oUC
 qCDwPUXsD/qS7vN62fsYNzN87H3JnV3JgTKBTSCIeDQ0rkLQQZEstJPeiWbBDEojRmvr
 evZJEYxW8eeubDanpf5Hb1fiY/0C72iZZnEqxkafkJs9NQu2zg52TAv6YudUvh3fEE1a
 JSKIYzylEGhrm/NvgVxu9XqmrN5I34xVr4+NAimTKcW7uJLS4+glwjqskftVBpnGjiM7
 IPEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5X8ipL9QQICMQ8PrDF4pS6/14vZdLgHHvHlPS7c3Sd/2qntCCTFiuhL4wkpmjhlmsOXJea8FQPu8W@nongnu.org
X-Gm-Message-State: AOJu0YzBaVf4eUmPZRg66DoFEwMc/DCDs/RyBLFyvDH4LN6Rt45F9/6w
 jmX1uuQjIY2zAy4Vf+8E73Pm7UiMa+NpLwGwWk8WGGHbyhOHXZvyEtwH6gUgR+EUIkecKE1510+
 uKIBh9QvIc1s01Qh8YEPboIjJkDkbWEbhIPUwOlmX7cmfJYYL6fH1ia9D65IYxfHMglDRGzw5LO
 XoXTU0kR1PJhjlvlNB1eVa/GHWAFYTqUM=
X-Gm-Gg: ASbGnct8OM9aERlsNeU5go9b27KA7uULLVO24asc1Eyi72f4OZRzYf2hX7jxyGbrURX
 jVynEYhJs9I5YmSsgOoX8UVccvQfB02SrVQR1VZj1avZPHXFX03G5JZlkqTlr0OCjlt7Im2y5TQ
 AVAh/w2JgAno93LsL7ZF3G2fDQvLSzLeb0n7bND+0QxBx/xfW782Yrz05+78i53GE=
X-Received: by 2002:a17:90b:3bc6:b0:343:66e2:5f9b with SMTP id
 98e67ed59e1d1-3472841d16fmr1295254a91.24.1763603137452; 
 Wed, 19 Nov 2025 17:45:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiBkVcwX8jnO8AGfOWSOPj8S+ezkn8SIEri/tkQM6SjTSkC6giPS61haSHYak0j2rw2U5sGgOrpwTVm7cXo+g=
X-Received: by 2002:a17:90b:3bc6:b0:343:66e2:5f9b with SMTP id
 98e67ed59e1d1-3472841d16fmr1295224a91.24.1763603137009; Wed, 19 Nov 2025
 17:45:37 -0800 (PST)
MIME-Version: 1.0
References: <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local> <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local> <20251113124207-mutt-send-email-mst@kernel.org>
 <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
 <20251116014625-mutt-send-email-mst@kernel.org>
 <CACGkMEsxZvzyeqa_-9qQRfwNGAeCg5pLgu5MtEHr0OFWpA4_-g@mail.gmail.com>
 <20251117034940-mutt-send-email-mst@kernel.org>
 <CACGkMEsxTSG66StYpkStDqqJJmcTOSLjLH9DzNQ9WN=ffsUkDw@mail.gmail.com>
 <20251119030622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251119030622-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Nov 2025 09:45:24 +0800
X-Gm-Features: AWmQ_bmZ9RT5el-fkjQVSBKaXEUFYLO81IKmdQZ2hq8nqtyIGsEkwszR5O_3ncw
Message-ID: <CACGkMEusFr2Ge0GthiEkhwkZ6ncByrVFkL6BcTrHmCK4TmEiOA@mail.gmail.com>
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

On Wed, Nov 19, 2025 at 4:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Nov 19, 2025 at 10:49:11AM +0800, Jason Wang wrote:
> > > qemu already probes tap features.
> >
> > Only part of the features.
>
>
> the part we care about?

Yes and technically Qemu can probe all.

>
> > > To me, it seems natural
> > > for management to do the probing through qemu.
> > > in fact your patch is a way to do that, is it not?
> >
> > Yes and no.
> >
> > > what it lacks though is a structured way to tell management how
> > > to fix the problem.
> >
> > Probing through management seems to be better. For example it can
> > calculate the cluster in advance without the need to launch qemu
> > everywhere.
>
> it is basically replicating qemu code then.

Yes but libvirt has duplicated somehow, e.g create and destroy TAP and
it even uses TUNGETFEATURES in virNetDevMacVLanTapSetup(). But I'm not
even sure this is the work of the libvirt. I think it should be the
job of the one who is in charge of managing the cpu cluster.

>
> what's the big deal to launch qemu?

It looks more heavyweight than probing by libvirt but I'm not sure, we
can listen to libvirt guys.

>
>
>
> > Or consider the case when USO is not supported by the kernel in the
> > destination, even if qemu reports this, I'm not sure what is expected
> > to be done in the management layer?
> >
> > Thanks
>
> reports what?

USO is not supported by this kernel.

Btw, to not make things worse, I would revert this until we find a
solution. Do you agree?

commit 1c79ab6937ae938d3dfd4da1c01afc7eb599857e
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Fri Oct 10 16:12:57 2025 +0200

    virtio-net: Advertise UDP tunnel GSO support by default

    Allow bidirectional aggregated traffic for UDP encapsulated flows.

    Add the needed compatibility entries to avoid migration issues
    vs older QEMU instances.

    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    Acked-by: Jason Wang <jasowang@redhat.com>
    Tested-by: Lei Yang <leiyang@redhat.com>
    Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
    Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
    Message-Id:
<9c500fbcd2cf29afd1826b1ac906f9d5beac3601.1760104079.git.pabeni@redhat.com>

Otherwise we will suffer from a similar issue soon.

Thanks

>
> --
> MST
>


