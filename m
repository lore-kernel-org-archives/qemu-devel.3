Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D91C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5e2P-0005kN-CN; Sun, 13 Sep 2026 02:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1x5e2N-0005kD-DB
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:50:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1x5e2L-00057N-Fj
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:50:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49e6deb520eso12202465e9.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 23:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789282199; x=1789886999; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aQfiew/xe64pxVRlVtC568YeDKAVba0iT4Vw/mUgiNs=;
 b=QKTe7NTTFZNEkGqxj/Ldd2TIxhPeDpDMV3vgS7p5eyTj0IUpI/0jelE8rc8HItFhqg
 kVtpsAXytjm1trKtm4N+DeF/b+nrsY7z7XazWo80pOeluqqf3BZiX1DpgGze0zUgw3KN
 A8CQbbvy7ZfwV95dOvX9cF6OGjBrRoVVjuE5woT3YH2sBVvm25TZecJZwMB22bLEk/d/
 dud7+YWtvS6K4+UXSS/4+4VieTxdAWsAwkmFTXxL4MZxDs4YeXLp7Tl9RmqSQKfgmXDV
 f8OK+cHkpwZk3OYA6ruyXVEu26+QbguyEKa1W06AG3dFeQg06f+fPZyCw0QLrgbLTC2I
 usIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789282199; x=1789886999;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aQfiew/xe64pxVRlVtC568YeDKAVba0iT4Vw/mUgiNs=;
 b=PlsKG8RiVcjtIzHBj4IzdSO5x9311zWjmWdYoV+hyBNDuQBYmLcAUD0KQC6XToEdtN
 l9hk+Ru2RSU1do3ncNl53r16jzA90DZiAvK+EyOyfVYG8pt00c7AglRN8c/yaPQQpfAr
 izMaWp1ZZd02biPPNPrkOV3JmtZ3qftpinSBT/JfmY3CgZBKlU9XFaVO84/jOQi54LaE
 CMNT3nP1mxz0MoaRixBF180DkUJuIeeyA7YKKkNvY8UEgLvUhX2El3gkFt7XQYGWx1xq
 vi9327V1/Giuj+N0Ho8llhLnCz0HgZKq3CYiIS+7sDZIP57X2QgENVaUvYpq/Owkazt7
 An7Q==
X-Gm-Message-State: AFuF++l3wB4KIBSntoTG0eR6Fmp2DLCqYq7jrd7p0i9Z03gE5xL2kfAd
 hTgeS25NObrzBdijUClcrvTiodnslaZzpg+pGQ0R5CJ/hBpWBO460jQ3
X-Gm-Gg: AYBFou2XljzgX1HBTDpw/p4AcFPP4eVpX34cjkA6ot/3WZXa68qQQH2lYmRBENV2Ijf
 xnhD8KIxSLto7PQP3pC+IdsvUoVhjz/Kz5AETytIyyK4mJ+IRKBgtEypFhF7Rl6d5KuJmKUilyw
 Z+T1HiXR0FVod52VjZEh1XqQCCl4yOWCjuH8MH/vtsFFnKVjg//ivcT9lrOixrC+jkBTYzCNDPr
 oUSKosxK7PIf5pHsp3S4QkHAs7wHMNvivOYv9cMXcpa7vorc1wEFxT8GGQEjws6/UyxYOTEtu3N
 KUQqE/STGyD1Dh4sustgv8bpTMEgRBQgDtkxUSca0yISO/my+hyvGyadJ/ljeQa42DoqDXTfgLF
 MqnNH+LSkf8e0X+ix+5Gb5E9uJgH54XvnYaYzoVhMFC1VVCulTnwBaSVN5P4o2wIJpo5GFNe8FW
 Hg0PgpwwsvuMa0EddYQkksoeK01fbYeBp7XNd24jjzFSGssKJPm/a0aieIbhqGhG/oJy/8ijmQu
 QSTTukvXKwQBxiRlyAnYwTGnH3uCcq2CfezcPZK7YlG81I0q+05zkxE8x7NKa7O
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id
 5b1f17b1804b1-49e6198865dmr149806905e9.8.1789282199002; 
 Sat, 12 Sep 2026 23:49:59 -0700 (PDT)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaee4sm318274605e9.14.2026.09.12.23.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 23:49:58 -0700 (PDT)
