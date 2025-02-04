Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE72C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKhb-0000hN-5Q; Tue, 04 Feb 2025 10:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKhY-0000hB-0g
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:19:01 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfKhW-0000vb-3I
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:18:59 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so5740531276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738682335; x=1739287135; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjYgOI+9qDfnBC7XXaqJktPREuHx70VJdecWMGw1GhU=;
 b=aGXBnS65qy9s05e/SYhixinqcCkzlcZJJ4cU7VlK24kMmCWtwwIHb3okQE0d26yfFe
 eS6JfyRvI3RRKdrEmp6VyB/FGv98wfROjsbCpRPCLbvvr2QR2/HjnC2Si6ZG8viC9HsY
 9rdGshTFed4vK+pND8dvNkfhnguvrOqjuV2wEXQmUHJZ0g2mqRE0AQ9xHVg0hDmliaXp
 gh4kshD4WWteAYttUQ3QPdehpU3N/TztBSTvDxm/WtnP4HkZ1+MJ3hqmNuFJi8TE4Yd5
 0XrOKIRfJXM+R8AuS7DNMg9yU+P3CJCvmEHlTNGnMn+q8iF6JfmMU/4BRXegw454G3BO
 TtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738682335; x=1739287135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjYgOI+9qDfnBC7XXaqJktPREuHx70VJdecWMGw1GhU=;
 b=MoVDv2YWZeGnZlkvea4luBZpLEAWfIpP3/M2T2NQ340kYZPWOk4KxIQ01hLeosmD2t
 FEZ8TrfXigQoNPHatFrQ3xlCdqGhcgd/jjFfQb0Y7zXmzTv+b9P/Hkm3k9j5yHyfDv51
 LIbp1srBygbrA7MUfhMGpSw4D2YHm3FayVLKq3grY/xkdGk/24ZqZbFhGI9wMNmm8F1/
 hnmDtDE1xungH6pZzZnfpR8nDUtCDfGL79RTSGZG3HhS/RMyAXgaR7sBIFR9+SKFBkd/
 ePQdU/AzYTGDgG0BBzlMqsG6z9Mi3abx+cwVjtntx6YjEaOLxiE3zC4Y4EupJzEqhmYj
 ILsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfD6iSQqaJ6mQL1eub52J+KV93CszI7lJaMhFXWr66C9Wb78GtZzb5H9xmQ4bNmF2P/dVz7Oj/nN70@nongnu.org
X-Gm-Message-State: AOJu0YxwgJXo7J3Y+1eoPVCgEKbHLKrsNizTFO19SjQOfilUerbbpeBp
 m3MFay4PhSWsZuLY0a47lryAbJsQ1Pj4hlFyczj2/p6pc2MqqW9RFGxIwLKf/SHzpcd6ibYMSan
 Ffom9kevs6+FbRzc2T9JLxazNAdkBRpmuLuEGgg==
X-Gm-Gg: ASbGncuOQIyIAqYEQ9DrxOf8Dj0SeLo1Qu1UNYsLa4f0vmsYxDZNEiyG+OGU03dp3u9
 bt3CZr56kybntwadwQNQi/HLKfiQ2sNp9MEvgaCSvUKbi706qh5VKT9Trn7fHfZAq34YUoUajZQ
 ==
X-Google-Smtp-Source: AGHT+IFnWqAslT3HJvleVqlLXGAskL5Yd39KgA0ntp7bmClM+WC73tDCQkNsVg6B4Nz01PpJn5z759eWrcDQ6cIlwRI=
X-Received: by 2002:a05:6902:c10:b0:e58:11f6:db86 with SMTP id
 3f1490d57ef6-e58a4ab07e9mr19679460276.7.1738682335306; Tue, 04 Feb 2025
 07:18:55 -0800 (PST)
MIME-Version: 1.0
References: <20250203114132.259155-1-pbonzini@redhat.com>
 <bd5ccffc-5e8c-4b87-9168-01a964dd6f0a@linaro.org>
In-Reply-To: <bd5ccffc-5e8c-4b87-9168-01a964dd6f0a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:18:43 +0000
X-Gm-Features: AWEUYZleqCQUFjdqasREF12FALgtPPi5TkL2XbKAEj1uUfu5PpI10k1YvhyzO2I
Message-ID: <CAFEAcA8pjBD7cM9BwgGWLjSW-TUqXvnGMOJrkp8wY2PqaV7RdQ@mail.gmail.com>
Subject: Re: [PATCH] qom: reverse order of instance_post_init calls
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, mst@redhat.com, alistair.francis@wdc.com,
 xiaoyao.li@intel.com, Markus Armbruster <armbru@redhat.com>, 
 Bernhard Beschow <shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Tue, 4 Feb 2025 at 15:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Paolo,
>
> On 3/2/25 12:41, Paolo Bonzini wrote:
> > Currently, the instance_post_init calls are performed from the leaf
> > class and all the way up to Object.  This is incorrect because the
> > leaf class cannot observe property values applied by the superclasses;
> > for example, a compat property will be set on a device *after*
> > the class's post_init callback has run.
> >
> > In particular this makes it impossible for implementations of
> > accel_cpu_instance_init() to operate based on the actual values of
> > the properties, though it seems that cxl_dsp_instance_post_init and
> > rp_instance_post_init might have similar issues.
> >
> > Follow instead the same order as instance_init, starting with Object
> > and running the child class's instance_post_init after the parent.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   qom/object.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index 157a45c5f8b..c03cd3c7339 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -423,13 +423,13 @@ static void object_init_with_type(Object *obj, Ty=
peImpl *ti)
> >
> >   static void object_post_init_with_type(Object *obj, TypeImpl *ti)
> >   {
> > -    if (ti->instance_post_init) {
> > -        ti->instance_post_init(obj);
> > -    }
> > -
> >       if (type_has_parent(ti)) {
> >           object_post_init_with_type(obj, type_get_parent(ti));
> >       }
> > +
> > +    if (ti->instance_post_init) {
> > +        ti->instance_post_init(obj);
> > +    }
> >   }
>
> I'm not opposed to this change as I had a similar issue there few weeks
> ago, but I feel we are changing one problem by another. IIRC some class
> post_init() handlers check the instance correctly did something. But I
> don't recall any example in particular. The documentation isn't clear
> about order (include/qom/object.h):
>
>    * @instance_post_init: This function is called to finish
>    *                      initialization of an object, after
>    *                      all @instance_init functions were
>    *                      called.

We have five users of instance_post_init in the tree, if I'm not
miscounting. So we should be able to audit them all for whether they
care about the order and/or are currently doing things in the wrong
order.

And yes, we should update the documentation if we're picking
a specific ordering :-)

thanks
-- PMM

