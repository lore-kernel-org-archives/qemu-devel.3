Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EC0F34C4C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGHI-0004Ui-4w; Mon, 13 Apr 2026 08:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGHF-0004UR-BV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGHB-0000VM-Hh
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776082824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
 b=cb5jht3GepqEY6CUkzUDO2z2AZxi9FDT4RIFrceHfetK02vfb2mkrvqp9mhdeh0d4AOkKE
 Pg1e1qWAgb1I0NIztodk+mfGEsy1P7ctwDGlwUF83GJZ7aBGY79WUdTmKxuXOqmj3pGxFP
 4M4W2SJByWNKobNyhca68w48WGRpTzI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-E1uUgcQYNQ-vwI3LbmprZA-1; Mon, 13 Apr 2026 08:20:21 -0400
X-MC-Unique: E1uUgcQYNQ-vwI3LbmprZA-1
X-Mimecast-MFC-AGG-ID: E1uUgcQYNQ-vwI3LbmprZA_1776082820
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2ed279eedso8308775ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776082820; x=1776687620; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
 b=NkxntGOVzeb+KRqKbr/PZxqpzbof8Kx63ebL2cyKe1JnM4a02gS3ssxalfmJ0+ZVaP
 laz5mTXJMDDZX6KSP6E8Vo+F5PFGe6A1ChRCaQYBUuhsQ5h2AoI7jhrBGROf7UwnLGtZ
 pEaMSMWdAdUqMIfMgCt6fD0cT5aoVSZ/0iEb9/H3w1eOpy2Es4l6M5WOwYVDEcrrbXhr
 RCyWLHplzbZMzHbQL0+keaF1Oh+bcTZDyfMtJvtdPPaui0rVVbTafv2SUTARZOTuhToU
 2X9LwEO6bT9ijytB7RoaNt7bTNQ5PKhig4dCekOPmdNKXpMtd8ZUeVnSrTvteB6rDI7L
 G7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776082820; x=1776687620;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sg+50Q8sxRR1Aj/0H7R8h6PT06l8kVwGZNKTmLDU/uw=;
 b=oTjr/FCQD/H1id3frRfczpV3Yt+7Uo18z5bHg+7sfhSOV2wrafaUfSZ7OFLFEBwyVW
 VxRQTmtviptQrrdjAZedGOvSI6MtAnDl+CAwb6dAuxfsp0dOVWc1N1N89rf/xW/Td1Do
 B4qCRH6gCvqpoyeeMbBMDlngHd4RwoaC+LhJdFFsC8GrAB3M7497XjMKv8NM7atoLebt
 fCOSjDktF82MAdC1yKG4qRX/ggO/GJoKoneLS8CJ9HkxzNGlWglC/Xf/7UETnt455Ieo
 n5E+AC7XJdc4V+T5y7/mE2EtVrcySFFjplPnCiibNYi1EYnaH/MbIKUtaXnmCr/5tAhq
 Uwvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sz3Xq4F3f1SelJ7PAgcN/IcLQVeFpMElF+pS3RJgf7sln9a89uscLkl1IXgzobeeHYIlOxRsVMrqG@nongnu.org
X-Gm-Message-State: AOJu0YxPFddOmT6rLS7fTbXerIiylik2q4UuzoyGYvdE7apgvHYk5YS3
 4VzqQQwsSJ2eqEng4MIFjROxnbr/k6Ekjx8jjfoNxvi1A8airIJEh3BHFFKSmDbSV3Li3WwJ5A1
 PuMgxUtAzHUL90JnD0T3Gar5N4/raqiwZJAQuipJytHx1ciO2et+8/oybCMK5nIF3
X-Gm-Gg: AeBDietp3QpmPj2gse/txgSGvR9OyuwIzSm7d6GLa/U3u+LXR9bi45jMZV7ED9+xJ+D
 dSPDzkz6iN4y/NfIiWfGOj4EgSX54QejV/MDBTIF41K4WrNwYsMenJvpROOb19BnpWpXlTm+YIA
 dfKywlxxsBNG0bKpYu8fozYGBtlMDh/vYxbShXbkvdTuahkt/yojLP9657oBD7zEGJx0gyKgLQd
 aCOyTw+JsPm0ZQaWEAm9mqEWNukyXeVHPOvaCHr/e4jT48lKWRf+ll7Gonhnrz3oIyi/5BXHpae
 Fk1YB6/bpUH1ZLLccEMrOXOBne1i09vnjBT9MExk0WYoTPqzaEINgkYmRuStUXqzsGtdOL3YLZ7
 Tg+GuAY0L7evuMFXtmwMjz3lx3ApoBZBL82CqIhQIUdD1iryCLPnc3ToGj1Qk5Dog2qYbF8wIO/
 4=
X-Received: by 2002:a05:6a20:748b:b0:38e:9220:ebbe with SMTP id
 adf61e73a8af0-39fe3d616a7mr14231524637.23.1776082820017; 
 Mon, 13 Apr 2026 05:20:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:748b:b0:38e:9220:ebbe with SMTP id
 adf61e73a8af0-39fe3d616a7mr14231494637.23.1776082819551; 
 Mon, 13 Apr 2026 05:20:19 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7922de0626sm10683181a12.13.2026.04.13.05.20.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 05:20:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA8CcD+8Hn2++X5FnyYcsDLV4J=tFg5BAd_sRJmCw+nVkg@mail.gmail.com>
Date: Mon, 13 Apr 2026 17:50:04 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1974E499-C3D2-4A3C-A5B9-89961751F23E@redhat.com>
References: <20260413090010.60339-1-anisinha@redhat.com>
 <CAFEAcA8CcD+8Hn2++X5FnyYcsDLV4J=tFg5BAd_sRJmCw+nVkg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 13 Apr 2026, at 5:40=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>> not present in KVM. This was not translating to an early return from
>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>> can check the return code and return early.
>=20
> As a fix intended for 11.0 at this point in the release cycle,
> it would be helpful if the commit message stated what the
> user-visible consqeuences of this bug are.

Ok I would appreciate if you can add this line in the commit log before =
putting it in CI:

=E2=80=9CDue to this regression, all KVM guests on PPC 64 hang =
immediately during startup"

Or if you prefer, I can spin up a new version with the updated commit =
message.

> That helps in
> identifying whether this really does need to go into 11.0
> (i.e. whether it is release-critical).
>=20
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> as the minimal fix for the logic-bug introduced by 98884e0cc1.
>=20
> thanks
> -- PMM
>=20


