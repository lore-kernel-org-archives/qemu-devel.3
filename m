Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72887606A896
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RJ0sMEQD;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=n6SSUrGv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT00p-00051x-Ji; Mon, 16 Nov 2026 11:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT00h-0004tu-DQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xT00g-0002XB-16
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 11:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794848208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8q8XSi9gg/jhITmwSQ68af9+h00qJvJnO0UKl3b73PU=;
 b=RJ0sMEQDMJDruerOXTT26zFCzgy5dSq/uXkPTcNQpxP8pKDjaqcs7HplBC6CwjJDEaqduJ
 cruqgxmoD3nVUszTwyfQE72cwO5VFfjP1sDQ8yjfELKjmXUWXyK8/H9Mw8ZO6p0+Xolg8z
 plc2C4wUnDQJawAUSzTs+ypdznRQ2SA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-auBAAv0TOp267SO2dyGVPw-1; Mon, 16 Nov 2026 11:56:47 -0500
X-MC-Unique: auBAAv0TOp267SO2dyGVPw-1
X-Mimecast-MFC-AGG-ID: auBAAv0TOp267SO2dyGVPw_1794848207
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8b3030bd581so53366917b3.3
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 08:56:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794848206; cv=none;
 d=google.com; s=arc-20260327;
 b=fsPjO6SgmC6NBBi7pRXirDHt3dLxkdlZ1i8eiEeeEtkFs0DAGmZ8mz0C/PPoKSp2/f
 ci02gS+EYOk43aO4+1U1PSDQSp4zuww58Y9TZHBxOnulelLNe60E0NySxqSdHq9uGwdV
 0drI1IN0XxMdyesSkLj9JCHEj0VJ4tnqN5P7pwcSOFijjb41QlaVSLOut+MMb0zPbJQD
 tYdUxquoaThoW170re8G25vtmckz2lvp33iNu7NAvX092NW0B3VHJobrWVle0w81xcFK
 LIuo3NNx8wUkFcXGRtw8eOfJ0FkOOrFdHXKAe5QCsIfRKbg9QZmJ1hqobLxthmyNY1dL
 LQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8q8XSi9gg/jhITmwSQ68af9+h00qJvJnO0UKl3b73PU=;
 fh=85ATGq1soNyaGAliYh/fWW+lGS7H2OI1v7OfWmA/Kjs=;
 b=mBNAqyU+WBie3dwLsYT8+Mbme0rYF59xif3OTdPXBlm8ayYB73c9KKuzNYcMOzEKu4
 AOx80zmkRUfUr52aXTcbfhW+Nu8eMUzJ+BRCk9pxZvHn/8FS0S63P+4OWzfOIc2w6UnH
 z4EiXBx18Z5ln1SLAmm/b3cxYX65XgLB0WUTDITyGyu65whnNGMcxdfdXMzYewFesGGt
 kaQ/Kk2L3ehzVquOhJX5JK1QW21ZS3IF1RoGqwSKQdPGFhmI5uaapLIy078gLWJme/9x
 ry3+wQA8eI1ii8/kf7ByUZoUbw2SHtO/6D8ByJtDnFYSzgIeXscxY/SE/uzb0L/TkWAz
 Kp1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794848206; x=1795453006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8q8XSi9gg/jhITmwSQ68af9+h00qJvJnO0UKl3b73PU=;
 b=n6SSUrGvfdohuRGDh3eHCOWeCBdKETaOQbrY9U87l+e+tNRX/q4OLpwQU6cV9Lx+SQ
 mYJvBRyS+f970OsNfkyApyd0+Buaccg7gb0vHvxJPfMwlQte017GnqoMPL32zTFOjTup
 kJ1zlfVTgKn8tHxWzN90lSbwHwlewuxcgydBHz8Yq9p4/GH7FWGnxlyBjqlOCrvEOdX8
 Ef8wb4Zm0WsZVgQRcn/HnhM1T6EhLhWFCJJj3ERyajkrn+vtv1oEG66hAGpSycdB+zvO
 A/jf1iPojobggsQYegDiwclbpFqFn69NyQUf8Hv0S3+8h1g1zfnFXJYVuxBqJrpmwqv0
 5d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794848206; x=1795453006;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8q8XSi9gg/jhITmwSQ68af9+h00qJvJnO0UKl3b73PU=;
 b=RteIc4zZc9KvYp/yxcBE05WI3vJQj/AtQ2iRjTJchDjA2KPPgW4ha67fHey3eMgJTq
 7vJt74/0t+J2aOyJpY1c8dGhFefLGNvSkQQ1tC/uODl24g0WQsJUN54Hhnqy4cAovuv8
 I3QdsRe7KDHl5ASlzR80I7nyVtx/hx7MoQA2Xkg8B2PDtq6txQ1jWUvNrihYnM61YpV+
 RdCV4eXFkBlhEJQkMmeqS/sWO8ywTlOTv1GcetYQGlWfP9/hnXwOdYwoEi82vv4nCcKE
 eq70f0+Uf3o3z2Oticudhm5Z2fkjOv1+KSUr/tTztB6kEMrO9838V/BvKJBCv7eFzumh
 wBmw==
