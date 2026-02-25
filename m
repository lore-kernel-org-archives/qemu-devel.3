Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F981EFD23A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBYl-00072d-UQ; Wed, 25 Feb 2026 04:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvBYk-00071P-Oa
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:51:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vvBYj-00084Q-50
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:51:58 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-436e87589e8so6232967f8f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 01:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772013115; cv=none;
 d=google.com; s=arc-20240605;
 b=KlCVRe3ec1hlMS911r+bErxJyZXAqBsloUkSl4QmEfhM1r3YtJ3lf337SDdqjdPZSy
 GQHm8pkhOm9KqIugOmLGrQocIWvX7cmeeAC5Ixt+KPa3xoTsUJPD2rFIuE6v6NzZkZpS
 fXJ1wxaxBXIy7RDjNiKmfKK2r5bzNN+DPlh2iRdrzbXr7KRqJzYNNF82yrMoO6zbYZ+7
 GXakZQkrZx3qXZQBmJ5PtfyYgazehQiD91ZONuTwKy8FQb57HdVj38LwzaCTqBGfuwRZ
 +dasMNEsltqorJEs5bs9o7HnIPSE/VKAf556DfJjN1bcYhNfppdr+KsJkO0QNbnNBuCb
 7zZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PdY9+MHTZgnTuYGAElSPw90dj0N6AYyklW6aPYrWaEo=;
 fh=DNIQJwxyLs9FQRJC8FrXsmg2+APPuZGRvOnclaeP3Ys=;
 b=ELrdliOEaQ4glsdykTQd2KjNtwKHe7MPhIjCSyF9Ux8Az6sryNNfET+rx785rmhWmA
 +iPM4AZ3cSI8uWfO20AhlNFRpx1gCvngC/6at95UIBUZHK5Xb7iG9NF4w8YGqu/y/Pgh
 QyIprghIEpJzH0PQLYULVP0qiHhSrir4F8n1RxxvXf6iFLI0/ERzEsCtz9uZbyvHFC3d
 Co4fpjKnW4Ovy4MClAfQdj4Y3Afwao6zLMas4uw/lhlcSn3R/F2BdmZcNR+OSvgXN0Gz
 Uz5xwSUhfLAHacrfdQzOe+X6ea8AV2rPa6r53pggj/CjK9hCOjkhG03Y4o1/Ooh2fXvA
 m9rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772013115; x=1772617915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdY9+MHTZgnTuYGAElSPw90dj0N6AYyklW6aPYrWaEo=;
 b=qgMBNXM8BsgQqCgUQsgX/nSlQHgORXVmLUHmWPUhNJZMVwq7Zp4V0wxZnUKxdfSelT
 BmYw19LJ9hDbe+2dyLAz/r0XnDzlsRPq92cTKLSeBtH6d2M7JZW3YgA1JDQUIhfZ8ITt
 M8KLtkNs144nfKjC18xgKHDQQ1cYDxpqjcP1rnOSFBJRPGfggoeVAVcnZzwJzTm/evJd
 9FgOygyaCGnMX+Y0IicwRsubRoirvPrE7rMQjHnmz4fMSi+W6nNZCMyEHgAxiBgZxr1P
 C9VObwgUFtWKKG/IzDAKpJ+nkbJeCXT9ao6R0iQJkHt1/GbKCcXqw2ONJ48flSi5lpfO
 RixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772013115; x=1772617915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PdY9+MHTZgnTuYGAElSPw90dj0N6AYyklW6aPYrWaEo=;
 b=T3AF1lAwZhI6U5I9WkunM7ZjTK9Neh3oabyBzmiu7hkEAsoXGS7hI0dbWcxEZWrC8Q
 5WCBDjnMYjnmjTr3mO53RH3b4aHTzyhkFsceiAdE+XH+kz9CBRFqntdZ3dYNzK9I1wQi
 BWQHX6WO7p+zI4TvqJuHkBoY9monbGKK3UfsO95xdShYUNM+YuYieW9l7GLe4QwsnWW9
 q1YNhOU+fTa+FUCPhXmPnOxlAPEANPTfcV+OjkV14QA+X8xQkuarwTl0nThaonV3lJgo
 GZmPrm9a6S3cMncl2yYNVtgRC92ZXxnyRGXU98FW00wSV53HICJ7aaA7ayLJfgIr0oEn
 fUNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5dkkBwlpArN2TspuDnyUJzJBjPzHggYZDyZWmVy9gGMwSyrZgnHNCMjgLl7F7+1356T2cMHvRsWmv@nongnu.org
