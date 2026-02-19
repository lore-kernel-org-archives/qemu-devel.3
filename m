Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AD8E9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt11x-0007lU-UW; Thu, 19 Feb 2026 05:13:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt11v-0007l5-0n
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:13:07 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt11s-0007q0-DH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:13:06 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad8435f46so620076d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:13:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771495983; cv=none;
 d=google.com; s=arc-20240605;
 b=H5cXOWPPF25hHosAKXY9QDJFNR3I5BPaH5LTzOK+vE6tpw7nhAql2fAOXApqXTGD+k
 AD4MRU3RGacpedjgkmRNsCZaL0UjLbqKe/FZONhrXc6Ci2/A/TdZuxgxmQVbVwIBVsks
 G6B6U3gR+vqikDmnnEZiIRODRRZKTrfGHpJNHB8DnR6gb5lAPLdx4HheirtE9D7JBX2T
 isZXrRcy3z3gGEd75UFT0IZrNJcCkRKfV+1pAK602xevaGfvQF3B3UfJzrd1j+uYRSki
 cMzi4x4rQg+1L3lDakkTPXMH0FwlKD3EHqu9CHvcTQuzIumdq8283PgTso27X6svmxxu
 9wWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=I1Xccy3fuo4NeBujNW8Yr112yKgANjPYkwu+AYvM1zk=;
 fh=EW9hBPmu06DRmAd6hMxBcpY5XawM6U88N8rDhpCGN1w=;
 b=XHt/HWJQFXwP+eX+l93/yZmD+ifAhr39pshtT4gkqxnYU/Ca6uMN++kSs4HtuoJs3A
 q7ZfTcge19TuMUAV0G7N78ciGJO3zd/wER1hgV2NHvonQNZdcdQg5rqS8HckwO+nbBTC
 DearVj1lcsDxpcv8VECacHZSJdse+PezEQIYC558ntrZxgKBULLlo3808BZIbGTphKFi
 O3HpKT5+yulRUGGjh7GVr0OmjrLq+tRKm1PicUhqEVXg0lmafMBIhmecCcseX1FgZ6Ax
 /IAcZhPWOCOFQafIlyXuUpEye0nswsXnEV0D0w5ZdSdKF5xEYl99roTIsapLXW61S8bL
 Gqxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771495983; x=1772100783; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I1Xccy3fuo4NeBujNW8Yr112yKgANjPYkwu+AYvM1zk=;
 b=Tjj1g4UC6/+Ux3OTgK4u/CtJR+m9KdT8pChYqUyHn8q0jeUlXUUnIH9/IPhqIzALz/
 HVXg6HgzOL6t9Pp2dEkGU1VlC0ilrmdGcOjoQsgxkDGh9AFo1+9nrXOjRPwqN2bDsWLI
 22jEdBXDUmZtHhuEmVONJrxXlJPc50k1f1dibcfJRy6oEaqFTYUYdBLsda9cxdFewntt
 9/RXJORt634ny5HVqNQ6Rv8yip+3UGqdFxyCmB1mZJ+hCpt90COGHfEKwY0S4z6HXh6P
 K4/dYYtyT9Y5xzW0z74YWRZONSLdlBJekyNtXg6ImpQNobhJCk5aIfQ1m2C8hv+qUsjl
 duCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771495983; x=1772100783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1Xccy3fuo4NeBujNW8Yr112yKgANjPYkwu+AYvM1zk=;
 b=V45Lb3aedl0V1Nr5TyScuK9AqvufNip2dUwAFhcO2Vc1897WEYZRaMDXQnxoUPQpjR
 n5SpFlGaO1FvQdAGCO0LMWYnxQlJK4JSWuFFoIHTvwKN22t04Q6a0i60q8ts0XrEfYQI
 dVBvNk8xQ7sZXaHxf7T7DIq9JwONAB/RsD7Po79CCFwKGEg2Tp/6HhjKOc9s4Sv7tGJj
 5cC733KNeM8xlkdDluKIboK3hfJHJSMnVZt/uanwqnrK2skNxRviOy1rymG1zKYgNICZ
 nFG+Bk68Jb4xRu6KsrywgmOizd0bzmF7u3+KFgLHzhuAyz5qq6PTWgXhX4w0TTYRW68N
 UN4Q==
