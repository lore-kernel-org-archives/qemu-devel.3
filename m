Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53573FC5915
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 11:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vva1B-0003sh-6t; Thu, 26 Feb 2026 06:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vva13-0003qw-K9
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:58:50 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vva11-0004is-Tc
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 06:58:49 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso811968d50.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 03:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772107126; cv=none;
 d=google.com; s=arc-20240605;
 b=CCmqArI+rmAY9w4oYMCwvnDm7PT/fQ8zs197UN2Bb2J6gpIM9OSTklprrv4EUERXv6
 mFMYfjpWpWnZZwwxjYGID1sHPwRWA8zPLe7gRjb/qmNS85sETcc6t0Vs6WFqtD5uM0km
 YvFJc344eTCyTeiGjezmqIMiB4lK9+aUSyCijEajMFOgwuPUSNd6cKpXBDnJDuI/GJti
 mH0JbG9Y4Ud804jKPr0BZWGx4cSivmR556jHiY6Y9i5zumEB0eFkqP0LNMTIoM9GGDes
 hYBgHSWUu75KwoFRlvQACmNrJulhCeqJFBmcX1z1gg+DxEOhj9s99MBIGraRY31JdQep
 ED0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YK96kD2X2pDEwIyzpnmlnJU1lWgCBQKcMvno7KDFusU=;
 fh=KF9H2fvp5hmhXEEqXYPimKkMJGdKDqrEgw4AcKOUtn8=;
 b=kT0Fd9cDdqzjsU+cpt37gnAVCwQg3zbRrfFKmLRIdY7HuzUJJix/j3+tTL/Kp7oSLZ
 UYrBd86NxQASS1LmsXttQdp9WTC+PE/kjHKmAHCJV69tPoHiCealqwV+58cxZriYlR0P
 WmoaF72bLu9qFabQKyBIeWF7gOPZjrFeoxF4yDauPRI4rFkd4eRC8SLfi9i91cOW+g/s
 AwD7HYOPKFbAUMl4yua9DsUcrTD2OQ5os5wenzYGo5wn7lj6mpizwOOROdqVbNTh7qNa
 gKljNBvBrnyzW8Tn+T0adBXm8m3/B53C2yFe4efhO9MdnQIsQwEBmGhbmBjIZk6L2YEJ
 kDEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772107126; x=1772711926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YK96kD2X2pDEwIyzpnmlnJU1lWgCBQKcMvno7KDFusU=;
 b=EgA6Jh3VZcVNMCqOsHiotH9oqhgYNk/6ATyi8lE2nLuIfW0lBnHWlVEpoG8E84V16v
 L5t/SUm38nQ0QlCOWRJQtvBX8KP768s0//xk7Pa4Uhb8Y89WULYdqYvHSM23NbuAgsQR
 dzVRgLkoefLn6+EgG+3tCzti840zVrqY+PRviwYUTd8RJN4q13Do5ZkIf4+JlEOW2Ug9
 DgJwblE6ZqHrTo+l4R6oI+UwFIO+jFaR6u48L44t4Vno8xaMvHa4ySdrnaoqnW0m9B6d
 KzPu28qviJvF1QiR2PfQ+lGUyQIEv/OuCGSo7VEBAY6ZIrbWbg7W6lixf1renQUBjyWR
 1wzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772107126; x=1772711926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YK96kD2X2pDEwIyzpnmlnJU1lWgCBQKcMvno7KDFusU=;
 b=A5TyLOVs3cpovUq4BaWJIfw8l0+TS7/WlJXRMT8TYTqo2g4vATAdfaLFsR2d1THBJY
 gkLADNRXGa+rA+R/2dz4mAFN9+qjKHzUI/73PLXh37O9F4rMebp8btiX9VnKoAsuZCmO
 ULyrT+85CmYe2vV3mw/hewBPPpKe9rTumTZwUp801OaK8qejz85bUJjAOKJZyItn7lMz
 mECP7R07k4YwIQjL6SwcefaP/vlz1TS9sC6CqOg+puYP5iipv/0KtHcPbdZP6KtVf/u7
 hXQU+3zF2Smx0AJVm8vAV05FWvMOyUoqmVOus9vpUM1gdz4ksiuDm0uHxuujnFJHjkWX
 wiLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdPuas025AC7QF6+dWYOOhGjJ4A8H6iRlw6nXr84ZrpNPLvbtwdiYN2/7hZNIcZ88o+ULme0TxUomp@nongnu.org
