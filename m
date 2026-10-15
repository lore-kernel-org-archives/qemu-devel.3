Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A18CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHITG-0006yg-It; Thu, 15 Oct 2026 06:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matej.genci@gmail.com>)
 id 1xHITE-0006yU-Jr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:13:56 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matej.genci@gmail.com>)
 id 1xHITC-00022R-Uh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:13:56 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-3a9c92ae2baso3049771fa.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792059233; cv=none;
 d=google.com; s=arc-20260327;
 b=eWKc1+UxDC8/ONvjkk7Va7tLjs6hOAp+li+laY8v+SCWDlvw7olzrFp/cit8i1INor
 tHVj/55MK7741OX3VQKKUmoVpXWwxbK734bnmZ/JKkUzp3rpLohDzHXmpE9ismWOWQ2+
 7eWWfWz+3BeAJxv7ckppDjhgzFMPddp+f2AETJ1tE0zq0uwmjSkFN1em+uxenUT208e/
 W77pArRIPdqRfTaOh81RoKcVKPWjHT1+L2l1i0/VY6czS5YA+4X5M/43ery7rIskReye
 Fu0z6NXgz1NT4fAouGWv5pVRQFbz5nyoK0Kh2MryjnNzj0qoCsrL9hH81N6fxjJJqhqJ
 5pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V7FV/dTwFGrcauIXhrX1W/yFqLF8BHPLVW9WAIrFS48=;
 fh=Tb6WBeUDfBuO0BpTweklRTDnk0a+mqTEY8X68pFdVvw=;
 b=eoXBWV4cnRruDE4iJ+hej4hOjHyZlqgULPzJyslk12P37D6ZM7Y+2tIivBTHBN/8Sj
 cTHXLGvgrf+EJAAWQ7xb5M9q+mA+Frwa+h2ATWNcVmqiWQcWdWIkwt3HQnvmEZ1pW1yH
 voxoWTRQe/9v9N6Wsi69ngakShJhjOA4Zc/IXR237Y7SqxFAjJwXqT5vz1YkACpqOwdY
 hCnVziw9oz7wcaGDTvWUjEr+IWnhQ3GGbrJf7vsyDJQM/FVrhePqYGU9vLTu/w69KoUS
 00dW4mj4GzwkmKsfuMMzbiK2nzflYI1F1JVoJjhN9hvp0xpex1W8Pi7niDOwmYtBxZYf
 ESCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792059233; x=1792664033; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V7FV/dTwFGrcauIXhrX1W/yFqLF8BHPLVW9WAIrFS48=;
 b=j0j+X3dnCdGVqCMa6WorLnNxpVqm+AkwdFwKTeNASsNWLI0nLM0gHu2vSAL2rlqsYV
 UGkfeGF+s7O+VyjTH9ehtso6lXKlvt7htnsiA7N4PwFnxoLhOswG1LooW5OfDT2DwpA+
 SoL6tzrc8yw3Ezy6mfADZk8W4UHKo4ljQ1fPhumZZQQ9o3FfO46+cplIWiHvNdHLFPew
 7d2B5mpXB6b+O5W/hnmg4UTkf9zeZnNsSulCz7ibfikIXNGWWKB7H1KOsw6hABhu/chT
 1j8M+m3c6o5uDSgPmA0oYF3cXNVujcpGBKFxFfNe6/COmalDAzAfUjUfNrj0J5uCkVIo
 IqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792059233; x=1792664033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V7FV/dTwFGrcauIXhrX1W/yFqLF8BHPLVW9WAIrFS48=;
 b=aYUG/cAMAw32tujmQdXA00awvt0X5xi0sTbIqlxngyNmnuxs/TP9OZTLD8/xHKlKgn
 vEd5d/nqnry87wiZLZAh64q3dxy2XLRfuRt64PhexZqgdkz6oT4SOAMVCG0LpiyYIlX+
 iHhhDqzBYbwTQXfvP8dN+nYmwi8+wPHSyHUBqa/4j9VeeC4J9DfK0l+sfIjdeIa8Yh10
 lrk5cz7vB5xNxlZzaOS/abn9+Wnr9rRYCX18UhVDbobrWOLQuyRWif1pyjKRDax9lF8+
 t3ukCPsuv+2K+eqlWMH9+0nz5avv+xeHVdRCIgnoYylADXcwIz5empDANDkUsdQiIjoO
 i41w==
X-Gm-Message-State: AFq9FYIAXmEO6GCxyzhzV8YNZsNdpF+j94wKl5SNx2kWb/ENiTvxQnkM
 3w67s7bVFLlY2OtYfP8jpw01nMaiUdQ8u3SKkPnb0wcA/65QRay7Ds9sU20eGZBJ38UKe+YImC3
 ZGClNFUeWRh0tJzYeSLEPhn+stX1MKoc=
