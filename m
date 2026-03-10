Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A30EB104C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuxk-0003A5-TP; Tue, 10 Mar 2026 07:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzuxg-00039p-Bq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:09:16 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzuxe-00075D-Qq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:09:16 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-7986e0553bdso120730487b3.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 04:09:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140953; cv=none;
 d=google.com; s=arc-20240605;
 b=DZ30YyHiuRS+1gOZEV76KB9buZu6Ju3P8I03j9GlBh3TA1afhhNm5cnwHlC9ctjvdi
 bcI8akPOd34ydDCKaNA+bgT20hAs/6iS1as1nCnkSjXhyz1Vt9oq7g7GrVbNgcz4DrYm
 8iSX/uwUe64JhaeEGrv1NfFePH2KAW2yV7v2DqvIB03jRyNhKfVFz56V/BtnRN+PBqeq
 AvLm+f6B2qjGr282ituJ6N/5wZRfco/JxR0w3/UnSlHSi3xuS7KpLZ2nfTriXSiytkRl
 SzuveNWd78R5ORqUe4RK5n1MfhRoZ3SSp565vESkGpo8QIlwWBUUwDeZsM09zLt1cRjg
 znXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QeHMrrZQbv9Kl674B/2IkIFKFOKWXdufTHQnPsSMhHQ=;
 fh=eBBtyqeStQYBiDk8btsm0TVmtNrTJlGySL6vEVi98R4=;
 b=jirFFu0lBXOd5wuvaWEy8pAkTeMzg+9FSSc3eWqnPNqe/N6BPptWDySnSnkIfEC/8E
 e58jrnVIoAP+M3/wtTtdXKCr2g1cID+V/xM7Se/+6e3fJsDTaCeMq2pMXUZ56ELXN7pP
 jvwX6tBmpVoMhjy7IMtZ5Cq2TP3MCWlQjAsxiMePpL9d1wG1aWmAQ2F2/lK4RXN6cKsA
 K572DV8POPrDFWifs9HqLRRom1eK611CGRR5bmHlBtKbTp1hu+jGCqNw/uLND+Hu9mRl
 Q0S0MMcEWIc2JhOLcS/M38VFVLB+0Ai5Pf2EgugF9b+11Ch0rRxaBLbQWVOxg7+nlEjl
 9E3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773140953; x=1773745753; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QeHMrrZQbv9Kl674B/2IkIFKFOKWXdufTHQnPsSMhHQ=;
 b=uqd3/9dOoTFUbSpAe61C2XKMjKX1KtGKqwNKZ5GCjisWKGHAwPsXoBmdZcQqMsPVMZ
 33VOlWgK7vusYn7t66tRoRsGL1mgzuTIg38mEEWsTs8HTeTgXJs+4WYGL/hVi5crRdBG
 h+LvytFAUdVG75rxByDeuN0E3wVKK9wvbUkMuQf74uswDESzK9+UGov0i88ii7igCuyQ
 7aSK+mY54zjrSp/GyutHr0ufAPHjQA/vDTIL7zf9kPS5Kq3j8b5tt8HMHeWKvzBaHwGG
 aZcJ534wfMnWkcuzormYNPDxDeDw5gX8bD37lVEz3Sq80BnAQUXLdmv7S0XwZKqCSgBc
 y+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773140953; x=1773745753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QeHMrrZQbv9Kl674B/2IkIFKFOKWXdufTHQnPsSMhHQ=;
 b=SdGQ2B2osNcfYseGtrlC9I1iilhY9A1tqfEu+tD5yYucooURwn5hFUC+c9RODQh6Rv
 DNEhv2Bdz5kJkMi1k6OYyGFkzwa5NmZitTYnimI3yH4DPItQYifRTN8f+96CQWDqcADs
 VtlN8Sw+LhAhmx2RPkdghAxUiGSQaNBqeBVDeT2GfkvE0XbCo+4W8xfw3UIBc5i+DkKL
 DOByf7JHOGfn5XY/Qu7mQYGW4OOWa8uIS/8NCA2d3VaGdK0pI9wEzodxAnNzX74nPW9J
 FoJgUtjG+MNoqgJdkgq9Ve4EzplBzRNu7rIJ6/y2bgiQU4OIG4z2R8j17ijo5Me76r6u
 /0kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWQsVPJiPqcmV9XHnR5LYFORd7HVdd7NjXZe5PrC3Ryv4Fwoa+G34bzrJ2i9FV9e2GowaFMEB01yY4@nongnu.org
