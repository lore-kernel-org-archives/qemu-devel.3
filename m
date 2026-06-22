Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC70CCDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbdDu-0005rv-UW; Mon, 22 Jun 2026 07:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wbdDs-0005rQ-Tl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wbdDr-0003hc-4N
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 07:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782129229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
 b=ZkbjHuNfIzXLML+MmTsWkXrDT9SfM/lZNOIULDzl+aA4VD8rWRzuzf0QTxHxpNzLzcKOxr
 Oii/yRQul0g5L66ZMPOHeyoGwKGrOf+471Cy6X3nOcIHQLtb5Ay/6AbzAinAcWy5kyNRBU
 ajuf0hdHptbyEsOQv9KD69nLQ6M6X3A=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-iFb-5LAjPaScs4dJdSQO6g-1; Mon, 22 Jun 2026 07:53:47 -0400
X-MC-Unique: iFb-5LAjPaScs4dJdSQO6g-1
X-Mimecast-MFC-AGG-ID: iFb-5LAjPaScs4dJdSQO6g_1782129227
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c6b7d5118fso73743805ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 04:53:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782129227; cv=none;
 d=google.com; s=arc-20240605;
 b=KV8bQ/RhapEJKEij5U+vpfLnpxZ/3lXzzJBhfcnrqnfgLnQ2VYtt0e056Yv4Fx2QyN
 6WuVYFLDT7xkJ14YGLigwAUFP0XJqS79IkvcBw+VqtUG88pwpMQJejlnnqWs26zbDPyI
 /q/4kw1fz2hf1TgD1YGHVJ4Xj7ONmqWlIwNr2EJCaAkA9ucFnu0N8DXShKUzzfWO0LYP
 CL+qv4WpX0yEYM8sEE/g67xJtPOTjbCNPslP5tZdqa50ZbqpoL0F0Frob5YOHaUWkfgZ
 9zr3LDS1rMfwsefckCr9rJYmHlMS5ihvycq9fDwCA86Jww8ohRyKxXVDJgUbC/zz9scC
 wFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
 fh=CbNs3Jl+0l1i+Z/igOdpnDCULMfGSU2YRfLnkavk7lQ=;
 b=IcuaarIe1zUkP8+mvKrYv0unGlAjChEg8HM8myGarqWtdDcMFOKhn9foDDNLaQ7y76
 yNWtpcHJgd5Sw7V4fwZ1weF3nYqlwo9ps9qJy0oytzkoCMoV4h/CJLhdXOMKiMiyGEkN
 /poHCU7xu7FRrbN7wAL3BLr39oNJ2MD+V67NKmvtHvgOfEdMBzCIGMSuS6zumSlEHr6H
 ZW2tQJN/K22IEQ4XXr01dVu5+I6li1PoVGMuuLdZRqFacTgASq2XgAUdWDTs0i/HzcWU
 sbkBNKljU8uwhz68B+5gAVXEM5VjOBxaig/9s5ogMcnGDgItxy9lDvTDJvbiReaZSaj8
 5Ong==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782129227; x=1782734027; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
 b=DnSejxjQNG4dr5MYQBYRk4Ar5P2oSBIk1du0mOvLro1l7MPWH1KCejaoz89rAD6Sa0
 39ZaVR+0w1skeZJA9/AiM0WbJhdl78Ocl/M6uHByd1LuVQVKp8Cdt3R4t5lkmeoV2klt
 QAEzhqfWWNeMKwYElrTQyPd5UWzJ8Q5YTL6s7e3nFQIh5S9aDIur3n2l4AnlunW0tVLI
 u2tXLqvMNfnmuSbuthXtfZVJ2XpMif7N/dl9q+nC8XmVty1RcMov+Y9IAgTCrDNjTgTl
 CQnRExlctGlmio2FlkbkjIKUIb+5zd+YfgBUGZKVAbHn8TbnW07nTKmynzbqvEAtnMTn
 raJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782129227; x=1782734027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fh9EbXDsUdt3JnPQT1zJjA204fWMQDrKUHfp8WDHpjI=;
 b=fl1wfrr0wAAj3qM3q15YIjDYgQIh/d8Bdzi3XJkR7UcxyUOqjVkH/Pm32D3gDyYYRF
 TkpeC87staBG9W9y+7sYHAXBNVy9UmkH4MF9Q/bmZSZDJm0yj6Fis4gOxLBUE6Ymp9Lf
 nWDWrFetrHMAAzP/1Is2gqOlvCwn0LCC1KsuChdzf9/FRCHudjk4YGSdGrDVftQQQHe2
 l6SOb1TLp+cZD5zqKXv6335SDN3BPzoAW5LGW/BYtbZd4rMpe8eOZKJIxsgPvNdsZMGU
 DB9natwH94pzZACHILm915WevjVW+jv/oaBSTl5SxT5rWUyuImt40CLoN3X4XuZMNoc6
 B11w==
