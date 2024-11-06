Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D265D59F59
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jxN-0000tU-Py; Wed, 06 Nov 2024 12:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8jxL-0000tA-1s
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:36:35 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8jxI-0004eY-I2
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:36:34 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso1093959666b.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914590; x=1731519390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXmEy9nUKcTxCQ4WXN6atvN/FiwXR0BLi75eSZ9zduo=;
 b=wBE0bZv1EZwLUzY/AVy8MewawGjXZhK9QL90fZcC+Yg9YeDY8RI7gLrgn4scmYx4WT
 GNeKGPyAvDfG78M5U55mYsjSJYyb/vAXtDJwLKSXtOxfVPzNYoe6JB9a3X2GlAtqJlHQ
 oZE7zqRgmJ3tsEK8doLjlkVAaPORICr+t+a32eb78egj4dj56o4qCymqSlIbFyC4Zsvg
 QLq63CknqSQEgI+bMtB688NwND88Jpb7t6Eu7kqfp1jA2c0LS0qSU/mLGs2NIlJj0aSf
 Hk6WGQbTb+L6veoOeeeT4efO1YR2t5DoRd51Wk2Uc0MN78Drq6t6khDFG5ZXFOkOKRie
 POyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914590; x=1731519390;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AXmEy9nUKcTxCQ4WXN6atvN/FiwXR0BLi75eSZ9zduo=;
 b=WnUaC+wVl6ypJ/rqgebtyMjj2/rGm3k3c7WsMUta/xx6qe9Vq2ExMCj4y34gHWXs83
 gRXOVuZrDFwtzS8EIZb7U1nHLZo8AFiEMj5USBDz1nLuGS8RkzFiIxlOnRtK75Z51R3d
 iyD9Brxh4kwjbT9We7h8mzND6r4t1aOVc9y53OgScEDPjRSOAL7twoj3vrQM+OQSd1T/
 Uf48QCi6HBIT2PYF5P2EsL07DkMhN+tLRUX3gyw8395A2hLslOuRS8xIqr3QHC0FbDu6
 nJUfkneK20hbYmiOHHFnC614D9l9xcqBq76ib+JKUCil+Ao0jPPPP50MB+7f66ulvev2
 50XQ==
X-Gm-Message-State: AOJu0YyoP4YB/UOzxaIkBtHt9lcsU1eJV0Lprn9EK67K8cV7XY8kNkOA
 Sb0Uu2PrfXz+ldeOOve3VUFEIAg4Hr/Jc629Li7lhGM03YMEKimABW3iHAtLtRI=
X-Google-Smtp-Source: AGHT+IF2SeF3i+uTBFdzjuILbceC2C9F5E3Xo+OBtW+8iy5se1taBADoMCVLVlQYo95gU6aN8ahRWQ==
X-Received: by 2002:a17:906:6a1e:b0:a99:87ea:de57 with SMTP id
 a640c23a62f3a-a9e6553bc7amr2004510366b.2.1730914589333; 
 Wed, 06 Nov 2024 09:36:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16dae5csm309989466b.79.2024.11.06.09.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 09:36:28 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF6C15F769;
 Wed,  6 Nov 2024 17:36:27 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] hw/display: factor out the scanout blob to fb
 conversion
