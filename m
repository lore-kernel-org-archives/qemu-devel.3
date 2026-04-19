Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E5EA7188
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 08:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wENbE-0000PI-S4; Sun, 19 Apr 2026 04:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wENbE-0000P4-3F
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 04:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wENbC-0003qo-00
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 04:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776587627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rLPwBZAuO7yVoRltIXrZqOLYKO9yfPdcfqrkUUgMAuQ=;
 b=Cyx68gxOlLyTd92Kd4v3f45vlTi8Zl1J3Zbq+vz7B8YPiSdJzOAVztPD/qOoYgcSQMmzAf
 NoRKBn1QaQu4AIW4i1iGFhHObFedaDdI8QqZofqOUJLo4Wbclx+JuhhH1VS5VhDrNFHiKM
 u/7+ODxZehxCAQjXSdxa7kV+k1CESxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-zlwA-2OINASdOBBNjLNYqA-1; Sun, 19 Apr 2026 04:33:45 -0400
X-MC-Unique: zlwA-2OINASdOBBNjLNYqA-1
X-Mimecast-MFC-AGG-ID: zlwA-2OINASdOBBNjLNYqA_1776587624
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso1712290f8f.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 01:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776587624; cv=none;
 d=google.com; s=arc-20240605;
 b=LL/yeZMW3Z2Gvj7v6iAqDBQB0BX1gVmskdDXg+AVVVCw/e1Aql3QNrLMQ673rjHEhA
 1KuHS4z7uLahIT08vnWkyl6+QyOAVvty+mSUM184kdlrXm5jtG+2i+aP0bPKPpUvhQK6
 mA2Md/BphuFw7GaZ6MX+J5npOIRpV38oNfsf1fqjqx4F9TVZfm7pbLFZg6ajI0+G921L
 fxv8/uQizpqxsxepr4HIX0gzyOgJytO3zdi0/H8J4osrk3leJdaEc2hBqHmEiu9vHfZl
 T6xfOGmJ9EhTAQIYNs/w8CSaxjNXoMwllUl16oYn0oZApyYoGjfP0ncYDxbdH1d7q0tw
 RkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rLPwBZAuO7yVoRltIXrZqOLYKO9yfPdcfqrkUUgMAuQ=;
 fh=7keYvWMxT8tzyrJUfr1+GGXboUjM6zt5MF6kkJwqLwk=;
 b=cJYef19RFqdrnGLf/fdpNFCbdFYBSEGIXXbGn6chz8vQMayb5sGlnN+oVqKnR2Whvs
 fIN+v5eCFb3MW6c3/J96MVPanzriA64cqOsxbPBPPJ+y86MXpIm6/rxxlBfvAgQNeyhV
 ttdy6sY4l9eobOn6HG8E+jIzZHAsadPyY//hJrC5iOjSXmiPHMS2rULrmrnqbe9itEG1
 p6VKXrOgd+aR/yt/iBZEEnM+0Puz0uSueMJqLuysLaNBRKZiD1C11m/P55Jmy1FkqF45
 hzxUfNhVizLx8g3PRn+Ka4W+TlsZcBM+DtrX/Kf36SVKPrsBT2NFdcWU48azQ7MZ8L21
 U6YA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776587624; x=1777192424; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLPwBZAuO7yVoRltIXrZqOLYKO9yfPdcfqrkUUgMAuQ=;
 b=MJhQ/79MxhH3vWGj90BdZyDGoxxgpkA2Qbm9Rp8NCI6hHc9GSLbbqRxkiEeq4FyJxm
 blklykPbbD3DeRvcxQhoBRMX/2W5MdcWuEtEmq4QRe6bdnTx0r56LA9qoI/jnaz9HjJk
 detOG65+r6OjPDIJYTkWdV+/OGByAsY2ByprWBgRhuv3V15uDMmHxCej/uYnmDchNrcu
 /ME8C6ZvRPgjPZVtAJBHKvE9n4Sc1fc/EtVeb5jMk1vkTcb9b2g7RWgdMTFkCl6NCA/z
 kXZlAm3wcl11BcnH2E5MRo2Yk1gX3bk4QS81OF7dS9cngNC8XjOi3CtWD6J3Q76EfH4L
 GCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776587624; x=1777192424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rLPwBZAuO7yVoRltIXrZqOLYKO9yfPdcfqrkUUgMAuQ=;
 b=nG077EefkfCl9/8b5A6/J2Ja8qBD2929hHw0awfzPJDgnIabGfPO4Xx3pWwMqRt2qL
 KYXksznLw68nJggOihJFe/ojrGZJiDx1OWowOZsmn9kden6Xiev06aiVR/04s22q/jFG
 EIYgCFFT5hOhIkvMfmCvOSAACntEnZ086VLSg91XRcJQZWM68GrCth9FnPTih5YhwnTA
 xBkbTQfzuA10pVPzLRcPldSrgWOr0bc/EIHcwZQXNULTnDPtUmA1wEp+CXh7Uk5RSd57
 Kfqi39D258rIroTVQHPDP2GJFlZl60RADflTCLmr2yTbHT36SwFrFg3kI7rSwXCQk/GP
 rp7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CKxYD3d3Ck5Pbej691WxKRT65+5MRuX4TjOUm8helVoDIKHg0w8xjhPy5FeYzhFT/coblisjFKr66@nongnu.org
