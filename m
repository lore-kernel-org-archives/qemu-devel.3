Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D3FF885C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 12:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGz4C-0007Ce-Cp; Sun, 26 Apr 2026 08:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGz47-0007CG-1b
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 08:58:28 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wGz44-0006kj-U8
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 08:58:26 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso9137705d50.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 05:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777208303; cv=none;
 d=google.com; s=arc-20240605;
 b=h+/q4M0vZ3cmPir2VK2JbMzIlIXhEyRgc4py6pydXe0MyfHa6W+y9o1wUelpcKzXyO
 ByBYFNOH79Xc9kW9LYvaIFa0GkEooN8vDpg1dBTIbBJe0cdMy3r4V40rS9l5/rDV14Qx
 GmGkqpEZBPYbVQKWU+v8Z7mQAROqtn6uRcbitmngHi2xGBRNSwDNErffb6vxR9e0tg40
 t/inagia46IYAezFhwdah4wEgttSBmyyp9SzhstaMLu8EKmAQjESVXDL3EifV6qIoi6J
 Lsk/Z69non0Iv6kjUaJZgayVETAQ7dBuaTMR38wn0I3XQHf47nO+63dqJ7DIXMsh2T6U
 wxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0UHWkSpJ/NIGgjibfTym2Ka0RKxid94udmKYvdVB17M=;
 fh=/J+bR136NyudAqreHqcNVMSk5lDml1Rpd70ZXEhiLQU=;
 b=dPjLlbLeaZRiglgZHKfLEHg2O1JI7fQAX7rdUxbN+lafL0u0gi02s5NzPC4QTvn++/
 IQplqNpkF0lVtDLOSQBwdxuR+KIYy+IRxdWw6e4PZAfGHKFOSaaesepK0WacJQlPWcsn
 SXJpG/zMK9FI+pWgwnhTrR56c3q4QcvvZ0EHgO7MN8fcTOrOIlDP6axBvDNWpip/nliQ
 Nq0EEPzOOj149Wfz3i5Eiyd9ORUrOA08sjvcgJqpxzkAErBdYAo2indY4/ZG53//qo+g
 esvE/4BLKQKa5tmQSSNJktIkIyNDkh06h8Tue6wSNTKvNQjoulOHpSAP1e0+5nyWLf2s
 NkEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777208303; x=1777813103; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0UHWkSpJ/NIGgjibfTym2Ka0RKxid94udmKYvdVB17M=;
 b=hiiC2uD6nEIhRKFrBuLkIkV2OOdIjr6Q49UOys1pILSaOjz9wTUZKm+nRnXXe72C+b
 DPZ4gzTJA2DIO2kewryxDuCIlJLbty+aJO13bl7o95GhDMe6HfAK08pU+scN5bi/cx3d
 lUJKkyR7DEZjJsN/bsPggkQuF6BznCw4pAB5SG6vfjotcX8sTWwukZLeXEMNLV/5fbbe
 +rvNhNW2LIDa0PAxirysb4ucPHTF4uYln6aG0wpdQBE71oYedYX5uc+H/XP6Gn15tARi
 bZ7EdZhop1IrOnjTmlYNtzjfMQgisSAcrh24ZXXtqsw3yajfNRw4BN1tYtoIZ+IvQYgH
 8bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777208303; x=1777813103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0UHWkSpJ/NIGgjibfTym2Ka0RKxid94udmKYvdVB17M=;
 b=c+JndpRL6mlnnExaellV9XA1A24kzBT4HGvXtzaL1Vz1G2QXERYFasDu9E2vqgd6Gv
 T4dzASUP37u0Xn3asiR8EsqYGShjLDrTGEe0LSWYOgTWo3hU4wtsdWoaYqt+A7ZShkx0
 anB8dmfiUDMr6vbl+sA2fguQkhFVjl5hOVIfbBTjI9yKH3rpSoIInvwHDafa/qI66Ow5
 7v4L+6TwDl2ok/OHsKiT83SNyL3L0V80Gm08ZwJAdtsAvQEt2S6un2RzOoJdEhJHWP5r
 M+fxzkRVvjJoe8KDyltNOUe/ERAYblgPZKcTn/qgsu/74c4cM5ZR0HY/eUYlbKg4LB1M
 jJXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ87ixz+3lYLEteVbwzWKMfA1W30vScZpONAGdscR7FMjJGejWmmM1iZYWsvp71rwdqlp3fHIfXf18w0@nongnu.org
X-Gm-Message-State: AOJu0YzmwTN2B0XLXq8Iu0kLI2bfsOQWjTfioiHtOcOQ+R/hpS41nln1
 Q9Fh7urLvD2Xbbbgt2vCrZ/3MbwnELOBclArycBWs5W4t50ewtmj7vBkJbzj1ILNjFJkL6tp52c
 gU9hpxAoDjoh+VHPLUPqoQfiFfxz0Do1733RgAKFclw==
X-Gm-Gg: AeBDietfDDfjRTFekGW9n+sGRSId/UfAm/Q94f98YGgCUNMUgHlX0SvTdgToASXjsyW
 ryEqJOCkF0u7YtWePsE2wvnPiRGJKe58ufiPRoXC8JB2fbEY0iiJ9X/mhbPLglRZB3f8oOZLTXa
 nwdCoDq1QLcnK8Wfy3rZY68/y3IV3XkBapmpviHydM+W2v8NKTfzKTM7/szpq5HTxT9YB392c+1
 6xL35d7vBi9AE9xuClqOpCTf6xU9D4d1/wD8y4KElaxXTWEmMeLd8SJGK73wigohi8RIDm9oLQ7
 8G51Q4tnZoxgJXI+9dyFQf6SfYQKr787KRVbl0LRDbypQT9p9hXLSSVYZxD8LaoKrKtUZG7XCQk
 BrQ==
X-Received: by 2002:a05:690e:418e:b0:651:c268:479 with SMTP id
 956f58d0204a3-65310acca30mr28600423d50.57.1777208303303; Sun, 26 Apr 2026
 05:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260421082935.85995-1-thuth@redhat.com>
 <c04615d4-2842-49ae-b8e4-8d1475832ab0@tls.msk.ru>
In-Reply-To: <c04615d4-2842-49ae-b8e4-8d1475832ab0@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 26 Apr 2026 13:58:10 +0100
X-Gm-Features: AQROBzBP730PUuXnXiHi5NzGXmLACGtDko0tduD0dOf3hEA5HNbFtkrNDfwIy6E
Message-ID: <CAFEAcA8-TEcFd1bf+AmJL_zcmHmuE6=UxW5mndZK3kZ4orVJpg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: Fix the valid access size to the avr-power device
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Michael Rolnik <mrolnik@gmail.com>, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Sun, 26 Apr 2026 at 12:50, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> On 21.04.2026 11:29, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >
> > Accessing the device with in non-single byte mode currently causes
> > QEMU to abort:
> >
> >   $ echo "writew 0x800064 0x4142" | \
> >     ./qemu-system-avr -M mega2560 -display none -qtest stdio -accel qtest
> >   [I 0.000000] OPENED
> >   [R +0.001784] writew 0x800064 0x4142
> >   qemu-system-avr: ../../devel/qemu/hw/misc/avr_power.c:58: avr_mask_write:
> >    Assertion `offset == 0' failed.
> >   Aborted                    (core dumped)
> >
> > Set the valid max access size to 1 to fix the problem.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3393
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> This looks like a minor issue, yet it feels like this change is a good
> candidate for the current stable releases.  Please let me know if it isn't.

Yes, this is fine for stable.

-- PMM