X-Gm-Message-State: AOJu0YxmLljGfM1SGzc9hu7I8xfzH8pj6v55035JWhS3mvQ5IF8QxBCL
 as+5v3AtKq5ynHLiq3SMjebmE9y7e0WxF4VwqkG1Xz8SGG4AxOD/nV14oKyABL7rDQdU6gwhVA1
 eGrPr4vAwY5aQQO6RnbCWK/k/gmED5xT47p8KJfmaog==
X-Gm-Gg: ATEYQzxI4kmC/Ti+0bAJTh9zRwQ19lIMn3tqVDRIf93GeKoY4nrLXy/FVo3eD6QNvKn
 eVDVwzJM36TkyxwweLC4lON7RwLB9sEd3DWASnjSns+ZjBXhazDrCmBWY9KR8gjBNwi9Xe0G1t6
 d9dBI1k8mBf/AE9clusRhU030ryFtcm4IpkxZrS7LVE5yNk3CKG12pHPpvC3ekaMsD05CqztIu1
 466kHXOZgHw2oxwLLTLPpndk//Uhz9J2rMWMDBNLYzwzRD583Ihe33mDc6d3bA67nOC0Uj24u+l
 aJaCwVy0PYe7XLBTkHCRd6nVjKHLDgK86hVMYwmln7tpSF452w==
X-Received: by 2002:a05:6000:430b:b0:432:84f9:8bea with SMTP id
 ffacd0b85a97d-4396f1884fbmr28635715f8f.51.1772013114846; Wed, 25 Feb 2026
 01:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20260219185409.708130-1-jsnow@redhat.com>
 <20260219185409.708130-2-jsnow@redhat.com>
 <aZ7FtAUfAJ0-y0qT@wheatley.k8r.cz>
In-Reply-To: <aZ7FtAUfAJ0-y0qT@wheatley.k8r.cz>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 25 Feb 2026 11:51:28 +0200
X-Gm-Features: AaiRm52zkX5a5UOo-Oo1K3P4HqIFnRhzk70lMJ4eWUO9hzxNca4uxY_3itE4Gvo
Message-ID: <CAAjaMXaBWSp22NZM6QOLCQGvh+O1SMjXUPFXYHnMEmOH3EFoCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] rust: use checked_div to make clippy happy
To: Martin Kletzander <mkletzan@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

On Wed, Feb 25, 2026 at 11:49=E2=80=AFAM Martin Kletzander <mkletzan@redhat=
.com> wrote:
>
> On Thu, Feb 19, 2026 at 01:54:09PM -0500, John Snow wrote:
> >When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
> >complaining about not using checked_div instead of manually checking
> >divisors. Make clippy happy and use checked_div() instead.
> >
> >Signed-off-by: John Snow <jsnow@redhat.com>
> >---
> > rust/hw/core/src/qdev.rs | 14 ++++++--------
> > 1 file changed, 6 insertions(+), 8 deletions(-)
> >
> >diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> >index 145e20a984f..b2e5441079d 100644
> >--- a/rust/hw/core/src/qdev.rs
> >+++ b/rust/hw/core/src/qdev.rs
> >@@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
> >     }
> >
> >     pub const fn period_from_hz(hz: u64) -> u64 {
> >-        if hz =3D=3D 0 {
> >-            0
> >-        } else {
> >-            Self::PERIOD_1SEC / hz
> >+        match Self::PERIOD_1SEC.checked_div(hz) {
> >+            Some(value) =3D> value,
> >+            None =3D> 0,
> >         }
> >     }
> >
> >     pub const fn period_to_hz(period: u64) -> u64 {
> >-        if period =3D=3D 0 {
> >-            0
> >-        } else {
> >-            Self::PERIOD_1SEC / period
> >+        match Self::PERIOD_1SEC.checked_div(period) {
> >+            Some(value) =3D> value,
> >+            None =3D> 0,
>
> This looks like unwrap_or_default:
>

unwrap_or_default is not stable in const contexts so won't compile.

>
> in case you want to make it shorter O:-)
>
> >         }
> >     }
> >
> >--
> >2.53.0
> >
> >

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

