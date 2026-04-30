Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C3CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITej-0001V6-27; Thu, 30 Apr 2026 11:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITeh-0001Ul-Cq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:50:23 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wITee-0004UT-8B
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:50:22 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65318dafbcbso1014854d50.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564219; cv=none;
 d=google.com; s=arc-20240605;
 b=fcU1vZrtvVHQ0eL2asNZ8WCG1368WsKjML7OD5VnGUGFNpeKtbqjj3REDAqpXZ90Dm
 d8JqH+QiqHKrDEmx+OURp/vRvjNQ1TDJhLrmsHZXPs5lj1BzH3u02z/kp+3Hnhe2MmXk
 ZO+Dc8VDJQmcGOB86rail0+u+5gWleugFi+j6bT/nc0LB/Yc1MNzvoaa6mEa7fl5eDEz
 d59klVDNdCCB7OfyTYVQDU7rMJZy+FcRGGOknmqyYdc8+KeRYqznpRc8I/RnRSodtjam
 Ko6IH0JO5PgUPECvA+IUOfNz1esjD3YqUpbi6fe2KXVt6u/zOERYUiBFcxBWUYnFNSth
 iaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IGSm8Kf+kUvKCOtRp5JgBM+cCLxPk+wJOrl+rqFcctg=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=lNNZZ6CUOZ7vKqErNpr/HGTXpimx2dOZ7fHJJ7TAH2A0zCaxTfiVCg2YlseatuccJM
 Y6SLXBrdqMEGJ8ZWvHOFTPzxVBbligiC94cRlHSEkA/HeouHBM2ffsCvlHYs3ZI03XoV
 Op6BrktXBhqeigssIFWF3TKQJOt4/e/asXg0YVWmgHR0xVaPjWccA4+gbFr6/g+fnnHJ
 r9myTqFnoiWpxD7WY6fIl65m9bBe8b0xhZkobgkCBwapE80i9c3OBQChf4xDtidMoO5h
 PPBSh8yS2DFbo3i2S+JV2DU5ijN6qdSeDg2pag0VGXXB4tlZQekyBluDgNkxsNTpwZek
 LX7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777564219; x=1778169019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGSm8Kf+kUvKCOtRp5JgBM+cCLxPk+wJOrl+rqFcctg=;
 b=pEHou9fpFVLSV5Q1R8qENyWXGyjq3SVgWnvfs9KDvFNyoNMBLd9y243U946l1+e3Dl
 gEevnXS4bQscSMPbjIGIsqXxTNYi7IduhWjiN71b/DY+w3WtBARv9I8DrlUnwW1H4Y4h
 FHT95GrdSbRPO0n7qu3vvb/BNlDnfO17iOgkZ99PB/kVKtLcDXXhwmQojYMsZ29LVds4
 0kHX1yb+SJUQjKRiM5QquXpXrrHZHwK2mlICwtQoSjGJa7T5VMmJAN9cq+XrMAE694l+
 7MGYfJCDtUNg5/nbLvJSF25Pgm83hLacRAyADG7iQrJJwZ7k2+e+yfvH242JV6KCkiE9
 1zoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777564219; x=1778169019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IGSm8Kf+kUvKCOtRp5JgBM+cCLxPk+wJOrl+rqFcctg=;
 b=fsg8mTWuV0kTQOFgMxsDVWrt8FOM7g+jDcNtGVEUhF+9Wgi+R9Gfe6Huu6WW8yNr5g
 cwEYMEU5GUoy6zlGDRBeHXfz2spVXNmnLqnQU8pK5fLuHlSU4iJCB/QOLqx3tyNQZsib
 o9YzDLIp4BAT4ii7DurXBR0bjbyMDv4HqagXrGBCae8ReVqOEZZLmjeOG84us7cPbeJF
 RpNBYr1Oe/xZ11IHStL7GWYrNMchqfDuf2inctXpYeOyC5vyROQhraDyjWYVM1xVKx6S
 rdkhn1I+OMJQktK79cbRXOVFowi++kDrGhtXYSlYjd50ZQsoHJL46fnKI9oSilH1Hpoy
 SLCA==
X-Gm-Message-State: AOJu0YxKB4x8Di2x+UFj6lFNr8B6hUbx0M/zM8OTfFfzuJVBBlLA02Dl
 XjzaDacwRlpUV+fCUaF8wdl5vRssw28fTNaVfOgaEb2CLKb4qtERfEtdAPSHvaKOdPXShEHxhDS
 aLMyoZpyB2N0EPHY6aNPRserVFNg2Vy1FF1yJ6+iuy++41lWWAmLa
X-Gm-Gg: AeBDietN9c2W7ET4tDXpESQBXoA2RCGf0lY0wg+eT0Ikg5vTlY0C0qhEZroASPo9uu/
 tzFblcb7r9DJz1muLYWQM4dHpD24WbaztMm4rQGgcEvZ1q/b7PSl8IREVP9zY76jqhIYQ+yyUhd
 tS6y5Bzl/dp2o6RJpliAlTQ0z+X5dMh5TZiWsm6Q3To+h+I7lfVMO+sYF5u1NsemW1BEObmANm1
 anIX7EFEJjFkMx6nxPYcN+5iaTxeoTOc6CeatxLjoLHzNkKvRVKZsh1P+Q9VXe0lnyGgalkDCXH
 wRbyL2Rn03XAMfLvz56rSpkNrb8IPOc27BSJRWWYbtSKvCa8g5+wr9qKrnikl3+zTrbN4+NcWpf
 iSA==
X-Received: by 2002:a05:690e:1c2:b0:65c:2b92:f8ed with SMTP id
 956f58d0204a3-65c2b932447mr297440d50.22.1777564218927; Thu, 30 Apr 2026
 08:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-17-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-17-c413f3605311@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 16:50:07 +0100
X-Gm-Features: AVHnY4IsZUDhToJ2uUO-0Y6YHNkRsnWqhqeS6BlrKZBz4EIbhBOxVC_aLwIdD_c
Message-ID: <CAFEAcA8Gq8xBOMUmC4BwtVmJMxn1cnOKcURt=gr2yPOhFjdjxg@mail.gmail.com>
Subject: Re: [PATCH 17/41] hw/core/resetcontainer: free children array on
 finalization
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Mon, 27 Apr 2026 at 20:44, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> resettable_container_init allocates a GPtrArray for children, but
> resettable_container_finalize was empty and never freed it.
>
> Fixes: 4c046ce37af0 ("hw/core: Add ResetContainer which holds objects imp=
lementing Resettable")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/resetcontainer.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
> index ef84aa2374a..a4a6476a036 100644
> --- a/hw/core/resetcontainer.c
> +++ b/hw/core/resetcontainer.c
> @@ -66,6 +66,9 @@ static void resettable_container_init(Object *obj)
>
>  static void resettable_container_finalize(Object *obj)
>  {
> +    ResettableContainer *rc =3D RESETTABLE_CONTAINER(obj);
> +
> +    g_ptr_array_unref(rc->children);
>  }
>
>  static void resettable_container_class_init(ObjectClass *klass,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

