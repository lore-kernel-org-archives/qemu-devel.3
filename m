Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38331C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljah-0007og-6o; Mon, 20 Jul 2026 04:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljaf-0007ne-SU
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:43:09 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljae-0003YC-2r
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:43:09 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-81ef11a0972so31748297b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536986; cv=none;
 d=google.com; s=arc-20260327;
 b=FjNsRwskc/CXCvkcuaN5Amthnjkpo3N/RUczhHraWhiF5H3BzydnsRW1mOBxXhJWbk
 NcFCbCH4e22F/WBdTEIGISJZ+9iEFjKSDBaGkPDqVe/+wUtPOu7IsuB6v+cwNYyebOxt
 kK0O6nAnp4fgg3udlY/dG+xeDgDniOz+Y7Nt4xuPh8KZawmecq9pmZ9L6O3M5aLz5Sis
 rekmnxr0ayBY89A3k/xCTO6RVuGj39VbnhVexoWyTlo/Oaot3PF6qoj8WX/iRMkygVq7
 D/7USZWCkvjtm1PNUcw4y86T+d26O8AMsiI2qsvaRwoKiggujWFCLuJtU9GtLvQWMu9l
 wkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4i05izum7cedEY4QengWa6slIiGpeACSEo2m454+20w=;
 fh=mVArEPsypA/bvqhGlg7JkTr9flwi5BnMwi4Vd02ZVR4=;
 b=VQYTDzooI6mQbP9m5DBNKR2ehGQAL7i8YnMRdlfuOQF/hLlw1WLylllq22xDktl2Cy
 ueOWZ5lKOAEcvFo9u5gJPHcESYTVn14uIEfijJvRqj0lZi0kSzELWRDqLCOzC0ZfbT7+
 K33kSvmZpch12l+9CydIAso5hNp1dyYAp5pSn4Ubhd0Z7KFpAB09xA9pp966bjeewT9+
 kwyZRFJCOlWXFlarjcODxAOAwRNq+LDXnMelXl805zR+m2O0Qkj3LXGjhvZ1fpMH2YY1
 jMXySrTjZoh0TJrhJPKuUj0uqm5tlbIv8nbT1EJoh3bI3A2NpM1rF3lR6GAqvPUE3D2B
 HREg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784536986; x=1785141786; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4i05izum7cedEY4QengWa6slIiGpeACSEo2m454+20w=;
 b=LgUwJZFQVH1djfdw2pBzx7XDjJIzEXHDxeCP5AqLEXcZ4AEIkWYjoZ62MbFfcs8wKV
 U4iZHr8J0zvnS0yuxcSNfwF4J+Ezb+ewokOMpXcgiNWI1K625BZYqy5xRgLTBPa4NuKl
 vUR66CrhLbVAtxZAs4CLhTtIKeDx0EjtqvqQGPYby2mXSQGVaEdOjuao5ikFeZqPxzVJ
 GMe9PwkpPEYig0qsjNUXuT8KlxvneN1PN8OKOFEdDFoNMqc5gSpQHJOKjx1+tWQhQ25m
 7Z72D4krRaSCOe/DxHCGabeQNlIH8hmh1frCrqgpTZXHBL0IWAb1ETdMHhhSqMcg7KAi
 6i2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536986; x=1785141786;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4i05izum7cedEY4QengWa6slIiGpeACSEo2m454+20w=;
 b=HOog47TNLEjyq/vgyGOpiAMJQj2r8iEdlE/i8QehmfaBFKzFRsTN0BVmu2XXWDeeAC
 yS21rp0kvs7b4tvaHwXSyPL2p8gZHQMEDL/X+oNvnLwLN5LlzsObcti3kxJG3wTNeKgq
 kdIHQAQGknh0iWFtZzvmeeoA4NNSp/cMXdNYRhLz/g0e7syvPnS+K+jU1BzpK5/pU1RN
 czpkvlPPOFiGWT3ifEWIfjZNGNc4NjI7xtMH1IW0Ge/YFIngtGhQMBPqM7Qp3Qe5+i/t
 d3VFwsihEgWaNKbHSakGgUHk4P83w/a6B9q8QmbpKyCrGuhsJJUL7bw9aIwuiSSZeaNd
 VYwA==
X-Gm-Message-State: AOJu0Yx4N7lHXZu+sDL953A7l437TAvKAMC5xytXCUtd2uR9UbIRF04K
 2fjA2VYt1ek0Vnp4GbnSBw3dra1gMqMLppyQmZNNs5aEiIQCyKou5L14xP2J8YLrmF3TprxhTYI
 DhQ9eTwsEb5I7NeyASmYGHAm1pkznl+G6duOyy6B6oN+dXsqULnHj
