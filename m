Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7626C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pg4-0001lc-M1; Wed, 16 Sep 2026 09:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pfv-0001kS-Bm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ale@rev.ng>) id 1x6pfs-0003sE-De
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=HermaQxa5SqXU2Q5DfB1gtpu5S22yJJsaYeForMeUPo=; b=TMsMtWyQEAM6OXc
 xQFTPm4SFbJjYVIJuk8jm78WcUn64VePdpH8JeOMP/6054+itWly4YjtEbAWfmUBl1nJW1Frd6++s
 YFcZkijwKi53xFgz7p+5H18YghKvdRuwFnNJSxNAfzV6XLADN/n5CtUT0FjL7HB/KFoPHS7Yca90s
 7s=;
Date: Wed, 16 Sep 2026 14:28:48 +0200
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@mailo.com
Subject: Re: [PATCH v2 21/50] helper-to-tcg: Add guest vector layout
 description
Message-ID: <20260916142848.732526d7@spawn>
In-Reply-To: <20260730031025.12926-22-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-22-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=ale@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Alessandro Di Federico <ale@rev.ng>
From:  Alessandro Di Federico via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 30 Jul 2026 05:09:55 +0200
Anton Johansson <anjo@rev.ng> wrote:

> Vectors are represented as arrays of host-endian blocks at least 64 bits in
> size, the size of which is configurable.  Lane 0 in each block may be
> placed either at the most- or least-significant bytes.
> 
> This covers a wide range of QEMU targets' vector representations.
> 
> Vector layout information is used later when mapping constant
> expressions such as constant vectors, and when emitting helper functions
> for performing size-changing operations.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  .../helper-to-tcg/include/VectorLayout.hpp    | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 subprojects/helper-to-tcg/include/VectorLayout.hpp
> 
> diff --git a/subprojects/helper-to-tcg/include/VectorLayout.hpp b/subprojects/helper-to-tcg/include/VectorLayout.hpp
> new file mode 100644
> index 0000000000..e85f5029d5
> --- /dev/null
> +++ b/subprojects/helper-to-tcg/include/VectorLayout.hpp
> @@ -0,0 +1,116 @@
> +//
> +//  Copyright(c) 2026 rev.ng Labs Srl. All Rights Reserved.
> +//
> +//  This program is free software; you can redistribute it and/or modify
> +//  it under the terms of the GNU General Public License as published by
> +//  the Free Software Foundation; either version 2 of the License, or
> +//  (at your option) any later version.
> +//
> +//  This program is distributed in the hope that it will be useful,
> +//  but WITHOUT ANY WARRANTY; without even the implied warranty of
> +//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +//  GNU General Public License for more details.
> +//
> +//  You should have received a copy of the GNU General Public License
> +//  along with this program; if not, see <http://www.gnu.org/licenses/>.
> +//
> +
> +#pragma once
> +
> +#include <llvm/ADT/ArrayRef.h>
> +#include <stddef.h>
> +#include <stdint.h>
> +
> +// Vector Layout
> +//
> +// Vector layouts among QEMU guests is quite diverse, this header aims to be
> +// simple but still capture a large subset of targets.
> +//
> +// Guest vectors are assumed to be divided into host-endian blocks of a
> +// configurable size (>= 64-bit and power-of-two), with block 0 always being at
> +// the lowest address.  Blocks in turn are divided into 64-bit columns which are
> +// used when interfacing with QEMUs `gvec` API.
> +//
> +// Below is a 32-byte <32 x i8> guest vector consisting of 16-byte blocks,
> +// 8-byte columns, and 1-byte lanes for each element in the vector.  Elements
> +// count from 1-32 in hex to indicate their position in memory.  Note this
> +// example is for a little-endian host with `LeastSignificant` lane preference
> +// meaning lane 0 is at the least significant bytes of each block.
> +//
> +//   Guest vector <32 x i8> {1, 2, 3, ..., 32}
> +//   +---------------------------------+---------------------------------+
> +//   |              BLOCK 0            |              BLOCK 1            |
> +//   +----------------+----------------+----------------+----------------+
> +//   |    COLUMN 0    |    COLUMN 1    |    COLUMN 2    |    COLUMN 3    |
> +//   |0102030405060708|090A0B0C0D0E0F10|1112131415161718|191A1B1C1D1E1F20|
> +//
> +//   LOW ADDRESS                                              HIGH ADDRESS
> +//
> +// On a big-endian host, the vector would instead be expressed in memory as
> +//
> +//   Guest vector <32 x i8> {1, 2, 3, ..., 32}
> +//   +---------------------------------+---------------------------------+
> +//   |              BLOCK 0            |              BLOCK 1            |
> +//   +----------------+----------------+----------------+----------------+
> +//   |    COLUMN 1    |    COLUMN 0    |    COLUMN 3    |    COLUMN 2    |
> +//   |100F0E0D0C0B0A09|0807060504030201|201F1E1D1C1B1A19|1817161514131211|
> +//
> +//   LOW ADDRESS                                              HIGH ADDRESS
> +//
> +// with the column order having shifted to make sure the host-endian blocks
> +// retain the same value.  Blocks are also allowed to be equal or greater in
> +// size that the guest vector, at which point the entire memory view of the
> +// vector would reverse when going from a little to big-endian host.
> +//
> +// The lane preference may also be changed to `MostSignificant` which for the
> +// little-endian example places lane 0 and the highest address of block 0.
> +// Note, that `MostSignificant` on little-endian and `LeastSignificant` on
> +// big-endian hosts are equivalent in their memory representation, but will
> +// differ in how they are emitted in C:
> +//
> +//   // MostSignificant, little endian
> +//   uint64_t vec[] = {0x90A0B0C0D0E0F10, 0x102030405060708, ...};
> +//
> +//   // LeastSignificant, big endian
> +//   uint64_t vec[] = {0x100F0E0D0C0B0A09, 0x807060504030201, ...};
> +//
> +
> +enum LanePreference {
> +    LeastSignificant,
> +    MostSignificant,
> +};
> +
> +struct VectorLayout {
> +    bool HostBigEndian;
> +    LanePreference Lane0;
> +    size_t BlockBytes;
> +
> +    inline size_t index(bool Reverse, size_t Count, size_t I, size_t J) const {

Methods defined inline are implicitly inline. Drop.

> +        if (Reverse) {
> +            return Count * I + (J ^ (Count - 1));
> +        } else {
> +            return Count * I + J;
> +        }
> +    }
> +
> +    // Return the index into a linear array of lane L in column C
> +    inline size_t indexLane(size_t LanesPerColumn, size_t C, size_t L) const {
> +        const bool Reverse = (Lane0 == MostSignificant);
> +        return index(Reverse, LanesPerColumn, C, L);
> +    }
> +
> +    // Return the index into a linear array of
> +    inline size_t indexBlock(size_t BlocksPerVec, size_t I) const {
> +        const bool Reverse = (HostBigEndian ^ (Lane0 == MostSignificant));
> +        return index(Reverse, BlocksPerVec, 0, I);
> +    }
> +
> +    //inline uint64_t column(llvm::ArrayRef<uint64_t> Lanes) {
> +    //    uint64_t Column = 0;
> +    //    const size_t LanesPerColumn = 64 / ElementSize;
> +    //    for (size_t L = 0; L < LanesPerColumn; ++L) {
> +    //        const size_t Index = VL.indexLane(LanesPerColumn, C, L);
> +    //        Column |= Ints[Index] << (ElementSize * L);
> +    //    }
> +    //}

Do not commit commented code.

> +};
> -- 
> 2.52.0

Reviewed-by: Alessandro Di Federico <ale@rev.ng>

-- 
Alessandro Di Federico
rev.ng Labs

