Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88857C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 09:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHKYo-00085u-E7; Wed, 12 Jun 2024 05:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHKYk-00085O-Nu
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:46:27 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHKYi-00062V-GC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 05:46:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-356c4e926a3so2220751f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718185582; x=1718790382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0AlRKaHD7La3xTbqXBCJp1i/Kv7vuW6pHEiZw9cisPg=;
 b=M/48X7+huXGc7qn0foBAn+/FPTm3ij1YjNuNEDu5t8W8Ulv4eKKpb6gNq78xVAlMa+
 dWVgVsRuGlI0RAsws4d8AX8JhtgZ81kYqymp6bUOd5AWnStBCgyXRmR1jTLK6tlsrTzY
 TK/r1+yqbUVzjdci+kcfsLQ/cJmZapagAgNsTpPmpMek1zjm9R+yMWdS3/Sjnft/nIsd
 MHctX8rW5vsKhm8NbAniY/WGNMjy1c07BfW5Nz+Epj1omAx+6Fu5RYnwf1863kymwcbS
 Z/XFhqtnNX2jhW2EkKUbnTu9NJCpuTl9EPlNbrCRf4sAqYpjhMpHz8C5n+ag10OFZ98q
 0RyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718185582; x=1718790382;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0AlRKaHD7La3xTbqXBCJp1i/Kv7vuW6pHEiZw9cisPg=;
 b=c3syL0HNHDMm6R9/A06c0aVQOfhudyySTh17r/xzrPhnNsDWZVQsIchgWNipIMVbDY
 mbWz4g9hGxQrIly3OsMD1jevHcNJw769aot7TyrwQmGRUUgcxzTmK0iJTfszCoA8yQXJ
 hRU8EmSN8bovH2tj+xClqC7Jufh8mk1RED4yN9lcooxSg/s1c+B9DNwTcCc3AojPJo6d
 ZnvL6+YXvcDx/ePxJire1BjrWeRyFGwgDfZW4pT9kQXbFQ3cLq35cLQ68n31VCLsbSRr
 7SJSGtLnyQDKWukyw3ebx1aGhcXEXlYKcV9AvVmWpqou++F/9kOrv3lozf2lsMFgdxUQ
 y50A==
X-Gm-Message-State: AOJu0Yxhp9CPvTU/g3qq8rJ/ooFO2INUjgHZKDGKeUer2e4PIcKvRzwV
 x6kd9Ll89+Z3R13AJa/a7qIu4z9IQEq90lKJzBMsZv+mqs321WlXo28AeGy9AeM=
X-Google-Smtp-Source: AGHT+IGshuj98sDRZk/St96Auidn2ytxQn7H4QYl7m+kLL5pW2P2zJbFsWxjQwPLNpRB14ps5xZZoA==
X-Received: by 2002:adf:ab13:0:b0:35f:24f5:e597 with SMTP id
 ffacd0b85a97d-35fe8925654mr975243f8f.65.1718185582452; 
 Wed, 12 Jun 2024 02:46:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5fc0a0dsm16158377f8f.91.2024.06.12.02.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 02:46:21 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3941F5F893;
 Wed, 12 Jun 2024 10:46:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Zheyu Ma <zheyuma97@gmail.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Eric Auger <eric.auger@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1] virtio-iommu: add error check before assert
In-Reply-To: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org> (Manos
 Pitsidianakis's message of "Tue, 11 Jun 2024 15:23:45 +0300")
References: <20240611122348.3613272-1-manos.pitsidianakis@linaro.org>
Date: Wed, 12 Jun 2024 10:46:21 +0100
Message-ID: <87o786xzma.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> A fuzzer case discovered by Zheyu Ma causes an assert failure.
>
> Add a check before the assert, and respond with an error before moving
> on to the next queue element.
>
> To reproduce the failure:
>
> cat << EOF | \
> qemu-system-x86_64 \
> -display none -machine accel=3Dqtest -m 512M -machine q35 -nodefaults \
> -device virtio-iommu -qtest stdio
> outl 0xcf8 0x80000804
> outw 0xcfc 0x06
> outl 0xcf8 0x80000820
> outl 0xcfc 0xe0004000
> write 0x10000e 0x1 0x01
> write 0xe0004020 0x4 0x00001000
> write 0xe0004028 0x4 0x00101000
> write 0xe000401c 0x1 0x01
> write 0x106000 0x1 0x05
> write 0x100001 0x1 0x60
> write 0x100002 0x1 0x10
> write 0x100009 0x1 0x04
> write 0x10000c 0x1 0x01
> write 0x100018 0x1 0x04
> write 0x10001c 0x1 0x02
> write 0x101003 0x1 0x01
> write 0xe0007001 0x1 0x00
> EOF
>
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2359
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/virtio-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 1326c6ec41..9b99def39f 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -818,6 +818,18 @@ static void virtio_iommu_handle_command(VirtIODevice=
 *vdev, VirtQueue *vq)
>  out:
>          sz =3D iov_from_buf(elem->in_sg, elem->in_num, 0,
>                            buf ? buf : &tail, output_size);
> +        if (unlikely(sz !=3D output_size)) {
> +            tail.status =3D VIRTIO_IOMMU_S_DEVERR;
> +            /* We checked that tail can fit earlier */
> +            output_size =3D sizeof(tail);
> +            g_free(buf);
> +            buf =3D NULL;

Hmm this is a similar pattern I noticed yesterday in:

  Message-ID: <20240527133140.218300-2-frolov@swemel.ru>
  Date: Mon, 27 May 2024 16:31:41 +0300
  Subject: [PATCH] hw/net/virtio-net.c: fix crash in iov_copy()
  From: Dmitry Frolov <frolov@swemel.ru>

And I wonder if the same comment applies. Could we clean-up the loop
with autofrees to avoid making sure all the g_free() calls are properly
lined up?

> +            sz =3D iov_from_buf(elem->in_sg,
> +                              elem->in_num,
> +                              0,
> +                              &tail,
> +                              output_size);
> +        }

Isn't this the next element? Could we continue; instead?

>          assert(sz =3D=3D output_size);
>=20=20
>          virtqueue_push(vq, elem, sz);
>
> base-commit: 80e8f0602168f451a93e71cbb1d59e93d745e62e

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

