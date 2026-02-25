Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C609EFD238
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 09:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBY4-0006h3-9C; Wed, 25 Feb 2026 04:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vvBXw-0006aW-Ev
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:51:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vvBXt-00081z-1i
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 04:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772013062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9wJ7Q5ozNJIParZdsQRU0qsIIxlByKZB0J4M1PT148A=;
 b=HWTrBCj1DnrktjznNRphPYvYF6BO9CSwRYDFGCrRiRaEK7nm/zoWwqjcwj1kroBgxlM1If
 j1kPgtPvN0Ohto5tskQUR7S2nyed1k9g3RPuaLD6PuaA+q3p1mz9TStQvPSnbYPTvRqsUa
 pvuxrtwp16pjWivE9nl4JHRFazcI7Ik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-gErKpDg_Mp6KKew7m6FdxA-1; Wed, 25 Feb 2026 04:49:43 -0500
X-MC-Unique: gErKpDg_Mp6KKew7m6FdxA-1
X-Mimecast-MFC-AGG-ID: gErKpDg_Mp6KKew7m6FdxA_1772012982
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43768240a29so711974f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772012982; x=1772617782; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9wJ7Q5ozNJIParZdsQRU0qsIIxlByKZB0J4M1PT148A=;
 b=XcgQh8VjIOOF8NQgu2Pml5+a+KzYi5hWXWsH1mess6Y8P6AdSuODWOC8nqO50TV1Hk
 27QTINUbxOnACVXjz9sPqLLmy7STS20dk+1fLxZRtVQ1AbmdA+MnQPSqFd72Qt9Qxbi0
 LGmGN9oFWNEnnAT440fgh9S8sKX7IEEIERdjSUEyIHFr91xQAwrjIaU9DuDUtmVqRxOm
 o/pIDyYIQPu19wRx1slfsUzmP5DdO+BK7QaXMkgM4WwrVXxRBawj5M6uT7Ignc+iJh92
 DS4gC+rbyzCpbbDGJavBItOht0M6pzXzGFfFZBvsZnXHAt+cOBaDEEkdr1SMnJ1LVIss
 xutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772012982; x=1772617782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9wJ7Q5ozNJIParZdsQRU0qsIIxlByKZB0J4M1PT148A=;
 b=Xtkied2/3DwP+dWIR87bgNgDvhO5oWDSUtuiLQgQOW9IvrgIUZ73zdblFBDhG63ulD
 N1LNopw3Syd9eXhafAxKdyFYeX/+pR710Ofidw/pSAUEOgc2cztGoVNL9irL+R8ZIlAl
 tEQk+yjwM6SCqakR0WmoxrGTBq3wEkl2/DrReciecKK9BDnEdwmNApRgRYXId97w6o0C
 9IvwHzaS6yFqeM88jAj0P6dXJKG+YIAhLxHHESKTATDNZp/VbWsEXBUbZ6rgTuYkjGRn
 njTQbpSJA9E7/1CbDHhcj78s6qF/kD0d7AEWlRhQlqv/6IjEXJrpo2g579JkMSXytV9r
 /Alg==
X-Gm-Message-State: AOJu0Yystyes38JYnEN7RANrMLO/M/n8S4/D8GDTJIrbkVKUyTK57mRy
 55GLuAJR0RJKVGWg9DpcxFpOWMERhFdMRi6hNwMMAHjC0XvRjgk9LAmqHlqqmmwBY1wHM13j3wv
 zyAg5dq2yGDQJ1RcJKMO0bcqEQRK6iAfbgosazfdUJ0KL7g1OTFFX2rJd
X-Gm-Gg: ATEYQzwo5MMIgAJpNhyafsQ0F1Wx/6q5meFWFC6r4dqZ6CX1hMNJGuUmkkcePL1dIuQ
 QGsESQ2nvign12thFufZm+9nVJfuPj+0DCEnLCto1iHfhpHbXwF7hSB4aaFO2SAf4my+UK6yKEY
 JgJhFLQJHCSt9GyFedP0gljQxWh5iytaPsT7Yx2S0d7hHrh6MmRfk898SF0uRpwmYy/2B+didsU
 UzTJhkTruBOBSlByNAG+gHIr0AClltp4DYurLj1DfvF5dLKTDieA2gQy5XoKA+e4naYqMx/F4gi
 qizOx4y3UA8L08ph05f8rpcPp/B5r0hvnGhRNOKRP6hdgkoVyxwReLWUqcuICpgYxS1BYEBMaQK
 UIUV+LWxDsB5nptVDKWQM3A==
X-Received: by 2002:a5d:5f86:0:b0:439:909f:c5a3 with SMTP id
 ffacd0b85a97d-439909fc8acmr2209266f8f.4.1772012982150; 
 Wed, 25 Feb 2026 01:49:42 -0800 (PST)
