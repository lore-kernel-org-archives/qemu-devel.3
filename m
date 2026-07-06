Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43607C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 09:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgfBO-0008N3-Rh; Mon, 06 Jul 2026 05:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgfBN-0008Mm-DK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:00:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wgfBL-0000Iz-Qc
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 05:00:05 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1830947f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 02:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783328401; cv=none;
 d=google.com; s=arc-20260327;
 b=mqH0oMGrHbO44SGT661yqmvCdJO1quepxUKjpUalH+E7WP/zwzdxdqWshYk+q/aXPk
 PV3q+DAwnyiZfIikPy09r4uHVbswqOoz355IWKB0NQN378qDEAwB0D7eJdClMynB6eoe
 6mUoRFLLdpzHS55np8bLnugLkEPlrTEK/fCdi8rVEvllenM0GLmb6OwIIELZK/0q6VDn
 UoOJxU3c6Im7g7IvbFY0HxjDfuAsGkQE8gYjOVAh9QZAjs/JSdYb0Jd1+gAosWyD7KVA
 oX5ZC+VJyK36oW1QQEOUkPLi3MlUw5eupLgOhAgUDBN+8gNRevNjOxBuKxZwOTVB9Ft0
 tvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WHeWPUaAkM4cXRoHBXqKA48aBSt4i6dxHJ5SOSMWAFM=;
 fh=KbcBiSRmCMaMhSFvT/X1XVUYD8qObKwAfsoyPNAlJZs=;
 b=HlTvZLZ6cAy+Uxb/kqm3PFSFHM4ZP/kWQKPt7M3ZqSIrtEVOzMK0N1V5+FuozAy3Am
 m76P6jtjkkFaveIgVlDnY9/OcipPtc8wsl6v06A5y7eeC0jXQbmXcUc0JaF8dlJnkTOK
 VTSniHPP0Q+vSBiUputaqssbUB+RdCzIqGkc9dYxWpM6gBkACgJFUR3M0Tv1fzcOx8AR
 ETzBhldABMvQ/rStHDGLii1wsVg4vtM4StxiXD1rKbq1rHpRbXkrZfkv/uLr+CNEs+p7
 Eo9O0CnewAwyY33G2aMXpyeqwHG2038fvqVf6Ut0kB+T6qs43HZXXGT/OI3YpZY/sXSg
 cPmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783328401; x=1783933201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHeWPUaAkM4cXRoHBXqKA48aBSt4i6dxHJ5SOSMWAFM=;
 b=hdZvbWJjmcwIAGiOvI4LBfziMZ1iWgyDsu5wfHT8ucioaEpCZXY5ZqKzbzD5wKDms1
 nYqOjNcvq32XRodmb6XsKE5ppb6YIZzAXCRqFtqSkStXIAHrr2EfA5vr9z8mKgbB5bDw
 FZVD08hM3MOfi7ytzlILGlSYFAbgsr3xkqv3BecTE1fp9v2nk9PjmuCfX1C5YtDDYVo4
 BGiNkiaMBrNGNtu9L4g8k3QHnRIXwanuz+rMVnNrLPkQPKDJCsaQZOhqu84r1TvCmqAA
 fC8JmpRHIZivcAA6xHITzOdekvOfnjsNiEwKgID/niAq8bHengQ/7XSweNHht3vPt6sH
 kqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783328401; x=1783933201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WHeWPUaAkM4cXRoHBXqKA48aBSt4i6dxHJ5SOSMWAFM=;
 b=aBr5MTKYq7ieu9D3RQeaRqn/197RkUx2nJV5vevcrZFITlQW9+fSAyDS+BqCzMqS1i
 mnsKewrnjHMbrKyXBL3KpCNecbGQChPD3r2RYXXNHEgZUhhUNF4uReNaKGWXjdKseYql
 ii1YXbTFWsTDxD33epX5GHU+Z/JX763E5xesE818SbDlsWcxtfNX9VPEc86o6C2lVe3f
 hK+EVHJ1Zaq//z4GKQ8jERn9kL60nuZIT9R2GDCmTvqt/zOCyCmYL55xCGx/Cj6yCg0v
 FKavw3lKwJnLKxV1pqDHqZI+EPi9fywzXgMcRY4BRHCS9ORdZxSStORchjgKFRFvJgs7
 /k+g==
X-Gm-Message-State: AOJu0YyRGav5IZOQ/vmCpEf5SIgtpHQuEnEtCH211X/1wVtxJyeAgiDC
 XziHoQmt8q9zeo23LGWRXcm3HUsQBewlZE71VrkpYfX5OcnjwErPewP6RGHuN+k95UvWPw39ajy
 3uJO2e7r12uCNBHIGmVXxwdnSVOukkuwk1w4B0PF2yg==
X-Gm-Gg: AfdE7cnZXyzCuo9tV5+ZLPwV10VpnaB6CVOUBDqM7URHc3ckGY/qM22w0Cg8b/ZhDMl
 8c6i4arzW9X+Vqb6PDH4oGJKynJzVXWts3jxlPAJTfPr/qbB9Y0s8y08voFc2WkqzdqgxJYSz4o
 hbNaZ0Y9oeGOROtXH2tkLfCM5zZ/vq2aV3vCU46yg3PEZOab0hh//ItkirYVCcQBPCRpnEKttk9
 iftlbogEMOE2qJ483Z48wpksFwB2HQBuK7ge3yAxr3rCIHuC9yQYd0KeCUPd+1dwDCUlUht6mTB
 Xs9+TMHT1zU4waW3besgG6Ku8kBBKQXCj8zDwz+pT+qcPshwPn65sqL8BdefEDwIzaUYsCKj3tw
 56YRIkY0OxHwmDOE5fneMXppufN2esA26zUiLZwBkrckYYEixmqY=
X-Received: by 2002:a05:6000:381:b0:460:6b12:1783 with SMTP id
 ffacd0b85a97d-47aba8c686cmr9810063f8f.4.1783328400768; Mon, 06 Jul 2026
 02:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
 <20260705215729.62196-17-philmd@oss.qualcomm.com>
In-Reply-To: <20260705215729.62196-17-philmd@oss.qualcomm.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 6 Jul 2026 11:59:34 +0300
X-Gm-Features: AVVi8Cf1UTXT_DR3ZrMZCBIXNud7-9n0DPs6YnEr-hV5IB8VuRtwkjdWAalWK20
Message-ID: <CAAjaMXbuvOEA6gj+YKEf3Yw5ttQtCoqLRVTi0_Lkh7=W1k0v+Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/32] accel: Hold @can_reverse information in
 AccelGdbConfig
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>, 
 alex.bennee@linaro.org, qemu-s390x@nongnu.org, 
 Magnus Kulke <magnuskulke@linux.microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

On Mon, Jul 6, 2026 at 1:00=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Hold @can_reverse in AccelGdbConfig, set it when initializing
> AccelState in AccelClass::init_machine handlers (only TCG sets
> it). Remove gdb_can_reverse() as now unused.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