X-Gm-Gg: AR+sD12ts40MXwtiXxSu2T9LWx123Q+k1ybVYoNAvEBn77KHFeaTRPL6WOH3MKm3E/y
 ituqv5TaFK7klX1tdpdxUsYtDz6B40YPB9VAHAczNXY1sYH5/sKrjux+4OLnssquRoQ48LDCnBi
 pZFRgd4I/0dvoFjPOsmifeS6ML8ip19BX9LNWUCZqt8QSQzVna2ln3jNQApNruHbbGEUUv8zV5e
 L3MdQanhTanAP/IQGoLF8ymosCJ9CzSciTNHrfwCEHjpFALdQd7TcOXfzd9RQ8tBYvTxQIiymW6
 zVnJ6MY+JOUN9cUkz5nxi+VTADepyRTyktQtgB6TMKU+Bw==
X-Received: by 2002:a05:690c:6c01:b0:81e:ba6b:a099 with SMTP id
 00721157ae682-81ef262b90amr42633767b3.60.1784536986347; Mon, 20 Jul 2026
 01:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260630104249.2533126-1-peter.maydell@linaro.org>
In-Reply-To: <20260630104249.2533126-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:42:54 +0100
X-Gm-Features: AUfX_mwCVwwremnfq-nXvgrXkQfbfhJNHU-ecgGmjQH0sXnwzw7hwQ5hFfjV-oE
Message-ID: <CAFEAcA8J6-QbqAT-=kfEx2mAvkMucGJiyWC0_zMmVeSrmQw9Jw@mail.gmail.com>
Subject: Re: [PATCH] hw/ide: Don't divide by zero if guest specifies 0 sectors
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping -- would anybody on the qemu-block side like to review this?

thanks
-- PMM

On Tue, 30 Jun 2026 at 11:42, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In ide_set_sector() if we're using CHS addressing the way we update
> the drive state involves dividing by (s->heads * s->sectors).  These
> values can be set by the guest using the INITIALIZE DRIVE PARAMETERS
> command, which means that s->sectors can be 0.  (s->heads can't be 0
> because the command passes a heads-1 value.) INITIALIZE DRIVE
> PARAMETERS is specified to not check the input values for validity;
> instead no error is posted until some other command makes an illegal
> access. So we have to cope with a 0 divisor here.
>
> Special-case s->sectors being zero.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2399
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We don't seem to ever actually check that the guest's read/write ops
> are within the CHS limits it sets with INITIALIZE DRIVE PARAMETERS --
> ide_sect_range_ok() only checks against the underlying block device
> geometry.  Maybe we should?  Then a zero-sectors misconfig would
> result in our reporting the error on the read/write as the spec
> suggests we should.  This patch fixes the division-by-zero, at least,
> though.
> ---
>  hw/ide/core.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f78b00220b..b030531534 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -646,13 +646,27 @@ void ide_set_sector(IDEState *s, int64_t sector_num)
>          }
>      } else {
>          /* CHS */
> -        cyl = sector_num / (s->heads * s->sectors);
> -        r = sector_num % (s->heads * s->sectors);
> -        s->hcyl = cyl >> 8;
> -        s->lcyl = cyl;
> -        s->select = (s->select & ~(ATA_DEV_HS)) |
> -            ((r / s->sectors) & (ATA_DEV_HS));
> -        s->sector = (r % s->sectors) + 1;
> +        if (s->sectors == 0) {
> +            /*
> +             * s->sectors is under guest control via INITIALIZE DRIVE
> +             * PARAMETERS and can be 0; this is an error but can't
> +             * be reported at INITIALIZE DRIVE PARAMETERS time so we
> +             * have to cope with the bad value here.
> +             * (s->heads is always at least 1.)
> +             */
> +            s->hcyl = 0;
> +            s->lcyl = 0;
> +            s->select = s->select & ~(ATA_DEV_HS);
> +            s->sector = 1;
> +        } else {
> +            cyl = sector_num / (s->heads * s->sectors);
> +            r = sector_num % (s->heads * s->sectors);
> +            s->hcyl = cyl >> 8;
> +            s->lcyl = cyl;
> +            s->select = (s->select & ~(ATA_DEV_HS)) |
> +                ((r / s->sectors) & (ATA_DEV_HS));
> +            s->sector = (r % s->sectors) + 1;
> +        }
>      }
>  }

