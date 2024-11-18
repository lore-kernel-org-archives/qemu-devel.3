Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05042D49209
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 11:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCzW7-0003zY-B8; Mon, 18 Nov 2024 06:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCzW4-0003z9-BA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:02:00 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tCzW2-0005IP-Lg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 06:02:00 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso533557766b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 03:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731927716; x=1732532516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6mWA2zHau7ZF85E+4uoNKja344YN+StSZiierbNNxE8=;
 b=Iu8z1jYp7Rgd7YeIg+GgQov3L70JbSYx/ONfT5S6yaxar7ktaLF9ZUgJvVWh9OZ3RB
 8e5KGK5mf3TyiAxWrufrWYELBiQavkRdve96dpUf4SNr/sQhGf3VW8074NaQ8Bgqw0GX
 PFxDdxRsAJ1xWje6+LEhQjt3nCDBvdIS40+L8k3uOblXNZEaWhFNqqEwBf44tH9SGWSL
 SOaPPGeKP1vCBasWSKkKgEX2sFN55xkDJ/3TKSLU7Uk8AnD8beyH9bZq+l+ZKRxoi2F0
 klJVhi21eUFMR95W5SDdTlR0i0lusMg5NB6+fzX3rcrLMfHCWOjOXFqA7vuPdP06znsn
 IkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731927716; x=1732532516;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6mWA2zHau7ZF85E+4uoNKja344YN+StSZiierbNNxE8=;
 b=W9+glBEvyoFiJQVBkcQoGQxpK+lLiXjIFCSr+fHIGuJX9xhmVRUZasQBogfCYPe8kn
 txDWxEghJPr/TFdXiTw6Alb2NvhbtUzKK0DaGNFq+WXbd+49JJJLWtariXiFk3MmCI4N
 3TtRdJusojrokcq06BhLKz338ATJv8kE4GpzuZZSKHBQJozllC+OYDrT4Z3nFCBCqnxW
 5jGwYcp2SyJOSW/K3Td9NJzqrT5D2sImREI0Iy6HF7YUK55lMpFKmG/EhUdg9gIJ0j3j
 VmSAxLN2bvq0PaNg+O0EqvJOOJdI0AYKrs03acmRjiRaKfPMhPAYvVnnEbLYGFemIN1X
 1kcw==
X-Gm-Message-State: AOJu0YwnaS4XnBRCw6GI6IF9IT0TVprDPSK/I9llyhhNO8KDtx2ZaM4Z
 C9vgx36fQfKaqS7oZm+VYud/2dydGvGjNv/JJ47CGVPhKcnUmcU/41JoVOvr+03wPQ/ltI+pxjx
 1
X-Google-Smtp-Source: AGHT+IFMJAxUB1jWUszJVSKsk3obRL4F67eJrcJ8lSNeCbgdcRAJgtmgSM1/qsdCjVSn8W+xlXGEQA==
X-Received: by 2002:a17:907:2d8e:b0:aa4:777d:7394 with SMTP id
 a640c23a62f3a-aa4833ec1f0mr1074812066b.11.1731927716447; 
 Mon, 18 Nov 2024 03:01:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e043316sm526114566b.135.2024.11.18.03.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 03:01:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 04CE95F7C6;
 Mon, 18 Nov 2024 11:01:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] virtio-gpu: coverity fixes
In-Reply-To: <20241114085241-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Thu, 14 Nov 2024 08:52:54 -0500")
References: <20241111230040.68470-1-alex.bennee@linaro.org>
 <20241114085241-mutt-send-email-mst@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 18 Nov 2024 11:01:54 +0000
Message-ID: <87bjycu7od.fsf@draig.linaro.org>
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Mon, Nov 11, 2024 at 11:00:38PM +0000, Alex Benn=C3=A9e wrote:
>> v2,
>>=20
>> Fixes after Dimitry's review.
>
>
> You should CC Gerd.

Since 2f8cd5a9b6 (MAINTAINERS: drop virtio-gpu maintainership)
virtio-gpu is currently orphaned for maintainers. I've been reaching out
to various teams with GPU experience (including Dimitry) to see if we
can find a replacement maintainer. For now I'm happy to test and
upstream odd fixes.

>
>> Alex.
>>=20
>> Alex Benn=C3=A9e (2):
>>   hw/display: factor out the scanout blob to fb conversion
>>   hw/display: check frame buffer can hold blob
>>=20
>>  include/hw/virtio/virtio-gpu.h | 15 +++++++++
>>  hw/display/virtio-gpu-virgl.c  | 22 +------------
>>  hw/display/virtio-gpu.c        | 59 +++++++++++++++++++++-------------
>>  3 files changed, 52 insertions(+), 44 deletions(-)
>>=20
>> --=20
>> 2.39.5

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

