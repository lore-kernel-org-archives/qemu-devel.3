Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BD7C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDxP-00026w-Oa; Fri, 12 Apr 2024 06:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDxN-00026c-3R
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDxL-00046a-JN
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712916985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UKIcLLvVEkfMtCoj6XMRqT4lF+Xqc2+0/AGdgCMMAs=;
 b=iHG8nvQCOL0SPzD1OqygbiVl9Sd13AUNpex6zBFMP+OxWaEExwOxfLfPIsiBCxb2mRJ6o+
 Xh+s9/XMJNtgBy0Ad72bEHobTIwfc0n074eVXTMbPvf77RePIvrvhmqqcZJO3x7gPJQ9M3
 nxxvamJyh04g/LuJRewxlLpnbwyajdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-bIGWa973OBOs5O_BhwXZQQ-1; Fri, 12 Apr 2024 06:16:24 -0400
X-MC-Unique: bIGWa973OBOs5O_BhwXZQQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-346b1cbd6b7so550292f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916983; x=1713521783;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UKIcLLvVEkfMtCoj6XMRqT4lF+Xqc2+0/AGdgCMMAs=;
 b=NRZ8xRWDk049dXYtrk3br8BlzT7hrvuiHad/lK0ZgdOEnUG+Xhv6rxJPrE9F2PPk8g
 OZZEklBtEkwdtc0EvA1B2afcuowuQLPDD0m9ZfjqnFMOvxgf/6LVcm33M+XjNBGJU9qX
 ZDtEtA6quQK0EPgaNkthA07WZS+GpUW2BVINudjdMkc5N2S2oYPXJRpFBXHqGOBjpM6J
 fIvKIUtW7DUu0+w47t2POl9ldgHv4omumZpnQI/TBxTSGuWvpER7H0S8m/8bH49z1jDW
 y/xsiMwc6Erop3+BvE3gCqRDyByKbLT52UgvI5pWOG1bpmtm8h7cMza6DUZjR/lHh8Mj
 rmuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSIs7hiBSJnfvUZJyyxjzUgVT0HKNFERH5BkCIDGEgYUY06BsWkI/cmCqSSpmNRHbBEqhV+CzgMJODmYC16dLO1es7Cfc=
X-Gm-Message-State: AOJu0Yx0X9pmP05FJ5M6Ga8HNe4uWFDI6fgUUDkQI4CsE/UzAqcscEhU
 PE3K3gBK+TMofxvhlrD8V4B+Oy+QPy9Glgwy2cD/FMH14RYEjyN0l+0JJi0NoazZ2TkpZPeMrhr
 4u+kvaQu5bVunPwUcDfCjL+4wg/y6kLwfn/+rj0QmZFbI6hIdgfgYdMs7PjMxbJhnN07sUbFAz2
 Qy3S3gVSoVjsLUGbJtfuEtuBA3y7c=
X-Received: by 2002:a05:6000:11c5:b0:343:e824:d7f7 with SMTP id
 i5-20020a05600011c500b00343e824d7f7mr1484647wrx.67.1712916983422; 
 Fri, 12 Apr 2024 03:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpAG1ZAiVyIfNmtyHS5UM47QlVlFw9mVgk5VZWfc4J5AR3ExJrmB/DaGZtQ0KeMQCRrI3bcAibMq71cwbDb1Y=
X-Received: by 2002:a05:6000:11c5:b0:343:e824:d7f7 with SMTP id
 i5-20020a05600011c500b00343e824d7f7mr1484625wrx.67.1712916983112; Fri, 12 Apr
 2024 03:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-5-thuth@redhat.com>
In-Reply-To: <20240328140607.2433889-5-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 12:16:11 +0200
Message-ID: <CABgObfYb-b7vaNaaESO-K_Q1vWomUaSNudmdA6JX6sj6mVkAFQ@mail.gmail.com>
Subject: Re: [PATCH for-9.1 4/9] Bump minimum glib version to v2.66
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, 
 "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 28, 2024 at 3:06=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> Now that we dropped support for CentOS 8 and Ubuntu 20.04, we can
> look into bumping the glib version to a new minimum for further
> clean-ups. According to repology.org, available versions are:
>
>  CentOS Stream 9:       2.66.7
>  Debian 11:             2.66.8
>  Fedora 38:             2.74.1
>  Freebsd:               2.78.4
>  Homebrew:              2.80.0
>  Openbsd:               2.78.4
>  OpenSuse leap 15.5:    2.70.5
>  pkgsrc_current:        2.78.4
>  Ubuntu 22.04:          2.72.1
>
> Thus it should be safe to bump the minimum glib version to 2.66 now.
> Version 2.66 comes with new functions for URI parsing which will
> allow further clean-ups in the following patches.

Missing:

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index b0e0b1d674f..cc1f5a708e4 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -288,7 +288,6 @@ qmp_guest_ssh_get_authorized_keys(
 }

 #ifdef QGA_BUILD_UNIT_TEST
-#if GLIB_CHECK_VERSION(2, 60, 0)
 static const strList test_key2 =3D {
     .value =3D (char *)"algo key2 comments"
 };
@@ -484,11 +483,4 @@ int main(int argc, char *argv[])

     return g_test_run();
 }
-#else
-int main(int argc, char *argv[])
-{
-    g_test_message("test skipped, needs glib >=3D 2.60");
-    return 0;
-}
-#endif /* GLIB_2_60 */
 #endif /* BUILD_UNIT_TEST */

Paolo


