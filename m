Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC8FC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtJa-0004eP-Kb; Mon, 17 Aug 2026 05:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wvtIv-0004Ei-CB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:06:52 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wvtIt-0001le-8H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:06:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso35390305e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786957601; x=1787562401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3ngolhcvbMqLUeFoPbLYsoQGaTEjccLb93LdN0z4Iq0=;
 b=Qi6U2Px19dgutoAAhmJZYsUwg11SbLojlHhqf28xDpBPeBMFOa9rF2j93X0aRjH9hI
 QRMKNYT8N6QSauX07Kk57BvO4OqojkZ6N/qcdKlcGPmTw3xbRLZbtY58DJMgshtu+EMo
 r/qwQseLUNf368ppQpgU4Et+UzCG47Y6z3CcD1PQ5eVHyTAmf5owl/FveoZxqKOmE5OL
 t5eBsiGxDX/ZSPy9GmbSU9Pbh7fFtylZHJcoGQzkjnZrRA0pgXUluvJzZwwiRf3gbkxC
 1116qt1vbt61utfZjxm8DLUJwnTucX0u2bgWoblKDfzkD1mABKHfSIpGyHdMRGKD7CP1
 5XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786957601; x=1787562401;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3ngolhcvbMqLUeFoPbLYsoQGaTEjccLb93LdN0z4Iq0=;
 b=i/FwIYktmbZMmmuGq+suZ2sz99TVb/K1xhOzwMOfHLkP50Aq0FBgGIb6UKazNU8RSL
 yQVrR5LXvrNyi/eqIn20t823itt4rExqvVgfJvwp5v3ZkFbKcxGHA9mYwDmyUml5Cuqe
 TSFIMsnmBO5tTvb3oFHTuEtx8eGxIbBNNQ8ypsIPwQMidc8mi8NYl5v+uLysQjMqxauY
 63kpRhWV5CX/f6tyBdju47MNbe4YZFCBjgYbzABD2TYm4JSKXRGvHa28Hz3eSITD2gYL
 yzloNdO+LIrxOvEzTUww2SSrNJ2J2H8EW1SI2Q+/CyDzNGLiiF2AFKbA6E9uUfODfo5/
 Gung==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMhIZVyllZHcJdziq0jOr8hcP5VqxjO+/urjhTxDpZgEmVbusm9UygVipRS5Prbh1dy0dJYKfZGA7v@nongnu.org
X-Gm-Message-State: AOJu0YymeziwrnwCUiqCj05U4ty9b2sPKTVeYOny1qRg0wngw6GsLI5T
 g3rFeZ3N2x4hG+qxzfoAzQlb+cuhQ14Vb91rwIUoAudE2wJIUuab3Oa33SNXwEGbpRA=
X-Gm-Gg: AR+sD10G4C+NJEgr399r7SPVkz6nlkBtiK8M1RMkM2dIeaHix17M7uG3lLA6RptFhUK
 VWZ0AQxNNbCSxXyp5rpttq0CBD1OoL/Kxhk33h2Fd9IWkY5+QnihPyAKfO6PRx1Tq288vWfRory
 lm8Uvz2NuvqlzV5fdIeTAHt6th+SgDOVkqXyfWizf4HqaGlmt+gJJpG9IGx5SLk3Si+6AVr2ssv
 oOXrbIrOLaLBqr3+/EsX6/jbBH1RTRLoNu4uLnPoym4fbIwTVPbg3OtzvHSguFuFZN0ip32axlP
 7FBoEsI0FA46UDSLTz+VC94TK1qjuL7mPewjlwQuhH2P8FOCnzoG+lBZ5g88mzwcA2QBbSnZr+T
 UcUZicvFl9EL7U/j1XrrGmhxj6LY+CxJFycjxiqkHeUdwOV3zSCR6KfI87ye1vS47/G483gcJrY
 s0VjOpP64Hw/tYzAXpciaYLHq2HE8Bot1tWOyL1iwigfgud6lVCgJ+3frs7P0j
X-Received: by 2002:a05:600c:820d:b0:499:7a36:88b with SMTP id
 5b1f17b1804b1-4998794402emr411655325e9.5.1786957601263; 
 Mon, 17 Aug 2026 02:06:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb872sm34734505e9.9.2026.08.17.02.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 02:06:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F3B55F86C;
 Mon, 17 Aug 2026 10:06:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Huang, Honglei" <honghuan@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  David Airlie <airlied@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 virtio-comment@lists.oasis-open.org,  dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,  Honglei Huang <honglei1.huang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>
Subject: Re: About new backend for GPU compute ROCm in qemu
In-Reply-To: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com> (Honglei Huang's
 message of "Mon, 17 Aug 2026 11:19:44 +0800")
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Mon, 17 Aug 2026 10:06:39 +0100
Message-ID: <87v799ru8w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

"Huang, Honglei" <honghuan@amd.com> writes:

> Hi Michael, Alex, Dmitry, Akihiko,
>
> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
> over virtio
> implementation to virglrenderer nine months ago (MR !1568 [1]). The
> ROCm side has
> been supportted by ROCm offical.
>
> Current implementation is a virtio gpu context type capset handled inside
> virglrenderer, sharing the display path. That's an awkward fit, many
> compute GPUs have no display engine at all.
>
> Beyond that, sharing the display path is increasingly painful:
>
>   - Compute hammers the queues more than graphics, so sharing
>     virtio gpu's single control queue with display/virgl causes contention
>     and display stutter.

Is this just due to iteration? From a layman's point of view I'm curious
as to what the queues are doing.

>   - Compute contexts need far more blob / shared memory than a display
>   one.

I guess weights and context are long lived blobs compared to rendering asse=
ts?

>   - Maybe needs a wider ROCm / compute stack, cause the render model
>     fits poorly:
>     rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth streams)
>     and ROCgdb (wave control, address watch, async exceptions an
>     out of band channel that must not block display).
>   - Events, faults and GPU reset/SMI are async and don't map onto fences.
>   - All of this is hard to extend cleanly inside a display capset.
>
> On the QEMU/host side, would something like this be OK? One step, two par=
ts:
>
>   - a dedicated headless virtio gpu instance for compute.

An oft-asked for VirtIO model is virtio-npu but I wonder if there is
enough commonality for a virtio-compute device with the same sort native
context type handling to deal with the those that want to have guests
targeting specific hardware rather than going through an abstraction
like Vulkan Computer or OpenGL CL.

>   - that instance served by a separate ROCm backend library loaded
>     in-process by QEMU.

Is this library a binary blob or open source? The last time I looked at
ROCm I had to give up as my AMD card was in an Aarch64 AVA machine.

> That reuses the existing pluggable backend model, a second virtio gpu + a
> backend library. It doesn't add dedicated queues for debug/profiling
> currently.
>
> Waiting for reply and  happy to share more detail. Thanks!
>
> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1=
568
>
> Regards,
> Honglei

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

