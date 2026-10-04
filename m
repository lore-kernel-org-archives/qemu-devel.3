Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E31CA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDP2c-0002H5-4h; Sun, 04 Oct 2026 12:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP2a-0002Fy-O7
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:26:20 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDP2Y-0002Ab-Sx
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 12:26:20 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso5919317b3.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 09:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791131177; cv=none;
 d=google.com; s=arc-20260327;
 b=DMohpbMahf26W8BOEecwrs86gNzmMKIN7XAs9SVg5QoZvyqUzZZJhDwyx2p3xLsKBI
 TSFZjECKFXebyQWgZCuzujC5LRDizFJjNRtYEADTIthvD57bqOHNCmlZN1fyRtedcGzI
 b4oqzeP4CCyQF4c711sNiTuPRmvQ9O41Xbq91idWm/J6Awo9nXP3JBfIJ19d+hBZE27D
 TQ1UcrGLWRPzWSgfniDjSXCrpKBOO1D/kri6Jq/WovJDG/3WRpzbkoJ1GaPg91KEtFWQ
 eESjD5c25ECuD27nlMmqyB6Kp3NkWjX1EURRU9YOFJadQiPgXBrNBP8fzSPqFX3l0KGI
 8ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gCMwWED71tLTeIT5hEmttxjS62VodQBS9PEI5/PVHSA=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=kuMdrBsqYURfBkVRGraI2waP/MOQWWVeofWkKFiwWGGo8eOjKroT1YFaRit8yc7vX6
 hknxK/7sjyCjUFCcP2VQLinHZN84YMP1FnU+2377kTOh7hmaFdtNyNlNfaF1DyQjKDXr
 KH4pjaxGIbiR8gDtjcsROU+Dxg9cCmsY+bh8qdTdKEXOZ70cxuSMGmdmPUbgCsEHCLPr
 hOGJ7JGUKsdaWXyZsamXzCVXnS5SMmiKHPK86JFeBBVgSZN7iNdGlOlVNwhLQ41IPtQU
 i/r2RqHsch6geohsrr/NyCToe/ifXDIfWblBdERHOTLmQa4mIHPun5kwgAZYYOdQADYH
 NqIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131177; x=1791735977; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gCMwWED71tLTeIT5hEmttxjS62VodQBS9PEI5/PVHSA=;
 b=kWsGcQEzM+mEU+pPaZ2TAaUQnb86rB3c1zEXxfA/BeEYlCEkcddBlIMVVWvywPhdRw
 g7CAADygjunASGtbOdaZ2DXZkIb+rqf7fS5oAxxRzC/clCVc4Kqe9kFyybWYtEPJ4zie
 ttAk5sTCT5Ot6mTueFhtvSOK8DR/LuvZ02XLaPNJagjXupAw/Xsl+QKokMI5yMD0fl9Q
 ayx721U+PH1RDxNbK7sIdXmc3LYkpcl7AGqwST5GtTAhNm53HbMeGphP0jPWkdd85dnr
 JUTXy2jUi9H397WLbapWGzV1vAVAhHWUtEellvCdaTMUN4lVIf7jAzJ6lRgCtyk6PLM7
 m/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131177; x=1791735977;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gCMwWED71tLTeIT5hEmttxjS62VodQBS9PEI5/PVHSA=;
 b=bjfzzqhkMtbcEqsSuXXUcEpa4Relqp/YHW+UB+I/RoOBgRXz84KLfMUtFK31QY33RF
 Ny0eRt5aX7qPTTuIqheQnmyQBc9ro2+XuDHCUF4plrQCEEEVzzWFFpd0Mh9JS93kAeWp
 jGZW6cRD9Keij0Noa1FoCpWd5dIRXxjlaxJCjdUj8t4Vzt36gp98Gyg4n+HITUs/bPlG
 vAK+hyQ0p4JtGurEKgTXWuFw/Q4BYRvR/z4leNwsOuH0QC4KwYeBolt8HnQma2PDCu02
 lSYq+pd0pynAUbezhoYR2hwKWywaMVXMF4MGzbAksYwIgqwb8RXlkV1l7PRfkY0b46NF
 gcNw==
X-Gm-Message-State: AFq9FYIjlCxMn5Npypb1d/992vy0wbVWTAehjRLdGCSUULXKsm/dQ3Yw
 SjMrvTlnzsx9YPG/3iZOyvntbvItE5VyTQgDd4beq2H8elRT3oOb71XT8Y3HJ9jPWwNm+rAaLUo
 EVavCY9Y5ulml60t88MzhRw0b2Gz+xuQ=
X-Gm-Gg: AYBFou0k/AzYsFH2Osh6Cn9ooA5vU2BctUgnaNnq3IPVP1MRiPe6BHS5J28SIXwwUlR
 uNxOG8dgmIpmcM6e4RpJ21EjKut8TYtUA/NQYTsJMhRcpcD44qg0vtH7ul20unF+LIfzUELDmCq
 d8HuRTNp4bfn6AJzzBy0B0PRnBKaCkvV6QzwlThiJJTCFAsJAlsWsrSmh/w+T6Ew/S+D9rGA5Qt
 YpIDQtHur/Scwo8ky9F3v2y2FSvxEo0JpMXT/XHrYdEblE30Y9pdBMtM4O6WQqDjO8v+S7NvIL2
 521mEoO1VlNcc8RNZA3/WqKFnBbOC164T9yCnbnJdA7ty3MzjQOksLWVIRoXSiOkQ5T+rbTMwNv
 zlE44524AHWZHkh0=
X-Received: by 2002:a05:690c:d8f:b0:8a8:8945:c41a with SMTP id
 00721157ae682-8acdab6c34amr49674117b3.3.1791131177644; Sun, 04 Oct 2026
 09:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-31-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-31-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 5 Oct 2026 00:26:05 +0800
X-Gm-Features: AclHuK_pU_rbdup5VKb9QVrW-iEijpIsgjS56VrcrlMfJmbyN81LENXo7UuueSI
Message-ID: <CAEUhbmUYrVbTZ93h9mkAL1e=1UntZ1XXy5hp5xZvj9M8YK0E=w@mail.gmail.com>
Subject: Re: [PATCH v2 30/30] hw/arm/fsl-imx8m: Fix typo
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112f.google.com
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> This is IMX8MP and IMX8MM, not IMX6.
>
> Fixes: 0c105b261551 ("hw/arm/fsl-imx8mp: Add Ethernet controller")
> Fixes: 857670200c51 ("hw/arm/fsl-imx8mm: Adding support for ENET ethernet=
 controller")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  include/hw/arm/fsl-imx8mm.h | 4 ++--
>  include/hw/arm/fsl-imx8mp.h | 4 ++--
>  hw/arm/fsl-imx8mm.c         | 2 +-
>  hw/arm/fsl-imx8mp.c         | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

