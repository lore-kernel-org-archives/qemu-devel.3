Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAADC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 19:22:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2azQ-0008MB-FF; Wed, 09 Apr 2025 15:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2azP-0008KY-0F
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 15:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1u2azK-0001ea-SV
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 15:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744226489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O0SW+EbGMTX07a5jltzv1cSEZRNVM8yzih6xzURwWfI=;
 b=g9RKSurKxxPo64nrkmLnUnUeV/2dFgK0bqZJGKKH8WBhIbuhkF8kE1qyXuyp5zbtbmEW6B
 GAh/ALd1d52tcu4IkpRdsq7LW9KB5Dza0GOUmiFgDA7FrXAldsIGU1yGN8/yODQbcsaseP
 ee7DqqEHgreD3QR4EhrHq0HLGlCb0Z4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-H9NlB14GOLCdR-3kczdCnQ-1; Wed,
 09 Apr 2025 15:21:23 -0400
X-MC-Unique: H9NlB14GOLCdR-3kczdCnQ-1
X-Mimecast-MFC-AGG-ID: H9NlB14GOLCdR-3kczdCnQ_1744226481
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1219F19560AB; Wed,  9 Apr 2025 19:21:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFC4D1801747; Wed,  9 Apr 2025 19:21:16 +0000 (UTC)
Date: Wed, 9 Apr 2025 15:21:15 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/10] Enable QEMU to run on browsers
Message-ID: <20250409192115.GA5528@fedora>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ex1hep+Q2LcyrOp+"
Content-Disposition: inline
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Ex1hep+Q2LcyrOp+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 11:45:51PM +0900, Kohei Tokunaga wrote:
> This patch series enables QEMU's system emulator to run in a browser using
> Emscripten.
> It includes implementations and workarounds to address browser environment
> limitations, as shown in the following.

I think it would be great to merge this even if there are limitations
once code review comments have been addressed. Developing WebAssembly
support in-tree is likely to allow this effort to develop further than
if done in personal repos (and with significant efforts required to
rebase the code periodically).

> # New TCG Backend for Browsers
>=20
> A new TCG backend translates IR instructions into Wasm instructions and r=
uns
> them using the browser's WebAssembly APIs (WebAssembly.Module and
> WebAssembly.instantiate). To minimize compilation overhead and avoid hitt=
ing
> the browser's limitation of the number of instances, this backend integra=
tes
> a forked TCI. TBs run on TCI by default, with frequently executed TBs
> compiled into WebAssembly.
>=20
> # Workaround for Running 64-bit Guests
>=20
> The current implementation uses Wasm's 32-bit memory model, even though W=
asm
> supports 64-bit variables and instructions. This patch explores implement=
ing
> TCG 64-bit instructions while leveraging SoftMMU for address translation.=
 To
> enable 64-bit guest support in Wasm today, it was necessary to partially
> revert recent changes that removed support for different pointer widths
> between the host and guest (e.g., commits
> a70af12addd9060fdf8f3dbd42b42e3072c3914f and
> bf455ec50b6fea15b4d2493059365bf94c706273) when compiling with
> Emscripten. While this serves as a temporary workaround, a long-term
> solution could involve adopting Wasm's 64-bit memory model once it gains
> broader support, as it is currently not widely adopted (e.g., unsupported=
 by
> Safari and libffi). Feedback and suggestions on this approach are welcome.
>=20
> # Emscripten-Based Coroutine Backend
>=20
> Emscripten does not support couroutine methods currently used by QEMU but
> provides a coroutine implementation called "fiber". This patch series
> introduces a coroutine backend using fiber. However, fiber does not suppo=
rt
> submitting coroutines to other threads. So this patch series modifies
> hw/9pfs/coth.h to disable this behavior when compiled with Emscripten.

QEMU's block job coroutines also rely on switching between threads. See
how job_co_entry() schedules job_exit(). It's not very likely that users
will run jobs in a WebAssembly environment, so maybe this is more of a
theoretical problem for the time being.

