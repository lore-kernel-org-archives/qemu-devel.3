Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A0DD0E6C4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNrdc-00027Q-6J; Tue, 25 Nov 2025 06:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrdR-00025m-Tb
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:55:06 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNrdP-00017M-FV
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:55:04 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b3377aaf2so3134169f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764071701; x=1764676501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DK2KBXPxKsd448FRlzZ8qH0yYJPKx42RjfJ0wGk0zZE=;
 b=m99JKWNDyN25/uWnZ9VUwP/y701iiUpvplhdYG6GzzJs9Im1kKoJcoHhcX9BSYgluO
 8T7awF3Fmp+tO2/dJEu+JKakPJqwh+s5dLypa8nrpWrMiIJ9l445dSzZxZHp+w5bM2X7
 eRXTFR5JZCSgkGmYByy0MiP+N+oNTi2xDqdatA1akX3570tBXdAxOahaIfA+DRY5fxTI
 NZV+wIErGuD2XSp1KdMIzWsW632PL6rwDg4w0JEGAbCxbboaW3mhwEWNMUZoNEv5OUzJ
 96rt7RWH+rwdt1qf9sIWcs4iG6yDXyX1m3kGsWT1EYlJ6hgcqzNgMb8cGlXaGKNu+dJk
 NVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764071701; x=1764676501;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DK2KBXPxKsd448FRlzZ8qH0yYJPKx42RjfJ0wGk0zZE=;
 b=GHubl6ZtDhsN2pVX2On7GqECieSwbNJlZW6bboDNurdEK7fgvMbBkycFV+Yzqo0UvP
 BUWth86VRwc0SaItcKpGY5X+AEikbxVTYqPd2zgVCBbBBxZvOuMS+kEJ+rWSmZnh57cN
 EgHbwD9Q6p3uGIdkgr+gNcOlBRcCdYusvBSsiA8sQgZze7xaDEJTYo+Thr99paR+Yxew
 olgSesQZ3pSeRZ+yHpx6pqBm1EIhkY32bR0k89DYZt5bnlUXiM7t4bQ1St20kgd3zcrj
 aUvzNAnMKgfNMdBVqYkiPa4o/KTxcBVv+pJRlVH8eGiSXQD6ky6eEetjMCKmUbhEr5/4
 JCfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrCvcDWrWmEXxeIfgdSboZ5MZboFGoWh67TITMfZjf9MzW//Q66njHaWoVEyXMtxuYvJSHb2f8AMDK@nongnu.org
X-Gm-Message-State: AOJu0YxlxKjpzhzafWrpz41id7RdR+uweJRCJgQkC+LMJNGeIgrNonrN
 Zr0TF9vEJTMtWgi69gWPVv+szkNh5zMzjcLlKipCwG6Tt6t9f8JWO8crvWQ5/BHjj4A=
X-Gm-Gg: ASbGnctLUnkuqzU/yW/UoLmcZegLhxNmjNIIZseQLNO+RG332gofByq0CWWTI8IbKtI
 X9dWSbS04PEJWNHjTEog9a/iu+mv0XN5RwiHMiqO8Dq1fcmO4wxCyCrXoH6ihCzBPEIJ9YKCNuv
 YytCj/g0UpFuNfwAkPvGVBdiP+Qy3LXs6rfaYaeL3DHTd7SwKzEmjM3yPlE9ePTpWpcLVEhYQSF
 hPiYUMOh9HEyzjQtKPqXh7vbNpHh8+o+h/601BF1z3PISd/HuU2ogdPsYFlzOYvZblj46c/D3jD
 F5mZh/Vvkt4/seaerieCqir4Lo2pYWpkNioU7LmN/dMYWJW71CGAPuLbJ/B7/c3fqs0/le11Iqh
 TEjMWOVFm7EPf22TYto3gUFee8gl278B/TBcNfZ3z+R501zNkm1DTCXdVCAfrkZFXUhHaKdX+bh
 8y4DCYhxMESc8=
X-Google-Smtp-Source: AGHT+IHKwg2UG1A/RqBgRQwJFYy7RlaAUWvrXE0XGLsrI/P0S8ZW7vnD2qyRnul93rvFrSHxaZ2dWQ==
X-Received: by 2002:a05:6000:1885:b0:42b:394a:9de with SMTP id
 ffacd0b85a97d-42cc1d1a10cmr15321695f8f.49.1764071700959; 
 Tue, 25 Nov 2025 03:55:00 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f363b0sm34449367f8f.13.2025.11.25.03.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 03:55:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 875C45F7EF;
 Tue, 25 Nov 2025 11:54:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Huang Rui
 <ray.huang@amd.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Yiwei Zhang
 <zzyiwei@gmail.com>,  Sergio Lopez Pascual <slp@redhat.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  Alyssa Ross <hi@alyssa.is>,  Roger Pau
 =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,  Alex Deucher
 <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K?=
 =?utf-8?Q?=C3=B6nig?=
 <christian.koenig@amd.com>,  Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,  Julia Zhang
 <julia.zhang@amd.com>,  Chen Jiqian <Jiqian.Chen@amd.com>,  Rob Clark
 <robdclark@gmail.com>,  Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [RFC PATCH v4 2/7] virtio-gpu: Validate hostmem mapping offset
In-Reply-To: <20251125023517.177714-3-dmitry.osipenko@collabora.com> (Dmitry
 Osipenko's message of "Tue, 25 Nov 2025 05:35:12 +0300")
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-3-dmitry.osipenko@collabora.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 25 Nov 2025 11:54:59 +0000
Message-ID: <8734628gz0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

> Check hostmem mapping boundaries originated from guest.
>
> Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index a6860f63b563..2224f59cf5d7 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -126,6 +126,14 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
>          return -EOPNOTSUPP;
>      }
>=20=20
> +    if (offset + res->base.blob_size > b->conf.hostmem ||
> +        offset + res->base.blob_size < offset) {

This second check seems weird. offset + blob_size could only every be
smaller than offset if blob_size was negative. I feel we should have
caught that earlier if it can happen.

Are we trying to catch an overflow here?

> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: failed to map virgl resource: invalid offset\=
n",
> +                      __func__);
> +        return -EINVAL;
> +    }
> +
>      ret =3D virgl_renderer_resource_map(res->base.resource_id, &data, &s=
ize);
>      if (ret) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource=
: %s\n",

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

