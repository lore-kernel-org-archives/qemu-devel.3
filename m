Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28339C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmqwN-0006Fp-NY; Thu, 23 Jul 2026 06:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmqwF-0006FO-6R
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:46:09 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmqwD-0000eX-Fm
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:46:02 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8143daf89c7so4244617b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 03:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784803560; cv=none;
 d=google.com; s=arc-20260327;
 b=N3ZXH6UNfxvr8FUrwH5BuIi5L4m7CidQn3L77LKSEUhDKEKGdA5nTqks5SOHcZ1iJI
 4tjjdfH4r+x/UkdPyhTK/7NRyEEMzVfLgeTcXf1yhSxOvZF752kg5m5B6ichJXOs8Lpy
 K2DHBkMME2Vo+MW5pFasVjWENgFVW82TqleRJhqJeMuGmpJW1z+4JKUjGJyJFqDCAATK
 7P33rp0RvLb89+ElmE2+RAYNyMtctbs0j34irR50sAb5KTIx+Xl0EeMDbPVU2o7HiABL
 wiMuWqGPqbBFga9XRoO8Pg5sZA0QB3JG81k1qKqpANj6B3qkQvQDr6DYOevNa7rT1qjY
 Tomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
 fh=x33KSjkiXcsQnLBFtzy0xqZIJArx/YcKIc6eJF9SrJk=;
 b=BBtYVPQ2iDO3l2NfxPa19y1Qzc9WIZKpquyziR4vNaPgqNw8EzwSZ7bUcWhNhliBwr
 kqgk3CqVUkROnzF7/II5Ozy08jdYnotvYdiG7EMNdAhiamIRCMr0X5puieZ9A/t/ftVy
 z6GtbCvGE+qBM2qGesgSUD5lzlMksB2UI6Pw5OzE3y+JBZkcwQrr0znKphYrhjyYRa+p
 NWmNvMySeny0DzPmyhgc6MG13eJqKQdatgA0ZCQ1596MGzKufK7d5uFPziIZrdENSIt/
 qbbek9iTqPGjkwctSgZNkDl7uS6n5CedaeZR0zDOr70+Ns0FbmLkzrpgAcykhlXFTV9D
 ekPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784803560; x=1785408360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
 b=KFA13zqWfQgo5B588L2Szqu06EF2+zCPlIDAk5YJxsZZGcRjiVE+oPNTM66alvznS/
 8+qvHdAMW0i33ZZKSXTIDImOqYW/hjAB/U2zD33Zvya69DrvbtyLcnsRwilJ4xJ1ayUC
 iZMyxsJiSmSMX1bNYfLqO0gesE7blh2Cq0VjaYMzJA8y5oTOYGT9c+WSY1c1uens/tns
 tSxJMZziUzGCOOXnDXqrljtyFuHvQVoxTn/yRaUj/CApImA3bA8gsQC9b7TKNA0MLTl6
 AA+CtOQ1EFYntyLG3MOP0BY4bJ6QxWr0iBIA5jBC6d6ORK8ORp5XUfJxUztXhz9CW8p8
 VMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784803560; x=1785408360;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fKQIqvFI+qnPLn66kWfRVJq/EdEMbY7GUmyED5BG8ZI=;
 b=ATC4KwM2c+ZPZ/o44inQpfFvdZX/XKO1nsHXKv9HWJ6PqSrTXu6/HQLVQ48nMP9VUJ
 mhGEQ7/sKKuUlEm3DWxZmQhL6+OHRu5dHyQURnaLh+lsXAhLmWWZdApUt3DPCsZqNxhF
 lG/2Op+Gyo88+7Ybj/cXUAbi+notbOExBkusy3ioplWXGLWQekaxnArgRfiOP9jwZAfs
 0Ln1eIIGH2HaMY/kPBRZef8g40beGzupoM9Nh1ASg1gA+8S9YfY2WeUKo/UUm5zzZ+W6
 oJaXMdkEGcjKbJZHe7JvQW3sbnIhvXYl8Ah/7EUkhLWcz99cZ8jQmhlAE1KtivxFp47q
 6+ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVcsMD3HKr6/nI71pxtlU1cayDNBThQ/QGySU/JoOZno7B55em+ecFv2uMtDF2rsAv88MQTDlXePIM@nongnu.org
