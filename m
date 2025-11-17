Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E49CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 05:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKsEM-0002pb-P9; Mon, 17 Nov 2025 00:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vKsEK-0002ov-I0
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 00:56:48 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vKsEI-0006F9-SH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 00:56:48 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b736cd741c1so401599766b.0
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 21:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763359005; x=1763963805; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RxNm03b5xtibms/VZqYHKyahpCGLpr6A87TWKYMwtNA=;
 b=TifvB1AkZB2dy2zOAEHyc4TMJ6bCDgbFfBs9xrw9n1wnp8vGBTsO/wZrIAAGF4uMJD
 TPI3UaIdy6qXtMTqrsjFfeDkZm63gmoFkfrKgZFbezhgOkk2rTCMwQ1cLAwAQy2J0hC7
 dE1ByEmQnd9f5N3nDH+fuXFxRXRR7D8oYJuad18GZYDCtIno84O+7kpvf9W4dK0Kn/Nu
 qUNm2jBQ2yb3YwMiFVGp04nOLSILYVZqrNlnvQlJoTulQDiO5PX8DgBpAbHiZCuFqx/B
 NCL4FIeW61dawv84am4yOYH306TfzMY5HrtEpZ+m1IhuHlIM86/czLVmdR3CJ4v0UOzV
 2q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763359005; x=1763963805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RxNm03b5xtibms/VZqYHKyahpCGLpr6A87TWKYMwtNA=;
 b=TjJE2UaJPkY9eB1fHTPpzmGalXpzJgO0xLJOdbeKeH9UDePit2pOAeniZXbtD4lT62
 Du0nIIgrpBk0xKHo8znTbj2vow+AgmrOwcDAFtGcsXpEt3hkEjRS1nJwvE0szvWSA40Y
 v47n2qiWqTqbh0zq6Al/YKol0sCJ3TjzWTb/yZweYNbS+QbW2npl7jFRKTyT1189wyz2
 CjjYOE0WvxEGSfGlmPD3/o6DYRBNysB7Z2sFmQcRVA/V4Kaa35aUmGgapf96R2MaAcyL
 FBz4kh6813SGZUDx1JfOXgZ1r78qaboo7oZchWVUJe8kbUC80HhIR9cHQNpQSBInIlZY
 trAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt59FQjfZ2wj4c4igZoLL2MWynCOzFD5zOcJlsUdRhI6ZtTlNRerQzogOeseNn2GrRgnXeVS35Y4xm@nongnu.org
X-Gm-Message-State: AOJu0YxHL6GuAV+G8DqjpIdJaygoHhRpHV41n1fR8LCwkrYa4BEpLl4R
 K60c7ufKRPCQiQ8ITSKoXmdOz5b05EQY22dTxGn3HRUkbnNlIDZLmuJ8wcZecMLyCTmxoKbSd62
 uk1r3XwHRGyrryEahsRicv3PJfGX5xBc=
X-Gm-Gg: ASbGncvFAq2AyZr63nvE7V+jVnuNnXpCtlx4lIpfwndwwUztU7+xAqk8DmHN46AM2h4
 6CtAQyU2zPtbcV1fnJMh4w4nIIjZQ8YwH2BeMN3qhLhcN2DyCZd1FL4e6Qf+RfIjz1rtcIKTc2F
 DL0NAiNzRvYRcifwRp577UDPaer7UaOASg52SCTVIDy/wy9iS/9qR1s3V8vQP8I2AbwRgcy3ZHF
 GiIotIGd/myohxab6OBEq5jTRWmmAKpQ0Sbj/EE25mS3N3ScgfgnrR/+Nq0nvsHn690xnZXS34A
 kXRZFjalsy3dwOd1MPZq6+8f36KQ
X-Google-Smtp-Source: AGHT+IGU9ADznqtlsioPPNJZsXuo31Arze6hpQ1NHEk9zqEaEwBdwN/paVSK0CeomXaPLbxGkJ4q8uy3I85g6Knhtn8=
X-Received: by 2002:a17:907:3c82:b0:b6d:5df7:3490 with SMTP id
 a640c23a62f3a-b73677ee60dmr951452566b.1.1763359004788; Sun, 16 Nov 2025
 21:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20251116141427.2325372-1-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Sun, 16 Nov 2025 21:56:54 -0800
X-Gm-Features: AWmQ_bnqRPkV4iELETMhfHU7rT_3XYIwNUCOuuh1mQxSJe1gPS3WZzi8ALRNtDc
Message-ID: <CAJ+hS_ijKWTWW1k1YU-US-EaJD8UCM8+zk2Jqq9cSBhss-s+GA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] Support mapping virtio-gpu virgl hostmem blobs
 using MAP_FIXED API
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Nov 16, 2025 at 6:15=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Virglrender got a new unstable API that allows mapping host blobs at a gi=
ven
> memory address using MAP_FIXED mmap flag [1]. Usage of this new API bring=
s
> major performance and stability improvement for venus and drm native cont=
exts,
> see commit message of the RFC patch for details.
>
> Sending early to collect review feeback and have patch prepared by the
> time new version of libvirglrenderer will be released with the stabilized
> API.
>
> [1] https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1=
374
>
> Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com
>
> Changelog:
>
> v2: - Addressed v1 review comments from Akihiko Odaki
>
>     - Added patch that removes unnecessary memory_region_set_enabled(),
>       suggested by Akihiko Odaki
>
> Dmitry Osipenko (2):
>   virtio-gpu: Remove superfluous memory_region_set_enabled()
>   virtio-gpu: Support mapping hostmem blobs with map_fixed
>
>  hw/display/virtio-gpu-gl.c     | 45 +++++++++++++++++++-
>  hw/display/virtio-gpu-virgl.c  | 76 ++++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-gpu.h |  3 ++
>  3 files changed, 119 insertions(+), 5 deletions(-)
>
> --
> 2.51.1
>

Nice work! I'd say Venus loves it soooo much ; )

Tested-by: Yiwei Zhang <zzyiwei@gmail.com>

