Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E22CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh12F-0004w6-20; Tue, 07 Jul 2026 04:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh12D-0004vn-Pt
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:20:05 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wh12C-0007fR-2B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:20:05 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66766d649fdso3061280d50.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783412402; cv=none;
 d=google.com; s=arc-20260327;
 b=BdnaNU/rs9mFZ8AV/iITAH7L+Ygv5MJuudQbCSvEfApL2jcbm76UZZW08d0uYWLzYU
 ynadh/ow8bFv1G1z6t+tK5+frDVIaTozcTvKWrPyZRz9Va98brkD1ct2GKzYNftKXWVK
 VF+InC4Li16D9pOCORJBkVRZKg6vVn8K006BSKPPrTBKgQzvjXMbz9Mn3Wxfv5cv0KOC
 GnL6SBlUEG+cAmSGx4F3Flob7JgDENpM/iymrQy2U6Tj0p0M3vyLnCfe6y4XNvjiB5tm
 VSguT4Q+rv8T2GzfuX6nKPn1dLM/TJccGTsV6P2N4tH2s4Z2X1d+OOaO67X+uKn+NxeI
 2slQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6s+ViQ7C6cdtI+3yrPoDRiHtXxuyrUpD4TQFZaKFH6M=;
 fh=mSDP7p7zFstMP/AEYTNOxCefZ/0Qk1KcNsfH7SPZhCI=;
 b=U4YFQzkLIy2RKHEAkm/6geuVj9+nhhvBkzCI5WbyGLjYMV+P+G3kz9f9lc8mIvWqIm
 ulC8+4IVzOqhPxLRDjqhe9YhAGs804QMtDevnoc9EcTYZCWrTuwvD5VeWjFww0Bhd4Kg
 g8B45eEJGRZkrwPd+e0AGOaR654GjUWq6wpgLAVlrsYmsD5fIXpGGq5SpeiFFtNFWTxb
 AsWy6bn1Mukpa7g7GNKyTr8CXuc3OomlVMX0rEK6hlIHE1v+ej8Ma5Zeix0RtpkOvaXa
 jGicsWus4L9mNXENQ93U0egh6mnRAFREoDB0nuoVOURgeqIbvK9cxr96mHWui9Od13X8
 giWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783412402; x=1784017202; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6s+ViQ7C6cdtI+3yrPoDRiHtXxuyrUpD4TQFZaKFH6M=;
 b=a4AgFQre5YyRZV+E/PL5btCNr/b/uzcFhwmKs2hKnNyxNURYU9B8/9wwTSKhSGrVnR
 ieVZAEZtZ60M2wbqsf/QDvjJS5JV9dUpmB4vl1efitUs9vw9fLKWF6LuNHtPoRAmD39v
 6xoeCrp4RBuQDeMEZ9BUtgrsTXaVKalM/W4HY0jHxFZrZNU1QvRBrtvgIcs8zZ/apwtP
 zVcIFz9EtkZadTtR9nw/BLSpKnI40pQ+hrUDY6sN9v0B0qPqMmbh9+3nyDsVkCa8ZzHK
 oPOqd+beFk1hCS70n5sSgCzVmYB6relyD3B4p7BojvvOM0/Q2G27fLzNVkZ5ZcUukWgi
 nzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783412402; x=1784017202;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6s+ViQ7C6cdtI+3yrPoDRiHtXxuyrUpD4TQFZaKFH6M=;
 b=rlmwH0u89M0XG7Ojz1B4aiU66EHFrWGeDNUl2Lz+CbOcV5uVXq3zp8SjHP2DuaEcrW
 cXmXleetrJIvfv4jZurQAICZU80i3GgFY2ehqjZ+Yn1heI6UiPaRLtGY8bbslXzwt/Vc
 hfuUSESzzfXwHv4NXW8YB8CS35zNGnCH+/W2JcWPqILF5of1R57lv8lCG7WVU91nscRT
 6HCkVLRhhfAlSET7dUGVk7L9fLSgTGPteemlS6A4yeS2kOoOIqCGGQJCDFLjR1n25phK
 69utRrmpvNPLA4NZ/Rh0r1WLodQx8Hl9DhU0YK/I/pontBkQf/iEUIrZ2nzswj5M3og3
 nFOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYfeOQ7o2TKiGTUJ1jL08Q8+H0kqfwtXB9Sdaj9Xtj18I93Z7oDWbNtq5gHNnSlbj1MqVfXOjK4LW+@nongnu.org