X-Gm-Message-State: AOJu0Yy0DrjLb9JdttAtqe5mTpXdtIYp8r+cIZ76UKmmiHaKeVgkTNfU
 TCw/hNqa1kGiwPOHzpNXQn+O3AsW9JanW9TWW1d3i3/f1kZUMI7vaD8kAaScJ9UmzkamC2jAZkJ
 oa2xM3zCC3Aka7utcZbZkgdJyms8+eMGflBdZ9utp3w==
X-Gm-Gg: AR+sD12bLzyfoAv6UIv7JVYYixBTd4U7O3HuUf47oQlQQz2XUjFsX07Ic+TMbvNTObK
 KptO/LqkPi6IGOwHoxOGrCp+HaZtpA5U+xWmaTicLEpEOjPom7i7VRHGS99qoakuJpzsGmHv0Pg
 XJfsz1h1POethYiyWk5Mnzt6ovWd/xcyssnUlVmhJd7nu/NwnhQnVh1t+8GOhtVFF23IiY+Ju2c
 6TV6zQ1v4B1Il5idmcRI1mnKbFl2vJEC76TAMzjlvLWXkuKk7n0j0TpFCj6fcT7k/330Auw/KUH
 JkidwNUlt5ubovhD5Lp8OfsB2HHz42s8bN1hvsBu6vDOug==
X-Received: by 2002:a05:690c:9986:b0:81e:2b86:d75a with SMTP id
 00721157ae682-81f4c2fd99emr7042797b3.55.1784803559620; Thu, 23 Jul 2026
 03:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260521145451.1831984-1-marcandre.lureau@redhat.com>
 <e7d3e9dc-be97-40f3-b426-3e93a242410a@oss.qualcomm.com>
 <87mrvightj.fsf@pond.sub.org>
In-Reply-To: <87mrvightj.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2026 11:45:47 +0100
X-Gm-Features: AUfX_my1yVwqDYBFri7PHqiSbZZksCRSQ7Qda_pMQK4AnsOEZwerOgkNdV0ZEE4
Message-ID: <CAFEAcA-Upx9uacBZ8nq3Co5csNqi-nHaTOVX7t9kUzDW-CL5Bg@mail.gmail.com>
Subject: Re: [PATCH] target/i386/sev: fix MemoryRegion reference leaks in
 gpa2hva callers
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "open list:X86 KVM CPUs" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 23 Jul 2026 at 10:46, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:
>
> > Hi,
> >
> > On 21/5/26 16:54, marcandre.lureau@redhat.com wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> gpa2hva() returns a referenced MemoryRegion via its p_mr out-parameter
> >> (inherited from memory_region_find()), but both SEV callers were faili=
ng
> >> to release it.
> >
> > Comment orthogonal to your fix; odd to have a non-monitor code
> > call an undocumented monitor method.
>
> Which one?

The gpa2hva() function, presumably. It does seem a bit odd to
have the target/i386 code directly calling this. The function
in monitor.c works on the system memory AddressSpace and
assumes that there is only one kind of "guest physical address",
because that's the implicit "everything is an old i386 PC"
kind of assumption that got backed into the human monitor
command. But it's not really something we should be doing
more widely.

The i386/sev code looks rather odd to me. It seems to be
using gpa2hva as a way to get at the host memory that is
backing the guest memory. Why can't it use the usual
address_space_map() etc APIs for this? Worse, it looks like
it keeps that host pointer around in a SevLaunchUpdateData
struct, and it's not immediately obvious to me that it won't
go wrong if the memory map later gets moved around and that
pointer becomes invalid. And it looks like it writes into
guest memory in a way that will bypass the dirty-tracking.

thanks
-- PMM

