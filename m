Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5816CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 02:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub96V-00034S-Ba; Sun, 13 Jul 2025 22:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1ub94P-00011s-9y; Sun, 13 Jul 2025 22:37:33 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1ub94L-0002ZY-W4; Sun, 13 Jul 2025 22:37:32 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3122a63201bso2880177a91.0; 
 Sun, 13 Jul 2025 19:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752460648; x=1753065448; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XEVO24rPMbQgNbO5DJJcRqLXXAX+wfY4X+88PJAaoc=;
 b=E539AmxoAcmWtAv0XmL9vDjUj4FC/swSK3fh2ga8hilOSIhYRweXL3mJxurDkog0Qs
 rbUmMsNsrNl3yZF1aA36XxeVpvbGKdM+Pqv7z9B+taXylyJyNvT04yJFtDxFkZwBBGuW
 S8NZ0F2/YRF/oN63COBtkirRynxXLZHI+di9zu7VgEHDjarZ/6yGjoFmW9iRfQB5C+5g
 XQ0XReTjkSfFEjKweXpYAVS9ejAZdPPAHsK+TtHuMakgLVTKAwoE3GgjdwFuHjV1+/MZ
 C2EHP6/jQS9b8PbE1Qn4QYmCq+L3nNvDDC1fedK7Xl93jx+N04x1RSVDiUgg/NS5420f
 oGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752460648; x=1753065448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XEVO24rPMbQgNbO5DJJcRqLXXAX+wfY4X+88PJAaoc=;
 b=tiY5ouRScj8vcby2ZzpQecy6Z8zbCijMmOCa6iNWa/9wLD2/t1r6GVeVswLnfuCyXd
 WNjwXmR6a3DEOGEb5aDYvdPKVL5ohn1ejYOb1FOIqr1m5S08voWmxoZjqH9CZr+Idkhz
 pdf7aNkhWamYvvGdeZZif7RGNZm9deQTt3ewMbJM/itz0J1U0vhbCRlZyh+bevwDJwWo
 e34fNZMSh3VZ5H+PzKl6dLSEUeg821p2Qt+Czbvd1Nyaqefr/V5h8N7HYhryYNNZrRd9
 Vqyyrs5TLnhtdq8pXHZ9hKWjfv4KkQMXPKX+l1qQL//q1pa8tCXf49x8Cbwkd+yMvsxx
 mItg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+F+zml7PM9p8pOkAtK88rcwuTkPys0zQi5UJYhX/TAIs3tP1BRYZY3xLQ1cd2iTs6vdTwyFkj9GuUvRk=@nongnu.org,
 AJvYcCVNTRBKz227rNwAoRMVk34cppLyB9HNKFyDL0ZZTJx6cfC2gScLJdRkdBWpGjccvaEsniSaxgGuiP2e@nongnu.org
X-Gm-Message-State: AOJu0YxCx+Ob25zJkPQYbgZ/acnDE2GGnUaBfWmnprp8RuKpFtJWRFUh
 lz+6FRVMxCQndGyTRG1bQepBHMEzTZuvIWgcapkmMZx525w97iIFSWp5uJz7/1WeSDZslmtT9Hz
 KwDHkJ81VMozp97qm6YWUfyeiWTaZyFo=
X-Gm-Gg: ASbGnctfWLeZCRGAgS0IP2r1m/hCSWF8jz4R0rI95fLCAYv0F+1EZ6MtMHsm868Vl2v
 e1UZ13kjtiG5NLxrhlzwnIp02sEJaaTrgVdyvQ1TjCXQ6mexhXq0q8VtUGV/JL+/Qbd2nZ2givF
 Dh3St6x5IueCjtDBIynmyrwJSNxJ2vbHstf8hu6KcRuUwWBAXqllTV+Cd+DKOtF4Rg6BQkILcge
 Ogd3KA=
X-Google-Smtp-Source: AGHT+IGT0rta7/EFr6gBAkglyA/cFgE/5A3G1ZBwAkrBW+PEJUJRg0+NxTA92BqR0qqnmdWab1JtMnEavOk6N5zSk+4=
X-Received: by 2002:a17:90a:d407:b0:311:ea13:2e63 with SMTP id
 98e67ed59e1d1-31c4f4b80d9mr16136299a91.13.1752460647754; Sun, 13 Jul 2025
 19:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250605083338.1845911-1-chenhgs@chinatelecom.cn>
 <238cce11-3050-4ec8-acbd-b1605f9dc4a1@tls.msk.ru>
In-Reply-To: <238cce11-3050-4ec8-acbd-b1605f9dc4a1@tls.msk.ru>
From: Huaitong Han <oenhan@gmail.com>
Date: Mon, 14 Jul 2025 10:37:15 +0800
X-Gm-Features: Ac12FXwbW9wXAB_Wa8ofSS0i6URYxRvO_j3BEUBnLvRTTZFkiEi3sAVzq8mOYDA
Message-ID: <CAAuJbe+dNpdA62CjfQfGq0Ph72w+Nooyax=WdRuYCRTPRngvxg@mail.gmail.com>
Subject: Re: [PATCH] vfio, migration: save device parent pci config
To: mst@redhat.com, clg@redhat.com
Cc: mjt@tls.msk.ru, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huguanshen Chen <chenhgs@chinatelecom.cn>,
 Heng Zhang <zhangh121@chinatelecom.cn>, 
 Huaitong Han <hanht2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=oenhan@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi, mst, clg

Any comments?

Thanks.
Huaitong Han

Michael Tokarev <mjt@tls.msk.ru> =E4=BA=8E2025=E5=B9=B47=E6=9C=8813=E6=97=
=A5=E5=91=A8=E6=97=A5 17:12=E5=86=99=E9=81=93=EF=BC=9A

>
> Ping?  Has this been forgotten?
>
> Thanks,
>
> /mjt
>
> On 05.06.2025 11:33, oenhan@gmail.com wrote:
> > From: Huguanshen Chen <chenhgs@chinatelecom.cn>
> >
> > On arm64 virtualization platform, vfio-user devices lose their interrup=
ts after
> > migration to the destination. This issue occurs because qemu fails to d=
eliver
> > the msi device id to the vGIC. The error device id is calculated based =
on the
> > device's parent bus, so it is essential to save the parent pci config t=
o
> > prevent this issue.
> >
> > Backtrace:
> > QEMU:
> >   #0 qdev_get_parent_bus
> >   #1 pci_dev_bus_num
> >   #2 pci_req_id_cache_extract
> >   #3 pci_requester_id
> >   #4 kvm_irqchip_update_msi_route delivers 0(error id) to vGIC
> >
> > KVM:
> >   #0 find_its_device returns error
> >   #1 find_ite
> >   #2 vgic_its_resolve_lpi
> >   #3 vgic_its_trigger_msi
> >   #4 vgic_its_inject_msi
> >   #5 kvm_set_msi
> >   #6 kvm_send_userspace_msi
> >
> > Reported-by: Heng Zhang <zhangh121@chinatelecom.cn>
> > Signed-off-by: Huguanshen Chen <chenhgs@chinatelecom.cn>
> > Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> > ---
> >   hw/vfio/pci.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index a1bfdfe375..442113d0b7 100644
> ...

