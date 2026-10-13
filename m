Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C12CC6B16
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGeeE-0003Qo-2D; Tue, 13 Oct 2026 11:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGedy-0003BS-5k
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:42:25 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGedw-0004PV-K2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 11:42:21 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b05bf699easo22936317b3.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791906139; cv=none;
 d=google.com; s=arc-20260327;
 b=p3GWCpnK2KKB4+2nSSRC7IGsrT+BEe4+7nyGd9BhV50mN38HaNcZhB/R7YwAEKsS4T
 B8qx1jvcFUWJ4dwJtmVLYYCWMllkoIuk5vvQpVhmAW2LJ4fCQEtu4IDAUTralVQzKrHY
 EjWhC8MKV0p3Y/ebJXNIezNCAycpvh2W5r9VaCjBbkoCnZxQhQPsV2/wA1CotcQP3BiA
 T40ls3z1PCWe3kdFe2k4RuW+p2sB0/tMWybwkrnKF96bQ4p/ox4IPeWqjcEfJTAlnFiV
 q3yqDKlhE8rCYvdqiqNxnIBMZI6OOY8XNUh4lydzFOs7TadU+a0Bb5LBtWJtmgd94d3j
 M/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Rm0LyYlJ+YzNGdvtjIb3BVxriPsy574YHZ4IY77q+sA=;
 fh=lcxT++mUnEdsJVXMh6F9MZkH1rKcJAvuwIeZznSAPao=;
 b=MsG92sj6Wq+5L8Dw+w0zJiHF7VagZy8mYdzMMj7Y7gBd75WB8eTaN65nxbhafn9kdg
 1AWqIlQhyCzhk24JjvKL1work3RDeB0gDMkIGWMa2EtVVOZA/0vO4V9rEMEtwPZ7Oh+Q
 Uf+aznGL/vK6Or+ZPIYLCLRyPmAOrEyNMx2sY5lc6Rni5EYJeF4Pw6shvk2a5yRUrXmq
 lUzUsip9PG2Mm4qLPIya+9Y8jcITWpe1/OSvJlwVsON4VfZ9dlMahiPTGnRTvtGTO+Cn
 rxXaxe5Cz7q4NCXzCzslkB5SdrSi7rkWaAOd+2LGUPfOA2tfk+2f/u7MzS9uCC1a9f+K
 2cEg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791906139; x=1792510939; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rm0LyYlJ+YzNGdvtjIb3BVxriPsy574YHZ4IY77q+sA=;
 b=acJQZG1gtT1D/k82n2woFRf7Q4GEt7HTgZ/LLAnl2B0JiqOoh5rUyiSWs0yVCFpIhz
 eWtM1UyQGaHFmPt8flt97fgjDH6SIKlzpHoHxbhZ+h/OtbNeFJAMVCKXUO8JTUq4GlPf
 bzRCHuUbdJ+y9ZxERfUfq5YA0DbEHcFSp3cDAnTg78tAcQsRU1JyUbU7DYhbCojwG5YA
 29hkt3HVxa1vp0fyf4CZb8seDKlAT/IW87UjY/f67DVKPcPAp5uitMeoAyaRVnLfPuMB
 rze8VzWAgrriRUHcp8u0BZx60ba/ybwy+UMrngSv/lQalB2AT/dmtTlSHfCIepoJxnLp
 5A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906139; x=1792510939;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rm0LyYlJ+YzNGdvtjIb3BVxriPsy574YHZ4IY77q+sA=;
 b=vVhb1tNapVWriPM4esufFfzJBFYOlQ8FWdSROIyaSUGQe3F7/Gqr3L7TG8eK5pIAy2
 vq1QRg59UMvt6Lo83lYBqq+Cu51Khq3Z+HUtWN+huzLvPsAE35yEwdDtXPshvzzNH9VN
 QDG6DMd8kc8FiwaMW2Zue1OZ+Thz3gljs4KR6iF0GrFKIlwYyU6aKzVGeQzEaiGybABW
 +L03gucMEuRHlhChqW9lifTjrkVM8paCqyhwOLkI2AfB1hwAyGBR8kyWU+sV5x0xa6K7
 YTYUar0dP0Ha6b3UIc/+4X9YUBjr5/2DQ3Q40cNws+pB2HJt52nuiIKN2LjTeBtBSQst
 bqJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz28SRUsHFmEyqnnr+z4Dj7iR+tGP/ehnK2x/DLMYbbl+iGYfMW2VMu5++GDFAp2+q08pg7/PXizbRE@nongnu.org
X-Gm-Message-State: AFq9FYIzMfKQ8FmQfDIlQTHKdeWEw3NggUksdJz3tj0EmOXQeHXoIgz0
 3KDv2gDnbmm4Mx3zjZYYxLgWuU+6iutYiEsJi1jIfRG/oq0CpZaeeqRspeyT/bBnjQ019PDkgSh
 TwPUGapRiKq+VIWdEz4E/3LQGh/8n97Hz+xlNkaAMzQ==
X-Gm-Gg: AYBFou32ApKohI7CLNnHhKFmM4lhfe3lzdqdBwtmn+KNKa0J8jFnrk+Sf68MKSaCfLS
 dIi72YsqXhmcsQfSd/f2nyZegERBIw/5IvrLOzmUrgf1+RaOuXufSVZKPFL6ZZMR452aA0sBowa
 MM2oSnwZ8X3OkzAHZExp/ZgJqEib2ifxkWwkZyZ7azK5ibqvTIkqN3R3CPi0i1yHp3r+OTp4Cje
 UuuNUtbK5E67WJ5b/RcUEwtlfSZEIv+NTdEZjMCXL/k7PH1yh2+OjzsEn5qFdfhUn/JbLtfZxlS
 /AKVNR38loDhHOqX9n/pj7nsECETrar5WwwCYkf6peN9i+PuUw0bSPwNaAL3KB87ljgzRULs0V1
 KNV8ItUArLeoA67JO5Sfwzt2Fs7CRerkUGEa4bmQ=
X-Received: by 2002:a05:690c:3685:b0:87a:c454:6d67 with SMTP id
 00721157ae682-8b07ee526b0mr38663537b3.52.1791906139243; Tue, 13 Oct 2026
 08:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
 <20260916104435.600211-5-mark.caveayland@nutanix.com>
In-Reply-To: <20260916104435.600211-5-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 16:42:07 +0100
X-Gm-Features: AclHuK9bqSLzLVQB4VCGAk6mL6XXtifWp7anaSaKyJr9Tn_7wu7r2UfWe3SiG8s
Message-ID: <CAFEAcA_NVw4_xPfb7aTXoNxgC+N+D7arQ7X+7vAokNuZxd4p9g@mail.gmail.com>
Subject: Re: [PATCH 04/22] i8259_internal.h: rename PICCommonClass to
 I8259CommonClass
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 16 Sept 2026 at 11:50, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/isa/i8259_internal.h | 4 ++--
>  hw/i386/kvm/i8259.c             | 4 ++--
>  hw/intc/i8259.c                 | 2 +-
>  hw/intc/i8259_common.c          | 6 +++---
>  4 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

