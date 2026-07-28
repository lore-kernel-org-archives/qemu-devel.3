Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1733C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodhI-0007G9-MX; Tue, 28 Jul 2026 05:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wodhH-0007Ff-6d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:01:59 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wodhF-0007YU-H8
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 05:01:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667971437d6so4309315d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 02:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785229316; cv=none;
 d=google.com; s=arc-20260327;
 b=cfQI/qrG2/plKY7e0NySasBLJRkLLpiqCYG3/LOHnvqW/UJKjlZO7FOY48OlsUiiKg
 ICOG2WTlxtk91Z5O4/HqcNjDy4dbuhyvnJWRRFLD1MhQYOqBNIKtNG3uHH0jw++ijbvY
 aqE3m2eizqGVs3pYGRMHIM7qKdKTMU1GePvPXCMekXa0UNBk0G+R3Gt8cAHJfy1IAlUy
 1uuM20MnOauC1SOvaJmOAaRsLom24wCQYRwW+j3iTIsTDPspd/asERF6FbKxt/zK/XDu
 ZDAEXBWpqKKxfEIboY950pFpUrgULdO644x4sZuMZtH1jO1ywkhNHiafCZigwcHS/R0s
 Vpvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/O1e1QgCmvZVbsVP7BYBNHDqnpIPp2EA9lqFhqaqi/w=;
 fh=4II/KbelIFK+SHhW1nZ+hm8cDILvv9DtoWip4ODhj8c=;
 b=iFAgsqyxClJKnOX5reDLHFsGVwVERB7bNJJXLXHHapTLJNt+hN8xKASXDwBSkirErQ
 J6bExChACianhPKdVTT1JL2xZdPQaiLzs78SkkTtjskxcyrqqB9PtQXv1vYn/1+NCx5Z
 b+soCJHKxhakjTtYWk1Tji4eCpx8DFUTmpqikTWz4AAl7nJrQMjF6EVnRndBuPfKT33J
 cQGWCWPeJTi/b3jtqOHhWDXaMJ4Zh29YZnAJF36jjwxxIp+JteJ1SPGYH+wcEzLabJWe
 K9P6+nW+Ij3VqTOAcFZU2PP6raEvowdiQwlJ/NCbFqpbmk5hsJvyFv4y3nOk1vvHmuh5
 GxEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785229316; x=1785834116; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/O1e1QgCmvZVbsVP7BYBNHDqnpIPp2EA9lqFhqaqi/w=;
 b=PspjOYpSu7+Y/tnJLW6qkrqDXC9Pw7lVR1F7CXl4R9zwgIYLIK23n8CA8nS0A5Havh
 t9B8YjMbZXwdFwLo/KW4c03sugLHRI+oBkG4FRduRvVAyfrDQxSiSkW2l2MGag404EhA
 uTFY9TTIyywNtJ6QwLmA5L2O6q+6uUSulGEWCp9vzm6glYfOrV3mElwQ2ND+UBUeciAm
 GhPWZqNZPEW3SrLpJVCqm9uRN/F8S4VZv9/K2DuOvzwfNH3kTZ2SIvm2cGCSawI/d6jK
 QzoXRse/djJIh7XzstqeSNTULipn6TB/lE++O0/AOwx/C0TGAoRqQ/6XkTSgEp5/lBGK
 8VrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785229316; x=1785834116;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/O1e1QgCmvZVbsVP7BYBNHDqnpIPp2EA9lqFhqaqi/w=;
 b=j0cULtVeDmiZh3soxXaXGcLofafkOGcukd98HZt4BEs+NwPnx1W5As2y/o0+UZjBN9
 Eh7ZzqMALhPP7FNzNF60lZflZa6Wn7VQoWaqt9+K5CKTpg97IjkU8Vr7ehJLMqZ9tafS
 afYbO9tBQ/gDlMoAmBUtF/ZZkqEpBovNAsHZkoG8C1JY6JN0U/S0tDWhrWr37m9aFqCz
 rK4j9QAArKgAsN7/mN7pjoj2VMApweMFB2aoMTnwImMQ/brVJj7GLVzCdKq9OhFEeIw2
 usd9+WpvspmEy1vEjc+VvgerFHV2LPPuYbnX6kqdhoiad8fmepd99MJF9Q2/Hb8vuzbc
 6k5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwDI3iI4Oz9wKSjHVnWu6FqYwMRsKrqOyfK4InDG+oeh4VmcyX/kqz5h/2a/MSYONoMbt++qT4q9PR@nongnu.org
