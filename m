Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E0C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyGz-0005jN-Lu; Mon, 17 Aug 2026 10:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wvyGo-0005iS-Lb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:25:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wvyGm-0003i0-BO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:24:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso17287495e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786976695; x=1787581495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
 b=ynzBoogVXUKdBVVyrT/m/uIeOJffcHzE84+e1h43txBHPtsMr1Lq+gFMDPb6pW7WuC
 GE4Z7eY2VJu9c8tQ7WaHoHG1I6GWlOR1pwHGu+oKmbXeZV+HcBJScTXbrJhnGwBKnYGA
 9h3ri+rk+Bls9Qoj89+H0G9Ddrp5uH3CWRFbwrk2xa0xmCYMT7yKdK52V04BKW/0QFxV
 MzVU9WzSmpaV3wBtVpX9qq+t5EmRnp4KDjj36r+jl7PBq9l+ihqHeCSimloo3t9+oTFd
 jO4D78w8W+R2Z4UIsIjWwuu6VgFsZavCE5+xWj/fh4dO7kOZhSx92xl13WPOMlXnCH4H
 EVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976695; x=1787581495;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/DTqqG3V7U7WfD1BzSnvfO5TKElZ9Vr+nrizGyb2ukE=;
 b=QbUOaCwrAzuAD6/vCrPIgslcHodF2yj7E6Z696G/mX+fR53grvRc+LMhfWnk44B4VZ
 dvQVKd0BVJRLzbQcrQm4KF7e1d+l6/KIDexU7bj9rO6FdmLeR4XXlauehbTTcibfRFTT
 +Ed+cuCoapmQCrVajdKhqLOswm3eNCCoRuzFdoLfoZkJjHBab3TpFuSo0IDuKbeZpZxd
 ZLDkkH3Ae9/1DKwrNVx1Edckf6ZzFVSXwc5D8CTehfSOelkoNiGeSh6GOKjpeTnYukpD
 4tbEZZ/UWZZwI66ubl6QymPTPUzvLKh6AQ6Vv21mxnT/aOA+FiNtdyOHVcRDqlKj3/oi
 T2cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfSirdDRY/gOgEKTSBFifXVkrp56Ofe16Kf0lgt+RCfnMvLcewkrGqnsLni56VTb0brcs2eq13mEtH@nongnu.org
X-Gm-Message-State: AOJu0YzK14Go5gu6AconEwPR5S1DVimnfYpgQgtyPE+BsecbkcUdNfMg
 ORrcdGY36XYkSD0Xqihh041WK1LDQ5TuXJh28MomkPnfVT2+2iGlD/6YMz3VElb1e3A=
X-Gm-Gg: AR+sD12bCV324sJRfcYjWKgsfbd/8aVDEztKhX8mlJ+E1U+UtT80D1Mdn6Z2TAJe5Z0
 /TLtOefz5Kg4Skr6EQgwT/lphoXWzgVjR6rVDiAb46Knv0VtRqLWLerpDuxOvRdeaTIF6AlTdTo
 kFwfibWuw39FABIfZMQay56SYE1uamDuT7JX8u8LuZV777avLjFFEnkkFs75g/dUtRNZqe22jmi
 NBcddysXNOofKLQM3vh3rRqW/YlQ0i7/STNBn7pvB62pqAKVDok3lAt9Nq809XN0+hbfT1hbKUE
 4U3tpENK6gKoa1SIxkQ2MQsXRMHKSKjQ6Pluj0R1sC0+g+O7YlC86TJVERHD5tqo112V2PoCF9Q
 APUXNr4wL3s6TW1DWBq8LHLZyczl3JMj091brUA4dumHSd49wEv1toDb958WKmEhUD4RZLEhZob
 zi4ymhYF967tBTfQrU28cIOG+r2oLhs03dOOR2m4nKxWxCSs4JSQZA+wa3LItC
X-Received: by 2002:a05:600c:348b:b0:499:5282:f8d1 with SMTP id
 5b1f17b1804b1-4999fb76c29mr9022705e9.12.1786976694599; 
 Mon, 17 Aug 2026 07:24:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996183b89sm185398105e9.12.2026.08.17.07.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:24:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0C3B05F86C;
 Mon, 17 Aug 2026 15:24:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Huang, Honglei" <honghuan@amd.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  qemu-devel@nongnu.org,
 virtio-comment@lists.oasis-open.org,  dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev,  Honglei Huang <honglei1.huang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,  David Airlie <airlied@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: About new backend for GPU compute ROCm in qemu
In-Reply-To: <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com> (Honglei Huang's
 message of "Mon, 17 Aug 2026 21:44:21 +0800")
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
 <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Mon, 17 Aug 2026 15:24:52 +0100
Message-ID: <87pkzgsu2z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>
>>> Hi Michael, Alex, Dmitry, Akihiko,
>> Hi Honglei,
>>=20
>>>
>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm
>>> over virtio
>>> implementation to virglrenderer nine months ago (MR !1568 [1]). The
>>> ROCm side has
>>> been supportted by ROCm offical.
>>>
>>> Current implementation is a virtio gpu context type capset handled insi=
de
>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>> compute GPUs have no display engine at all.
<snip>
>>> =C2=A0=C2=A0 - that instance served by a separate ROCm backend library =
loaded
>>> =C2=A0=C2=A0=C2=A0=C2=A0 in-process by QEMU.
>> First, I think we need to establish why ROCm cannot or should not
>> remain
>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>> likely better placed to advise on that boundary. Once the protocol
>> requirements and performance measurements are clear, we can assess the
>> appropriate QEMU integration.
>
> venus is borned for GFX.
> virCL not merged.
>
> To be clear, I'm not saying virglrenderer can't host a ROCm native
> context it clearly can. My hesitation is more about fit and direction:
> virglrenderer has grown up around GL/graphics, and I haven't yet found
> compute oriented plumbing there to build on, while ROCm moves very
> fast and I need something I can keep current with low friction.

I'm unsure what the current development status of virglrenderer is but
it does see a continuing stream of merges. However the threading model
does make things tricky for QEMU when we are sharing lifetime of blobs
between QEMU proper and the virglrenderer thread. Perhaps there is a
better way to organise things?

Could we do the marshalling of VirtIO GPU commands into ROCm directly
inside QEMU rather than going through additional plumbing? Are the
sequences we need to handle more or less complex than your general gfx
rendering? How might this work with other frameworks?

>
> Regards,
> Honglei
>
>
>> [2]
>> https://developers.redhat.com/articles/2025/06/05/how-we-improved-
>> ai-inference-macos-podman-containers
>> [3] https://www.qualcomm.com/developer/blog/2024/10/vcl-virtio-gpu-
>> opencl-driver
>> Regards,
>> Akihiko Odaki
>>=20
>>>
>>> That reuses the existing pluggable backend model, a second virtio gpu +=
 a
>>> backend library. It doesn't add dedicated queues for
>>> debug/profiling currently.
>>>
>>> Waiting for reply and=C2=A0 happy to share more detail. Thanks!
>>>
>>> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/
>>> merge_requests/1568
>>>
>>> Regards,
>>> Honglei
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