X-Gm-Gg: AYBFou18Zq1e0Tm6LtdeWSsUZaWKcF/GuE2PSMI/q+/+MUgVUVq7G5BeCkgL+hqMSPv
 AQ2znBuHR5T17jptOQEWoLQjNPpCJZ7rgNKMK1Dfki/cnoV5qTm+wiGpsAaGJwIyBpXCMS4ZBsK
 p7XUzipbVHD72wiUklhFuehh8HqMaUX8x1wW4RvKJ+PdFnyVGdA2e77TnRX7YYAf93HqLpWHkUZ
 FcyE+lR2pjklCDbbpnPS2jNZ8lP2M9Yv5reW9DzClE0QTHoAW0ujaixISVxwDiztYKlozIA4jmI
 6358F2KcaCtehs+y2aig9JRkHMpBsDTAFRiCCFi1Kz8z6c/akIp9
X-Received: by 2002:a05:651c:a20f:10b0:3a9:8408:8c5f with SMTP id
 38308e7fff4ca-3a9c54b827emr27907211fa.10.1792059232660; Thu, 15 Oct 2026
 03:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHPkGVdzQzqnW0MS9G-7xDuakHfjqYZCRR9HATDsBy0ZyTXLmw@mail.gmail.com>
 <1365f6c8-c44a-409d-a0d0-696adfc9417e@redhat.com>
In-Reply-To: <1365f6c8-c44a-409d-a0d0-696adfc9417e@redhat.com>
From: =?UTF-8?B?TWF0ZWogR2VuxI1p?= <matej.genci@gmail.com>
Date: Thu, 15 Oct 2026 11:13:38 +0100
X-Gm-Features: AclHuK9iRRZkLeyW4m-txOeqs9P_GE2u3GL6LVspjchmu9GsoKm1kzBlwxb56gM
Message-ID: <CAHPkGVcciQ+byaL46ATLuAcumJHqeqz0Y2rfUApKnkzrfz9iOw@mail.gmail.com>
Subject: Re: Establishing an order between messages on the primary and twin
 sockets
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, thanos.makatos@nutanix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=matej.genci@gmail.com; helo=mail-lj1-x229.google.com
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

st 14. 10. 2026 o 18:12 C=C3=A9dric Le Goater <clg@redhat.com> nap=C3=ADsal=
(a):
>
> On 10/14/26 17:10, Matej Gen=C4=8Di wrote:
> > I'm writing a TCP transport for vfio-user. When I was looking into
> > bringing back the interrupt message, I realised that currently we have
> > no mechanism to establish the order of transactions across the primary
> > and the twin socket. With a slow connection, operations can happen in
> > this order:
> >
> > 1. twin: Server sends an interrupt message
> > 2. prim: Client does a REGION_WRITE to disable (or reconfigure) interru=
pts
> > 3. prim: Client does a REGION_READ to ensure the write was processed
> > 4. prim: Server completes the read
> > 5. twin: Interrupt message arrives, client raises an interrupt
> >
> > My understanding is that PCI protocol guarantees that 4 and 5 can
> > never happen in that order - the read acts as a barrier and the
> > interrupt will be sent before the device responds to the read.
> > This shouldn't be an issue if we use a single socket. All multi stream
> > transports (UNIX twin sockets, even interrupts via eventfd) can hit
> > this race, but TCP seems particularly susceptible.
> >
> > To address this, I propose adding a sequence number to every message
> > on the twin socket (explicit in the message payload or a separate
> > counter in the client and server, I think either will work).
> > Replies on the primary socket will contain a `twin_seq` field with the
> > sequence number of the last message sent on the twin socket. Before
> > acting on that reply, the client must have received every message from
> > the twin socket with sequence number <=3D twin_seq in the reply. Posted
> > writes must be delivered to memory or interrupt controller, for
> > non-posted requests the client should receive them without waiting for
> > completion.
> >
> > The `twin_seq` field should probably be a negotiated feature, which
> > would require additional changes to the wire format. Alternatively, if
> > we don't mind a backwards incompatible twin socket spec, we could
> > enforce this for all twin socket connections.
> >
> >
> > I want to get your opinion before I propose some spec changes or
> > publish QEMU patches.
>
> Does vfio-user support twin socket mode ? I don't see any implementation.

The spec defines it, and it was discussed as an alternative to making
the QEMU client fully async in
https://github.com/nutanix/libvfio-user/issues/279
I think it's worth resolving the issue in the spec, even if there is
no client implementing twin socket mode yet.

I intend to contribute a QEMU client for TCP transport, but I'd prefer
to resolve the spec issues and corner cases there before I publish
client patches. I feel like that will be easier to review.

>
> Thanks,
>
> C.
>
>
> > Fwiw I opened a discussion on this topic on
> > https://github.com/nutanix/libvfio-user/discussions/883 as well before
> > Thanos pointed me here.
> >
> >
> > Matej
>

