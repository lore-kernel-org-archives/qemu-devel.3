Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F93AC61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 06:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1I61-0000TW-Pm; Tue, 01 Sep 2026 02:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1I60-0000Sw-6a
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:35:48 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1x1I5x-0007oY-BJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 02:35:47 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-864cd11a932so7981407b3.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 23:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788244544; cv=none;
 d=google.com; s=arc-20260327;
 b=YrScKBER7J4JKoO4zZaSMNTe/F9GT2uLFFR/4+rJv1SnSFoO3i7p4vySDtbasWLh4b
 EALxE7KU8BpZb2Cji7nD8KOxW3Sv4KZzdk03CICuanMWnYrsZJXvxcS/P6TqMetwjVF2
 glgMDJ+p8CCJkUjiBHg60vJ6pHykl6ks6L2scP2PMi5p682pBZ+ragxEn25xEepG5aeG
 sPj18CcGTUUE29hNOloX6vCLRGdRQq0Jm8LRnYT9AXDxAe5LahFtWZ1ubIwfS5OByCa7
 oia81/rE3AqTtmwdrQZBmWGmGpsEw8DZMho4yrEwI8g5sLIXvz9AtHxNdJj97XZSiqbg
 tOsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e6e5XAw+jSpn8T0cpU8hyi77lDq561nw/gbdHPWoBj0=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=jhB38ZtUZfUlyGpzJWepYMjZF20KDIhBBaGVEoYn/CXZZhrRFdCSdgrS/UbmoQGpMm
 JKSezC3JjXsJY/4anYQ6IWrsoY9cQFydp2vaq4yoHYm8JrYl3kPZPXiz6adtdXjRGpbx
 VpAvaKQVT6G/6BYaml0mrnUf5PPM9mC5mbnfSHFGKRguVMpkOZq7B2gfMgz68nHRR+7g
 eflRcpbq1fLDOUIPft+88dpsG0eqWNkzrFsLw7OhKZeVTudJNIqEIiyPy+2mSh9wQXdg
 8i7q/liw71QKBsA3XsxdcKJTdC+qYUGCYGKOT/FgNdJUlXYjjt6d5wq9esYaB+0DWPmF
 xq7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788244544; x=1788849344; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e6e5XAw+jSpn8T0cpU8hyi77lDq561nw/gbdHPWoBj0=;
 b=guvTWbrF153K6HASZhzCIkE8Xiy2mqjmbqLHGnE+lOXf8WavflBp9MOCdFU3DRmcKh
 wKMZ2E2TTyheAXxNGjOFk/w27Cf2IXpb7QWqtKRnSb0515c+VkfQK5rWV/wVZZSHC1HS
 ZkL+16/ir6nTYFau1nwdD8a49z25CrxAondY2SlLTmnbfGAxusMt7+i5JVFuORhHBSKI
 Llg8NXBk/EHcdOvmFUcjIjNBv36QVFrDpF188NFTm6csRjhB1nO4FdcL7L0xmAs/gX8I
 Y7CsDmm+Sl2plGxG6gqvSXSxkNFz4ZQRzP91HE8k4IrhJJIceBSLz7aCvmp7gAXyZYwv
 Yw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788244544; x=1788849344;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6e5XAw+jSpn8T0cpU8hyi77lDq561nw/gbdHPWoBj0=;
 b=gh/y56cmH/MpxQvTQ6CBj6moLfsK0nMwFxr0Vn74wez3+4yl+nYnwSH5l5vhUOCWzy
 mPmAJIBb9ehpiFK5G45t49qxnrfKd7S8Md87GzmeoaOdZI55xOgZ4bBir49QjKXw9tB9
 P4ay8uHx7OZZozMgYB4BMzzjfm/HTknb3lctDvkd60SNupLf/7UQCddd56s46J8FwN+7
 /gPy+IFqfw1Mu4gmQltMpDSi3nMuwhKW/fwyf2p70eFEB3zYn2BoDkW2zpmd8LCue6Fd
 eOShw0JbY3vIn4PYYTPk54aT8MxsTejaYZhMhSIqC8pLX4jGVTSNRvfB/e6cXFNcK8Sn
 CFOw==
