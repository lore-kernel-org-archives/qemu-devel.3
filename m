Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15151CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8y03-0007ox-JU; Wed, 15 Oct 2025 05:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8y00-0007mW-Et
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:40:49 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8xzw-0002sl-7j
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:40:47 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b40f11a1027so1141456966b.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760521239; x=1761126039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diJ/kcHuVIsk3x/CFnlG5nQePhERgq/r9pMLDQcr0jI=;
 b=Z3yBLSDQq/cHEXDKQINWQMMWJ7N4c2fmdhkDuHUC3ffRd/BOPFI+6QQDLjDL+oegeG
 z59VM/t7t5Xj6P31/FFD537Gt8NN8UXb1ibZek85CaOcTXxO7OXpTqePEOHlaSbYKWb8
 3FfJBicOaZgCv6VCVmGY2mgVDIoiHXjWdDQeUUlkZyqqcU4BacNBGyw8r84AFh4UjZnh
 IR3j+FhlGwHufptZKNvMRb1WF7CW4ZmR38Wrbu3q1o3mWQVQu2WP9zwiSlg5K9vmnG9A
 Qpv3kU7lj+X17xR1M2dYySG2LAS44HhFovGOdtf/Dl/xAubxk1Y/wN5D0+jQI2R/4o2S
 lLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760521239; x=1761126039;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=diJ/kcHuVIsk3x/CFnlG5nQePhERgq/r9pMLDQcr0jI=;
 b=hTyiCb3RX1u41fmle1DFipMzmc9Awgpnk3mwgchqvn25fO9isEOT8L6rhxRyKw0Aj8
 GQUJFp9Pa15DwFGjcCMpx0oE8aS9e3MfMwuGA3qKfJ4BVBj1T+irWyUzspErW8QHOiKY
 TlmSsUGiBd0VazDlosW3hG+k3dlo4o/U4sMyCjbJmwZkI3cZe/5ULarRdHsW2J3RWZ2A
 2tNxx2innZUZxjlh+akmf37hxIMt2MFkiiB9JdZmKxRLl11X8VI+HOszXXnRgcRMyWXE
 TPZlf9z604KloqvqZYABACtRZbht0ARZvAldbXHyoY5x3EIl4iU37j+IWKbRplc2SyES
 V+SQ==
X-Gm-Message-State: AOJu0YzO++fpUM4gH+7eOn3QjOadztIbx19zAfQBABkWjZFfD5vau9P6
 oLkLKaGbqX0AGXeGE8myHQFWfI6jNl9ORwhnYhtOXO1E0Ko0ogtMXvkOejmSaRraVfU=
X-Gm-Gg: ASbGnctVa3WsstfrutYUTwQIhAYGZMNQ97TQJyfmUNoR3XBD+MNf71RuZCtlA+M27+l
 NWl7XfAp0vr7jYS5yr5fFwDfsYgQVF4IT+nkpYoaLNoAhw9LMI1nPR81mKUXlQUdKHdgV6Y4MOY
 RR2ASw18A2t9CM5h3oKjtL6y0cev77S6ipCXot7xyUDj+s4wYyRbhK88tD9oZRbFSzA5hndmGi/
 0dsQCyFJLcJ7xede6uNLiwMrVDESbYvkroYM9CwJDYSKOCiqhlrL+ruO4RYOwoeSN9cnaD/LM+0
 6TOoW5uB7UKyuhC82h5eH0268iYIqdPENzyOEG5eq68ur/dNw56lrSdcubSNejFmN9xSGFUbUBB
 LZ2TWMAlPy0HvfYvC5M2n6mje8g7m/8p0Kkl2wPUzr0OelAl/evdsjnXx
X-Google-Smtp-Source: AGHT+IHVXHYTFBYLgfmLM1ty0HvTeckA8kYW49mD0w7BRkPfIaH6B/3cAKIhRSJAf4Oed8IGeBQa4g==
X-Received: by 2002:a17:907:3d43:b0:b3b:78a7:6220 with SMTP id
 a640c23a62f3a-b50ac6d6457mr3088985866b.55.1760521239269; 
 Wed, 15 Oct 2025 02:40:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cccdaa082sm179394266b.50.2025.10.15.02.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:40:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A930A5F83C;
 Wed, 15 Oct 2025 10:40:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Andrew
 Keesler <ankeesler@google.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 1/8] Support per-head resolutions with virtio-gpu
In-Reply-To: <7ebab3d3-ee30-499c-b475-a64560eb160a@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Wed, 15 Oct 2025 11:49:04 +0900")
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-2-alex.bennee@linaro.org>
 <7ebab3d3-ee30-499c-b475-a64560eb160a@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 15 Oct 2025 10:40:37 +0100
Message-ID: <87sefkjyei.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/10/14 20:12, Alex Benn=C3=A9e wrote:
>> From: Andrew Keesler <ankeesler@google.com>
>> In 454f4b0f, we started down the path of supporting separate
>> configurations per display head (e.g., you have 2 heads - one with
>> EDID name "AAA" and the other with EDID name "BBB").
<snip>
>> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>> index 7269477a1c8..6adb5312a40 100644
>> --- a/hw/display/virtio-gpu-base.c
>> +++ b/hw/display/virtio-gpu-base.c
>> @@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>>       g->req_state[0].width =3D g->conf.xres;
>>       g->req_state[0].height =3D g->conf.yres;
>>   +    for (output_idx =3D 0, node =3D g->conf.outputs;
>> +         node && output_idx < g->conf.max_outputs;
>
> output_idx < g->conf.max_outputs is redundant as it is already
> enforced with the first for-loop that enumerates outputs.
>
> The condition can be simply removed, but I think merging this loop to
> the earlier loop will make the code a bit more concise.

I've dropped the extra condition check but I've left the loop where it
is as I don't want to change the effect of:

    g->req_state[0].width =3D g->conf.xres;
    g->req_state[0].height =3D g->conf.yres;

above.=20

>
> Aside this redundancy of the code, the logic this patch implements
> looks good to me.
>
>> +         output_idx++, node =3D node->next) {
>> +        if (node->value->has_xres && node->value->has_yres) {
>> +            g->enabled_output_bitmask |=3D (1 << output_idx);
>> +            g->req_state[output_idx].width =3D node->value->xres;
>> +            g->req_state[output_idx].height =3D node->value->yres;
>> +        }
>> +    }
>> +
>>       g->hw_ops =3D &virtio_gpu_ops;
>>       for (i =3D 0; i < g->conf.max_outputs; i++) {
>>           g->scanout[i].con =3D

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

