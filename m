Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDA3CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 21:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdH9-0001RY-Ag; Mon, 25 May 2026 17:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdH3-0001Qt-U1
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:55:51 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wRdGz-0006sO-Rg
 for qemu-devel@nongnu.org; Mon, 25 May 2026 17:55:48 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5a995ab70d1so12144403e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 14:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779746143; cv=none;
 d=google.com; s=arc-20240605;
 b=Oj0+NM+1495TKxOkhE3TFyA2MouOz7yC3YwhCzonTadygd5KRcOBY/bDj20YSto9VQ
 cEoj4kKAPpSkQf3F2v/S8LGnbczA4RITdWxMqgBuiZHwKlSgH2/G7s3ylXd5YDx4xJXA
 PoYbPtxJxubx1nKEDlX++e0p61PxRJX88txv8IHUmHWr1hsxHlpv9/A98gk8Ywf2ttuH
 k+Uc3/lSAVyOWD9HsTUPXdSZrBRMp1fvL62ux8+mKgja0Jrx7bWCPjI64oOFNV9SLnMb
 XvJ1Dh7ZdCVNWs6vuBhquZkmOLqsJJQxY2EEDcZrxES5Cdl6K1fEzn2P5TaLK+jgyOnc
 ZHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eUhEPBi3LivwxayvyV86Esu2W/1SF8qcV29vw61T9iU=;
 fh=VDGqiENZLmjMFMZWY1xbVB15zxWtxE1H+z48zMSi81E=;
 b=Z6Jr7JePA2bfjCACLWg2e/FBUhAbeaPt2P9dWfoFU921ePPD4zBuludg8a4PRV+b3J
 S1wt9jcc71ugf6OEBpt6tKoT3OVD6f4KuiFUVIHFcgmRDoy23EuKyGPb+je+wqtYnv/C
 N1be26XFi3UZmuyW75DtKqAqnV19FM3AhPttMhSL6BGOHOLsf3uIKBZBFubZGC566GPD
 NsQo5XP8J0zUKDBn+x7/hS4Dc+0+OSZm8kUl3GSODiCAJo4ETxYh0JvHF06FZA0XNZbD
 ytP6Thm35wwlyrLBQGlO/gn4udrydJZsM2fbMNIyzmrN5R39gMPUb0FqGuCHDksGhUUV
 6Diw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779746143; x=1780350943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUhEPBi3LivwxayvyV86Esu2W/1SF8qcV29vw61T9iU=;
 b=c6Z4OH61A7rIdcjfnp11HvFd7RjCniQ7sr9+fLg2lfapB858hZZo4BKVjO5/Jqo+X4
 Yv+xsyevohvKACECzGZGkHSvKRm3E3Sa4qLI5Oa0wgNOsI1Da16SeXMvKR+RZXl0MW7V
 DnaSctv/UmSOGIQjIIZLr4J8tdkh3vFlo0k5UQCTX5z7/07APR4fjSmW0dE+mWKUmWCh
 AdIJu3KCkBK/yqCxhGX//pRHgijXJu7cRKfV5LALZBwdzeVmdAAr+9pKJ7LOV6LB5ofk
 5lFI8w0RomkxQrxAIg1u+SX5ql9CmfM4n2XTwRCT3GJyymaO9rV9tbqokuVeLdAyEes1
 VorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779746143; x=1780350943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eUhEPBi3LivwxayvyV86Esu2W/1SF8qcV29vw61T9iU=;
 b=FdDZAztxYXfa/Hoo2xpUiy1DYbYYjHxTxdu2HzbtX5QGKHMiXnxtnwVPSK5WCyTuBq
 2cd484wsOpT7sJyz2MjHnMP9sbvAPBhp1MWxyoKpIeFRq2a6F2uevsmWg4ehU6qq95tc
 DD5AfCvzYb3KvJrWGH0q+lvF1iFRYGdOkC6Rlx9S1YYevb9fJQjSp7VAOspiELQMD683
 FAC28iwzBtH4JVlwAlMD+ZtSNQwk47qEPMOsuAZjXgYuJPUq74reEJByInHDBdTw4qRd
 OtDuX1burIQ8ZuGNEuwJxkGllF+yOV0xAPKDP3wDxDGSGD2js1Mys0F20Kn5k+1Xwp0r
 VV3Q==
X-Gm-Message-State: AOJu0Yye9o8y6uVGxyyewhQRyAbV67fl7wLo6F1hfLeqTAvsL971Fgl7
 OIAd/Hh37mXjRisd5UyTPZMsQjV0cnS7POT/2NgWvbfFdDonNqlsYKhPI2SWBPqSO5hMHG+GWWJ
 VNuGCSOOtq+HADyUmTmJL7q3aa+7wYMeLM4R03ic=
X-Gm-Gg: Acq92OGZGp9fOVT3iFsvkS9pDGTQTKFKjSOl26RIto5fiyynKHHYwssYIbSNknb9Sho
 3ZjrLsLP4Pq40SHqR+bDttjd5+NLUyz0yiDltJiszdlLq4Z5jKBy5PpkAeAVvcEed2sYH+ASNZO
 C4W+xD+A/b0/7ds/c3VHg7WDarcmYA2Ani7hcSW9tXOpRHtKfNPYJrEONBpnsdJT5Vz5JdTEWpa
 dsD8Vy3tmcnwPTvBjWeBRtyMGV2M7t/lPWolwVBY2VWLWGJY+5cEhtct9ujR/LEHiBVriVl4xxO
 Dev+O+PAWg==
X-Received: by 2002:a05:6512:33ce:b0:5a2:a3dc:51e3 with SMTP id
 2adb3069b0e04-5aa323ab2d9mr4569064e87.12.1779746142705; Mon, 25 May 2026
 14:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260525152642.4121729-1-mattst88@gmail.com>
 <20260525152642.4121729-3-mattst88@gmail.com>
In-Reply-To: <20260525152642.4121729-3-mattst88@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 25 May 2026 17:55:29 -0400
X-Gm-Features: AVHnY4IREey_Of1JJqpHKsFLdh-AaEW6jFbPhz72pJOrYHqG44UDZifW0ClQx9g
Message-ID: <CAEdQ38E3Tkd=EBtoScq1=ywJP4e09EcUf4j-UfHL2HTXEFoyHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/sh4: sync fp_status when gdb writes FPSCR
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 25, 2026 at 11:26=E2=80=AFAM Matt Turner <mattst88@gmail.com> w=
rote:
>
> sh4_cpu_gdb_write_register() wrote the incoming FPSCR value straight
> into env->fpscr, leaving the derived env->fp_status (rounding mode and
> flush-to-zero) stale, so a gdb-initiated FPSCR change did not take
> effect for subsequent FP operations. Use cpu_load_fpscr() instead, the
> same way the adjacent case already uses cpu_write_sr() for SR.
>
> Cc: qemu-stable@nongnu.org
> ---

Signed-off-by: Matt Turner <mattst88@gmail.com>

