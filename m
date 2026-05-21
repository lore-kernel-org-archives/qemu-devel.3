Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DCCCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ084-00007P-7P; Thu, 21 May 2026 05:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wQ082-000075-DB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:55:46 -0400
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1wQ080-00068A-SA
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:55:46 -0400
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-1357c851a48so6658596c88.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 02:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779357342; cv=none;
 d=google.com; s=arc-20240605;
 b=AEuocunwuT+/Ay+yNkNJGcUxtZJgg6NWCwBqzM4eMbtdN2co7EQCKGXiWcM/RVIkTe
 F2pQtbjBLCcL2SIgeojK1v1/E8RpJMrDT5r+/tiKo9XOVlAm3YbEdw9icDrYSGCqqsmR
 //VhA5AaqsWGZ1MB6Ku7ip08Rk7c+9o893opM0tb6gAoE/41Q1uGXKEWoCjmQnNJvG6x
 HXTJoz4oxcQgNaCjBy/IM3BzjRCx3h2qRBrXo2u6Igxcg9F8GFv9pZrihY86jfnpkz+k
 H5uKemVOQZrRdhRvgvkJx4+RDztyigI1I0h+clkc9gCP2oEotm4a9T0N/1WsYxUczaZ2
 syvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rO6JsACd/MJFSReATEen9jrRxGPWcD1HYQG9kEJafxg=;
 fh=Ei0qSJMEZoMQpmCCEKjE7PPkiA5h+jrAhhZqLppjUhs=;
 b=UeyCWh/vjMTlmOXWvw0I96LS9C8RTzpcERMvzk8DnhySDKXabDW8gsjdAyVCnSTUpM
 7cov/Ad3/UMpd8Zrcxsg0W+srnJ8l2e69rp9QJgVbCII17IBv2l1Cs34L1czsMFDteeO
 woyIYWvcvT+XileEZ31EWLDjmOIZtGGAaOKrIqdEV3SwhmE0BfxD1s9cUszwyXSgU7pm
 1yENkbtx+z5RW1GwiDBnxYy2t6QT8lS29XAoy93Yck5c0TMtjLzM9MP4m3kznJ8kmlxn
 tn0yEYTfIgjp0yD0csdK/sx/fIrWUaSdC6hay4mnWrsSlf9EFdQ845Xz0LXKYCrfZN4i
 XszQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779357342; x=1779962142; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rO6JsACd/MJFSReATEen9jrRxGPWcD1HYQG9kEJafxg=;
 b=bp+w3p4tOzRX06aIlFlLxPslAn+KHxx8XMiFrO6ipKXecKqvpEyslsE+v/zDvlrGqY
 TTIjzgi/F+aXVpQOK+BoVvz/Cl6jdT2deFscYDZO2B/b3i2FL1PPUt1YfYWC4UYxzXln
 bCdfASCsR+oDc0hVEe2cfgZCwFqtqoxyFnHN8muZlXLxVVUPevAb7sx9kJaBuy6uu6Tv
 Y3K1+a042mG+1zxFd5tKOOB+pF6g5ubFJHNdZ17zEktwGemqeiE+3wg3VhZkClw4XFCU
 wOH5SWWDUJcnlQLyfG9kIob2fG+rEo59ZXQRQ3CAtIowI354ekDpZLg+qCbbfgUD6hp3
 hCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779357342; x=1779962142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rO6JsACd/MJFSReATEen9jrRxGPWcD1HYQG9kEJafxg=;
 b=luYG0lFIiDc9lAFL5aZkgTSJiZ71hg03QVWIX1WqOgAABJBgJQ++pLbmtTtY0uKpYf
 xsByUFwA324ZosiEOKBlYd6iqebPTnZMyGXkv1qC9er5TO5J/1HLvGBNG18y9lQCiiof
 N7hLKPdKxHCMCXVuvwcWaQ3bhgLvLmVQU21270HAco0cPWN7BWdS8weJur9vi09arMma
 0Ye/W2ayBwGq8m2GMyCRQ0VkIU7f58c2FhMlMokHrNp3yyO52W99VpoBCrUiicb6JpkR
 UZcejYtbWZX7yTRi+3W1fNOn7Xru/MMrcFxVJUX8L3COcKWVk456WhQNRtqJEHqbuWOs
 ssdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0LDIgll40PZBTAGXP1U7JXJrQ1eCVhfY872s3o14vPEbPd8zCiQfzpMMmO7lrk+yqwddMkgrgmB6t@nongnu.org