X-Gm-Message-State: AOJu0Yy4xqH1EllaK2uBe2VSR6clewlYjoPfvZ4IOv8fHvj/9hEuHuMv
 MkWo4XapEujUTI+1fpw3PagjmoRlEK2lgsbx1ICIhfzgiSj2idaFLujTgt7zt+AXyKFDnwi3578
 zu/dFlMyPdqIXGOR7jEfHCgU6viyK2uXBcuwwlQrK+w==
X-Gm-Gg: AR+sD13ub9vJOk/ZD+Gjkui/gKhXDuTqcWbHUdUaO0AwWqEc4olzfzoIjC1p9Urxt0t
 c/fQK/W1VehfSYpb0rArlGhAxUYigREavt8P8Ybdc1g2cM70szLd2dgMCOGO92DCUdehn3Eekke
 OTyznlpBTbL5Sw07UEjXlXoLNqvVb+Cy6QTqk0KF4wtiwrsCWo8sJM1rH9fyfB/GOQ2s29L1NmJ
 HulQlGZU1IGtt7FoBWBYWO6YeyGLzc3mOBKs9HfuBibjHzIgd7PFOH3zvDwZdb3DPQ4zmJ0sg8m
 OletmJUgvnhJDiiOPU0THpV187IfRQLq7OFuJyYsebSTQg==
X-Received: by 2002:a53:c70c:0:b0:668:111:b895 with SMTP id
 956f58d0204a3-6690580e328mr291405d50.83.1785229316193; Tue, 28 Jul 2026
 02:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260727032649.145381-1-gshan@redhat.com>
 <20260727032649.145381-3-gshan@redhat.com>
 <CAFEAcA9_tDRAd97z4UtNhFPK+fMbq37LJhWTSmD5cueo61hvvg@mail.gmail.com>
 <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
In-Reply-To: <0a384d67-fc56-4a21-9d0e-25f218a45228@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 10:01:43 +0100
X-Gm-Features: AUfX_mzZaSlhFOGmRL7hAVNwbkrAj7yyDQ20dte6sSEpFsYt_seZpNpIhuS5X60
Message-ID: <CAFEAcA9HbTSj9cJfv8o=jYSuPhScr-RVKWCos4kpUJ+T1S6g5Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] system/memory: Use qemu_ram_move() for directly
 accessible regions
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com, 
 mst@redhat.com, philmd@oss.qualcomm.com, richard.henderson@linaro.org, 
 alex@shazbot.org, berrange@redhat.com, philmd@mailo.com, david@kernel.org, 
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com, 
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Tue, 28 Jul 2026 at 04:01, Gavin Shan <gshan@redhat.com> wrote:
>
> On 7/27/26 10:51 PM, Peter Maydell wrote:

> >> +void qemu_ram_move(void *dst, const void *src, size_t n)
> >> +{
> >> +    uintptr_t test, len;
> >> +
> >> +    if (src == dst || n == 0) {
> >
> > I think we should not bother testing for src == dst. It's
> > vanishingly unlikely to actually happen, and if it does
> > happen then the code will work fine, and it's probably better
> > to actually do the access in that case than to skip it.
> >
>
> We can drop the check of (src == dst), but it will introduce inconsistent
> behaviors. For example, qemu_ram_move(0x1, 0x1, 0x2) is finally turned to
> memmove(0x1, 0x1,0x2) where no memory movement happens in glibc::memmove(),
> but qemu_ram_move(0x0, 0x0, 0x2) is turned to qatomic_set((uint16_t *)dst,
> qatomic_read((uint16_t *)src)) where we do have memory movement happening.
> So I would like to keep the check of (src == dst) in order for the consistent
> behaviors.

Well, it depends on which kind of consistency you want.
If we do the src == dst check, then we have the inconsistency
that a small aligned access always happens exactly once,
*unless* it happens that src == dst, in which case it doesn't
happen even though the caller asked for it.

You can see this in the documentation comment I suggested above:
if you don't check 'src == dst' then you can document it as
"memmove, plus for a small access where src and dst are naturally
aligned we guarantee it to happen exactly once atomically".
If you do check src == dst then it gets more complicated,
because you have to say "memmove, plus for a small access
where src and dest are naturally aligned *and* src != dst then ...".

I think that because it's the small sized accesses where we
know that it might be necessary to really actually do the
access, that we should do that also for src == dst.

> >> +    test = (uintptr_t)src | (uintptr_t)dst | n;
> >> +    len = test & -test;
> >
> > What is this doing? I am not a fan of clever bit twiddling
> > that isn't commented to explain itself. Readers of the code
> > shouldn't have to go off and search for an explanation of what
> > is going on.
> >
>
> The following comments will be added for (v5).
>
>      /*
>       * Maximal length of aligned access that are determined by @src,
>       * @dst and @n
>       */

What I mean is more that it ought to say why "x & -x"
achieves that goal.

-- PMM

