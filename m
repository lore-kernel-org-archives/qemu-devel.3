Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA757D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vZY-0001mY-Sb; Mon, 04 Nov 2024 06:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t7vZW-0001m8-MJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:48:38 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t7vZV-0002Ha-75
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:48:38 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so2563087a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730720915; x=1731325715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkHaS2DPQX5ww8JR/w77DwIDnQvyaeXelSQP7jDBZio=;
 b=iIjJIB7OBBBUWZRpoBlGqV8K7Q2xKBOjV3Nxl1DqPt/HXfD373x8khVWor7YRxRbw8
 j0CJgbfyM3cBC6mY3R5p/5LaDFmR7zgtHD6QilWwfFtkZZXAJJyhcruPclqQXIfKrafd
 /ro0Xwx45ZocXzgFBo8QEaHk/E6wmd9/dJDQCugi9kDIqwJ1DzBpp9Ad7u8nwTLEkeJ0
 8FX+sz9wy50pZS3KY/nlfoBIxf23uauLUIk1vL8Z0WyG+VQGd+QjhuTp4eAWFktc5A8L
 0CHsr1F01eL/pH/QI7TKy+VxTo6QvgqB8ODKkxU3DexoDLBfXlv4pyuc6fKsnbj1Ebt5
 7MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730720915; x=1731325715;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hkHaS2DPQX5ww8JR/w77DwIDnQvyaeXelSQP7jDBZio=;
 b=KqE0taeHBZkM+Zgerj9vCVn9yN+K8NsfOkhzlhtapqSPegmFpwpUrXyIdRjcyWejaB
 QOaerBe8N0SwQkpLjQU7KJu/dPbeJ6kw6ziNM0UWqrtNwY7HjKeJ/+BVK6LIAZVlzVYB
 5bodRY/O2sgaoZbIc5HhgPycxCn2ypdcNVj/iKMV7VeAgXPT6NNRiM4Jx5FnuChEIkvA
 yHOmLmluSg6IgHA9X9HnXTEo8cmQnEmTEMOGebgl3H4L6HGcue4HsU7mppXq5m48fIbD
 XWay3Iy27WHo/J1k0AN9Eh1l/4evNxJU4PSFfGVR6Xh4HD5+hkXtcSLl0lq8WlpSVA3+
 biDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcIjO2/Zvhu9VLz8wlA6FMfRbtGl3IApQ+G8/E855qa9rECHnYY4h/Ku5dPcJL/n5xm8YhOmjLKQgr@nongnu.org
X-Gm-Message-State: AOJu0Yz5SRwjeIrg19mDgxgDQHCzamUQqFQ2KISp1kYzka73iEaztuWP
 vwBbnayJxpwxZmPpcPV1FRqjE8VELT/57KkknrmEnF+USo01jbfoHjqA9p7Ojiw=
X-Google-Smtp-Source: AGHT+IFb5RVEODeEmxdxwYxybsDf6t515FVTTaOO2mNnxUv2WxEHXM7XKx0OWiJwowCGGQ0JPwWBCw==
X-Received: by 2002:a05:6402:5201:b0:5ce:afe1:cd2d with SMTP id
 4fb4d7f45d1cf-5ceb8de9672mr11314784a12.15.1730720914939; 
 Mon, 04 Nov 2024 03:48:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac7ca7a0sm4285108a12.64.2024.11.04.03.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 03:48:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8DA325F882;
 Mon,  4 Nov 2024 11:48:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,
 Robert Beckett <bob.beckett@collabora.com>,  Antonio Caggiano
 <antonio.caggiano@collabora.com>,  Xenia Ragiadakou
 <xenia.ragiadakou@amd.com>,  Huang Rui <ray.huang@amd.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>
Subject: Re: [PULL 11/13] virtio-gpu: Handle resource blob commands
In-Reply-To: <7b4c6712-ed37-4973-88ef-5ef5efdfa232@collabora.com> (Dmitry
 Osipenko's message of "Fri, 1 Nov 2024 21:23:21 +0300")
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
 <20241029121030.4007014-12-alex.bennee@linaro.org>
 <CAFEAcA8M1gu9Ow8n42i-ie9t-k=yoe0R+D0CUZodwoU_Kezfhw@mail.gmail.com>
 <87ldy2ho24.fsf@draig.linaro.org>
 <7b4c6712-ed37-4973-88ef-5ef5efdfa232@collabora.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 04 Nov 2024 11:48:32 +0000
Message-ID: <87o72vdxtb.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

> On 11/1/24 20:16, Alex Benn=C3=A9e wrote:
>> Also what is the subtlety behind using both stride and bytes_pp in the
>> calculation. My naive thought would be:
>>=20
>>   fb.bytes_pp * ss.r.width =3D=3D fb.stride
>>=20
>> Can anyone enlighten me?
>
> GPUs want image line size to be aligned to a power of 2 value, like 64
> bytes for example. This aligned size of the line is called stride.
>
> GPU's DMA engine operates with a predefined granularity when it accesses
> memory, it reads/writes memory chunks that are multiple of a stride.
> GPUs almost never support memory accesses at a granularity of one byte,
> like CPUs do it.

Ok that seems worth covering in a comment. Also what is going on with:

    fb->offset =3D ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->=
stride;

and then calculating fbend from offset + the calculation? Is this
because we need 2 full frames of storage? Can that ever change?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

