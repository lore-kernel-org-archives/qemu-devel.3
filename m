Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13310CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZwF-0003Fk-QG; Fri, 02 Oct 2026 05:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCZwE-0003FO-MM
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:52:22 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCZwC-0000py-6b
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:52:22 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 00721157ae682-8a7411012b1so72369787b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 02:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790934738; cv=none;
 d=google.com; s=arc-20260327;
 b=eOiSKokCsdQxU9AHMqRDOjjFMMqg7cVE4+Zkcpa3hRkGTvUKz6rLdTicvz/WiIOEcn
 1JxzffZRwsoB1ZB4oI5iC3Au5ISQ3Dmhw842Rw7gQuVSc+F1giUXKSLMBDZODKqf1DA3
 KmyVvJz+xwrN1DBd4+LJSiHaD1DMiS4ThYmWpuUkMCetFFZBd3Ou7u7QjE5maiLRzVpt
 N3dAaK5hfBZV05EC+XAH6v90+m+/nxiyd5XrlAUdxgEn49VoQmMC1tRYrugzIyE6OX+9
 rWZxp8SZQEQcr1lDke4BcI0/b234KvvOo/G0eLbME3Fl41Gp0aTolCehG5BzfAZqLHOG
 ScrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kS48AqODLblVpccntfewHU6RKnpje2GovfdoIqGkUZ8=;
 fh=LX+cLgtw9TJIDgDgLWvTr3l2mLDE8DLsNMKbDBRfU58=;
 b=WHB1iGN5pzFpItWTg8PPLRxSsFFqYfR3KuQrT868blwBV5I1lb0gbKFfe4EoV4vFlO
 DRhqMsVlifLVIUr1zrfbWLG4tITynWje8Rw6pzPwnGSm9A8ubZ5qMNI/CAB61fP7m2le
 m8mkYmYStyDJLeEJuY3z4EoeYuKbOCF0DWQ9mSqbzrTVJyW5hlPpYv9c2SuEchey5jIX
 gqtu+cZy1gSgz5I9Lc9HOoHrF0jVPVx25IhztAngGSAq69rD0T4nnU0mvBWameUSr0YI
 ccyIrjreSp2GhcDSnT2uTb0hz1c0x2di/2swi8H/5qsgit06nX6oaq5S+pd9ihyI6sl/
 j9aA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790934738; x=1791539538; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kS48AqODLblVpccntfewHU6RKnpje2GovfdoIqGkUZ8=;
 b=z8y0stPCi5oNCiUjjwlqUuU58zb6d+KOh83erOUY3dH5ZYX8Hw5n5Nc+7Qq6RbO/ZW
 2pdgVK6IO9JQcvbUZn89nSBSOjts/M3oTy9SlUse91Htrdx3WX6Qb914JTTmJJoNOfHT
 b0ltsfqLyqCLuSyRM482rZaZm53Dh2+ceCbGYKkU60A2t5ORIskR1HBYnm1Xate4VXaa
 99FlFkuMtAmU9p/5sgL+zKzvrZpeHczZ1qhN123LVUUOPjEoWE7jKKt7aaIQNZyULMry
 xqeqJt/byN6yVn0w5qy3ZDBcHpY0kMiO/yutkVv1NVjnWUUzTBwCdsbqLJjPmZsQAITE
 NLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790934738; x=1791539538;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kS48AqODLblVpccntfewHU6RKnpje2GovfdoIqGkUZ8=;
 b=pI4eu+vOilrAo4ouJbI4Pox+sCGvJ7jn0EiYGV09uUspmZVTP+XSrz5JlTROnPTbUR
 cHWHcpLB67/CUa7tat5TPnHyinhDpQXnX8TCqMorEzlonLRgzPioTiH5dHpXIE8ftJyI
 UsdulI8QFnRVv3u1q4TCGkdGIudPWP49Ps182bJEwNyuKKHYtATLByhrsn9Bq8Xk7APD
 xcP/VPpnAjCONMA8BZW5q0qvnv56/3Vv1GWE+mMiOvQ11JKo+qKdRGIV8zJqubFztDfK
 +NC+mEJZwwFnDRz7wZoyrbzp8W2GjpbMQ06nTYqL104e2Pf3uCNApYjqykL/61bxAct2
 NqLQ==