Date: Sun, 13 Sep 2026 07:49:57 +0100
From: Stafford Horne <shorne@gmail.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/or1k: Implement l.extws and l.extwz
Message-ID: <aqZHlXKjDM10jxm7@antec>
References: <20260829083010.2424941-1-ali@iusegentoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260829083010.2424941-1-ali@iusegentoo.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x330.google.com
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

Hello Ali,

On Sat, Aug 29, 2026 at 08:29:48AM +0000, Ali Ahmet Memis wrote:
> From: Ali Ahmet Memiş <ali@iusegentoo.com>
> 
> l.extws and l.extwz belong to the ORBIS32 instruction set, but the
> decoder has no entries for them, so they raise an illegal instruction
> exception on every CPU model.
> 
> On a 32-bit implementation both are register moves: there is nothing
> above bit 31 to extend into. Implement them as such.
> 
> Found while writing an OpenRISC port of Valgrind.
> 
> Signed-off-by: Ali Ahmet Memiş <ali@iusegentoo.com>

Thanks, I will queue this.

-Stafford

> ---
>  target/or1k/disas.c      |  2 ++
>  target/or1k/insns.decode |  2 ++
>  target/or1k/translate.c  | 14 ++++++++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/target/or1k/disas.c b/target/or1k/disas.c
> index dc025bd64d..0a46d68d30 100644
> --- a/target/or1k/disas.c
> +++ b/target/or1k/disas.c
> @@ -71,6 +71,8 @@ INSN(exths,  "r%d, r%d", a->d, a->a)
>  INSN(extbs,  "r%d, r%d", a->d, a->a)
>  INSN(exthz,  "r%d, r%d", a->d, a->a)
>  INSN(extbz,  "r%d, r%d", a->d, a->a)
> +INSN(extws,  "r%d, r%d", a->d, a->a)
> +INSN(extwz,  "r%d, r%d", a->d, a->a)
>  INSN(cmov,   "r%d, r%d, r%d", a->d, a->a, a->b)
>  INSN(ff1,    "r%d, r%d", a->d, a->a)
>  INSN(fl1,    "r%d, r%d", a->d, a->a)
> diff --git a/target/or1k/insns.decode b/target/or1k/insns.decode
> index 0d6f7c29f8..cbf8af7f8b 100644
> --- a/target/or1k/insns.decode
> +++ b/target/or1k/insns.decode
> @@ -112,6 +112,8 @@ l_exths         111000 d:5 a:5 ----- - 0000 -- 1100
>  l_extbs         111000 d:5 a:5 ----- - 0001 -- 1100
>  l_exthz         111000 d:5 a:5 ----- - 0010 -- 1100
>  l_extbz         111000 d:5 a:5 ----- - 0011 -- 1100
> +l_extws         111000 d:5 a:5 ----- - 0000 -- 1101
> +l_extwz         111000 d:5 a:5 ----- - 0001 -- 1101
>  
>  l_add           111000 d:5 a:5 b:5   - 00 ---- 0000
>  l_addc          111000 d:5 a:5 b:5   - 00 ---- 0001
> diff --git a/target/or1k/translate.c b/target/or1k/translate.c
> index eb4485312f..e00ef45b9b 100644
> --- a/target/or1k/translate.c
> +++ b/target/or1k/translate.c
> @@ -502,6 +502,20 @@ static bool trans_l_extbz(DisasContext *dc, arg_da *a)
>      return true;
>  }
>  
> +static bool trans_l_extws(DisasContext *dc, arg_da *a)
> +{
> +    check_r0_write(dc, a->d);
> +    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
> +    return true;
> +}
> +
> +static bool trans_l_extwz(DisasContext *dc, arg_da *a)
> +{
> +    check_r0_write(dc, a->d);
> +    tcg_gen_mov_i32(cpu_R(dc, a->d), cpu_R(dc, a->a));
> +    return true;
> +}
> +
>  static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
>  {
>      check_r0_write(dc, a->d);
> -- 
> 2.55.0
> 

