Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FDEC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 15:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk2tG-0007bW-31; Mon, 17 Feb 2025 10:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk2tD-0007V5-Tk
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:18:32 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tk2tB-0000q8-U2
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 10:18:31 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ded46f323fso5655370a12.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 07:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739805507; x=1740410307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2Y0zFfXopWu4WzN003ye9VQ5YyGl8LE3MEeNy82QtQ=;
 b=ilAHdoNl9KhC4jadz6N7qTAxB3jRm/npYzbOmhC7TGbukmcnkT/nG+YdRlzNgtcPas
 xOtaE71oqOGgcqbjU7tUEBE09u1wDd7eUDRNiv3CDsDVZ6yRZJwMucD0+MEG7YnjJ9gS
 6wcvIwLQ/en9DocQnkNt1UsXbsFV3OoMeX/sXTl2ZknP3vB31AvSbjajKDMMXpLF0pE8
 uDnpm+WWfaA/mi0aS7naxXnlZ/y/pxaKsfIZm95eb3tLJmuyFEeCP53fJY6gCQdn7VYi
 EB0lXXZ7Dj0zHNFqH50d85i0RdtS4Md2SqbbAaeHsMk9V85VgqLu6ID7Apcbg0IHE38L
 J6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739805507; x=1740410307;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K2Y0zFfXopWu4WzN003ye9VQ5YyGl8LE3MEeNy82QtQ=;
 b=AtvXNUAHQI8t1DpozKxV+C6QNfOsdSJQ4Epcb6bFoQ+Wele6FysNJqk9tItZf3kIvJ
 4XxCNa4Cgr4/FYBUblglLzVJuP1GIIzOv3XKg2JAz9K33saaKT06uKOgQ4fwe4rhBder
 LHey54d/BhV6WMIvMvUCr43cXTwukbQ8/uQXx5ZD8nUHx74h0wcxtee3YXYA7GdJYo37
 cq+qdny9+M7Gt1bRLQHNMALh1R1t+5EZiKg3ljyaKdWAkMGMhxT3OjQjR4boYYfuiKZv
 OX3MQxKb59fHE5+cTS6xk01lP+IGKHXUPWdnRqNXbMdD7RgJ0eqOtlObyo9N7rJd1pmu
 sGwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzEFT++agrvZMwA83iRPPNTSUet46UWUduYuRXTSaELTDjZOXA+4C53TgofH5szvpL/D5VivgZ+tDe@nongnu.org
X-Gm-Message-State: AOJu0Yxef0L3HrNWrFBqRmRDTq8zGGOqCWLT+ILQYE5sl3C/wcftn9I5
 et2hlAM4NLQTp0C5gLpBGEdBh/N86liCWqAbcIIsvHY9ixtbce7KFsHboiFVJm8=
X-Gm-Gg: ASbGncvtY+SxUcOsvJ/qI4bg5SaCPD3XevCoSYeV6WXcjNqQBYUzXyl/0Sy/zIpsH59
 Ng8UjLGapMrH3UKZbeitWytBCnGCC/NEQKA2+dEnP9rZHfHu69V/XUUlUZXm8mp8vEz38bFQ8ji
 B4Y7+Y6V275WTn3RgBm/nfTz62eWdijZNc2T9n55D0AM87xaWzHPDht3ptDn2DJkY3fvmc5y9ts
 xZp+Yk72rECCfYr8gNgLOJq7OkXiycKYzyMW2GHZBPVuZnC0oskByNN8J04yIm65Q4hTyE3Vifq
 eKuMj2m/V4OWQANt7g==
X-Google-Smtp-Source: AGHT+IGVeweK40fYZr2FdYlgJSSL3FNMKPqZC3VvwUH4Hrl1nMkqoMdnfF1JkcZEHfQ/crfbMYyhrg==
X-Received: by 2002:a17:907:1dd6:b0:abb:b1ce:b4f0 with SMTP id
 a640c23a62f3a-abbb1ced563mr55800566b.4.1739805507160; 
 Mon, 17 Feb 2025 07:18:27 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb88c69c1bsm365736266b.110.2025.02.17.07.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 07:18:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7A2A35F936;
 Mon, 17 Feb 2025 15:18:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org,  Gurchetan Singh <gurchetansingh@chromium.org>,
 Alyssa Ross <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?=
 <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Rob Clark <robdclark@gmail.com>,  Yiwei Zhang
 <zzyiwei@chromium.org>,  Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH v6 00/10] Support virtio-gpu DRM native context
In-Reply-To: <18bb7aa3-93cc-4a38-9641-31e6e988c64e@collabora.com> (Dmitry
 Osipenko's message of "Fri, 31 Jan 2025 20:13:35 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <87cyg844fr.fsf@draig.linaro.org>
 <18bb7aa3-93cc-4a38-9641-31e6e988c64e@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 17 Feb 2025 15:18:25 +0000
Message-ID: <87h64slhvi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 1/27/25 19:17, Alex Benn=C3=A9e wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>=20
>>> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>>>
>>> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
>>> DRM native context [1] mediates lower level kernel driver UAPI, which
>>> reflects in a less CPU overhead and less/simpler code needed to support=
 it.
>>> DRM context consists of a host and guest parts that have to be implemen=
ted
>>> for each GPU driver. On a guest side, DRM context presents a virtual GP=
U as
>>> a real/native host GPU device for GL/VK applications.
>>>
>>> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>>>
>>> Today there are four DRM native context drivers existing in a wild:
>>>
>>>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>>>   - AMDGPU, completely upstreamed
>>=20
>> Well good news and bad news.
>>=20
>> I can verify that AMD native context works when I run my Aarch64 guest
>> on my Aarch64 host with -accel TCG (therefor avoiding KVM all together).
>> I get potato frame rates though (~150FPS) although I suspect that is
>> because the PCI errata workaround.
>>=20
>> When it comes to graphics memory allocation is there anything I can do
>> to force all allocations to be very aligned? Is this in the purview of
>> the AMD drm drivers or TTM itself?
>
> All GPU allocations should be aligned to a page size. Alignment is
> specified by AMD driver. I don't expect that alignment is the problem.
> What's the size of your host and guest pages?

4k AFAIK.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

