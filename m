Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF74BD41D61
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 07:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAkwX-0006GG-Lg; Tue, 12 Nov 2024 02:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAkwW-0006Ft-7B
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 02:04:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tAkwU-0005do-Ep
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 02:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731395041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yt3Ny/WIf/pPGiavXY4jdHTG5XrWgvgRosKdOGc2f/g=;
 b=I74MvdMEJG15G31IUoa+pQWr6DgOskPqDf5uQPVu8P+3lu7lTFDJUuHkGNkKg57pxdU0za
 +47XHxwCxdHSeDgCzd/ajQSZ25pq+cWcNkkaiPv7rC+JgbUktWWe/+7ebaS0rNNeUvtAbO
 Ie9efxqdhFUfHZu5lGRX+Azas1N0Y88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-9FUtNylLOCCcotmlas9Jyw-1; Tue, 12 Nov 2024 02:03:56 -0500
X-MC-Unique: 9FUtNylLOCCcotmlas9Jyw-1
X-Mimecast-MFC-AGG-ID: 9FUtNylLOCCcotmlas9Jyw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso38382995e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 23:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731395035; x=1731999835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yt3Ny/WIf/pPGiavXY4jdHTG5XrWgvgRosKdOGc2f/g=;
 b=t3TyayEwQrSGT1JLUJSeHjSPoabememy3AloRNZLjDvMGUmQE21esPEOma5zCQyeNu
 FOjU1qG9D3KkhI3zb9hS4M6UyysEV1AcOAZarbC7jIuG53pZ6mRfpVsczFLwcH1akIoZ
 P6DIekfBzYW5ezrADlO3Y6tvx/rJqWZ8PLOkO/yUHmjKLWTFlfA9E1340jvLWpAO0AxT
 KLLZ6V4zLBjJt7+BgXTsNvTfjdGgim7sDDRL+FfYYqs6zAnSLO6Yd4hJnvkdEU17LbnS
 wrK+2bAcVj8t5p+xshQhNCGzz84hmV2hgMUzKlMB98WF2ugCUv7iEEWG0vSHfu5yaOBt
 DGrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3m9QQn9BByyCrCqqarnwQMp+bBsEjinUzBDEVNKtQNCHZhLb9fBRroiQdnXfHpKC4V2Pyy2WOU2mM@nongnu.org
X-Gm-Message-State: AOJu0YxSpF8GpMfHCAvRhD5uSTMFCj9NAO2s3bnd4Ypz7NdXvHEhsAdY
 vzG4kAmDa7EqAnpg6FdL3KewbkjJVPizJcxB3ejvk7yFDLL/kryCixRimSJLu8YPKXvN6WCgguF
 /zg+RDwVZAjiFvhaYS5cYYmPrLlXtOVzDo9RItC6Lyb9Sy7PKPs1iEv9RhGOMf6saZslouMeR9m
 7pZk52+b2CBIpcmdvsNnFdTzHkMh0=
X-Received: by 2002:a05:600c:34d1:b0:42f:7ed4:4c25 with SMTP id
 5b1f17b1804b1-432b7505ad9mr131724385e9.14.1731395035406; 
 Mon, 11 Nov 2024 23:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERRS+qoaQrsLjtxJOQTQFa8OYRS45kMt667CutpAvnS/5xiv0Y1kdB+XiF6Twyauu0F3DwBbP4IonQMswpDyk=
X-Received: by 2002:a05:600c:34d1:b0:42f:7ed4:4c25 with SMTP id
 5b1f17b1804b1-432b7505ad9mr131724195e9.14.1731395035078; Mon, 11 Nov 2024
 23:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20241111090534.66439-2-frolov@swemel.ru>
 <CAE8KmOw75c9Vja5dnGy50b2Dqp9wgfMfxRWjHDdqEUkLBUcP+A@mail.gmail.com>
 <60535722-1a11-42f9-a678-d103e227942f@swemel.ru>
 <CAE8KmOyvCJoOHAw7+Y=2-pDD3co5kcwshJCjGfdsmEpsQLRgow@mail.gmail.com>
 <23ef463e-744d-472c-bd25-30f68a97a8cf@swemel.ru>
 <f8673240-2bae-d759-9d1a-de3a320b3c14@ispras.ru>
In-Reply-To: <f8673240-2bae-d759-9d1a-de3a320b3c14@ispras.ru>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 12 Nov 2024 12:33:38 +0530
Message-ID: <CAE8KmOw=+_P+3c0uT=Ak_AJX47RN3tmhUfz1_cnbipj5fovgxg@mail.gmail.com>
Subject: Re: [sdl-qemu] [PATCH] tests/qtest: fix heap-use-after-free
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>, 
 lvivier@redhat.com, farosas@suse.de, sdl.qemu@linuxtesting.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

On Mon, 11 Nov 2024 at 22:51, Alexey Khoroshilov <khoroshilov@ispras.ru> wr=
ote:
> On 11.11.2024 16:35, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =D0=A4=D1=
=80=D0=BE=D0=BB=D0=BE=D0=B2 wrote:
> Not allowed to read the exact memory area, because it is marked as freed.
>
> As far as I understand, heap-use-after-free means a situation when code a=
llocates memory then frees it and then access it.
> Here the code just accesses invalid memory because of nonstandard main() =
call convention.
>
> If it is correct, the patch title could be "tests/qtest: make access to e=
nvironment variables portable"
...
> Since this is UB, it does not matter, if a crash happens or not.
> ASAN just helps to highlight the hidden problem.

* It is not clear what is happening here.  The third parameter
(**envp) looks widely supported.

    -> https://www.gnu.org/software/libc/manual/html_node/Program-Arguments=
.html

Above document says and following program confirms '**envp' points to
the same address as '*environ' variable. It also says '**envp' is not
portable.
=3D=3D=3D
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[], char **envp)
{
    printf("environ: %p, envp: %p\n", environ, envp);
    return 0;
}
$ cc -xc -o test test.c -lasan
$ ./test
environ: 0x7ffc5eb12168, envp: 0x7ffc5eb12168
=3D=3D=3D

> When saintizers are disabled, qos-test passes successfully.
> qos-test fails when qemu is built with enabled sanitizers

* That means Debian/clang has no qualms about the third parameter. It
is not a portability issue then. This Debian page also indicates usage
of '**envp' parameter ->
https://www.debian.org/doc/manuals/debian-reference/ch12.en.html.

* If both '*environ' and '**envp' point to the same address, why does
ASAN throw error with one and not with the other? Where is that memory
getting free'd?

* The patch looks fairly innocuous, but along with the commit message
it is confusing enough to review it. I'd be okay to review it if we
get some clarity about what is going on there.

Thank you.
---
  - Prasad


