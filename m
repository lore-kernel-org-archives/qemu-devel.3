Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4C4C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLwd-0001B5-13; Thu, 17 Jul 2025 06:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ucLwb-00018y-9M
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:34:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ucLwY-0000sI-ES
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:34:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so5395275e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752748462; x=1753353262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LgcW96k10F488CMHnlCEDCb7XMIS/y0i6ItdbnUtfAY=;
 b=WfO6K1ssqvWkwJIQ9LtkT47YqTlyHgBoEPShMEH6775BgU9chx5WO6vAsMuKIPaTZS
 MU8OVb64oQ4DdCanklWRPliGBnyR99Mv9EdoUhqkNLNnpP6qv4Lksk85xH2STQY+Qw+E
 gQL9WFdErQWRvQZVfoeUO6eqVPuLOfi1WfisMHfJIGzTZAg1WlHsQtV/Pg15gW4GEVl+
 2i4QlnZHWgIlfpBNLZWXFRrYV0H9rRMKbh3vsbbyrVnSqozWt8ULNlqMcYmY+6LXO9Fu
 +rm3fTs0Mn5de+O6ZbGz048qS61vCRy/3hdULvVXQmU0F4M2nMprWtL42wX0DJ5uqcRS
 Bt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748462; x=1753353262;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LgcW96k10F488CMHnlCEDCb7XMIS/y0i6ItdbnUtfAY=;
 b=AgeNXKAPWPwG76zgNnf6wseev28iE5r7MCGXR9zju1m6BBFCj6vKyPzqtqe0P6iJk1
 /YCx3fTiZ6Ky6c7p5Rb1sLXAvovXvbJQlh2xlPLNK1+OmuReVXbSc/C1VLwA9u0X3F4P
 oxyss3PPrD4qvQmGFj/v8Mg/+foQAbczLb5FOXOKtjAzVuWDbWaSZsmzc8YUWgr+uiAm
 3eWtLpjLNgE4lKJAloaPiMbTxhZ9fnOwHSMbqRrhXIr07oA05r6H++gGooV2sTh50d4d
 t++DrTl5wQUqG1B5ECWgCefXFr4SVRW1CpdE1SN4+/BwYVCwitOBlfGRfxGRJPj4wnh8
 ACnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSISABJ7gBTJ6vnHkm6kNegM/7HgyyKSTsFmgB5fp+x9qL7lWXXNDoJkb1sYtwXYE6HToG+Pa0/LWF@nongnu.org
X-Gm-Message-State: AOJu0YycYHiYNGrGX6H7mFRzM567vX+c27qGomQM2P23stsFAsSIZmsF
 Dn2oRo/szOe1DL1uYn8wvvm0ZtMfZxEVs6di8YDyVzJGitAIVCuZN36M
X-Gm-Gg: ASbGncsR2VS+L+Kb74Bzk+HgQZElPDSuquNXXsS9J+CrJHuYsNmLCjc/XrLUIVj7wbY
 04tPwPMMne9P5Z37ChOqw4uXecYjFHR24uGS3byqo6X6vaQqSgAOPA6Uyh4pM4IAZdt7+CEVFmY
 CEWKdfwXlkSOe5zPAYLdzedfi+eI24+hFtjFXP9Z8lzLfughx9HZlSiR2efeQ5DHcR9ABf5v2Z8
 I/C0leig7Q/knZYYDcTNJOJ1mowgqIXguSah3YC7ELltCByRa4YZ3zaY3kK2LooD0a1lf30qGkK
 oF4gGtS2A2vDAJYEHf+Hf3Lq3nuuLMHomvpn6bXPVhXkYwIXy/UFkJvZvzG6FlKgLyRq3Bexadv
 6aKb/Yl/Swk930Nzw
X-Google-Smtp-Source: AGHT+IEJqfQQeqaTaINZnur2GzmEn8OdoDAGrCaqF9WPN5kXkV0H7AijUtFaE9Qiw1Elrx+P+DZ22w==
X-Received: by 2002:a05:600c:8b76:b0:456:1752:2b44 with SMTP id
 5b1f17b1804b1-45634fdff3fmr18636805e9.23.1752748462125; 
 Thu, 17 Jul 2025 03:34:22 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e8ab642sm46203625e9.36.2025.07.17.03.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 03:34:21 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:33:59 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <groeck7@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_hw=3A_usb=3A_xhci=3A_Add_property?=
 =?US-ASCII?Q?_to_support_writing_ERSTBA_in_high-low_order?=
In-Reply-To: <b92f0b78-6a8e-47ad-a980-f449b76af810@roeck-us.net>
References: <20250405140002.3537411-1-linux@roeck-us.net>
 <20250405140002.3537411-2-linux@roeck-us.net>
 <D93N0YH6FKHH.3JBGQVVKLFXSY@gmail.com>
 <41a54c58-25df-4027-bc93-45a817c2d570@roeck-us.net>
 <15C9B399-B43D-4D81-9FBA-64C30C07C94C@gmail.com>
 <b92f0b78-6a8e-47ad-a980-f449b76af810@roeck-us.net>
Message-ID: <D357B3DC-9DF7-4CEE-BB6D-3E43CF6EF523@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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



