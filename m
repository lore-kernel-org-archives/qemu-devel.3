Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C1AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBu1-0007iS-Al; Thu, 05 Jun 2025 10:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNBtz-0007iG-6Y
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:49:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNBtx-0000mT-2Q
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:49:06 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-60727e46168so1614532a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749134943; x=1749739743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y61MfMWBbSElkqB7wWRk7kLD7Hhi736GzVo4lvOVLTI=;
 b=AqnOBL/5nU1u4Bx0NA9NL7tbcFMNCr5OsF1N9SpLkZ0xJltPzuk8WBs7Fin9n4qlsO
 D6QQH2WvL3/M7Qcy1IDkDJMJ4x5/kBrYaY2mFAuAmWGTcCDc9+TNMHaWx42bbHDWlXBN
 Xi9hrcOtB5BoPedTkoPJ4mJD+9RU6136ZUEWKCyw5xMgnI4fosCa4t3DVyB09vsQIxi3
 ZR1ZBmKhkNMs2v06+FMlXbdxTCRBtK0SGoKD10VTCjo/4GkJjFijbEbhDkW6VJBr9MEw
 e7PA16P/bGCgutdnAYR7blOjWq/n6en2cZ0C6OILp+RNcwnAXJ3EqlWGtL0UTFeUh6qA
 5FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749134943; x=1749739743;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y61MfMWBbSElkqB7wWRk7kLD7Hhi736GzVo4lvOVLTI=;
 b=EoVz0YofvuXVjy5EJx/YuEEQmdk0bk/+TAAkC4EI/e/HOome9QvvKMVcVEttKEamoB
 ChKR8L7i6An7KtCK9o4Xs44eUS7oMEkHL6PwVyiODD4IABpjjQGYPO6RFwHxM5z1537p
 Mu/xYb4kzS+Cd5c8i7oLtCMFftBrCxS/ZmxxBbPTrCoj/iEGLi0yH3ZHQO5QLGwQrtec
 19b2ipwR1cf5amh1vSe1SiG++Lb5t8Xu24Dy59tVfASiTWiP9+IvCpVSEhXXgNAv37uo
 8zWkt4PpTrB2nDKjS5FYjQ2DPqOrufNz3/yiZY19JOxKVJz3DyGBKwCAZhCteggZZjpR
 LsMA==
X-Gm-Message-State: AOJu0YwXzOfXEsQ+Yotq8nPg9ttOdPHppvuOILb4gnHh/yZIl3UbTrlI
 c+tp7xPKC0TweMiYZgUg75jKggMEjxyGxxVcO7TdisoiR04aqxBpxlyD63XCAiL2BPw=
X-Gm-Gg: ASbGnct70rMATP/nhGzfWdq2pG/B7LLo7xJ4KwEYI+hTdIu9uxIk1njGFGQx3EgDcmT
 jIDDavZd78P7nAbbAywMmUeO1A5s6nkD4sYjEUeEG7AxXSwxskcpkhDQ6ZsnHZcMxp9hCRV51DK
 OP3+1+H2zne+fp1mLqC3qPKozs7wizwuhP7Kh1Vdil/F9SQ5076iEcZgtC9Jp4ZJlYPgw72OCsJ
 hSEmrm5w68kNzUrNyfsVvL11lNWeA9DC09zwxvf4o7Ci9M5yYPo+Cw1F3PtFHlIgPChkTuqbHbR
 p5ZcmPCnMWr7Jd/GcGVEtQhJhMf945RoGl/6bDNBkYK+NCSwO03xAfvFdjiuDsQ=
X-Google-Smtp-Source: AGHT+IFQV6nGWVf1X1erklSrZiLj9tKq706Lwe/xTLlaA02ffEtkpM2PFHOkHsjpBVyIbSXGpxR3sQ==
X-Received: by 2002:a05:6402:350e:b0:607:6324:8da2 with SMTP id
 4fb4d7f45d1cf-60763248e5cmr59580a12.24.1749134943038; 
 Thu, 05 Jun 2025 07:49:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6073184a7dfsm688509a12.9.2025.06.05.07.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:49:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ABB1E5F782;
 Thu, 05 Jun 2025 15:49:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Frediano Ziglio <freddy77@gmail.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>,  Dongwon Kim
 <dongwon.kim@intel.com>
