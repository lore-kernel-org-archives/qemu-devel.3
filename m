Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21DAC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VsG-0008R7-3R; Wed, 09 Apr 2025 09:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2VsD-0008Nj-RK; Wed, 09 Apr 2025 09:53:49 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u2VsC-0006Km-9G; Wed, 09 Apr 2025 09:53:49 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3015001f862so4703681a91.3; 
 Wed, 09 Apr 2025 06:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744206817; x=1744811617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fO86AUOVMEMkyzgCe3CigxfkEKJzkLkqDXYq/IelJEs=;
 b=XKpPdfrdvg4aGDpU44o6LMElElvo+OHzGT8TxqzC1p2gznM2Tm9+1r0Lh68oeyGoZU
 lUtzQtO+N6Ig7MSgxlboui9pbxQRDOCf2Omeve7JakgdAr/7e+yfQSguUhhgkmaPeRkW
 H1boLIFB1urvPMzNr9xdUcH7BaIM3PWOiwyz+newZrTR2D+0qHFQ5hmV729tgg+FgyWP
 /72gmcUT/R68JvYnbySeVAzpxD69o9COiYet806BbHu7PembRxG1sy+RFRRhvd/HZp0N
 KFMDny7hbhdOTqC571gM4N1BI766ad7p+7WH0oZrDilBt2md1+ABQcLy8lmN2SKdz2z6
 qwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744206817; x=1744811617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fO86AUOVMEMkyzgCe3CigxfkEKJzkLkqDXYq/IelJEs=;
 b=LAN9r4Ofx/hcUY3cBlG80Eqf0b0VN8T6p9wl8UkZhGTDUAJ56SjsV9ChGyvUI/FpBx
 uqepLLMP3KBPh3WLKoGc6H86kJpYTuy03p5vh7u4P6ElDaR0y7S9/gnMllEVrs9viTwt
 /SxpWYwXQIe7DI5ITeAgFTzG48I490qt15t3S1QlZ1tyatpxwowBjTzlpsZ0y+hnmF0h
 BVsvbtcnxK8fYTe3ARbfhoLndO8uCw5tceqU/Ois/ftJvG2+ZsvBoQbtEWATRdfthkWf
 RqxbZBUauRpb3rWNRWlzzh4jh2AyafBNVhyZfYAhxy/l3d0k9/sEp0S8pi4CTRZtZo0W
 X5bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx5shGTqmjnq5p7qV6l1Yn9XzKIgNmhmn0qUbLWPE41FfeYmTaRlF/V7X10ZhQ7Xz261+yGI1XCxKo9A==@nongnu.org,
 AJvYcCVnAT8bXwDSYIRC+e4eNyYrMQls4ZVOEWW532hOLBs4z+dCMMFe9bCY2tATwOMsylSNsUbOUZWJ2w==@nongnu.org,
 AJvYcCWhv9yypBDDWJe1VD4+mluDiQR0TLmKmnzHzrg1YZc1hPS3hzDqUn3Z1roomPj/SdbxgU7i16Nsn4wi1g==@nongnu.org,
 AJvYcCXSrbbXIrk8BT3HlI4OgesW5EF/9NaYREgSNUcQ/NcJbn7uV8XUHbaq5JgWhu0KE8KIa3jFvhtIAizhlg==@nongnu.org
X-Gm-Message-State: AOJu0Yy4clBGuV61N7t+OvsfAU/iqIF2RDBHAJqIY3V6AsIWLv92YzO7
 ZR5bTBcXRhj2ZRJWRHhdTX7WDYtbmddAkia+6QZ8y0FkWAyBCEQstge6UdujQGtfesWr/pJQyIs
 aoCUEos9GM5UdS2jGAYK6uCNaJ1et+A4VAjs=
X-Gm-Gg: ASbGncvhf+Tzj8JWXahnyH4OO8h/37qVgVkXvT+uiYYQB3R7bh7EK8aaNMaL2lczwWT
 l/e2Gytt09TLLZS1llJ0zIbnNUTyuqS0mhVvqn/xqJaqqyu/HfU5yezEHwXviZIX4SJlJylHHba
 g+ZLaCC+w7lE0y/cl3Kj0dugrUhs5TBLcVG9ubi1dlNlMXwlnlQ/uZRYGUNoa3iTo=
X-Google-Smtp-Source: AGHT+IEcFr5+7WmmB/L2Y3x0x3gjpCLcCsTZwB8iEN3nZHLGE5ZN9jnOSQr5GjgYEdphHNdpy5MVCHMb1sEwGjJb6G4=
X-Received: by 2002:a17:90b:380a:b0:2ff:570d:88c5 with SMTP id
 98e67ed59e1d1-306dbb8e6f7mr3966680a91.9.1744206817553; Wed, 09 Apr 2025
 06:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <24b5ff124d70043aff97dc30aa45f8a502676989.1744032780.git.ktokunaga.mail@gmail.com>
 <069ad872-5012-4f2a-8ba6-e2a22ce2bb49@linaro.org>
In-Reply-To: <069ad872-5012-4f2a-8ba6-e2a22ce2bb49@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Wed, 9 Apr 2025 22:53:26 +0900
X-Gm-Features: ATxdqUHcy7JpXUs-uTpIxaoiUmvJiw4LWXS3bgs3RLqnCgbLDwbNS6L7a6WJOo4
Message-ID: <CAEDrbUYX+i908=QxmvSt6SHAK9O6cwu9cT+5NbCw1xbwz3Ja7w@mail.gmail.com>
Subject: Re: [PATCH 07/10] tcg: Add a TCG backend for WebAssembly
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c67982063258cbc5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
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

--000000000000c67982063258cbc5
Content-Type: text/plain; charset="UTF-8"

> Eh TBH this is too much to review as a single patch.
>
> Do you already have an idea how different the wasm64 implementation can
be?

Sorry for the large patch. I'll split it into smaller patches in the next
version of the series.

With wasm64, instructions that manipulate pointers (e.g., ld/st, qemu_ld/st)
will be updated to handle 64bit pointers. I believe wasm64 will not require
large changes to other parts, such as label handling, goto_tb/goto_ptr, or
the forked TCI.

--000000000000c67982063258cbc5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">&gt; Eh TBH this is too much to review as=
 a single patch.<br>&gt; <br>&gt; Do you already have an idea how different=
 the wasm64 implementation can be?<br><br>Sorry for the large patch. I&#39;=
ll split it into smaller patches in the next<br>version of the series.<br><=
br>With wasm64, instructions that manipulate pointers (e.g., ld/st, qemu_ld=
/st)<br>will be updated to handle 64bit pointers. I believe wasm64 will not=
 require<br>large changes to other parts, such as label handling, goto_tb/g=
oto_ptr, or<br>the forked TCI.<br><br><br></div></div>

--000000000000c67982063258cbc5--

