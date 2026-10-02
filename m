Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6ADECA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCbTv-0001mU-70; Fri, 02 Oct 2026 07:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1xCbTr-0001m0-U9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:31:12 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lihuiba@gmail.com>) id 1xCbTm-0004Ch-RC
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:31:11 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e50968489so6667709d50.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790940665; cv=none;
 d=google.com; s=arc-20260327;
 b=H/KPIlUOhu6VRyF3BhMeUXgbIZoW/EMFYeHwhIw6SvoWok3Wqj/EyooRH+QixRG2SH
 Ro4k8SKCWAUDzN0yw1XCIhgnRFSml10Q7dLpBZhTz/p4bLNcAQXmrz3k0GNLDec73SmE
 jxPdehiXsMnfBm9pqM5tlaq8oL4M9VRXYO3K8vKN7O8K08r152U94mODmD4iA+Jkontv
 BS0sEiu8jxg3gc+1lsfHm23OL75Cfdfmx6bOfKTAg+6Dlk+mHRm4MI6JEARHD1i0FY6+
 stQOdP6vuBq9gqh5dFHy9KVps9YCyEDo7muYk96zbghMCwFfbr2e+5S5iVKCh96eTCw2
 01jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3WwFdaypfX07rHhHiyUQ+HHjCbWIjgbn3//wkS/l64I=;
 fh=M9dIQropV6J8u5/SyKneYJmQ6a9X8IItEUVawXExmGQ=;
 b=K7UxoK6/z+Mmjz4LK81+1Y+pogmS8YY8X7DO5a8TQx9MMRs3uVXKM0Vd/otWZUVonR
 BFmq9X73x7ZlKhGMcq+Tzfb/U5GROfKPIt3B9KG7Hf5zJ6pED/878YLIzs8M14e0NSaW
 lEm9p6CgsKGekUJsJCrHnFODgrZ2nGDBvCyvO7ID7N4aln2njXbwUbfm8+9zf8iD3nUh
 yU5Vt8YXSyapL+1z2yoU97EG+lawSyv0FGJfO/5uWCJUS4XyL0rKFkJzWyvBLnLDidVO
 zbbzo1cf8hWYp0qUp00FgxDh7/y6oyEmVtjKaMxsc7JSwXLpXHNDpilEJf1a859M0AkQ
 EGBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790940665; x=1791545465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3WwFdaypfX07rHhHiyUQ+HHjCbWIjgbn3//wkS/l64I=;
 b=RKagi8fxoI6u6ianiyrXmxeDugO9ity8B8/ZLhAqVDTdF6iie1XfaLrxIf1kjzM+21
 2+1vYvw9v9WbMqTY8qSwNY1aBi1QK/A2YJQDZM5+wrQBqvdpagdAFMJwCotTqDFRSRwm
 9AQVVEQPVxsP1jajsH75q82quyOYZ2MO2A/YN3d+c0HKSu1D9dNGS7tK6hD0HzBwkGhh
 uGRzuZN4YwL63i0ndAlSJ9+6Wu44Ni+mXDOCRfCtECwzeIJ5Kjz701m1yShkeQ/6x/xS
 GmnxBI1ExytEBx4d96AJAiyt7YwW92ozcF+lWulKXT5ylNoUiK/zilHAJjw1kwFV9vnV
 n6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790940665; x=1791545465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3WwFdaypfX07rHhHiyUQ+HHjCbWIjgbn3//wkS/l64I=;
 b=gMkXWRm4irNHXTDJunsPF1drinEIdM+gJLtVtPhGoHTi9tZM92FsrRD9bF6lwDsxZ3
 EmvaCpAwuR0GMAZ7QnSsAgZLjUPuLCWc/f6kCUUajvNLwg0D6KTaf0qcit2S7pMVu9Ts
 7FFvBzBLSFc0cYrPClJM+/X0CUKXusf0I41CcF3pM1jo4Ba/aqAGq7JG3JNuL/M8oEox
 iAsOksKRwNEDEV/wSog99g4OWgO7yItpnfBIv4utE5p9uKsK66+tA8RDwQN26GOalaYa
 fGyCmpKbcl+gqdwoxsYlAI41FDbmufEjr3khE+di6Xx+Zrqlv0wqrHL0Mo0l0bldlA1E
 ldlQ==
X-Gm-Message-State: AFq9FYKEuGAv6Hh++se6+HTZFDGPvX/9m7DrWNUCRSwAQle08EBCNPXS
 fXtvw8SaY7cslib123lel6lf3DWCCeS9UhiGTWBCqtUjHoEvBa1qBO4YePlIQzE5L3l9X6b/056
 tN1AsRA3BqRk9/UHoDVSgfrjwqNPyPvczSouy35OGeFjW
X-Gm-Gg: AYBFou3I9iExIefUfQP7dQhXwxnNX9D+JjBMI5SbE2MxCd1vT6hfQrMONOF1jzhyAQM
 H9kbZdagXO42aHb12wXKnnOsLehXoQcxNToaUm3Airulb72lSAgB1vf9VuprDezTueM4o+zGnlG
 eY+CGdfURgp5zQPsQwoI2yjv3wk/7c835k2/Z32oyWz9bAN+eoz/aUMdVfX2ddnaHRayEPj3ADW
 qM/r8f0EFQDlCPhBJ14ZbF+FBbOqoCLAfJljhJqtRmH13uzBLUXmCJ6TNMywUVf88dDiRNuS2Oo
 p8Ac2LyzXnLz3TywC36C+MxB4y4MQTfBXm6nKxigpNiveZFL+pHHtpDAUg==
X-Received: by 2002:a05:690e:18d:b0:674:5c44:aa6c with SMTP id
 956f58d0204a3-677abff87c1mr737356d50.16.1790940664181; Fri, 02 Oct 2026
 04:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260921064440.67131-1-lihuiba@gmail.com>
In-Reply-To: <20260921064440.67131-1-lihuiba@gmail.com>
From: Huiba Li <lihuiba@gmail.com>
Date: Fri, 2 Oct 2026 19:30:52 +0800
X-Gm-Features: AclHuK_tk-hRxEMqsAlXmqTakBy2X1-c4wKcp4mYnGYmf8iVnuO51nxztAdkd30
Message-ID: <CA+AFTT8BWMCfiWBKXyHxXVbPrcxZYAfsQdoOi57ynFh6zd4H8Q@mail.gmail.com>
Subject: Re: [PATCH] block: Add overlaybd read-only format driver
To: qemu-devel@nongnu.org
Cc: Huiba Li <huiba.lhb@alibaba-inc.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-block@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=lihuiba@gmail.com; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

+ Stefan Hajnoczi
I'm sorry but I didn't realize that git send-mail missed you.

