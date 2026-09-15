Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C85C982C3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6T6f-0004yq-8b; Tue, 15 Sep 2026 09:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T6Y-0004tR-Nl
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:21:48 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T6W-0001J7-Nt
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:21:46 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab20a33so3318070d50.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478503; cv=none;
 d=google.com; s=arc-20260327;
 b=WVOnSFlkM4PvZvNDiy4JwLfOYMqWXiLikARrivpGBjqNVTm9zDnuRimkU44hhJ+srD
 jMfqM5ga1gz6ZSlI2363Qpqj687WhDf1ISj0YQds/HnEyP+xMr+Rg5J8ez2AAOwUnfZu
 ulI/kVSdo+eMsmC3DJa9Azqs27Xw0NhVlf0QneRILYuun5NXE2gZWaDfLUm6pYLoGfib
 9n3VBS4FgYwoOV5pDABmxTHnKqit32Wu8OjG/zTOCxFMpA4UZLL1SixRSF/1b3V35BmD
 V/oynDC+e6wpcI/6vTO+chG4iBh0Ok51gbVcYzuaa+ISXTVl1r1BtrhH8KUkulvhehb1
 aEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CZrGQFhDKi3Uv76rbzUZUgqf9dFVin9iGrrCgEcQlf4=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=c8TvtaUszh0W20Of7HmMjRQB4fxlJZEVkXZL7Ugglgi3Bw75sRnItkxjxkxtNGTPOK
 UJz6Zx5zsNrJLS/w2Z4/nvK97kiGeMgwAgh55WUqcr+fgGQ1/d7Uf2yBzyQbv/Mptx0w
 zBLS337Rn0yq/91rIPmnllbw75IPLd7nPpzXfhsYWw6jD9F/tgTEMkrt1fN3sz6aRVzr
 cs2et9EspbZzCjfTJfbMIak9tPGJJJ6nu788OtazozE1QGpUkWoB7HkEIMME3sixZgMf
 p0GkwWbpVvKVKlw+JfumGmtqT5VN5CABjXDx3/j9eYknfzanyaH/38NF3Od78YCi7c8Y
 rJeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789478503; x=1790083303; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CZrGQFhDKi3Uv76rbzUZUgqf9dFVin9iGrrCgEcQlf4=;
 b=uIH4wLAHHnQv6GlP7kReAEgmjdPH4n/iYY7x9wXnhB3dtlAKYNMiv1dEkx5LMcKHrq
 Vg1DMc6DyN+gPfytbMaYjWwELskBwx6eURW5Fp1MLM+QhdeuQXXU3Wu/ogO/dOhWyjHS
 SPueyu/ZZScjNOnaUCjwObZwszNQ+2aoz1FJE1Jc5tTxY4rYKvQUaYTgtIx8ot9scrPa
 GQ9kih53xQ6JWMScqal75mRAmOJ9sPJQGo2tEdK7GHHBhe+nvDgvnv1278XsV4lSqVX+
 JtgsFf/zh9LpdUEdHNuEG25Kz3OAv0jQgI8G0E+M/BvOXoxQDM8di7YfbENyXGuKIePi
 zNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478503; x=1790083303;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CZrGQFhDKi3Uv76rbzUZUgqf9dFVin9iGrrCgEcQlf4=;
 b=jaG4q2wrME+s+yVwMMNQU13lcXZaQbgd7rB7oRJrHTQMhFWkUPS7+CAr7HD1cLDgCG
 nDMVM0hYbDujw4uX0QNj1JqldzMnVI+5nzARPlxLqpcps1s38QNKhn/SAXDhfAowsjIh
 hpmWgtkj3Mg6OTboTNfJDmwO2wVQLtrXbHW87CRdht4F73nBdN3TLskDOn/18n3zrMQR
 GbRclL2YEh8MjRtibNCeDfVqNwfLZOMxugMqK8FbwybQ2zlQivIgTB1ijQJ5Z7nl7RLC
 TMs7zX1eCzRcwAp7OyyrKx8yo1xihD/t4+2e+Bz+nxX0BRemqJeSksENMt1lNOBBSvlH
 V4nQ==
X-Gm-Message-State: AFuF++lhdSo0xKSeqrAik/ubWRBA3Y+6g5ENy8MgMeEZ81LTd3tEl4hq
 OQjyObXlYDNDAoloYbofPBU2FpBRZ0i4UBZVLdrL+PdvdDmVPAHKN8/Mce9jHZ1SfWEgTb8grTN
 E6TNFS2FHAzt4NSkdEQCMYBbkYEG3eKTDMo9wum0Gog==
X-Gm-Gg: AYBFou1XYiLL3chLodzCITQ/3GtrbR4a76aizyjPin8g07X9J3VuFBbO7ht2eSdhITd
 +ESJx3WSZ+CTyQvhdjdZVBYKxSypSchEWw90NcwAuJspaJMjfcffvNxJ86U3+GDB1JhBnW3fGls
 LTf/LyVTcVXQMDR2WGnztpM2ttkLQK2dKNJB4PXOK95lr5mUevdC6bTbrerpEFUoBdKAN0pCqdS
 /mKC1MT7GBW/c/spbj7LB6sOJXt/P3IOAEQf34ZS6ZQDuRy6KWlcJ1xlyAHPgqOAB+xbRyyEGke
 P7FM28ChQ514wdPtxK6z8FsNewmnUZF6LPQKY/gOKPjRUEYYVlF0/vw4qpy8L+TFP8r3rkW6zOO
 3+ULAkv3xOiBL25s8dpgO7and/bepSk9j47agdWcwsuF6apVGJw==
X-Received: by 2002:a05:690e:480c:b0:671:436f:adce with SMTP id
 956f58d0204a3-6714dff571amr1506403d50.45.1789478503014; Tue, 15 Sep 2026
 06:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-4-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260914192323.29250-4-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:21:28 +0100
X-Gm-Features: AcwNN1ViJ--V6in8r4K53SVhRZMltYtRv9qzUYqpz5MYNzF_Gt2VQ4jIRc85jMM
Message-ID: <CAFEAcA9A+Vxq5rEA8DDHpEyFqiN1mdZPzLixDOXKzJhBtJcUEQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/6] target/arm: MPU - limit regs RBAR/RASR A1-A3
 to Main Extension
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 14 Sept 2026 at 20:26, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> The alias registers MPU_RBAR_A1-A3 and MPU_RASR_A1-A3 (v7M) or
> MPU_RLAR_A1-A3 (v8M) exist only when the Main Extension is implemented
> (ARM_FEATURE_M_MAIN). The current NVIC decoder groups the principal
> register and its aliases in the same case fall-through, so once the
> PMSAv7 path is enabled for v6-M (or the PMSAv8 path for v8-M Baseline)
> the aliases become incorrectly accessible.
>
> The fix reorders the case statements for the four locations (read and
> write of RBAR and RASR/RLAR) in hw/intc/armv7m_nvic.c. Alias cases are
> placed before the principal register case with a fall-through and are
> guarded by a test of ARM_FEATURE_M_MAIN. If the Main Extension is absent
> the code jumps to bad_offset, causing a read to log "NVIC: Bad read
> offset" and return zero, and a write to log "NVIC: Bad write offset" and
> be ignored. The principal MPU_RBAR and MPU_RASR/RLAR registers remain
> functional for CPUs that implement the corresponding MPU.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

