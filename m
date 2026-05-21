Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437C7CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQAAj-0001XD-Fu; Thu, 21 May 2026 16:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gumenezes2019@gmail.com>)
 id 1wQAAb-0001UG-8P
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:39:05 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gumenezes2019@gmail.com>)
 id 1wQAAZ-0006ae-J5
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:39:05 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7cfd0d8eb09so35054527b3.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:39:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779395942; cv=none;
 d=google.com; s=arc-20240605;
 b=Ydk7zPBbcSyiSmgnPAka1LKizC5mImyR6lJfKC94xFiOHjgVhlQZi8v4VZUPnJSmd1
 sbb/39TDBoJ3nEg6jYK9BhH4wjJquhknbkt5EIC1JKzGRsTkrXqDJLOk2WfTrjUEJSdZ
 ebBCnjhX4Xa8h5zDsZRU/QxuwI5W8elU7Rs+y6/YmnSAZNrPBYmfOThOBSpEFduda7z0
 2ZP4k+4xb0Zx6FSKRte0suUmyC0X4qhogT8Eu3W26udv9b0VHLDvnlRNG74ImBKIkHz9
 C2KXMlvdXVvI2FcONjU00qkvDLrqCVnvK6P0H0vEbqtrEPcPrKzttkyacDdJruABxj6+
 RDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v+DKoTCfCC6UB3kduWaVqd1GE9NOmFLhNF6mSI5w6b0=;
 fh=axbB2bjiSokmisYx3H7DI5yUO3Z+Sykod4F4JR7lPwk=;
 b=JV9WX47yJdvgd3wLne2GS0modNVFnvUOz9hk87lEoLqyvL09GIC8RK24QXDHYDkeVL
 kdFaMk5kTwC/5BOTX2a0dD4sUBExkRZ6/On7Fsicfw6y33Y8iWOOhYH+Tt5sK8vlbL0V
 obX85LFOIGOJnsoPJxyCkvWStf2BpBqI5r3lCw+udOWJC9GgbOXKnLNip5DAmPjD5kOp
 KMiH/qcc2yl/eSy8Bxs+K0l5qjKQjNRXKeMZR5gIczowCWTFG5MaRfNiIzA44yWqSg46
 gS01t1JxCe+vXONqhN6VKsxJCWwetweijDf2y2vMTko/Qce9deDNyyihGx6VVarkys/O
 cvUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779395942; x=1780000742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v+DKoTCfCC6UB3kduWaVqd1GE9NOmFLhNF6mSI5w6b0=;
 b=dhGRbXO+pdTWAB2FxKuKIPbLOIM2fB2tpr2a3Vjv84Ro42gmENHqAA7/gE5xnkCRoE
 4VlIzuYF6V7/+ZSo5ZGTujsD7qAQ0k8JNskr9k55YdtS3sYirspG8WroVcNskcwoTOoz
 KeuUHhK/SziHJoXpQOwJVl4yBH1PZTNPhbHqCze8Hh2tli1dSYH3d8Fro3560HPyPIwD
 nlvSRG4rfGYlAltfPXBOWlRDEgEeZfyRXCRye2MsfsugA3TGT0UPDDUlrmgGnfrQD3bN
 nh/iyR5YHb7SHQWHmYRIl3GNd2MzF+WctwPI5EiAYpVOScL1xeExbuuAWbA1b9W50Ywf
 1qwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779395942; x=1780000742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+DKoTCfCC6UB3kduWaVqd1GE9NOmFLhNF6mSI5w6b0=;
 b=Dv9tSnr4x3uGSdINJ8/23/omZ5CIIBSChg4Z0pqKjMWtqdx62TSVjZGSluxSTf8uPL
 U3e9Xah22w0IhYLkZ8t5cv8UANhBfdDJSAO8QS0Ds0UhDDYuYMiBRMrB4Ezl8SyD6Fs1
 frTiAbDKQfEUBusfhuwbFmHyj9hMAJTKbuPDabrX7R5ByOtllwBbAczXkDSMFgpnoMjq
 e8+bEcvwwlk5fT6rpn+WLWoXryaAxIcJTrdy9sZrL+KzBdY/nsLAHjGtJvJh5COm9jxk
 rYmgXY4PxjTpfxHOyjZmqV7zXUrxQWBGzT/lpdNl5bzu0wwQBDXa6xj4TdwGegVFE0+t
 KoFw==
X-Gm-Message-State: AOJu0Yz5mx58TG+Yx+6m99pjkEWv3QkVCfFhJUZvNiGxWPaijn3PzQo9
 i46dzIJcNvqTW6AbwBu4SvhjmszsNoDC345QeLJ7MdsFcTS3pZrgjLGla5cF52/Y8XA973e2XEh
 C6+sD0T9Ah5v8Mo5ORMGK9rG5J1xEXrQ=
