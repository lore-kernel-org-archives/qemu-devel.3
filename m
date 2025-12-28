Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D20ED3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 20:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZxb1-00006G-Ui; Sun, 28 Dec 2025 15:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxaz-00005v-7D
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:42:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZxaw-00065I-Uk
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 15:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766954549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlNanx6ECBvXNo6gfQvt5xryS9X2RTEIospcCl+eX4s=;
 b=cO2+SIIn+nv2msbnZUE1h2w03RtnoczLvvYSGcrGCc/qVCNI92if2bNI5+aBmeUZFGSsof
 7cmSI4w4mxU/0uZiROFx9Ou3MEfCZdhyhxdi0/RPKqZmX1vumm6LrmDHhBIewFAuizJzf1
 f5BPIZikGc9lNcQig70a9+ICoC3XdTU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-tAbWno8tN_yf0I49pU7cdg-1; Sun, 28 Dec 2025 15:42:27 -0500
X-MC-Unique: tAbWno8tN_yf0I49pU7cdg-1
X-Mimecast-MFC-AGG-ID: tAbWno8tN_yf0I49pU7cdg_1766954546
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d1622509eso49843085e9.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766954545; x=1767559345; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VlNanx6ECBvXNo6gfQvt5xryS9X2RTEIospcCl+eX4s=;
 b=g+pTsxuJuXdtsPobok3E/I0qHVDd2UzFMo2fJIk3x4J/38ANMsxtLwrDcrykZ2xUWH
 QMtnoGIJFhDNMa/RioNo3qDWZROGXapzfso+AxIr8eUKZajE/CEmwA6w+MUywx/ANOkp
 s5ujM3DSI+JDx65Nm5STMUIj0KseTgoSYvqU4/JeJwafpkTBeThpoFP7VlnwcOWqXjrr
 4AyUuM0LdXVFn2amiwgcUy1vOtYOp1Pr6IkfQa8RMn24XE7CqQeFYJjLFUnkyNJTi/Bq
 d0Chvh1WRMTHYLFnMjk8SP0cpXCaqCfZag40RzvhT185sLpvXSX3VYuKlYTf1nCVLM+7
 lVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766954545; x=1767559345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlNanx6ECBvXNo6gfQvt5xryS9X2RTEIospcCl+eX4s=;
 b=Lq4wpkeUp1G2yDyqW2hdr1fVjkX/0QWwxzuDMSMeDRZWZefqX440SGlq+v/wKaUgnK
 pmFH5qakFO6nw35cqjpeR5V4TAlPila//9iS2AnuTXsJ3QbaFdJw55Nd/raAXrFlawy0
 JFfAKoIzYaTPBadru1WdZDC/aX9YF0Yy5gap3fmSEwUBl7aXawN+8rvhtECWFp7gB6fD
 St+Z+pg0Rm1+qfOMgVl1FdA56JwrjqSbH9TwukMQdmn83RvkEvZ90AEIh8nJCoye4BdY
 VY/EV6Ikle7jb6OIPIM4riD/Zxf6Ke5Ki8Key1HXDJ8OEQBDx8i9uvjTbyR6ubZXv1KG
 QgeQ==
X-Gm-Message-State: AOJu0Yz3d776ozjI8wWkMu9mc97N/sX6v9c2Z5SB5byBLb6ochTYwfsJ
 yLSj6GP5GE3llBiuKATyJgGdhWyDFxa4fXzuMyrhrFcCFUVoy8ynQgmIcudT7bZJJ0nQCXNM7NM
 0rQdeoINJ0An/Tw37V5dKz9CLXXRICxHoKmh4hCuc148lQTMCoUCX/DGiB0CzbYwcn02pgU+KTx
 RuLJjPf6ITTkPqWdqrZxRHCdZoF8pIHigcKSUJIps=
X-Gm-Gg: AY/fxX4Frf+SbC56E1uuaASTZTuf8E+S7wNsfJlK8r3cMVg69zCLxn4VpHaq0DYFcIX
 Q7OGikmUl0+yGL1upE5+ss11hgXDQUhngEpEun5Tuo+gyGSyHlGfOIdOwSxd+5vXPFScxjdHDLi
 DFRwIX6wGiiOND5UiwOvg3UmhMDcmwN/t2vraNZNGQVYU+XXHM7DnqlB59UYPtaQE/wQroYcDDB
 6CrG7CQhj7PjykP4eIFze+0CjSvang7DYbOjpWOf9j9s3kbTQznC9YA5O30C1pvehEHDgQ=
