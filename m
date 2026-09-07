Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647EC79FA9
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cKM-0005tr-Ib; Mon, 07 Sep 2026 12:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3cKD-0005rt-Lp
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:36:06 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3cKC-0001vR-2D
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:36:05 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-836c4474028so33401807b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:36:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788798963; cv=none;
 d=google.com; s=arc-20260327;
 b=AH35qQkyfnmSS2PXohRFHlgKfY7M+0gn9CjPmxoLwUyliKmhrxn11oL7GOUR5oed4z
 cU8Bg+oMdJL8fiAiK9TX9dElARw0KYrN09EHPyEVkjFYWh6jgXp1xvGcg7so1uW5VdcZ
 Q/2phA9Sgk7hR+lTIcSwFZ9c5RxyYNTSmikSDkmI2g/1zarww7yVFzckcJl9GYW3lIHf
 94mda93nnfvy2YbaIdMh3S12b/HcE8DC0Lrxa+uKC8mJQgk1hv3UuUgCVM8qce0zaeb7
 hPG9TdSqAFJfxZ0hwa+pDkBpqI7sgyTu/8JpTbRbLZiV4OMgF05jSJrUgwVO5QS3eKJN
 5bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0xhvK6ou6X5KeR+W3xj5MqmXM5SKANPnIkd2kiUdqhg=;
 fh=G/I2ACfQ/DeWwPbJWwJ+Dt/IzNJqfgzn1BexC7R9onA=;
 b=oqIXuZFZRjduddjnPHUji9KnC5o+DYcyBGn1H158TJtYPsnWjDnG3DgQos9u20Luor
 bJ9rNQpyFh7r4BO3YKfSJyWBSDQRTdehQk0PKMWx/toRbze536JEJ8A8SX+4KWkm3jDZ
 +3BsQHOxXdsONFT8tJgYL/pu6maX8Sj5v67OtGB6xIhdyEDZ4VX0hoQlHyAM74nxS2zL
 rrAoScy+lZjfr/kagjl3AGZq2Wm3wsYFgQHSqNYwxRsx12iFr/uyDbOMZS8LEWasVFoi
 bdtwYWuDCtKDRJeCFhIZ1rNi0xWG14Gy8FB38cgVSgub82+SmPuYfWTGrbUrntfeqdsy
 P4ew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788798963; x=1789403763; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0xhvK6ou6X5KeR+W3xj5MqmXM5SKANPnIkd2kiUdqhg=;
 b=bgq8dK/f0dBKMZaHzSqVIUdmjTLShtW2G6/BS7umM5q+NiClEcXNfOBB/fBEdmQqCb
 BMpUzMCVAu3T6uPhjmUKaJb4OanBfkfZamChsDl4CnHhxqZOyHslOWn7vUtflIhrLhp9
 CeP420DmxaSlYKh/p7gO0q8wKezZ+PH+DgvtkP1nzWYQjQlmqmh//EjMgVVRjF9QZD/W
 ECJZvcUh95RPg/iXl95RciZpuIxz0B7ksMDvL6lI9DWrFL1/NwJWki80ddhlnfN8UD/h
 dz/m90NUZ7muOSQxzUQkLL4UfT8d0+ZZ3h2y73GSguA8fLc3tKr46ikmJqq+8gI+YP6w
 MxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788798963; x=1789403763;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0xhvK6ou6X5KeR+W3xj5MqmXM5SKANPnIkd2kiUdqhg=;
 b=njCIPh3EM/88JiN1oK0ltFeb50KM8rvmbR58FYjth60w0c7HdWF4jXp08Vg/IH11pD
 qkks9PQIm+9py4wuWDNV7zR17Y6uOLWO3YSHuKuk4Wv4quHIx7t59QDhD4UTnvVcO3+p
 pSC7VGXILG/b0GwcKiyYWIufdHryCq049kZv2qTvT9qn509NSH6VasAVM2TSmrWgJwaB
 aYklkF3M0n94IGgaPopjpnj3ZS3pV3vA0FmdYjd0ugCIEDAbb9M7xaxpb6PMDpY8H8px
 7U6KwEuDwA517No7qzSlS+PSiV4O9g2h6Z+pCb4VbAsbPasM4cBffBFAwCFaHaAMZNPl
 6I8Q==
X-Gm-Message-State: AFuF++kosYn59CLP3AslfDy2Qm9UXtOWuIjkX2ULB8A2LyekNzzr3Mit
 yGDOqt4kNpnjBOwfs8tV4qGtgVSZzSO0r8ItbF77Hdndjs7CfDkPCrdsjQBpipHS0aUFmnIAegI
 2dhASIkSOAjERlLOSZ4i3dEVL3uj77N9GicdH1ayNlkHgOfy6kbeb1Lg=
X-Gm-Gg: AYBFou3uWsYfFXOJ9tC8iJJjuFrig4UrzezfeeWseq5lXmcTEDnBep5X3VbsuJHQrTg
 gAAyNiJLzIYMHYBEajPis0ahsWKgLdYaXjpQoETmhZlDkcm4kRguBsByUpjxx2eJcBJBSaAmIab
 fHcNwfMbgDhUWGM+CkNh2jOn0UVEY9MHizAOeklKDfsPhLRfvIYXYYHqvaN1wOMfh5WoPXZqWLu
 u0DF+BhQ0zeF+WFxQw4NnRAP1YQY9/RHfd8V823XJE80nebccrTx1oewX6fYu+Cfb3yaPQ0sosj
 9fm4gdOi9KvA7UWPWaExPRVPxDn8lXvrmEFezu5Uj6HFheuuUwM0xUsJrlOv0USLYvhK5ECTZQ8
 0WKBcPG0Xh8CaiMMKZG1d6pPSLhne
X-Received: by 2002:a05:690c:c622:b0:86f:6c64:7eb7 with SMTP id
 00721157ae682-87122599769mr71576167b3.1.1788798962640; Mon, 07 Sep 2026
 09:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260907105310.497730-1-berrange@redhat.com>
In-Reply-To: <20260907105310.497730-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2026 17:35:50 +0100
X-Gm-Features: AcwNN1WoQkTOIo3OWlnk2_kZoYwgtwVOkD_tEW1U0ezifGxAX8-pqdaZjthhAhc
Message-ID: <CAFEAcA-W=Dke75ys=kPuimtC63c3RtK5vROMTTws54UyqhRb9g@mail.gmail.com>
Subject: Re: [PULL v3 00/12] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 7 Sept 2026 at 11:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit ff1d2d19d7e24893e2012d879f8e73077e17b9=
bd:
>
>   Merge tag 'pull-11.1-check-tcg-meson-040926-2' of https://gitlab.com/st=
squad/qemu into staging (2026-09-04 16:52:58 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
>
> for you to fetch changes up to 0766e83d2f94285338e6c642b4b003ffafb142f4:
>
>   docs/system/security: exclude uninitialized stack variables as bugs (20=
26-09-07 11:31:03 +0100)
>
> ----------------------------------------------------------------
> Merge crypto, I/O and misc fixes
>
>  * Deprecated the AF_ALG crypto backend
>  * Improve checkpatch output in CI jobs
>  * Document security policy for uninitialized stack variables
>  * Fix multiple denial of service flaws in websockets
>  * Fix error handling in some x509 APIs
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2
for any user-visible changes.

-- PMM

