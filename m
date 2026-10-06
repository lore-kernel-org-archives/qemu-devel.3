Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C9ACA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN96-000706-3U; Wed, 07 Oct 2026 04:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEI4s-0001GJ-S8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:33 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xEI4P-0008La-9d
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:07 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e2de97b4d2so11864645ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791342464; cv=none;
 d=google.com; s=arc-20260327;
 b=ISoiL3sB56rltyzcRye0/5IbEX0ayNx6CAEnizoZMZyM+3g+IqVoFBdnahniI3+Ski
 2369gu1blhsKigtIFVwwJGVVUQB69OYpqdsDJL8nZlsHoggBfLeEdqsNUKtUlcdNsaFW
 KzcFvN3wQYWvlmnbdrcIE8E6R1jWfnS5NTvODp614bYt6wALD6LJD94eSQ+MJVGUE7Tm
 Z75Wn3zX5GVMdihN61AQDwTCeyfPblTlsEDlv6hAS+HdhUBpOgG1IxxxL83nYQx00qzP
 ck7udrtbccnnXx68piUhhrq4FQ1DtJJtwTMghrsanEqZLJ5lNEqF1dU+kZH5rSHErnbY
 4QTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8WK3zec8gA7pfREdAGlD6sa4szkDYgehy2nCGUiweF8=;
 fh=NEyRVjg04fVR3TycHvG0jl9zlGvJgXNyHVqB9OOnoxM=;
 b=jKAcvpdaEJUdALJpt0csDpESBXAV0aiIPNoJtRMsGIJ9yyxxn8Kixii5+fmZiHbq3L
 DUKjCikPtHrYe4y72TiI+I3iiDR+G6BLeITddabEdj9aMQ8mSMw/kkJsWrD4DPnowNcq
 2O1pH049SuxcnSP7yZDVE59JTMXUx1sN2hj9GDMI180sSQx3PZuyhwsF6/5ghJ5teInH
 1WxTwPLBuio3ZPfFL7qPPJResn0w/y0tBKsy4h+SMz98EoQa1+MPQE3u4JDV5A8spGFA
 hR0xqQDie7wpZr0zl92RoeBkdIr0rB6m+rtOZA/nI2/s0Lsd/Kuu55Po1EqZ+V5UNP8B
 YoRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791342464; x=1791947264; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8WK3zec8gA7pfREdAGlD6sa4szkDYgehy2nCGUiweF8=;
 b=sxti9A/yNdZHvayeRo+tpR1ZlPrWwXwGfmUOnaH3Q7XP/l5+OT+eHk8YE4MwB2RfJP
 dtFIoXRHAAoW3EJpLThr4rxciMWZ2nr5z/kiSrvYpleZGQl1Gx+b6/5SxpXHbeR5fsOB
 z0/NOMxlGOYxuYgKA2mfU04nf9letZfPPkAMkNX15g1uCBxrqsSAQmDcn3tbdE+kHBeL
 EctmBwBFp9bGMabkNQ3T1Yyielo6vjejsr6naZlBjvloM7gcbxVh/Rg3Hdr4LFs8zTjz
 6oMOB3vfRAY4hiekyACvwSyLJa20IZzna5KHQImHzEqoHpkhyhT4CrMr/QCCLgj31f3G
 5svQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791342464; x=1791947264;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8WK3zec8gA7pfREdAGlD6sa4szkDYgehy2nCGUiweF8=;
 b=1vpke9guhImc3aB0IkqYZuBNkCengvgaWdlVXRuqey/X/GFdcdZkGm8eCNR0+kHMRf
 BMGEbP6xSuxtwG1awd1qwPwIohUmou2FpIuKh8E861kSqXI7ltuDfCfRxPFSO3zuXt/g
 9Mzk2Epzld+/OXv+sH07GLzXkDqImYK/GXTxV3u3eclEWet8MQjywAIqJK+ld1i1M6+u
 P2hki+62jr6kUmgu/RMj/1MbKgVp6pmt4kvKup6l0lF6qnJ+/nhV8kfkb2Y71/OPAYJc
 YqKrA7gPvleZ924mLiaKxcEPDaPAaNaNQUrFaD4r3poiBRpNKZR5jLJH0e2vuarAnwUi
 MzqQ==
