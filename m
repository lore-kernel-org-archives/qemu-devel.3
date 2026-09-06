Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBD2C79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 14:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3DdV-0003O9-5U; Sun, 06 Sep 2026 10:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3DdT-0003Nu-62
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 10:14:19 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3DdR-0005zM-HD
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 10:14:18 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-86e7f44b773so28307947b3.2
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 07:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788704056; cv=none;
 d=google.com; s=arc-20260327;
 b=sMNC21xY7WviNToEvfebEJSD7HezX5+Z+Ev2MYC9H5hGbn5xmpUE4BVvmVp4JUkOwU
 S5zsh/sOf9y9oYdJzuyzEHI0ZTYZ8UlvFNhK7wS+P0cpc83yIhwaXoUKqlSo2gBR3ew0
 7h9WiRC1qjtk1pb7IqymQAFOXZvXOZWr0nfqHAag/MID7pirSU6avNq5jjVpW7Sv8ieQ
 PGCQHIHzYO83rqaPP6c15KJjHn4sIDc3MLCTxbcZ46losrKtlvJWisGhvaU1Bmv1OsDO
 rWXZ+dL3Rc1XiJecxOQsHuxp92tbmx8jI8PvoOEJd7xypwf/HkhlliTVnPf5lQeyG7xb
 BHfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t8/JyiFPQhudZJmazAcuGPDK868muEBN5fmXOo63tYA=;
 fh=lJqty2iAsNv3XMQixAO0iWecJck8RspZsy8W0qo8I8s=;
 b=PMskPVKFOXb9Al8hTu2NRyxIZDw86ZrVAjFa6e5Wp+1RjxJ9pJAypRfNogU+sYa9m5
 98wa2kVZCS5er/Ubo4ySwV4cLWmXCSmAtYVmX0EI5PAc0tEdIMlCR5ipf1ANyx6mH8pC
 1eo/Lk+Gq7WwN3X/4g5Y+l6A8FFzLJDZGgMmrs/hXnMil0UQ279PPdNurYll9+rTuG91
 bvM04t2BCqv0TGDm7QzxraMLRa7qKtT2ILNx8TSdfq+Uig0Siu3dVBdz+hqRjY43bgRL
 u3Y1Y26N9enJ2DMq33C9NbDXGCaWyAh9msYeVjxjNeQw+5qdSid7gu4KbMK5ITuk8RM3
 MUaw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788704056; x=1789308856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=t8/JyiFPQhudZJmazAcuGPDK868muEBN5fmXOo63tYA=;
 b=PXFDM7pLLLPbitzYllk3+ZX1weFmOpX2vpdSWnfQPlTM8oBWRUIMyn5UHLADZ1nKVK
 Pr+GDYxHYnwVEBw+fBvuEzur38h9GAtYALlOpN0wDXbMmkbDojbhH4aBZNonbZGtih8P
 ol/WMY8Z/ARVIzVJbWzvO+bw/LsyCgfolWeHrlzoMn5e45Zyt1tNftIR5AbzJBD2q/4X
 O6fRikLKt9qnxba6TNdQl95EBqemEvJEMMhjuWx/T6UjyB35lO8uZaQ4jbDJrb9pcXe2
 7H10/O00iI1pRXslML2pfrQywcDelDspwur+tJlzOKWQaHtC9RAd6WCrueJEZg/JmFdk
 1V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788704056; x=1789308856;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t8/JyiFPQhudZJmazAcuGPDK868muEBN5fmXOo63tYA=;
 b=VLlUIOInB33c8uj56UQ8YlpCNGPOkFpEg9mvztRoWWRO0z05UQTavn7R5cQKwZ93NF
 ZuDPP21B5J++52/HErDSVn5JoXSzXNewUzi1P7iblrtt4ObIwPQzjcGcVoScDYSWdi7M
 VIJW29gxrG7uo6iPKg38D7gv/2vl1RGrA0lgZVVzbJs3o+QmRahJBfoedXYCbtZy/ycr
 OjXvmaS+/cx4vL5nJDwcS7kt/lrhfbrFIJUZSUWrxABHMlzM9SjHd2GpkDebH/6b1hru
 3KSFqAJzh1RUSYeY0g5xJQs7sS4jCtIcv2Cf54ZbsdFGZImrqJehRZDPo+xLF7F0AT6w
 3Xvw==
X-Gm-Message-State: AFuF++lRKKgDTc+6XzPWYGt8BzCu9BAgGGhi+M2IaGcWKLqxJvoOX1m3
 4KJwc/pFK/YDi9Qzc5Zvo9I+O4YQxPhyZvuMAWgFLQuuNnzZX2vHod7jdzi5+IGl6Mj6nhLdcTa
 Ps/l77Ath7tcCYclVXQfhamv7bZ/CjBhQ2LcwX1tGNA==
X-Gm-Gg: AYBFou3ehlJt8/Bj7pdxCKET5C9WMQOXgptAi+WkYys+sG0PxMRJxvF6TYHmM1VBseV
 j1QPEUsJPNFs83ndSjTRh/U3S2dz3uJYJKs2KuupqaypeYSa2sLVQwU4ET4agOH1XG2LwLBYZBj
 2ib8HErVN7V305ttR2/l3UUdheV4PEHsl493rmKvZnZCkkNEPqfvwk9rbweMvwzJ5HgSXlMnyqR
 8UVAT3c/JGBsjowxakAN3fS4NxJCw+tAQvuLgTShVgqJjU9Js96UkXnPssg0XgdnXKGcICyeD8k
 VFLNzkDf6CV6f9H44D/AbIqo3+Wi5fL4uXDAszUhDJQTsU3XC7JBP+j6Va63Yp2g8BLmNNr2HJn
 pkxMHjD77mVPWKNs85Vn+CebNuoJ2
X-Received: by 2002:a05:690c:93:b0:873:5ddf:d861 with SMTP id
 00721157ae682-8735ddfd9b6mr40902267b3.44.1788704055560; Sun, 06 Sep 2026
 07:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260904160643.353833-1-berrange@redhat.com>
In-Reply-To: <20260904160643.353833-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Sep 2026 15:14:03 +0100
X-Gm-Features: AcwNN1XSdGwsBp5sZZ_f8mESNNnapz33GD06ced5378rRAwq9vA5a6P0C_lDKEU
Message-ID: <CAFEAcA-B=N8E1dVgkZvcHoBvWXfQU2v1E9e5Cfe4LJWjJgS7rQ@mail.gmail.com>
Subject: Re: [PULL v2 00/13] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 4 Sept 2026 at 17:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 99e54ab5e7a6efc945af6d5661842155d1f3fc=
7a:
>
>   Merge tag 'hw-misc-20260903' of https://github.com/philmd/qemu into sta=
ging (2026-09-03 16:43:24 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
>
> for you to fetch changes up to 39dfe7cf8e87d6de975bae6c10c3712f4df56ee6:
>
>   docs/system/security: exclude uninitialized stack variables as bugs (20=
26-09-04 14:29:16 +0100)
>
> ----------------------------------------------------------------
> Merge crypto, I/O and misc fixes
>
>  * Deprecated the AF_ALG crypto backend
>  * Improve checkpatch output in CI jobs
>  * Fix --disable-containers arg handling in configure
>  * Document security policy for uninitialized stack variables
>  * Fix multiple denial of service flaws in websockets
>  * Fix error handling in some x509 APIs
>

Hi -- I'm afraid this has a conflict in configure: could you rebase
and fix, please?

thanks
-- PMM