X-Gm-Message-State: AOJu0Yw54reb/FBSXeg2hxmXetaUKEZ6ZEUyHH3z3yptc2d8Il4ysbr/
 ExxWOuxHwmJETHs1iMQcgim5aSTBu/3ii4vRhezV5Zum8hZdLAYCKVJIsE8Gj/6FSbXvq7C35js
 bN7ZMxdEFr9fSjxxj/q+d9cWHjHz1krHfb7ElM5ZIvyfERJ0LQredTpAObBSxQhUdgZYZ7NvuSR
 JasX16qlZFhnP688Mvim1i3G4IE9ZqzTY=
X-Gm-Gg: AfdE7ckgk+bXE1GUp/CUic9++a2u74r6um/meyrb+Kgjsad/heIl9yZ2g6VmNh3qO73
 yj+Kn8udrFvciZd7rzoY7lMlU3AL+irH9ntuYpNQRZ1fMuIRG07JusIatLxifoudfhfd4G2VAML
 5NGdYVm9ZpegfqTPrP9P05ViYQcV1sU6/Lmxzl/q+IFwZYeFUs3VUwommHzY6eBdhgp5I7yFsgL
 GmNMkB4zof+TSfqedgc7s8WpOOw1oAH2DITwC2e585Jm4a5C476QqQ4sxCvoCPmWSc6WN1mlcrI
 1vAS8Qx7G6xt
X-Received: by 2002:a17:903:2f48:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2c718f60995mr175520715ad.18.1782129226785; 
 Mon, 22 Jun 2026 04:53:46 -0700 (PDT)
X-Received: by 2002:a17:903:2f48:b0:2c7:1200:bd7e with SMTP id
 d9443c01a7336-2c718f60995mr175520225ad.18.1782129226133; Mon, 22 Jun 2026
 04:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
 <ajVco512NDPKDPTr@x1.local>
In-Reply-To: <ajVco512NDPKDPTr@x1.local>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Jun 2026 15:53:33 +0400
X-Gm-Features: AVVi8Cetkjgs_ZPbhSsYJ4D0E5D4CqDmlEHuwWMGY_b4e-igfUqu15XDdXHKZHo
Message-ID: <CAMxuvazRnZw4PEsdKCEBD8X1ua5LMj5K-k+-oh-J_uvXm5vT1w@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Peter

On Fri, Jun 19, 2026 at 7:13=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Jun 4, 2026 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > This is an attempt to fix the incompatibility of virtio-mem with conf=
idential
> > > VMs. The solution implements what was discussed earlier with D. Hilde=
nbrand:
> > > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.=
18657-5-chenyi.qiang@intel.com/#3502238
> > >
> > > The first patches are misc cleanups. Then some code refactoring to ha=
ve split a
> > > manager/source. And finally, the manager learns to deal with multiple=
 sources.
> > >
> > > This has been tested together with the Linux kernel series from
> > > Zhenzhong Duan [1] for TDX guests.
> > >
> > > (help fix https://issues.redhat.com/browse/RHEL-131968)
> >
> > Can the patch 1-11 be queued or are we missing something?
> > (RFC patch 12 can be dropped for now)
>
> Likely yes.. one thing to double check with you before I do: We don't nee=
d
> the kernel series, do we?  Since when unplug, I expect with the truncatio=
n
> approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE the=
n
> unaccept is done (?).

> Say, what happens if we run QEMU with this series applied, but without th=
e
> kernel series?

The kernel series is needed at least for PAGE.ACCEPT. Without it, QEMU
will have KVM_RUN return EIO, and finish into assert (while tearing
down ioeventfd).

> What confused me a bit is the dependency of this series v.s. the kernel
> one.  It seems to use different approaches, but then I don't understand w=
hy
> this series was tested with the kernel change.

My understanding is that the kernel may perform TDG.MEM.PAGE.RELEASE.
That depends on TDX config TDCS_CONFIG_PAGE_RELEASE which qemu/kvm
doesnt currently control. I don't know whether this is then
redundant/needless with qemu doing discard on the guest_memfd..


