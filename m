Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B22DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgm78-00060W-4I; Mon, 06 Jul 2026 12:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgm75-0005yD-U5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgm74-0000qm-AR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783355045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zs8DOaeL0nMMZkOTKtCEE9asrMHhE8ROz+qzcsyJUYA=;
 b=eLDcLW+/KBaptGEGLrhxSCVoZPWpTUeL+h7RRtTfC74yIkvIFcEog+tjPGT3/mz8NEKeJG
 sHJcF9xCedCJo4hM3hK7tcpcyS7A/06M+gKXeqwrAa4Q+W43u9yTU+SNZeYUbEjDxyrXHo
 n3hZtSiMhzWxMwPu4Le+laVpVOqUyfc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-smjSQOi6Ow-I1JV8MVBWSw-1; Mon, 06 Jul 2026 12:24:03 -0400
X-MC-Unique: smjSQOi6Ow-I1JV8MVBWSw-1
X-Mimecast-MFC-AGG-ID: smjSQOi6Ow-I1JV8MVBWSw_1783355043
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915f6ff639aso582181285a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783355043; x=1783959843; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zs8DOaeL0nMMZkOTKtCEE9asrMHhE8ROz+qzcsyJUYA=;
 b=s8uyRvjWqkhfMEEj9FuUj2BwaD/BfuoKVvv+JFido1QnvpDqcRkrp/yMvMLbovpYys
 j8jOoFpwzswDC3C3MpYjSFhE1tFZ8X3e2P+Z8VOeoRk/aBK/w0+PHMRlgKisLkkf0pIK
 SLQDhkmIta4XzJfdAF6r4BfKpZRBwVqwc9VwkFu/dHTtMTTljA131Cyp7FP6wyiHe8uZ
 dIrjPHImV1LQZ5H7qrvzOmrlw5w25wQB2tnkaICatHoyHYYgjkjORBIFaBVybWTeCq2H
 7qxaQjAE16DoaHMKijO8qJi4NsFZdK0jAvxKjztEOrxX+pC7kZR2ZB7FiApeQfT9Yf9r
 r2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783355043; x=1783959843;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zs8DOaeL0nMMZkOTKtCEE9asrMHhE8ROz+qzcsyJUYA=;
 b=pJPw1zbVbR0boqDvBLEMcBWeHWFvSyekiyYQKXmPukXkD1grCkFyC5UEFgHvZVk2pZ
 5+nCqnOAnmNuHa/kZ/Otwq1l9qYFX5+Lm7dWGQdaa4/Dbz++SK/VFcNmLmjyHbBOq+Ns
 YRagZoA5vA3ROX4WXjKIhLKWa+y90R7D8KevOTS8sOyfgmJrRcCzoM0xK7nfUrnDMcdj
 DHo/32tBVP2Ghkdube0kFZh8tEYA41q49oR1KSJUl255FnyzCQRZZzigYOxzCrdaPAQG
 o3dHJxLpkEFLUBJ+6YP0X78PMoSO+gN0p9rT5ksHpT/nECkaO/Zio0eNjJiwOeX14TqL
 AOHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1kliQSZKltuOJQq//ykLUqbTtHGz71u68QgjuPG4rQfR1sqf84bZE/5syx0ZH74YA4Dpt+dFibk7L@nongnu.org
X-Gm-Message-State: AOJu0YwmYkzOOg/6UDjruX52lud9ikSLVFjVj2r/0/FOqU6CjTP9qr1d
 BaqgFqAn7SNOPDfy7FxZMCXv0nJmAnStXa5//gnsjAO3aS2TfZ6NCn5o+8bNrjqb6VjTDFT3pSF
 fc2YZO3/z8jxwpFoWwVcvaS2w8E4neEItW0tWIOwt+uhkUQhwbOY1+V7t
X-Gm-Gg: AfdE7cnrjt+aW5LLw5ypcXo2Z1oQyuoHny/lBFrAMXYVvUmDAZ/NPplkUq77aKM5xRp
 3z/H1xdvf+zFOiyTK44W7okOTOXpeisWuBbSon0hrfuhISDleU//O5aBw3D2DgVtudErE6iFgW8
 8kjuK0JKts28RqB/zBhEGf3qbdKFnuiWJFt+EG1rMxMg1M4X15Ghc3CK2exG+FWNwvYB9OEHde+
 d1NlfVQHnHykqwFY60eC10I31tURrEKCwlgexG1TwQTsy9NzibWz18QCIQwCyWSxaQjnNZNQrgP
 c6OyQK1zd6QkyyPA9mnbUKTHxd5/oPbhEl0rjx+GGanSkQfqcNMmBCVKXR1/8HTwpzfeo1KX32p
 3csw=
X-Received: by 2002:a05:620a:1981:b0:92b:6805:91bf with SMTP id
 af79cd13be357-92ebb5b87c3mr183140885a.71.1783355042690; 
 Mon, 06 Jul 2026 09:24:02 -0700 (PDT)
X-Received: by 2002:a05:620a:1981:b0:92b:6805:91bf with SMTP id
 af79cd13be357-92ebb5b87c3mr183136785a.71.1783355042071; 
 Mon, 06 Jul 2026 09:24:02 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cbe3e2sm966036385a.35.2026.07.06.09.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 09:24:01 -0700 (PDT)
Date: Mon, 6 Jul 2026 12:23:49 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
Message-ID: <akvWlciUvxjDbBBZ@x1.local>
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
 <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
 <871peqtm5t.fsf@suse.de> <ah3eheRXN1QJAGj_@x1.local>
 <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
 <ah86Z0r5sMnxwgo-@x1.local>
 <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
 <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 02, 2026 at 08:36:32PM +0200, Maciej S. Szmigiero wrote:
> I looked more deeply into this and even prototyped a similar new design.

Sorry for a late response; off work most of last week.

> 
> However, in the end I think that running VFIO state transitions in
> parallel with other non-VFIO cb() handlers just isn't safe.
> 
> For example, on the migration source, the second transition is
> PRE_COPY_P2P -> STOP_COPY.
> PRE_COPY_P2P is the last state during migration that still allows the
> device to accept DMA and similar interactions, while STOP_COPY is
> already the "quiescent" state.
> 
> So if a VFIO has already reached STOP_COPY but a non-VFIO device
> callback still hasn't finished, then any DMA/MMIO/P2P transaction from
> that "unfinished" device to the VFIO device would now hit a VFIO device
> that no longer can accept such transactions.
> This may result in hard-to-debug memory corruption during live migration.

Do you have any solid example of this problem?

AFAIU, P2P in VFIO state's term only means P2P DMAs _between_ host VFIO
devices, nothing to do with emulated.

I am not aware of any P2P that can be initiated from emulated devices, even
if it exists, it is only P2P from guest perspective not host: it will
become host operations finally from processor side.  I really don't think
it's a concern.

My limited understanding of VFIO's P2P state is: when switching to P2P
state, the VFIO device can still accept P2P DMA from other devices, but
never initiating P2P DMAs, and the latter sentence is critical, it means
the real quiecent state of the whole system happens after the last VFIO
device switching to P2P state: then it means none of the VFIO devices can
initiate P2P DMA anymore, whole system is quiesced.  That happens earlier
than reaching any of the cb()s here, because VFIO's prepare_cb() does that
P2P state switch.

Thanks,

-- 
Peter Xu