Subject: Re: [PATCH v5 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
In-Reply-To: <20250529051352.1409904-1-vivek.kasireddy@intel.com> (Vivek
 Kasireddy's message of "Wed, 28 May 2025 22:11:11 -0700")
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 05 Jun 2025 15:49:01 +0100
Message-ID: <87seke5jmq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

Vivek Kasireddy <vivek.kasireddy@intel.com> writes:

> To address the limitation that this option is incompatible with
> remote clients, this patch series adds an option to select a
> preferred codec and also enable gl=3Don option for clients that
> are connected via the network. In other words, with this option
> enabled (and the below linked Spice series merged), it would be
> possible to have Qemu share a dmabuf fd with Spice, which would
> then forward it to a hardware or software based encoder and
> eventually send the data associated with the fd to a client that
> could be located on a different machine.
>
> Essentially, this patch series provides a hardware accelerated,
> opensource VDI option for users using Qemu and Spice by leveraging
> the iGPU/dGPU on the host machine to encode the Guest FB via the
> Gstreamer framework.
>
> v4 -> v5 (suggestions from Marc-Andr=C3=A9):
> - Fix the errors (mostly 80 chars limit violations) identified by
>   scripts/checkpatch.pl
> - Rename the globals to have a spice_ prefix for consistency
> - Rename MAX_REFRESH_RATE to DEFAULT_MAX_REFRESH_RATE
> - Added comments to explain how/when the gl_draw request is submitted
>   to spice server in the remote clients case
> - Fix the mem_obj leak that would occur when the associated texture
>   is destroyed or when an error is encountered while creating a
>   texture from an fd (Dmitry and Michael)
> - Merged Michael's patch to fix the mem_obj leak into this series and
>   added his Co-developed-by tag to the relevant patches
>
> v3 -> v4 (suggestions from Marc-Andr=C3=A9):
> - Add a new parameter to make max_refresh_rate configurable
> - Have surface_gl_create_texture_from_fd() return bool after checking
>   for errors
> - Remove the check for PIXMAN_r5g6b5() in spice_gl_replace_fd_texture()
> - Report errors in spice_gl_replace_fd_texture() when someting fails
> - Use glGetError() correctly by adding an additional (dummy) call
>   before checking for actual errors (Dmitry)
> - Add a new patch to check fd values in egl_dmabuf_export_texture()
> - Rebase on Qemu master
>
> v2 -> v3:
> - Check for errors after invoking glImportMemoryFdEXT() using
>   glGetError() and report the error to user (Dmitry)
>
> v1 -> v2:
> - Replace the option name preferred-codec with video-codecs (Marc-Andr=C3=
=A9)
> - Add a warning when an fd cannot be created from texture (Marc-Andr=C3=
=A9)
> - Add a new patch to blit the scanout texture into a linear one to
>   make it work with virgl
> - Rebased and tested against the latest Spice master
>
> Tested with the following Qemu parameters:
> -device virtio-vga,max_outputs=3D1,xres=3D1920,yres=3D1080,blob=3Dtrue
> -spice port=3D3001,gl=3Don,disable-ticketing=3Don,video-codecs=3Dgstreame=
r:h264
>
> and remote-viewer --spice-debug spice://x.x.x.x:3001 on the client side.
>
> Associated Spice server MR (merged):
> https://gitlab.freedesktop.org/spice/spice/-/merge_requests/229
>
> ---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Vivek Kasireddy (7):
>   ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
>   ui/spice: Add an option for users to provide a preferred codec
>   ui/spice: Enable gl=3Don option for non-local or remote clients
>   ui/spice: Add an option to submit gl_draw requests at fixed rate
>   ui/console-gl: Add a helper to create a texture with linear memory
>     layout
>   ui/spice: Create a new texture with linear layout when gl=3Don is
>     enabled
>   ui/spice: Blit the scanout texture if its memory layout is not linear
>
>  include/ui/console.h       |   3 +
>  include/ui/spice-display.h |   5 +
>  include/ui/surface.h       |   1 +
>  qemu-options.hx            |  10 ++

Aside from the qemu-options we don't see a lot about SPICE in the docs.
Could we add a section to cover the configuration or maybe just expand
system/devices/virtio-gpu with information about how acceleration works
with remote SPICE viewers?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

