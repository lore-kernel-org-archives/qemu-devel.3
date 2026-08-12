Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF65C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu692-00040I-0w; Wed, 12 Aug 2026 06:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu68z-0003uz-4i
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:25:09 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu68w-00023W-3I
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:25:08 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-80dc4a68e4aso8665697b3.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786530304; cv=none;
 d=google.com; s=arc-20260327;
 b=rkemcF4AfZWJIs3pTTr6vyumkvyziWmNw6pgQbpmkAtG3MqS9LQnq8/b7vINABesGH
 yJ6jp2mTHkDIV9Z7n2nh43/amlz7gRwRw0dftLp2EDGFBU1YO7N6/dfAVaZuFP/15+le
 NRJ73HSmG8+F5yJhgGg8AhqQJrAj0navbWFDdQLmeMHQXZMVmeA+brrLf91HDH2rhKNF
 miidrWdlx98D2CDx08lqZjjztNAgNUPNT/Y3h3AHK9JXvrx3+LjFgqDhD7ZjRdPYj/Dd
 e5w0AwnITOq7IosgQIaeG750HOyv9hmpQ7uuVpHcax1dczu2NhhsO3yq2Q3HzCzCag2/
 0lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LXTqFzRPeF0ea5Y2BTsg4MEbZkafleniouizAQfpXjs=;
 fh=ltWIwVsWDzxKvEG7jBnlBXPrQvIjQc+HOgvPossf/dc=;
 b=TDaSNwCUTLekW+8DZzC9TueeDlHNjqJX8qIkytRJTCcAkqj+hefHXirAkfCil3Aacf
 7Qah+50SS12lcAkMaDqmCkJlx91PoK278c6HfmNEyIIyKC9EalASLBvjTwEJ7/OUrYnF
 l56mHFeNWzJQRYaXIXdF4XocBrIclIorDUKtWAkv+Rqk0uyKzKK70i7S/AD9B24ZOEXQ
 wyfiXCcHg2J0RWloprDfzN7dMqQF7qL8GLj4KztrBrcqojLyGHJRIiTSKGK+8yt3zVAB
 JAJ0M5K+zXeVWWSRylx/wYN41EtudH+FIhSvP2e5XIoqUSarcggIVFL7TAKCJfO+LL8g
 zgVQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786530304; x=1787135104; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LXTqFzRPeF0ea5Y2BTsg4MEbZkafleniouizAQfpXjs=;
 b=xim+a4DMGpOFzknSs1WSftlXLNsnwSMO2ONE8EU1jEnfCSI5xMjGUspJabtAbNs6Dc
 D/HgttWB4fEbJuEaglkyx1NS6Cwu818aTU1zmAjoSD5KCrNrxrsLVWWaRGphNAPT5jAP
 Yb/MIeJEMbpINsdBPL6/MRICMjjbtfriS4ziVEJGF7alFhaLuW3f1PbMt39I54jbNRC0
 oYBgdbH34fF1coD8WpKZBfV6L8TPZ8E0yVP9KLxqWH//fixXfUKmwlZXQ5xp6aB+iVbn
 4kapkN0dp9yby6OBj5gK1hSoMstChsQQAqf+5q6kGYsIAzJbZ+SDCm9TSM5ATTKIu88s
 8vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530304; x=1787135104;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LXTqFzRPeF0ea5Y2BTsg4MEbZkafleniouizAQfpXjs=;
 b=PLGPRpAK78k54GVkHD/b3Za+9hYPMW/K9sPkz4AYGyVLRn3B36nZ3mjq+Bi5EbuhD2
 39sMTPDtsWieysTeLxmpNTljbhTpFGENBOddUD7b9AT4JTxAk/khoznikxFgNwrM/Nyj
 5QsM/vDCx0tMakRUMss5mabqUgYLTmQbJFGui75zBi5cnPafePBcDanQHOUyJJYJs87+
 wRVRzZWJeOoU4DbSWR/1rwNtDPDx4/XSNDSbIJKd2FllsJ7safO7CnXT9LFaJtbbZ6On
 yBMU7dSHryLm64QqgFxhgKKgf4jD5NoHhXMv99ESvKTfpUPPmy/xxN+xDoGZ75XYOKia
 /rdw==
X-Gm-Message-State: AOJu0YxTt3xc9Y1hQkPav4n68upaTSd0F8VphKnavh/ztamjybSdXs6K
 lRSYqQCkvJ/bq/YVY9PQAEIqq8nYxVUDbJGO5huodYAlMvyfLr8nZDVcK/k4hObTqhDQfuIVXjq
 09mg2xwHg7chWmrv/d5GFLARHp4GPq2yRbf/GSpVMLA==
X-Gm-Gg: AR+sD10C4l7cBMRtAbpyeuGuVbula6vFvtiCVpqR+4W0yvIHBonyakGWQ4GfJWbLMZa
 un2omj4ayJSyw9+wCgnjFKGfvVBaM4Qk6iwJs/+IfN9LD1mpRooJpIKOaxA96X9nmv6UIG2l3nJ
 GWbqRJpFCOny7wdinEp4Fotxi4KGFJH5HTykktO/A/y15Rf9uYRx8G0v5OUE6n3pJtPuoqWZ4uH
 abzQe3QG36vxtAtuCs4bHqF5wbVTgy8T8BeuktiOMkxi7+gHgbccgz9Yw/zHsbK9xg7sGHXYcHM
 kjOXAUhSNx/dfg9ZABjAPKIVakTaWqa8Kk/07E9WXlM3Tkm/sP+CkXxbVx3fsRhP08vfF9j+6MC
 TO2d/OsGiLKPbLMINST+FK4Ubkn7qzwJ6ApkI9s8=
X-Received: by 2002:a05:690c:e0c:b0:81f:a595:2e19 with SMTP id
 00721157ae682-8310b73e8a0mr22080347b3.23.1786530303817; Wed, 12 Aug 2026
 03:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260811143539.7835-1-marcelomanzo@gmail.com>
In-Reply-To: <20260811143539.7835-1-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Aug 2026 11:24:51 +0100
X-Gm-Features: AUfX_mwkmm23E6gGDgCu1vPUb_ezW7RKkcqYvLBMpMwup0kV7mLZVC5ThsCudKc
Message-ID: <CAFEAcA_duyqT1F2m64jg10Xy+4QVikZfUbacvZ50v=isrcCKZg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hw/arm/raspi4b: fix guest RAM capped at ~1 GiB
 regardless of machine size
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 11 Aug 2026 at 15:35, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> While working on unrelated raspi4b issues, I noticed the guest never
> seemed to have as much RAM as I'd given it and tracked it down to
> hw/arm/raspi4b.c's raspi4_modify_dtb(): it decides whether to add a
> second memory node above the 1 GiB peripheral hole by checking
> info->ram_size, but that field is the boot loader's RAM budget for
> where it's allowed to place the kernel/initrd/dtb image, itself always
> capped to at most UPPER_RAM_BASE - vcram_size by
> raspi_base_machine_init(). Since that capped value can never exceed
> UPPER_RAM_BASE by construction, the condition was never true for any
> raspi4b configuration -- the second node was never added, and the
> guest never saw more than ~1 GiB of RAM regardless of the machine's
> nominal size. board_ram_size(info->board_id), computed one line above
> in the same function, is the value that was actually needed.
>
> Patch 1 fixes it (one line); patch 2 adds a regression test.
>



Applied to target-arm.next, thanks.

-- PMM

