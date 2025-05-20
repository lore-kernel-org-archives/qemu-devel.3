Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A5FC54E65
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHP8e-0006IZ-Cv; Tue, 20 May 2025 11:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHP8d-0006GE-2V
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:44:19 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHP8Z-0001fo-Sg
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:44:18 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad5566ac13cso435641266b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747755854; x=1748360654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9rjUu2GtdWAnzkigfyFbUXD/L72ubN/+IMNvVrpF7Z0=;
 b=mRcDSqRWlneDSgbIR7jYCnKQkA5ERopHDdnXQK0Sf+kTuRjoqs2ZcX/svQyrmpbTOC
 /6STMc569TW779G0mbgAAj75L6TQAyEG2vMEcNL8usTij82fUWHptPQ2mY1hOmHPn+gg
 /xE9IYZV3CgNC00/FlbP30yBVGNq/+NaAzzcZSfFy7oJp6wyYjfciVA+zVc+Wr2J4HVK
 6qBcxQozh2iVv6dcddYma+KDjOjp1Mj8hzs68KSyC6wynOTIc4XGC3e2MhGE1CJ0PPuf
 6YMhqhL1SUJkgBrOGmMQJn/zUI+/0cFcbwJo1hKwPiZ/vghDxAvBXPugt1RClxsVCpEc
 ZpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747755854; x=1748360654;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9rjUu2GtdWAnzkigfyFbUXD/L72ubN/+IMNvVrpF7Z0=;
 b=D9163ajwsKs5ntN2HbswjWAur/scECdtZ7ihqhdUigRrZOh9j1B4tC3VkgIMInCsFp
 fqm8tSHj5py3W/+zOxhgwxfe5KVUoHFnyzLRZUv3aLGWR4xVM/fGstEZn3us6hrR+Yut
 rEqva5/FqO9g1Rl7xp8epyi6Lr3e6ej/3O9ryCnkvriPLx2jtBfM4HY9R9S9e4kHBwUX
 SbVqh9/MjbN+ogdvl6fgRS/cjnNuubrUvtge4xacwZnL8JMhfPnI1GPPkiAUmUWriwrz
 Y8uJ4VSnZRD7E6RsQVfU46/pMIIxf7927sbX1teBVUq4EDK1GXnLbzGcrxzKsbhmi74k
 2W/A==
X-Gm-Message-State: AOJu0Yz3QjdWEKphlEItrhvHUBQsw3EbKNjQ12XaGAwmsf3BTZnPxV9P
 6GCFBPQ7HyOPZtzj2IKpSxFBmnPig3BcOuP8CTIqEJuCorPKj04UBclgjkKH6qsgdeg=
X-Gm-Gg: ASbGncv1xaruW1CdkXmYuFl6kXAryyKzqkVq/sEUy2/g+TPNOlGazQYmG/gaw1zFOeP
 dJdFlFagvVm2DZW8MY34ioGcm8mjpL/YgidB7P0+F5rAj2RGgO9RxuhLHtocKGOkmm/ZA6O74aw
 b9CzpwkKcu92opjQlWlepPwwBmVbZCAV0EEPDrdodSJgUjGFTHjnzyNWRJLBxt2ct/3Oc0vKSOQ
 NK7IyIbgFTwc9BtBhRdHIWN5mh/r5jODlSp12Z3TORluhfmQnoHJNaf9/DJcRrxpDmRtXeY7SMF
 xNHVGWeQxhTIpj59Jfy5nqhJ2H97DEugCbntjE3aCkgLAtWwMovh
X-Google-Smtp-Source: AGHT+IF+nl8NkJEBWSCFDO1/VoBxI3zDgzpcALMUOs76LhBSKgLd5nz1oq8yhB/TUD0P8yc4UZLBSA==
X-Received: by 2002:a17:907:7b9a:b0:ad2:43be:6f04 with SMTP id
 a640c23a62f3a-ad536f38b56mr1478768166b.51.1747755854007; 
 Tue, 20 May 2025 08:44:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d06d533sm748981566b.45.2025.05.20.08.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:44:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A13DF5F7A5;
 Tue, 20 May 2025 16:44:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: qemu-devel@nongnu.org,  dmitry.osipenko@collabora.com,
 balaton@eik.bme.hu,  qemu-stable@nongnu.org
Subject: Re: [PATCH v2] virtio-gpu: support context init multiple timeline
In-Reply-To: <20250518152651.334115-1-zzyiwei@gmail.com> (Yiwei Zhang's
 message of "Sun, 18 May 2025 08:26:51 -0700")
References: <20250518152651.334115-1-zzyiwei@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 20 May 2025 16:44:12 +0100
Message-ID: <87iklv9tir.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Yiwei Zhang <zzyiwei@gmail.com> writes:

> Venus and later native contexts have their own fence context along with
> multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
> the flags must be dispatched to be created on the target context. Fence
> signaling also has to be handled on the specific timeline within that
> target context.
>
> Before this change, venus fencing is completely broken if the host
> driver doesn't support implicit fencing with external memory objects.
> Frames can go backwards along with random artifacts on screen if the
> host driver doesn't attach an implicit fence to the render target. The
> symptom could be hidden by certain guest wsi backend that waits on a
> venus native VkFence object for the actual payload with limited present
> modes or under special configs. e.g. x11 mailbox or xwayland.
>
> After this change, everything related to venus fencing starts making
> sense. Confirmed this via guest and host side perfetto tracing.
>
> Changes since v1:
> - Minor commit msg updates based on feedbacks from BALATON
>
> Cc: qemu-stable@nongnu.org
> Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
> Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>

Queued to virtio-gpu/next (in maintainer/may-2025), thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

