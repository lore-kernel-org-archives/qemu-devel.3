Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB4DC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcRp8-00018T-7b; Mon, 27 Jan 2025 11:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcRp3-00015h-VC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:18:50 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tcRp2-000210-9g
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:18:49 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab69bba49e2so243382166b.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737994726; x=1738599526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NllUBgEBZxHqpiSwCHDJJXUJfmvp0DPqaPB0zddBIvM=;
 b=hIyWqxo1YZb7rt6eBRCyGttKWeRqBqQzkQHWFC0afNs8FNRAAf+Tk+/cjiUFXFkUhd
 1T3GkErX04uUOB7CxFyf+j3AA8lbxz4+UWGCRFvYTNqiPPRwimgt87uSZrShRBABi4/l
 3LcydOmQycBF4UeHCEfnJ3Yj463qvzVoPs32BWQeTcGXN+SUIdPqnl2dDJb1j45pneYj
 TLTvsI1FSS1KZFsrG7wt0+gMBKkunpE6lVxtuZ+mlLFUecVyQ1J42bNCtgbtaiFHF9iH
 0ffwD0WNYZsYpG+O7XxPerI2F0bahlg7kTZwtL2HFe2QJoyUAXchufZjYPFx+D92D6ol
 rLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994726; x=1738599526;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NllUBgEBZxHqpiSwCHDJJXUJfmvp0DPqaPB0zddBIvM=;
 b=PMFFZ3sP1694803PLrUG7pgfHqC4BUIAr1bmM5JQf8T+JjORnHnolmBONdGsL9Tx7x
 P4LnbT+E+ePcX7gwv65AX6L/HLRyWZ4KGowQkuE7RRw+1RF+weBYYvZqeQhne/zUMe+T
 FtoRRIPnA+OWe0Lz+317cqU15pF5YYioiXrJkmLL8uYR9hghSVyhnNQ8o8lW14vy2bzi
 3FYhBTWw8Dv2R6YqT3/60ugwrwUsTD6bitJ8PZesGcaCTChVtj0O1QNyuNQwfyvrm+hM
 pugbI3kHylJ3T5zzyBDQLcNGCRuh0bKcPrExNLvNl/oe5w3/b40FBnL5JVJ4J5rNWPA6
 UcJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW3WB5cpFen1iAsNw0sNVTa5KPqx9PN1SUfhvg2u7upuF8yeyRlcwFjhYEu2xRDTHk89lRh3HfpgZb@nongnu.org
X-Gm-Message-State: AOJu0YyYojv8Y/CSJb26yqQ7podRC5PAGw804DfzTxzMsg1Y+8dV6W2J
 wd9IX1Pj88s24/oXUWaXrkfEQhI6m1hX0p2chvRFW4MFaHBxnhdQVBCMw7OI5h4=
X-Gm-Gg: ASbGncsqVSFxEgmMxc8x+p+s8dY8aqfW8w4CI/369q5yF2Ur0heFPjQI60KGDj2SyL7
 UNEXJQwrP0UlrZZaAdNtBRfJah/sDoWobwlcZ8w5M9A1JdQYbuLMj8nuwnIC7y7Jdbet0P1RNCp
 qMLxe2t5UGftHuBDNjPegXOe0lhnvpGaynQghy4F9qlmvvexQ4Fn94WdeFoPypxmq0JgnNNma9B
 o8UoUIFY0KTnp4SCzXY3sfQq++sQvWTS6HJGB9LZmOLOnV2nJbsfskrIkgVQv0G708z8Wai7bVP
 OOk=
X-Google-Smtp-Source: AGHT+IEJTCnKdByTXqtiBlXfv7CwN/2KryTnM6Fqcvobi7QNy2HvkExEpeI/aBHznJyOib8FwKjDKA==
X-Received: by 2002:a05:6402:518a:b0:5d3:ba42:e9e3 with SMTP id
 4fb4d7f45d1cf-5db7d2f5ec0mr101636509a12.13.1737994725970; 
 Mon, 27 Jan 2025 08:18:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dc2ea16e7asm3167544a12.42.2025.01.27.08.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 08:18:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA89B5F7CB;
 Mon, 27 Jan 2025 16:18:44 +0000 (GMT)
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
Subject: Re: [PATCH v6 04/10] virtio-gpu: Support asynchronous fencing
In-Reply-To: <20250126201121.470990-5-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Sun, 26 Jan 2025 23:11:15 +0300")
References: <20250126201121.470990-1-dmitry.osipenko@collabora.com>
 <20250126201121.470990-5-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 27 Jan 2025 16:18:44 +0000
Message-ID: <877c6g44d7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

> Support asynchronous fencing feature of virglrenderer. It allows Qemu to
> handle fence as soon as it's signalled instead of periodically polling
> the fence status. This feature is required for enabling DRM context
> support in Qemu because legacy fencing mode isn't supported for DRM
> contexts in virglrenderer.
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

