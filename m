Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E1ECC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGxjT-00072P-0A; Wed, 14 Oct 2026 08:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGxjQ-000728-Dl
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:05:16 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGxjO-0003ad-Ib
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 08:05:16 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ae9bc9a2fcso48056837b3.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 05:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791979512; cv=none;
 d=google.com; s=arc-20260327;
 b=BTB5C+bi+CLc/VP6dgQ51fKaywC4TWI8AVCTz1P2mkQ3FoHdYtBp27FJgKm9CnAM6k
 KptUEhm5G1F+/CekPW6QL6ilR7kICZjNzsVY1ZKiqa3pHSdy/ZPEelemuOCpF4sNGKAr
 Qi/BcpGxI+4gbo+4xEiIUJXl284fUHdJYSpdVy7GeJ2+iqeGtXdADlCZNds3eC3z3mew
 DDwd3tqbBrpV9S9yMhRvpa+70WxXx7kRc5YldveL0v40KCH2M2E1gFoDfWJ7r2f1PmE7
 ApQ85CyQkjfI3SKPr8gyAnqKCqtj38e6OHOhllXKRGmtmwQCOXSVp39PKeFAODyzs7Wp
 brZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=M9Nyl9xH3QF3gMvTwTw/sBu2NY+4Q2lch/paE09DFwI=;
 fh=h8c/yFRgZpGWeDZqTgMvFbz8jsrSkstGL4N/FagHsVA=;
 b=i7g8EmT2U9rd+0f4hzHHnNcI4BSgTsRHRC+gPZAuN42SyjMftDO4SK30UlGIMu95Hv
 7oRVCRR9hnhYoaOqN6WM3ccL4jAM1TYC/x+QhE+501qqTlC2TSA9jnPQ44KTe1RAMoqI
 KGhGT84ff7l562DxABV75KiUFUjl8NXY9poAqGwoI+UGHJo1rxB0e01scKAdFTVhs8D5
 is8RTUFYL/VQk7Wm+eGwkwfUyn8iwI/7hb9+yOPlUhVA/KqT7vqKzCdTLgwr625whuuo
 rnmiNsNNzlYiOpZYKH//KioPsWpWQPSfRbYT61vT7VzrXtX7JmTLo1JYQ52dP9ZR+CV1
 fm5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791979512; x=1792584312; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=M9Nyl9xH3QF3gMvTwTw/sBu2NY+4Q2lch/paE09DFwI=;
 b=nxm6DmJd8Os0mtL739V+77F64QyRY01XkdSlVaarp4mIlKSg6Gw73zFy7qyyYKWOz2
 uhr8NOe0OAPBeR7Eda6BzorPGeO9SyVspxKu5LnS/qSACKeiZYllSMqD4XdW5UcnuPkh
 ZMHpoUo+In6DMGdnBVHov7VUvKEMD+ahP1BnwHL0gCg2pbfJ1qgRD2HE42/WgHOlqkWe
 O9ctxagOd/Ov8mqDWsquhPyxxO1sFE7sNZ7Acv/RquIdIDuyi09EPZXFvDQf/eKFOCCN
 LGM4EX/bzyYZVZzrJk2r6SrrixcFbeqoLXKaUVxNI1y/6WYPo7X+rGWVQ0mwB6STw/3h
 tXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791979512; x=1792584312;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=M9Nyl9xH3QF3gMvTwTw/sBu2NY+4Q2lch/paE09DFwI=;
 b=t2HVVotC3H/xnxqLtoH5dRD37DofXkiE51JUxjtPHjOSIYE9oVRIbBucVTUr60304R
 2m1ZJGC7Wf5dvWw/vkSEFJ+Tn2Yy1lrXStVpOSI6Tg/BPJsyuYsdgBTIQREzIIyhPiYC
 weGQNAV+/w9fWGnacOLIDUloxnjCScd3no4M9zx5rPf2/QNvUX6IG6dq3dEFDaK7jV9A
 Ei27tBNiI/vy57XKamis3ySvhbePVvlNCQFKdqNZB1o4/Sa9F3KEZmbtAV9yu2S9own2
 pJSREbX/Z4pi5s4e1XvTHRAPmb9yHs6Zr6Cm/5hOt1njIU920eJ21mm/lfwLgXTMrLZ8
 LRPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0+IJlkvsOqyrc5gUhvKZlqQDpLxTDXDYd5DmzMWLv0JkOb4xTN+1YTdtOaCEYsc7G3PJWc4r9sOYo@nongnu.org
X-Gm-Message-State: AFq9FYJzfd5SfVDcpQTqrEmgPcCRdRoDGGO8YJbANwqvurpaqfhizRRZ
 LLhwCO7PWVJW6ZBtKQnz9rwEeeoV8hjDG2kZAyYidTTnpJ6+fpH8QKmQP5yTFEFE9x1UVqm79C1
 E+mrZf3AM3qFStoxNR8YVQgGu6sNVBVJ0zkJ1LNyinw==
