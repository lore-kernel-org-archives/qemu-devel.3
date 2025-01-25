Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C7DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 21:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbnzS-0004ax-Vc; Sat, 25 Jan 2025 16:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tbnzL-0004aH-IP
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 16:46:48 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tbnzI-0003fh-Sj
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 16:46:46 -0500
Received: from [192.168.1.8] (default-rdns.vocus.co.nz [202.150.110.104] (may
 be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 50PLkRGc2378469
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Sat, 25 Jan 2025 21:46:30 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=bdYorims header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1737841592;
 bh=DqELh9P7k079YxtL494nqZ4ttzI8mS00V0YjBFGUeSc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=bdYorimspyp2M54ofW7LMqPs8Ldbr3zcIe691zj0Z6ULWDBRggjBUq/qlz/AOJJEz
 EMHHGgV2Ugf0YDKNyNlOH8Q+z9F+M9QKhV4xlepkrlrA0ZMGTZPV517Zjwa6/QTQra
 MpIOwgDueTVR1P3mPr9AWiWUUvB9lGdRaMx/5NukI+MTY4xj21nSRxM1XuSL8RF7Xo
 dldo/Gx7sbjkiu/emcA78YEty8Uesr2CqL4geCMtPlxxBTREJTNvE/JEgxAr6lrdnV
 t67dxKTZNTzWrqmOdgQVIDDk+TWg9ykZY/tV1S08zDuLfir+BlAkw+rsp9dsGA9R9Z
 lfcL4lO2SX6PA==
Message-ID: <d91b9e83-1648-43c6-809f-7cd21cb83e51@anarch128.org>
Date: Sun, 26 Jan 2025 10:46:21 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] x86-disas: add x86-mini disassembler implementation
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250124001032.1073926-1-michael@anarch128.org>
 <20250124001032.1073926-5-michael@anarch128.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <20250124001032.1073926-5-michael@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

to save time on reviews. I had a look over the patch in light
of QEMU conventions I neglected due to it being portable code.

this is what I have found so far:

- use g_malloc/g_malloc0/g_free instead of malloc/calloc/free.
- remove duplicate unused definition of ctz/clz/popcnt.
- remove some magic constants and replace with math.
- remove some unnecessary casts.

the only thing that forks the code is the allocator conversion
as most of the code is quite functional/combinatorial. I could
get away with layering a patch on top of the upstream code.

I noticed QEMU doesn't use alloca much. I prefer it for small
temporary function scope allocations because it is super cheap.

I was thinking. it would be nice to pipe the bytes to another
thread. that way the disassembler won't trash the cache and it
might run a little faster. because otherwise it will dominate
L1 cache and compete with the translator for cache. one could
use something like this pipe, with the addition of a sleeping
mutex. I am using it in a kernel with spinlocks but it would
not be too hard to add a sleeping mutex on qfull. it would be
faster than sockets because it's just a couple of atomic compare
swap and memcpy in the case that the queue is not full. one
could copy a whole translation block at a time. that limits
the cache footprint to stuff already in cache.

- https://github.com/michaeljclark/cpipe/

I will spin a v2 in a few weeks time. with this sort of thing:

diff --git a/disas/x86-core.c b/disas/x86-core.c
index d2704bf839f4..8a08f9bff4b3 100644
--- a/disas/x86-core.c
+++ b/disas/x86-core.c
@@ -27,6 +27,7 @@

  #include "disas/x86.h"
  #include "disas/x86-tables.inc"
+#include "qemu/osdep.h"

  #define array_size(arr) (sizeof(arr) / sizeof(arr[0]))

@@ -787,7 +788,7 @@ static int x86_opc_data_compare_alpha(const void 
*p1, const void *p2)

  static x86_table_idx x86_opc_table_index(size_t n)
  {
-    x86_table_idx tab = { n, malloc(sizeof(size_t) * n) };
+    x86_table_idx tab = { n, g_malloc(sizeof(size_t) * n) };
      for (size_t i = 0; i < tab.count; i++) tab.idx[i] = i;
      return tab;
  }
@@ -819,7 +820,7 @@ x86_table_idx x86_opc_table_filter(x86_table_idx 
tab, uint modes)
          const x86_opc_data *d = x86_opc_table + tab.idx[i];
          if (d->mode & modes) count++;
      }