X-Gm-Message-State: AFq9FYJKg/VsWa+rVw7EeTY2Bl7XX9mj2IPvzrDwOSipgeHbPkUR6gNg
 it+NghPfhvDgwBIN3XcSs2KWg9uJQBtTLhxPHxQD6a/2T0a7NaMHLMtyUj7Yg8PaXECt3aSAqgM
 SL3LJJjYf+GPU+nOtCf2EwQtttVYGFe2fBZxYGmnhaH9ICJ4ddWqzhWEepw==
X-Gm-Gg: AYBFou2LgPRia0FOlymZm4mfTaziPeuwUb7kSfie8pj0sjHvAVy+P1Ouso8fBGJF+Nh
 LH4Fp4Zyqxz2LNDwRCaFKEGTt4hGredkV83u8eorCzVlUTGsb8Hzps+6kv3C8uN3CpeFH6+Mp8L
 DsJvSz6XBhdKtv0xozLgk7II3HFZTaXn8qbqtZNCOIYJ89ER8fA3wu2kDfmrQFezSumNmIxffcO
 i8mADuGfqKG+F6J4RGKRpQKD9VYaOujwld0H0u8mzfbdHLIZ1xh5pypAOTP/QKWUZ1YXENJCsUe
 zR9HRcDR4SCNitvBJaCp7zGdQTH2dPsDN5LelImpuI4ijjkeQqm5Au6CQZJvQG8OBvLroG6MMQ4
 YV1okPXVY1iBKEX7crV/7SiMyT/ZSo5qpqxI9ehmxHZo8lkloTrg=
X-Received: by 2002:a05:690c:110:b0:873:17c9:b054 with SMTP id
 00721157ae682-8b04f3b67e9mr2786957b3.21.1791284361945; Tue, 06 Oct 2026
 03:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261004090500.3082641-1-bin.meng@processmission.com>
 <20261004090500.3082641-2-bin.meng@processmission.com>
In-Reply-To: <20261004090500.3082641-2-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2026 11:59:09 +0100
X-Gm-Features: AclHuK_uCi8-12XdRHW0FiOqJOrRse9qKbJ7s6ql5zhkGQvmtOaKaNxVMtK9mac
Message-ID: <CAFEAcA_U-Aoo1MmvAm61_HxhbA+1A-YX1g+oh=1THsi9QKBeOg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] hw/cpu: a15mpcore: Model the reserved page as
 RAZ/WI
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, 4 Oct 2026 at 10:05, Bin Meng <bin.meng@processmission.com> wrote:
>
> U-Boot's shared i.MX6 identification code reads PERIPHBASE + 0x4 on
> MCIMX6UL-EVK. The first private peripheral page is currently unmapped,
> so that access causes a data abort before the console is ready.
>
> The GIC-400 register map reserves offsets 0x0000 through 0x0fff and
> specifies read-as-zero, write-ignored accesses to reserved locations.
> Model that page in the private peripheral device.
>
> Reference: GIC-400 TRM (ARM DDI 0471B), sections 3.1 and 3.2
> https://documentation-service.arm.com/static/5e8f15e27100066a414f7424

The Cortex-A15's internal GIC isn't a GIC-400, as far as I know.

> Signed-off-by: Bin Meng <bin.meng@processmission.com>

RAZ/WI doesn't match the documented behaviour of the Cortex-A15
for this region in its TRM:

https://support.arm.com/documentation/ddi0438/i/generic-interrupt-controller/gic-functional-description/gic-memory-map?lang=en

"Read access to reserved regions results in a Data Abort exception to
the requesting processor. Write access to reserved regions results in
the assertion of nINTERRIRQ."

thanks
-- PMM