X-Gm-Gg: AYBFou32Ct4GPGKRxlqFx5T6q9OuQHqrv+4KB7oN9C5wWLzFRcoBhKjEZ/exCz10jXu
 04JVudhL8ABAtV2hERoJV+HxYRz/e6WsfIQJIuCztP3Z/hMqKk38hKGKEKhSefpygXqdi8o8Xkm
 914CxD/JMxyDyvGDQuQ2OJGE8UeVil9pU+Hg6rLbwzS3WZwpQXHHL8s3DEMVu+Z35/crUkDcbps
 vmTHFepFdNJCUb+icnv1ixG4E5bYl24FjDgkbosfmg+eTvQiq9k1/atnGBg/YWY3Fdl4pXnWivK
 iQA7ePPGHjRk2b1cTJ+QWgOA+kHl66bpJ2otKzftGh/44l4gUxJJHlkwI7fdseVYir2vl/pN6hO
 ex8RkVPNO/jRH7EXc2IMEW0gijGnnpr1Wz6YINXa5ydq9s65msQ==
X-Received: by 2002:a05:690c:13:b0:8b0:a30a:7f31 with SMTP id
 00721157ae682-8b0a30a9167mr33446427b3.29.1791979512090; Wed, 14 Oct 2026
 05:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-14-mark.caveayland@nutanix.com>
 <CAFEAcA-FFiWEs3ZLztVwZ72_TGLuhEBbfKnaZ3NFJJ1W-Wd33A@mail.gmail.com>
 <c444a8ed-eb83-4a69-87e5-57c71f3a6d01@nutanix.com>
In-Reply-To: <c444a8ed-eb83-4a69-87e5-57c71f3a6d01@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Oct 2026 13:04:59 +0100
X-Gm-Features: AclHuK_fKBiA6YUTOHdzTar_zcSRcOFWB6_EBRpgQCUFNyZdpL7rStVJCTFbRZ0
Message-ID: <CAFEAcA8v+pcFz+HsgT9M6xb_16qBKK5FOuf8WupP5KuQK+aNcQ@mail.gmail.com>
Subject: Re: [PATCH 13/22] i8259.c: introduce TYPE_I8259_PIC device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 14 Oct 2026 at 12:09, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 13/10/2026 17:17, Peter Maydell wrote:
>
> > On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
> > <mark.caveayland@nutanix.com> wrote:
> >> +struct I8259PICState {
> >> +    DeviceState parent_obj;
> >> +
> >> +    qemu_irq pic_out_irq;
> >> +    qemu_irq pass_irqs[ISA_NUM_IRQS];
> >> +
> >> +    ISABus *isabus;
> >> +    IRQState i8259_primary_out_irq;
> >> +    I8259CommonState i8259[2];
> >
> > This allocates only enough space for the common base class's
> > instance struct, but later we do an object_initialize_child()
> > of the child class. If the child class's state struct is
> > ever bigger than the common class, this will break.
>
> That's true. In theory this should be something like I8259State, however
> I didn't think it was worth adding a specific
> OBJECT_DECLARE_SIMPLE_TYPE() if there were no extra fields. I did
> quickly check that if this happens, then the assert() in
> object_initialize() fires so if this did happen then we'd find out
> really quickly.

I think that every QOM class ought to define its own instance
struct, even if it doesn't contain anything beyond the base
class. This means that when we do need to add a field in future
we don't have to go around and find the places which currently
use the parent-class struct but really want the leaf-class
struct. (There are places where we don't catch mistakes like
this -- for instance I think if you don't update the
.instance_size in a type then that doesn't get noticed:
we've had a bug or too like that).

We don't write that down in https://wiki.qemu.org/Documentation/QOMConventions
but we do have some similar rules about class structs that
boil down to "either you're a leaf class and provide none
of these things, or else you should provide them all; don't
have a halfway-house 'we happen to only need X and Y but
not Z right now' setup".

> >>   static const TypeInfo i8259_type_infos[] = {
> >>       {
> >>           .name       = TYPE_I8259,
> >>           .parent     = TYPE_I8259_COMMON,
> >>           .class_init = i8259_class_init,
> >>       },
> >> +    {
> >> +        .name          = TYPE_I8259_PIC,
> >> +        .parent        = TYPE_DEVICE,
> >
> > Devices that directly inherit from TYPE_DEVICE are awkward,
> > because they never get reset. Conviently this device doesn't
> > currently need a reset method, but still, is this a good idea?
>
> In this case I think it's correct, because the PIC device in this case
> is a container for 2 cascaded i8259s which are connected separately to
> the ISA bus. Therefore each i8259 will have its reset triggered via a
> reset of the ISA bus.
>
> The container itself can't exist on the ISA bus because it would then
> appear as a separate device which doesn't make sense in this case.

OK.

-- PMM

