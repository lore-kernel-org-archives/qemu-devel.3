Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A529FC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raa7i-0004zl-KV; Thu, 15 Feb 2024 06:41:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1raa7g-0004zW-Oj
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 06:41:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1raa7e-000494-UN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 06:41:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41202eae372so6034375e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 03:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707997304; x=1708602104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VTEAKiHQgau8rz6G6SavLxaIz42F4xUZL+SfEwlOHQ=;
 b=zdXpWjsqovE+iBd9F6ZNS/u20qoSiZj5HI4DvtYeLLGzepLNUlLDRe3ir4aXwpQdJ4
 XQy1EX8JLWz9D7lMDG1VYdC4HW3wZRZgS4+fq28VDssZ6Pz36+mOe6dQ8Bne84u/9v9G
 SyZCaavKrafDY2Ns8VlumyIdjZndZu5S2bWXNcMrIF5Ymi+VwVKb37qIMtjvOIsykN21
 yuB4Dr2KAUXLXFYSJ6muEJyrPaeISKIBDkWVb5XjyCN8Y3pDmPNs6g37EdbBhSLkv7ok
 o7phEmLksYMYfq9gfLN4vfAWq4I8Ur4bpSRtFpPiKhurWnECEMRBAeZcC7ueF8rEg8Mz
 YeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707997304; x=1708602104;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3VTEAKiHQgau8rz6G6SavLxaIz42F4xUZL+SfEwlOHQ=;
 b=O+B6Pk+wiByDIjBa+m/SLnL+eljYVLxbblF1rukQKBE6mbqPdIFVEsIPmLbQZSs/hD
 2987EO3vIEY4IiU6v5XnxVZwTV31k7teYPCpNDUirkJImligkm71MHbcjr4tsqdVl6SH
 +NeLegfwpYuPHFl5JpjJcelKcw4oQeOR2NNB2u2ZFFZHi6l5qCl8c71zU5sTb6j/HEwJ
 oRii+DwzPwshiUcyKENfDe+HcGIla+ua/JzwgF6vwAT2ugUHnOzYCq4KrsRdhV5XG6X7
 t4LLjB7QvEWKJMKjVnfZ3MqS5nXZ46u7K19yQ63u1fFunTZZosyGHGqZ2lOfjSCEipPf
 sBfg==
X-Gm-Message-State: AOJu0YyqmvNuSW9G0kp/pJvOOTC0JAR/ut+NPuQPVj/7cHkke36IJdKw
 pchmIxniS90Qgh3ydOnK1Po2pRWYgrJY0MJ+QvCzLTRyZphWJuDiTE35Kl+ls2I=
X-Google-Smtp-Source: AGHT+IEr4j+Tco+JxwNo7H042Tl5fXVh3rwkBwE3bXXo49rLDNMY26RmtrfuCwfTWDBcTG/V4aVGXA==
X-Received: by 2002:a05:600c:4503:b0:411:ae8e:5945 with SMTP id
 t3-20020a05600c450300b00411ae8e5945mr1150188wmo.36.1707997304199; 
 Thu, 15 Feb 2024 03:41:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y26-20020a1c4b1a000000b0040fe3147babsm4789207wma.0.2024.02.15.03.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 03:41:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6328F5F8AD;
 Thu, 15 Feb 2024 11:41:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org,  stefanha@gmail.com,  "Michael S. Tsirkin"
 <mst@redhat.com>,  marcandre.lureau@gmail.com,  kraxel@redhat.com,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 2/3] hw/virtio: cleanup shared resources
In-Reply-To: <CADSE00+fCX_w_CyyRmXTJw3WTY-Z-uM+WkOf+yzLKuffUdOB+w@mail.gmail.com>
 (Albert Esteve's message of "Thu, 15 Feb 2024 10:45:41 +0100")
References: <20240109125614.220293-1-aesteve@redhat.com>
 <20240109125614.220293-3-aesteve@redhat.com>
 <87le7ymrqg.fsf@draig.linaro.org>
 <CADSE00+fCX_w_CyyRmXTJw3WTY-Z-uM+WkOf+yzLKuffUdOB+w@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 15 Feb 2024 11:41:43 +0000
Message-ID: <87jzn66jk8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Albert Esteve <aesteve@redhat.com> writes:

> On Tue, Feb 6, 2024 at 12:11=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  Albert Esteve <aesteve@redhat.com> writes:
>
>  > Ensure that we cleanup all virtio shared
>  > resources when the vhost devices is cleaned
>  > up (after a hot unplug, or a crash).
>  >
>  > To do so, we add a new function to the virtio_dmabuf
>  > API called `virtio_dmabuf_vhost_cleanup`, which
>  > loop through the table and removes all
>  > resources owned by the vhost device parameter.
>  >
>  > Also, add a test to verify that the new
>  > function in the API behaves as expected.
>  >
>  > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>  > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
>  > ---
>  >  hw/display/virtio-dmabuf.c        | 22 +++++++++++++++++++++
>  >  hw/virtio/vhost.c                 |  3 +++
>  >  include/hw/virtio/virtio-dmabuf.h | 10 ++++++++++
>  >  tests/unit/test-virtio-dmabuf.c   | 33 +++++++++++++++++++++++++++++++
>  >  4 files changed, 68 insertions(+)
>  >
>  > diff --git a/hw/display/virtio-dmabuf.c b/hw/display/virtio-dmabuf.c
>  > index 3dba4577ca..6688809777 100644
>  > --- a/hw/display/virtio-dmabuf.c
>  > +++ b/hw/display/virtio-dmabuf.c
>  > @@ -136,6 +136,28 @@ SharedObjectType virtio_object_type(const QemuUUI=
D *uuid)
>  >      return vso->type;
>  >  }
>  >=20=20
>  > +static bool virtio_dmabuf_resource_is_owned(gpointer key,
>  > +                                            gpointer value,
>  > +                                            gpointer dev)
>  > +{
>  > +    VirtioSharedObject *vso;
>  > +
>  > +    vso =3D (VirtioSharedObject *) value;
>  > +    return vso->type =3D=3D TYPE_VHOST_DEV && vso->value =3D=3D dev;
>
>  It's a bit surprising to see vso->value being an anonymous gpointer
>  rather than the proper type and a bit confusing between value and
>  vso->value.
>
> It is the signature required for this to be used with `g_hash_table_forea=
ch_remove`.
> For the naming, the HashMap stores gpointers, that point to `VirtioShared=
Object`, and
> these point to the underlying type (stored at `vso->value`). It may sound=
 a bit confusing,
> but is a byproduct of the VirtioSharedObject indirection. Not sure which =
names could be
> more fit for this, but I'm open to change them.

This is the problem without overloading value and vso->value. I
appreciate that virtio_dmabuf_resource_is_owned() has to follow the
signature for g_hash_table_foreach_remove but usually the compare
function then casts gpointer to the underlying type for any comparison.

So something like:

  typedef struct VirtioSharedObject {
      SharedObjectType type;
      union {
            vhost_dev *dev; /* TYPE_VHOST_DEV */
            int udma_buf;   /* TYPE_DMABUF */
      } value;
  } VirtioSharedObject;

and then you would have:

  VirtioSharedObject *vso =3D value;
  if (vso->type =3D=3D TYPE_VHOST_DEV) {
     vhost_dev *dev =3D dev;
     return vso->value.dev =3D=3D dev;
  }

In fact I think you can skip the cast so have:

  VirtioSharedObject *vso =3D value;
  return vso->type =3D=3D TYPE_VHOST_DEV && vso->value.dev =3D=3D dev;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

