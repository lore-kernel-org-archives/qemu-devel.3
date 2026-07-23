Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9800BC531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 08:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmou7-0003lE-Vt; Thu, 23 Jul 2026 04:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmou6-0003kC-2D
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:35:42 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wmou4-0007fv-4s
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 04:35:41 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbb85186d43so271812a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 01:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784795738; cv=none;
 d=google.com; s=arc-20260327;
 b=VVGYSjh4ntLzCx36XLuampB8Z5qPvhjhM1TiBZ5eecgongbPJwFGVyWlxyi/ixHpum
 cPuqnvI6RMznjXBMOz/4U1nI5/2P5h2afXuIOS0Zs7QOw/nDXuopKXsSngxKzHzlFKAC
 x8N6iBq5T8GhJB+3e3GYiuxZpp7ReDSsEVaoDM8izIJNPXD+Fzp/H3dWWoy+zalDD7nC
 d07KYgwbcyBTImT/DJByu9MFDcF9l3uIDi6EhUr086HhdKlmwnCvTezAT1sRHk782Gdz
 62OooZR7KQLveYrfYMwxaOEmeF2ECL+CRfA5J5LTvuuhevWZYUfL6LmLO28r+Gij85qd
 hGcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=avx/9UTFRGD2a3Jmzkma/lYbADz9cvuQDSckzg5qwdc=;
 fh=yO7hsCEgyCHbk7uK1aZzmseKmGII3G341cBwMKCXdno=;
 b=RiE/TuimXjKGxr3fZMJIc3Q7G4D3gR8rvXS0WfBaO2U94riusCeZKJHEkZduyr0isM
 3TeKr39E3P62+dP3fznPF+TjTX7n3N0A704F36wzIZWHs6YxBRd07KXz7SAtjJUQoH+2
 nJzGkHXpU4uRp6FeIl3rrcBK9St/1G4o0SQ2HTw7hPHx/ZNF1rg7o5VYgKuRLl2zUzbP
 tZCqCyM94HGOYohLxuLJGY0cUYMj4CDsh3pzRTvKAqeURxbXu/NKyzKIlaHP6nxE4E7w
 eKk2bkP+M8DXZUbuwhV+dDcQaIthPfzSwYoK/tx5RNLZYuW8XsfKuJMJ/He69wCJcyui
 drVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784795738; x=1785400538; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=avx/9UTFRGD2a3Jmzkma/lYbADz9cvuQDSckzg5qwdc=;
 b=Q1Rbr8OVFju9tg6KcwK4bRuFfgniJK9vPN1qA8zQcrcCjJNc0Yakr8n3gXA4HC0QL/
 hIzQ3URB5pZineVd43VBwshFROHc1ggc3B0ynfs15nfc8FGYaYCdl4rbP+0818ThD3LY
 Z3bFqiuUhrX+xlHof7AHaGaffF/WE/cDqt+j4I+B5uXT7nwVuJIoqXxsXIVMCLVxowQa
 Uo+2RtIeF7khx6lLQ3OUS3U7L6sSO37FTRlEmwENXUbi8KQ4oiCWBqqtZVI6zKOsL5y8
 2xfn9y5rt1Qvw4rp3flzqWr287crdhH+Pq0eh993+drH/ulugJiFv3ASbzqoQIWZ5a0a
 Jqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784795738; x=1785400538;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=avx/9UTFRGD2a3Jmzkma/lYbADz9cvuQDSckzg5qwdc=;
 b=OE+/ln+N1i6hLh8TFJaC55eSpCaNcDTvfDlKRqNSjO1yMvGpKuKf8LQHHKL0yLhapW
 P0nCqZL5Xj8VYlT3WsOdF32XFsfVaWFmlPZ++ovO58j+gpkQO8Mf69yQrJ302haAfkWl
 VQwuXp34mWjqz42Fgl96aUB4UccThKGV5hF5T5DvoZnqI1wfkVWI7avwu3EuJ1gGym0W
 aO/1CqCxccEbrQCvduee9d+o8SVac3KvV8Xn0QmtoP5pnC40wzWBX0gJHq7Y9caer0MU
 U+ApE4LKkngbnoEfL3xnrAfH6s+Zwudrw1qhB0dF5v2466zBjzUm07zmAQQ0ZSOppr0A
 8A4g==