Am 16=2E Juli 2025 20:07:25 UTC schrieb Guenter Roeck <linux@roeck-us=2Ene=
t>:
>On Wed, Jul 16, 2025 at 07:59:16PM +0000, Bernhard Beschow wrote:
>>=20
>>=20
>> Am 13=2E April 2025 16:03:16 UTC schrieb Guenter Roeck <linux@roeck-us=
=2Enet>:
>> >On 4/11/25 00:40, Nicholas Piggin wrote:
>> >> On Sun Apr 6, 2025 at 12:00 AM AEST, Guenter Roeck wrote:
>> >>> According to the XHCI specification, ERSTBA should be written in Lo=
w-High
>> >>> order=2E The Linux kernel writes the high word first=2E This result=
s in an
>> >>> initialization failure=2E
>> >>=20
>> >> This should probably be reworded, it's not so much that Linux does i=
t,
>> >> this kind of implies a Linux bug=2E It is that the hardware requires=
 it
>> >> and Linux works around such quirk=2E
>> >>=20
>> >>    According to the XHCI specification, ERSTBA should be written in =
Low-High
>> >>    order, however some controllers have a quirk that requires the lo=
w
>> >>    word to be written last=2E
>> >>=20
>> >>>=20
>> >>> The following information is found in the Linux kernel commit log=
=2E
>> >>>=20
>> >>> [Synopsys]- The host controller was design to support ERST setting
>> >>> during the RUN state=2E But since there is a limitation in controll=
er
>> >>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>> >>> It is supported when the ERSTBA is programmed in 64bit,
>> >>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>> >>>=20
>> >>> [Synopsys]- The internal initialization of event ring fetches
>> >>> the "Event Ring Segment Table Entry" based on the indication of
>> >>> ERSTBA_LO written=2E
>> >>=20
>> >> Could you include a reference to the commit in the normal form?
>> >>=20
>> >> The following information is found in the changelog for Linux kernel
>> >> commit sha ("blah")=2E
>> >>=20
>> >>>=20
>> >>> Add property to support writing the high word first=2E
>> >>>=20
>> >>> Signed-off-by: Guenter Roeck <linux@roeck-us=2Enet>
>> >>> ---
>> >>>   hw/usb/hcd-xhci=2Ec | 8 +++++++-
>> >>>   hw/usb/hcd-xhci=2Eh | 1 +
>> >>>   2 files changed, 8 insertions(+), 1 deletion(-)
>> >>>=20
>> >>> diff --git a/hw/usb/hcd-xhci=2Ec b/hw/usb/hcd-xhci=2Ec
>> >>> index 64c3a23b9b=2E=2E8c0ba569c8 100644
>> >>> --- a/hw/usb/hcd-xhci=2Ec
>> >>> +++ b/hw/usb/hcd-xhci=2Ec
>> >>> @@ -3107,10 +3107,15 @@ static void xhci_runtime_write(void *ptr, h=
waddr reg,
>> >>>           } else {
>> >>>               intr->erstba_low =3D val & 0xffffffc0;
>> >>>           }
>> >>> +        if (xhci->erstba_hi_lo) {
>> >>> +            xhci_er_reset(xhci, v);
>> >>> +        }
>> >>>           break;
>> >>>       case 0x14: /* ERSTBA high */
>> >>>           intr->erstba_high =3D val;
>> >>> -        xhci_er_reset(xhci, v);
>> >>> +        if (!xhci->erstba_hi_lo) {
>> >>> +            xhci_er_reset(xhci, v);
>> >>> +        }
>> >>>           break;
>> >>>       case 0x18: /* ERDP low */
>> >>>           if (val & ERDP_EHB) {
>> >>> @@ -3636,6 +3641,7 @@ static const Property xhci_properties[] =3D {
>> >>>       DEFINE_PROP_UINT32("p3",    XHCIState, numports_3, 4),
>> >>>       DEFINE_PROP_LINK("host",    XHCIState, hostOpaque, TYPE_DEVIC=
E,
>> >>>                        DeviceState *),
>> >>> +    DEFINE_PROP_BOOL("erstba-hi-lo", XHCIState, erstba_hi_lo, fals=
e),
>> >>>   };
>> >>>     static void xhci_class_init(ObjectClass *klass, void *data)
>> >>> diff --git a/hw/usb/hcd-xhci=2Eh b/hw/usb/hcd-xhci=2Eh
>> >>> index 9c3974f148=2E=2Ecf3f074261 100644
>> >>> --- a/hw/usb/hcd-xhci=2Eh
>> >>> +++ b/hw/usb/hcd-xhci=2Eh
>> >>> @@ -189,6 +189,7 @@ typedef struct XHCIState {
>> >>>       uint32_t numports_3;
>> >>>       uint32_t numintrs;
>> >>>       uint32_t numslots;
>> >>> +    bool erstba_hi_lo;
>> >>=20
>> >> Could you use the "quirk" prefix for the device and property name?
>> >>=20
>> >
>> >Done all, except then I noticed that you want me to prepend "quirk"
>> >and I appended it out of habit=2E So I'll need to start over :-(=2E
>>=20
>> Ping
>>=20
>> Any news? Would be nice if a fix made it into 10=2E1=2E
>>=20
>
>Sorry, I ran out of time and won't be able to look into this again
>anytime soon=2E I don't mind if someone else wants to pick it up=2E

Okay, I will look into it as soon as I find some time=2E

Bernhard

>
>Guenter