X-Gm-Message-State: AFuF++ktZIvP7yXBrnjKwpc8AN7N7u250Toaa/flFINbZ+Caj+af6bJl
 mUK8bsIHht2v2wvOCDSnbpQ0qi7mg50O/VOFL/QzkcF4pLXAUc+DTF3Ucyjow2tTRxOhWwfs8dQ
 NyVC3gXbdoD29Leu9f6s2RCX5eKvA4AFdlmaABQk=
X-Gm-Gg: AYBFou1Er0YEuCFP6x/qM9biK3UZzOcqD1H+0VqClBr1vrRSk/Itx8ACYtklqIjHaKv
 y7Vhxtdrl1VoPdwpREKc39/Kbh/KWwXVsX22ZvLuAVcVLthQjthJzLwbmNHUffjGlMHqMosLp3i
 su6Z0q/zUeAfk29MfFBGtCTGi4Gg/19aQ0czTzaKWW7z+JM0fDhQGPfnWkoLPtvJEXHBETqomth
 kw96AN5BciaN+T2Z3mN1Y3Q2cT3ezYq7BUaJ/DoTi3yDQEwDQxx7Nv/mk9n4yH8cbP+1pF93Yfb
 L4eIr9160+PpxTVrq2+8tSQKFKChFIe7coYYZ+AJkBKM8sN9nRJOE4BOvrBpBNRNlBjv2ChQNTk
 YcmnEeaIrkNFKXmUiHsAynL+PjZV/DrQ=
X-Received: by 2002:a05:690e:1385:b0:66c:bafa:b7b2 with SMTP id
 956f58d0204a3-66f8a577744mr1097876d50.21.1788244544051; Mon, 31 Aug 2026
 23:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260813052532.22833-1-scherer.simon89@gmail.com>
In-Reply-To: <20260813052532.22833-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Tue, 1 Sep 2026 08:35:32 +0200
X-Gm-Features: AcwNN1WErXSHoYSYMD7mY1ajek2wVfF_lh1Z2kOJbXOl3cJWwFdt5n8D_SCWS1c
Message-ID: <CAEQwQtJLPYtPvhQBQqjphF+VaaqBD6x-s0a_xm4Y3gVH1TefZg@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Set aliased x87 exponent bits to all 1s
 for MMX register writes
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yw1-x112c.google.com
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

Ping. Maybe the patch has been missed.

On Thu, Aug 13, 2026 at 7:25=E2=80=AFAM Simon Scherer <scherer.simon89@gmai=
l.com> wrote:
>
> Per the Intel SDM (Vol 3, 15.2), writing an MMX register also sets bits
> 64-79 of the aliased x87 register to all 1s. gen_writeback() never
> does this for X86_OP_MMX destinations, so those bits keep whatever
> the x87 side left there (e.g. 0 after finit/fldz). A later x87
> instruction such as fucomi/fucomip can then read a stale finite
> value where real hardware guarantees a NaN encoding, changing
> comparison results and flags.
>
> Set the high 16 bits to 0xffff when writing back to a MMX register (not
> memory).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4105
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: use offsetof(CPUX86State, fpregs[op->n].d.high) directly instead of
>     reusing MMX_OFFSET() + offsetof(floatx80, high), per Richard's review=
.
>
>  target/i386/tcg/emit.c.inc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 473f415766..2c36e41303 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -352,6 +352,10 @@ static void gen_writeback(DisasContext *s, X86Decode=
dInsn *decode, int opn, TCGv
>          }
>          break;
>      case X86_OP_MMX:
> +        if (!op->has_ea) {
> +            tcg_gen_st16_i32(tcg_constant_i32(0xffff), tcg_env,
> +                             offsetof(CPUX86State, fpregs[op->n].d.high)=
);
> +        }
>          break;
>      case X86_OP_SSE:
>          if (!op->has_ea && (s->prefix & PREFIX_VEX) && op->ot <=3D MO_12=
8) {
> --
> 2.53.0
>

