Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5D9C369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 10:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Y02-0005Rc-54; Sat, 12 Apr 2025 06:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u3Y00-0005RH-2I; Sat, 12 Apr 2025 06:22:08 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u3Xzx-0003gp-PY; Sat, 12 Apr 2025 06:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8ZN1z54BNoN4tZ6rXpv1jL7pDZiAQKvk/wBRnTkDugQ=; b=IDAZFJ7vcPW7YMgQ+g7m+TSHLb
 UxNotxxINEpJ/RoFD/GYuQNIpCWMiPZWuTrMpb/TEiRfqm9EzvkElWKisCMU08jOA1afyTGDkKcOM
 ZZBqx1kKvKBgw6scDXH14I4Ng/dyp8huyIa4q8qrFTfGK5dXGdKjSY3emvvc1vMY39/bIFF3KFVA2
 AHgZ5axKHKlf7g+PykfXk9HzODy3lDydiL/cYPzoZQh5x/HMTnokDySzF7UcLSd3gW13JnJO9Ao5e
 6Rauf/DhH6ZPyRpwY5EjiAIlGdmLYOWb+RaoapSnRYzzk5m3hG1LVZDQmirdSmG8RHHp5D+Fa36Bg
 Ot9g86b8MysFA0kWOxETwF3R4EaD88UkBxWr10VW/Hhfri9h6r/j5I3c+LBMDuPD6SIfoekCMossP
 TuTtMhej+ViuSgfSHaPU8YvnWVb9IUC40XQ0b4UcWlfxxxBEfN/2ILnRTbgLh2bDhW6KIDi1yLm9I
 BJ+0QruA1qCZVZfR6a9EqL/iKX9y4anyGokeLBRjE0FFgdQQgILl+QRC/x31JXFdxaO2psWdFjStk
 DDHF4xgbjEWgvvZkOdoLojIqjniXOIGZFFapm9wM8M2Km30hdND0r1W2cbNHB3VharGX2oezD8BfR
 K2aWhgHHl6WO6TWmUGLlMNZB6IqGBJfg4H8LjFFKk=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?ISO-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
Date: Sat, 12 Apr 2025 12:21:47 +0200
Message-ID: <1881242.gqbg26PhFk@silver>
In-Reply-To: <2441396.svyq9LpYvz@silver>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <CAEDrbUakVwwn228nSb0rD1C9qiZ-tpcHBzLRDVyGRNsim97=JQ@mail.gmail.com>
 <2441396.svyq9LpYvz@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Saturday, April 12, 2025 10:21:47 AM CEST Christian Schoenebeck wrote:
> On Friday, April 11, 2025 12:47:29 PM CEST Kohei Tokunaga wrote:
> > Hi Christian,
> > 
> > > > Emscripten's fiber does not support submitting coroutines to other
> > > > threads. So this commit modifies hw/9pfs/coth.h to disable this behavior
> > > > when compiled with Emscripten.
> > >
> > > The lack of being able to dispatch a coroutine to a worker thread is one
> > > thing, however it would probably still make sense to use fibers in 9pfs as
> > > replacement of its coroutines mechanism.
> > >
> > > In 9pfs coroutines are used to dispatch blocking fs I/O syscalls from main
> > > thread to worker thread(s):
> > >
> > > https://wiki.qemu.org/Documentation/9p#Control_Flow
> > >
> > > If you just remove the coroutine code entirely, 9p server might hang for
> > good,
> > > and with it QEMU's main thread.
> > >
> > > By using fibers instead, it would not hang, as it seems as if I/O
> > syscalls are
> > > emulated in Emscripten, right?
> > 
> > Thank you for the feedback. Yes, it would be great if Emscripten's fiber
> > could be used to address this limitation. Since Emscripten's fiber is
> > cooperative, I believe a blocking code_block can still block the 9pfs server
> > unless an explicit yield occurs within it. I'll continue exploring better
> > solutions for this. Please let me know if I'm missing anything.
> 
> As far as I understand it, the I/O syscalls are emulated, and when being
> called by fibers, blocking syscalls would imply to yield under the hood,
> without explicit yield by application that is.
> 
> If that's true, it would only require little code changes for this to work.
> 
> > > Missing
> > >
> > >     errno = ENOTSUP;
> > 
> > Sure, I'll fix this in the next version of the series.
> > 
> > > Looks like you just copied the macOS errno translation code. That probably
> > > doesn't make sense.
> > 
> > Errno values differ between Emscripten and Linux, so conversion is required
> > here. I've used the same mappings as macOS for now, but I'm happy to add
> > more conversions if needed.
> 
> OK, but why have you chosen macOS errno mapping exactly? Are you testing on a
> macOS host machine? Are errno values of emscripten machine dependent?
> 
> The errno mapping must be correct, otherwise funny things will happen on guest
> side if 9p2000.L client is used, as it blindly expects errno numbers sent by
> 9p server to be in native Linux errno number presentation.

Let my answer my own question: I just checked the wasi sources. The errno
values are hard coded by the wasi API, consistent over systems. So the current
mapping of this patch is wrong. macOS uses a different mapping than the wasi
API.

https://github.com/WebAssembly/wasi-libc/blob/main/libc-bottom-half/headers/public/__errno_values.h

https://github.com/emscripten-core/emscripten/blob/4af36cf80647f9a82be617a0ff32f3e56f220e41/system/include/wasi/api.h#L116

So please use a correct mapping as defined in that header file.

/Christian

> Alternatively 9p2000.u protocol variant could be used for Emscripten. Not
> ideal, as this 9p protocol version is somewhat a legacy protocol from QEMU
> perspective, reduced performance, less reliable, but it transmits error
> strings to client which it can map to correct errno values by itself. Linux 9p
> client uses a hash map for this errno translation of 9p2000.u error strings.
> 
> /Christian