X-Gm-Message-State: AOJu0YzUdcwM6YfJ9Q+ZcOuwXTq0nVDaEHeZJ3ckPoGtDQQtk0mVJyFZ
 1SJ4ZDcIEJ+q24FkGAwB1ZVgTQyj3KV/k8k26iVVnjgz45+Ojk0v2R+RKj6XW/189WdOk9pDM3t
 u1X2HHjFuqG1ORB8AmKQpz8cu6NIAc+s=
X-Gm-Gg: Acq92OF3CHAtmhuVK/iys1okEHHVD1sZnvSmKRZn7xicNss/RW6lKh2iMcdCEBSrlp7
 Q5CfatqLeBxioPb8FigqcU+uSYo+/bC2W2GrC26PaBiJDyUCg7IrGkKgx+rIK+hPIGaHZ9UypH9
 kBqwkcGv+6MsFgmXYxbPs297Is85JP028rdR2Mjdqww0Z8y56gmXndHYvs2jhNTdWstKHz209/1
 UNN8hiQlB4nODdvJfAFAh64EN+U1kCnFxczBAnkH0ADoZNys70ExbIQ1Cxc4ujai9dzMwegWW5D
 Ad2Q9GD0X79sHt7WPrWhSsojTCVU5aNThjR2Vda6qH+Jrw46
X-Received: by 2002:a05:7022:6997:b0:128:cf80:deea with SMTP id
 a92af1059eb24-136326e7a41mr948005c88.1.1779357342290; Thu, 21 May 2026
 02:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-12-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-12-armbru@redhat.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Thu, 21 May 2026 18:55:28 +0900
X-Gm-Features: AVHnY4LRaJfD19JPB3aSS2OnCMNd_OXc8eCDU5YCViDYciRxgLjg-5cgrSb8bH4
Message-ID: <CAEDrbUbUJbZATuYH7jEATcCO2-xTgFe7aSeFh-4mh0mSGc3V3g@mail.gmail.com>
Subject: Re: [PATCH 11/39] MAINTAINERS: Fix F: in "WebAssembly"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, pierrick.bouvier@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="00000000000050d79e065250ea4c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000050d79e065250ea4c
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

Thank you for fixing it.

> We neglected to update MAINTAINERS when we renamed
> emsdk-wasm-cross.docker to emsdk-wasm64-cross.docker.  Update it now.
>
> Fixes: 792d94406a (tests/docker: rename wasm cross container, 2026-01-28)
> Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44e5f096a1..a4680516f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -709,7 +709,7 @@ F: include/system/os-wasm.h
>  F: os-wasm.c
>  F: util/coroutine-wasm.c
>  F: configs/meson/emscripten.txt
> -F: tests/docker/dockerfiles/emsdk-wasm-cross.docker
> +F: tests/docker/dockerfiles/emsdk-wasm64-cross.docker

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

Regards,
Kohei Tokunaga

--00000000000050d79e065250ea4c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Markus,<br><br>Thank you for fixing it=
.<br><br>&gt; We neglected to update MAINTAINERS when we renamed<br>&gt; em=
sdk-wasm-cross.docker to emsdk-wasm64-cross.docker.=C2=A0 Update it now.<br=
>&gt; <br>&gt; Fixes: 792d94406a (tests/docker: rename wasm cross container=
, 2026-01-28)<br>&gt; Cc: Kohei Tokunaga &lt;<a href=3D"mailto:ktokunaga.ma=
il@gmail.com">ktokunaga.mail@gmail.com</a>&gt;<br>&gt; Signed-off-by: Marku=
s Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>=
&gt;<br>&gt; ---<br>&gt; =C2=A0MAINTAINERS | 2 +-<br>&gt; =C2=A01 file chan=
ged, 1 insertion(+), 1 deletion(-)<br>&gt; <br>&gt; diff --git a/MAINTAINER=
S b/MAINTAINERS<br>&gt; index 44e5f096a1..a4680516f6 100644<br>&gt; --- a/M=
AINTAINERS<br>&gt; +++ b/MAINTAINERS<br>&gt; @@ -709,7 +709,7 @@ F: include=
/system/os-wasm.h<br>&gt; =C2=A0F: os-wasm.c<br>&gt; =C2=A0F: util/coroutin=
e-wasm.c<br>&gt; =C2=A0F: configs/meson/emscripten.txt<br>&gt; -F: tests/do=
cker/dockerfiles/emsdk-wasm-cross.docker<br>&gt; +F: tests/docker/dockerfil=
es/emsdk-wasm64-cross.docker<br><br>Reviewed-by: Kohei Tokunaga &lt;<a href=
=3D"mailto:ktokunaga.mail@gmail.com">ktokunaga.mail@gmail.com</a>&gt;<br><b=
r>Regards,<br>Kohei Tokunaga<br><br></div></div>

--00000000000050d79e065250ea4c--

