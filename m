Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF10D3EE65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viujK-0000vN-Np; Thu, 22 Jan 2026 08:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viujJ-0000tS-9O
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:28:09 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viujH-00087h-LC
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:28:09 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-78fc4425b6bso8495657b3.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 05:28:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769088486; cv=none;
 d=google.com; s=arc-20240605;
 b=FzvU/O+Zr3TgFxhoOC5aL6VG8BleDYTq0iH5VACJNYyeE5rQXBbUKWOsxLwbfm6WVD
 ZmStBJLkO9Ah3a0Dky569LQHAxEKH9uw1nCz+OFTbJpurZix0Epcc4wy83zdcKTPM+ek
 RuB8DSoLqP2reumJrkjPDby59y944ZDpZjtKO4yewZJQRLObp8gg0I67WSBryh+Y7KbA
 /jU9oo172uMfyrBeYtjDI9jBnvx8z9+iUaHnD3l9fYCCP5EG49Z1mH+3p+qkuXMg9dhu
 EXZtOV4X9gkvZpdT81rxHwdxiGFz0avvVz+uNdUpnaTiAQsSv3ukN0mAXDJaz2/aF24W
 OAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XwqjWdVr1pKvISg7D4Yr5+KDapK8vVx3gmbKWFOSRvw=;
 fh=EVSR1hokHdkVDEVT2wFcm2YyX3tAP3Pm00g9OGLFlL8=;
 b=Ml2YWPhMMm3eoiZoKSkH9fJUjeKEviRbFR2QTOTBTDomUtdGf9H+jjj94D3HdFnRmQ
 1GBBq0v91d4jHqgq3um31BQO6PtK7TvnKD+iAx3j2XugHfJ277i2RKUiROvMLEl8YJPK
 BGhkI+hMclapJ/xxPCBIyXmjQ8Y9Nwg2YgzlBDVlQqALt9U5y9iU2Uyq+weQO+J9u4do
 C2dUJQGZjMzhjOcQoN8vw5Rf8v8ZB6KoTF8ta1H2retDARu/XBzCNLDWSqI1r6tCzv8z
 x3A3X1ckEJv2/VYSp9xB5Nh83vfxsfqavLoU0HMQOqZE+y+XbOgFKvQtAGR5D9nWd1ob
 LsYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769088486; x=1769693286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwqjWdVr1pKvISg7D4Yr5+KDapK8vVx3gmbKWFOSRvw=;
 b=MONpJhiNvMDEeWVeDMtGJHLWwSqMdmXvIHFI6xX+WTubmX0cE61x+8z9sO/zBgxRhl
 qABCcdXKR3aXfNHTKBd1YnwQ5keFyGQRvd4uHi3qheY571ZSGfi0HcMHePt6skT6Megm
 1/ieCTMMVGMd/1VlysYYZfY6K+XsNxGo8LNd8CFI4v9g1bWWNac/NQJ6ahjPZ1fzlJSJ
 1eEJ6a84UN2Fg9ZE50ShHXHjB43uIE8qTMuWyDavZT6W4rtTplxrjrBjVpRcQo1ZhAg3
 /5OhplagCRpTPd+otrsKN4r/jtDkBeEgXCPZ3tZpzaGx2e9+wOJRDAse+bI+py7K/0Pu
 Dbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769088486; x=1769693286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XwqjWdVr1pKvISg7D4Yr5+KDapK8vVx3gmbKWFOSRvw=;
 b=OGH/Y+16aXMb5F/xWntXD6avc3SwQrnHChyPTQrFn6FwaLzDDtp9GjkQajoGEMPo+6
 MhxT5JOXXJn5kyBT+d9UjoJSBQaDKiwFxAn4BfpdLSCvtE4IGUYnOB3820OH0Z83lBnS
 fs7+j679CxkX4NRhyMLGVFAB15q/JECgzn00RLORV9gUnqALqrOpzxqSYiS+6G+lv9no
 LrVZehic74wz0M0ynVTo/A+EEUJdf3KW4MTT8c2iTXSrcN37eKdpilX6j28/2NsGvOn3
 jKYpiGjlNrgDK1oiZfE9F60p0f2vZQ56kOWDyIx9OR92AzA/hit5W38J/AzaotJ6OTH4
 Z1pg==