X-Gm-Message-State: APuU4Z+Ff6+IZgO1OtKfAvcKQ7bDXA8lYMkIjrfggYqJ3Cb9cbxf520x
 f/DDGuId3CaddVM9f4+QtWhRgdRzZbPRRuBy8COFjyZfZ6EFx3vV3LGY5OP4/93YkaRhWBoVRFZ
 s669pg4+sxAtZwvDrwgv60pM6gTA9TfuO8RVKXY6u9CZb6Xl7InWAQqHdislvsJytxPq5/U6n9J
 IRizisKFKCmXVOsXsT6LGbFpUXUSqZqv+Vy5EjNuQ=
X-Gm-Gg: AZFdTZeHn1vRKYpJawB1vxc++kBcvAYNtP5XpGWiV/mXSCHWFhf+4A10nva/vE9tP62
 LGTbpztx43XrUdmtj71Z8jkJKk6u4O4vhKCwlChP8LclC8p9AQFupVQCJK9zmsgOaphyYZN4rRI
 nA0ZPRquQjU3uvUetHKLHC2zZW7riEFW2gfkmutS9yvaEn9ZShHUKlM/iNtmfxcjUuC6Qh/+FCl
 Oa1r9j51B31v8AK
X-Received: by 2002:a05:690c:18:b0:8b0:e619:7047 with SMTP id
 00721157ae682-8b4aa2f32cfmr58304197b3.50.1794848206613; 
 Mon, 16 Nov 2026 08:56:46 -0800 (PST)
X-Received: by 2002:a05:690c:18:b0:8b0:e619:7047 with SMTP id
 00721157ae682-8b4aa2f32cfmr58304017b3.50.1794848206184; Mon, 16 Nov 2026
 08:56:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109183605.3210043-1-jsnow@redhat.com>
In-Reply-To: <20261109183605.3210043-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Nov 2026 11:56:35 -0500
X-Gm-Features: AclHuK_hUzaWKon9uCDfcgTv6PvOzNQ9VaM-c0tRL6DGD2JZ6z6jRtxktVwYmOw
Message-ID: <CAFn=p-Z1evov86CBoT25NMqGHZqVxP-2T7mKTNY2SseEMfnQLA@mail.gmail.com>
Subject: Re: [PATCH 0/3] build: small build system changes
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <lvivier@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 1:36=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
>
>
> John Snow (3):
>   build: remove vestigial CONFIG_SGA
>   build: update CONFIG_PVPANIC
>   build: Add "-d keeprsp" to Ninja flags
>
>  Makefile                                 | 2 +-
>  configs/devices/i386-softmmu/default.mak | 6 ++++--
>  tests/qtest/meson.build                  | 1 -
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> --
> 2.56.0
>

Hi, I think we want these for 11.2 if possible, though I suppose it's
not absolutely crucial.