X-Gm-Message-State: AOJu0YyV0ZiS56TlwFpHUmysWnKTJPmXACHqOfOyMdETES+O3oNnh9F2
 XuGlSQpg6I0jU4AnPiarsu5jrzGVRQflyFsFOxyb0CM/RojeDx1/h78BpfDXNb2lXa6qYNBrvSp
 aG1RC7Cz9IWwPt4ZDYDDsQoGqEnhpLGQ=
X-Gm-Gg: AR+sD12QnRdwSNWTlNGMgMGy58tHD+i4EqUY4OZlVoxdpx6JTTY7Tf/y9Ux7IWjxKNo
 inhVDxkxJi5TapV/TnS/VSFyYb4HvfNBbIGRvZ51APDEtLua9ICaN1nl+SnxRv9ISe1zgCmK7k9
 9mUkI1Wtg+LsRQcu3ilQDqKaBBq9h8PX+apiRWJAblbIHBS2oeeJgNxa4m4JMHy0PCJJI9bQ5r0
 Ca6eOFoJtVP6PLOdtk6q7mLc5BCxNE//Jn3j/NmvOSqbdYgHWn9YF15G4c9pE3w1+VVx+9gVOCN
 EigaK7KkrLZUc32SWA==
X-Received: by 2002:a05:6a21:338e:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c44affc91dmr2227012637.24.1784795738296; Thu, 23 Jul 2026
 01:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
In-Reply-To: <20260720071556.106003-1-jianghaotian.sunday@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Jul 2026 12:35:25 +0400
X-Gm-Features: AUfX_mzeiOYmGN5wkEmSsMh70E2iixlCAcfS8uYDdjnMyYhOGfJdQqFexg1VT00
Message-ID: <CAJ+F1CLzPQDtNDkL1YeLbATKFkJ=4J1uXLkrBt=U7A-h8xdkiQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-gpu: fix NULL deref in rutabaga set_scanout
To: jianghaotian.sunday@gmail.com
Cc: qemu-devel@nongnu.org, mst@redhat.com, alex.bennee@linaro.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dmitry.osipenko@collabora.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi

On Mon, Jul 20, 2026 at 11:17=E2=80=AFAM <jianghaotian.sunday@gmail.com> wr=
ote:
>
> From: Haotian Jiang <jianghaotian.sunday@gmail.com>
>
> rutabaga_cmd_set_scanout() checks scanout_id < VIRTIO_GPU_MAX_SCANOUTS
> (16), but does not check scanout_id < conf.max_outputs like the base
> class (virtio-gpu.c) and virgl backend (virtio-gpu-virgl.c) do.
>
> With the default max_outputs=3D1, virtio_gpu_base_device_realize only
> initializes scanout[0].con. A guest submitting SET_SCANOUT with
> scanout_id >=3D 1 takes the con=3DNULL path, and
> qemu_console_set_surface(NULL, NULL) dereferences con->ds, crashing
> QEMU.
>
> Replace VIRTIO_GPU_MAX_SCANOUTS with vb->conf.max_outputs in the
> CHECK, since realization already ensures max_outputs <=3D
> VIRTIO_GPU_MAX_SCANOUTS.
>
> Fixes: 1dcc6adbc1 ("gfxstream + rutabaga: add initial support for gfxstre=
am")
> Reported-by: Haotian Jiang of Tencent Security (Yunding Lab) <jianghaotia=
n.sunday@gmail.com>
> Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Cc: qemu-stable@nongnu.org

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-rutabaga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rut=
abaga.c
> index 6ff1263901..3f78899442 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -302,7 +302,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virtio_=
gpu_ctrl_command *cmd)
>      trace_virtio_gpu_cmd_set_scanout(ss.scanout_id, ss.resource_id,
>                                       ss.r.width, ss.r.height, ss.r.x, ss=
.r.y);
>
> -    CHECK(ss.scanout_id < VIRTIO_GPU_MAX_SCANOUTS, cmd);
> +    CHECK(ss.scanout_id < vb->conf.max_outputs, cmd);
>      scanout =3D &vb->scanout[ss.scanout_id];
>
>      if (ss.resource_id =3D=3D 0) {
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