X-Gm-Message-State: AOJu0Ywg0ZfVWLmEkXyhtFpWjNtdLhxIlOhZusn13Zl9pJKD9aVToz5q
 niJG7ryyleNJdpw70OZnQ9Pl6jYlyn5+5lHx0WebfMNvvW9wMookkvfSYdUtYdusQ+1ZhgLD5QB
 RNNh3vK+7YU1qXQOM+WN/Eqy1DRwDtA1yxXGfSCxoOw==
X-Gm-Gg: AZuq6aIEKI3pYUxvTfctmtgS5sBgqUe/4e5DVJVSkVBy6Q0uOJhPZwVDxATAr4jMp12
 5nAWAzekseatN4+9n+xqe5hjsN8CiJ0juN3cDG2gaC8IolEzFcTLge6kEwkD/Vq+ormx3saBZIK
 icj/YdOfBdKqK2RAHJVaECczz5zT33YBeEfEfWurytGSBPWIZxMk2pz70JEujKp8SD/E+ZtuCY2
 w6QR6Udstd3XAXSiHeSdINc3fogwCnPwEp9aSfIDEu1k5r/xf5yzHtjJkkTr1RPR+pdMw==
X-Received: by 2002:a05:690c:b06:b0:78f:afdb:ea41 with SMTP id
 00721157ae682-7940a156388mr72860037b3.18.1769088486244; Thu, 22 Jan 2026
 05:28:06 -0800 (PST)
MIME-Version: 1.0
References: <20260116060315.65723-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260116060315.65723-1-zhenzhong.duan@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 13:27:54 +0000
X-Gm-Features: AZwV_Qjzl_NfdcLkX5RGf5TqJUmNooMIekWsU_E3bdmpmxd_Iukgmk-3s-tVUwM
Message-ID: <CAFEAcA_LnfF-TqF2yKcPJOK4WHJnbt1RECk9svdRkRrvgRqqSQ@mail.gmail.com>
Subject: Re: [PATCH] vfio/migration: Fix page size calculation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex@shazbot.org, clg@redhat.com
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

On Fri, 16 Jan 2026 at 06:03, Zhenzhong Duan <zhenzhong.duan@intel.com> wro=
te:
>
> Coverity detected an issue of left shifting int by more than 31 bits lead=
ing
> to undefined behavior.
>
> In practice bcontainer->dirty_pgsizes always have some common page sizes
> when dirty tracking is supported.
>
> Resolves: Coverity CID 1644186
> Resolves: Coverity CID 1644187
> Resolves: Coverity CID 1644188
> Fixes: 46c763311419 ("vfio/migration: Add migration blocker if VM memory =
is too large to cause unmap_bitmap failure").
> Suggested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/migration.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f857dc25ed..b4695030c7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1173,7 +1173,7 @@ static bool vfio_dirty_tracking_exceed_limit(VFIODe=
vice *vbasedev)
>       * can also switch to use IOMMUFD backend if there is a need to migr=
ate
>       * large VM.
>       */
> -    page_size =3D 1 << ctz64(bcontainer->dirty_pgsizes);
> +    page_size =3D 1ULL << ctz64(bcontainer->dirty_pgsizes);
>      max_size =3D bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * pag=
e_size;

This doesn't strictly speaking resolve CID 1644186, because
what Coverity sees is that ctz64() returns 64 when dirty_pgsizes
is zero. That is still UB even with the ULL suffix.

But if we are enforcing somewhere that dirty_pgsizes is
never zero, then this is fine and we can mark that Coverity
issue as a false-positive.

thanks
-- PMM