In-Reply-To: <21888d29-b9ee-4c1c-99b3-09f980d7cfd0@collabora.com> (Dmitry
 Osipenko's message of "Wed, 6 Nov 2024 03:33:23 +0300")
References: <20241104165348.2361299-1-alex.bennee@linaro.org>
 <20241104165348.2361299-2-alex.bennee@linaro.org>
 <21888d29-b9ee-4c1c-99b3-09f980d7cfd0@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 06 Nov 2024 17:36:27 +0000
Message-ID: <87v7x0clic.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 11/4/24 19:53, Alex Benn=C3=A9e wrote:
>> There are two identical sequences of a code doing the same thing that
>> raise warnings with Coverity. Before fixing those issues lets factor
>> out the common code into a helper function we can share.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  include/hw/virtio/virtio-gpu.h | 15 +++++++++
>>  hw/display/virtio-gpu-virgl.c  | 21 +-----------
>>  hw/display/virtio-gpu.c        | 60 +++++++++++++++++++++-------------
>>  3 files changed, 53 insertions(+), 43 deletions(-)
>>=20
>> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-g=
pu.h
>> index 553799b8cc..90e4abe788 100644
>> --- a/include/hw/virtio/virtio-gpu.h
>> +++ b/include/hw/virtio/virtio-gpu.h
>> @@ -333,6 +333,21 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>>                                     struct virtio_gpu_scanout *s,
>>                                     uint32_t resource_id);
>>=20=20
>> +/**
>> + * virtio_gpu_scanout_blob_to_fb() - fill out fb based on scanout data
>> + * fb: the frame-buffer descriptor to fill out
>> + * ss: the scanout blob data
>> + * blob_size: the maximum size the blob can accommodate
>
> Nit: 'maximum size the blob can accommodate' makes it sound to me like
> data will be copied into the blob. What about 'size of scanout blob data'.
>
>> + *
>> + * This will check we have enough space for the frame taking into
>> + * account that stride for all but the last line.
>> + *
>> + * Returns true on success, otherwise logs guest error and returns false
>> + */
>> +bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>> +                                   struct virtio_gpu_set_scanout_blob *=
ss,
>> +                                   uint64_t blob_size);
>> +
>>  /* virtio-gpu-udmabuf.c */
>>  bool virtio_gpu_have_udmabuf(void);
>>  void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res);
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl=
.c
>> index eedae7357f..35599cddab 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -852,26 +852,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>>          return;
>>      }
>>=20=20
>> -    fb.format =3D virtio_gpu_get_pixman_format(ss.format);
>> -    if (!fb.format) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: pixel format not supported =
%d\n",
>> -                      __func__, ss.format);
>> -        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> -        return;
>> -    }
>> -
>> -    fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
>> -    fb.width =3D ss.width;
>> -    fb.height =3D ss.height;
>> -    fb.stride =3D ss.strides[0];
>> -    fb.offset =3D ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.st=
ride;
>> -
>> -    fbend =3D fb.offset;
>> -    fbend +=3D fb.stride * (ss.r.height - 1);
>> -    fbend +=3D fb.bytes_pp * ss.r.width;
>> -    if (fbend > res->base.blob_size) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
>> -                      __func__);
>> +    if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size)) {
>
> This fails to compile, needs s/res->blob_size/res->base.blob_size/
>
> ../hw/display/virtio-gpu-virgl.c:855:53: error: 'struct
> virtio_gpu_virgl_resource' has no member named 'blob_size'
>   855 |     if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size))=
 {
>       |                                                     ^~
> ../hw/display/virtio-gpu-virgl.c:808:14: error: unused variable 'fbend'
> [-Werror=3Dunused-variable]
>   808 |     uint64_t fbend;
>       |              ^~~~~
> cc1: all warnings being treated as errors
>
> Please correct in v2.

Doh - I failed to compile that in my extra.libs config. Will fix.

>
>>          cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>>          return;
>>      }
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index c0570ef856..e7ca8fd1cf 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -721,13 +721,48 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>>                                &fb, res, &ss.r, &cmd->error);
>>  }
>>=20=20
>> +bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>> +                                   struct virtio_gpu_set_scanout_blob *=
ss,
>> +                                   uint64_t blob_size)
>> +{
>> +    uint64_t fbend;
>> +
>> +    fb->format =3D virtio_gpu_get_pixman_format(ss->format);
>> +    if (!fb->format) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: host couldn't handle guest format %d\n",
>> +                      __func__, ss->format);
>> +        return false;
>> +    }
>> +
>> +    fb->bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
>> +    fb->width =3D ss->width;
>> +    fb->height =3D ss->height;
>> +    fb->stride =3D ss->strides[0];
>> +    fb->offset =3D ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * =
fb->stride;
>> +
>> +    fbend =3D fb->offset;
>> +    fbend +=3D fb->stride * (ss->r.height - 1);
>> +    fbend +=3D fb->bytes_pp * ss->r.width;
>> +
>> +    if (fbend > blob_size) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: fb end out of range\n",
>> +                      __func__);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>> +
>> +
>
> Nit: extra newlines

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

