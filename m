Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB48CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmOm-00020S-ST; Sun, 17 May 2026 21:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmOg-00020C-WE
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:03:56 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmOf-00061V-F5
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:03:54 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67c2b4809baso4214297a12.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779066232; cv=none;
 d=google.com; s=arc-20240605;
 b=lRYyNkcEpvFWyc6m66Sm/6GK7dBEDtnYGVZ63M1addxxzKla+jS8ZgqKO9+UaTT1aG
 8Bbx8kQZBUW/8BwuUDKDmOtrZyKSbJEdAn7EZZ9dEXNrogvb0nDZl7MV3AZ+JQjieIPH
 nvcRdGRV5UfVweYDMMleK6mA7U2pl7Ut1sWBVpZJfEGHcfhRWPdW4E7yeSR+E2SeAtvH
 rSjjbqGKFf/CGzooaPSkgMVA5YVaTicnQdFaHFpWF9b90hsJ81fWOBup9F8GM32JvRiL
 p9lyoV20MJZUGRwvgv5X1DogAyQ4CEMICFJbPvI+h+rq2XScI2VKn4TQO+acJewaVV0i
 EIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bkwEj7LGWYaFRv7IZVPW07Z+lQ0kxeffBEmQ94Ld6KI=;
 fh=Ofc/7yYflL5fzGU4DVTgtdXtCN7XZwZQ8r7NIaePuJA=;
 b=EI4yzyc959MUqdgoZLVADsSt2BpKi5wPb4TnnX2BCXrAbbqDEyv52I3tZIFdFmmlqQ
 dZ69D+ieO2XwagyUI9HtAfCwaI+Izs779dL7BI+b2JJepcRmI/xbxqC7SoV9IheaN+sG
 ehQCrGw2Z4LQP2W6j9mb76JxHoNgk99r2O+FTi+TxF/f1AOv25QOhAgPMCNcN1b2Qpsf
 bj4tf1RoicCj9YhsSaxKhMYZknrrvGRF+NgxWCExDIubKBrXV+OxixGD6f/kLm/ZVojP
 atCxfROlhVROk3RMxH3FgzjEaPI9s92CrdjjOJdtgeg3bJD78DIxS/WykpVMLnRIL4AE
 FIbg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779066232; x=1779671032; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bkwEj7LGWYaFRv7IZVPW07Z+lQ0kxeffBEmQ94Ld6KI=;
 b=NX5VicP3gZaiRaxgigsIyJne7CL4+1LfkIrJexcZrVM7uY6px4lVFLRSAUITzwUtRg
 xyE8gSRgk5IsD9604zoOgx1Rf3E0+B7hJwKMAKYJ/hxz2FEi8Yvcw6b8rT5Hb7jb+IJI
 9yTN3C7sI9hs2rdSLyKflhjr9kbPsiRMtF2rXMzCfYRupiaBOm1jFoSZkxeIVM0S6sYK
 Flmu5Ih2Pt6XZisIrfocQ1Nah+tS0uazWTgBibUDx72VhbjVkEbaVGGcPG7fpYYCoHek
 TZbcK8Z+Q7nbt25bwN/vHnH32rH/8WnXTtN0Ud2k4x8PKdOccng3I1tGIeVsQks8mtFn
 NWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066232; x=1779671032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bkwEj7LGWYaFRv7IZVPW07Z+lQ0kxeffBEmQ94Ld6KI=;
 b=eDw7F0sA9Veow+bt2EVoOs5itBZ9t/ZIztKPVMOFboCx8rCgwM3zTiTqt5TIQ1fOZy
 qDuMl5P5dEwhvDYkEz0bDCss2DEy62aM4R/bSX7cQxBBmDyWOuzgq6kvhZMRuO/tKF1l
 +Ok42VBAghstbJgjbeCf3xT+6KbCMEQU9gGfqtwODpT3WwSP0qEh//R4FmcZLuNONGvH
 KywdPlBR58RECnee6Xy4EPcM5CnG179wUWIUOHAyv59nDivVZL4iCUWJ+vdoPZBhjm/l
 gfJJjSsNJiyuyBUNkrAbtJhhomvpRhcbt5HviufLb94pNafnRu+bPag9Iq29+8aTDFDk
 2Txg==
X-Gm-Message-State: AOJu0YzWdiGy7gNJuQHxAdWisjcejxzMiWqwrjQphh/fC4zrFNsUrmG1
 mL6W78alx2E/j8jZId9OngOwKwpF+fqhDNGTvSOETMOiqT5N82imupefpXNIyRkVYdSot/crI5e
 earCsaFl5O/TzPVfsQLwtDoUoViE5PTvwK49p
X-Gm-Gg: Acq92OFB/usDyO6WQJvd/qjhu+xs58p9JI7ALq5PQU1glklNzybR270GSiSd0fohjz9
 UNOIbDzi8Wvt/nCVhtLoSxVi4dDY5cOvfAsyXrBM1lRndN3cAmB8YPIy8XiqD1AndNzlUV5F+ov
 cBa0H44fdO8ZH56AcN6bBQkLqiepvXxMs23rMwvNQqJfcbEYmwXOPnv5BHj7Ub/cldQvgrDJii1
 dzhkopqBAPBIvhVqjJ+II5xLny2GoVZSMz9zk92KnT6ryBEIV/C5czzH5a2ajJx9rVl1Rok5yXt
 TX4MahoSJG5w8qhWqySbbL+NTanq0Z94QEd+y0Bo+oyXm1mN
X-Received: by 2002:a17:907:c311:b0:bcb:98cf:1a82 with SMTP id
 a640c23a62f3a-bd5177c0402mr712666066b.14.1779066231554; Sun, 17 May 2026
 18:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260515180437.23620-1-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-1-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:03:25 +1000
X-Gm-Features: AVHnY4Jn7rH9609hukF_PW6PhJxrFQe7O3HiORWOmbQSj1FWN4T3QeDk0VfcsgE
Message-ID: <CAKmqyKMZWH0cBp4gNoVpM-emEb4-BEvUb5BdBAFpc+XRB3kF+Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/27] single-binary: Make riscv cpu.h target
 independent
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Sat, May 16, 2026 at 4:02=E2=80=AFAM Anton Johansson via qemu developmen=
t
<qemu-devel@nongnu.org> wrote:
>
> Hi,
>
> this is a first patchset moving towards single-binary support for riscv.
> Additional patchsets for hw/ and target/ are based on this one so it's
> best to make sure the approach taken is ok.  Most patches in this set
> concern fields in CPUArchState which are either widened (usually to
> uint64_t) or fixed to a smaller size which handles all use cases.
>
> General purpose registers and fields mapped to TCG are dealt with by
> widening the type and applying an offset to tcg_global_mem_new() to
> correctly handle 32-bit targets on big endian hosts.
>
> Quick question to correct my understanding. AFAICT riscv64-softmmu is a
> superset of riscv32-softmmu which handles 32-, 64, and 128-bit ISAs, so
> concerning single-binary do we for the time being only need to support
> riscv64-softmmu?

That's mostly right.

In an ideal world there would be no riscv32-softmmu, just a
riscv64-softmmu which could handle all bit lengths.

There are currently corner cases where riscv64-softmmu doesn't work as
well for 32-bit bit (I heard GDB debugging a 32-bit guest either
doesn't work or has problems).

But focusing on riscv64-softmmu with the goal of dropping
riscv32-softmmu in the future is fine with me

Alistair

