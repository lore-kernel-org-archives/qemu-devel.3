Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41475CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbfxz-0000wF-R7; Mon, 22 Jun 2026 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbfxy-0000vd-Ky
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:49:38 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wbfxw-0003s0-TE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 10:49:38 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66310a69f65so2320510d50.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782139776; cv=none;
 d=google.com; s=arc-20240605;
 b=PgYJpqN4I1rbw3FaKK2uGCfGeidKEqhC6PS2+Dnx4R74aomwaODryYZnqbVABe4tfV
 f4sy/msHcVMDfY3IX8FvuhpI3cycYePwNDgpxUzQK2dGlN7GycWnW98Q0uTVsr8twGRs
 iH7CKlVoVf7tWsUVQqYu9SxnCwlzYUBKKspwlss2Xh/J5eLqUHwtL343y/DYk6aEzXnb
 wdTWC2Jpd9qy27Az311SBIKf6rbZkSKiYRHmcs8Fb/Vq7PYEH7AVgI6L4jRsn4dCsh98
 9iWKQcXR87b+nCoB+O1Plj4UKX8EdIVPkwW5uKbhTpTRM+yrbS9plORXzzkVoT3fvE11
 Kiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cH8xzlyacw2lCQfDqOKcGjogN3qEe3GnA/fcB74/s50=;
 fh=CU4uMkahKDKs962uJQThoxWtEWeD5rfJeicmfFn1qfs=;
 b=Ri3VWpw1qeBnS2d/9IV+Vx/VEVgqfgGPy9TCDVMd5VXcvkaj8sOLtHOBoLaX8PWMgE
 6xVFDRfxQzbTJe6kSxIi59FYmfZpeGnIR7abv6O/dfq9qzIIbX4+BCKhrDwjQJGh7dAO
 X/nUfQY+xc//eAaT+yw1bwi+t3tHK1iN6lFm4uME4mSZiGaBooL8fBgzerFukEbJY9+e
 eT5Ibq45DJOU2U+JRkGEjsbh80jrvypBBW7CkRJhyLH+kVrJr/370XeJQQNB7zk4bqO+
 ds9L9xKsHy5/HD7fmYBCwo4fbmiFz2vfRL2BmwjANjxTiO4y7KFD/o3htp1MyX8Snt8q
 FHDw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782139776; x=1782744576; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cH8xzlyacw2lCQfDqOKcGjogN3qEe3GnA/fcB74/s50=;
 b=wgwtt6C4ta4VUK29eLfERc6HaJVw49DfAa6T+haXbd41bXAOtovHCFgbyP/6zSjTmX
 2wEdH2ynQX9d7xcJm0FtCQXtkhgiXg4XSFf7bSnh13XwJc1UHwttmtauTOl0VBAgdakZ
 /6+0cW1y0KcoaKwvA2+RWV+gjiJOcaGKTKtqNCTla4wiyuGbEjrQPGR5t4YG59hQqwk4
 F4/1mxibWNXB7AnITKUey/D6jfVE+aia0WbFrXpOlXb+S5qWK32rW8BaqfEnNoTGyLaS
 HsOZ9eYml8VPqygV9zeZNNU5/Mi8g5W6YfqLlevMA3c3LuHjasyGwdDmygFEyYK75xzu
 tD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139776; x=1782744576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH8xzlyacw2lCQfDqOKcGjogN3qEe3GnA/fcB74/s50=;
 b=J/1LBJnvRlc+g1VAEBWbAdWkd0UH9qQlyaaAtFKNBlNV6W7jz0xy2dLp4Q1opNh44U
 q9m44dfM6+QSWXVlulKrsKeUmo5nZVJhIinBnH2CeAh7dcbCVg4P80zP+EejdllvG0gg
 /NmKlETVUuynSfCcQSlHb+IPrzdUJfr5nyGzpY8IinUbj7OTmyL3C63DQpYC6owhaDqZ
 Z4PbSNxW6DM9jxFOLq6tAvUsqai2W8PYG7hh22qwE7JRXsowlQ6HEFLB6O5uFAU70zoB
 XUHe2ActLZP7hxgarNaz3/HD/9/lTqcLuXBNpNyPnZsQPC4UbJ2w40WFRxTdwh7/q2pb
 0KMA==
