Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9042BC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcRnf-0000Kz-DR; Mon, 27 Jan 2025 11:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcRnb-0000KY-9G
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:17:19 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcRnY-0001vV-Q6
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:17:18 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ab34a170526so773402966b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 08:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737994634; x=1738599434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXJJq+BSmBpgHQ8o3SSzoAdmWb/+j11yRdzWZ8g4Ih8=;
 b=AmOww7RahACzU164ZX1zs7h/sIOhQPvIhfl/MmvnQPoGlryu+Jj6jTe6ET3EVum0J8
 UYIoLVJ1uhIiZ6FvyqSYba5+NLRlJrzqfkSIHgvL8bpZDAhSwdB7Ko100AChfLP0dRMe
 vbBqxQJwjuv1/gXUoqvEw0XoMlTcbeXH8Im5id0h9Ww6JMtAuxjsQqfyCUiIaAZzhjP6
 ohKVHoOCu47m3Wsi3vM/kXigEm3gqX/fsWHqFs4MJOQ+XuBk9lbHEiUx07OArQv8srSQ
 /xwfj1MHULc2rS++mRGjQW2B2IrqZ7RQKbIx5RfLupvPdylD0iMyvkcImz6ZGjlXXtsT
 +YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994634; x=1738599434;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AXJJq+BSmBpgHQ8o3SSzoAdmWb/+j11yRdzWZ8g4Ih8=;
 b=IlK6eudO1BhkbuGmcPrsbuEfFj4Pv/syylJHLjDqARmITY4sxNBVjSNrHz+QkKyp8F
 Ab2nShceU7JgEC7+WcAoeqED6ekBp1WABVUS+hCT3513LbStO3XqMGfq0eqo68VyR87+
 boF2kyBwieiH0/DQJoSmjfWiL0N7QumSHl9aXivmn6ZSWa1cSBkP3O7zY4jUuCzjzMZF
 gni6A+H4Av2KrIzN1vg9tpxIFZfT01kSwbYHFiw02qCkFCO1LnM2Lvqv5V0xnq9N1Chh
 Xr/X2yG1g3wjMUH56IT/H8olU6CJxv/fqPePDblP83orq7cFxSB+Hv7UjOl5T7xOLCIe
 iNXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDVe0ATHlKjEtEvDwGO9HlGISMYkFcv2w+BYaqEEwMK7HKa4n5wLVwSuz/YQ9ha9nMtSokw5npemXT@nongnu.org
X-Gm-Message-State: AOJu0YwDEM2xpAPAtF+/mK9d9GCGoDZEuHytTRb7RI0v1zYkVsI8+H9h
 kls3T+fl5l8OHvWZS14Urr7gCALet0xpiZRktc6ws9gYuwITgRWZXhWpayux2EY=
X-Gm-Gg: ASbGnct3rCxEOB4i3D3+HQ1n4wzDZO54pnzzy+FRD/aNgh3qstnNdLBG9u4/COoB9hD
 pEGgyPoJ6DHzYgsBcUvMpbaBYbpCzm3A+/xSsN4DC9bJRZZx0fSX0tnaOe3Jmz43IE/mZJ7PUDJ
 g1lC/9ppoqkPc4eyBg1OCxmhidUOYDp6EihgzEcBkjPk+MjK4O/5r5eT+CQtm5tCL6MA2gIkWMo
 6Pgx1MNHdGbGym+mXTwkuJ9OojcBPf6qYx+hR00ttO1FHM+ZwmL1W8y+DcjCxzdMnl+ZpNfws+s
 oQs=
X-Google-Smtp-Source: AGHT+IHsiuzt5cHJQF4iRZJzLB/WJNPBxVuFP4qUjPFGwyil3aNaMhA2KCj2aWu2fqUO1tY5Rnxf0Q==
X-Received: by 2002:a17:906:f58c:b0:aaf:8f8e:6bf4 with SMTP id
 a640c23a62f3a-ab38b16333bmr3375752866b.26.1737994633812; 
 Mon, 27 Jan 2025 08:17:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab69933f976sm309944466b.51.2025.01.27.08.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 08:17:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2F6AE5F7CB;
 Mon, 27 Jan 2025 16:17:12 +0000 (GMT)
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
In-Reply-To: <20250126201121.470990-1-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 26 Jan 2025 23:11:11 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 27 Jan 2025 16:17:12 +0000
Message-ID: <87cyg844fr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> This patchset adds DRM native context support to VirtIO-GPU on Qemu.
>
> Contarary to Virgl and Venus contexts that mediates high level GFX APIs,
> DRM native context [1] mediates lower level kernel driver UAPI, which
> reflects in a less CPU overhead and less/simpler code needed to support i=
t.
> DRM context consists of a host and guest parts that have to be implemented
> for each GPU driver. On a guest side, DRM context presents a virtual GPU =
as
> a real/native host GPU device for GL/VK applications.
>
> [1] https://www.youtube.com/watch?v=3D9sFP_yddLLQ
>
> Today there are four DRM native context drivers existing in a wild:
>
>   - Freedreno (Qualcomm SoC GPUs), completely upstreamed
>   - AMDGPU, completely upstreamed

Well good news and bad news.

I can verify that AMD native context works when I run my Aarch64 guest
on my Aarch64 host with -accel TCG (therefor avoiding KVM all together).
I get potato frame rates though (~150FPS) although I suspect that is
because the PCI errata workaround.

When it comes to graphics memory allocation is there anything I can do
to force all allocations to be very aligned? Is this in the purview of
the AMD drm drivers or TTM itself?

I'm still seeing corruption with -display gtk,gl=3Don on my x86 system
BTW. I would like to understand if that is a problem with QEMU, GTK or
something else in the stack before we merge.

>   - Intel (i915), merge requests are opened
>   - Asahi (Apple SoC GPUs), partially merged upstream
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

