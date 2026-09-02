Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7778C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kFa-0002yX-5G; Wed, 02 Sep 2026 08:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1kFY-0002v1-A8
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:39:32 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1kFW-0007XC-Ka
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:39:32 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-86162c086f8so13803707b3.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 05:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788352769; cv=none;
 d=google.com; s=arc-20260327;
 b=h29BNMzA5rxvT/+8O3Btf7Iw1WerrOpbC9260GIIdHxKeCDGmPOY8Zj8Long2esO9s
 rZdQ2sWV34wJ+ZjaaKeABNYrr0DgJoOkcZICWrmnCcQx2JPg4F5KWnMutRGAEi7Br2ik
 0Eds0CAuu87gfMTd+RhKzReRAGTLdZVVjJUFLRtGDmuo1Vzo5FtoLkAEulzAtFFEiPtu
 SgBn82NqNtjG6WYQ72LUT61bJBMIQri+g7NK6TB1A4xGvxqyldw9Wg9z1oDdpX20HcCe
 Il28c0iBazQ6ExuQGLfx57PmU8Ae5lqIE8kFO+oBBTKmHSBrjTx55AxWNVlCeqiu/K1v
 9ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=bbd7Juv8As/da/HkRccZIAK8wQhIyYCJRyivc0pdELY=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=T1uE93tsrKqoPgzP3mIoGKQekspMULbIbrztycwEO9GesRdK+K+V2PJ4zccMb4EPsc
 WBu5UdyIXft7nDZ19H5+c2t6ljRofHMjE0ZTjocfY4oMj8twqssdvPAJVfULYAB3Q+s2
 pRdcSXLNxljWuAyPCb5Kk68J/F6v6YLaPlrzwBwhSIJXUVrRkVfaQAeYIZGpiLwFKBO5
 ml97vqf0pam+Yws0RDoG4m0f6DQSMP8Q/CurhLUkO9cZZRsYLS7YDNOxSw4BY/tniS7J
 Rw79BcsEek4/6zgN2mK0pSd3k8MzJ/qjtNd/QFRPhcx/v54yBXEEdUIIXFW8vaOO1ARu
 stYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788352769; x=1788957569; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bbd7Juv8As/da/HkRccZIAK8wQhIyYCJRyivc0pdELY=;
 b=aklxJ0Ee2Bg6eZbg0fMlRMFnzcglDiU4PpiXIBOkzcemtOwBWvBYFr038LRnjbRBHt
 UK8KXhpfx5aJ5nFoVCe+Q461SaYNpWHseDjmw/SN8Q9Ql7UHkSpWV1oZrhULZbARBY50
 XE4HePdPfp2I3GKxXVYk5wl2yXtns2saYH1uxQg2VqzYfAi8Ba7OvbZBqAFWfhSBKBik
 ttFNd7OjbsaTf8e5x+0atDq96rtxA12cJ86yQvHaV0vDv7U3KajFuRq/ivHpINGtcOaz
 KfqQHcjJmMY/Qz4FNyJkIab3ClvFvxuSMxP8y+ZkCAQUqpnywOnZv9R1i028K+Un0oBg
 jgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788352769; x=1788957569;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbd7Juv8As/da/HkRccZIAK8wQhIyYCJRyivc0pdELY=;
 b=qdXbI1ZPKDN4oD0jTVGYI2E+jvuc3fI7ZW3CRADasT26JUl4uqjv22ugRObU4xqAEV
 TvqS3GUNbO6i/WMLuRbNHhQjN3e+dDlevssSRZ6duEi3Vk35yCdu2Gc40o9NOyglcKno
 qzxZzH7RghikA/X++ireeLIof2+LFpwZXMBy9SyrdriYKROfNvaLPVHGPXBINxXnGEuN
 AP1sTPk14DNzV3IYDWU+qrLPqdZVLF9LiQLR1IEbe8ENuGGTyF3wYaTRC8jcR6aJKiU0
 TXY2FRUDmeVht5yrCdUwt5YD89tFoDCUzEM8Bac1i9gkS7XQ3+RY5OMw+3lZiJmBCnLk
 QWMQ==
X-Gm-Message-State: AFuF++ngJ7r4ySbsgJ1xR6OuX9D78i3BB4N36PnOwIBtPZ6dJPRTfXTp
 fdS/F8ie6fIRoj/rnJc3VCOQUYy7NLB4hQtArmYqGYTxHqSJLiTHiGTBrD2zLU+ULWOZHgw1a9X
 dPRyWENh2kW03gk5Q2s0MMamDELR7oMSw0qp7ahYuBH/a+VrTb8py/xs=
X-Gm-Gg: AYBFou2Npc6L7q6LWLXzM8I+nZasblfxXr/z0/XXfOyceih2JUfdlhjYg+eXpBCQK0H
 x8lQzieVyZtd8Vu7qqIJuYNsEphhZXgPRKG2ZU2CjIWmvwWLMfunreTrswhdN4dczbSAz2/MSQz
 kg9AS8YvcrjDJTRoFT9BUewsk5OrCUwUqVoTRPxCb+KIkJjueZvKlaWduxD5vIFwkyM7qvrxkqp
 hl3m6aluLCqdIp0N3CsmizE5phhkoKF3VVNQHbOVsL81XoLvfwj+XSFac+KZAC+5D+jml/ED185
 GzqKASuwUz6oMnHTXcPtbEIXn8/hn9uwtubBLEjV0GfhlHylvGkpqFhrXTT0J4uIMn127EdR5QL
 dx954ppmiDpV7Hz7czg6p+ku2qOfj
X-Received: by 2002:a05:690c:10d:b0:858:bf8e:d0a4 with SMTP id
 00721157ae682-8694ec2d996mr54516217b3.18.1788352768528; Wed, 02 Sep 2026
 05:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2026 13:39:17 +0100
X-Gm-Features: AcwNN1XzTFnMtmb5IKzmROM81B5XsLtICEhIT7e29BdiE11LEQkU7ag6Np_T2yE
Message-ID: <CAFEAcA_DOTWETFdeV6TrV5cvzmj2-Hp9MUJz1Yy+=KXTbraOnw@mail.gmail.com>
Subject: Re: [PULL 00/58] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 1 Sept 2026 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; here's an arm pullreq: one new board, one removed board,
> emulation of various new CPU features, some bugfixes.
>
> -- PMM
>
> The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998b475:
>
>   Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/qemu into staging (2026-08-28 15:17:04 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260901
>
> for you to fetch changes up to 90789a83fb8b608f08a2716a3517c5ad743b3823:
>
>   target/arm: Enable FEAT_SVE_AES2 for -cpu max (2026-09-01 13:44:13 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: fix TTA instruction S bit for IDAU-exempt addresses
>  * target/arm: Correct reset value of SCTLR for arm926, arm1026
>  * target/arm: Don't provide TLBTR for pre-v6 CPUs
>  * target/arm: Don't enforce alignment faults on Device memory for SCTLR.U == 0
>  * target/arm: Correctly UNDEF Thumb T1 hints, CBZ, IT on older CPUs
>  * target/arm: add cortex-m85 model
>  * target/arm: Separate cpu types max-v8 and max-v9
>  * target/arm: Implement FEAT_FGWTE3, FEAT_SVE2p2, FEAT_SME2p2,
>    FEAT_SVE_BFSCALE, FEAT_SSVE_BitPerm, FEAT_SVE_AES2
>  * hw/char/pl011: support backend hotswap
>  * hw/arm: Add Arm mps3-an555 board
>  * hw/arm: Remove the 'musicpal' machine



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

