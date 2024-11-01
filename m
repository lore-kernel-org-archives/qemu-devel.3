Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B875E6F06C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 15:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6tgu-0002yN-Az; Fri, 01 Nov 2024 11:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6tgs-0002xw-BP
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:35:58 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6tgo-000462-D0
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 11:35:57 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so2726176a12.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730475352; x=1731080152; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox5zuqQkZjxezk9rgYnUQrTGz2TSASa/ElhWXn8NhKw=;
 b=fRhagpMPj2ELUTLGjXLkAyqV8AsKCGYcrvIaXky+JFDOL6bNpxHMwE6NlLLhPaMYCv
 XihKjacnKjkdnerolS/wTROTU5t0YqhDr7SiBYF5win6NXgEwP1o+JgLbaNj4rT+syJD
 5O6EOtYLe0fHqUIpPxelxPrW2rrUNd//qsOSnfZ+eHqlhdacr0hNhjJ5irs5QjY0Mxxu
 xK0l/VX82liIpfyvXlfrQAy6sboj1L3VXbTtTZxhh44ygCrK+C6NXfMwyo3FgmXe2Fnr
 f3P/4m97J/ntt7hjDYO8Yl7tqE10vMZlMs0nfC0doEYz8YxtSX6/3Xe601QJVohBadDq
 CukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475352; x=1731080152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ox5zuqQkZjxezk9rgYnUQrTGz2TSASa/ElhWXn8NhKw=;
 b=atuVErB0s+YwDuzYgsapbCin/q8r2bt21C5CTE05fiEK/u38MjT0R+dvM2bnROhhc8
 PH7WBFxFNH7C7Be9F8uoUFUPAOuPuZCCA/2SStKyRb21VGggKqCnuORP8g8pj5mxEhKR
 JfPMHvt02shAZJHIKJ8luSBPtPigGfa6OH9FW0sTrwPYi8PVD1rSbY40/LuvqpIifsFI
 5RXOA/eAaJR6XDQKdVt9hhzBSMPDkO1YQCsqlG96p+RS+91/S7gnsxhQtBjm7aK4Bd8/
 vIQooD8wdDhPdjAXN+o8g+4Lrfjsu8/s+O8Cj+gcN+VFKLaLpiCpavOY1/0mmmPPYamf
 k5UA==
X-Gm-Message-State: AOJu0Yzar82vPibSrxB53/pPGgn9Bhf73ATbR9nJnPpBXtZ1GwJQrz78
 kUpaKx6EHDq2FKEDYTa3TRNEPPpWPcIi2/sH/rurPpGWNB+3t5HEoTJp+U88dffjemZr4koZyc1
 YUpzgOAShAXCHKBKMoVxh7R4I/+9ylT59nsh6E0BOjdsDzfx4
X-Google-Smtp-Source: AGHT+IG9ZaB7+4L23HAx9rxhZ1UeH28UsTS1Go6kPEnoQlmeIEOLKJQ1v3Uiem7D7qr0u0FQIuD2uz6IV8IeLy9M9EE=
X-Received: by 2002:a05:6402:3489:b0:5cb:b261:c34f with SMTP id
 4fb4d7f45d1cf-5ceb9236a6cmr2456885a12.6.1730475352282; Fri, 01 Nov 2024
 08:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
In-Reply-To: <20241029121030.4007014-12-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2024 15:35:41 +0000
Message-ID: <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Robert Beckett <bob.beckett@collabora.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Tue, 29 Oct 2024 at 12:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> From: Robert Beckett <bob.beckett@collabora.com>
>
> Support BLOB resources creation, mapping, unmapping and set-scanout by
> calling the new stable virglrenderer 0.10 interface. Only enabled when
> available and via the blob config. E.g. -device virtio-vga-gl,blob=3Dtrue
>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com> # added set_sca=
nout_blob
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Message-Id: <20241024210311.118220-12-dmitry.osipenko@collabora.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Hi; Coverity points out some possible issues with this commit:


> +    fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
> +    fb.width =3D ss.width;
> +    fb.height =3D ss.height;
> +    fb.stride =3D ss.strides[0];
> +    fb.offset =3D ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.str=
ide;
> +
> +    fbend =3D fb.offset;
> +    fbend +=3D fb.stride * (ss.r.height - 1);
> +    fbend +=3D fb.bytes_pp * ss.r.width;

Here 'fbend' is a uint64_t, but fb.stride, fb.bytes_pp,
ss.r.height and ss.r.width are all uint32_t. So these
multiplications will be done as 32x32->32 before being
added to fbend, potentially overflowing. This probably
isn't what was intended.

(This is Coverity CID 1564769, 1564770.)

The calculation of fb.offset also might overflow, but
Coverity doesn't spot that because fb.offset is uint32_t
and so the whole calculation is 32-bit all the way through
without a late-32-to-64 extension.

> +    if (fbend > res->base.blob_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }

thanks
-- PMM

