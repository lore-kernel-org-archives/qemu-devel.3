Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08737CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDAg-00082l-Qt; Mon, 28 Sep 2026 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDAd-00082K-12
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:21:35 -0400
Received: from mail-yx2-x0e.google.com ([2607:f8b0:4864:41::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBDAa-0002aV-Oj
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:21:34 -0400
Received: by mail-yx2-x0e.google.com with SMTP id
 956f58d0204a3-673335b89a0so2696555d50.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790608891; cv=none;
 d=google.com; s=arc-20260327;
 b=XOtdgP+X/mRSEue1PsF9Gfpae4/r4R05M6uNTrXTAAFFeDyBt0KBJuGn7eq/gfE4iO
 G1FMN0eLwA/chqaonn3yegMBwDVdUoD+aIMTim0P1t0lX89VdH6lttnlIQUictN5F/gQ
 EdRIApLORbJoe4bXscTgXQ6cjm9KuoRVhx/m8w8hXZjvFn5gYq2eyswAr4PFMYDHneDm
 Xl9i6TqZZk6V4RlValhNUT7YWprugh/po52ma/ltRMdZ9ckvKdqBYEs/ea+LtLge/5Do
 9GGugy09hjgLu8g6g+9hyp4B1WtgF5UJWIGEcYDfjfRBd01q8ik+xz+2hvLlOC5QWEvD
 cAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4tIooPjFmR1kgez8sCGC0GwupWizrxuv8RiaCahKBK0=;
 fh=Lv1U3XVWP3rpozI9Hv4W2mWdZZLP1iZbIwIE9pXGX44=;
 b=CcMrzYqX2wG1Wpm7PmiQbtf6ZDM1pjsJpgYH6LFxfViR94ysz2YH6Hz07M1uF6nqPJ
 xovNse4+9GEMaS+tu4geBhY8B4QwJfa//3NbwN2YYrZ1pOSz+kTcoWDLIwf1lwYtTpY8
 gdotqMoQZaN10VISTKBRZ4A36C33HsYw6m7vDleSYCZNPQixq616bBinvF/Mbwtr5JwP
 vmJ0NJRkudi0FsCgY4i5s+XunH+bjypVZ9iOVXHu+562bhjDoYP2egDXxCC00R1gOZiC
 cL4yK9If3lNJsuJBMP9Sm3TfYtLtDvbf0WVGoOPe5RYLTZ55a/COhCSFg3UXASgXZWpf
 MA6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790608891; x=1791213691; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4tIooPjFmR1kgez8sCGC0GwupWizrxuv8RiaCahKBK0=;
 b=YgF6vg4YEHDSNPlP9wgU538lJvNXMyXbbCs27WYsfTpOofiZ0eW/EKUKm/0QKeI5ec
 fREKrZZ6INoDWE3Gp3KBzvI+Lwg9NdNFBfXdpYWST3sJaZLoHriITRWIj04N0e4xG27e
 pU+FPXu+6OwcKT7rtaCuqUkE/CfvfHcmKRtcws8Q0i3xKEeWWfwdvRWvoxt7EzUHjIqf
 11Lt7VuNdAjKNg7VGmeQvl6uXuVFTgyP7kCi8r0wxWSxI/em38jO4toYjpwMCvnSgaDP
 xLkWXNXPdP3JvhjDVFACqdVXZ6TzEf0vVXLA4ctbrrk3MJB3FMbltw0LrseI8SpYAS9A
 H42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608891; x=1791213691;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4tIooPjFmR1kgez8sCGC0GwupWizrxuv8RiaCahKBK0=;
 b=m2WwthhAJmvCdwO0nsZ55ZFzsNnRW0Z3yPp2p4sLpFwmFvpLl9AdfZ7xoxjs6A3i5a
 34/iVSv33YVwjqQhIHxZUQceAAU/AzPaWaqtIwKNATNTk6xkNEJ/9+qmDDm+Nl91Bf/b
 gSup+m3UoT8IwnhwUlkqolXZygArEMyj7/dXMDB3aMeLnjdjsuP+4bGoo3fu8isfPdmV
 jHa2ibHA3UoxzmFZeHr9ozQctP4QVsYMDmbGNNg0j2ogtad+0yCRgF5RzDEeXnWYM6g7
 3DPy5LPzqdY3pdfL1az/bWFRaPZSZpRA4n6Ye+isRtRQ9X+o/IX50nGHmGcYbIBFKPvF
 qMXQ==
X-Gm-Message-State: AFuF++nQ73+rHvThR5wEzGpymWEyDfPc82IvmraDd3ZH1dLXegPFSIH/
 CoHCrH9xOlYg73pQDEgJGfoCmXeXTU+44FWSIG6xBENp3h1nSqIBXIvbMjwSw1aq17r96rAyNIR
 FhiBIVo3en3p7u4322/6ogKKDX9VBzLojGhCzZd57SYdGTbO4jigK
X-Gm-Gg: AYBFou0N/QAnNKxYiwyu9wh9T3i4LwRX8jLRGgTjiWnpkmZ/xS/ni8YVVH/DP5FmkQ4
 Qc5Wrkp9dOG/4ub6+KXlRyo4EFZFlEBKFB8Q0YusKWmFHyOPYX9247kGf2DRMSbXeemRoOirbFZ
 /ElFKljOwFbcqvWnlJU0wduTex1GlMGljHmPNsrjOYCgPrkpfbMNcrYnMUcq5Y4i64crl9UZMYa
 2llkOH3vaF1a66EECkEi5pqpPvncoSAjLQdDf8d5uhxf747JngsegvyCwcHrW0xvABSJw4MUOQB
 yrb8dZ1wvNrgwtHTip2NvN3Xj/Xv/8n/fw8uZE+SVqZXMIF/iBVH7iXlozdTjK6zyPOl6drTidZ
 JHWBHdbbxTakKQXsloe5cHQJsDliLiin+VgqnR7Q=
X-Received: by 2002:a05:690e:4084:b0:671:1208:d6d9 with SMTP id
 956f58d0204a3-672ed0194ccmr6035271d50.21.1790608891194; Mon, 28 Sep 2026
 08:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260925234136.1182108-1-jeff@borto.fr>
In-Reply-To: <20260925234136.1182108-1-jeff@borto.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 16:21:19 +0100
X-Gm-Features: AclHuK-nCZhwdanwtFZLe0QudTxugsEdJ1UHoHv7UkKM8rrLNZkuiDZEh-aQ2Eg
Message-ID: <CAFEAcA9jtwi6=YSw6xQrton8zub=bJuzrrv_N7wY0qq_455Q-w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix PMSAv8 shareability decode for R-profile
 MPU regions
To: Jean-Francois Bortolotti <jeff@borto.fr>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sat, 26 Sept 2026 at 00:42, Jean-Francois Bortolotti <jeff@borto.fr> wrote:
>
> In Armv8-R AArch32 the shareability field of an MPU region lives in
> PRBAR, not PRLAR:
>
>   PRBAR: [31:6] BASE  [5] RES0  [4:3] SH  [2:1] AP  [0] XN
>   PRLAR: [31:6] LIMIT [5:4] RES0  [3:1] AttrIndx  [0] EN
>
> (Arm Cortex-R52 TRM 100026_0103_00_en: Tables 3-80 and 3-83 for
> HPRBAR/HPRLAR, Tables 3-124 and 3-127 for PRBAR/PRLAR.)
>
> Without this fix, address translation instructions like ATS1HR
> will return wrong value for PAR.SH.
>
> Signed-off-by: Jean-Francois Bortolotti <jeff@borto.fr>
> ---
>  target/arm/ptw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Yep, this is clearly wrong, maybe a cut-and-paste mistake, since
we just pulled bits [3:1] out of matched_rlar for attrindx.

Applied to target-arm.next, thanks (and added a cc:stable tag).

(I did wonder about v8M, but this whole block is not-M-profile;
the register layout for RLAR and RBAR is the same, we just don't
bother to fish out the SH and attr info since there's nowhere
that M-profile needs to report it.)

-- PMM

