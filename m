Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B431EE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 10:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVTfK-0002Kp-6A; Wed, 08 Jan 2025 05:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tVTfE-0002Kg-IL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:51:54 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tVTfC-0007Bf-6s
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 05:51:51 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso15911260f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736333507; x=1736938307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4iCOjuZ/xAqj/+8jAiztsVvLpoUdK7ynsRVlAarbkA=;
 b=YwBlR5vDY+AYohLjdDqN2m5vGLqB66loeKkAwzwsYw8rH8kN3f6ge7h9wmq9w+FRTO
 qWGNOFbfFGKvFcj4BFbZf/femx0wS27S4YNXMTGbuvKmGZxPH+AbI5VeCi1FS8HYtfh7
 SoRAQfcNsPvw9fXwr0aIr5oThG1QKpadmYWFYdmvaHkgLs3kkNpWYcUCbKpVELi82a+B
 ZDDBqem0vXoTXNa4/7eGpFctztj3SUOE2RycMMZVK/ro3GVGyn//6yptyGCFso2TAIMD
 O3eRSgiPtMqrFcgIMWyYmrq8aG2IB/pFPhJfif+tYJhbndPEyI2hAESJupDSUAEmzm3W
 be5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736333507; x=1736938307;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P4iCOjuZ/xAqj/+8jAiztsVvLpoUdK7ynsRVlAarbkA=;
 b=eiCmc7HHUgbvUUrYMdQ1MIpzMZO2XdxIEke/4Bl6QbOeo+KAZ+rF1WKzhjw6pPAjkB
 0mO8yaqyIn1bpJxLSwsX/gO8yHwgVvRedgryeluyuwxp/cflPpt9cIANCYix8JKXIIGt
 MS5aSxE1F6k3vINTkmRSqu9o+9dJDENr6ouWyjUUlWsYe6kUFW3+HiI+viw5jh8gOTXz
 ukgS9iJ4QH5yqJdNCd/7m12kg2vnvddE95/fLmKS7C9Y4Rn5Mi3TlKWN4b3UUE100uL3
 lwLyJfpHQVdSwA612zgwf8YWzHs7AKeZWYNFmwpvP06loovukGRVZHmGN8Yem8KlTZ6Y
 lNHg==
X-Gm-Message-State: AOJu0Yy9kLyDhAVJBZRAfx3iUjfeZ7SxmjtWjUXY0Ov9XLGbtt/0ULHR
 8lA7/mQ4XMR+OAy1Ca7c9oXRg+o2dhPI7FpDcVUesRuznMHiqZBBy6nQmQ==
X-Gm-Gg: ASbGnctOmJeRKgioesg46mzO/L32C6VrPCXr2R3plXvlQzVCCORZlF4V4jxZ3XNWhGP
 2Fl1tvmOnkpj1BK/IMbhCCjps1s3BN+Xh5WlrT4WK9nPmGnYkOgzSBEypihs4TIZc3QJSN2H1qg
 eD6dOBg+ERCaHc255mMMOxjDz49SqrqHpjDNaiZ0LyKAPC+tfno1/uffHVMvlIDCZsiGwNDPSAS
 YAJSNEVFmBSKilkTbCaIobIzAe04raen9ZmQS9gL5uJbOKAwLbw
X-Google-Smtp-Source: AGHT+IGqIaT+5M6eC6yS9qvb4iMsCuARl6VL60xRz6RyrP+G7RI+BXnESAj30GlnVwk2/mfARZp9ag==
X-Received: by 2002:adf:a3d2:0:b0:38a:88f8:aac6 with SMTP id
 ffacd0b85a97d-38a88f8ac78mr931149f8f.41.1736333507056; 
 Wed, 08 Jan 2025 02:51:47 -0800 (PST)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aaf5d1b602bsm1138530266b.178.2025.01.08.02.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 02:51:46 -0800 (PST)
Date: Wed, 08 Jan 2025 09:45:43 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
CC: Thomas Huth <thuth@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/i386/pc=3A_Fix_level_inte?=
 =?US-ASCII?Q?rrupt_sharing_for_Xen_event_channel_GSI?=