Huiba Li <lihuiba@gmail.com> =E4=BA=8E2026=E5=B9=B49=E6=9C=8821=E6=97=A5=E5=
=91=A8=E4=B8=80 14:44=E5=86=99=E9=81=93=EF=BC=9A
>
> Overlaybd (overlay block device) is a novel layered
> image format based on block-diff representation. It
> was originally designed for fast launching of containers,
> and it is also feasible for virtual machines.
>
> It features:
> (1) small index with variable-length block size;
> (2) fast lookup with linearized B+ tree and SIMD; (binary search for now)=
;
> (3) O(1) lookup at any number of depth (internal backing chain);
> (4) optionally fast decompression with lz4 or zstd;
> (5) OCI-compatible layering and manifest.
>
> Signed-off-by: Huiba Li <huiba.lhb@alibaba-inc.com>
> ---
>  MAINTAINERS                            |    7 +
>  block/meson.build                      |    5 +-
>  block/overlaybd.c                      | 1962 ++++++++++++++++++++++++
>  docs/system/qemu-block-drivers.rst.inc |   37 +
>  meson.build                            |    9 +
>  meson_options.txt                      |    4 +
>  qapi/block-core.json                   |   39 +
>  scripts/meson-buildoptions.sh          |    6 +
>  tests/qemu-iotests/tests/overlaybd     |  795 ++++++++++
>  tests/qemu-iotests/tests/overlaybd.out |   10 +
>  10 files changed, 2873 insertions(+), 1 deletion(-)
>  create mode 100644 block/overlaybd.c
>  create mode 100755 tests/qemu-iotests/tests/overlaybd
>  create mode 100644 tests/qemu-iotests/tests/overlaybd.out
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6be9c5725b..a71264490b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4436,6 +4436,13 @@ L: qemu-block@nongnu.org
>  S: Supported
>  F: block/dmg.c
>
> +overlaybd
> +M: Huiba Li <huiba.lhb@alibaba-inc.com>
> +L: qemu-block@nongnu.org
> +S: Supported
> +F: block/overlaybd.c
> +F: tests/qemu-iotests/tests/overlaybd*
> +
>  parallels
>  M: Stefan Hajnoczi <stefanha@redhat.com>
>  M: Denis V. Lunev <den@openvz.org>
> diff --git a/block/meson.build b/block/meson.build
> index bc419aebf0..48fdac8b0b 100644
> --- a/block/meson.build
> +++ b/block/meson.build
> @@ -39,7 +39,7 @@ block_ss.add(files(
>    'throttle.c',
>    'throttle-groups.c',
>    'write-threshold.c',
> -), zstd, zlib)
> +), zstd, zlib, lz4)
>
>  system_ss.add(when: 'CONFIG_TCG', if_true: files('blkreplay.c'))
>  system_ss.add(files('block-ram-registrar.c'))
> @@ -69,6 +69,9 @@ endif
>  if get_option('bochs').allowed()
>    block_ss.add(files('bochs.c'))
>  endif
> +if get_option('overlaybd').allowed()
> +  block_ss.add(files('overlaybd.c'))
> +endif
>  if get_option('vvfat').allowed()
>    block_ss.add(files('vvfat.c'))
>  endif
> diff --git a/block/overlaybd.c b/block/overlaybd.c
> new file mode 100644
> index 0000000000..9d3b5eb437
> --- /dev/null
> +++ b/block/overlaybd.c
> @@ -0,0 +1,1962 @@
> +/*
> + *
> + * Read-only block driver for OverlayBD images
> + *
> + * An OverlayBD image is a stack of layer files. Each layer is an LSMT
> + * blob: a 4096-byte header, a data region,
> + * a sorted index of 16-byte LBA mappings, and a 4096-byte trailer. The
> + * driver merges the per-layer indexes top-down (a top layer's mapping
> + * wins its whole extent; lower layers only fill holes) and serves reads
> + * at 512-byte sector granularity. Holes and zeroed mappings read as
> + * zeros.
> + *
> + * Layers may optionally be wrapped in a single-entry tar and/or
> + * compressed with ZFile (block-wise LZ4 or ZSTD with a jump table).
> + *
> + * The layer stack is given either by an OCI image manifest, whose layer
> + * digests name blobs in a local directory (manifest option, or the file
> + * child for -drive file=3D... usage), or as an explicit bottom-first
> + * "layers" array.
> + *
> + * See also the reference implementation:
> + * https://github.com/containerd/overlaybd
> + *
> + * Specifications for the on-disk formats:
> + *   LSMT layer blob format (header, data, index, trailer)
> + *     https://github.com/containerd/overlaybd/blob/main/src/overlaybd/l=
smt/format_spec.md
> + *   ZFile block compression format (jump table, LZ4/ZSTD)
> + *     https://github.com/containerd/overlaybd/blob/main/src/overlaybd/z=
file/format_spec.md
> + *
> + * The layer blobs are named by an OCI image manifest; the remaining OCI
> + * specifications are listed where the manifest is parsed:
> + *   https://github.com/opencontainers/image-spec/blob/main/manifest.md
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "block/block-io.h"
> +#include "block/block_int.h"
> +#include "block/qdict.h"
> +#include "qemu/module.h"
> +#include "qemu/bswap.h"
> +#include "qemu/crc32c.h"
> +#include "qemu/cutils.h"
> +#include "qemu/memalign.h"
> +#include "qobject/qjson.h"
> +#include "qobject/qdict.h"
> +#include "qobject/qlist.h"
> +
> +#ifdef CONFIG_LZ4
> +#include <lz4.h>
> +#endif
> +#ifdef CONFIG_ZSTD
> +#include <zstd.h>
> +#endif
> +
> +/*
> + *
> + * On-disk format definitions below mirror the reference implementation
> + * (containerd/overlaybd: lsmt/file.cpp HeaderTrailer, lsmt/index.h,
> + * zfile/zfile.cpp HeaderTrailer, zfile/compressor.h CompressOptions)
> + * field for field; per-struct citations mark the source of each layout.
> + * Metadata is little-endian on disk and is read through explicit
> + * little-endian accessors, which also sidesteps the signedness of
> + * ldl_le_p() for the 32-bit fields.
> + */
> +
> +static const char lsmt_magic0[8] =3D "LSMT\0\1\2";
> +static const uint8_t lsmt_magic1[16] =3D {
> +    0x65, 0x7e, 0x63, 0xd2, 0x94, 0x44, 0x08, 0x4c,
> +    0xa2, 0xd2, 0xc8, 0xec, 0x4f, 0xcf, 0xae, 0x8a
> +};
> +static const char zfile_magic0[8] =3D "ZFile\0\1";
> +static const uint8_t zfile_magic1[16] =3D "tuji.yyf@Alibaba";
> +
> +/* LSMT::HeaderTrailer::SPACE, lsmt/file.cpp */
> +#define LSMT_HT_SPACE             4096
> +/* LSMT::MAX_LSMT_RO_INDEX_SIZE, lsmt/index.h */
> +#define LSMT_MAX_RO_INDEX_ENTRIES 1000000LL
> +/* LSMT::MAX_LSMT_INDEX_SIZE, lsmt/index.h: cap on the merged index */
> +#define LSMT_MAX_MERGED_ENTRIES   128000000LL
> +/* LSMT::MAX_STACK_LAYERS, lsmt/file.h */
> +#define LSMT_MAX_LAYERS           255
> +/* LSMT::Segment::INVALID_OFFSET, lsmt/index.h */
> +#define LSMT_INVALID_OFFSET       (((uint64_t)1 << 50) - 1)
> +#define LSMT_MOFFSET_BEGIN        (LSMT_HT_SPACE / BDRV_SECTOR_SIZE)
> +
> +/* LSMT::HeaderTrailer::FLAG_SHIFT_*, lsmt/file.cpp */
> +#define LSMT_FLAG_HEADER    (1u << 0)
> +#define LSMT_FLAG_DATA_FILE (1u << 1)
> +#define LSMT_FLAG_SEALED    (1u << 2)
> +
> +/*
> + * LSMT::HeaderTrailer, lsmt/file.cpp: a packed struct with byte-aligned
> + * fields only (no bitfields), identical to the upstream definition less
> + * the C++ methods, and covering the whole LSMT_HT_SPACE block that is
> + * read and written.  Upstream stops at user_tag (sizeof =3D=3D 390) and
> + * keeps the tail outside the type, reading the block into a raw buffer
> + * and casting it; format_spec.md:32 documents that tail as a header
> + * field, so it is declared here instead.
> + */
> +typedef struct QEMU_PACKED OverlaybdLSMTHeader {
> +    uint64_t magic0;
> +    uint8_t magic1[16];
> +    uint32_t size;           /* 390: the fields above, tail excluded */
> +    uint32_t flags;
> +    uint64_t index_offset;
> +    uint64_t index_size;     /* # of 16-byte index entries */
> +    uint64_t virtual_size;   /* bytes */
> +    uint8_t uuid[37];        /* UUID::String */
> +    uint8_t parent_uuid[37]; /* UUID::String */
> +    uint16_t reserved;
> +    uint8_t version;
> +    uint8_t sub_version;
> +    uint8_t user_tag[256];   /* TAG_SIZE */
> +    uint8_t reserved_space[3706];
> +} OverlaybdLSMTHeader;
> +
> +QEMU_BUILD_BUG_ON(sizeof(OverlaybdLSMTHeader) !=3D LSMT_HT_SPACE);
> +
> +/* ZFile::HeaderTrailer::SPACE, zfile/zfile.cpp */
> +#define ZFILE_HT_SPACE       512
> +/*
> + * ZFile::MAX_READ_SIZE, zfile/zfile.h: upstream uses this one constant
> + * both as the block size cap and as the size of BlockReader's
> + * compressed-data read window.  Only the block size cap is needed here =
--
> + * the read window is sized to the request.
> + */
> +#define ZFILE_MAX_BLOCK_SIZE 65536
> +/*
> + * qemu-side hardening: a jump table entry is image-controlled, so cap t=
he
> + * compressed size of one block to bound the read window.  Upstream has =
no
> + * span cap; it ERANGEs when a block overflows its 64 KiB window instead=
.
> + */
> +#define ZFILE_MAX_SPAN       (1u << 20)
> +/* ZFile::CompressOptions::LZ4 / ZSTD, zfile/compressor.h */
> +#define ZFILE_ALGO_LZ4       1
> +#define ZFILE_ALGO_ZSTD      2
> +
> +/* ZFile::HeaderTrailer::FLAG_SHIFT_*, zfile/zfile.cpp */
> +#define ZFILE_FLAG_HEADER           (1ULL << 0)
> +#define ZFILE_FLAG_DATA_FILE        (1ULL << 1)
> +#define ZFILE_FLAG_SEALED           (1ULL << 2)
> +#define ZFILE_FLAG_HEADER_OVERWRITE (1ULL << 3)
> +#define ZFILE_FLAG_DIGEST           (1ULL << 4)
> +#define ZFILE_FLAG_INDEX_COMPRESSED (1ULL << 5)
> +
> +/* ZFile::CompressOptions, zfile/compressor.h: sizeof =3D=3D 24 */
> +typedef struct QEMU_PACKED OverlaybdCompressOptions {
> +    uint32_t block_size;
> +    uint8_t algo;
> +    uint8_t level;
> +    uint8_t use_dict;
> +    uint8_t __padding_0;
> +    uint32_t reserved;
> +    uint32_t dict_size;
> +    uint8_t verify;
> +    uint8_t __padding_1[7];
> +} OverlaybdCompressOptions;
> +
> +/*
> + * ZFile::HeaderTrailer, zfile/zfile.cpp, embedding ZFile::CompressOptio=
ns
> + * at offset 72: upstream is not packed, but every member is naturally
> + * aligned at these offsets, so a packed C struct has the identical
> + * layout.  As with the LSMT header, the ZFILE_HT_SPACE tail that
> + * upstream keeps outside the type is declared here, per
> + * format_spec.md:39 (offset 89 ~ 511, of which opt.__padding_1 already
> + * covers 89 ~ 95).
> + */
> +typedef struct QEMU_PACKED OverlaybdZFileHeader {
> +    uint64_t magic0;
> +    uint8_t magic1[16];
> +    uint32_t size;           /* 96: the fields above, tail excluded */
> +    uint32_t digest;         /* CRC32C of bytes 28..511, digest zeroed *=
/
> +    uint64_t flags;
> +    uint64_t index_offset;
> +    uint64_t index_size;     /* # of u32 jump-table entries (blocks) */
> +    uint64_t original_file_size;
> +    uint32_t index_crc;
> +    uint32_t reserved_0;
> +    OverlaybdCompressOptions opt;
> +    uint8_t reserved_space[416];
> +} OverlaybdZFileHeader;
> +
> +QEMU_BUILD_BUG_ON(sizeof(OverlaybdCompressOptions) !=3D 24);
> +QEMU_BUILD_BUG_ON(sizeof(OverlaybdZFileHeader) !=3D ZFILE_HT_SPACE);
> +
> +/* ZFile::MAX_ZFILE_INDEX_SIZE, zfile/zfile.cpp */
> +#define ZFILE_MAX_INDEX_ENTRIES 1000000000LL
> +
> +/* crc32c_salt()'s seed, zfile/zfile.cpp: per-block CRCs are salted */
> +#define ZFILE_CRC_SALT          100007
> +
> +/*
> + * ZFile::JumpTable, zfile/zfile.cpp: within-group offsets are uint16_t,
> + * so one group spans at most UINT16_MAX + 1 bytes of compressed data.
> + */
> +#define ZFILE_JUMP_GROUP_BYTES  (UINT16_MAX + 1u)
> +
> +#define ZFILE_INDEX_CHUNK_BYTES (1 << 20) /* ZFile::load_jump_table delt=
a */
> +#define ZFILE_INDEX_MAX_COROUTINES 32
> +
> +/*
> + * In-memory 16-byte index entry. The field assignment mirrors the
> + * on-disk SegmentMapping (lo =3D lba:50 | length:14, hi =3D moffset:55 =
|
> + * zeroed:1 | tag:8, the tag slot holding the serving layer at runtime,
> + * like the reference implementation), but this struct deliberately does
> + * NOT map the disk image: bitfields are forbidden in packed or
> + * exact-layout structures (docs/devel/style.rst), so on-disk bytes are
> + * decoded by overlaybd_decode_entry() with explicit little-endian loads
> + * and the bit order below is compiler-managed, never exposed.
> + */
> +typedef struct OverlaybdSegment {
> +    uint64_t lba:50;
> +    uint64_t length:14;
> +    uint64_t moffset:55;
> +    uint64_t zeroed:1;
> +    uint64_t layer:8;
> +} OverlaybdSegment;
> +
> +QEMU_BUILD_BUG_ON(sizeof(OverlaybdSegment) !=3D 16);
> +
> +typedef struct OverlaybdZfile {
> +    uint64_t index_offset;       /* jump table offset, ZFile-relative by=
tes */
> +    uint64_t index_size;
> +    uint64_t original_file_size;
> +    uint32_t block_size;
> +    uint8_t algo;
> +    bool verify;
> +    /*
> +     * ZFile::JumpTable, zfile/zfile.cpp: block @i starts at
> +     * partial_offset[i >> group_shift] + deltas[i], except at a group
> +     * boundary where the delta is zero.
> +     */
> +    uint64_t *partial_offset;
> +    uint16_t *deltas;
> +    unsigned group_shift;
> +} OverlaybdZfile;
> +
> +typedef struct OverlaybdLayer {
> +    BdrvChild *child;
> +    bool is_zfile;
> +    uint64_t base_offset; /* tar prefix length in the child, bytes */
> +    uint64_t view_size;
> +    OverlaybdZfile zf;
> +    /* LSMT metadata, in ZFile-virtual space for compressed layers */
> +    uint64_t index_offset;
> +    OverlaybdSegment *index;
> +    size_t index_count;
> +    uint64_t virtual_size;
> +} OverlaybdLayer;
> +
> +typedef struct BDRVOverlaybdState {
> +    OverlaybdLayer *layers; /* top-first: layers[0] is the topmost layer=
 */
> +    int nb_layers;
> +    OverlaybdSegment *merged;
> +    size_t merged_cap;
> +    size_t merged_count;
> +    uint64_t virtual_size;
> +} BDRVOverlaybdState;
> +
> +/*
> + * Load one on-disk 16-byte index entry (two little-endian u64:
> + * lo =3D lba:50 | length:14, hi =3D moffset:55 | zeroed:1 | tag:8) into=
 the
> + * host-side entry. The on-disk tag is discarded; the merge assigns
> + * layers.
> + */
> +static void overlaybd_decode_entry(const uint8_t *p, OverlaybdSegment *o=
ut)
> +{
> +    uint64_t lo =3D ldq_le_p(p);
> +    uint64_t hi =3D ldq_le_p(p + 8);
> +
> +    out->lba =3D lo & (((uint64_t)1 << 50) - 1);
> +    out->length =3D (lo >> 50) & ((1u << 14) - 1);
> +    out->moffset =3D hi & (((uint64_t)1 << 55) - 1);
> +    out->zeroed =3D (hi >> 55) & 1;
> +    out->layer =3D 0;
> +}
> +
> +static bool overlaybd_has_magic(const void *ht, const void *magic0,
> +                                const void *magic1)
> +{
> +    return memcmp(ht, magic0, 8) =3D=3D 0 &&
> +           memcmp((const uint8_t *)ht + 8, magic1, 16) =3D=3D 0;
> +}
> +
> +static bool overlaybd_is_lsmt_header(const uint8_t *buf)
> +{
> +    return overlaybd_has_magic(buf, lsmt_magic0, lsmt_magic1);
> +}
> +
> +static bool overlaybd_is_zfile_header(const uint8_t *buf)
> +{
> +    return overlaybd_has_magic(buf, zfile_magic0, zfile_magic1);
> +}
> +
> +static bool overlaybd_is_tar_header(const uint8_t *hdr)
> +{
> +    return memcmp(hdr + 257, "ustar", 5) =3D=3D 0 &&
> +           (hdr[156] =3D=3D '0' || hdr[156] =3D=3D '\0' || hdr[156] =3D=
=3D 'x');
> +}
> +
> +static bool overlaybd_verify_lsmt_block(const OverlaybdLSMTHeader *ht,
> +                                        bool is_trailer)
> +{
> +    uint32_t flags;
> +
> +    if (!overlaybd_has_magic(ht, lsmt_magic0, lsmt_magic1)) {
> +        return false;
> +    }
> +    flags =3D le32_to_cpu(ht->flags);
> +    if (is_trailer) {
> +        return !(flags & LSMT_FLAG_HEADER) &&
> +                (flags & LSMT_FLAG_DATA_FILE) &&
> +                (flags & LSMT_FLAG_SEALED);
> +    }
> +    return flags & LSMT_FLAG_HEADER;
> +}
> +
> +/*
> + * Upstream's crc32::crc32c_extend() is the raw CRC-32C recurrence with =
no
> + * post-conditioning, while qemu's crc32c() inverts once on return, so X=
OR
> + * the result to recover upstream's value for any seed. A wrong conventi=
on
> + * here fails silently against real images: nothing but the digest misma=
tches.
> + */
> +static uint32_t overlaybd_crc32c(uint32_t seed, const void *buf, size_t =
len)
> +{
> +    return crc32c(seed, buf, len) ^ 0xffffffff;
> +}
> +
> +static bool overlaybd_zfile_verify_digest(OverlaybdZFileHeader *blk)
> +{
> +    uint32_t crc, saved =3D le32_to_cpu(blk->digest);
> +
> +    blk->digest =3D 0;
> +    crc =3D overlaybd_crc32c(0, blk, sizeof(*blk));
> +    blk->digest =3D cpu_to_le32(saved);
> +    return crc =3D=3D saved;
> +}
> +
> +static bool overlaybd_zfile_verify_block(OverlaybdZFileHeader *blk,
> +                                         bool is_trailer)
> +{
> +    uint64_t flags;
> +
> +    if (!overlaybd_has_magic(blk, zfile_magic0, zfile_magic1)) {
> +        return false;
> +    }
> +    flags =3D le64_to_cpu(blk->flags);
> +    if (is_trailer) {
> +        if ((flags & ZFILE_FLAG_HEADER) || !(flags & ZFILE_FLAG_DATA_FIL=
E) ||
> +            !(flags & ZFILE_FLAG_SEALED)) {
> +            return false;
> +        }
> +    } else {
> +        if (!(flags & ZFILE_FLAG_HEADER)) {
> +            return false;
> +        }
> +    }
> +    if (flags & ZFILE_FLAG_DIGEST && !overlaybd_zfile_verify_digest(blk)=
) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/*
> + * Locate a header/trailer block of @ht_space bytes near the end of the
> + * layer and return its offset, relative to the child, or -errno.  The
> + * block found is also copied to @ht_out, which must hold @ht_space byte=
s:
> + * it has already been read and validated here, so re-reading it at the
> + * returned offset would be a second I/O for the same bytes.
> + *
> + * The end of the layer is not the end of the child: a tar wrapper pads
> + * its entry to a blocking factor, so the scan must stop at
> + * base_offset + view_size. That end is still not exact for a bare layer=
,
> + * whose view_size is just bdrv_getlength() rounded up to 512 bytes, so
> + * scan the last @ht_space + 511 bytes for the magic (the same approach
> + * as dmg_find_koly_offset()), taking the match closest to the end.
> + */
> +static int64_t GRAPH_RDLOCK
> +overlaybd_scan_trailer(OverlaybdLayer *l, size_t ht_space, bool is_zfile=
,
> +                       void *ht_out)
> +{
> +    int64_t end =3D l->base_offset + l->view_size;
> +    int64_t window, off, found =3D -ENOENT;
> +    uint8_t *buf;
> +    int ret;
> +
> +    window =3D (int64_t)ht_space + 511;
> +    off =3D end > window ? end - window : 0;
> +    window =3D end - off;
> +
> +    buf =3D g_malloc(window);
> +    ret =3D bdrv_pread(l->child, off, window, buf, 0);
> +    if (ret < 0) {
> +        g_free(buf);
> +        return ret;
> +    }
> +    for (int64_t i =3D (int64_t)window - ht_space; i >=3D 0; i--) {
> +        bool ok;
> +
> +        /* copy the whole block: the ZFile digest covers all 512 bytes *=
/
> +        if (is_zfile) {
> +            OverlaybdZFileHeader blk;
> +
> +            memcpy(&blk, buf + i, sizeof(blk));
> +            ok =3D overlaybd_zfile_verify_block(&blk, true);
> +        } else {
> +            OverlaybdLSMTHeader blk;
> +
> +            memcpy(&blk, buf + i, sizeof(blk));
> +            ok =3D overlaybd_verify_lsmt_block(&blk, true);
> +        }
> +        if (ok) {
> +            memcpy(ht_out, buf + i, ht_space);
> +            found =3D off + i;
> +            break;
> +        }
> +    }
> +    g_free(buf);
> +    return found;
> +}
> +
> +/*
> + * ZFile::JumpTable::build(), zfile/zfile.cpp: turn the on-disk u32
> + * block lengths into one absolute offset per group plus uint16_t
> + * within-group prefix sums. @offset_begin is where block 0 lives,
> + * relative to the ZFile.
> + */
> +static int overlaybd_zfile_build_table(OverlaybdZfile *zf,
> +                                       const uint32_t *table,
> +                                       uint64_t offset_begin, Error **er=
rp)
> +{
> +    uint64_t group_size =3D ZFILE_JUMP_GROUP_BYTES / zf->block_size;
> +    uint64_t min_span =3D zf->verify ? 4 : 0;
> +    uint64_t raw_offset =3D offset_begin;
> +    uint32_t span;
> +
> +    zf->group_shift =3D ctz64(group_size);
> +    /*
> +     * g_try_new, not g_new: both sizes come from the image, and a hosti=
le
> +     * header can ask for gigabytes (at block_size 65536, group_size is =
1
> +     * and partial_offset costs 8 bytes per entry).
> +     */
> +    zf->partial_offset =3D g_try_new(uint64_t, zf->index_size / group_si=
ze + 1);
> +    zf->deltas =3D g_try_new(uint16_t, zf->index_size + 1);
> +    if (!zf->partial_offset || !zf->deltas) {
> +        return -ENOMEM;
> +    }
> +    zf->partial_offset[0] =3D raw_offset;
> +    zf->deltas[0] =3D 0;
> +
> +    for (uint64_t i =3D 1; i <=3D zf->index_size; i++) {
> +        span =3D ldl_le_p((const uint8_t *)&table[i - 1]);
> +
> +        if (span <=3D min_span || span > ZFILE_MAX_SPAN) {
> +            error_setg(errp, "invalid ZFile block size in jump table");
> +            return -EINVAL;
> +        }
> +        raw_offset +=3D span;
> +        if (i % group_size =3D=3D 0) {
> +            zf->partial_offset[i / group_size] =3D raw_offset;
> +            zf->deltas[i] =3D 0;
> +            continue;
> +        }
> +        if ((uint64_t)zf->deltas[i - 1] + span >=3D UINT16_MAX) {
> +            error_setg(errp, "ZFile compressed blocks in one jump table =
"
> +                             "group exceed %d bytes", UINT16_MAX);
> +            return -ERANGE;
> +        }
> +        zf->deltas[i] =3D zf->deltas[i - 1] + span;
> +    }
> +    return 0;
> +}
> +
> +/* ZFile::JumpTable::operator[], zfile/zfile.cpp */
> +static uint64_t overlaybd_zfile_block_off(const OverlaybdZfile *zf,
> +                                          uint64_t idx)
> +{
> +    uint64_t part =3D zf->partial_offset[idx >> zf->group_shift];
> +
> +    if (idx & ((1ULL << zf->group_shift) - 1)) {
> +        return part + zf->deltas[idx];
> +    }
> +    return part;
> +}
> +
> +typedef struct OverlaybdZfileLoad {
> +    BdrvChild *child;
> +    int64_t offset;   /* table start, relative to the child */
> +    uint8_t *table;
> +    uint64_t bytes;   /* table size */
> +    uint64_t next;    /* first byte no coroutine has claimed yet */
> +    int nb_done;
> +    int ret;
> +} OverlaybdZfileLoad;
> +
> +/*
> + * The caller holds the graph rdlock across the whole open, so these
> + * coroutines take no further lock. They share the one cursor in @load:
> + * claiming a chunk reads load->next then advances it with no yield betw=
een,
> + * and coroutines in one AioContext never run concurrently, so the chunk=
s are
> + * partitioned with no locking. Inputs are copied to locals here; only n=
ext,
> + * ret and nb_done stay shared (a private next would spin on chunk 0 for=
ever).
> + */
> +static void coroutine_fn GRAPH_RDLOCK
> +overlaybd_zfile_load_co(void *opaque)
> +{
> +    OverlaybdZfileLoad *load =3D opaque;
> +    BdrvChild *child =3D load->child;
> +    int64_t offset =3D load->offset;
> +    uint8_t *table =3D load->table;
> +    uint64_t bytes =3D load->bytes;
> +
> +    while (load->next < bytes) {
> +        uint64_t off =3D load->next;
> +        uint64_t len =3D MIN(bytes - off, (uint64_t)ZFILE_INDEX_CHUNK_BY=
TES);
> +        int ret;
> +
> +        load->next =3D off + len;
> +
> +        ret =3D bdrv_co_pread(child, offset + off, len, table + off, 0);
> +        if (ret < 0) {
> +            if (load->ret =3D=3D 0) {
> +                load->ret =3D ret;
> +            }
> +            break;
> +        }
> +    }
> +    load->nb_done++;
> +}
> +
> +static int GRAPH_RDLOCK
> +overlaybd_zfile_load_table(OverlaybdLayer *l, uint32_t *table, Error **e=
rrp)
> +{
> +    OverlaybdZfile *zf =3D &l->zf;
> +    uint64_t bytes =3D zf->index_size * sizeof(uint32_t);
> +    int ret;
> +
> +    if (bytes <=3D ZFILE_INDEX_CHUNK_BYTES) {
> +        ret =3D bdrv_pread(l->child, l->base_offset + zf->index_offset,
> +                         bytes, table, 0);
> +    } else {
> +        OverlaybdZfileLoad load =3D {
> +            .child =3D l->child,
> +            .offset =3D l->base_offset + zf->index_offset,
> +            .table =3D (uint8_t *)table,
> +            .bytes =3D bytes,
> +        };
> +        int nb_chunks =3D DIV_ROUND_UP(bytes, ZFILE_INDEX_CHUNK_BYTES);
> +        int nb_cos =3D MIN(nb_chunks, ZFILE_INDEX_MAX_COROUTINES);
> +
> +        for (int i =3D 0; i < nb_cos; i++) {
> +            qemu_coroutine_enter(qemu_coroutine_create(overlaybd_zfile_l=
oad_co,
> +                                                       &load));
> +        }
> +        BDRV_POLL_WHILE(l->child->bs, load.nb_done < nb_cos);
> +        ret =3D load.ret;
> +    }
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not read ZFile jump table");
> +    }
> +    return ret;
> +}
> +
> +static int GRAPH_RDLOCK
> +overlaybd_zfile_open(OverlaybdLayer *l, Error **errp)
> +{
> +    BdrvChild *child =3D l->child;
> +    OverlaybdZfile *zf =3D &l->zf;
> +    OverlaybdZFileHeader ht;
> +    uint64_t flags, index_offset, index_size, original_file_size;
> +    uint32_t *table =3D NULL;
> +    uint32_t block_size;
> +    uint8_t algo, verify;
> +    int64_t child_size, zfile_end;
> +    uint64_t end_reserve;
> +    int ret;
> +
> +    child_size =3D bdrv_getlength(child->bs);
> +    if (child_size < 0) {
> +        error_setg_errno(errp, -child_size, "could not get layer file si=
ze");
> +        return child_size;
> +    }
> +    child_size -=3D l->base_offset;
> +    if (child_size < 2 * ZFILE_HT_SPACE) {
> +        error_setg(errp, "layer file too small to be a ZFile");
> +        return -EINVAL;
> +    }
> +
> +    ret =3D bdrv_pread(child, l->base_offset, sizeof(ht), &ht, 0);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not read ZFile header");
> +        return ret;
> +    }
> +    if (!overlaybd_zfile_verify_block(&ht, false)) {
> +        error_setg(errp, "invalid ZFile header");
> +        return -EINVAL;
> +    }
> +
> +    flags =3D le64_to_cpu(ht.flags);
> +    /*
> +     * The layer's own end, not the child's: a tar wrapper pads its entr=
y.
> +     * bdrv_getlength() also rounds up, so when there is a trailer the
> +     * scanned trailer position gives the exact end instead.
> +     */
> +    zfile_end =3D l->view_size;
> +    end_reserve =3D 0;
> +    if (!(flags & ZFILE_FLAG_HEADER_OVERWRITE)) {
> +        /*
> +         * Without HEADER_OVERWRITE the trailer carries the final metada=
ta,
> +         * so the header is dead once its flags have been read and the
> +         * trailer is read into the same block -- as upstream does.
> +         */
> +        int64_t trl_off =3D overlaybd_scan_trailer(l, ZFILE_HT_SPACE, tr=
ue,
> +                                                 &ht);
> +
> +        if (trl_off < 0) {
> +            error_setg(errp, "invalid ZFile trailer");
> +            return -EINVAL;
> +        }
> +        flags =3D le64_to_cpu(ht.flags);
> +        zfile_end =3D trl_off + ZFILE_HT_SPACE - (int64_t)l->base_offset=
;
> +        end_reserve =3D ZFILE_HT_SPACE;
> +    }
> +
> +    if (flags & ZFILE_FLAG_INDEX_COMPRESSED) {
> +        error_setg(errp, "compressed ZFile jump table is not supported")=
;
> +        return -ENOTSUP;
> +    }
> +
> +    index_offset =3D le64_to_cpu(ht.index_offset);
> +    index_size =3D le64_to_cpu(ht.index_size);
> +    original_file_size =3D le64_to_cpu(ht.original_file_size);
> +    block_size =3D le32_to_cpu(ht.opt.block_size);
> +    algo =3D ht.opt.algo;
> +    verify =3D ht.opt.verify;
> +
> +    if (ht.opt.use_dict !=3D 0) {
> +        error_setg(errp, "ZFile with dictionary is not supported");
> +        return -ENOTSUP;
> +    }
> +    if (block_size =3D=3D 0 || block_size > ZFILE_MAX_BLOCK_SIZE ||
> +        !is_power_of_2(block_size)) {
> +        error_setg(errp, "invalid ZFile block size %" PRIu32, block_size=
);
> +        return -EINVAL;
> +    }
> +    if (algo !=3D ZFILE_ALGO_LZ4 && algo !=3D ZFILE_ALGO_ZSTD) {
> +        error_setg(errp, "unknown ZFile compression algorithm %" PRIu8, =
algo);
> +        return -EINVAL;
> +    }
> +#ifndef CONFIG_LZ4
> +    if (algo =3D=3D ZFILE_ALGO_LZ4) {
> +        error_setg(errp, "LZ4-compressed layer, but qemu was compiled "
> +                         "without lz4 support");
> +        return -ENOTSUP;
> +    }
> +#endif
> +#ifndef CONFIG_ZSTD
> +    if (algo =3D=3D ZFILE_ALGO_ZSTD) {
> +        error_setg(errp, "ZSTD-compressed layer, but qemu was compiled "
> +                         "without zstd support");
> +        return -ENOTSUP;
> +    }
> +#endif
> +
> +    if (index_size > ZFILE_MAX_INDEX_ENTRIES) {
> +        error_setg(errp, "ZFile index size %" PRIu64 " exceeds maximum "
> +                         "%lld", index_size, ZFILE_MAX_INDEX_ENTRIES);
> +        return -EINVAL;
> +    }
> +    /*
> +     * order the checks so each subtraction is guarded by the previous
> +     * condition (no unsigned wraparound on adversarial values)
> +     */
> +    if (index_offset < ZFILE_HT_SPACE ||
> +        index_offset > (uint64_t)zfile_end - end_reserve ||
> +        index_size * 4 > (uint64_t)zfile_end - end_reserve - index_offse=
t) {
> +        error_setg(errp, "invalid ZFile jump table location");
> +        return -EINVAL;
> +    }
> +    if ((index_size - 1) * block_size >=3D original_file_size ||
> +        original_file_size > index_size * block_size) {
> +        error_setg(errp, "ZFile block count does not match content size"=
);
> +        return -EINVAL;
> +    }
> +
> +    zf->index_offset =3D index_offset;
> +    zf->index_size =3D index_size;
> +    zf->original_file_size =3D original_file_size;
> +    zf->block_size =3D block_size;
> +    zf->algo =3D algo;
> +    zf->verify =3D verify;
> +
> +    table =3D qemu_try_blockalign(l->child->bs,
> +                                index_size * sizeof(uint32_t));
> +    if (!table) {
> +        return -ENOMEM;
> +    }
> +    ret =3D overlaybd_zfile_load_table(l, table, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +    /*
> +     * like the reference implementation, the jump table CRC is only
> +     * checked when the digest flag is set (it is garbage otherwise)
> +     */
> +    if ((flags & ZFILE_FLAG_DIGEST) && le32_to_cpu(ht.index_crc) !=3D
> +        overlaybd_crc32c(0, table, index_size * sizeof(uint32_t))) {
> +        error_setg(errp, "ZFile jump table CRC mismatch");
> +        ret =3D -EIO;
> +        goto out;
> +    }
> +
> +    ret =3D overlaybd_zfile_build_table(zf, table,
> +                                      ZFILE_HT_SPACE +
> +                                      le32_to_cpu(ht.opt.dict_size), err=
p);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +    if (overlaybd_zfile_block_off(zf, zf->index_size) > zf->index_offset=
) {
> +        error_setg(errp, "ZFile data region overlaps the jump table");
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> +
> +    l->view_size =3D zf->original_file_size;
> +    ret =3D 0;
> +out:
> +    qemu_vfree(table);
> +    return ret;
> +}
> +
> +/*
> + * Forward-only cursor into a QEMUIOVector. Seeding it and committing ea=
ch
> + * block's bytes are the same advance, so they share one. The blocks of =
a
> + * request are written contiguously in increasing order, so a full pass =
costs
> + * O(niov) rather than the O(niov * nblocks) of qemu_iovec_subvec_niov()=
,
> + * which rescans from iov[0] -- expensive for the one-iovec-per-guest-pa=
ge
> + * qiov that virtio-blk normally hands us.
> + */
> +typedef struct OverlaybdQiovCursor {
> +    struct iovec *iov;
> +    struct iovec *end;
> +    uint8_t *cur;
> +    size_t left;
> +} OverlaybdQiovCursor;
> +
> +static void overlaybd_qiov_cursor_advance(OverlaybdQiovCursor *c, size_t=
 n)
> +{
> +    while (c->cur && n >=3D c->left) {
> +        n -=3D c->left;
> +        if (++c->iov >=3D c->end) {
> +            c->cur =3D NULL;
> +            c->left =3D 0;
> +            return;
> +        }
> +        c->cur =3D (uint8_t *)c->iov->iov_base;
> +        c->left =3D c->iov->iov_len;
> +    }
> +    if (c->cur) {
> +        c->cur +=3D n;
> +        c->left -=3D n;
> +    }
> +}
> +
> +/*
> + * Point @c at byte 0 of @qiov.  @qiov is NULL on the buf path, which
> + * leaves the cursor exhausted, so every test of it fails closed.
> + */
> +static void overlaybd_qiov_cursor_init(OverlaybdQiovCursor *c,
> +                                       QEMUIOVector *qiov)
> +{
> +    c->iov =3D qiov ? qiov->iov : NULL;
> +    c->end =3D qiov ? qiov->iov + qiov->niov : NULL;
> +    c->cur =3D c->iov < c->end ? (uint8_t *)c->iov->iov_base : NULL;
> +    c->left =3D c->cur ? c->iov->iov_len : 0;
> +}
> +
> +/*
> + * All I/O goes through bdrv_pread() (a mixed wrapper), so this is
> + * callable from both GS and coroutine contexts.
> + */
> +static int coroutine_mixed_fn GRAPH_RDLOCK
> +overlaybd_zfile_read(OverlaybdLayer *l, uint64_t off, uint64_t bytes,
> +                     void *buf, QEMUIOVector *qiov, size_t qiov_off)
> +{
> +    OverlaybdZfile *zf =3D &l->zf;
> +    uint32_t bsz =3D zf->block_size;
> +    uint64_t first, last, base, need;
> +    uint8_t *cbuf =3D NULL;
> +    uint8_t *scratch =3D NULL;
> +    OverlaybdQiovCursor c;
> +    int ret;
> +
> +    assert(off + bytes <=3D zf->original_file_size);
> +
> +    /*
> +     * also keeps "off + bytes - 1" below from wrapping when both are 0,
> +     * which a caller reading an empty index can legitimately ask for
> +     */
> +    if (bytes =3D=3D 0) {
> +        return 0;
> +    }
> +
> +    first =3D off / bsz;
> +    last =3D (off + bytes - 1) / bsz;
> +    /*
> +     * One read covers the compressed bytes of every block the request s=
pans,
> +     * so the loop below never refills. A hostile jump table can still m=
ake
> +     * @need many times larger than @bytes, hence qemu_try_blockalign() =
rather
> +     * than the aborting qemu_blockalign(); aligning to the child's
> +     * opt_mem_alignment lets an already-aligned request reach the proto=
col
> +     * driver without being bounced.
> +     */
> +    base =3D overlaybd_zfile_block_off(zf, first);
> +    need =3D overlaybd_zfile_block_off(zf, last + 1) - base;
> +
> +    /*
> +     * One allocation for both: the compressed window, then the one-bloc=
k
> +     * decompression scratch behind it. bdrv_pread() writes only the fir=
st
> +     * @need bytes so the two never overlap, and only the window goes to=
 the
> +     * block layer, so only its start needs the alignment.
> +     */
> +    cbuf =3D qemu_try_blockalign(l->child->bs, need + bsz);
> +    if (!cbuf) {
> +        return -ENOMEM;
> +    }
> +    scratch =3D cbuf + need;
> +
> +    ret =3D bdrv_pread(l->child, l->base_offset + base, need, cbuf, 0);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    overlaybd_qiov_cursor_init(&c, qiov);
> +    overlaybd_qiov_cursor_advance(&c, qiov_off);
> +
> +    for (uint64_t bi =3D first; bi <=3D last; bi++) {
> +        uint64_t bstart =3D bi * (uint64_t)bsz;
> +        uint64_t expected =3D MIN((uint64_t)bsz,
> +                                zf->original_file_size - bstart);
> +        uint64_t cp_begin =3D bstart > off ? 0 : off - bstart;
> +        uint64_t cp_len =3D MIN(expected, off + bytes - bstart) - cp_beg=
in;
> +        uint64_t dst_off =3D bstart + cp_begin - off;
> +        uint64_t off_blk =3D overlaybd_zfile_block_off(zf, bi);
> +        uint64_t span =3D overlaybd_zfile_block_off(zf, bi + 1) - off_bl=
k;
> +        uint64_t clen =3D span - (zf->verify ? 4 : 0);
> +        const uint8_t *cdata;
> +        uint8_t *dst =3D NULL, *dec;
> +
> +        cdata =3D cbuf + (off_blk - base);
> +
> +        /*
> +         * BlockReader::crc32_code(), zfile/zfile.cpp: the salted CRC tr=
ails
> +         * the compressed data and covers exactly those bytes.  Upstream
> +         * retries three times before failing, which cannot help against=
 a
> +         * read-only child.
> +         */
> +        if (zf->verify) {
> +            uint32_t want =3D ldl_le_p(cdata + clen);
> +
> +            if (want !=3D overlaybd_crc32c(ZFILE_CRC_SALT, cdata, clen))=
 {
> +                ret =3D -EIO;
> +                goto out;
> +            }
> +        }
> +
> +        if (cp_begin =3D=3D 0 && cp_len =3D=3D expected) {
> +            if (buf) {
> +                dst =3D (uint8_t *)buf + dst_off;
> +            } else if (c.cur && cp_len <=3D c.left) {
> +                dst =3D c.cur;
> +            }
> +        }
> +        dec =3D dst ? dst : scratch;
> +
> +        ret =3D -EIO;
> +#ifdef CONFIG_LZ4
> +        if (zf->algo =3D=3D ZFILE_ALGO_LZ4) {
> +            int r =3D LZ4_decompress_safe((const char *)cdata, (char *)d=
ec,
> +                                        clen, expected);
> +
> +            if (r >=3D 0 && (uint64_t)r =3D=3D expected) {
> +                ret =3D 0;
> +            }
> +        }
> +#endif
> +#ifdef CONFIG_ZSTD
> +        if (zf->algo =3D=3D ZFILE_ALGO_ZSTD) {
> +            size_t r =3D ZSTD_decompress(dec, expected, cdata, clen);
> +
> +            if (!ZSTD_isError(r) && r =3D=3D expected) {
> +                ret =3D 0;
> +            }
> +        }
> +#endif
> +        if (ret < 0) {
> +            goto out;
> +        }
> +        if (!dst) {
> +            if (buf) {
> +                memcpy((uint8_t *)buf + dst_off, scratch + cp_begin, cp_=
len);
> +            } else {
> +                qemu_iovec_from_buf(qiov, qiov_off + dst_off,
> +                                    scratch + cp_begin, cp_len);
> +            }
> +        }
> +
> +        overlaybd_qiov_cursor_advance(&c, cp_len);
> +    }
> +
> +    ret =3D 0;
> +out:
> +    qemu_vfree(cbuf);
> +    return ret;
> +}
> +
> +static int GRAPH_RDLOCK
> +overlaybd_pread_view(OverlaybdLayer *l, uint64_t off, int64_t bytes, voi=
d *buf)
> +{
> +    if (l->is_zfile) {
> +        return overlaybd_zfile_read(l, off, bytes, buf, NULL, 0);
> +    }
> +    return bdrv_pread(l->child, l->base_offset + off, bytes, buf, 0);
> +}
> +
> +/*
> + * Load and validate the LSMT header/trailer/index of a layer. All
> + * metadata comes from the trailer; the header is only a format sniff
> + * (real images may have garbage header fields).
> + */
> +static int GRAPH_RDLOCK
> +overlaybd_lsmt_open(OverlaybdLayer *l, Error **errp)
> +{
> +    OverlaybdLSMTHeader ht;
> +    OverlaybdSegment *index =3D NULL;
> +    uint8_t *raw =3D NULL;
> +    uint64_t index_offset, index_size, virtual_size, moffset_end;
> +    uint64_t index_bound;
> +    uint64_t prev_end =3D 0;
> +    size_t count =3D 0;
> +    int ret;
> +
> +    if (l->view_size < 2 * LSMT_HT_SPACE) {
> +        error_setg(errp, "layer too small to be an LSMT image");
> +        return -EINVAL;
> +    }
> +
> +    ret =3D overlaybd_pread_view(l, 0, LSMT_HT_SPACE, &ht);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not read LSMT header");
> +        return ret;
> +    }
> +    if (!overlaybd_verify_lsmt_block(&ht, false)) {
> +        error_setg(errp, "invalid LSMT header");
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * The header is only a format sniff, so reading the trailer into th=
e
> +     * same block is safe.  index_bound is where the index must end: the
> +     * trailer start, which for a bare layer is not view_size - SPACE
> +     * because bdrv_getlength() over-reports (tar padding, rounding).
> +     */
> +    if (l->is_zfile) {
> +        /* in the ZFile virtual space the content size is exact */
> +        ret =3D overlaybd_pread_view(l, l->view_size - LSMT_HT_SPACE,
> +                                   LSMT_HT_SPACE, &ht);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "could not read LSMT trailer");
> +            return ret;
> +        }
> +        index_bound =3D l->view_size - LSMT_HT_SPACE;
> +    } else {
> +        int64_t trl_off =3D overlaybd_scan_trailer(l, LSMT_HT_SPACE, fal=
se,
> +                                                 &ht);
> +
> +        if (trl_off < 0) {
> +            error_setg(errp, "invalid LSMT trailer (not a sealed data "
> +                             "layer?)");
> +            return trl_off < -ENOENT ? trl_off : -EINVAL;
> +        }
> +        index_bound =3D (uint64_t)(trl_off - (int64_t)l->base_offset);
> +    }
> +    if (!overlaybd_verify_lsmt_block(&ht, true)) {
> +        error_setg(errp, "invalid LSMT trailer (not a sealed data layer?=
)");
> +        return -EINVAL;
> +    }
> +
> +    index_offset =3D le64_to_cpu(ht.index_offset);
> +    index_size =3D le64_to_cpu(ht.index_size);
> +    virtual_size =3D le64_to_cpu(ht.virtual_size);
> +
> +    if (index_size > LSMT_MAX_RO_INDEX_ENTRIES) {
> +        error_setg(errp, "LSMT index of %" PRIu64 " entries exceeds maxi=
mum "
> +                         "%" PRId64, index_size, LSMT_MAX_RO_INDEX_ENTRI=
ES);
> +        return -EINVAL;
> +    }
> +    if (index_offset < LSMT_HT_SPACE ||
> +        index_offset > index_bound ||
> +        index_size * 16 > index_bound - index_offset) {
> +        error_setg(errp, "invalid LSMT index location");
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * both sizes come from the image, so the allocating variants that
> +     * abort on OOM are not acceptable here; out: frees either pointer
> +     */
> +    index =3D g_try_new(OverlaybdSegment, index_size);
> +    raw =3D qemu_try_blockalign(l->child->bs, index_size * 16);
> +    if (!index || !raw) {
> +        ret =3D -ENOMEM;
> +        goto out;
> +    }
> +    ret =3D overlaybd_pread_view(l, index_offset, index_size * 16, raw);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not read LSMT index");
> +        goto out;
> +    }
> +
> +    moffset_end =3D index_offset / BDRV_SECTOR_SIZE;
> +    for (uint64_t i =3D 0; i < index_size; i++) {
> +        OverlaybdSegment seg, *out;
> +
> +        overlaybd_decode_entry(raw + i * 16, &seg);
> +        if (seg.lba =3D=3D LSMT_INVALID_OFFSET || seg.length =3D=3D 0) {
> +            continue;
> +        }
> +        if (count > 0 && seg.lba < prev_end) {
> +            error_setg(errp, "LSMT index is disordered or overlapping");
> +            ret =3D -EINVAL;
> +            goto out;
> +        }
> +        if (seg.zeroed) {
> +            if (seg.moffset < LSMT_MOFFSET_BEGIN ||
> +                seg.moffset > moffset_end) {
> +                error_setg(errp, "LSMT zeroed entry moffset out of range=
");
> +                ret =3D -EINVAL;
> +                goto out;
> +            }
> +        } else {
> +            if (seg.moffset < LSMT_MOFFSET_BEGIN ||
> +                seg.moffset >=3D moffset_end ||
> +                seg.moffset + seg.length > moffset_end) {
> +                error_setg(errp, "LSMT entry moffset out of range");
> +                ret =3D -EINVAL;
> +                goto out;
> +            }
> +        }
> +        out =3D &index[count++];
> +        *out =3D seg;
> +        prev_end =3D seg.lba + seg.length;
> +    }
> +
> +    l->index_offset =3D index_offset;
> +    l->index =3D index;
> +    index =3D NULL;
> +    l->index_count =3D count;
> +    l->virtual_size =3D virtual_size;
> +    ret =3D 0;
> +out:
> +    qemu_vfree(raw);
> +    g_free(index);
> +    return ret;
> +}
> +
> +static int GRAPH_RDLOCK
> +overlaybd_detect_tar(OverlaybdLayer *l, int64_t child_size, Error **errp=
)
> +{
> +    uint8_t hdr[512];
> +    uint64_t hoff =3D 0;
> +    int ret;
> +
> +    l->base_offset =3D 0;
> +    l->view_size =3D child_size;
> +
> +    if (child_size < 1024) {
> +        return 0;
> +    }
> +    ret =3D bdrv_pread(l->child, 0, sizeof(hdr), hdr, 0);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not read layer file header")=
;
> +        return ret;
> +    }
> +    if (memcmp(hdr + 257, "ustar", 5) !=3D 0) {
> +        return 0;
> +    }
> +    if (!overlaybd_is_tar_header(hdr)) {
> +        error_setg(errp, "unsupported tar layer layout");
> +        return -EINVAL;
> +    }
> +    if (hdr[156] =3D=3D 'x') {
> +        /*
> +         * pax extended header: its size field gives the length of the
> +         * attribute block that precedes the real ustar header
> +         */
> +        char size[13];
> +        unsigned long long pax_size;
> +
> +        memcpy(size, hdr + 124, 12);
> +        size[12] =3D 0;
> +        if (qemu_strtou64(size, NULL, 8, &pax_size) < 0) {
> +            pax_size =3D 0;
> +        }
> +        hoff =3D ZFILE_HT_SPACE +
> +               DIV_ROUND_UP(pax_size, ZFILE_HT_SPACE) * ZFILE_HT_SPACE;
> +        if (hoff + 2 * ZFILE_HT_SPACE > (uint64_t)child_size) {
> +            error_setg(errp, "tar layer too small");
> +            return -EINVAL;
> +        }
> +        ret =3D bdrv_pread(l->child, hoff, sizeof(hdr), hdr, 0);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "could not read tar file header=
");
> +            return ret;
> +        }
> +        if (memcmp(hdr + 257, "ustar", 5) !=3D 0 ||
> +            (hdr[156] !=3D '0' && hdr[156] !=3D '\0')) {
> +            error_setg(errp, "unsupported tar layer layout");
> +            return -EINVAL;
> +        }
> +    }
> +
> +    l->base_offset =3D hoff + ZFILE_HT_SPACE;
> +    l->view_size =3D child_size - l->base_offset;
> +    if (hdr[124] < 0x80) {
> +        /*
> +         * prefer the tar entry size: it is authoritative when the tar
> +         * entry is padded
> +         */
> +        char size[13];
> +        unsigned long long tar_size;
> +
> +        memcpy(size, hdr + 124, 12);
> +        size[12] =3D 0;
> +        if (!qemu_strtou64(size, NULL, 8, &tar_size) &&
> +            tar_size > 0 && tar_size <=3D l->view_size) {
> +            l->view_size =3D tar_size;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int GRAPH_RDLOCK
> +overlaybd_open_layer(OverlaybdLayer *l, Error **errp)
> +{
> +    uint8_t buf[512];
> +    int64_t child_size;
> +    int ret;
> +
> +    child_size =3D bdrv_getlength(l->child->bs);
> +    if (child_size < 0) {
> +        error_setg_errno(errp, -child_size, "could not get layer file si=
ze");
> +        return child_size;
> +    }
> +
> +    ret =3D overlaybd_detect_tar(l, child_size, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +    if (l->view_size < 2 * ZFILE_HT_SPACE) {
> +        error_setg(errp, "layer file too small");
> +        return -EINVAL;
> +    }
> +
> +    ret =3D bdrv_pread(l->child, l->base_offset, sizeof(buf), buf, 0);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "could not read layer file header")=
;
> +        return ret;
> +    }
> +    if (overlaybd_is_zfile_header(buf) &&
> +        (ldq_le_p(buf + 32) & ZFILE_FLAG_HEADER)) {
> +        l->is_zfile =3D true;
> +        ret =3D overlaybd_zfile_open(l, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    return overlaybd_lsmt_open(l, errp);
> +}
> +
> +/*
> + * First index whose entry covers or follows @sector: entries are sorted
> + * and non-overlapping, so entry ends are monotonically increasing.
> + * This matches the reference implementation's lower_bound(), which
> + * searches by entry end so that an entry covering @sector is found.
> + */
> +static size_t overlaybd_find_segment(const OverlaybdSegment *a, size_t n=
,
> +                                     uint64_t sector)
> +{
> +    size_t lo =3D 0, hi =3D n;
> +
> +    while (lo < hi) {
> +        size_t mid =3D (lo + hi) / 2;
> +
> +        if (a[mid].lba + a[mid].length <=3D sector) {
> +            lo =3D mid + 1;
> +        } else {
> +            hi =3D mid;
> +        }
> +    }
> +    return lo;
> +}
> +
> +/*
> + * Merge the per-layer indexes into s->merged: layers[0] is the topmost
> + * layer; a layer's mapping wins its whole extent, lower layers fill the
> + * holes. Entries pushed for [begin, end) are edge-trimmed to that range=
.
> + */
> +static bool overlaybd_merge_level(BDRVOverlaybdState *s, int level,
> +                                  uint64_t begin, uint64_t end, size_t *=
count)
> +{
> +    OverlaybdLayer *l;
> +    size_t i, size0 =3D *count;
> +    uint64_t begin0 =3D begin;
> +
> +    if (level >=3D s->nb_layers || begin >=3D end) {
> +        return true;
> +    }
> +    l =3D &s->layers[level];
> +    for (i =3D overlaybd_find_segment(l->index, l->index_count, begin);
> +         i < l->index_count && l->index[i].lba < end; i++) {
> +        OverlaybdSegment *e =3D &l->index[i];
> +
> +        if (e->lba > begin &&
> +            !overlaybd_merge_level(s, level + 1, begin, e->lba, count)) =
{
> +            return false;
> +        }
> +        if (*count =3D=3D s->merged_cap) {
> +            /*
> +             * One input entry can be emitted several times when it is
> +             * split by ranges covered (or zeroed) at upper layers, so t=
he
> +             * output can exceed the sum of the input indexes -- hence t=
he
> +             * cap, which upstream enforces at the same point.  Grow int=
o a
> +             * temporary so that a failed realloc leaves s->merged valid
> +             * for overlaybd_close() to free.
> +             */
> +            size_t cap =3D s->merged_cap ? s->merged_cap * 2 : 64;
> +            OverlaybdSegment *grown;
> +
> +            if (cap > LSMT_MAX_MERGED_ENTRIES) {
> +                return false;
> +            }
> +            grown =3D g_try_renew(OverlaybdSegment, s->merged, cap);
> +            if (!grown) {
> +                return false;
> +            }
> +            s->merged =3D grown;
> +            s->merged_cap =3D cap;
> +        }
> +        s->merged[*count] =3D *e;
> +        s->merged[*count].layer =3D level;
> +        (*count)++;
> +        begin =3D e->lba + e->length;
> +    }
> +    if (begin < end &&
> +        !overlaybd_merge_level(s, level + 1, begin, end, count)) {
> +        return false;
> +    }
> +    if (*count > size0) {
> +        OverlaybdSegment *first =3D &s->merged[size0];
> +        OverlaybdSegment *last =3D &s->merged[*count - 1];
> +
> +        if (first->lba < begin0) {
> +            uint64_t delta =3D begin0 - first->lba;
> +
> +            first->length -=3D delta;
> +            first->lba =3D begin0;
> +            if (!first->zeroed) {
> +                first->moffset +=3D delta;
> +            }
> +        }
> +        if (last->lba + last->length > end) {
> +            last->length =3D end - last->lba;
> +        }
> +    }
> +    return true;
> +}
> +
> +static int coroutine_fn GRAPH_RDLOCK
> +overlaybd_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
> +                    QEMUIOVector *qiov, BdrvRequestFlags flags)
> +{
> +    BDRVOverlaybdState *s =3D bs->opaque;
> +    uint64_t cur =3D offset >> BDRV_SECTOR_BITS;
> +    uint64_t end =3D cur + (bytes >> BDRV_SECTOR_BITS);
> +    size_t done =3D 0;
> +    int ret =3D 0;
> +
> +    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
> +    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
> +
> +    while (cur < end) {
> +        OverlaybdSegment *e;
> +        OverlaybdLayer *l;
> +        uint64_t run, run_end;
> +        size_t idx =3D overlaybd_find_segment(s->merged, s->merged_count=
, cur);
> +
> +        if (idx =3D=3D s->merged_count || s->merged[idx].lba >=3D end) {
> +            qemu_iovec_memset(qiov, done, 0, (end - cur) * BDRV_SECTOR_S=
IZE);
> +            break;
> +        }
> +        e =3D &s->merged[idx];
> +        if (e->lba > cur) {
> +            run =3D (e->lba - cur) * BDRV_SECTOR_SIZE;
> +            qemu_iovec_memset(qiov, done, 0, run);
> +            done +=3D run;
> +            cur =3D e->lba;
> +        }
> +        run_end =3D MIN(end, e->lba + e->length);
> +        run =3D (run_end - cur) * BDRV_SECTOR_SIZE;
> +        if (e->zeroed) {
> +            qemu_iovec_memset(qiov, done, 0, run);
> +        } else {
> +            int64_t off =3D (e->moffset + (cur - e->lba)) * BDRV_SECTOR_=
SIZE;
> +
> +            l =3D &s->layers[e->layer];
> +            if (l->is_zfile) {
> +                ret =3D overlaybd_zfile_read(l, off, run, NULL, qiov, do=
ne);
> +            } else {
> +                ret =3D bdrv_co_preadv_part(l->child, l->base_offset + o=
ff, run,
> +                                          qiov, done, 0);
> +            }
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +        done +=3D run;
> +        cur =3D run_end;
> +    }
> +    return ret;
> +}
> +
> +static void overlaybd_refresh_limits(BlockDriverState *bs, Error **errp)
> +{
> +    bs->bl.request_alignment =3D BDRV_SECTOR_SIZE;
> +}
> +
> +static int overlaybd_probe(const uint8_t *buf, int buf_size,
> +                           const char *filename)
> +{
> +    if (buf_size < 24) {
> +        return 0;
> +    }
> +    /*
> +     * Only a bare LSMT or ZFile magic is distinctive enough to claim a =
file.
> +     * A tar-wrapped layer shows just its entry header here, the payload
> +     * starting past the 512-byte probe window, and tar is far too gener=
ic a
> +     * container to claim on that evidence -- every unrelated archive wo=
uld
> +     * then fail to open instead of being read as raw. So a tar-wrapped =
layer
> +     * must be named explicitly (-f overlaybd, file.driver=3D,
> +     * layers.<n>.driver=3D or a manifest), all of which bypass probing.
> +     */
> +    if (overlaybd_is_lsmt_header(buf) || overlaybd_is_zfile_header(buf))=
 {
> +        return 100;
> +    }
> +    return 0;
> +}
> +
> +static void overlaybd_close(BlockDriverState *bs)
> +{
> +    BDRVOverlaybdState *s =3D bs->opaque;
> +    int i;
> +
> +    bdrv_graph_wrlock_drained();
> +    for (i =3D 0; i < s->nb_layers; i++) {
> +        if (s->layers[i].child) {
> +            bdrv_unref_child(bs, s->layers[i].child);
> +            s->layers[i].child =3D NULL;
> +        }
> +    }
> +    bdrv_graph_wrunlock();
> +
> +    for (i =3D 0; i < s->nb_layers; i++) {
> +        g_free(s->layers[i].zf.partial_offset);
> +        g_free(s->layers[i].zf.deltas);
> +        g_free(s->layers[i].index);
> +    }
> +    g_free(s->layers);
> +    s->layers =3D NULL;
> +    s->nb_layers =3D 0;
> +    g_free(s->merged);
> +    s->merged =3D NULL;
> +    s->merged_count =3D 0;
> +}
> +
> +/*
> + * Manifest handling: the layer stack comes either from an OCI image man=
ifest
> + * (manifest option, or the file child content) or from an explicit
> + * bottom-first "layers" array. Of a manifest only "schemaVersion" (must=
 be 2)
> + * and "layers" (non-empty, bottom-first) are read, and of each layer
> + * descriptor only "digest"; everything else -- the top-level "mediaType=
",
> + * "annotations", "subject" and the whole "config" descriptor -- is igno=
red,
> + * so the image config blob is never fetched.
> + *
> + * Blobs are named after the root they live under: ROOT/<alg>/<hex> for =
an OCI
> + * image layout's blobs/ or an explicit blob-path, or ROOT/<hex> when RO=
OT is
> + * itself an <alg> directory, i.e. the manifest is a sibling of the laye=
rs it
> + * names (an OCI layout read from inside blobs/sha256/, or a containerd
> + * content store).
> + *
> + * Specifications:
> + *   image manifest (schemaVersion, layers)
> + *     https://github.com/opencontainers/image-spec/blob/main/manifest.m=
d
> + *   descriptor "digest" grammar, narrowed by overlaybd_parse_digest()
> + *     https://github.com/opencontainers/image-spec/blob/main/descriptor=
.md
> + *   the blobs/<alg>/<hex> directory layout
> + *     https://github.com/opencontainers/image-spec/blob/main/image-layo=
ut.md
> + */
> +
> +typedef enum {
> +    OBD_BLOB_DIR,
> +    OBD_BLOB_SIBLING,
> +} OverlaybdBlobKind;
> +
> +typedef struct OverlaybdBlobRoot {
> +    char *path;
> +    OverlaybdBlobKind kind;
> +    GPtrArray *blobs;
> +} OverlaybdBlobRoot;
> +
> +#define OCI_DIGEST_ALG_MAX 32
> +#define OCI_DIGEST_HEX_MAX 128
> +/* an OCI image manifest is a few kilobytes; anything larger is not one =
*/
> +#define OCI_MANIFEST_MAX_SIZE (1u << 20)
> +
> +static char *overlaybd_blob_path(const OverlaybdBlobRoot *root,
> +                                 const char *alg, const char *hex)
> +{
> +    switch (root->kind) {
> +    case OBD_BLOB_SIBLING:
> +        return g_strdup_printf("%s/%s", root->path, hex);
> +    case OBD_BLOB_DIR:
> +        return g_strdup_printf("%s/%s/%s", root->path, alg, hex);
> +    }
> +    g_assert_not_reached();
> +}
> +
> +/*
> + * Validate a digest and split it into algorithm and hex parts. Both are=
 used
> + * verbatim as path components, so anything outside the OCI grammar -- i=
n
> + * particular "." and "/" -- is rejected. The grammar also allows separa=
tors
> + * in the algorithm and uppercase hex; both are excluded on purpose, sin=
ce
> + * every tool in practice emits a lowercase "sha256" and narrowing the s=
et
> + * costs nothing.
> + */
> +static int overlaybd_parse_digest(const char *digest, char **alg, char *=
*hex,
> +                                  Error **errp)
> +{
> +    static const char alg_chars[] =3D "abcdefghijklmnopqrstuvwxyz0123456=
789";
> +    static const char hex_chars[] =3D "0123456789abcdef";
> +    const char *colon =3D strchr(digest, ':');
> +    size_t alen, hlen;
> +
> +    if (!colon || strchr(colon + 1, ':')) {
> +        goto invalid;
> +    }
> +    alen =3D colon - digest;
> +    hlen =3D strlen(colon + 1);
> +    if (alen < 1 || alen > OCI_DIGEST_ALG_MAX ||
> +        hlen < 1 || hlen > OCI_DIGEST_HEX_MAX ||
> +        strspn(digest, alg_chars) !=3D alen ||
> +        strspn(colon + 1, hex_chars) !=3D hlen) {
> +        goto invalid;
> +    }
> +
> +    *alg =3D g_strndup(digest, alen);
> +    *hex =3D g_strdup(colon + 1);
> +    return 0;
> +
> +invalid:
> +    error_setg(errp, "invalid layer digest '%s'", digest);
> +    return -EINVAL;
> +}
> +
> +static int overlaybd_reject_url(const char *what, const char *ref,
> +                                Error **errp)
> +{
> +    if (path_has_protocol(ref)) {
> +        error_setg(errp, "%s '%s' is a URL; only local files are support=
ed",
> +                   what, ref);
> +        return -ENOTSUP;
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Put an explicit file child reference under @key, so that the blob is
> + * opened without format probing. A bare string reference would instead =
be
> + * looked up as a node name.
> + */
> +static void overlaybd_put_child(QDict *options, const char *key,
> +                                const char *value)
> +{
> +    /* two variables: reassigning a g_autofree one leaks the old value *=
/
> +    g_autofree char *drv_key =3D g_strdup_printf("%s.driver", key);
> +    g_autofree char *ref =3D g_strdup_printf("%s.filename", key);
> +
> +    qdict_put_str(options, drv_key, "file");
> +    qdict_put_str(options, ref, value);
> +}
> +
> +static int overlaybd_blob_root_from_option(const char *blob_path,
> +                                           OverlaybdBlobRoot *root,
> +                                           Error **errp)
> +{
> +    char *end;
> +    int ret;
> +
> +    ret =3D overlaybd_reject_url("blob-path", blob_path, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    root->path =3D g_strdup(blob_path);
> +    end =3D root->path + strlen(root->path);
> +    while (end > root->path && end[-1] =3D=3D '/') {
> +        *--end =3D '\0';
> +    }
> +    if (!*root->path) {
> +        error_setg(errp, "blob-path is empty");
> +        g_free(root->path);
> +        root->path =3D NULL;
> +        return -EINVAL;
> +    }
> +    root->kind =3D OBD_BLOB_DIR;
> +    return 0;
> +}
> +
> +static int overlaybd_derive_blob_root(const char *manifest, const char *=
alg,
> +                                      OverlaybdBlobRoot *root, Error **e=
rrp)
> +{
> +    g_autofree char *dir =3D NULL;
> +    g_autofree char *base =3D NULL;
> +    g_autofree char *alg_dir =3D NULL;
> +
> +    root->path =3D NULL;
> +
> +    dir =3D g_path_get_dirname(manifest);
> +    base =3D g_path_get_basename(dir);
> +    if (strcmp(base, alg) =3D=3D 0) {
> +        root->path =3D g_strdup(dir);
> +        root->kind =3D OBD_BLOB_SIBLING;
> +        return 0;
> +    }
> +
> +    /*
> +     * Otherwise the blobs are grouped by algorithm in a directory besid=
e
> +     * the manifest, either directly or under the blobs/ of an OCI image
> +     * layout. The root is that directory's parent, since a directory ro=
ot
> +     * composes ROOT/<alg>/<hex>.
> +     */
> +    alg_dir =3D g_build_filename(dir, alg, NULL);
> +    if (g_file_test(alg_dir, G_FILE_TEST_IS_DIR)) {
> +        root->path =3D g_strdup(dir);
> +    } else {
> +        root->path =3D g_build_filename(dir, "blobs", NULL);
> +        if (!g_file_test(root->path, G_FILE_TEST_IS_DIR)) {
> +            error_setg(errp, "could not find the blobs of manifest '%s':=
 no "
> +                       "%s/ or blobs/ directory beside it; give blob-pat=
h",
> +                       manifest, alg);
> +            g_free(root->path);
> +            root->path =3D NULL;
> +            return -ENOENT;
> +        }
> +    }
> +    root->kind =3D OBD_BLOB_DIR;
> +    return 0;
> +}
> +
> +static int overlaybd_parse_manifest(const char *content, QDict **manifes=
t_out,
> +                                    Error **errp)
> +{
> +    QDict *manifest;
> +    QObject *obj;
> +    int64_t version;
> +
> +    obj =3D qobject_from_json(content, errp);
> +    if (!obj) {
> +        return -EINVAL;
> +    }
> +    manifest =3D qobject_to(QDict, obj);
> +    if (!manifest) {
> +        error_setg(errp, "overlaybd manifest root is not a JSON object")=
;
> +        qobject_unref(obj);
> +        return -EINVAL;
> +    }
> +
> +    version =3D qdict_get_try_int(manifest, "schemaVersion", 0);
> +    if (version !=3D 2) {
> +        error_setg(errp, "unsupported OCI schemaVersion %" PRId64 ", "
> +                   "expected 2", version);
> +        qobject_unref(obj);
> +        return -ENOTSUP;
> +    }
> +    if (!qobject_to(QList, qdict_get(manifest, "layers"))) {
> +        error_setg(errp, "overlaybd manifest has no \"layers\" array");
> +        qobject_unref(obj);
> +        return -EINVAL;
> +    }
> +    *manifest_out =3D manifest;
> +    return 0;
> +}
> +
> +static int overlaybd_paths_from_manifest(QDict *manifest, const char *lo=
cation,
> +                                         OverlaybdBlobRoot *root, Error =
**errp)
> +{
> +    QList *layers =3D qobject_to(QList, qdict_get(manifest, "layers"));
> +    const QListEntry *entry;
> +    int i =3D 0, ret;
> +
> +    for (entry =3D qlist_first(layers); entry; entry =3D qlist_next(entr=
y)) {
> +        QDict *desc =3D qobject_to(QDict, entry->value);
> +        const char *digest =3D desc ? qdict_get_try_str(desc, "digest") =
: NULL;
> +        g_autofree char *alg =3D NULL;
> +        g_autofree char *hex =3D NULL;
> +
> +        if (!digest) {
> +            error_setg(errp, "layers[%d] has no digest", i);
> +            return -EINVAL;
> +        }
> +        ret =3D overlaybd_parse_digest(digest, &alg, &hex, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (i =3D=3D 0 && !root->path) {
> +            ret =3D overlaybd_derive_blob_root(location, alg, root, errp=
);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +        g_ptr_array_add(root->blobs, overlaybd_blob_path(root, alg, hex)=
);
> +        i++;
> +    }
> +    if (i =3D=3D 0) {
> +        error_setg(errp, "overlaybd manifest has no layers");
> +        return -EINVAL;
> +    }
> +    return 0;
> +}
> +
> +static int overlaybd_layers_from_options(QDict *options, int nb_layers,
> +                                         Error **errp)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < nb_layers; i++) {
> +        char key[32];
> +        const char *val;
> +        int n, ret;
> +
> +        n =3D snprintf(key, sizeof(key), "layers.%d", i);
> +        assert(n < (int)sizeof(key));
> +
> +        val =3D qdict_get_try_str(options, key);
> +        if (val) {
> +            g_autofree char *path =3D g_strdup(val);
> +
> +            ret =3D overlaybd_reject_url("layer", path, errp);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +            qdict_del(options, key);
> +            overlaybd_put_child(options, key, path);
> +        }
> +    }
> +    return 0;
> +}
> +
> +static int overlaybd_open_layers(BlockDriverState *bs, QDict *options,
> +                                 const OverlaybdBlobRoot *root, int nb_l=
ayers,
> +                                 BdrvChild *file_layer, Error **errp)
> +{
> +    BDRVOverlaybdState *s =3D bs->opaque;
> +    int ret;
> +    int i;
> +
> +    if (nb_layers > LSMT_MAX_LAYERS) {
> +        error_setg(errp, "too many overlaybd layers (%d, maximum %d)",
> +                   nb_layers, LSMT_MAX_LAYERS);
> +        return -EINVAL;
> +    }
> +
> +    s->layers =3D g_new0(OverlaybdLayer, nb_layers);
> +    s->nb_layers =3D nb_layers;
> +
> +    if (file_layer) {
> +        s->layers[0].child =3D file_layer;
> +    } else {
> +        for (i =3D 0; i < nb_layers; i++) {
> +            BdrvChild *child;
> +            char key[32];
> +            int n;
> +
> +            if (root) {
> +                n =3D snprintf(key, sizeof(key), "layer.%d", i);
> +                assert(n < (int)sizeof(key));
> +                overlaybd_put_child(options, key, root->blobs->pdata[i])=
;
> +            } else {
> +                n =3D snprintf(key, sizeof(key), "layers.%d", i);
> +                assert(n < (int)sizeof(key));
> +            }
> +
> +            child =3D bdrv_open_child(NULL, options, key, bs, &child_of_=
bds,
> +                                    BDRV_CHILD_DATA | BDRV_CHILD_METADAT=
A,
> +                                    false, errp);
> +            if (!child) {
> +                ret =3D -EINVAL;
> +                goto fail;
> +            }
> +            /*
> +             * fill top-first: the last path (bottom-first) is the top
> +             * layer
> +             */
> +            s->layers[nb_layers - 1 - i].child =3D child;
> +        }
> +    }
> +
> +    bdrv_graph_rdlock_main_loop();
> +    for (i =3D 0; i < nb_layers; i++) {
> +        ret =3D overlaybd_open_layer(&s->layers[i], errp);
> +        if (ret < 0) {
> +            goto unlock_fail;
> +        }
> +    }
> +
> +    s->merged_cap =3D 64;
> +    s->merged =3D g_new(OverlaybdSegment, s->merged_cap);
> +    if (!overlaybd_merge_level(s, 0, 0, UINT64_MAX, &s->merged_count)) {
> +        error_setg(errp, "failed to merge overlaybd layer indexes");
> +        ret =3D -EINVAL;
> +        goto unlock_fail;
> +    }
> +
> +    s->virtual_size =3D 0;
> +    for (i =3D 0; i < nb_layers; i++) {
> +        if (s->layers[i].virtual_size !=3D 0) {
> +            s->virtual_size =3D s->layers[i].virtual_size;
> +            break;
> +        }
> +    }
> +    if (s->virtual_size =3D=3D 0) {
> +        error_setg(errp, "overlaybd image has zero virtual size");
> +        ret =3D -EINVAL;
> +        goto unlock_fail;
> +    }
> +    /* DIV_ROUND_UP() below would wrap around to a zero-length image */
> +    if (s->virtual_size > UINT64_MAX - (BDRV_SECTOR_SIZE - 1)) {
> +        error_setg(errp, "overlaybd image virtual size %" PRIu64 " is to=
o "
> +                   "large", s->virtual_size);
> +        ret =3D -EINVAL;
> +        goto unlock_fail;
> +    }
> +
> +    bs->total_sectors =3D DIV_ROUND_UP(s->virtual_size, BDRV_SECTOR_SIZE=
);
> +    bdrv_graph_rdunlock_main_loop();
> +    return 0;
> +
> +unlock_fail:
> +    bdrv_graph_rdunlock_main_loop();
> +fail:
> +    return ret;
> +}
> +
> +static int overlaybd_open(BlockDriverState *bs, QDict *options, int flag=
s,
> +                          Error **errp)
> +{
> +    g_autofree char *manifest_opt =3D NULL;
> +    g_autofree char *blob_path =3D NULL;
> +    OverlaybdBlobRoot root =3D { 0 };
> +    const OverlaybdBlobRoot *blobs =3D NULL;
> +    QDict *manifest =3D NULL;
> +    const char *location =3D NULL;
> +    char *content =3D NULL;
> +    BdrvChild *file_layer =3D NULL;
> +    bool use_file_child;
> +    int nb_layers =3D 0;
> +    int ret;
> +
> +    GLOBAL_STATE_CODE();
> +
> +    bdrv_graph_rdlock_main_loop();
> +    ret =3D bdrv_apply_auto_read_only(bs, NULL, errp);
> +    bdrv_graph_rdunlock_main_loop();
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    qdict_flatten(options);
> +
> +    /* copy before deleting: qdict_get_try_str() borrows from the entry =
*/
> +    manifest_opt =3D g_strdup(qdict_get_try_str(options, "manifest"));
> +    blob_path =3D g_strdup(qdict_get_try_str(options, "blob-path"));
> +    qdict_del(options, "manifest");
> +    qdict_del(options, "blob-path");
> +    use_file_child =3D qdict_haskey(options, "file");
> +    nb_layers =3D qdict_array_entries(options, "layers.");
> +    if (nb_layers < 0) {
> +        error_setg(errp, "option layers is not a valid array");
> +        return -EINVAL;
> +    }
> +    if ((manifest_opt !=3D NULL) + use_file_child + (nb_layers > 0) > 1)=
 {
> +        error_setg(errp, "only one of manifest, file or layers may be gi=
ven");
> +        return -EINVAL;
> +    }
> +    if (!manifest_opt && !use_file_child && nb_layers =3D=3D 0) {
> +        error_setg(errp, "either manifest, file or layers is required");
> +        return -EINVAL;
> +    }
> +    if (blob_path && !manifest_opt && !use_file_child) {
> +        error_setg(errp, "blob-path requires a manifest");
> +        return -EINVAL;
> +    }
> +
> +    if (manifest_opt) {
> +        gsize len;
> +
> +        ret =3D overlaybd_reject_url("manifest", manifest_opt, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (!g_file_get_contents(manifest_opt, &content, &len, NULL)) {
> +            error_setg(errp, "could not read overlaybd manifest '%s'",
> +                       manifest_opt);
> +            return -ENOENT;
> +        }
> +        location =3D manifest_opt;
> +    } else if (use_file_child) {
> +        uint8_t sniff[512];
> +        const uint8_t *p, *end;
> +        int64_t len;
> +
> +        ret =3D bdrv_open_file_child(NULL, options, "file", bs, errp);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        /*
> +         * The file child is either an OCI image manifest or a single la=
yer,
> +         * possibly inside a tar and/or ZFile shell. No layer magic star=
ts
> +         * with '{', so a JSON document is a manifest and anything else =
is a
> +         * layer; overlaybd_open_layer() peels the shells and requires a=
n
> +         * LSMT core.
> +         */
> +        bdrv_graph_rdlock_main_loop();
> +        len =3D bdrv_getlength(bs->file->bs);
> +        if (len < 0) {
> +            bdrv_graph_rdunlock_main_loop();
> +            error_setg_errno(errp, -len, "could not get the file child s=
ize");
> +            ret =3D len;
> +            goto out;
> +        }
> +        memset(sniff, 0, sizeof(sniff));
> +        ret =3D bdrv_pread(bs->file, 0, MIN((uint64_t)len, sizeof(sniff)=
),
> +                         sniff, 0);
> +        if (ret < 0) {
> +            bdrv_graph_rdunlock_main_loop();
> +            error_setg_errno(errp, -ret, "could not read the file child"=
);
> +            goto out;
> +        }
> +        location =3D bs->file->bs->filename;
> +        end =3D sniff + MIN((uint64_t)len, sizeof(sniff));
> +        for (p =3D sniff; p < end && g_ascii_isspace(*p); p++) {
> +        }
> +        if (p =3D=3D end || *p !=3D '{') {
> +            file_layer =3D bs->file;
> +            nb_layers =3D 1;
> +            bdrv_graph_rdunlock_main_loop();
> +        } else {
> +            /*
> +             * @len comes from the child rather than from overlaybd, so =
it
> +             * cannot be handed to g_malloc() unchecked; a real manifest=
 is
> +             * a few kilobytes.
> +             */
> +            if (len > OCI_MANIFEST_MAX_SIZE) {
> +                bdrv_graph_rdunlock_main_loop();
> +                error_setg(errp, "file child starts like a JSON manifest=
 but "
> +                           "is %" PRId64 " bytes, above the %u byte limi=
t",
> +                           len, OCI_MANIFEST_MAX_SIZE);
> +                ret =3D -EINVAL;
> +                goto out;
> +            }
> +            content =3D g_malloc(len + 1);
> +            ret =3D bdrv_pread(bs->file, 0, len, content, 0);
> +            if (ret >=3D 0) {
> +                content[len] =3D 0;
> +                ret =3D 0;
> +            } else {
> +                error_setg_errno(errp, -ret,
> +                                 "could not read overlaybd manifest");
> +            }
> +            bdrv_graph_rdunlock_main_loop();
> +            if (ret < 0) {
> +                goto out;
> +            }
> +        }
> +    }
> +
> +    if (!file_layer) {
> +        if (content) {
> +            ret =3D overlaybd_parse_manifest(content, &manifest, errp);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +            root.blobs =3D g_ptr_array_new_with_free_func(g_free);
> +            if (blob_path) {
> +                ret =3D overlaybd_blob_root_from_option(blob_path, &root=
, errp);
> +                if (ret < 0) {
> +                    goto out;
> +                }
> +            }
> +            ret =3D overlaybd_paths_from_manifest(manifest, location, &r=
oot,
> +                                                errp);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +            nb_layers =3D root.blobs->len;
> +            blobs =3D &root;
> +        } else {
> +            ret =3D overlaybd_layers_from_options(options, nb_layers, er=
rp);
> +            if (ret < 0) {
> +                goto out;
> +            }
> +        }
> +    }
> +
> +    ret =3D overlaybd_open_layers(bs, options, blobs, nb_layers, file_la=
yer,
> +                                errp);
> +
> +out:
> +    g_free(root.path);
> +    if (root.blobs) {
> +        g_ptr_array_free(root.blobs, TRUE);
> +    }
> +    qobject_unref(manifest);
> +    g_free(content);
> +    if (ret < 0) {
> +        overlaybd_close(bs);
> +    }
> +    return ret;
> +}
> +
> +static BlockDriver bdrv_overlaybd =3D {
> +    .format_name         =3D "overlaybd",
> +    .instance_size       =3D sizeof(BDRVOverlaybdState),
> +    .bdrv_probe          =3D overlaybd_probe,
> +    .bdrv_open           =3D overlaybd_open,
> +    .bdrv_child_perm     =3D bdrv_default_perms,
> +    .bdrv_refresh_limits =3D overlaybd_refresh_limits,
> +    .bdrv_co_preadv      =3D overlaybd_co_preadv,
> +    .bdrv_close          =3D overlaybd_close,
> +    .is_format           =3D true,
> +};
> +
> +static void bdrv_overlaybd_init(void)
> +{
> +    bdrv_register(&bdrv_overlaybd);
> +}
> +
> +block_init(bdrv_overlaybd_init);
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-bl=
ock-drivers.rst.inc
> index 675daa72f9..2569f42e52 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -391,6 +391,43 @@ More disk image file formats are supported in a read=
-only mode.
>
>    Apple disk image.
>
> +.. program:: image-formats
> +.. option:: overlaybd
> +
> +  Overlaybd image, the layered format used by containerd's overlaybd
> +  snapshotter.  Each layer holds over-written data blocks, optionally
> +  compressed block-wise with LZ4 or ZSTD and optionally wrapped in a
> +  single-file tar.  Only sealed layers can be read; compressed layers
> +  need QEMU built with lz4 / zstd support respectively.  See
> +  https://github.com/containerd/overlaybd for the format specification.
> +
> +  The layer stack is given by exactly one of:
> +
> +  - ``manifest=3D<path>``: an OCI image manifest whose ``layers`` array
> +    (bottom-first, of each entry only ``digest`` is used) names the laye=
r
> +    blobs, plus an optional ``blob-path=3D<root>`` saying where they are=
.
> +    The root defaults to the blobs beside the manifest, which covers an
> +    OCI image layout and a containerd content store.
> +
> +  - ``layers.<n>.driver=3Dfile,layers.<n>.filename=3D<path>``: an explic=
it
> +    bottom-first list, the first element the base layer and the last the
> +    top layer.
> +
> +  - a ``file`` child holding a manifest or a single sealed layer, as
> +    ``-drive file=3D<path>`` provides.  A manifest must be named with
> +    ``format=3Doverlaybd``, since probing cannot recognise JSON.
> +
> +  A bare layer is detected by probing; a tar-wrapped one is not, as
> +  probing sees only the tar entry header, so it must be named explicitly
> +  via ``-f overlaybd``, a ``file`` child, ``layers.<n>`` or a manifest.
> +  Tar-wrapped layers are usually shipped gzip-compressed and must be
> +  unpacked first, since the driver reads an uncompressed tar.
> +
> +  For example::
> +
> +    qemu-img info --image-opts driver=3Doverlaybd,manifest=3Dmanifest.js=
on,\
> +    blob-path=3D/var/lib/containerd/io.containerd.content.v1.content/blo=
bs
> +
>  .. program:: image-formats
>  .. option:: parallels
>
> diff --git a/meson.build b/meson.build
> index cfac634cf1..d7468db2a7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1391,6 +1391,12 @@ if not get_option('zstd').auto() or have_block
>                      required: get_option('zstd'),
>                      method: 'pkg-config')
>  endif
> +lz4 =3D not_found
> +if not get_option('lz4').auto() or have_block
> +  lz4 =3D dependency('liblz4', version: '>=3D1.8.0',
> +                   required: get_option('lz4'),
> +                   method: 'pkg-config')
> +endif
>  qpl =3D not_found
>  if not get_option('qpl').auto() or have_system
>    qpl =3D dependency('qpl', version: '>=3D1.5.0',
> @@ -2542,6 +2548,7 @@ config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm=
3.found())
>  config_host_data.set('CONFIG_HOGWEED', hogweed.found())
>  config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_LZ4', lz4.found())
>  config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_UADK', uadk.found())
>  config_host_data.set('CONFIG_QATZIP', qatzip.found())
> @@ -4856,6 +4863,7 @@ if have_block
>    summary_info +=3D {'bochs support':     get_option('bochs').allowed()}
>    summary_info +=3D {'cloop support':     get_option('cloop').allowed()}
>    summary_info +=3D {'dmg support':       get_option('dmg').allowed()}
> +  summary_info +=3D {'overlaybd support': get_option('overlaybd').allowe=
d()}
>    summary_info +=3D {'qcow v1 support':   get_option('qcow1').allowed()}
>    summary_info +=3D {'vdi support':       get_option('vdi').allowed()}
>    summary_info +=3D {'vhdx support':      get_option('vhdx').allowed()}
> @@ -4989,6 +4997,7 @@ summary_info +=3D {'snappy support':    snappy}
>  summary_info +=3D {'bzip2 support':     libbzip2}
>  summary_info +=3D {'lzfse support':     liblzfse}
>  summary_info +=3D {'zstd support':      zstd}
> +summary_info +=3D {'lz4 support':       lz4}
>  summary_info +=3D {'Query Processing Library support': qpl}
>  summary_info +=3D {'UADK Library support': uadk}
>  summary_info +=3D {'qatzip support':    qatzip}
> diff --git a/meson_options.txt b/meson_options.txt
> index 6c2de6296f..a1b2ca6e56 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -270,6 +270,8 @@ option('xkbcommon', type : 'feature', value : 'auto',
>         description: 'xkbcommon support')
>  option('zstd', type : 'feature', value : 'auto',
>         description: 'zstd compression support')
> +option('lz4', type : 'feature', value : 'auto',
> +       description: 'lz4 compression support')
>  option('qpl', type : 'feature', value : 'auto',
>         description: 'Query Processing Library support')
>  option('uadk', type : 'feature', value : 'auto',
> @@ -339,6 +341,8 @@ option('cloop', type: 'feature', value: 'auto',
>         description: 'cloop image format support')
>  option('dmg', type: 'feature', value: 'auto',
>         description: 'dmg image format support')
> +option('overlaybd', type: 'feature', value: 'auto',
> +       description: 'overlaybd image format support')
>  option('qcow1', type: 'feature', value: 'auto',
>         description: 'qcow1 image format support')
>  option('vdi', type: 'feature', value: 'auto',
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index aed2888147..18a3fe8a95 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3390,6 +3390,7 @@
>              'iscsi',
>              'luks', 'nbd', 'nfs', 'null-aio', 'null-co', 'nvme',
>              { 'name': 'nvme-io_uring', 'if': 'CONFIG_BLKIO' },
> +            'overlaybd',
>              'parallels', 'preallocate', 'qcow', 'qcow2', 'qed', 'quorum'=
,
>              'raw', 'rbd',
>              { 'name': 'replication', 'if': 'CONFIG_REPLICATION' },
> @@ -4182,6 +4183,43 @@
>    'data': { 'path': 'str' },
>    'if': 'CONFIG_BLKIO' }
>
> +##
> +# @BlockdevOptionsOverlaybd:
> +#
> +# Driver specific block device options for overlaybd (read-only).
> +#
> +# @manifest: an OCI image manifest naming the layer stack.  Its
> +#     "layers" array is read bottom-first and only the "digest" of
> +#     each entry is used; the image config blob is never fetched.
> +#
> +# @blob-path: directory the layer digests are resolved against.
> +#     Optional, and derived from @manifest when absent.  Blobs are
> +#     looked up as BLOB-PATH/<alg>/<hex>, i.e. the blobs/ of an OCI
> +#     image layout.  A derived root is the blobs/ directory beside
> +#     the manifest, except when the manifest is itself a blob, as in
> +#     an OCI image layout addressed by digest or a containerd content
> +#     store, in which case the layers are its siblings,
> +#     BLOB-PATH/<hex>.
> +#
> +# @layers: explicit layer list, bottom-first: the first element is the
> +#     base layer, the last element is the top layer (the same order as
> +#     the "layers" array of an OCI image manifest)
> +#
> +# @file: the image to open, which may be either an OCI image manifest
> +#     or a bare sealed layer file, i.e. a single-layer image
> +#
> +# Exactly one of @manifest, @layers and @file must be given, and
> +# @blob-path only with a manifest.  Every reference is a local file;
> +# a URL is rejected.
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'BlockdevOptionsOverlaybd',
> +  'data': { '*manifest': 'str',
> +            '*blob-path': 'str',
> +            '*layers': [ 'BlockdevRef' ],
> +            '*file': 'BlockdevRef' } }
> +
>  ##
>  # @BlockdevOptionsVirtioBlkVfioPci:
>  #
> @@ -4905,6 +4943,7 @@
>        'nvme':       'BlockdevOptionsNVMe',
>        'nvme-io_uring': { 'type': 'BlockdevOptionsNvmeIoUring',
>                           'if': 'CONFIG_BLKIO' },
> +      'overlaybd':  'BlockdevOptionsOverlaybd',
>        'parallels':  'BlockdevOptionsGenericFormat',
>        'preallocate':'BlockdevOptionsPreallocate',
>        'qcow2':      'BlockdevOptionsQcow2',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.s=
h
> index 08c9fbb62c..a7bfcce254 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -153,6 +153,7 @@ meson_options_help() {
>    printf "%s\n" '  libvduse        build VDUSE Library'
>    printf "%s\n" '  linux-aio       Linux AIO support'
>    printf "%s\n" '  linux-io-uring  Linux io_uring support'
> +  printf "%s\n" '  lz4             lz4 compression support'
>    printf "%s\n" '  lzfse           lzfse support for DMG images'
>    printf "%s\n" '  lzo             lzo compression support'
>    printf "%s\n" '  malloc-trim     enable libc malloc_trim() for memory =
optimization'
> @@ -168,6 +169,7 @@ meson_options_help() {
>    printf "%s\n" '  nvmm            NVMM acceleration support'
>    printf "%s\n" '  opengl          OpenGL support'
>    printf "%s\n" '  oss             OSS sound support'
> +  printf "%s\n" '  overlaybd       overlaybd image format support'
>    printf "%s\n" '  pa              PulseAudio sound support'
>    printf "%s\n" '  parallels       parallels image format support'
>    printf "%s\n" '  passt           passt network backend support'
> @@ -404,6 +406,8 @@ _meson_option_parse() {
>      --disable-linux-io-uring) printf "%s" -Dlinux_io_uring=3Ddisabled ;;
>      --localedir=3D*) quote_sh "-Dlocaledir=3D$2" ;;
>      --localstatedir=3D*) quote_sh "-Dlocalstatedir=3D$2" ;;
> +    --enable-lz4) printf "%s" -Dlz4=3Denabled ;;
> +    --disable-lz4) printf "%s" -Dlz4=3Ddisabled ;;
>      --enable-lzfse) printf "%s" -Dlzfse=3Denabled ;;
>      --disable-lzfse) printf "%s" -Dlzfse=3Ddisabled ;;
>      --enable-lzo) printf "%s" -Dlzo=3Denabled ;;
> @@ -438,6 +442,8 @@ _meson_option_parse() {
>      --disable-opengl) printf "%s" -Dopengl=3Ddisabled ;;
>      --enable-oss) printf "%s" -Doss=3Denabled ;;
>      --disable-oss) printf "%s" -Doss=3Ddisabled ;;
> +    --enable-overlaybd) printf "%s" -Doverlaybd=3Denabled ;;
> +    --disable-overlaybd) printf "%s" -Doverlaybd=3Ddisabled ;;
>      --enable-pa) printf "%s" -Dpa=3Denabled ;;
>      --disable-pa) printf "%s" -Dpa=3Ddisabled ;;
>      --enable-parallels) printf "%s" -Dparallels=3Denabled ;;
> diff --git a/tests/qemu-iotests/tests/overlaybd b/tests/qemu-iotests/test=
s/overlaybd
> new file mode 100755
> index 0000000000..7ce102426f
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/overlaybd
> @@ -0,0 +1,795 @@
> +#!/usr/bin/env python3
> +# group: rw quick
> +#
> +# Test the read-only overlaybd block driver
> +#
> +# Builds a 3-layer stack (plain sealed LSMT base, LZ4 zfile middle layer
> +# with a zeroed range, ZSTD zfile top layer inside a tar wrapper with
> +# dirty header fields) plus a standalone LZ4 zfile of 16-byte blocks
> +# whose jump table exceeds 1 MiB, with pure-Python encoders -- LZ4
> +# literal-only and match-based blocks and ZSTD Raw_Blocks are valid
> +# without any compression library -- and verifies byte-exact reads
> +# through all interface forms plus the error paths.
> +#
> +# Copyright (c) 2026 Huiba Li <huiba.lhb@alibaba-inc.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import hashlib
> +import json
> +import os
> +import shutil
> +import struct
> +
> +import iotests
> +from iotests import file_path, log, qemu_img
> +
> +BLOCK =3D 4096
> +NBLOCKS =3D 256  # 1 MiB virtual image
> +SECTORS_PER_BLOCK =3D BLOCK // 512
> +
> +LSMT_MAGIC0 =3D b'LSMT\x00\x01\x02\x00'
> +LSMT_MAGIC1 =3D bytes([
> +    0x65, 0x7e, 0x63, 0xd2, 0x94, 0x44, 0x08, 0x4c,
> +    0xa2, 0xd2, 0xc8, 0xec, 0x4f, 0xcf, 0xae, 0x8a
> +])
> +ZFILE_MAGIC0 =3D b'ZFile\x00\x01\x00'
> +ZFILE_MAGIC1 =3D b'tuji.yyf@Alibaba'
> +
> +
> +def _crc32c_table() -> list:
> +    table =3D []
> +    for i in range(256):
> +        c =3D i
> +        for _ in range(8):
> +            c =3D (0x82f63b78 ^ (c >> 1)) if (c & 1) else (c >> 1)
> +        table.append(c)
> +    return table
> +
> +
> +CRC32C_TABLE =3D _crc32c_table()
> +
> +# zfile.cpp's NOI_WELL_KNOWN_PRIME: per-block CRCs are computed with thi=
s
> +# seed rather than 0
> +CRC32C_SALT =3D 100007
> +
> +
> +def crc32c(data: bytes, crc: int =3D 0) -> int:
> +    """Raw CRC-32C accumulation -- no init inversion and no final xor.
> +
> +    This is overlaybd's crc32::crc32c_extend(), which is NOT the standar=
d
> +    init-0xFFFFFFFF/xorout-0xFFFFFFFF CRC-32C. The two disagree on every
> +    input, and a fixture that used the standard form would agree with a
> +    driver that made the same mistake, so both would look correct while
> +    rejecting every real image.
> +    """
> +    table =3D CRC32C_TABLE
> +    for b in data:
> +        crc =3D table[(crc ^ b) & 0xff] ^ (crc >> 8)
> +    return crc
> +
> +
> +def lz4_block_literals(data: bytes) -> bytes:
> +    out =3D bytearray()
> +    n =3D len(data)
> +    if n < 15:
> +        out.append(n << 4)
> +    else:
> +        out.append(15 << 4)
> +        rest =3D n - 15
> +        while rest >=3D 255:
> +            out.append(255)
> +            rest -=3D 255
> +        out.append(rest)
> +    out +=3D data
> +    return bytes(out)
> +
> +
> +def lz4_block_zeros(n: int) -> bytes:
> +    """LZ4 block decoding to @n zero bytes.
> +
> +    One literal, one offset-1 match, then the five trailing literals the
> +    format requires; a block that ends in a match is rejected by
> +    LZ4_decompress_safe, so this only works for n >=3D 12.
> +    """
> +    match =3D n - 6
> +    assert match >=3D 4
> +    out =3D bytearray()
> +    ml =3D match - 4
> +    nib =3D min(ml, 15)
> +    out.append((1 << 4) | nib)
> +    out.append(0)
> +    out +=3D struct.pack('<H', 1)
> +    ml -=3D nib
> +    if nib =3D=3D 15:
> +        while ml >=3D 255:
> +            out.append(255)
> +            ml -=3D 255
> +        out.append(ml)
> +    out.append(5 << 4)
> +    out +=3D bytes(5)
> +    return bytes(out)
> +
> +
> +def zstd_frame_raw(data: bytes) -> bytes:
> +    out =3D bytearray(b'\x28\xb5\x2f\xfd\xe0')
> +    out +=3D struct.pack('<Q', len(data))
> +    off =3D 0
> +    while True:
> +        chunk =3D data[off:off + 128 * 1024]
> +        last =3D 1 if off + len(chunk) >=3D len(data) else 0
> +        out +=3D struct.pack('<I', (len(chunk) << 3) | last)[:3]
> +        out +=3D chunk
> +        off +=3D len(chunk)
> +        if last:
> +            break
> +    return bytes(out)
> +
> +
> +def fill_base(b: int) -> bytes:
> +    return bytes((b * 7 + 13 + i) & 0xff for i in range(BLOCK))
> +
> +
> +def fill_mid(b: int) -> bytes:
> +    return bytes((b * 11 + 29 + i * 3) & 0xff for i in range(BLOCK))
> +
> +
> +def fill_top(b: int) -> bytes:
> +    return bytes((b * 5 + 101 + i * 7) & 0xff for i in range(BLOCK))
> +
> +
> +def lsmt_header(flags: int, index_off: int, index_size: int,
> +                virtual_size: int) -> bytes:
> +    ht =3D bytearray(4096)
> +    ht[0:8] =3D LSMT_MAGIC0
> +    ht[8:24] =3D LSMT_MAGIC1
> +    struct.pack_into('<I', ht, 24, 390)
> +    struct.pack_into('<I', ht, 28, flags)
> +    struct.pack_into('<Q', ht, 32, index_off)
> +    struct.pack_into('<Q', ht, 40, index_size)
> +    struct.pack_into('<Q', ht, 48, virtual_size)
> +    return bytes(ht)
> +
> +
> +def build_lsmt(spec: dict, pattern) -> bytes:
> +    """spec maps 4K block index -> 1 (data) or 2 (zeroed); missing =3D h=
ole."""
> +    out =3D bytearray(4096)
> +    data =3D bytearray()
> +    slot_of =3D {}
> +    for b in sorted(k for k, v in spec.items() if v =3D=3D 1):
> +        slot_of[b] =3D (4096 >> 9) + len(data) // BLOCK * SECTORS_PER_BL=
OCK
> +        data +=3D pattern(b)
> +    index_off =3D 4096 + len(data)
> +
> +    index =3D bytearray()
> +    keys =3D sorted(spec.keys())
> +    i =3D 0
> +    while i < len(keys):
> +        j =3D i
> +        while j + 1 < len(keys) and keys[j + 1] =3D=3D keys[j] + 1 \
> +                and spec[keys[j + 1]] =3D=3D spec[keys[i]]:
> +            j +=3D 1
> +        first, count =3D keys[i], keys[j] - keys[i] + 1
> +        assert count * SECTORS_PER_BLOCK <=3D (1 << 14) - 1
> +        lba =3D first * SECTORS_PER_BLOCK
> +        length =3D count * SECTORS_PER_BLOCK
> +        if spec[keys[i]] =3D=3D 2:
> +            moffset, zeroed =3D 8, 1
> +        else:
> +            moffset, zeroed =3D slot_of[first], 0
> +        lo =3D lba | (length << 50)
> +        hi =3D moffset | (zeroed << 55)
> +        index +=3D struct.pack('<QQ', lo, hi)
> +        i =3D j + 1
> +
> +    out +=3D data
> +    out +=3D index
> +
> +    for flags in (2 | 4, 1 | 2):  # trailer first, then header
> +        ht =3D lsmt_header(flags, index_off, len(index) // 16, NBLOCKS *=
 BLOCK)