> # Overview of build process
>=20
> This section provides an overview of the build process for compiling QEMU
> using Emscripten. Full instructions are available in the sample
> repository[1].
>=20
> To compile QEMU with Emscripten, the following dependencies are required.
> The emsdk-wasm32-cross.docker environment includes all necessary componen=
ts
> and can be used as the build environment:
>=20
> - Emscripten SDK (emsdk) v3.1.50
> - Libraries cross-compiled with Emscripten (refer to
>   emsdk-wasm32-cross.docker for build steps)
>   - GLib v2.84.0
>   - zlib v1.3.1
>   - libffi v3.4.7
>   - Pixman v0.44.2
>=20
> QEMU can be compiled using Emscripten's emconfigure and emmake, which
> automatically set environment variables such as CC for targeting Emscript=
en.
>=20
> emconfigure configure --static --disable-tools --target-list=3Dx86_64-sof=
tmmu
> emmake make -j$(nproc)
>=20
> This process generates the following files:
>=20
> - qemu-system-x86_64.js
> - qemu-system-x86_64.wasm
> - qemu-system-x86_64.worker.js
>=20
> Guest images can be packaged using Emscripten's file_packager.py tool.
> For example, if the images are stored in a directory named "pack", the
> following command packages them, allowing QEMU to access them through
> Emscripten's virtual filesystem:
>=20
> /path/to/file_packager.py qemu-system-x86_64.data --preload pack > load.js
>=20
> This process generates the following files:
>=20
> - qemu-system-x86_64.data
> - load.js
>=20
> Emscripten allows passing arguments to the QEMU command via the Module
> object in JavaScript:
>=20
> Module['arguments'] =3D [
>     '-nographic', '-m', '512M', '-accel', 'tcg,tb-size=3D500',
>     '-L', 'pack/',
>     '-drive', 'if=3Dvirtio,format=3Draw,file=3Dpack/rootfs.bin',
>     '-kernel', 'pack/bzImage',
>     '-append', 'earlyprintk=3DttyS0 console=3DttyS0 root=3D/dev/vda logle=
vel=3D7',
> ];
>=20
> The sample repository[1] provides a complete setup, including an HTML file
> that implements a terminal UI.

If I understand correctly the QEMU project is only build the statically
linked wasm binary in the CI system and not distributing it (e.g. making
it available for download)? I'm asking because if the QEMU project wants
to distribute the wasm binary it may be necessary to put together a
combined software license to meet the license requirements of glib and
other dependencies that are statically linked.

