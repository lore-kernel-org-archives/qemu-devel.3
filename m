Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06815C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4l5-0004hy-HC; Thu, 06 Mar 2025 01:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq4kz-0004bI-BE
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:31:00 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq4kw-00053V-5z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:30:57 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22356471820so3573235ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741242652; x=1741847452;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JrVZOb+P7PkLjQT/T6qLRePIF7SkiJoQMIf+ygF468w=;
 b=N514Bwjah8CWfp3+cEXY2IIbXVUeFfBInTu2J20XTf5GontjW/QdsC/G1Mcrcx3AJ0
 af2QOLFEu8yyLL7GNw3HzbWaCgka+2XA2qaEe2D87t3ELIrtZA2Wa8C0IJWDLD9DAr4x
 rgsYmWPY2rL2fuDCdTap+Wms8GFTMm3kuAOVnHDsboaJa8MF9Mus6rtOItpjBEodQQFT
 TvhKL0UVZTQw4p40pFOPh7/V/8Lb82gXVNY1Gr3feWHTZKeAreIlU55m4rs58HYTDJOb
 0qoi4z9RQqrqfnTZdPJMW3bwIDMV/xaWOFsLbQVplsl/MeDXxzU0zgWdlyxZvTjFQc+r
 WnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741242652; x=1741847452;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JrVZOb+P7PkLjQT/T6qLRePIF7SkiJoQMIf+ygF468w=;
 b=wTK/Fo5ohmVKwPdqK35VjfsgYYdgv79RckR7eTwCB8f6+/OnrQ5sS0L4DGusz4P7lI
 PGnhvMrUaKYtS6s3468/WLqAUSRFuTH9Fct0OKyz3hy89G84crJq3ffxev7XYGdpfpJl
 JJ8+X3waQvsFOiR3MZRzMH55lGP+MlQBd3z9TZzj4GH8rnSxe+CUYNfpy2qeOnY9kMOA
 nmKJnzh5Hp84OJYVfMRZK/KwcYaHC/I8ONG6Jdojv1OfO6UM3IB/B5bfLAeIOq6t1ig6
 BLyrY1bjO3wAsAbisU2FKYrg6ioJYgb4taMKiUFoJM4am9BsMLvoQGkTpEGhanr/ymeo
 HnYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+FA/4hvGKRFhq4QJ+SqFBzgwHOC7icAb6gYZ6uO/Y3HSf3zGqIBIFNhy/JNwAbset6iA054TRIW7l@nongnu.org
X-Gm-Message-State: AOJu0YyLApcTZE6AVJ6oVEdgJkAiEjms3cJkiLYkioZAH7wyycElXpea
 pv5gDutAf17cvQEO2wrAnIJ8xgXrQRUdhGOyBSsg9WsQb0JjfVmC6VhrKrTb6cJc7aaC0oRVNFw
 R
X-Gm-Gg: ASbGncsGUS+Utl+AAibPbQckInJgiX3KU1JBM6+pfhtfOqdizvZKTUPfZ19fGbtHc7y
 UciLv1D+Dl39MQUL3qmL0xcmb4EiKVkoOo3l3aE0Q9BLaj6L/9VreD4UMwExuB2GIH68Tlb1mzw
 PjPw9l/Bv9Jhp9542QX5l716WzwK7IUOyCiESgEKMO62uKYB/6/IoUbEibcItE4xdaKMuDd1RM+
 yPb2JNcKPFPURfUVXCwK9FpUNdSNWZakUGXBRTLIp23pNwyYxf2lO4grwW693FB9ZcUHYjZhBBk
 54eCPeVP3/nweqkY6eiZGZS4i+Km7GaAX4LYf7+0kVD533FKd4TB8rk=
X-Google-Smtp-Source: AGHT+IGHC4jgMAheygVS4pd5i2///pbt+D+ZdgBNatVoIgxyazhyripBdUvLaCfuYZ6vUzW1OVjgvA==
X-Received: by 2002:a05:6a00:928a:b0:736:33fd:f57d with SMTP id
 d2e1a72fcca58-73682ca8ecdmr8199840b3a.17.1741242651868; 
 Wed, 05 Mar 2025 22:30:51 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698206c78sm547779b3a.12.2025.03.05.22.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:30:51 -0800 (PST)