> +        if flags & 1:  # header goes over the placeholder
> +            out[0:4096] =3D ht
> +        else:
> +            out +=3D ht
> +    return bytes(out)
> +
> +
> +def wrap_zfile(content: bytes, algo: int, garbage: bool =3D False,
> +               block: int =3D BLOCK, overwrite: bool =3D False,
> +               bad_block_crc: bool =3D False) -> bytes:
> +    """Wrap into a ZFile blob: algo 1 =3D LZ4, 2 =3D ZSTD. With garbage,=
 the
> +    digest flag is clear and the digest/crc fields carry junk, like real
> +    baselayer files. With overwrite, the header carries the final metada=
ta
> +    and the trailer is left out -- upstream's HEADER_OVERWRITE shape, wh=
ich
> +    is what zfile_compress produces when it rewrites the header in place=
.
> +
> +    With bad_block_crc the first block's trailing CRC is wrong while its
> +    compressed bytes stay valid, so only the driver's per-block checksum
> +    can notice; corrupting the compressed stream instead would be caught
> +    by the decompressor and would prove nothing about the checksum.
> +
> +    All-zero blocks use the compact match encoding: the reference jump
> +    table stores in-group offsets as uint16, so the compressed blocks of
> +    a group must together stay under 64 KiB, which literal-only encoding
> +    cannot manage at a small block size."""
> +    zero_chunk =3D bytes(block)
> +    zero_c =3D lz4_block_zeros(block) if algo =3D=3D 1 else None
> +    body =3D bytearray()
> +    jump =3D bytearray()
> +    for off in range(0, len(content), block):
> +        chunk =3D content[off:off + block]
> +        if algo =3D=3D 1:
> +            if chunk =3D=3D zero_chunk:
> +                cdata =3D zero_c
> +            else:
> +                cdata =3D lz4_block_literals(chunk)
> +        else:
> +            cdata =3D zstd_frame_raw(chunk)
> +        body +=3D cdata
> +        crc =3D crc32c(cdata, CRC32C_SALT)
> +        if bad_block_crc and off =3D=3D 0:
> +            crc ^=3D 0xffffffff
> +        body +=3D struct.pack('<I', crc)
> +        jump +=3D struct.pack('<I', len(cdata) + 4)
> +
> +    out =3D bytearray()
> +    index_off =3D 512 + len(body)
> +    for is_header in (True, False):
> +        if overwrite and not is_header:
> +            break  # the header already carries the final metadata
> +        ht =3D bytearray(512)
> +        ht[0:8] =3D ZFILE_MAGIC0
> +        ht[8:24] =3D ZFILE_MAGIC1
> +        struct.pack_into('<I', ht, 24, 96)
> +        flags =3D (1 if is_header else 0) | 2 | 4 | (1 << 4)
> +        if overwrite:
> +            flags |=3D 1 << 3
> +        struct.pack_into('<Q', ht, 32, flags)
> +        struct.pack_into('<Q', ht, 40, index_off)
> +        struct.pack_into('<Q', ht, 48, len(content) // block
> +                         + (1 if len(content) % block else 0))
> +        struct.pack_into('<Q', ht, 56, len(content))
> +        struct.pack_into('<I', ht, 64, crc32c(bytes(jump)))
> +        struct.pack_into('<I', ht, 72, block)
> +        ht[76] =3D algo
> +        ht[88] =3D 1
> +        if garbage:
> +            struct.pack_into('<Q', ht, 32,
> +                             (1 if is_header else 0) | 2 | 4)
> +            struct.pack_into('<I', ht, 28,
> +                             0xfeedface if is_header else 0xdeadbeef)
> +            struct.pack_into('<I', ht, 64, 0xdeadbeef)
> +            ht[300:304] =3D b'\x01\x02\x03\x04'
> +        else:
> +            struct.pack_into('<I', ht, 28, crc32c(bytes(ht)))
> +        out +=3D ht
> +        if is_header:
> +            out +=3D body
> +            out +=3D jump
> +    return bytes(out)
> +
> +
> +# tar's default blocking factor: 20 x 512-byte records
> +TAR_BLOCKING =3D 10240
> +
> +
> +def wrap_tar(content: bytes) -> bytes:
> +    """Tar wrapper with the padding a real archiver writes, so that the
> +    archive ends well past the layer and the driver has to locate the
> +    layer trailer from the entry size rather than from the file size."""
> +    hdr =3D bytearray(512)
> +    hdr[0:9] =3D b'layer.bin'
> +    hdr[156] =3D ord('0')
> +    # slice assignment lengths must match exactly, or the bytearray
> +    # silently shrinks: 11 octal digits into the 12-byte size field
> +    # (the 12th byte stays NUL), 6 digits into the 8-byte checksum
> +    hdr[124:135] =3D b'%011o' % len(content)
> +    hdr[257:263] =3D b'ustar\x00'
> +    hdr[263:265] =3D b'00'
> +    hdr[148:156] =3D b' ' * 8
> +    hdr[148:154] =3D b'%06o' % (sum(hdr) & 0o777777)
> +    out =3D bytes(hdr) + content
> +    out +=3D bytes(-len(out) % 512)
> +    out +=3D bytes(1024)
> +    out +=3D bytes(-len(out) % TAR_BLOCKING)
> +    return out
> +
> +
> +# A ZFile of 16-byte blocks needs a jump table above 1 MiB (the point
> +# where the driver switches to parallel loading) once the content passes
> +# 4 MiB. 16 is the smallest block size whose all-zero LZ4 block still
> +# fits the uint16 in-group deltas, so the data region is that big.
> +BIG_BLOCK =3D 16
> +BIG_DATA =3D 4259840
> +BIG_VIRT_SECTORS =3D 24
> +
> +
> +def fill_big(tag: int) -> bytes:
> +    return bytes((tag * 31 + i * 5 + 7) & 0xff for i in range(4096))
> +
> +
> +def build_big_lsmt() -> tuple:
> +    """LSMT blob with two mapped 4K blocks, at the start and at the far
> +    end of an otherwise zero data region, plus the expected image.
> +
> +    The two blocks are 4 MiB apart, so reading them back exercises jump
> +    table lookups in two different groups.
> +    """
> +    index_off =3D 4096 + BIG_DATA
> +    far_moff =3D (index_off - 4096) // 512
> +    index =3D struct.pack('<QQ', 8 << 50, 8)
> +    index +=3D struct.pack('<QQ', 8 | (8 << 50), far_moff)
> +
> +    blob =3D bytearray(4096)
> +    blob +=3D fill_big(1)
> +    blob +=3D bytes(BIG_DATA - 2 * 4096)
> +    blob +=3D fill_big(2)
> +    blob +=3D index
> +    assert len(blob) =3D=3D index_off + len(index)
> +
> +    for flags in (2 | 4, 1 | 2):
> +        ht =3D lsmt_header(flags, index_off, len(index) // 16,
> +                         BIG_VIRT_SECTORS * 512)
> +        if flags & 1:
> +            blob[0:4096] =3D ht
> +        else:
> +            blob +=3D ht
> +
> +    expected =3D fill_big(1) + fill_big(2) + bytes(4096)
> +    return bytes(blob), expected
> +
> +
> +def corrupt_jump_table(src: str, dst: str, span: int) -> None:
> +    """Copy a ZFile with every jump table entry rewritten to @span, fixi=
ng
> +    up the index CRC and both header/trailer digests so that only the
> +    entry values differ."""
> +    with open(src, 'rb') as f:
> +        img =3D bytearray(f.read())
> +
> +    index_off =3D struct.unpack_from('<Q', img, 40)[0]
> +    index_size =3D struct.unpack_from('<Q', img, 48)[0]
> +    for i in range(index_size):
> +        struct.pack_into('<I', img, index_off + i * 4, span)
> +
> +    crc =3D crc32c(bytes(img[index_off:index_off + index_size * 4]))
> +    for ht_off in (0, len(img) - 512):
> +        ht =3D img[ht_off:ht_off + 512]
> +        struct.pack_into('<I', ht, 28, 0)
> +        struct.pack_into('<I', ht, 64, crc)
> +        struct.pack_into('<I', ht, 28, crc32c(bytes(ht)))
> +        img[ht_off:ht_off + 512] =3D ht
> +
> +    with open(dst, 'wb') as f:
> +        f.write(img)
> +
> +
> +mid_img =3D file_path('mid_lz4.zfile')
> +top_img =3D file_path('top_zstd.tar')
> +top_plain_img =3D file_path('top_plain.lsmt')
> +oci_dir =3D file_path('oci.d')
> +oci_blobs =3D os.path.join(oci_dir, 'blobs')
> +oci_exported =3D os.path.join(oci_dir, 'manifest.json')
> +alg_dir =3D file_path('algdir.d')
> +alg_manifest =3D os.path.join(alg_dir, 'manifest.json')
> +probe_img =3D file_path('probe.zfile')
> +converted =3D file_path('converted.raw')
> +garbage_img =3D file_path('garbage.bin')
> +garbage_zfile =3D file_path('garbage.zfile')
> +big_img =3D file_path('big_index.zfile')
> +small_img =3D file_path('small_lz4.zfile')
> +overwrite_img =3D file_path('overwrite_lz4.zfile')
> +huge_img =3D file_path('huge_vsize.lsmt')
> +overrun_img =3D file_path('overrun_index.lsmt')
> +corrupt_img =3D file_path('corrupt_index.zfile')
> +badcrc_img =3D file_path('bad_block_crc.zfile')
> +junk_tar =3D file_path('junk.tar')
> +badver_json =3D file_path('bad_schema_version.json')
> +nolayers_json =3D file_path('no_layers.json')
> +traverse_json =3D file_path('digest_traversal.json')
> +missing_json =3D file_path('missing_blob.json')
> +
> +TOP_BLOCKS =3D {b: 1 for b in list(range(0, 51)) + list(range(150, 201))=
}
> +MID_BLOCKS =3D {b: 1 for b in range(60, 161)}
> +MID_BLOCKS.update({b: 2 for b in range(210, 221)})
> +
> +
> +def expected_block(b: int) -> bytes:
> +    if b in TOP_BLOCKS:
> +        return fill_top(b)
> +    if b in MID_BLOCKS:
> +        return fill_mid(b) if MID_BLOCKS[b] =3D=3D 1 else bytes(BLOCK)
> +    return fill_base(b)
> +
> +
> +def expected_image() -> bytes:
> +    return b''.join(expected_block(b) for b in range(NBLOCKS))
> +
> +
> +def top_only_image() -> bytes:
> +    return b''.join(fill_top(b) if b in TOP_BLOCKS else bytes(BLOCK)
> +                    for b in range(NBLOCKS))
> +
> +
> +OCI_MANIFEST_MEDIA_TYPE =3D 'application/vnd.oci.image.manifest.v1+json'
> +OCI_LAYER_MEDIA_TYPE =3D 'application/vnd.oci.image.layer.v1.tar'
> +OCI_EMPTY_MEDIA_TYPE =3D 'application/vnd.oci.empty.v1+json'
> +
> +
> +def write_blob(data: bytes) -> str:
> +    digest =3D 'sha256:' + hashlib.sha256(data).hexdigest()
> +    alg, hexsum =3D digest.split(':', 1)
> +    d =3D os.path.join(oci_blobs, alg)
> +    os.makedirs(d, exist_ok=3DTrue)
> +    with open(os.path.join(d, hexsum), 'wb') as f:
> +        f.write(data)
> +    return digest
> +
> +
> +def digest_path(digest: str) -> str:
> +    alg, hexsum =3D digest.split(':', 1)
> +    return os.path.join(oci_blobs, alg, hexsum)
> +
> +
> +def build_oci_manifest(layers: list) -> tuple:
> +    """Write @layers (bottom-first) as blobs plus a manifest listing the=
m.
> +    Returns the manifest blob's path and the layer blob paths.
> +
> +    The image config blob is written as well, since the driver has to
> +    ignore it, but index.json is left out: the tests name the manifest
> +    directly instead of resolving it through the index."""
> +    cfg =3D b'{}'
> +    digests =3D [write_blob(data) for data in layers]
> +    manifest =3D json.dumps({
> +        'schemaVersion': 2,
> +        'mediaType': OCI_MANIFEST_MEDIA_TYPE,
> +        'config': {'mediaType': OCI_EMPTY_MEDIA_TYPE,
> +                   'digest': write_blob(cfg), 'size': len(cfg)},
> +        'layers': [{'mediaType': OCI_LAYER_MEDIA_TYPE,
> +                    'digest': d, 'size': len(data)}
> +                   for d, data in zip(digests, layers)],
> +        'annotations': {'org.opencontainers.image.ref.name': 'latest'},
> +    }).encode()
> +    return digest_path(write_blob(manifest)), [digest_path(d) for d in d=
igests]
> +
> +
> +def mutated_manifest(src: str, dst: str, mutate) -> str:
> +    with open(src) as f:
> +        m =3D json.load(f)
> +    mutate(m)
> +    with open(dst, 'w') as f:
> +        json.dump(m, f)
> +    return dst
> +
> +
> +def huge_virtual_size(src: str, dst: str) -> None:
> +    """Copy an LSMT with virtual_size set to the value that makes the
> +    driver's sectors conversion wrap around to a zero-length image. An
> +    LSMT header carries no digest, so both copies can be patched raw."""
> +    with open(src, 'rb') as f:
> +        img =3D bytearray(f.read())
> +    for off in (48, len(img) - 4096 + 48):
> +        struct.pack_into('<Q', img, off, (1 << 64) - 1)
> +    with open(dst, 'wb') as f:
> +        f.write(img)
> +
> +
> +def overrun_lsmt_index(src: str, dst: str, pad: int =3D 256) -> None:
> +    """Copy a bare LSMT with @pad bytes of trailing junk after its trail=
er,
> +    whose trailer then declares index entries reaching into that junk.
> +
> +    The padding is what makes the case reachable: the driver's view of t=
he
> +    layer ends at the child's length, so a bound taken at view_size - 40=
96
> +    accepts the overrun, while the trailer position the backward scan
> +    actually found is @pad bytes earlier. @pad must stay under 512 or th=
e
> +    scan window no longer reaches the trailer. An LSMT header carries no
> +    digest, so the copy can be patched raw."""
> +    assert pad < 512 and pad % 16 =3D=3D 0
> +    with open(src, 'rb') as f:
> +        img =3D bytearray(f.read())
> +    for off in (40, len(img) - 4096 + 40):
> +        n =3D struct.unpack_from('<Q', img, off)[0]
> +        struct.pack_into('<Q', img, off, n + pad // 16)
> +    img +=3D bytes(pad)
> +    with open(dst, 'wb') as f:
> +        f.write(img)
> +
> +
> +def make_fixtures() -> tuple:
> +    base =3D build_lsmt({b: 1 for b in range(NBLOCKS)}, fill_base)
> +    mid =3D wrap_zfile(build_lsmt(MID_BLOCKS, fill_mid), algo=3D1)
> +    top =3D wrap_tar(wrap_zfile(build_lsmt(TOP_BLOCKS, fill_top),
> +                              algo=3D2, garbage=3DTrue))
> +
> +    with open(mid_img, 'wb') as f:
> +        f.write(mid)
> +    with open(top_img, 'wb') as f:
> +        f.write(top)
> +    with open(top_plain_img, 'wb') as f:
> +        f.write(build_lsmt(TOP_BLOCKS, fill_top))
> +    with open(garbage_img, 'wb') as f:
> +        f.write(os.urandom(32 * 1024))
> +    with open(garbage_zfile, 'wb') as f:
> +        f.write(wrap_zfile(os.urandom(64 * 1024), algo=3D1))
> +    with open(junk_tar, 'wb') as f:
> +        f.write(wrap_tar(os.urandom(64 * 1024)))
> +    with open(small_img, 'wb') as f:
> +        f.write(wrap_zfile(build_lsmt({0: 1}, fill_base), algo=3D1))
> +    with open(overwrite_img, 'wb') as f:
> +        f.write(wrap_zfile(build_lsmt(TOP_BLOCKS, fill_top), algo=3D1,
> +                           overwrite=3DTrue))
> +    huge_virtual_size(top_plain_img, huge_img)
> +    overrun_lsmt_index(top_plain_img, overrun_img)
> +
> +    os.mkdir(oci_dir)
> +    manifest, blobs =3D build_oci_manifest([base, mid, top])
> +    shutil.copyfile(manifest, oci_exported)
> +
> +    os.mkdir(alg_dir)
> +    os.mkdir(os.path.join(alg_dir, 'sha256'))
> +    for blob in blobs:
> +        shutil.copyfile(blob, os.path.join(alg_dir, 'sha256',
> +                                           os.path.basename(blob)))
> +    shutil.copyfile(manifest, alg_manifest)
> +
> +    big_blob, big_expected =3D build_big_lsmt()
> +    with open(big_img, 'wb') as f:
> +        f.write(wrap_zfile(big_blob, algo=3D1, block=3DBIG_BLOCK))
> +    return big_expected, manifest, blobs
> +
> +
> +def codec_supported(algo: int) -> bool:
> +    """
> +    True unless the driver says this codec was not compiled in.
> +
> +    Keyed on the driver's own message, not on the exit status: a probe
> +    that only checked the status would also report "not compiled in"
> +    when the read path is merely broken, turning a real failure into a
> +    silent not-run.
> +    """
> +    name =3D {1: 'lz4', 2: 'zstd'}[algo]
> +    with open(probe_img, 'wb') as f:
> +        f.write(wrap_zfile(build_lsmt({0: 1}, fill_base), algo=3Dalgo))
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{probe_img}', check=3DFalse)
> +    return f'without {name} support' not in res.stdout
> +
> +
> +def convert(opts: str, out: str):
> +    return qemu_img('convert', '--image-opts', '-O', 'raw', opts, out,
> +                    check=3DFalse)
> +
> +
> +for algo in (1, 2):
> +    if not codec_supported(algo):
> +        iotests.notrun(f'zfile algo {algo} not compiled in')
> +
> +
> +def read_converted(path: str) -> bytes:
> +    with open(path, 'rb') as f:
> +        return f.read()
> +
> +
> +def probed_format(path: str) -> str:
> +    res =3D qemu_img('info', path, check=3DFalse)
> +    for line in res.stdout.splitlines():
> +        if line.startswith('file format:'):
> +            return line.split(':', 1)[1].strip()
> +    return ''
> +
> +
> +def expect(cond: bool, msg: str) -> None:
> +    if not cond:
> +        raise AssertionError(msg)
> +
> +
> +def test_overlaybd() -> None:
> +    big_expected, manifest, blobs =3D make_fixtures()
> +    # the manifest is itself a blob in blobs/sha256/, so the blob root i=
s
> +    # derived from its own path -- the OCI image layout and containerd
> +    # content store shapes
> +    cfg =3D f'driver=3Doverlaybd,manifest=3D{manifest}'
> +
> +    res =3D qemu_img('info', '--image-opts', cfg)
> +    expect('virtual size: 1 MiB' in res.stdout, 'unexpected info output'=
)
> +
> +    ret =3D convert(cfg, converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D expected_image(),
> +           'manifest mode: content mismatch')
> +    log('manifest mode: byte-exact')
> +
> +    for name, opts in (
> +            ('explicit blob-path',
> +             f'driver=3Doverlaybd,manifest=3D{manifest},blob-path=3D{oci=
_blobs}'),
> +            ('exported manifest',
> +             f'driver=3Doverlaybd,manifest=3D{oci_exported},'
> +             f'blob-path=3D{oci_blobs}'),
> +            ('exported manifest, derived blob-path',
> +             f'driver=3Doverlaybd,manifest=3D{oci_exported}'),
> +            ('manifest beside an <alg> directory',
> +             f'driver=3Doverlaybd,manifest=3D{alg_manifest}')):
> +        ret =3D convert(opts, converted)
> +        expect(ret.returncode =3D=3D 0, ret.stderr or f'{name}: convert =
failed')
> +        expect(read_converted(converted) =3D=3D expected_image(),
> +               f'{name}: content mismatch')
> +    log('blob-path forms: byte-exact')
> +
> +    layers =3D (f'driver=3Doverlaybd,'
> +              f'layers.0.driver=3Dfile,layers.0.filename=3D{blobs[0]},'
> +              f'layers.1.driver=3Dfile,layers.1.filename=3D{blobs[1]},'
> +              f'layers.2.driver=3Dfile,layers.2.filename=3D{blobs[2]}')
> +    ret =3D convert(layers, converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D expected_image(),
> +           'layers mode: content mismatch')
> +    log('layers mode: byte-exact')
> +
> +    single =3D f'driver=3Doverlaybd,layers.0.driver=3Dfile,' \
> +             f'layers.0.filename=3D{top_plain_img}'
> +    ret =3D convert(single, converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D top_only_image(),
> +           'single layer: content mismatch')
> +    log('single plain layer: byte-exact')
> +
> +    single =3D f'driver=3Doverlaybd,layers.0.driver=3Dfile,' \
> +             f'layers.0.filename=3D{overwrite_img}'
> +    ret =3D convert(single, converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D top_only_image(),
> +           'overwrite header: content mismatch')
> +    log('header-overwrite zfile: byte-exact')
> +
> +    # the file child given as a dict reference carries the manifest
> +    # (a bare string "file" would be a node-name reference, which is
> +    # why -drive file=3D... passes the filename as a parameter); the blo=
b
> +    # root has to be derived from the child's own filename
> +    ret =3D convert(f'driver=3Doverlaybd,file.driver=3Dfile,'
> +                  f'file.filename=3D{manifest}', converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D expected_image(),
> +           'file-manifest mode: content mismatch')
> +    log('file child as manifest: byte-exact')
> +
> +    ret =3D convert(f'driver=3Doverlaybd,file.driver=3Dfile,'
> +                  f'file.filename=3D{top_img}', converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D top_only_image(),
> +           'file layer mode: content mismatch')
> +    log('file child as tar layer: byte-exact')
> +
> +    # probing sees only the first 512 bytes: a bare LSMT and a bare ZFil=
e
> +    # match on their magic, but a tar shell shows nothing there except a
> +    # generic entry header, so tars are deliberately not claimed -- ever=
y
> +    # unrelated tar would then fail to open, and probing has no fallback
> +    expect(probed_format(top_plain_img) =3D=3D 'overlaybd', 'LSMT not pr=
obed')
> +    expect(probed_format(mid_img) =3D=3D 'overlaybd', 'ZFile not probed'=
)
> +    expect(probed_format(top_img) =3D=3D 'raw', 'tar layer claimed by pr=
obing')
> +    expect(probed_format(garbage_img) =3D=3D 'raw', 'garbage not probed =
as raw')
> +    log('format probing verified')
> +
> +    big =3D f'driver=3Doverlaybd,layers.0.driver=3Dfile,' \
> +          f'layers.0.filename=3D{big_img}'
> +    res =3D qemu_img('info', '--image-opts', big)
> +    expect('virtual size: 12 KiB' in res.stdout, 'unexpected info output=
')
> +    ret =3D convert(big, converted)
> +    expect(ret.returncode =3D=3D 0, ret.stderr or 'convert failed')
> +    expect(read_converted(converted) =3D=3D big_expected,
> +           'big jump table: content mismatch')
> +    log('1 MiB jump table: byte-exact')
> +
> +    # error paths (qemu_img() merges stdout and stderr)
> +    res =3D qemu_img('info', '--image-opts', 'driver=3Doverlaybd', check=
=3DFalse)
> +    expect('either manifest, file or layers is required' in res.stdout,
> +           'missing options: wrong error')
> +    res =3D qemu_img('info', '--image-opts',
> +                   'driver=3Doverlaybd,manifest=3D/nonexistent.json', ch=
eck=3DFalse)
> +    expect('could not read overlaybd manifest' in res.stdout,
> +           'missing manifest: wrong error')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,manifest=3D{manifest},'
> +                   f'layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{mid_img}', check=3DFalse)
> +    expect('only one of manifest, file or layers may be given' in res.st=
dout,
> +           'conflicting options: wrong error')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,blob-path=3D{oci_blobs},'
> +                   f'layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{mid_img}', check=3DFalse)
> +    expect('blob-path requires a manifest' in res.stdout,
> +           'blob-path without manifest: wrong error')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,manifest=3D{manifest},blob-path=
=3D/',
> +                   check=3DFalse)
> +    expect('blob-path is empty' in res.stdout,
> +           'empty blob-path: wrong error')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{garbage_img}', check=3DFalse)
> +    expect('invalid LSMT header' in res.stdout,
> +           'garbage layer: wrong error')
> +    res =3D qemu_img('info', '-f', 'overlaybd', junk_tar, check=3DFalse)
> +    expect('invalid LSMT header' in res.stdout,
> +           'tar of garbage: wrong error')
> +    # probing cannot see past a shell: it claims this on the ZFile magic=
,
> +    # so the payload is only verified once the ZFile is open
> +    res =3D qemu_img('info', garbage_zfile, check=3DFalse)
> +    expect('invalid LSMT header' in res.stdout,
> +           'ZFile of garbage: wrong error')
> +
> +    mutated_manifest(manifest, badver_json,
> +                     lambda m: m.update(schemaVersion=3D1))
> +    mutated_manifest(manifest, nolayers_json, lambda m: m.pop('layers'))
> +    mutated_manifest(manifest, traverse_json,
> +                     lambda m: m['layers'][0].update(
> +                         digest=3D'sha256:../../../../../../../etc/passw=
d'))
> +    mutated_manifest(manifest, missing_json,
> +                     lambda m: m['layers'][0].update(
> +                         digest=3D'sha256:' + '0' * 64))
> +    for name, path, want in (
> +            ('schemaVersion', badver_json, 'unsupported OCI schemaVersio=
n'),
> +            ('no layers', nolayers_json, 'has no "layers" array'),
> +            ('digest traversal', traverse_json, 'invalid layer digest'))=
:
> +        res =3D qemu_img('info', '--image-opts',
> +                       f'driver=3Doverlaybd,manifest=3D{path},'
> +                       f'blob-path=3D{oci_blobs}', check=3DFalse)
> +        expect(want in res.stdout, f'{name}: wrong error: {res.stdout}')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,manifest=3D{missing_json},'
> +                   f'blob-path=3D{oci_blobs}', check=3DFalse)
> +    expect(f'{oci_blobs}/sha256/' + '0' * 64 in res.stdout,
> +           f'missing blob: wrong error: {res.stdout}')
> +
> +    for name, opts in (
> +            ('manifest URL',
> +             'driver=3Doverlaybd,manifest=3Dhttp://127.0.0.1:1/manifest.=
json'),
> +            ('blob-path URL',
> +             f'driver=3Doverlaybd,manifest=3D{manifest},'
> +             'blob-path=3Dhttp://127.0.0.1:1/blobs'),
> +            ('layer URL',
> +             'driver=3Doverlaybd,layers.0=3Dhttp://127.0.0.1:1/blobs/sha=
256/0')):
> +        res =3D qemu_img('info', '--image-opts', opts, check=3DFalse)
> +        expect('only local files are supported' in res.stdout,
> +               f'{name}: wrong error: {res.stdout[-200:]}')
> +
> +    # 30000-byte blocks: the running in-group offset no longer fits u16
> +    corrupt_jump_table(small_img, corrupt_img, 30000)
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{corrupt_img}', check=3DFalse)
> +    expect('jump table group exceed' in res.stdout,
> +           'oversized jump table group: wrong error')
> +    # A valid compressed block whose trailing CRC is wrong. Opening the =
LSMT
> +    # layer reads its header, which is ZFile block 0, so only the driver=
's
> +    # per-block checksum can turn this into an error; without it the blo=
ck
> +    # decodes fine and the corruption is never noticed.
> +    with open(badcrc_img, 'wb') as f:
> +        f.write(wrap_zfile(build_lsmt({0: 1}, fill_base), algo=3D1,
> +                           bad_block_crc=3DTrue))
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{badcrc_img}', check=3DFalse)
> +    expect(res.returncode !=3D 0 and 'Input/output error' in res.stdout,
> +           f'corrupt block CRC: rc=3D{res.returncode} {res.stdout[-200:]=
}')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{huge_img}', check=3DFalse)
> +    expect('virtual size 18446744073709551615 is too large' in res.stdou=
t,
> +           f'huge virtual size: wrong error: {res.stdout}')
> +    res =3D qemu_img('info', '--image-opts',
> +                   f'driver=3Doverlaybd,layers.0.driver=3Dfile,'
> +                   f'layers.0.filename=3D{overrun_img}', check=3DFalse)
> +    expect('invalid LSMT index location' in res.stdout,
> +           f'overrunning LSMT index: wrong error: {res.stdout[-200:]}')
> +    log('error paths verified')
> +
> +    # file_path() only removes plain files, so the layout directories go
> +    # explicitly (as tests/vvfat does)
> +    shutil.rmtree(oci_dir)
> +    shutil.rmtree(alg_dir)
> +
> +
> +if __name__ =3D=3D '__main__':
> +    iotests.script_main(test_overlaybd, supported_fmts=3D['raw'],
> +                        supported_protocols=3D['file'])
> diff --git a/tests/qemu-iotests/tests/overlaybd.out b/tests/qemu-iotests/=
tests/overlaybd.out
> new file mode 100644
> index 0000000000..be1352fbce
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/overlaybd.out
> @@ -0,0 +1,10 @@
> +manifest mode: byte-exact
> +blob-path forms: byte-exact
> +layers mode: byte-exact
> +single plain layer: byte-exact
> +header-overwrite zfile: byte-exact
> +file child as manifest: byte-exact
> +file child as tar layer: byte-exact
> +format probing verified
> +1 MiB jump table: byte-exact
> +error paths verified
> --
> 2.54.0 (Apple Git-157)
>