X-Gm-Message-State: AOJu0YwDaVu0B4rKsMYnqQc8KrSgKtQtEX0/naak8HaBbRonSCqsky27
 FR0CSbEqODVeyZzoyy83REWe+qUkjEU1j1zplvUL13dh5YrgDMFE4NcOZLOHIQrbb2QTNDcIgRU
 yxXFkxWh5XTHpE4gB+AMTB3dAroSnisMa5B8ZJxMvVw==
X-Gm-Gg: ATEYQzyAmj3OO6fxk4GN231y0vGDk5M46lijS6tz1ru3h2iYBFFRMwuTb3jlWiyhP2h
 TILG9/7dFRfhZYNEBCwPidk9MRVx/EDYd1BlSzBSjpFHCSGg1JjloLSweWW8tBrOcqH5ZSaDEL9
 KRYCXdzaCnlh2ltv2kajIBvmYU+VKTRjy1+kghicfQP1WwOQNmeLXmOLE2AiQsf0gVFUuR0Fu5g
 +kqpYoiYKaFEicM1lzI2Xr0ZyXbhmFiPWfIUC8D2Qm5yVGCXk56KKKGXIAW/dGno8/1JOHhMUTp
 y9YBpnun9+Pe2PwTByV2NRxqM/bb1ARQFO25NPw0t2Tri4BcrErjXmLTHK8UDYgfpZQ=
X-Received: by 2002:a05:690c:660a:b0:799:266:83d2 with SMTP id
 00721157ae682-79902668a63mr46942127b3.40.1773140953461; Tue, 10 Mar 2026
 04:09:13 -0700 (PDT)
MIME-Version: 1.0
References: <aNLIHOwcGB47qbUY@redhat.com>
 <20250924093138.559872-1-alessandro@0x65c.net>
 <20250924093138.559872-2-alessandro@0x65c.net> <aNO7J7Y6wsk1-wyw@redhat.com>
 <CAFEAcA9oKbFi7hBvKcz_v_xWtHaPz4n3Q_cVEai1F1kZnr5PiA@mail.gmail.com>
 <87a4wgc5gh.fsf@pond.sub.org>
In-Reply-To: <87a4wgc5gh.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 11:09:01 +0000
X-Gm-Features: AaiRm53bxMYXqj2pqYRhj1Kfsqulmw-zNM4rQONZ4FkRG5kf9Y7zBjoR_EvCyjU
Message-ID: <CAFEAcA85zD1d=4xkXKFyefYjsj14DqpBDXrPbtfSfa0ry8raKw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: improve virtqueue mapping error messages
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alessandro Ratti <alessandro@0x65c.net>, alessandro.ratti@gmail.com,
 alex.bennee@linaro.org, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 10 Mar 2026 at 11:03, Markus Armbruster <armbru@redhat.com> wrote:
> Neither function is ideal.  But in their current state, I *strongly*
> prefer qdev_get_human_name(), because I hate having to decipher a QOM
> path less than having to guess what kind of device this might be, then
> figure out what format its .get_dev_path() uses.
>
> If someone posts a patch to fix the shortcomings of
> qdev_get_printable_name() I outlined above, we can talk.

How do you feel about the proposed unification of the two
functions done in this patch?

https://lore.kernel.org/qemu-devel/20260308160040.354186-2-alessandro@0x65c.net/

thanks
-- PMM

