Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10C5E63F14
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 20:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrimt-0008AI-3e; Sun, 15 Feb 2026 15:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vrimr-00089v-2W
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 15:32:13 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1vriml-0004o6-J1
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 15:32:12 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65c0891f4e9so557099a12.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 12:32:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771187525; cv=none;
 d=google.com; s=arc-20240605;
 b=bwg/Vc/ujzI8O5+ZzSa2cPybvdlPyq6ysIfXhlZP2q5KSkdyDyEfy/XVTt3RvL60p4
 KxXZivYT4y0WXRdkvpce2Mm48Ik965TI9ylPF/pcWeW4RLtoy4s6xbhjwAja3bJn2zQB
 2liaHZE/a1f6mXFhS/cd+P5cmnBED8So2Nou75HPGnnmfGWIBEtL1g/YskRGflGJp6M+
 j13dy9sItWI5ccjwlESu8wKt14KQ9ZW5O9y7b3WAK8kyiqOeE6Qit+nCwl9HkbNyTemn
 i+thUAyCuYCQxq8/ilN4eC0MSJ90vp0GQ4HwK0E+ToBUTR0tc1TT5LYkYnsNn0z6Zu8T
 7Nvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XABNvLoXDQWxQvSm8H8jBA4yYZd6zYBc56Cmgo7N9AY=;
 fh=fa9r3k2RM1BPu//GuZC/xhfPX6IkvWffHptETS5k24I=;
 b=OM3lw1IV9tuJdqq1JAlPAl5rG6AXi5FXwU0TVvEJ7aSmrpoMsGkFM98hZwIqFtt8Zg
 yzyFH/C9HBqFba0HfhOiDHH95ExLDtgJqSKGFJMiDcoIH6lS8ESAfRx9Ih4cvFuzJrn/
 peP6jrhLvLoHvB0Y5beCnSIc+M1GqxgEa4ARIn+uMFoemZ5Ddjoe+QHISzsDe5d6wh7z
 AR0FLy/B07qAR1V8CLKUK/nra4Cw6qtab2Y4WqseGOH30u3NARbn9tu/HSTQYGlAa5RA
 cFYvhZpu0SEVMgozzkHeyyz/3ZUfOm77OaDa9A3yhPELLfk4CteQlyr63ml3ETh94y2C
 DhTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771187525; x=1771792325; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XABNvLoXDQWxQvSm8H8jBA4yYZd6zYBc56Cmgo7N9AY=;
 b=cNXXEFUOvQ0TLybghIL5GB9Hfq6EPq0h4mBHr1pj7edxuKYd2lC6qaNneXV3tJPggR
 I4RfN6cfKI5rrX9EnenEPnoE//taPBXimBeqxDBsK2qCDok6kP/DIzCYxn4/A1dW0Ngw
 hAEl7vFrBnTMgT5UzI2MlHJyhmyWV5DJp+21lcvpq0aws49RgjusPqRWhJowo0pDaaGh
 0hiFo5n8BK624AlKJUET4l83Qv3zfUehJlXJGn5vit3uQkJ/u46MpZHC5bWDE99NFGEb
 LjoQYi8kDNVwoj+XuQ5EtQirhvO3wk+5fRpw35O3AKLNDDY5L5aUtIrAE3KCgl+a1LIj
 pq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771187525; x=1771792325;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XABNvLoXDQWxQvSm8H8jBA4yYZd6zYBc56Cmgo7N9AY=;
 b=PZpT+dRTZgs2k7ys2OPgFQjCU5VoNg6ng3AROfXLzV6+MfNV+w2nIgNk0wUkx4fFX0
 OMj9ZQEi4EA8SroqYYSTwLIbZGIsXc5rSjGK4hI3tWG0DOCJkU12y00wYBBH3EEA9M2P
 wsz01geaZdZf6tMSB+YYv9piqWN2O6gSfFEDBMEcRT+AlfVpCFOu+jZ99aqi1U0k5TZN
 gpmm+IOu6O7wt/lidA6asTNeJvOQh0FSUGHD4C+Sj6UBdEo7zRVLvLkBe7tody08uQs2
 7pb36GQe0Ve8ovgbKGjEN3zJZKIXaMeKh6MZCK7K1jrGR1KL3IXKHPI79BoNGirowL6H
 uUsw==
