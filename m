Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCDCC282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqN5Z-0006ix-Rz; Thu, 06 Mar 2025 21:05:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tqN5V-0006i8-QP; Thu, 06 Mar 2025 21:05:22 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tqN5T-0006vD-26; Thu, 06 Mar 2025 21:05:20 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86d3805a551so483943241.3; 
 Thu, 06 Mar 2025 18:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741313115; x=1741917915; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9ITJx13kNMIqYZjjXQ+4FwbeWPJ58U+jFQbaQmMDBE=;
 b=EYD3lR3T5zYeYZu5ZU3cvNKk8K/FZ/9/p2H01H9uuZc2QIU/io37Un3J3ipnuLaGFt
 lxK4Su/P4/D2z8leH/g6a9ry1/nsqmxyuKnicWxQiMMPWr/aBHWS4hfiNEjqaf1eSx9g
 HxZt+BKxJpIEMEIvyYVOdvdciDuWBVxit1w5KbbEBk3kKBpck8vupgwUUV263qnF9lO0
 kLdRbSXzA/86hUi/4pTSWMaqORZQby/wzcySbUjV77QKzybyllBnQ93t6zZCGCfusenh
 xwA7fouGSNIi9G413WzI105hM7p4Mn3pJLSBwy1bS1nPDZYEDWLgMmOCQXNIt3KFNUs+
 FB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741313115; x=1741917915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9ITJx13kNMIqYZjjXQ+4FwbeWPJ58U+jFQbaQmMDBE=;
 b=wAbfU/eEG5Xv7rG/DwtXLpB/4CMOhtPUExjcsMoU2K7yza98yFMbQccMif2H3PdJeV
 D2+n7B99ggsrCfwmCS8f+8s4Ad60Nfmg7BfzNm92lsN8hb1tEaiirv/q49RrpFc5sARi
 FIPfyHsiooFVIlAlgRkMPUqHvoIj0uIdsMmfZ077JOVJ5VctXr2cL9w0qVtt3GTupTbM
 xoArBAIGgyeMYryTvQMWB7A+dtYbVH0R9T5Rp0ZN4WqoF7TKCYCSi7EsfDOZ2UssGWGh
 kOUjXe1IHhzvSZxa4q+4QNPLH6eTUTEmfDsYy1AuSZB9kZ8VQpkP0OltRAUk+e4Ho3Es
 taMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIH5+6sR1dQCaHh09/Aggvf8+0WnPUYJrCl9QqAYZkVYgdDE+BYoJxiEaQBeU2eyEgrSV7M9TZzvZw@nongnu.org
X-Gm-Message-State: AOJu0YzVMqbymnQo6GCqMXlJYFON9QEjMZrXltsL4JBJF6sltX97qHCD
 QZITo8RIY656r+DKap8JEXvbr5Zj/SPuKgLSUO9SzibCy8E+23gCUN9iLzyGaKDte960ZhAF3Hw
 7Hny41PaKTBeNY97N40QLBsax/BE=
X-Gm-Gg: ASbGncsfogfqxkagPkGgvE+Pr8iPWzJJIyzr50A0oQrN7aJQz4ADxXCUAFQVF2794UW
 TA3r7z9szUUcknmCg4a2PBzYc+mpg4VEBrTJFXCmG9pEdTl1LpPZOvljpv83wJ6HbK7L18R7I82
 kN/CrNBiSA2XoImRt1IpJGNLcHunQ93lzXUPt5boQiijbPqiDxNC7gtiLT
X-Google-Smtp-Source: AGHT+IG00xtOVrQNZQyFj3/9+QCtlHz9A1CtBx78XzMsfoSKs4fTngJHFgeGryeOoU/Dvb4QFoMvae0JwNe8edm7csk=
X-Received: by 2002:a05:6102:41a8:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4c30a6ad03amr1124505137.19.1741313114754; Thu, 06 Mar 2025
 18:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20250306064636.452396-1-debug@rivosinc.com>
 <20250306064636.452396-2-debug@rivosinc.com>
In-Reply-To: <20250306064636.452396-2-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Mar 2025 12:04:48 +1000
X-Gm-Features: AQ5f1Jo_KDgc44UU25IKVNuatd6Yj2ELWeCNmvcAnK672xM15DLzrYS5Ynf6Sys
Message-ID: <CAKmqyKOHrYSMVNUo9B6fcG7921eMeuioXw0KK8rD=NS8HEqbTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Ved Shanbhogue <ved@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Mar 6, 2025 at 4:47=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
> `ssamoswap` instruction. `ssamoswap` takes the code-point from existing
> reserved encoding (and not a zimop like other shadow stack instructions).
> If shadow stack is not enabled (via xenvcfg.SSE) and effective priv is
> less than M then `ssamoswap` must result in an illegal instruction
> exception. However if effective priv is M, then `ssamoswap` results in
> store/AMO access fault. See Section "22.2.3. Shadow Stack Memory
> Protection" of priv spec.
>
> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
>
> Reported-by: Ved Shanbhogue <ved@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Please use a cover letter for a multi-patch series in the future

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index e3ebc4977c..b0096adcd0 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -15,6 +15,13 @@
>   * You should have received a copy of the GNU General Public License alo=
ng with
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> +
> +#define REQUIRE_ZICFISS(ctx) do {        \
> +    if (!ctx->cfg_ptr->ext_zicfiss) {    \
> +        return false;                    \
> +    }                                    \
> +} while (0)
> +
>  static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>  {
>      if (!ctx->bcfi_enabled) {
> @@ -77,6 +84,11 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *=
a)
>  static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    REQUIRE_ZICFISS(ctx);
> +    if (ctx->priv =3D=3D PRV_M) {
> +        generate_exception(ctx, RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
> +    }
> +
>      if (!ctx->bcfi_enabled) {
>          return false;
>      }
> @@ -97,6 +109,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_=
amoswap_w *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    REQUIRE_ZICFISS(ctx);
> +    if (ctx->priv =3D=3D PRV_M) {
> +        generate_exception(ctx, RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
> +    }
> +
>      if (!ctx->bcfi_enabled) {
>          return false;
>      }
> --
> 2.34.1
>
>