X-Received: by 2002:a05:600c:310b:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-47d1959783amr322165575e9.34.1766954545396; 
 Sun, 28 Dec 2025 12:42:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7lJ4oW7tB6r77qltULhVxWUiZqytanGM5hJdfj8CJs1UI/u2bqsLVwOxIgVB2zToyLiVFpIp92Dr5BJ4CBhc=
X-Received: by 2002:a05:600c:310b:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-47d1959783amr322165395e9.34.1766954544959; Sun, 28 Dec 2025
 12:42:24 -0800 (PST)
MIME-Version: 1.0
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227091622.20725-30-pbonzini@redhat.com>
 <f7dd1a94-c135-489f-857f-0b71f891e5fc@linaro.org>
In-Reply-To: <f7dd1a94-c135-489f-857f-0b71f891e5fc@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 21:42:12 +0100
X-Gm-Features: AQt7F2ozA2HbpH99HI_O4q-bs8WGIkK6y5PnHv1NcL5S0fsiX3JquojV75olF9Y
Message-ID: <CABgObfbc05R089L1dmWPHfA33y+S2kRnK5bMiwoQ_goSjXGZxg@mail.gmail.com>
Subject: Re: [PULL 029/153] include: reorganize memory API headers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fcbc73064709298e"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000fcbc73064709298e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 27 dic 2025, 16:45 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> Hi Paolo,
>
> On 27/12/25 10:14, Paolo Bonzini wrote:
> > Move RAMBlock functions out of ram_addr.h and cpu-common.h;
> > move memory API headers out of include/exec and into include/system.
>
> I know you want the good of the project and make it evolve,
> but TBH pushing your own unreviewed patches without looking
> at others work in the same area is really demotivating, it
> feel like you completely ignore us.
>

This cleanup was posted over a month ago and I didn't get any reviews... it
does absolutely nothing except splitting up a couple header files so that
they do what the names signify, so I didn't think too much about it and
thought people didn't really care.

Sorry for not spotting the duplicate patch among your patches=E2=80=94what =
happened
is that I agreed with the general idea and, seeing Richard and others
reviewing them, I trusted both you and them; I only looked at them closely
today after you pointed out the duplication.

Rest assured that it's really trusting the people that are working on QEMU,
like you (or Peter or David for the memory API) and not ignoring them.

Paolo


> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   MAINTAINERS                              |   2 +-
> >   include/exec/cpu-common.h                |  74 -----------
> >   include/exec/cputlb.h                    |   1 +
> >   include/exec/translation-block.h         |   2 +
> >   include/hw/core/qdev-properties-system.h |   1 +
> >   include/hw/i2c/smbus_eeprom.h            |   2 +-
> >   include/hw/xen/xen-hvm-common.h          |   1 +
> >   include/system/balloon.h                 |   2 +-
> >   include/system/block-ram-registrar.h     |   2 +-
> >   include/system/iommufd.h                 |   2 +-
> >   include/system/memory.h                  |  16 ++-
> >   include/system/memory_mapping.h          |   4 +-
> >   include/system/physmem.h                 |   2 +-
> >   include/system/ram_addr.h                | 136 +++----------------
> >   include/system/ramblock.h                | 160 ++++++++++++++++++++++=
-
> >   include/{exec =3D> system}/ramlist.h       |  10 +-
> >   include/system/xen-mapcache.h            |   1 -
> >   include/system/xen.h                     |   3 +-
> >   migration/migration.h                    |   3 +-
> >   migration/ram.h                          |   1 +
> >   accel/mshv/mshv-all.c                    |   1 +
> >   accel/tcg/cputlb.c                       |   2 +-
> >   accel/tcg/tcg-accel-ops-mttcg.c          |   1 +
> >   backends/hostmem.c                       |   1 +
> >   block/blkio.c                            |   2 +-
> >   dump/dump.c                              |   1 +
> >   hw/acpi/ghes.c                           |   1 +
> >   hw/acpi/nvdimm.c                         |   1 +
> >   hw/acpi/vmgenid.c                        |   1 +
> >   hw/arm/omap1.c                           |   1 +
> >   hw/audio/marvell_88w8618.c               |   1 +
> >   hw/char/riscv_htif.c                     |   1 +
> >   hw/core/cpu-common.c                     |   1 +
> >   hw/core/machine-qmp-cmds.c               |   1 +
> >   hw/core/numa.c                           |   3 +-
> >   hw/display/exynos4210_fimd.c             |   1 +
> >   hw/display/omap_lcdc.c                   |   1 +
> >   hw/display/ramfb.c                       |   1 +
> >   hw/display/vga.c                         |   1 +
> >   hw/dma/i8257.c                           |   1 +
> >   hw/dma/omap_dma.c                        |   1 +
> >   hw/dma/rc4030.c                          |   1 +
> >   hw/dma/sifive_pdma.c                     |   1 +
> >   hw/hyperv/hyperv.c                       |   1 +
> >   hw/hyperv/syndbg.c                       |   1 +
> >   hw/hyperv/vmbus.c                        |   1 +
> >   hw/i386/kvm/clock.c                      |   1 +
> >   hw/i386/vapic.c                          |   1 +
> >   hw/intc/apic.c                           |   1 +
> >   hw/intc/xive2.c                          |   1 +
> >   hw/m68k/next-cube.c                      |   1 +
> >   hw/microblaze/boot.c                     |   1 +
> >   hw/misc/pc-testdev.c                     |   1 +
> >   hw/net/fsl_etsec/rings.c                 |   1 +
> >   hw/net/mcf_fec.c                         |   1 +
> >   hw/net/opencores_eth.c                   |   1 +
> >   hw/net/xgmac.c                           |   1 +
> >   hw/nvram/spapr_nvram.c                   |   1 +
> >   hw/ppc/amigaone.c                        |   1 +
> >   hw/ppc/e500.c                            |   1 +
> >   hw/ppc/pegasos.c                         |   1 +
> >   hw/ppc/pnv.c                             |   1 +
> >   hw/ppc/ppc440_uc.c                       |   1 +
> >   hw/ppc/spapr.c                           |   1 +
> >   hw/ppc/spapr_drc.c                       |   1 +
> >   hw/ppc/spapr_events.c                    |   1 +
> >   hw/ppc/spapr_hcall.c                     |   1 +
> >   hw/ppc/spapr_rtas.c                      |   1 +
> >   hw/ppc/spapr_tpm_proxy.c                 |   1 +
> >   hw/ppc/virtex_ml507.c                    |   1 +
> >   hw/remote/proxy-memory-listener.c        |   1 +
> >   hw/s390x/css.c                           |   1 +
> >   hw/s390x/ipl.c                           |   1 +
> >   hw/s390x/s390-pci-bus.c                  |   1 +
> >   hw/s390x/s390-stattrib.c                 |   1 +
> >   hw/s390x/virtio-ccw.c                    |   1 +
> >   hw/scsi/vmw_pvscsi.c                     |   1 +
> >   hw/sparc/leon3.c                         |   1 +
> >   hw/vfio-user/container.c                 |   1 +
> >   hw/vfio/container.c                      |   2 +-
> >   hw/vfio/helpers.c                        |   1 +
> >   hw/vfio/migration.c                      |   2 +-
> >   hw/virtio/vhost.c                        |   1 +
> >   hw/xen/xen-mapcache.c                    |   1 +
> >   hw/xen/xen_pt_graphics.c                 |   1 +
> >   hw/xtensa/xtfpga.c                       |   1 +
> >   migration/ram.c                          |   2 +-
> >   stubs/physmem.c                          |   2 +-
> >   stubs/ram-block.c                        |   4 +-
> >   system/ioport.c                          |   1 +
> >   system/memory.c                          |   2 +-
> >   system/physmem.c                         |   2 +-
> >   target/arm/kvm.c                         |   1 +
> >   target/i386/kvm/kvm.c                    |   1 +
> >   target/i386/sev.c                        |   1 +
> >   target/ppc/kvm.c                         |   2 +-
> >   target/s390x/kvm/kvm.c                   |   2 +-
> >   tests/qtest/fuzz/generic_fuzz.c          |   2 +-
> >   util/vfio-helpers.c                      |   2 +-
> >   rust/hw/char/pl011/src/bindings.rs       |   4 +-
> >   rust/hw/core/src/bindings.rs             |   2 +-
> >   rust/system/src/bindings.rs              |   5 +-
> >   102 files changed, 298 insertions(+), 234 deletions(-)
> >   rename include/{exec =3D> system}/ramlist.h (94%)
>
>

