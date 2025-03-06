Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233DDC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4U3-0000d9-Tv; Thu, 06 Mar 2025 01:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq4U0-0000Pz-0W
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:13:24 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1tq4Tx-00034R-P3
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:13:23 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22334203781so30510995ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741241600; x=1741846400;
 darn=nongnu.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6ZbxLqlcWUIFf2tYl4TJD94i7m8THgCcYvH7iy2xssU=;
 b=YOgAGA4ZbsnPHtmzDz1SnWLs0mZHymRXwaTyuhw1Z/PdN8UodEtnudpfH6+4APmG/Y
 QFqOPMslVPzS007aUK+ZCtMsyKjY5zn56bGJvnqSwNy85k7E5DPOHTy3DyngFxnM1oZy
 F7r//GTz47jlTa/JhnG1+WmS8h2GkSLaVg6knE7Q45cZocvCsL2bie9cHelFwYizGjFH
 8fsGLdmDf//OsdCCtK2raidrLZRtVSfqoSOQOGXqStmZyt/udc+XsMZaCXN3Z1ChjMv3
 HZ8GH6ld4CFkvTm53kRcefYx1YFnAOtqvuoD4Tj+dz2gzPuhUzTxsdsCYXQyF1sSPWVi
 8r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741241600; x=1741846400;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6ZbxLqlcWUIFf2tYl4TJD94i7m8THgCcYvH7iy2xssU=;
 b=v0StBmNvyP717jYWPqxDLe0/XZlpM6X9Se/PhiC0iFFA4NYNKLOQIef24MVCmU+UPo
 XGJ439U4DDoxQa/Tco+niQTAcMzh9mvzO/vMWuhs56VBOqkxL5rQl27doTUzHLLYlYbT
 YorGvpwP8EB11UQNEssVLeMBKAotpsM4edm0F75QW+9LlDg5eCsrM3nneHujZdrKVqPS
 iXbsU/q+OeNWwVsSoU00ZzPq2cZsKymckVHnnnqjPTAI/Cg89TXgFjRl7pm0aPSZKDR7
 iRvCwUOEvt8EY7NXMFR/DLEOTEvbRAB28SooGF9asInSkjRIcGxcskLMEWcv9LjSDUYV
 y22Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPQhJxg3XVHz/huJYnYRLPcMPovLaSUyHsKPGUdE+hOYvjA2CtoTj4Q30uKjoiDGvjxD4YdhGUci8s@nongnu.org
X-Gm-Message-State: AOJu0YxG2/tCitTjIfNvr0K04cGRT2+yMIKzXZPqqe79sNMXV9MpV7Tu
 gzyHH7fz/4g+dxKOrQr8wpjNhXZDdPDjVAPm9rjt/ualGCYsq8EZVfkOo4TZpPA=
X-Gm-Gg: ASbGncsh8koueES8v2kOHmKnhl8dvqAzlLv4Wqs1wO0x/2lz36ePeY0QDK51vr5EP9/
 I/WzHH22cv4rpxdnzMrwB0Wjb7Ffbq/cFVO4K87MxOxmkaou42QMX8VEomT6qy28ls9r0XbX567
 cFZxIza0XE6VZz8fK4GI6Xit+JWofjyeYh38cMoWKhntweKAaCzQX13c6sJ4+sbYQmvNDnAwv71
 CMOeSF133TbSPjh0qKPSCHbtSBo6GUZw1jiXgY5faWa5qbq0C4iG0qhOUNVLUxyyqlcttzztwBc
 Oor8dZAVtSUGipJKMsQpBgxXqYV2RwUnwS1UMLQshCFN3XbqmeeT7/E=
X-Google-Smtp-Source: AGHT+IHr8icnw0l/4ztfvjx0FTHERXeeIfSiXHdq0rb7TdJEUsDtWTK7w1OG3VVY6W64ND7z/+1igA==
X-Received: by 2002:a05:6a00:2e21:b0:736:8a00:cb6d with SMTP id
 d2e1a72fcca58-73693fabb91mr3493724b3a.11.1741241600194; 
 Wed, 05 Mar 2025 22:13:20 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736984f8666sm479898b3a.113.2025.03.05.22.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:13:19 -0800 (PST)
Date: Wed, 5 Mar 2025 22:13:18 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Ved Shanbhogue <ved@rivosinc.com>
Subject: Re: [PATCH 2/2] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
Message-ID: <Z8k8/rhi/COfv/vj@debug.ba.rivosinc.com>
References: <20250218025446.2452254-1-debug@rivosinc.com>
 <20250218025446.2452254-2-debug@rivosinc.com>
 <CAKmqyKMip2t-QyEvFFvnsMkXV1Wokt0dXAqpe4MAzyCHpUm--A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMip2t-QyEvFFvnsMkXV1Wokt0dXAqpe4MAzyCHpUm--A@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 06, 2025 at 03:29:00PM +1000, Alistair Francis wrote:
>On Tue, Feb 18, 2025 at 12:57 PM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
>> `ssamoswap` instruction. `ssamoswap` takes the code-point from existing
>> reserved encoding (and not a zimop like other shadow stack instructions).
>> If shadow stack is not enabled (via xenvcfg.SSE), then `ssamoswap` must
>> result in an illegal instruction exception. However there is a slightly
>> modified behavior for M-mode.
>>
>> Shadow stack are not available in M-mode and all shadow stack instructions
>> in M-mode exhibit zimop behavior. However, `ssamoswap` can still succeed
>> if MPRV=1 and MPP is non-zero (see section 2.7 of zicfiss specification).
>> This patch corrects that behavior for `ssamoswap`.
>
>Section "22.2.3. Shadow Stack Memory Protection " of the latest priv
>spec [1] seems to say: "When the effective privilege mode is M, any
>memory access by an SSAMOSWAP.W/D
>instruction will result in a store/AMO access-fault exception."

Hmm I didn't look at priv spec. Let me fix this one.

>
>1: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-9cfaf37-2025-03-06
>
>Alistair
>
>>
>> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
>>
>> Reported-by: Ved Shanbhogue <ved@rivosinc.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
>> index e3ebc4977c..ec016cd70f 100644
>> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
>> @@ -15,6 +15,13 @@
>>   * You should have received a copy of the GNU General Public License along with
>>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>>   */
>> +
>> + #define REQUIRE_ZICFISS(ctx) do {       \
>> +    if (!ctx->cfg_ptr->ext_zicfiss) {    \
>> +        return false;                    \
>> +    }                                    \
>> +} while (0)
>> +
>>  static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>>  {
>>      if (!ctx->bcfi_enabled) {
>> @@ -77,7 +84,8 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
>>  static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>>  {
>>      REQUIRE_A_OR_ZAAMO(ctx);
>> -    if (!ctx->bcfi_enabled) {
>> +    REQUIRE_ZICFISS(ctx);
>> +    if ((ctx->priv != PRV_M) && !ctx->bcfi_enabled) {
>>          return false;
>>      }
>>
>> @@ -97,7 +105,8 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
>>  {
>>      REQUIRE_64BIT(ctx);
>>      REQUIRE_A_OR_ZAAMO(ctx);
>> -    if (!ctx->bcfi_enabled) {
>> +    REQUIRE_ZICFISS(ctx);
>> +    if ((ctx->priv != PRV_M) && !ctx->bcfi_enabled) {
>>          return false;
>>      }
>>
>> --
>> 2.34.1
>>
>>