X-Gm-Message-State: AOJu0Yxrw1/kPa5b0NVC9urbFeuxYYfhqPrnO4HAjsH2KM6s3RUiEBhB
 W1L14domsiDsLzx0cwxJC5XQLeJKY3OdGIwpfgV6GC/RIjliVc7dmv5Wl04c/e/aHMiOK91cjK5
 jb6n9d0JvtLb1gx3mFvSvRDUZXjD/DxSqpQZHGohdRMCWCARMAWM1EpeyAWOpcxxolmiiMk+F/Y
 knhvPWZ+zbqXiT2Isij2840oSuo3CY3Iw=
X-Gm-Gg: AeBDiev9eDN7qr8ZQtRpveaK5FfJGC8mPE92+vNIahdsKOW4q/d60TOFAdk0TAkXjeI
 ekC2tVqbtQS4a1a4m03KgIqmg2QmYTD+doxxrKuzYruBoEfQJRrrMoypq5ry7hICl6U0FPzK3Hw
 0SplwJHYv6W00XziEVWvr7Y6hlpZ6v84AweZLFYJlTYW8b9o99+uZitsAwUNMVz/iyu/33foiLa
 bgJstz7X5Nq596WkVFQteUAA/KCGf7sDgoK5tYIQfdlloRyvPxb8lcOIGwIIY6d+RFauP7IbpKl
 1lqg4drJ26ov99k=
X-Received: by 2002:a05:6000:228a:b0:43d:779e:afa8 with SMTP id
 ffacd0b85a97d-43fe407a7e5mr14684997f8f.16.1776587623727; 
 Sun, 19 Apr 2026 01:33:43 -0700 (PDT)
X-Received: by 2002:a05:6000:228a:b0:43d:779e:afa8 with SMTP id
 ffacd0b85a97d-43fe407a7e5mr14684964f8f.16.1776587623302; Sun, 19 Apr 2026
 01:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260418061429.16898-1-rickgcn@gmail.com>
 <9926A5B0-8660-433D-B074-3B49E830BC9D@unpredictable.fr>
In-Reply-To: <9926A5B0-8660-433D-B074-3B49E830BC9D@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 19 Apr 2026 10:33:30 +0200
X-Gm-Features: AQROBzCKAQDmNANV668nkEulDo5HbpBITXsbc5OPJYYMum-yUI3eCLgHj6OTB9g
Message-ID: <CABgObfbZPDvB6FAEbUY3fNZd+3mNkjnoU47K2RCSDM4zy1fn8Q@mail.gmail.com>
Subject: Re: [PATCH] hw: i386: vapic: restore IRQ polling for non-kernel
 irqchip backends
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: rickgcn <rickgcn@gmail.com>, qemu-devel@nongnu.org, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Apr 19, 2026 at 1:14=E2=80=AFAM Mohamed Mediouni
<mohamed@unpredictable.fr> wrote:
>
>
>
> > On 18. Apr 2026, at 08:14, rickgcn <rickgcn@gmail.com> wrote:
> >
> > 69dfc078 extended vAPIC handling for WHPX with user-mode irqchip, but i=
t
> > also changed vapic_write() case 4 in a way that excludes TCG from
> > apic_poll_irq().
> >
> > Before that change, IRQ polling happened whenever no in-kernel irqchip
> > was active. After the change, it only happened for KVM or WHPX with a
> > user-mode irqchip. Under TCG, both kvm_enabled() and whpx_enabled() are
> > false, so the poll never happens.
> >
> > This regresses 32-bit Windows XP guests on a Windows host with
> > -machine pc-i440fx-10.0,accel=3Dtcg, causing a STOP 0x0000000A during b=
oot.
> >
> > Fix it by making the decision depend on whether KVM or WHPX is using an
> > in-kernel irqchip, instead of whether either accelerator is enabled.
> >
> > Fixes: 69dfc078a6f0 ("hw: i386: vapic: enable on WHPX with user-mode ir=
qchip")
> >
> > Signed-off-by: rickgcn <rickgcn@gmail.com>
> > ---
> > hw/i386/vapic.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
> > index 41e5ca26df..1acb9f91b2 100644
> > --- a/hw/i386/vapic.c
> > +++ b/hw/i386/vapic.c
> > @@ -716,8 +716,7 @@ static void vapic_write(void *opaque, hwaddr addr, =
uint64_t data,
> >         break;
> >     default:
> >     case 4:
> > -        if ((kvm_enabled() && !kvm_irqchip_in_kernel())
> > -          || (whpx_enabled() && !whpx_irqchip_in_kernel())) {
> > +        if (!kvm_irqchip_in_kernel() && !whpx_irqchip_in_kernel()) {
>
> Hi,
>
> I think we want to keep the kvm_enabled/whpx_enabled checks.

No, it's not needed.  If kvm_enabled() is false either the checks are
compiled out or the variable is false.

The check is for "is it using the userspace APIC", so rickgcn's patch
is correct.

Paolo

> How does this sound?
>
>         if (!(kvm_enabled() && kvm_irqchip_in_kernel())
>          || !(whpx_enabled() && whpx_irqchip_in_kernel())) {
>
> Or
>
>         if ((kvm_enabled() && !kvm_irqchip_in_kernel())
>           || (whpx_enabled() && !whpx_irqchip_in_kernel())
>           || tcg_enabled()) {
>
> Thank you,
>