In-Reply-To: <8b2690f2c9532468fd5029d319737904b58acec2.camel@infradead.org>
References: <e592f9127f2d9919e6ccb76a0afb38c5d725d8ec.camel@infradead.org>
 <20250107110718-mutt-send-email-mst@kernel.org>
 <8b2690f2c9532468fd5029d319737904b58acec2.camel@infradead.org>
Message-ID: <E60B2E8D-23B5-43E2-8DC5-FDBA30EB40EF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42d.google.com
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



Am 7=2E Januar 2025 16:20:28 UTC schrieb David Woodhouse <dwmw2@infradead=
=2Eorg>:
>On Tue, 2025-01-07 at 11:07 -0500, Michael S=2E Tsirkin wrote:
>> On Thu, Dec 19, 2024 at 05:24:11PM +0100, David Woodhouse wrote:
>> > From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>> >=20
>> > The system GSIs are not designed for sharing=2E One device might asse=
rt a
>> > shared interrupt with qemu_set_irq() and another might deassert it, a=
nd
>> > the level from the first device is lost=2E
>> >=20
>> > This could be solved by using a multiplexer which functions as an OR
>> > gate, much like the PCI code already implements for pci_set_irq() for
>> > muxing the INTx lines=2E

Just curious: Why not use that aporoach? Could <https://lore=2Ekernel=2Eor=
g/qemu-devel/20250108092538=2E11474-5-shentey@gmail=2Ecom/> help?

Best regards,
Bernhard

>> >=20
>> > Alternatively, it could be solved by having a 'resample' callback whi=
ch
>> > is invoked when the interrupt is acked at the interrupt controller, a=
nd
>> > causes the devices to re-trigger the interrupt if it should still be
>> > pending=2E This is the model that VFIO in Linux uses, with a 'resampl=
er'
>> > eventfd that actually unmasks the interrupt on the hardware device an=
d
>> > thus triggers a new interrupt from it if needed=2E QEMU currently doe=
sn't
>> > use that VFIO interface correctly, and just bashes on the resampler f=
or
>> > every MMIO access to the device "just in case"=2E
>> >=20
>> > This does neither of those=2E The Xen event channel GSI support *alre=
ady*
>> > has hooks into the PC gsi_handler() code, for routing GSIs to PIRQs=
=2E So
>> > we can implement the logical OR of the external input (from PCI INTx,
>> > serial etc=2E) with the Xen event channel GSI by allowing that existi=
ng
>> > hook to modify the 'level' being asserted=2E
>> >=20
>> > Closes: https://gitlab=2Ecom/qemu-project/qemu/-/issues/2731
>> > Reported-by: Thomas Huth <thuth@redhat=2Ecom>
>> > Signed-off-by: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>=20
>> Xen things so feel free to merge=2E
>>=20
>> Acked-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>
>Thanks=2E
>
>Further testing shows I need one minor fix=2E=2E=2E
>
>> > @@ -1596,7 +1607,7 @@ static int allocate_pirq(XenEvtchnState *s, int=
 type, int gsi)
>> > =C2=A0=C2=A0=C2=A0=C2=A0 return pirq;
>> > =C2=A0}
>> > =C2=A0
>> > -bool xen_evtchn_set_gsi(int gsi, int level)
>> > +bool xen_evtchn_set_gsi(int gsi, int *level)
>> > =C2=A0{
>> > =C2=A0=C2=A0=C2=A0=C2=A0 XenEvtchnState *s =3D xen_evtchn_singleton;
>> > =C2=A0=C2=A0=C2=A0=C2=A0 int pirq;
>
>=2E=2E=2E
>
>@@ -1628,7 +1656,7 @@ bool xen_evtchn_set_gsi(int gsi, int level)
>         return false;
>     }
>=20
>-    if (level) {
>+    if (*level) {
>         int port =3D s->pirq[pirq]=2Eport;
>=20
>         s->pirq_gsi_set |=3D (1U << gsi);
>
>
>