Date: Wed, 5 Mar 2025 22:30:49 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Ved Shanbhogue <ved@rivosinc.com>
Subject: Re: [PATCH 2/2] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
Message-ID: <Z8lBGS1NtSrRbK1J@debug.ba.rivosinc.com>
References: <20250218025446.2452254-1-debug@rivosinc.com>
 <20250218025446.2452254-2-debug@rivosinc.com>
 <CAKmqyKMip2t-QyEvFFvnsMkXV1Wokt0dXAqpe4MAzyCHpUm--A@mail.gmail.com>
 <Z8k8/rhi/COfv/vj@debug.ba.rivosinc.com>
 <CAKmqyKNd9HRX9vWBBihVn6EFhYHXTmFpKV4iNJpcgDmteJfhjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNd9HRX9vWBBihVn6EFhYHXTmFpKV4iNJpcgDmteJfhjA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Mar 06, 2025 at 04:22:52PM +1000, Alistair Francis wrote:
>On Thu, Mar 6, 2025 at 4:13 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Thu, Mar 06, 2025 at 03:29:00PM +1000, Alistair Francis wrote:
>> >On Tue, Feb 18, 2025 at 12:57 PM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >> Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
>> >> `ssamoswap` instruction. `ssamoswap` takes the code-point from existing
>> >> reserved encoding (and not a zimop like other shadow stack instructions).
>> >> If shadow stack is not enabled (via xenvcfg.SSE), then `ssamoswap` must
>> >> result in an illegal instruction exception. However there is a slightly
>> >> modified behavior for M-mode.
>> >>
>> >> Shadow stack are not available in M-mode and all shadow stack instructions
>> >> in M-mode exhibit zimop behavior. However, `ssamoswap` can still succeed
>> >> if MPRV=1 and MPP is non-zero (see section 2.7 of zicfiss specification).
>> >> This patch corrects that behavior for `ssamoswap`.
>> >
>> >Section "22.2.3. Shadow Stack Memory Protection " of the latest priv
>> >spec [1] seems to say: "When the effective privilege mode is M, any
>> >memory access by an SSAMOSWAP.W/D
>> >instruction will result in a store/AMO access-fault exception."
>>
>> Hmm I didn't look at priv spec. Let me fix this one.
>
>I hope the two don't conflict, that will be a nightmare

No they don't conflict. Last "else" block below basically means that
it should be store/AMO access fault because there is no shadow stack page.

"""
if privilege_mode != M && menvcfg.SSE == 0
	raise illegal-instruction exception
if S-mode not implemented
	raise illegal-instruction exception
else if privilege_mode == U && senvcfg.SSE == 0
	raise illegal-instruction exception
else if privilege_mode == VS && henvcfg.SSE == 0
	raise virtual instruction exception
else if privilege_mode == VU && senvcfg.SSE == 0
	raise virtual instruction exception
else
	temp[31:0] = mem[X(rs1)]
	X(rd) = SignExtend(temp[31:0])
	mem[X(rs1)] = X(rs2)[31:0]
endif
"""
>
>Alistair
>
>>
>> >
>> >1: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-9cfaf37-2025-03-06
>> >
>> >Alistair
>> >
>> >>
>> >> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
>> >>
>> >> Reported-by: Ved Shanbhogue <ved@rivosinc.com>
>> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> >> ---
>> >>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 13 +++++++++++--
>> >>  1 file changed, 11 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
>> >> index e3ebc4977c..ec016cd70f 100644
>> >> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
>> >> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
>> >> @@ -15,6 +15,13 @@
>> >>   * You should have received a copy of the GNU General Public License along with
>> >>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>> >>   */
>> >> +
>> >> + #define REQUIRE_ZICFISS(ctx) do {       \
>> >> +    if (!ctx->cfg_ptr->ext_zicfiss) {    \
>> >> +        return false;                    \
>> >> +    }                                    \
>> >> +} while (0)
>> >> +
>> >>  static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>> >>  {
>> >>      if (!ctx->bcfi_enabled) {
>> >> @@ -77,7 +84,8 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
>> >>  static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>> >>  {
>> >>      REQUIRE_A_OR_ZAAMO(ctx);
>> >> -    if (!ctx->bcfi_enabled) {
>> >> +    REQUIRE_ZICFISS(ctx);
>> >> +    if ((ctx->priv != PRV_M) && !ctx->bcfi_enabled) {
>> >>          return false;
>> >>      }
>> >>
>> >> @@ -97,7 +105,8 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
>> >>  {
>> >>      REQUIRE_64BIT(ctx);
>> >>      REQUIRE_A_OR_ZAAMO(ctx);
>> >> -    if (!ctx->bcfi_enabled) {
>> >> +    REQUIRE_ZICFISS(ctx);
>> >> +    if ((ctx->priv != PRV_M) && !ctx->bcfi_enabled) {
>> >>          return false;
>> >>      }
>> >>
>> >> --
>> >> 2.34.1
>> >>
>> >>

