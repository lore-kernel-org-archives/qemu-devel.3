Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FBFC54E49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 17:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfkBj-0002zp-O3; Thu, 29 Feb 2024 12:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfkBa-0002wZ-0s
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:27:10 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfkBX-0006Pd-9T
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 12:27:08 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so1828316a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 09:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709227625; x=1709832425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BfOcnT6Atb+kovKBhJgbSnOu/CDyar9aHkDq2eCI1XI=;
 b=KK+JUzYY36qZaKaAcRMVuBqW7E0k2TMsHWmWDHLzOdPjuYZb0m06UMm4elhJekElFK
 XRTvGoVEU4pf0Z//FSmzlQSjb5+4iO9J3J/q1XehO5SMgRjAuDx7p9dwXUIBjOu+7nuF
 l0BqfUY4onN6XdigV6hxwfoZCF0XY/27U3XW3JWqg/tldUwHlZ3a5dHKIPFhHtoJpmuH
 NcFsrxbHZRc2kM+zm/LnRtv43eI5d5ZgVJmCYSL5m2gMgebpCrrwcP3tXh5/P9Z/atz0
 r3SZvG8SQ47DKdB5r3oJRx/8a6QJzdQocCtXEUH0iUp4Z/bhogyUvHmUc1zDFBSMONqD
 6lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709227625; x=1709832425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfOcnT6Atb+kovKBhJgbSnOu/CDyar9aHkDq2eCI1XI=;
 b=mJ6wR+EEuy6LXThYg5zGjz7lqKnSP3pJ85EoW6lekdVPKbl2k2QRbDiCLbTiVgzLnh
 87zVRuNes1Tg/XXU3blHC4L2PERGQdEumReXhZqNyt6T8O81+EnJ7SN6VINt8hkN/Ebo
 +qxhToE14SUr8POE60GKy6Uc/ZrIWrAC+AUCthPqY7tcdKu1cPv2qRvWI/WVYjBokN4h
 SxTqdpInCoxU+zpUINxjzZGNv/eDeDAcw+D/6lnIsoY5wC3wx2I/mj4Ye+xmOYn7Q+kw
 6VrHLoLzA9bRca0iuFn70gLcMkOfWFQGMPlY6CAAP4ltKulJrgHzFl58kQLpOMg+76nT
 DNwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA3nlt+NyNfttO5MhU4RV/Im0nU681JGTxSD1V1FJ8i89dBSKgkkHqXWA5aAypinJbqofRiHCqRiLrXu5lV3tox+fIils=
X-Gm-Message-State: AOJu0YwDVlT3ExF6SyjdCV03+Zz8LHKr8UhvlNmlHogosc2BSPryvAe1
 inDeZvKxkI2gyihXHfpugA6F5La6t0hra2PE6iKv+RzPkA3tRiT3tcC2GHOmLXc3RrSxYsAzOZ4
 cFCFE/aSNIBcc7/PX3HMhhxnkU0aLM5hi8V7NCA==
X-Google-Smtp-Source: AGHT+IFGalZbdmqOLHtKebyYs+BDQdozu21Mus9x3EnpXXreTKJ+drBbisSCIjp+0VnXYcQx28yd5c5fcGnSNKb7vTs=
X-Received: by 2002:a50:cc08:0:b0:565:2458:4f5a with SMTP id
 m8-20020a50cc08000000b0056524584f5amr1983830edi.4.1709227625643; Thu, 29 Feb
 2024 09:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20240228211149.1533426-1-svens@stackframe.org>
 <CAFEAcA-KioRCJ97dbaiSf0f5uM0=+nAb=oLbFiRg=EPGwd57sw@mail.gmail.com>
 <87r0gvxlce.fsf@t14.stackframe.org>
In-Reply-To: <87r0gvxlce.fsf@t14.stackframe.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 17:26:53 +0000
Message-ID: <CAFEAcA8tbtrtoZSO2MmLHr+7+mcys63z15qFEVYm=nAO4cUMmQ@mail.gmail.com>
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add hack to prevent scsi timeouts in
 HP-UX 10.20
To: Sven Schnelle <svens@stackframe.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, deller@gmx.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 29 Feb 2024 at 16:54, Sven Schnelle <svens@stackframe.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Wed, 28 Feb 2024 at 21:12, Sven Schnelle <svens@stackframe.org> wrote:
> >>
> >> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
> >> under certain circumstances. As the SCSI controller and CPU are not
> >> running at the same time this loop will never finish. After some
> >> time, the check loop interrupts with a unexpected device disconnect.
> >> This works, but is slow because the kernel resets the scsi controller.
> >> Instead of signaling UDC, add an option 'hpux-spin-workaround' which
> >> emulates a INTERRUPT 2 script instruction. This instruction tells the
> >> kernel that the request was fulfilled. With this change, SCSI speeds
> >> improves significantly.
> >> [..]
> > I see we already have a hacky workaround for other OSes
> > that do something similar. The ideal fix for both of these
> > I think would be for lsi_execute_script() to, instead of stopping,
> > arrange to defer executing more script instructions until
> > after the guest has had a chance to run a bit more.
> > I think setting a timer that calls lsi_resume_script() after
> > a while would have that effect.
>
> Thanks, good idea. So something like this?

Yeah, something like that I think. (You probably want to delete
the timer on reset, and you need to handle migration -- you can
either put the timer state in a new vmstate section, or else
in post-load if the state is 'LSI_WAIT_SCRIPTS' arm the timer.)

Does it work? :-)

-- PMM