X-Gm-Gg: Acq92OHiG4seC+//7osXVSjH9Ri3SfrC6ZCpeKexCeyfcuoRDbZueN2oaszrh2E0BKb
 rvUr5O+uF5cn3K38BVAMd/iivR8qvUE6A0rgLmrAZ3m3o8Rgs8PXmXzGL/1F9hYThoHOMxXHaKE
 sBlMGZCF1j1cBFGxLGdUd8Jmt7nSCs0JRdzZ8PlNE8a6kty+PXPnCWEkMKbKdZFqj3LY5GmnTn5
 uoEjUmZ0wNccDnJezrTAzkY71JLBeiHnM8UyZpLOlbybSntiJo5nVvrW/UmGupjm9m1Z14ojpXe
 aOewuHkTtzb42GSknaocq3TSNx1VlYqrFtvtxX4FKXYg0jeTyjSrOAxinWUS1pgTzdGQFqcYI8L
 1ARbKfw==
X-Received: by 2002:a05:690c:d0b:b0:7c0:56f:5b59 with SMTP id
 00721157ae682-7d338490957mr11394957b3.15.1779395942481; Thu, 21 May 2026
 13:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+YAEjo9BdN6RuRbg=bfVqke4kf24my21Jk3P4aJDzR8A5yqyw@mail.gmail.com>
 <87h5o0mrr2.fsf@draig.linaro.org>
In-Reply-To: <87h5o0mrr2.fsf@draig.linaro.org>
From: gustavo menezes <gumenezes2019@gmail.com>
Date: Thu, 21 May 2026 17:38:49 -0300
X-Gm-Features: AVHnY4LRgOAgeQjANcCWPGYWIKXLa1Yj0q52JfK8t17QFIx4kXFsCrw1k4QUIy8
Message-ID: <CA+YAEjoXsRp71ucEmreK+ExPjWhK6iEw6BrGzVkk1e5b45fc9Q@mail.gmail.com>
Subject: Re: [RFC] Add initial Qualcomm MSM7201A platform emulation
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000110513065259e760"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=gumenezes2019@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000110513065259e760
Content-Type: text/plain; charset="UTF-8"

Thank you for the detailed feedback.

My initial goal is intentionally much smaller than full smartphone
emulation. I mainly want to establish a minimal MSM7K machine model
capable of early Linux/Android boot and serial console output.

I agree that a complete emulation of commercial devices would require
significant long-term work, especially for multimedia and modem-related
hardware.

Regarding experience:

   -

   I have been studying QEMU internals and ARM board models
   -

   I have experience with low-level firmware/kernel analysis
   -

   I have also been working with vendor kernel sources and older Android
   boot chains

For the initial devices:

   -

   ARM1136 support already existing in QEMU simplifies the CPU side
   -

   Some peripherals appear to be Qualcomm-specific rather than standard
   ARM PrimeCell IP blocks, although I am still verifying this through
   downstream kernel sources and available documentation

My current plan is roughly:

   1.

   Minimal machine definition
   2.

   UART support
   3.

   Interrupt/timer implementation
   4.

   NAND boot path
   5.

   Linux kernel boot to serial console

I also appreciate the comments regarding:

   -

   record/replay compatibility
   -

   maintainability expectations
   -

   testing and documentation
   -

   avoiding legacy API patterns

I intend to keep the implementation incremental and localized as much
as possible.

Thanks again for the guidance and references.

--000000000000110513065259e760
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Thank you for the detailed feedback.</p><p>My initial g=
oal is intentionally much smaller than full smartphone<br>emulation. I main=
ly want to establish a minimal MSM7K machine model<br>capable of early Linu=
x/Android boot and serial console output.</p><p>I agree that a complete emu=
lation of commercial devices would require<br>significant long-term work, e=
specially for multimedia and modem-related<br>hardware.</p><p>Regarding exp=
erience:</p><ul><li><p>I have been studying QEMU internals and ARM board mo=
dels</p></li><li><p>I have experience with low-level firmware/kernel analys=
is</p></li><li><p>I have also been working with vendor kernel sources and o=
lder Android<br>boot chains</p></li></ul><p>For the initial devices:</p><ul=
><li><p>ARM1136 support already existing in QEMU simplifies the CPU side</p=
></li><li><p>Some peripherals appear to be Qualcomm-specific rather than st=
andard<br>ARM PrimeCell IP blocks, although I am still verifying this throu=
gh<br>downstream kernel sources and available documentation</p></li></ul><p=
>My current plan is roughly:</p><ol><li><p>Minimal machine definition</p></=
li><li><p>UART support</p></li><li><p>Interrupt/timer implementation</p></l=
i><li><p>NAND boot path</p></li><li><p>Linux kernel boot to serial console<=
/p></li></ol><p>I also appreciate the comments regarding:</p><ul><li><p>rec=
ord/replay compatibility</p></li><li><p>maintainability expectations</p></l=
i><li><p>testing and documentation</p></li><li><p>avoiding legacy API patte=
rns</p></li></ul><p>I intend to keep the implementation incremental and loc=
alized as much<br>as possible.</p><p>Thanks again for the guidance and refe=
rences.</p></div>

--000000000000110513065259e760--

