Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB308CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkJC-0007Q6-Ab; Fri, 16 Oct 2026 11:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkJ6-0007Ol-J3
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:57:22 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkJ4-0008TW-Jm
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:57:19 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso523257b3.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166237; cv=none;
 d=google.com; s=arc-20260327;
 b=jdaiHYaxY3rQlI5a73XQ+sucDus1kLttBWKr+Ke4cVxInq4iGubSngHJuJMz+opFmP
 hDa5BaiAAOLmhGB35o3nPsmYpmKHBQJq6I4n1/Wa9ysu00kACvWvZdDiTFTUMDFyvQnh
 eBoTieR0JmvNl8XO0fWchOOJeQRy9S8Q7VRY78TbpAsCfMnbsLI3soFSGdEP99ReCT0o
 wJLob43lCPG0+MlnyhMsuvADN2zzES5ZCfGRMld99PrOlKfKF/2/UxAxCEuDwtzFe3h3
 pIdOcinF00ZfekyhxDyaFUhEPgydjSbUwOyW7xFn5JE45FhGjwcf6cCAKQizXNytIFL0
 f6JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0Bv0jhAStudRjf0YN2Dnq1S4McAGYgpTwxwO1ue/HiM=;
 fh=zk3zkpaAUYNnBGm/wk3w1P+ppxtrUGqeaW4n7HVzh/g=;
 b=drHtMlGtchXGAz4C5yo845J0lF+WIfpFrGy9xnX6hoO+9CeTG698VfW+Yz8jnZinpz
 5OyH4IsmeD7avLb+cWSo/1fpsV1WxIg2Okntt/JAseC+WuKa02J74ctzCLw5ckASKFKC
 osG4y5yUKTQ5h9UsGcrdbzprkqFes1FMJAgrTxcYU7xPA0XGD+5zc7vwAdl0JZI16Paz
 ca+PrgKsVJ9Ayyb9lMHZbei/mJUFDy1TOzqi8kFRawCJQIh/cZ1TWep1/NxBb37RymWg
 R37+Uba0CyN1h1IBR/XYfAEuLwFbeShCK245nD+m60SgcjfBPYOQchBg6mfGwFracSaZ
 EKWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166237; x=1792771037; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Bv0jhAStudRjf0YN2Dnq1S4McAGYgpTwxwO1ue/HiM=;
 b=f568sDYRmgNs4kMSdb034Y3U8LkAewhOM0WAWKOGtULDcObm900X9kyxx3mOaq7Fd0
 OfINbzqyrvYTUmJEai5EpDZPAmQuYL3pw/EB8dxPZ1bhsAskuyXJTqswPDp3saJdctTm
 noOu/M6/ZboM+1JRnLEzi9h5x3g3rtIdFEec9wIVruBn84l3gwBYb+onFHn9TXuIMCsq
 M0zw/Fi9Jxtw5/aQMpIYY2tTvbPy0hVsHSXwhQborM60VMM/U1NcONWnQqi+Me4em3w+
 hkgU1eX5USbYY44KkFwPqu5adkL1LpMtdbLjnhQpgNx4WnldhwD1s/CIKkxiaKhLwq5P
 u62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166237; x=1792771037;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0Bv0jhAStudRjf0YN2Dnq1S4McAGYgpTwxwO1ue/HiM=;
 b=GjPToHsVLJe4nCDJmBuqspKDkpBKaaoQ5thWVakFMP95+vi3oVA2prEaflEtATKcod
 fejrPvL+JtdElZzC0OpwTCBJmWiMe4DEb+gjoz9ICUxPRXNEsCab9RoHiDRSWBaKtZlL
 QdHckjTKNeZxKwOZKNSI4sFwjg78rukCCI12xVIBpom2F4dt3dJ7SngpGLeBJdl3rpAg
 ENLbyXyLI+AG4zvvhmAJFUocdv+Mr5m2Endz4Kr9rsoG1j97u35Dp03yBjBcz5LbfWcZ
 6N1m+CWfa0SnYCLfxRtkKR7P5tjkqCwx4uiVflCv4qD0Ej8dMloTAf4X+1lqAYLtGC/6
 4eYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQOYGsbaDL1PitFbT2xniL0rdcXU+VH3NDx4aTBnYtyxGFM/OjPHRnhTG8+cKFRDPjPjBzA2yF2Y0C@nongnu.org
X-Gm-Message-State: AFq9FYIN8Zt4dGVycI2+OShM+LdGSop1jO7JjDQbYDDduP8y6ToxWJcJ
 MKrmrIiulFlI0Lf12GbDwvARXQB5Fto9kfrbp2P7VVudLHStljahvPwymkIPuSChR45AENPwiRW
 jdhaKQj4PnXvPon9MK5wc0rCuHuJ/aVpt4fSuaiCQkg==
X-Gm-Gg: AYBFou2ZQ38afEhmlwBtaA30BIz22rJZJDf9lsZFtNBDzrgXo0YRPNiBAzB58/Bw7lE
 G8va5n4qIbGw8re+cFZ6IotoMs/HKFvif9evDL5rhzi5pBegPdWMiRvsMZfr6KZg3fahQB4xbad
 cRVke2QX/JjQo4cb6H0ZwRMp/5+uZyW3swqHT68EriwxBx7kPjjBiaJKrxS+jBsyoM899cvRcLM
 A1AKRDaLEY97gtDuLGTSKTUSK19J1AmtZiw7aEoDUJfL170J0P5z5SvV1j2pq0AcckTsB+WBluO
 F6hFmGesF5Qa/cI8CKrLY6xti6r/OusawJOt01CIvy6SnnWAjnDSIGN0xuH7oMIWtp+Z91zhs2u
 wQUHWAdDPV0eIZzHv2D/y9XMAB872wmqdI/2ssZ4=
X-Received: by 2002:a05:690c:47ca:b0:882:31:3af9 with SMTP id
 00721157ae682-8b0f2056721mr1329977b3.9.1792166237384; Fri, 16 Oct 2026
 08:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-9-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-9-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:57:05 +0100
X-Gm-Features: AclHuK9_tRimGSW5gwJJGSJpXxB0ZYcFgojChYR8ldRgcNm1LmSPVOQJU6cjInU
Message-ID: <CAFEAcA8Yoi-8KEX7ZfKckcG0m=WtKaSwJ8tzJ0K8-ubd6t61YA@mail.gmail.com>
Subject: Re: [PATCH v2 08/27] kvm/i8259.c: rename KVMPICClass to KVMI8259Class
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 16 Oct 2026 at 15:22, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This is in preparation for its use within a QOM type presenting a single
> KVM 8259 PIC.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/kvm/i8259.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

