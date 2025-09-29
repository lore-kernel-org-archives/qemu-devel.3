Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0988CCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F6w-0005Py-M4; Mon, 29 Sep 2025 10:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F6n-0005Og-VL
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:44:12 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F6f-0002A3-Is
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:44:09 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d5fe46572so64427647b3.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759157029; x=1759761829; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T2r0TdizdduB9sJCG8TJu6Twt1PSisV8cqib/uyB1ig=;
 b=cz2bnIDmfigJxKCLeFn/SoLionyBh/O/fnweUbgBl2ue/ImTOSb1PSkuaDywS2hL/m
 JMCz4sNpkbOk9OVe2Edsm4xoRvsi+wdqkDUYQnz5wbEPpaJbnttYheQb/KpQb0ZOFmVi
 /wNS4rSVy6JyDH1z8FyfYFGH09E3n2rixSpOFGBKA7dLEo3iOlrYizlhvwKPWFAikPeL
 YlBPCvK4l0koAW+Kp7SGhKZXRFTXvY73OFGhxIjlh54aQDc+363gir+vT726S6dj5t4F
 NDsQROcAoUyHExY6kUQQrFUgvbbBafzYVYg4DGqUMdW+wrZusFT+BOp91e/gnHdB0lR7
 IeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759157029; x=1759761829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2r0TdizdduB9sJCG8TJu6Twt1PSisV8cqib/uyB1ig=;
 b=fdPk+UlZfUcmgU3b20dfe+L3h7hVub4ZK24pLT71FjUjwRxBo78m1ZFvFjIacK0xsj
 aK6TrkW4/LTonlTxcJYvNVzt8jGkVGX3dqEzHZOnw5xvrIvjJfLLQsgkqIPo9ZfJYztX
 fWZd8RuemFK6DdBkHMgeWQ6OXbUO5VYh9wuixB5mTUaDK3hKi/q9iIY1RhmmuJHBzz65
 e41p3ewEcN3Fx8WiQFwC4kyC98qbiv5yOoUDyedpq7YOxuqVD+tDmmdQNacCyhL9OBvj
 bjdA5cuLx0Y9DeTXvefAMGLEgtaj16SE5tYd0wI87Vh2o2LF69EVqkMqI5MbxESf6Tq5
 w98A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOMyuz8CyEyvbPD602EjITtunwjKj/Z0RZanzFznzVgX+dU219jcTxoCsiQ9SmLDex1NFPPFX0X5pZ@nongnu.org
X-Gm-Message-State: AOJu0YwTonwM4IYGwl/1wIc/4GctT40kbbLqtPHg+4oAegNJ4U4yxZUp
 By8mD6cVeEuGP3qoOnNvwLj6LGXduItLN2gK1l+NNAiIYapluTz+lMOgqkJ+CcDGGgauqfHtKvx
 aKQRBr8sDqnu1jBgKFyeyT7rdELrxQgLw5LV2xSHUFA==
X-Gm-Gg: ASbGnctafFURKH62wCm2tNiXyKR9TjSGawBAUzhdQuVlpimNS9JjCP8k8CZED5oh3KQ
 o3JledVpga6lDxivJNh30SbppJe8UGuzOiUjLUnnUasf6L+8oSbepmE2HJmz9B+pf7FszgIvy9N
 Ah1ybfs9XSvJSxkdA1aj5lwUd+321hOxn/GgaKCOtk360tIn+FuJQt6nAj7A+GipRWj6pc7E/S1
 cTPeVXkqavL2/d0uPc=
X-Google-Smtp-Source: AGHT+IHJFrLUjQtJfpVqcJ0wc3OCvD5p70oQcDKJR21euyIFj4C6MWG8LnK274bcr/AWoPPFBCtjrrAox2zN+lLFKPw=
X-Received: by 2002:a05:690e:287:b0:635:4ed0:571e with SMTP id
 956f58d0204a3-63b59af8420mr664929d50.22.1759157028998; Mon, 29 Sep 2025
 07:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
 <aNWgnBV-9p6UnsYT@x1.local>
 <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
 <aNauXSMiP0LUWQ5J@x1.local>
 <CAFEAcA--K0=EJNNvj98i=ewGY=tN3u4S0+fNb9kJpYynzjHEhw@mail.gmail.com>
 <aNqZrEagWEQ-up-Y@x1.local>
In-Reply-To: <aNqZrEagWEQ-up-Y@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Sep 2025 15:43:37 +0100
X-Gm-Features: AS18NWD8Dv-uv8x5PQVqYiwqES4wdrheCMnk1Z_rdHc7r_M121cGK4esseeJKGY
Message-ID: <CAFEAcA-5BFKJZv964OgR-oatEMUTdEd-z0cggkOyB0HC4HkDmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 29 Sept 2025 at 15:37, Peter Xu <peterx@redhat.com> wrote:
> On Mon, Sep 29, 2025 at 01:45:05PM +0100, Peter Maydell wrote:
> > I figured out what my problem was here: like the existing
> > cpu_address_space_destroy(), it wants to first destroy the AS
> > and then free the memory the AS is using. So it does the
> > obvious thing:
> >     address_space_destroy(cpuas->as);
> >     g_free_rcu(cpuas->as, rcu);
> >
> > This doesn't work, because address_space_destroy() sets
> > up an RCU callback using the 'rcu' node in the AddressSpace
> > struct. But then g_free_rcu() tries to do exactly the same
> > thing and overwrites the info in the 'rcu' node: so we never
> > call the do_address_space_destroy() hook.
> >
> > (1) Is there some way we can make this "tried to use the RCU
> > node twice" assert?
>
> Good point.  Maybe we should assert node->func==NULL in call_rcu1().
>
> >
> > (2) I think the simplest fix here is something like the
> > patch you propose that does the "destroy + free" in one
> > RCU callback.
>
> Yes, I agree.
>
> Note that Akihiko has another series to QOMify Address space.  This problem
> should be relevant there too. Currently I believe it's similarly broken in
> his series, but I think maybe we should fix this first on x86/arm hotplugs.

Yep; I've just sent out a patchset that tries to do that.

-- PMM