X-Gm-Message-State: AOJu0Yz1BNGCUraTl44DvBUQVND1yEW+3hOw0JyaBcZ/whhaOdS5p8fv
 TCf7LhZFYW4uNivYpZ9Mbc6X7gX23WNz6Btun5dJj69mF6Xsvf0GtoLxwZjzmeQg4svaxB1GDtG
 okEBYh0te8eipvCJqD0/Rggsy5AssO8Y=
X-Gm-Gg: AZuq6aJlyrwp5ByQYUObCbWU9EPvCSUeBkNSAYx6gKo05Ogl8A+yx9uDliHksH4IPNg
 9jGSLZtB6UhoL+mW6StuIlYXPGqaQnLnK0HM0VQbj2wDZGJvO3n5SEEuizcV6YqN/oFjvwDmAwA
 EJ6tmZE23VjFulQkUf5UR78D/4wY7bwNUXXt7Vg6daHFHcMlem9jt36+pQ6qMUF4n8PrCZsjhVa
 8Qpu57x8CW/I+Zgql3GPbp8hnwByeme5dToPdksHX2tje2AFkjdFknHIVECczUj2YFxQvd6F99z
 giAjkqTpQNSk93AB
X-Received: by 2002:a05:6402:5188:b0:65a:2903:315d with SMTP id
 4fb4d7f45d1cf-65bc7a7b702mr2760311a12.30.1771187525028; Sun, 15 Feb 2026
 12:32:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
 <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
 <CAJSP0QVbvRxZXjbfoegu+NA=0hX3N9pSeG7Stx_jpqo1Mgwd0w@mail.gmail.com>
 <93c80b9e-7eb9-45f2-bdd7-a769e2935ba1@gmx.de>
 <CAJSP0QU7TJ5Y2gAy=ipk4=7hrqejifJJ8YcDz2LsbiQbWL5Kig@mail.gmail.com>
 <5befbced-8aaa-46e2-8875-88d681854aee@gmx.de>
In-Reply-To: <5befbced-8aaa-46e2-8875-88d681854aee@gmx.de>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 15 Feb 2026 15:31:52 -0500
X-Gm-Features: AaiRm529hcdahmLgoK3UmgcviYoaROHdjNUdS2LIQmCd7bd9yr36j4maiMUqv2A
Message-ID: <CAJSP0QUwP1L5YQH=_u5AFS++iQXZFK8r9H6xkg5KAHoJa0evsw@mail.gmail.com>
Subject: Re: Call for GSoC internship project ideas
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
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

On Sun, Feb 15, 2026 at 1:25=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> Hi Stefan,
>
> On 2/10/26 19:23, Stefan Hajnoczi wrote:
> > You can still propose an idea before February 19th.
> >
> > The Linux scsi_debug driver has support for emulating a tape device,
> > so that may already be usable with QEMU but I'm not sure.
>
> It is interesting, but it is only available with Linux hosts,
> and doesn't seem to handle existing TAPE files or can be
> used to permanently store things (e.g. it handles everything in RAM).
>
> > If you have a use case for SCSI tape emulation in QEMU then it sounds
> > like something that would fit GSoC.
>
> Here is my proposal.
> I hope this is OK?

Thanks, Helge. I have added your project idea to the wiki and edited it:
https://wiki.qemu.org/Google_Summer_of_Code_2026#SCSI_TAPE_device_emulation

The intern needs to research the project idea and come up with a
design before the coding period starts. You can make this easier by
specifying more of the design so the intern has less to figure out. I
think your project description contains enough pointers so that a
motivated applicant can discuss the details with you during the GSoC
application phase.

Two pieces of information that could help focus this project:
1. Do you have any tape data files for reference that you want QEMU to
be able to access?
2. Do you have a particular guest OS in mind?

Stefan