X-Gm-Message-State: AOJu0YzapSU2yMh04Ch31DIHVSPCdOuTQLxE6wG9ycZvgUo13TLX3RFt
 blUelGeDzECaI9YU+7xFKy8+fCoQXsw5bcLVcwo6g9lhpD7gMAaqZK4353kabfXJJW+J2j5JTwx
 CRdhjhEfKHZeI28PGUY5c3NyDs85NFy9RmVzwMGS+oQ==
X-Gm-Gg: AZuq6aKTCUNhzgdKvpmV/1MBKDY1o58dMMa64t6YFgS8SqwvETc55ETkqZr2sSGVpR7
 +pAvVG6g0vikymdNq3MBjkH3ayJ+nJnAX1Pc+w+dm9aIvQQHdrKqBmDJqMFy1Iss2FsXPQ9G280
 bUF3iCjDUziTqxjgDiM4C9CxYljlziuvkg8JNLtU9aRwzMwRibHeohjoBcIlh8PQd9jnCs6ipTb
 +KIHyKxpzvub0QSIZKz1lILIRyJCSSVjTIay4r04681dY50HWFTysZduF3yPvCPr4Uqux2GOZSm
 aEzfnIGpu5XASfI8DUplEOnrx12z5yPrjjLoa+SvIxZ03tOqOlP66OUtYdwBkjfrhmg=
X-Received: by 2002:a05:690e:1590:20b0:649:3e3d:327 with SMTP id
 956f58d0204a3-64c21abc466mr10458746d50.40.1771495983057; Thu, 19 Feb 2026
 02:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
 <CAFEAcA_+eqfTy+7U9igTscue5SMURm3C9yUXvdFTon+ZgSJfAA@mail.gmail.com>
In-Reply-To: <CAFEAcA_+eqfTy+7U9igTscue5SMURm3C9yUXvdFTon+ZgSJfAA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 10:12:51 +0000
X-Gm-Features: AZwV_Qhabehe9XEqgx1hlH4Z2TOu_dd-y-R6Q2cllhzQweagDwcNI8TNXSoHquA
Message-ID: <CAFEAcA_fR8gQc-f1qhcNb7tD0_EfqfNJEhS_tSg354Rhpb=fQw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: Mohammadfaiz Bawa <mbawa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 philmd@linaro.org, cohuck@redhat.com, eric.auger@redhat.com, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 18 Feb 2026 at 19:01, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 11 Feb 2026 at 12:28, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> > tables even when no backend is attached. This causes "Unknown
> > devices" (ACPI\LNRO0005) to appear in Device Manager.
> >
> > Until Windows fixes that by supporting, adding a new machine
> > property 'virtio-transports' to control the number of
> > virtio-mmio transports instantiated. The default remains
> > NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> > Setting it to 0 allows users to disable virtio-mmio entirely.
> >
> > Usage: -machine virt,virtio-transports=0
> >
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>
> Applied to target-arm.next, thanks -- but please could you check
> up with the ACPI spec about whether it says anything about what
> to report for empty transports? If it says we should or if it's
> just vague we should probably match the x86 microvm behaviour
> of not showing empty transports, since they can never be
> hotplugged after startup. (This might need to be tied to
> a machine-version, not sure.) Maybe we should also not report
> them in the dtb?

Looking again at this patch, I had a couple of niggles, so
I've dropped this patch from target-arm.next for the moment.

(1) we need to document the new property in
    docs/system/arm/virt.rst. Something like

--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -226,6 +226,11 @@ dtb-randomness
 dtb-kaslr-seed
   A deprecated synonym for dtb-randomness.

+virtio-transports
+  Set the number of virtio-mmio transports to create (between 0 and 32;
+  the default is 32).  Unused transports are harmless, but you can
+  use this property to avoid exposing them to the guest if you wish.
+
 x-oem-id
   Set string (up to 6 bytes) to override the default value of field
OEMID in ACPI
   table header.

would do.

(2) I think we should call the property virtio-mmio-transports,
to make it clearer to the user that this is MMIO-specific and
nothing to do with the much more commonly used PCI virtio.
What do you think?

thanks
-- PMM

