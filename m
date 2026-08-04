Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53494C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 15:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrHLo-0006Dq-Sz; Tue, 04 Aug 2026 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wrHLj-0006DK-CP
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:46:42 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wrHLi-0008U2-2D
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 11:46:39 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0794669a6so6682289a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 08:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785858396; cv=none;
 d=google.com; s=arc-20260327;
 b=dvaDhI21oksxvTEk64dlMQh+Ou2ifDIlcs8gBxAEu7OHur1ToNPyLqvNOqULngc/Y3
 7F3aWKn60iqjfQM9NsMivMqHOO/f1fAHyOMXK9j5De2TH4Pqxigvhumzg6qRJ73RgYtr
 gKbbR1f4a/B3hGGHeNHq1QOexkOMILbZl31eUHp1qOeHW/tfQmfstavVpvJ2RwN03tKS
 XM643FaRRPe9MENdUd7YjsWtychEb+uMyhi5f3agB3B+pdRj1G1XfeqNlN/ddXNw1WzU
 xBQ7+758YkfAghbPEVLojJhmTNNRnvMtnSynmHn+AwcpjAM5gS7uQ0k20pQ6LtWAuGNk
 MXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5hRZkUBov2oo6lhHiXMhi3iCVaISD3LAqJHT9ycCdWg=;
 fh=ErhCrVLVjWLuNVM4dnEwne6AMWC8gdwKuMkozzRcRHc=;
 b=MDyxFeHXRbQMfDmnKoIATHHBf1kUFN9XNiP2bYvwYxPtDQTZnPe4DYIwJqwprhomvj
 2L+cMyv+TtHVLAMd+Ycyx9mQY55+Vp2BhZLyvKwEbiHgI0F5ZxoXnWMq0rpzWYtKp+CM
 EltUPG2NHLYjUJAYyLZRRs8BlSZd+q1UVjViS9Y3XkmY8unNMhtOdjgKA0SY94+Vtf10
 rsFPFxSUoBnXIaADUr0Bw/Qh3YXeRye8GgbLtylAsOMQJXb9ZkaEr4F+W4T5OIjdvVHO
 I2gWCuoql0iRDfLAk13naGyliRif/FbTJwR+aPpEFNw/tc1qo7dPQ9ZHHsygmdcf7D64
 FFCw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785858396; x=1786463196; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5hRZkUBov2oo6lhHiXMhi3iCVaISD3LAqJHT9ycCdWg=;
 b=ZPHAuD+q7arjhcZEirKeAxsE1qoaqyulwDf1emY4h1JIfEkwkvnUDaMb1Y7Zc5ikt9
 2JFZn2fpsw+OMum3CJB2TGGXZc1uCxbfCkpy5CLQ4O9XDF+dGbuHY8rDNVYDLhHljbH6
 G3Z1wMkIOfJFMX+YA0cgzkNJhqdPd2et0fT3AlKHt81FmE8vUROsieNBLvxRbwaCdaTk
 6UdZyGo+jLfCKfTrqVHJLXw5YlaHODopFL8YbEBto3mirE7fSMc+0dGkE/IdoAqR4VgZ
 Kl1boDd6VNG3KH9VKH6HX++Te7maW+Z/dWXFsGIxUw7srcqc8fz2hO9VzU4FQj1CDo5w
 hqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785858396; x=1786463196;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5hRZkUBov2oo6lhHiXMhi3iCVaISD3LAqJHT9ycCdWg=;
 b=mpoCxPg/j4oJ5IhshUBcvWXNBb5ClzMVPUVwlIgo24/e57Qv28WcngNJ7/j0iMvRNK
 /dYNjpSFRLs3SZJlr3/gXTfErVrwkBpgmEBIHKeT6r28H7J68owWuLNXm7qkg+taJCDI
 DVeISO19ELWYmYpOfuTxDrW1qer0ZE86iHfgnuAm8dxukG7iS2YTq95lqwXB6L5jXvnd
 wNov12J6YaQCQ3dwL1FGX5wZBoKpXCvZeVxRQ04YVWDecDu7FGepJtCR9iR/rWeRgVW+
 GWO2oSLeIuUbcpCU2so1GKZO3+RFRPOHw9uc/BEbd+JIxAjDiltWVH0GMMzCLJHqJi0I
 4pMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsJ4xIWXzLZK7ASxXB+zDfjY4Vq9IgsUhSyGG28zLcFD6F/aUsA5EffsMfq5bnINcSiS28wAbAQ4Hc@nongnu.org
X-Gm-Message-State: AOJu0Ywgq6CviRY3r6dHY++S1vWN2ecFFfe05sR6Nkmo8Q6fcdTdfupn
 iQoN+n6GwvThkTmh6toshhb78Ib29zbfZyR0tY7sx0vS7OYOs4rEp+PHmje0i2sGqU2S+DerBoR
 LQMhicXjQd0ywyZGNrR2mtLuTMZHR+kA=
X-Gm-Gg: AR+sD12HoUNsVxFcjJNcqzsYQQ+PvY/ZEHJ7qm0X4PhGlCwCDxwxcP/ypCqZ7mSGc/s
 ExNi6zitqPlN6rbYbGFBm8rDoHF662+jwssg5w/Tanupe279inWt/2w85NFrB7txVaHYFcuI+Vm
 TRco1WDHtGKaxIh+V/VEjVKOva6Ki+UI70a6Rje6we7kcbuIqsw6vPiRt1dhkGTkEr0tSdippuw
 gnye/rKEtCAOfW9a2sSL/tHmHdjKgc9mitz0jhjFkXXlMt2oVNMw95SxWyMg6IPLJxHIJ8Gc+B4
 dKAFp21wtSnvZtRTPbTuseJeiximjCFBGmoJpD+e9kghj2qGVmk3denvivApt1TjQKvV3SjJp2m
 Gow==
X-Received: by 2002:a05:6402:52d1:b0:69e:8ad:5162 with SMTP id
 4fb4d7f45d1cf-6a0a7c60ee0mr12890079a12.1.1785858396422; Tue, 04 Aug 2026
 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260804121000.444745-3-hi@alyssa.is>
In-Reply-To: <20260804121000.444745-3-hi@alyssa.is>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 4 Aug 2026 11:46:23 -0400
X-Gm-Features: AUfX_mzl88qsHpx1f7GKHGeFWfVE4rOddYdtPMVRqddQY0GH97n9c0RwEHTLbmo
Message-ID: <CAJSP0QWtiREX+8Hoek6edYDacNm07MqnzfFM6daGa9tWvMyMHw@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: fix typo
To: Alyssa Ross <hi@alyssa.is>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x536.google.com
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

On Tue, Aug 4, 2026 at 8:11=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>
> The protocol feature is named SHMEM.  SHMEM_MAP is one of the
> requests.
>
> Fixes: 588acb45c2 ("vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec")
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> (Resending after accidentally not sending to the list the first time.)
>
>  docs/interop/vhost-user.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