X-Gm-Message-State: AOJu0Yz2eRUity2wLCJxHvxG269VEu+GeA3Kj7uIQJQZJFOOod4Ckf/P
 wjHdBoFR5YnaoRq1204NVCe77fvMmE3naB7z8HSC2e8N5byVZvRZy1wTF4t6/euiBKBiOvUhdtb
 tjvvI7FqXP0CUb4jOYg6br2RCJzuax3QwMTRbyPS5iz/3pvaynWbs
X-Gm-Gg: AfdE7cm4/FHiBVu//cyK1Q6el5fVhfZipAuOMfZdf+ZAh3uFo2F/ujWJRXTqFtHoDsf
 IMxXn8LEOfcnZRj6dj+by8coQiLszClzcM4KSy7o0/JflxS4YIHK+MQXSdt+8A4PcZ/TDKOyeXN
 QK+zDRoFvNLSm+MoNiW2iZMK1BjZlUE+bKfYfUoxhQ322om8vgNMWqUDeBxafNLiq/YPTAE8ze7
 YDBRtN1wNmmXEpQlGN4SoslNuQYw9oIcWel6Aqr1badSbGPtlTwS/zaMyuChYHs9+mz/k55G2lr
 Go0NebcMoiKHLq4MYToSzG1XHG3NO4n1GqSxdf69pBLWW9WzhffuUNwOhFCinPJiwU4=
X-Received: by 2002:a05:690e:e8d:b0:660:54e4:5db5 with SMTP id
 956f58d0204a3-663033dfef5mr12855798d50.56.1782139775499; Mon, 22 Jun 2026
 07:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260529114723.42040-1-peter.maydell@linaro.org>
 <20260529114723.42040-9-peter.maydell@linaro.org>
In-Reply-To: <20260529114723.42040-9-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2026 15:49:23 +0100
X-Gm-Features: AVVi8Cdl97467TkVOzLJY9E5ekv0snkyD9qLIAlsw0AlhhlRi10vN0PSNgbn_JE
Message-ID: <CAFEAcA-880g8FVk1SZ8eH7-cAkzh2oyH7OFV2LBG68=CcFE=JQ@mail.gmail.com>
Subject: Re: [PULL 08/21] hw/misc/zynq_slcr: Add logic for DCI configuration
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>, 
 YannickV <Y.Vossen@beckhoff.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 29 May 2026 at 12:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: YannickV <Y.Vossen@beckhoff.com>
>
> The registers for the digitally controlled impedance (DCI) clock are
> part of the system level control registers (SLCR). The DONE bit in
> the status register indicates a successfull DCI calibration. An
> description of the calibration process can be found here:
> https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/DDR-IOB-Impedance-Calibration
>
> The DCI control register and status register have been added. As soon
> as the ENABLE and RESET bit are set, the RESET bit has also been toggled
> to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the status
> register is set. If these bits change the DONE bit is reset. Note that the
> option bits are not taken into consideration.

Hi; we've just had a Coverity Scan run that went over this code,
and it points out an issue:

>  REG32(DDRIOB, 0xb40)
> +REG32(DDRIOB_DCI_CTRL, 0xb70)

These REG32() macros define R_DDRIOB as 0xb40 / 4 == 0x2d0,
and R_DDRIOB_DCI_CTRL as 0xb70 / 4 == 0x2dc...

> @@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
>      s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
>                            = 0x00000e00;
>      s->regs[R_DDRIOB + 12] = 0x00000021;
> +
> +    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;

...and here in the reset function we are now initializing
both s->regs[R_DDRIOB + 12] and s->regs[R_DDRIOB_DCI_CTRL], but
those are the same array element (since 0x2d0 + 12 == 0x2dc).

What was the intention here? Which reset value is correct?
Should we be resetting some other register where we currently
are resetting s->regs[R_DDRIOB + 12] ?

thanks
-- PMM