X-Gm-Message-State: AOJu0YyfJEI/xBxIcHU6b0c8uXadH8aQoIg9u/nHF3ECav1MLkjCK4ae
 YKt0HM2jJt1Ngy+YgLIep8GfCeqTbTZLKDBH21xCPKnLqyxhAeRy8WOfrOredQm5TWHxgy4N1wE
 JIUgHIZzNIrmK65+Yd9hqp7VTngbYmwd0Ou7Qd/1zNA==
X-Gm-Gg: ATEYQzwa0u2cDnfHFpBLcho5qxo9+ovXdDOCxMrqXLnqz6M5R96Z5Am81sbq+YjefsA
 HCL+hT2qyiFu/R4f1kNEqryDu/v6mWjqbE4bnwdqP5LbX+6Fq1j8at3KqvvCDdUGa2K1Pw7pTtN
 SuRrgrAQdo0Vso5/zhzcxKP2XM6NS8qSR+i81fsN3Vq0dVMaYGmTIZCxVWNpKxf/4r/5kSNDAoI
 Hlu6uq8S5YB9R8DnceLgGKJdxMQkWQ1X7wobIqy5v941rwYKWk9vMQ/CAO0NSTKyoCw2LcWswwl
 RPGNlISiDlOWlIICxgb1tI7dkwSbVdAfVN5n80aUL0/1T7Oic5GrNLDax1AONmpIFQQ=
X-Received: by 2002:a05:690e:12ce:b0:649:d68c:1f60 with SMTP id
 956f58d0204a3-64cb7c24d12mr1459042d50.33.1772107126106; Thu, 26 Feb 2026
 03:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
 <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
 <3a72c0f3-ba85-1e98-3964-5f43efb80375@eik.bme.hu>
In-Reply-To: <3a72c0f3-ba85-1e98-3964-5f43efb80375@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Feb 2026 11:58:34 +0000
X-Gm-Features: AaiRm50n-CEfuOTolsLFOZPFe-KHCZo0rKXcUHCRIrnJ_nXWV8NCxWDGpcpAVbc
Message-ID: <CAFEAcA8wu0kvL0END0woXp-yTpv-Va708Uytc--ASJBiEi7Yvw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached
 if they have a bus
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 25 Feb 2026 at 01:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Tue, 24 Feb 2026, Mark Cave-Ayland wrote:
> > The questions I think we need to answer as a starting point:
> >
> >  1. Which API shall we converge on: qdev or QOM? Can we come up with a
> >     code sample(s) showing what we want object/device initialisation to
> >     look lie? Longer term can we unify the QOM and qdev trees?
>
> My first question is why do we have separate qom and qdev names and trees?
> The docs aren't very helpful. Qdev does not have a Glossary entry and only
> a brief summary at:
> https://www.qemu.org/docs/master/devel/qdev-api.html
> and some confusing info in an old doc here
> https://habkost.net/posts/2016/11/incomplete-list-of-qemu-apis.html
>
> For a long time I did not even know there was info qom-tree command in
> monitor but I was familiar with and used info qtree. I still don't know
> what the qom-tree is good for therefore I also don't care when creating
> machines or devices as I never use it and don't know why I would want to
> use it. To me it looks like some internal thing of QEMU that I don't have
> to be concerned with. All the useful info about devices are in info qtree.

The qdev tree is the older of the two. It models the buses:
devices can own buses, and devices are (mostly) on buses. The classic
example is something like PCI: the PCI controller device owns a PCI
bus, and various PCI network devices etc are children of that bus.
Reset is (currently) done by traversing the this tree.
The qdev tree represents a real thing in the hardware we're modelling.
(The "sysbus" is an odd thing that has all the memory-mapped devices
on it, which is kind of broken in that a memory-mapped subcomponent
of a PCI device is still on the "sysbus". There are also problems
with devices that aren't on buses at all, notably the CPUs: they
don't get reset automatically, for instance.)

The QOM tree is newer, and was introduced when QOM was. It is a
tree of ownership of objects: the machine owns all the devices it
creates, including perhaps an SoC object; the SoC object owns all
the devices that are its subparts (the UART, the I2C controller, etc),
and so on. It provides a hierarchy that the qdev/qbus one cannot,
because not all "this object owns this other object" relations
are ones where the other object is on a bus owned by this one.
Conversely, not all "device A is on a bus owned by device B"
relations are "device B owns device A" ones -- consider an SoC
with a PCI controller and a PCI device that's created via the
command line: the PCI controller doesn't own that PCI device.
In that "PCI device with a memory mapped subcomponent" example above,
the memory-mapped subcomponent is a child of the PCI device in the
QOM tree, so here QOM gets something right that the qbus tree doesn't.

-- PMM