X-Gm-Message-State: AOJu0Yx3ARc4QfmrbKNoT684MN3LLlb3rW6X1yKcfPhU83CzWhzxUYZ3
 bzCLq69D7/QnVAWyJg7gpY85hRUMWAvi0TxHExW93xajVMnhhegsuPClS9ws3+ZiJnUuheO+omv
 pLus5SlEWBNnhv7yJSTgnENkEwN/AOuQnsYQ66MbUjA==
X-Gm-Gg: AfdE7cnhgxY1ED2zojWFDaubttNvVY15bN5o+IeYCbQlxfjm3u6ZCOFOKoAPiiklREE
 FPPzekmYZVeTMVzFecb1qqnlV2Rs+BvdrwrdakaG1ZLN+aBIyzY6XbDrS91lS/Ab6iyW+77DQ/y
 7bQ1/Leeg96Yc6XnpMy7SYKXcgQGF8TKxqXUaN0XtEFQaSHmn43sz4xcptYeF2GUwOy4Tyw/cUP
 ub6nvwLybfcodnTQgIc1hxB64cFOEMQ804v8RThbVrQZuLLZxcfviO8pFPSdoVW4eK++1/5oq8c
 ll5CDWlDvC2ft1N+3ITB+/kGjwBLny5X5aWKcoPIgNN/qyRLwEdCiTwr
X-Received: by 2002:a05:690e:191b:b0:664:c7b0:f64f with SMTP id
 956f58d0204a3-6677fd49591mr3268548d50.58.1783412402466; Tue, 07 Jul 2026
 01:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260309181452.83702-1-thuth@redhat.com>
 <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
 <124bd918-f2ab-43e2-bd2d-fc824de62c40@tls.msk.ru>
 <fcbe3d7f-64d4-4b13-b930-a81e77db4784@ilande.co.uk>
 <df7a091c-a8a1-416a-acf3-28a0cbd8dd2f@redhat.com>
 <c7d6b801-449e-4f55-9c1d-ebec7a0e9595@redhat.com>
 <c0cd50bd-e054-48b6-af54-1050e13bb720@ilande.co.uk>
 <baf0b727-d53c-4717-b4e8-9c8603b2fa75@oss.qualcomm.com>
 <CAFEAcA_oFFEyRfXjRZR7+nLOE5fgzDi1kHQop=s1Q4EzYvaVxg@mail.gmail.com>
 <1aa71446-d211-46d6-b4eb-7bc0fea36de1@oss.qualcomm.com>
In-Reply-To: <1aa71446-d211-46d6-b4eb-7bc0fea36de1@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2026 09:19:47 +0100
X-Gm-Features: AVVi8CfCHkhIJNMphVa_Kcjqq_ugsDcSDitULfU1lYHiSwySy73bZ-uGYg_tQdw
Message-ID: <CAFEAcA9qKE_kg8qubyCumJ14D917RWXJULRW_SnBwnNh2qcZuw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, 
 qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 6 Jul 2026 at 21:27, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 6/7/26 19:53, Peter Maydell wrote:
> > On Mon, 6 Jul 2026 at 18:29, Philippe Mathieu-Daud=C3=A9
> > <philmd@oss.qualcomm.com> wrote:
> >> - Bus capacity is odd. We have a generic Bus-class @max_dev field but
> >>     do not use it with PCI variants. If set, it limit the instances
> >>     capacity. The capacity is tracked in the instance state, and when
> >>     no @max_dev is set the only way to mark a bus full is using the
> >>     qbus_mark_full() helper. Then if we remove devices, the bus remain=
s
> >>     full, and there is no helper to restore available slots.
> >
> > The qbus_mark_full() function is intended for the use case where
> > a machine has a bus which in real hardware is entirely internal,
> > so you have something like an I2C bus which has some on-board
> > I2C devices connected to it, but there's no external socket
> > that the user could add more to the bus for. The idea is that
> > the machine model creates all the devices for this bus, then
> > marks it as full. The devices never get removed from the bus,
> > because they're hardwired in, not user-unpluggable.
>
> Are you saying, while this happens to work correctly for the
> Ultrasparc Sabre PCI host bridge, this is not the appropriate
> API to use? I understand the I2C example when the lines are
> populated within a board but can't be accessed outside of it
> (like our CLI -devices), but what about this Sabre case, the
> bus is internal to the chipset; can we consider it a full bus
> or should we use the BusClass::max_dev property instead?

If the bus is internal to the chipset then qbus_mark_full()
sounds fine -- the only devices that will be put on the bus
are the ones the machine itself creates, and the bus isn't
intended to be available for users to dynamically add more.

It looks from a quick grep like the only use we make of
BusClass::max_dev is that we set it to 1 for:
 - PCI controllers that have a single root complex
 - virtio transports, because you can plug exactly one
   virtio backend into a transport
Did I miss any other uses?

-- PMM