X-Received: by 2002:a5d:5f86:0:b0:439:909f:c5a3 with SMTP id
 ffacd0b85a97d-439909fc8acmr2209221f8f.4.1772012981677; 
 Wed, 25 Feb 2026 01:49:41 -0800 (PST)
Received: from wheatley.localdomain ([213.175.46.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970c09897sm33914924f8f.17.2026.02.25.01.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 01:49:40 -0800 (PST)
Received: by wheatley.localdomain (Postfix, from userid 1000)
 id 7C3C9194702D9; Wed, 25 Feb 2026 10:49:40 +0100 (CET)
Date: Wed, 25 Feb 2026 10:49:40 +0100
From: Martin Kletzander <mkletzan@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v2 1/1] rust: use checked_div to make clippy happy
Message-ID: <aZ7FtAUfAJ0-y0qT@wheatley.k8r.cz>
References: <20260219185409.708130-1-jsnow@redhat.com>
 <20260219185409.708130-2-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9Ib26oYEF+J5DSKt"
Content-Disposition: inline
In-Reply-To: <20260219185409.708130-2-jsnow@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mkletzan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--9Ib26oYEF+J5DSKt
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 01:54:09PM -0500, John Snow wrote:
>When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
>complaining about not using checked_div instead of manually checking
>divisors. Make clippy happy and use checked_div() instead.
>
>Signed-off-by: John Snow <jsnow@redhat.com>
>---
> rust/hw/core/src/qdev.rs | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
>index 145e20a984f..b2e5441079d 100644
>--- a/rust/hw/core/src/qdev.rs
>+++ b/rust/hw/core/src/qdev.rs
>@@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
>     }
>
>     pub const fn period_from_hz(hz: u64) -> u64 {
>-        if hz =3D=3D 0 {
>-            0
>-        } else {
>-            Self::PERIOD_1SEC / hz
>+        match Self::PERIOD_1SEC.checked_div(hz) {
>+            Some(value) =3D> value,
>+            None =3D> 0,
>         }
>     }
>
>     pub const fn period_to_hz(period: u64) -> u64 {
>-        if period =3D=3D 0 {
>-            0
>-        } else {
>-            Self::PERIOD_1SEC / period
>+        match Self::PERIOD_1SEC.checked_div(period) {
>+            Some(value) =3D> value,
>+            None =3D> 0,

This looks like unwrap_or_default:

https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2024&co=
de=3Dfn%20main()%20%7B%0A%20%20let%20asdf%20%3D%20100u64%3B%0A%0A%20%20prin=
tln!(%22%7B%3A%23%3F%7D%22%2C%20asdf.checked_div(5).unwrap_or_default())%3B=
%0A%20%20println!(%22%7B%3A%23%3F%7D%22%2C%20asdf.checked_div(0).unwrap_or_=
default())%3B%0A%7D%0A

in case you want to make it shorter O:-)

>         }
>     }
>
>--=20
>2.53.0
>
>

--9Ib26oYEF+J5DSKt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEiXAnXDYdKAaCyvS1CB/CnyQXht0FAmmexbQbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEAgfwp8kF4bd254P+gPYUqzDhLphSojcYc1Z
nSZIjJYQUXdPvQnolP/ydFnfW+IMzCX9M2BD346x6nsqPyWb2zvULVpx8OOPnIG2
yTj9CHQBXrLXCdVBzPhbJuogpS8YL1s4MPF3XLxxPdkLH+tuxAwSWWniF6bV41yi
sPC1ohnXw9YqVKBj7J0stZRbtupoH6l+L/gENCIQUwuRl4BPmCCLEMdIbx06in3Y
K7cqO/J5J1CeGoaTRQhY1vyc0YizxiI5wzoKHUR4hZTPZIDt7WYIjEOswwkUZarw
TwyczuH4lwqls1hyM6/oxea/+CrYkFU2qPLA3I6scjWu93RqX6qgrpgNqUZtlojv
z1sE4relQVzmm5OJXPDMAHFtDKg8GgvwGy6ncAOHnjYgB84r/hdXNm5TF/eCEQVc
zJDGe6wF2o5qnD6wrFBUWVFs4qAbxEXhIMSxQdNWGDpu20M8h8MYwWyXSv6XzeNT
6fupBwSmszE3kaEK8cHEI6+nOXI2jMNy5hCOi2ErKg7e4Kz8yeVVAhx59TVQ94QA
9Hqdrz7Sedzl4dcV0hAGvqUTPdZaA2r/fos7Qr5z6WbspdLDgp04AwQ9D7cluxyS
akcYRgSWzvfjCsq0ske153/9pyRR0xANwQKBprSnUpvpeOfwjL41yaQObWEkMvlj
u0qkK2o14zJDXiCmjIg1ROj7
=YJWd
-----END PGP SIGNATURE-----

--9Ib26oYEF+J5DSKt--


