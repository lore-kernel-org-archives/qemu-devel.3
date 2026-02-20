Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41047C55ABE
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 12:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtPXI-0006IC-83; Fri, 20 Feb 2026 07:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtPXF-0006Hp-FM
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:23:05 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vtPXD-0002As-UE
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:23:05 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so302582066b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771590182; x=1772194982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JySoy64kSgswjAB7NAV+KziwfklF99yuvzjA7kMGbqo=;
 b=cGXErCKg5v6aLimei4e0ZXErSpxqUPQp1V6QY6KrXnxPGe6YfURu8ihU9gTuuHVrFa
 YQOFQNumUlcul8MdJVwg1UKqo3wb80caOsXZYtrTUnwqyu6vaPU1I2T8coGY5Lw4HAYI
 MJ65nqV09jspO4esE6LCCl2rSo8qT2+N1ZHdNkbtl535Xm8LR7ru301YbhUd8e+KnEAr
 af0YUFyzt9koxvovJtdf4Qv4bz6pPHijwPgbaPOfMdDQbbZW5gHCuR0+j1+wqzjK8dwX
 oCs73Nxp06d1hqdI3/aQ4KroR25n1dtFbI+oUX6rv9PTa8uiK3sUMrnPuEFSrVjlJ3ru
 ETGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771590182; x=1772194982;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JySoy64kSgswjAB7NAV+KziwfklF99yuvzjA7kMGbqo=;
 b=e/aBY5hjW+9M0N0e5q0ilQDwR7Z+lb7Q5Ml3cDt5rXWLffmZmIlOePCBHkANsuK5F5
 4RvmyVDRhu1+i3sGh5m4ygyLrvUISr5T19vnPkE9HokudM7bciy3Vnhk4TOLJ+hN2Z5L
 GjiCw+Ru+N2q+MQVmF/aXQypuwZ9iR2SLh2ZwG9mK/R9B17BFr08tCMENsYfp26fNE/w
 QM5WtUQIX649uvwK4YlOTbgOQHJVqHuYaAnViI2GKvMePKZ/lhJ2E6l8MFDWUuzKsXr4
 9u4TIDl38PD8wbVNqs53a9S8gpOQpBPTQSyun4T4zQkyOlf2s7OSq01jUq7u+pnebGU4
 6W0g==
X-Gm-Message-State: AOJu0YzsCREpQGjdE8mkwap0pA4Ga7OphbaNsF7aD6eUmp81kBY1C3cR
 rbbf5ohcEIgYoxV1GFNyS9cg+1CKLnOT62bAnH7aZhoPyy+mKiirxOsAYKWFc91iDo8=
X-Gm-Gg: AZuq6aLBtiq+OV5k0fYsJv7sZeF420/1nWLPvMIVwBpA3G/X+25LINPAIIsGG1Dk1jt
 top15U0Sbu0WCBqEFu9nvCNeau6jFagLtZoQgOWtwEA8zCH1/oXpKsYZNJEyCuM/EtJ0M9OAx2G
 Nx0/yFVw+GkCD4I/JEazDao22jYqaPu1g3qzGSDqapCSnfbyLrHMQLT8sRo2OjM0akX6oobBYU3
 Sefa36p9Uac5xanGgJFNFn9azir9odh5C0V3sMlUIHYLgtaIoWnG8By4gAcg7RSiqHNigTE4Gb/
 6vIpZylaXRPaFS1WLYiBxJKV0FbcTEHYJZlDMK+aOm/yIrjClrBKxLWKYyA84pVTDDRrbTDu8by
 JZlHJRPuUdz6GssqLYwGWGzWggIXyZbVgiU+NIRN4qo//nRWaNYH219qWil7PvtlS4A8jN5D5hs
 1nHrZvvwX6TLr1ZrCppDNcojuw7Uxtbf8qPQ==
X-Received: by 2002:a17:906:d552:b0:b8e:4790:d7c7 with SMTP id
 a640c23a62f3a-b903da48ee5mr569623466b.6.1771590181526; 
 Fri, 20 Feb 2026 04:23:01 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc763810asm664103366b.43.2026.02.20.04.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 04:23:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 27BA15F838;
 Fri, 20 Feb 2026 12:23:00 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Gerd Hoffmann
 <kraxel@redhat.com>
Subject: Re: [PATCH 1/5] MAINTAINERS: add me as maintainer to virtio-snd
In-Reply-To: <20260220-virtio-snd-series-v1-1-207c4f7200a2@linaro.org> (Manos
 Pitsidianakis's message of "Fri, 20 Feb 2026 11:40:12 +0200")
References: <20260220-virtio-snd-series-v1-0-207c4f7200a2@linaro.org>
 <20260220-virtio-snd-series-v1-1-207c4f7200a2@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 20 Feb 2026 12:23:00 +0000
Message-ID: <87ms1361uj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0c481e2125d81298a52caf7f7b51c3e4f026d85..63231747b0692f764b51bf367=
97cff3e9849e1a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2601,7 +2601,7 @@ F: include/hw/virtio/virtio-mem.h
>=20=20
>  virtio-snd
>  M: Gerd Hoffmann <kraxel@redhat.com>
> -R: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>  S: Supported
>  F: hw/audio/virtio-snd.c
>  F: hw/audio/virtio-snd-pci.c

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