X-Gm-Message-State: AFq9FYLd7cPGgw7/XwlOJXpySS8m6B9dhggJEY2zmRUNx4IXhHCCqYRu
 E5CqYPEZoU5zCG2j3m4yvGJrE9b322HP7Y6DVENTQVjjIQ9V0+Ve0HzCwEgNhTrvzMgriIQnh3/
 5fdBEZH36TsrPRXEO9PxAcL55bRSs1GhbqQAm0JIBWT1QtgcNK3fbxICYbg==
X-Gm-Gg: AYBFou3gsuQCxmzGYPnCEXEkw/OIvdwJ8bCJEK+HNUH/pDQ/hcgiagjD7vupcWqYlaR
 /C8Y8vl6HVxj3XauU6nG778GgPcL0ohEX/VPd0iVckJxfhGsyH/8aGndcEtzbWa2MBbL6opZvNY
 0CWzEkqGz7HX1pYJzwi9SqsG5cvzzRsifyKZfUcw0Mt68b8YoK6XOaMK0NQFiFtr+YXGNbErqlB
 ftjLIRu28t/4KjPEZdILIkpSvXd1F3T6SFjYNUL7b2RtA9ctVbs1kAqdqIBdJRSZXgJJhbPJt79
 BO1Lq4zNWW6O579CTW8UejK6Jm3OEWtrU5hY4U8lDm082QIVF+ODJUyODxhBvSiq7DblSGRcJ07
 hij4iq3YXv24Rx4JVEvu1GJHr2J2oKBNh0vjVoUk=
X-Received: by 2002:a05:690c:9990:b0:8ae:17ba:df03 with SMTP id
 00721157ae682-8ae3add6500mr6171777b3.64.1790934737739; Fri, 02 Oct 2026
 02:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261001194756.3003085-1-peter.maydell@linaro.org>
In-Reply-To: <20261001194756.3003085-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2026 10:52:06 +0100
X-Gm-Features: AclHuK_ru2qMh2_WCME-arx3t5cGRc8dpSTGROJCSAVr3zEsjGrXSYYVRpuJPNc
Message-ID: <CAFEAcA8jcNzVT9QuFfog4GZRWt8ZpysKbOy9R-SxmtTrAZ67JQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fail iso packets sent to non-iso
 endpoints and vice-versa
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 1 Oct 2026 at 20:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The OHCI USB controller requires software to set up an Endpoint
> Descriptor data structure.  This specifies (among other things) both
> an EndpointNumber telling the controller which USB endpoint to talk
> to, and a Format (F) bit which is 1 for Isochronous transfers and 0
> for General transfers.
>
> The specification requires that software matches the F bit with the
> endpoint it's setting up the descriptor for, so that Control, Bulk
> and Interrupt endpoints use F=0, and Isochronous endpoints use F=1.
> It doesn't require the controller to check whether software gets this
> right.
>
> The spec isn't totally clear about what happens if software creates
> an ED with a mismatch, but I believe that the controller just trusts
> the F bit, and tries to talk to the endpoint with the wrong sequence
> of USB tokens (notably, isochronous transactions have no handshaking
> and the others do). This probably results in the transfer failing.
>
> In hcd-ehci.c we check for the "iso transfer to non-iso endpoint" and
> make it fail, but we don't do this in hcd-ohci.c.  The result is that
> a guest that deliberately sets up this situation can cause us to hit
> the assertion added in commit 7b1eba96aeca, where the endpoint is not
> isochronous and returns USB_RET_ASYNC to an iso TD handling function
> that isn't prepared to deal with that.

Side note -- compare 45684127cd which fixes an assert we hit
in hcd-xhci when the guest configures an isoch transfer on a
non-isoch endpoint, and the code in the hcd-ehci model which
catches a similar case. An alternative approach here would be
to add an argument to usb_handle_packet() which was a bool for
"is isochronous transfer" (or some enum, for better ergonomics),
and have usb_handle_packet() complete the packet with an error
response in the case of an endpoint mismatch. That would allow
us to deal with this in one place and make it harder for the
controller models to forget about it, but it would also be more
invasive as a change, which is a bit unappealing given USB's
current unmaintained status and a lack of tests for it.

thanks
-- PMM

