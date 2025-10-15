Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E6BCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8z0o-0003wP-5I; Wed, 15 Oct 2025 06:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8z0l-0003vu-Bx
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:45:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8z0d-0004DO-Hz
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:45:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so66849215e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760525125; x=1761129925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEbP9xFlj/nao2tzjDKzG1X19uIVc8V9SsHLufcHWaU=;
 b=ks+vyFKRTkzOLkIgsOhFZxHKP+CjK/wlec7/zGtqkZdDLotXCWFAf4Djb3TQ/vnBWS
 hWFnemzlLj22cYusxET+3SSTplco+4bkU9oExzsmA975rLpcI9Bmd6Hu5K7U+vcD35h+
 Dxnf19WUkJZ82GXxNlkGBBtyFLuK+7lkZWv6r2N98WBbGlh6uvmL+giXBLSCaFgllP1l
 S11ZDCVc7wIYfC+pCJkXEpPApzY6dbf4dJ2PK0YNQ4uDvBjmaqzoV2PN1PwphLBwC4YB
 EkwweRTZELXVf+byC71a+hPfE6MA7TtGGEmg9/pMBx5PcnGJGVge4HapTW6VxRuRqypf
 2IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760525125; x=1761129925;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FEbP9xFlj/nao2tzjDKzG1X19uIVc8V9SsHLufcHWaU=;
 b=E8HEeKoo3Htfpwru4pflP9P8C3TBbY1Vb2A3LJnaf/s6fI5xRNLhdrbyVtR77iofHL
 0jT8RTOfJy5C5ry80wjb866SwychfWHWcSOpTHOC8pyA9G97TyTNhIXeMfFoMjdiGz/b
 HYsRQGf6XA/D3oqLc9daFw5y3WerlBWXvgBvq17Cei3WKyFFME2uwCT5lT13seKHq8J2
 rugjTkuYgLGLNKVlCopM/4TDg5cN4OlQEMrV3uod2VDHMoGX6Qn923hmtRUVFNQ0YNLQ
 SiGtge9WhzikyJhbaL2DmcawtAS0v4Jd8B38RnnwNTl5kVcbASEliFbu36HjK6GeO6wO
 jYNA==
X-Gm-Message-State: AOJu0YzzZEqISu0R6k25QHq4duLwNCPC0kBORTmR6I8QE92vQve5JAM7
 Tgu/ADxJ+eXjvBGI3/vkYvqVvf92Hal05anGOFEnl2Ai4KEuJSIX1AREpvqSRsXnfJQ=
X-Gm-Gg: ASbGnctNPUYA5jp21Gw3kxIxcmLZQSwVUsySI7nQEksV0W8kDDHbUQGEIGDs3WIgRFi
 WAyiYSWmiIiQ/BFVCq/I5UY6praYVJG2LMS7zVOOQE5ETY5SBRl1QbSqK/I+L0+fFlwYZy8p+7g
 iz4afTInPRKMG5tv0xWKF+ZQkFVOZDB2mJmmtVCrVZsMBD8Au759GOlGrj0idcRRnA5zKLIYEye
 FuJVfy04JH1YWpU0meTEmsRlGMacpcO1UoKBnVQYz3UuNyxg/QBC07T1j+Lqr7cpKOuY4j+aRZH
 fN2xfEVJ02zCDAczOMZjYC7Z0XiT1EOm6Wj9Tk8vl1Zv8IgO2ZYmk7OlF+5Z1kIHdqSFkunAEi4
 K0MP5QpwbmLAmXrfd5TSo61wa2ocZlDouP7foWi9wVhcWxgIAGKgYS0lH
X-Google-Smtp-Source: AGHT+IE/dXdQSr3zKowLG2bD9u10oGzMO1nf7Yhs1IN/CSgAgzjcRp2ueTECiLSTvRIs7ggkHU6dzw==
X-Received: by 2002:a05:600c:1907:b0:470:ff87:6c2d with SMTP id
 5b1f17b1804b1-470ff8770dcmr13293165e9.29.1760525125500; 
 Wed, 15 Oct 2025 03:45:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489accbsm343859495e9.14.2025.10.15.03.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 03:45:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F224F5F83C;
 Wed, 15 Oct 2025 11:45:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  David Hildenbrand <david@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Dongwon Kim
 <dongwon.kim@intel.com>,  Vivek Kasireddy <vivek.kasireddy@intel.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH 3/8] ui/gtk-gl-area: Remove extra draw call in refresh
In-Reply-To: <72228a73-c465-4c5f-b557-0e319e99d7b5@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Wed, 15 Oct 2025 12:08:14 +0900")
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
 <20251014111234.3190346-4-alex.bennee@linaro.org>
 <72228a73-c465-4c5f-b557-0e319e99d7b5@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Wed, 15 Oct 2025 11:45:23 +0100
Message-ID: <87ms5sjvek.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/10/14 20:12, Alex Benn=C3=A9e wrote:
>> From: Dongwon Kim <dongwon.kim@intel.com>
>> This partially reverts commit
>> 77bf310084dad38b3a2badf01766c659056f1cf2
>> which causes some guest display corruption when gtk-gl-area
>> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
>> simulataneous accesses on the guest frame buffer by host compositor
>> and the guest.
>> Fixes: 77bf310084 ("ui/gtk: Draw guest frame at refresh cycle")
>> Reported-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>> Message-Id: <20250214170813.2234754-1-dongwon.kim@intel.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-ID: <20250603110204.838117-12-alex.bennee@linaro.org>
>> Cc: qemu-stable@nongnu.org
>> ---
>>   ui/gtk-gl-area.c | 1 -
>>   1 file changed, 1 deletion(-)
>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>> index 05fc38096ec..9a11c9b4d18 100644
>> --- a/ui/gtk-gl-area.c
>> +++ b/ui/gtk-gl-area.c
>> @@ -165,7 +165,6 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>>         if (vc->gfx.guest_fb.dmabuf &&
>>           qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
>> -        gd_gl_area_draw(vc);
>
>
> I suggested adding code comment for the lack of gd_gl_area_draw() here
> a while ago but it seems it is missed since then:
> https://lore.kernel.org/qemu-devel/63911dcc-482b-45c5-9468-120ae3df691b@d=
aynix.com/
>
> The removal of this function call itself looks good to me.

What comment would you like - its not clear from the thread what I
should add.

>
>>           return;
>>       }
>>=20=20=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