-    x86_table_idx newtab = { count, malloc(sizeof(size_t) * count) };
+    x86_table_idx newtab = { count, g_malloc(sizeof(size_t) * count) };
      count = 0;
      for (size_t i = 0; i < tab.count; i++) {
          const x86_opc_data *d = x86_opc_table + tab.idx[i];
@@ -1079,24 +1080,25 @@ static void x86_build_accel_table(x86_acc_idx 
*idx, x86_acc_entry *acc)

  static x86_acc_idx *x86_table_build(uint modes)
  {
-    x86_acc_idx *idx = calloc(1, sizeof(x86_acc_idx));
+    x86_acc_idx *idx = g_malloc0(sizeof(x86_acc_idx));
      x86_table_idx tab = x86_opc_table_sorted(x86_opc_table_filter(
          x86_opc_table_identity(), modes), x86_sort_numeric);
-    ullong *modfun = (ullong *)calloc(2048, sizeof(ullong));
-    ullong *modmod = (ullong *)calloc(2048, sizeof(ullong));
+    size_t bmap_size = /*t,p,m*/ 512 * /*opcode*/ 256 >> /*bits*/ 3;
+    ullong *modfun = g_malloc0(bmap_size);
+    ullong *modmod = g_malloc0(bmap_size);
      x86_build_prefix_clashes(idx, tab, modfun, modmod);
      x86_build_prefix_table(idx, tab, NULL, &idx->map_count, modfun, 
modmod);
-    idx->map = calloc(idx->map_count, sizeof(x86_opc_data));
+    idx->map = g_malloc0(idx->map_count * sizeof(x86_opc_data));
      x86_build_prefix_table(idx, tab, idx->map, NULL, modfun, modmod);
      qsort(idx->map, idx->map_count, sizeof(x86_opc_data),
          x86_opc_data_compare_build);
-    idx->page_offsets = calloc(512, sizeof(uchar));
+    idx->page_offsets = g_malloc0(/*t,p,m*/ 512);
      idx->acc_count = x86_build_accel_offsets(idx);
-    idx->acc = calloc(sizeof(x86_acc_entry), idx->acc_count);
+    idx->acc = g_malloc0(idx->acc_count * sizeof(x86_acc_entry));
      x86_build_accel_table(idx, idx->acc);
-    free(tab.idx);
-    free(modfun);
-    free(modmod);
+    g_free(tab.idx);
+    g_free(modfun);
+    g_free(modmod);
      return idx;
  }

@@ -2674,7 +2676,7 @@ err:

  x86_ctx *x86_ctx_create(uint mode)
  {
-    x86_ctx *ctx = malloc(sizeof(x86_ctx));
+    x86_ctx *ctx = g_malloc(sizeof(x86_ctx));
      ctx->mode = mode;
      ctx->idx = x86_table_build(mode);
      return ctx;
@@ -2682,8 +2684,8 @@ x86_ctx *x86_ctx_create(uint mode)

  void x86_ctx_destroy(x86_ctx *ctx)
  {
-    free(ctx->idx->page_offsets);
-    free(ctx->idx->map);
-    free(ctx->idx->acc);
-    free(ctx);
+    g_free(ctx->idx->page_offsets);
+    g_free(ctx->idx->map);
+    g_free(ctx->idx->acc);
+    g_free(ctx);
  }
diff --git a/disas/x86.h b/disas/x86.h
index 3e745c2438fa..caf04db31b56 100644
--- a/disas/x86.h
+++ b/disas/x86.h
@@ -42,102 +42,6 @@ typedef ushort u16;
  typedef uint u32;
  typedef ullong u64;

-static inline uint clz_u32(uint val) {
-    return val == 0 ? 32 : __builtin_clz(val);
-}
-static inline uint clz_u64(ullong val) {
-    return val == 0 ? 64 : __builtin_clzll(val);
-}
-static inline uint ctz_u32(uint val) {
-    return val == 0 ? 32 : __builtin_ctz(val);
-}
-static inline uint ctz_u64(ullong val) {
-    return val == 0 ? 64 : __builtin_ctzll(val);
-}
-static inline uint popcnt_u32(uint val) {
-    return __builtin_popcount(val);
-}
-static inline uint popcnt_u64(ullong val) {
-    return __builtin_popcountll(val);
-}
-static inline uint ispow2_u32(uint v) {
-    return v && !(v & (v - 1));
-}
-static inline uint ispow2_u64(ullong v) {
-    return v && !(v & (v - 1));
-}
-
-#define clz_ulong clz_u64
-#define ctz_ulong ctz_u64
-#define popcnt_ulong popcnt_u64
-#define ispow2_ulong ispow2_u64
-
-/* C11 generics for clz, ctz, popcnt, ispow2 */
-#define clz(X) _Generic((X), \
-uint : clz_u32, int : clz_u32, \
-ulong : clz_ulong, long : clz_ulong, \
-ullong : clz_u64, llong : clz_u64)(X)
-#define ctz(X) _Generic((X), \
-uint : ctz_u32, int : ctz_u32, \
-ulong : ctz_ulong, long : ctz_ulong, \
-ullong : ctz_u64, llong : ctz_u64)(X)
-#define popcnt(X) _Generic((X), \
-uint : popcnt_u32, int : popcnt_u32, \
-ulong : popcnt_ulong, long : popcnt_ulong, \
-ullong : popcnt_u64, llong : popcnt_u64)(X)
-#define ispow2(X) _Generic((X), \
-uint : ispow2_u32, int : ispow2_u32, \
-ulong : ispow2_ulong, long : ispow2_ulong, \
-ullong : ispow2_u64, llong : ispow2_u64)(X)
-
-static inline uint rupgtpow2_u32(uint x) {
-    return 1ull << (32 - clz(x - 1));
-}
-static inline uint rupgepow2_u32(uint x) {
-    return 1ull << (32 - clz(x));
-}
-static inline uint rdnlepow2_u32(uint x) {
-    return 1ull << (31 - clz(x - 1));
-}
-static inline uint rdnltpow2_u32(uint x) {
-    return 1ull << (31 - clz(x));
-}
-static inline ullong rupgtpow2_u64(ullong x) {
-    return 1ull << (64 - clz(x - 1));
-}
-static inline ullong rupgepow2_u64(ullong x) {
-    return 1ull << (64 - clz(x));
-}
-static inline ullong rdnlepow2_u64(ullong x) {
-    return 1ull << (63 - clz(x - 1));
-}
-static inline ullong rdnltpow2_u64(ullong x) {
-    return 1ull << (63 - clz(x));
-}
-
-#define rupgtpow2_ulong rupgtpow2_u64
-#define rupgepow2_ulong rupgepow2_u64
-#define rdnlepow2_ulong rdnlepow2_u64
-#define rdnltpow2_ulong rdnltpow2_u64
-
-/* C11 generics for roundpow2 */
-#define rupgtpow2(X) _Generic((X), \
-uint : rupgtpow2_u32, int : rupgtpow2_u32, \
-ulong : rupgtpow2_ulong, long : rupgtpow2_ulong, \
-ullong : rupgtpow2_u64, llong : rupgtpow2_u64)(X)
-#define rupgepow2(X) _Generic((X), \
-uint : rupgepow2_u32, int : rupgepow2_u32, \
-ulong : rupgepow2_ulong, long : rupgepow2_ulong, \
-ullong : rupgepow2_u64, llong : rupgepow2_u64)(X)
-#define rdnlepow2(X) _Generic((X), \
-uint : rdnlepow2_u32, int : rdnlepow2_u32, \
-ulong : rdnlepow2_ulong, long : rdnlepow2_ulong, \
-ullong : rdnlepow2_u64, llong : rdnlepow2_u64)(X)
-#define rdnltpow2(X) _Generic((X), \
-uint : rdnltpow2_u32, int : rdnltpow2_u32, \
-ulong : rdnltpow2_ulong, long : rdnltpow2_ulong, \
-ullong : rdnltpow2_u64, llong : rdnltpow2_u64)(X)
-
  /* endian helpers */
  static inline u16 be16(u16 v)
  {