--000000000000fcbc73064709298e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9ImF1dG8iPjxkaXY+PGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSBnbWFp
bF9xdW90ZV9jb250YWluZXIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5JbCBz
YWIgMjcgZGljIDIwMjUsIDE2OjQ1IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVm
PSJtYWlsdG86cGhpbG1kQGxpbmFyby5vcmciPnBoaWxtZEBsaW5hcm8ub3JnPC9hPiZndDsgaGEg
c2NyaXR0bzo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPkhpIFBhb2xvLDxicj4NCjxicj4NCk9uIDI3LzEyLzI1
IDEwOjE0LCBQYW9sbyBCb256aW5pIHdyb3RlOjxicj4NCiZndDsgTW92ZSBSQU1CbG9jayBmdW5j
dGlvbnMgb3V0IG9mIHJhbV9hZGRyLmggYW5kIGNwdS1jb21tb24uaDs8YnI+DQomZ3Q7IG1vdmUg
bWVtb3J5IEFQSSBoZWFkZXJzIG91dCBvZiBpbmNsdWRlL2V4ZWMgYW5kIGludG8gaW5jbHVkZS9z
eXN0ZW0uPGJyPg0KPGJyPg0KSSBrbm93IHlvdSB3YW50IHRoZSBnb29kIG9mIHRoZSBwcm9qZWN0
IGFuZCBtYWtlIGl0IGV2b2x2ZSw8YnI+DQpidXQgVEJIIHB1c2hpbmcgeW91ciBvd24gdW5yZXZp
ZXdlZCBwYXRjaGVzIHdpdGhvdXQgbG9va2luZzxicj4NCmF0IG90aGVycyB3b3JrIGluIHRoZSBz
YW1lIGFyZWEgaXMgcmVhbGx5IGRlbW90aXZhdGluZywgaXQ8YnI+DQpmZWVsIGxpa2UgeW91IGNv
bXBsZXRlbHkgaWdub3JlIHVzLjxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0byI+VGhpcyBjbGVhbnVwIHdhcyBwb3N0ZWQg
b3ZlciBhIG1vbnRoIGFnbyBhbmQgSSBkaWRuJiMzOTt0IGdldCBhbnkgcmV2aWV3cy4uLiBpdCBk
b2VzIGFic29sdXRlbHkgbm90aGluZyBleGNlcHQgc3BsaXR0aW5nIHVwIGEgY291cGxlIGhlYWRl
ciBmaWxlcyBzbyB0aGF0IHRoZXkgZG8gd2hhdCB0aGUgbmFtZXMgc2lnbmlmeSwgc28gSSBkaWRu
JiMzOTt0IHRoaW5rIHRvbyBtdWNoIGFib3V0IGl0IGFuZCB0aG91Z2h0IHBlb3BsZSBkaWRuJiMz
OTt0IHJlYWxseSBjYXJlLjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPlNvcnJ5IGZvciBub3Qgc3BvdHRpbmcgdGhlIGR1cGxpY2F0ZSBwYXRjaCBhbW9uZyB5
b3VyIHBhdGNoZXPigJR3aGF0IGhhcHBlbmVkIGlzIHRoYXQgSSBhZ3JlZWQgd2l0aCB0aGUgZ2Vu
ZXJhbCBpZGVhIGFuZCwgc2VlaW5nIFJpY2hhcmQgYW5kIG90aGVycyByZXZpZXdpbmcgdGhlbSwg
SSB0cnVzdGVkIGJvdGggeW91IGFuZCB0aGVtOyBJIG9ubHkgbG9va2VkIGF0IHRoZW0gY2xvc2Vs
eSB0b2RheSBhZnRlciB5b3UgcG9pbnRlZCBvdXQgdGhlIGR1cGxpY2F0aW9uLjwvZGl2PjxkaXYg
ZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9ImF1dG8iPlJlc3QgYXNzdXJlZCB0aGF0IGl0
JiMzOTtzIHJlYWxseSB0cnVzdGluZyB0aGUgcGVvcGxlIHRoYXQgYXJlIHdvcmtpbmcgb24gUUVN
VSwgbGlrZSB5b3UgKG9yIFBldGVyIG9yIERhdmlkIGZvciB0aGUgbWVtb3J5IEFQSSkgYW5kIG5v
dCBpZ25vcmluZyB0aGVtLjwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRpdiBkaXI9
ImF1dG8iPlBhb2xvPC9kaXY+PGRpdiBkaXI9ImF1dG8iPjxicj48L2Rpdj48ZGl2IGRpcj0iYXV0
byI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUgZ21haWxfcXVvdGVfY29udGFpbmVyIj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
DQo8YnI+DQomZ3Q7IFNpZ25lZC1vZmYtYnk6IFBhb2xvIEJvbnppbmkgJmx0OzxhIGhyZWY9Im1h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayIgcmVsPSJub3JlZmVycmVy
Ij5wYm9uemluaUByZWRoYXQuY29tPC9hPiZndDs8YnI+DQomZ3Q7IC0tLTxicj4NCiZndDvCoCDC
oE1BSU5UQUlORVJTwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMiArLTxicj4NCiZndDvCoCDCoGluY2x1ZGUvZXhlYy9jcHUtY29tbW9uLmjCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8wqAgNzQgLS0tLS0tLS0tLS08YnI+DQomZ3Q7wqAgwqBpbmNsdWRl
L2V4ZWMvY3B1dGxiLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxICs8YnI+
DQomZ3Q7wqAgwqBpbmNsdWRlL2V4ZWMvdHJhbnNsYXRpb24tYmxvY2suaMKgIMKgIMKgIMKgIMKg
fMKgIMKgMiArPGJyPg0KJmd0O8KgIMKgaW5jbHVkZS9ody9jb3JlL3FkZXYtcHJvcGVydGllcy1z
eXN0ZW0uaCB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBpbmNsdWRlL2h3L2kyYy9zbWJ1c19lZXBy
b20uaMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQomZ3Q7wqAgwqBpbmNsdWRlL2h3
L3hlbi94ZW4taHZtLWNvbW1vbi5owqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8Kg
IMKgaW5jbHVkZS9zeXN0ZW0vYmFsbG9vbi5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
wqAyICstPGJyPg0KJmd0O8KgIMKgaW5jbHVkZS9zeXN0ZW0vYmxvY2stcmFtLXJlZ2lzdHJhci5o
wqAgwqAgwqB8wqAgwqAyICstPGJyPg0KJmd0O8KgIMKgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5o
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KJmd0O8KgIMKgaW5jbHVk
ZS9zeXN0ZW0vbWVtb3J5LmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgMTYgKystPGJy
Pg0KJmd0O8KgIMKgaW5jbHVkZS9zeXN0ZW0vbWVtb3J5X21hcHBpbmcuaMKgIMKgIMKgIMKgIMKg
IHzCoCDCoDQgKy08YnI+DQomZ3Q7wqAgwqBpbmNsdWRlL3N5c3RlbS9waHlzbWVtLmjCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQomZ3Q7wqAgwqBpbmNsdWRlL3N5c3Rl
bS9yYW1fYWRkci5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCAxMzYgKysrLS0tLS0tLS0tLS0t
LS0tLTxicj4NCiZndDvCoCDCoGluY2x1ZGUvc3lzdGVtL3JhbWJsb2NrLmjCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8IDE2MCArKysrKysrKysrKysrKysrKysrKysrLTxicj4NCiZndDvCoCDCoGlu
Y2x1ZGUve2V4ZWMgPSZndDsgc3lzdGVtfS9yYW1saXN0LmjCoCDCoCDCoCDCoHzCoCAxMCArLTxi
cj4NCiZndDvCoCDCoGluY2x1ZGUvc3lzdGVtL3hlbi1tYXBjYWNoZS5owqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgMSAtPGJyPg0KJmd0O8KgIMKgaW5jbHVkZS9zeXN0ZW0veGVuLmjCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKy08YnI+DQomZ3Q7wqAgwqBtaWdyYXRpb24v
bWlncmF0aW9uLmjCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAzICstPGJyPg0K
Jmd0O8KgIMKgbWlncmF0aW9uL3JhbS5owqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgYWNjZWwvbXNodi9tc2h2LWFsbC5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgYWNjZWwvdGNn
L2NwdXRsYi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJy
Pg0KJmd0O8KgIMKgYWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMtbXR0Y2cuY8KgIMKgIMKgIMKgIMKg
IHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGJhY2tlbmRzL2hvc3RtZW0uY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgYmxvY2svYmxraW8u
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+
DQomZ3Q7wqAgwqBkdW1wL2R1bXAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2FjcGkvZ2hlcy5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBo
dy9hY3BpL252ZGltbS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAg
wqAxICs8YnI+DQomZ3Q7wqAgwqBody9hY3BpL3ZtZ2VuaWQuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2FybS9vbWFwMS5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAxICs8YnI+DQomZ3Q7
wqAgwqBody9hdWRpby9tYXJ2ZWxsXzg4dzg2MTguY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvY2hhci9yaXNjdl9odGlmLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2NvcmUvY3B1LWNvbW1v
bi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAxICs8YnI+DQomZ3Q7wqAg
wqBody9jb3JlL21hY2hpbmUtcW1wLWNtZHMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKg
MSArPGJyPg0KJmd0O8KgIMKgaHcvY29yZS9udW1hLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHzCoCDCoDMgKy08YnI+DQomZ3Q7wqAgwqBody9kaXNwbGF5L2V4eW5v
czQyMTBfZmltZC5jwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBo
dy9kaXNwbGF5L29tYXBfbGNkYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAx
ICs8YnI+DQomZ3Q7wqAgwqBody9kaXNwbGF5L3JhbWZiLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2Rpc3BsYXkvdmdhLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDC
oGh3L2RtYS9pODI1Ny5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8
wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody9kbWEvb21hcF9kbWEuY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2RtYS9yYzQwMzAu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZn
dDvCoCDCoGh3L2RtYS9zaWZpdmVfcGRtYS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody9oeXBlcnYvaHlwZXJ2LmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2h5cGVydi9z
eW5kYmcuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0K
Jmd0O8KgIMKgaHcvaHlwZXJ2L3ZtYnVzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody9pMzg2L2t2bS9jbG9jay5jwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvaTM4Ni92
YXBpYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJy
Pg0KJmd0O8KgIMKgaHcvaW50Yy9hcGljLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L2ludGMveGl2ZTIuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3
L202OGsvbmV4dC1jdWJlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAx
ICs8YnI+DQomZ3Q7wqAgwqBody9taWNyb2JsYXplL2Jvb3QuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvbWlzYy9wYy10ZXN0ZGV2LmPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3
L25ldC9mc2xfZXRzZWMvcmluZ3MuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSAr
PGJyPg0KJmd0O8KgIMKgaHcvbmV0L21jZl9mZWMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvbmV0L29wZW5jb3Jlc19ldGgu
Y8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcv
bmV0L3hnbWFjLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDC
oDEgKzxicj4NCiZndDvCoCDCoGh3L252cmFtL3NwYXByX252cmFtLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3BwYy9hbWlnYW9uZS5jwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKg
aHcvcHBjL2U1MDAuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzC
oCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3BwYy9wZWdhc29zLmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3BwYy9wbnYuY8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0K
Jmd0O8KgIMKgaHcvcHBjL3BwYzQ0MF91Yy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody9wcGMvc3BhcHIuY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvcHBj
L3NwYXByX2RyYy5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAxICs8
YnI+DQomZ3Q7wqAgwqBody9wcGMvc3BhcHJfZXZlbnRzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody9wcGMvc3BhcHJfaGNhbGwuY8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvcHBj
L3NwYXByX3J0YXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxi
cj4NCiZndDvCoCDCoGh3L3BwYy9zcGFwcl90cG1fcHJveHkuY8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvcHBjL3ZpcnRleF9tbDUwNy5jwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvcmVtb3Rl
L3Byb3h5LW1lbW9yeS1saXN0ZW5lci5jwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8Kg
IMKgaHcvczM5MHgvY3NzLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3MzOTB4L2lwbC5jwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody9zMzkweC9z
MzkwLXBjaS1idXMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZn
dDvCoCDCoGh3L3MzOTB4L3MzOTAtc3RhdHRyaWIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
fMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvczM5MHgvdmlydGlvLWNjdy5jwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvc2NzaS92bXdfcHZz
Y3NpLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvC
oCDCoGh3L3NwYXJjL2xlb24zLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3ZmaW8tdXNlci9jb250YWluZXIuY8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgaHcvdmZpby9jb250YWlu
ZXIuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQomZ3Q7
wqAgwqBody92ZmlvL2hlbHBlcnMuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3ZmaW8vbWlncmF0aW9uLmPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KJmd0O8KgIMKgaHcvdmlydGlvL3Zo
b3N0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAxICs8YnI+DQom
Z3Q7wqAgwqBody94ZW4veGVuLW1hcGNhY2hlLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBody94ZW4veGVuX3B0X2dyYXBoaWNzLmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoGh3L3h0ZW5zYS94dGZw
Z2EuY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMSArPGJyPg0KJmd0
O8KgIMKgbWlncmF0aW9uL3JhbS5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgfMKgIMKgMiArLTxicj4NCiZndDvCoCDCoHN0dWJzL3BoeXNtZW0uY8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDIgKy08YnI+DQomZ3Q7wqAgwqBzdHVicy9y
YW0tYmxvY2suY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDQgKy08
YnI+DQomZ3Q7wqAgwqBzeXN0ZW0vaW9wb3J0LmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB8wqAgwqAxICs8YnI+DQomZ3Q7wqAgwqBzeXN0ZW0vbWVtb3J5LmPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KJmd0O8KgIMKg
c3lzdGVtL3BoeXNtZW0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKg
IMKgMiArLTxicj4NCiZndDvCoCDCoHRhcmdldC9hcm0va3ZtLmPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDEgKzxicj4NCiZndDvCoCDCoHRhcmdldC9pMzg2L2t2
bS9rdm0uY8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHzCoCDCoDEgKzxicj4NCiZndDvC
oCDCoHRhcmdldC9pMzg2L3Nldi5jwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
fMKgIMKgMSArPGJyPg0KJmd0O8KgIMKgdGFyZ2V0L3BwYy9rdm0uY8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgMiArLTxicj4NCiZndDvCoCDCoHRhcmdldC9zMzkw
eC9rdm0va3ZtLmPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoDIgKy08YnI+DQom
Z3Q7wqAgwqB0ZXN0cy9xdGVzdC9mdXp6L2dlbmVyaWNfZnV6ei5jwqAgwqAgwqAgwqAgwqAgfMKg
IMKgMiArLTxicj4NCiZndDvCoCDCoHV0aWwvdmZpby1oZWxwZXJzLmPCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAyICstPGJyPg0KJmd0O8KgIMKgcnVzdC9ody9jaGFyL3Bs
MDExL3NyYy88YSBocmVmPSJodHRwOi8vYmluZGluZ3MucnMiIHJlbD0ibm9yZWZlcnJlciBub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+YmluZGluZ3MucnM8L2E+wqAgwqAgwqAgwqB8wqAgwqA0
ICstPGJyPg0KJmd0O8KgIMKgcnVzdC9ody9jb3JlL3NyYy88YSBocmVmPSJodHRwOi8vYmluZGlu
Z3MucnMiIHJlbD0ibm9yZWZlcnJlciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+YmluZGlu
Z3MucnM8L2E+wqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAyICstPGJyPg0KJmd0O8KgIMKgcnVz
dC9zeXN0ZW0vc3JjLzxhIGhyZWY9Imh0dHA6Ly9iaW5kaW5ncy5ycyIgcmVsPSJub3JlZmVycmVy
IG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5iaW5kaW5ncy5yczwvYT7CoCDCoCDCoCDCoCDC
oCDCoCDCoCB8wqAgwqA1ICstPGJyPg0KJmd0O8KgIMKgMTAyIGZpbGVzIGNoYW5nZWQsIDI5OCBp
bnNlcnRpb25zKCspLCAyMzQgZGVsZXRpb25zKC0pPGJyPg0KJmd0O8KgIMKgcmVuYW1lIGluY2x1
ZGUve2V4ZWMgPSZndDsgc3lzdGVtfS9yYW1saXN0LmggKDk0JSk8YnI+DQo8YnI+DQo8L2Jsb2Nr
cXVvdGU+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--000000000000fcbc73064709298e--