>=20
> [1] https://github.com/ktock/qemu-wasm-sample
>=20
> # Additional references
>=20
> - A talk at FOSDEM 2025:
>   https://fosdem.org/2025/schedule/event/fosdem-2025-6290-running-qemu-in=
side-browser/
> - Demo page on GitHub Pages: https://ktock.github.io/qemu-wasm-demo/
>=20
> Kohei Tokunaga (10):
>   various: Fix type conflict of GLib function pointers
>   various: Define macros for dependencies on emscripten
>   util/mmap-alloc: Add qemu_ram_mmap implementation for emscripten
>   util: Add coroutine backend for emscripten
>   meson: Add wasm build in build scripts
>   include/exec: Allow using 64bit guest addresses on emscripten
>   tcg: Add a TCG backend for WebAssembly
>   hw/9pfs: Allow using hw/9pfs with emscripten
>   gitlab: Enable CI for wasm build
>   MAINTAINERS: Update MAINTAINERS file for wasm-related files
>=20
>  .gitlab-ci.d/buildtest-template.yml           |   27 +
>  .gitlab-ci.d/buildtest.yml                    |    9 +
>  .gitlab-ci.d/container-cross.yml              |    5 +
>  MAINTAINERS                                   |   11 +
>  accel/tcg/cputlb.c                            |    8 +-
>  block/file-posix.c                            |   18 +
>  configs/meson/emscripten.txt                  |    6 +
>  configure                                     |    7 +
>  fsdev/file-op-9p.h                            |    3 +
>  fsdev/meson.build                             |    2 +-
>  hw/9pfs/9p-util-stub.c                        |   43 +
>  hw/9pfs/9p-util.h                             |   18 +
>  hw/9pfs/9p.c                                  |    3 +
>  hw/9pfs/coth.h                                |   12 +
>  hw/9pfs/meson.build                           |    2 +
>  hw/riscv/riscv_hart.c                         |    9 +-
>  include/accel/tcg/getpc.h                     |    2 +-
>  include/exec/tlb-common.h                     |   14 +-
>  include/exec/vaddr.h                          |   11 +
>  include/qemu/atomic.h                         |    4 +
>  include/qemu/cacheflush.h                     |    3 +-
>  include/tcg/helper-info.h                     |    4 +-
>  include/tcg/tcg.h                             |    2 +-
>  meson.build                                   |   30 +-
>  meson_options.txt                             |    2 +-
>  os-posix.c                                    |    5 +
>  qom/object.c                                  |    5 +-
>  scripts/meson-buildoptions.sh                 |    2 +-
>  target/arm/helper.c                           |    4 +-
>  tcg/meson.build                               |    5 +
>  tcg/tcg.c                                     |   26 +-
>  tcg/wasm32.c                                  | 1260 +++++
>  tcg/wasm32.h                                  |   39 +
>  tcg/wasm32/tcg-target-con-set.h               |   18 +
>  tcg/wasm32/tcg-target-con-str.h               |    8 +
>  tcg/wasm32/tcg-target-has.h                   |  102 +
>  tcg/wasm32/tcg-target-mo.h                    |   12 +
>  tcg/wasm32/tcg-target-opc.h.inc               |    4 +
>  tcg/wasm32/tcg-target-reg-bits.h              |   12 +
>  tcg/wasm32/tcg-target.c.inc                   | 4484 +++++++++++++++++
>  tcg/wasm32/tcg-target.h                       |   65 +
>  .../dockerfiles/emsdk-wasm32-cross.docker     |  145 +
>  util/cacheflush.c                             |    3 +-
>  util/coroutine-fiber.c                        |  127 +
>  util/mmap-alloc.c                             |   18 +
>  45 files changed, 6561 insertions(+), 38 deletions(-)
>  create mode 100644 configs/meson/emscripten.txt
>  create mode 100644 hw/9pfs/9p-util-stub.c
>  create mode 100644 tcg/wasm32.c
>  create mode 100644 tcg/wasm32.h
>  create mode 100644 tcg/wasm32/tcg-target-con-set.h
>  create mode 100644 tcg/wasm32/tcg-target-con-str.h
>  create mode 100644 tcg/wasm32/tcg-target-has.h
>  create mode 100644 tcg/wasm32/tcg-target-mo.h
>  create mode 100644 tcg/wasm32/tcg-target-opc.h.inc
>  create mode 100644 tcg/wasm32/tcg-target-reg-bits.h
>  create mode 100644 tcg/wasm32/tcg-target.c.inc
>  create mode 100644 tcg/wasm32/tcg-target.h
>  create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker
>  create mode 100644 util/coroutine-fiber.c
>=20
> --=20
> 2.25.1
>=20

--Ex1hep+Q2LcyrOp+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmf2yKoACgkQnKSrs4Gr
c8jrGAgArxG5JcQ7kMWq9ZAUzdDSYfC4+ag+jvYj3/DzNOWl57WhqgpyWR/ppOeI
57c5fMWtu50s5RJ1k9hyaTTusRPuilljutDZEspcQ4DBFPNc54+JQq78vrLHdR3I
fv+Q8ldL78JZdAB7CfFRMJklclo3gQGwjSvOrxZxg3Xnx1sqXwzsJNxXbMZt9kr4
NEbaXHUzyjvR215VP+Y4a7JQEatssBWLDa3mf4TbyCClhUtisn1S1nwNZhQ+8Pb9
BdEluCfiw2DCFKFUkA4d8czr9wS3IHhJahbZYg9tpHLFDPeiZGjgVOE8fM/Vf8ZA
Ur3ohLbPsr37Fu2NpLKPQ58RJjdumw==
=QZYV
-----END PGP SIGNATURE-----

--Ex1hep+Q2LcyrOp+--


