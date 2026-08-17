Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162F0C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyqU-0001Hj-3S; Mon, 17 Aug 2026 11:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyqT-0001HW-EC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:01:49 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyqR-0005bA-NM
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:01:49 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7ff05e5d009so39122227b3.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:01:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786978906; cv=none;
 d=google.com; s=arc-20260327;
 b=RSQeTcVyQAQB1nK9tSu0b7pR68tTC1femg/TpzS/x6I/CdVEwrrpLBwD0P1UQclXzB
 VPD6BLCdAcBhFKvf6U/ECsji98cpJU7lYDtTb/tRCdNJN8I1RLUa7nXtcXou0lk3UbKj
 cgjBpGlEeL6n8CtmSPt/bNzw6m3eZKTJ4KZBH9yRaCQRyOxEEeQuSzWf4Aoi0ABa0A1/
 vYUyVoTOmWqakXBruxyPYdcq09vkMAHIPhsSykokF/pCkv/TjnQKLajf3kncX5MzvgN7
 iorvswoNB7CQxOyD9kWsuBdUEGuS1n6ODxtCqgHipWJ7SWoN52SyJYltMPuj/aVt6IWG
 NoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HDVmgTG4FVPA91nr8zreT6qotEHoroa3CbRzNIbmnAU=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Baf23A4uCF8NyBkl7YjZMULdRJ3/X/L91KlGQ6hGxKPUM61ekxvu1+etehcgsPFQXr
 LsWgJN+NEUY+roASZSaqJpPyhPJ1strkFvot19UyD+zkLNplr6ph6f9prh5A9guYst6t
 5KifV1as+1kkVgjRsPHGplr94FSABkncchK5rQU4maoK89kVu6ODFO/VMwf7Nnm7Qg2j
 0adFvVEtFiCTzRvCwgZbP9fJGeYL3yZSxUMWjx1D9arlkqxixYXozrPxCzf8fAZ61ImH
 Eakvie2FuOii+4siX9YfnaKCeAervYmO30tZTEYWjbwabopiyT74Qn2fF2SPFBecyHs4
 yPhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786978906; x=1787583706; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HDVmgTG4FVPA91nr8zreT6qotEHoroa3CbRzNIbmnAU=;
 b=DIfrftZS4gqyHdfO1c/sxRfzWdU69T4/6d/+ZeJAfLqwqsbTs76SSfW7x122c4en2S
 JW91aoPEZYnSOZ/OngdJOAIlv65/85zz/vN/+AqUYs+0fOBgDIgvtVcGeiIPkXeTWiOT
 2+YTbhGt9ULeuWiOH6XTqmRDASefbD7NPjEV8PTiRSMD5G3GZ6DbyZ6mR3whKzAQN3Jf
 XUKPf4lBrE525np8OBsv0tx/C9xcQcwDL9O1VUFCybTkZf1Ij7d/gMMmmbxvsqJSjf9E
 yDsQ75lgwAD+AXQTdxJ7nD03W8AeG35tw+ZtFV92HPqTlavjKzQkfQIeRGdl8GbTm0gu
 T5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786978906; x=1787583706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HDVmgTG4FVPA91nr8zreT6qotEHoroa3CbRzNIbmnAU=;
 b=FZK/mmF+YlM7/GLng2xQb1ghfpW0e4B+UzUbJjkfsHrQkCzRm9Gp3DrC2KQPTyPoOK
 6gulj96BsfSgIvfL02WXcaV12NLC2T2BVURchIQah0Srbi5q3Lnka/hERl4nbRr9XJCh
 LTy6I9/l7qIA8i6QH5wFEAmfQmGi2R2w3lvnzI6Gzb0bPGFirNGXfdUMZO1qQ/4MRkkP
 cBvudD+9lKaH2ssxV0leb+V5tkF1L25YAA965VvGukaw6yVmxBnrCG4Q+LX8BorKCEsj
 fCjghoGJ5t1O5bzfZ+YlaUfd3ZNlOT2hGjRbz9aarDS0bzqCbJJvjpGaazBHfjt9oZak
 U3jg==
X-Gm-Message-State: AOJu0Yx+W6AasZ3GEXgeCONXz3GHThEqVr4b+BZ/enwMlPtHlRvoXSMh
 4airEE2vDUtVzXyTdO5D5+/kIAlw3INNPc/UNzApfPfcFgv2ikua3QWfuDDzfMLimIKUZSndQsF
 4hVOKtlOu5UPabaqdhmUsCA/JB24S5kZGlZvcd7228VK4D9Rzk/8Z
X-Gm-Gg: AR+sD12lIzG3U1bzoYaELl8bnf+sgvecBowPR1TSxPgbKNAJw6rFRcz3kFvzCS/Xe3Z
 5Bor6VFnfiMSalBmtDhARHnG1IXrm1aUgl1/Tdn7BECzUskcRmvR/r3Is5Pxig9SAp42vy/AZiv
 kTonjvhXhGOl9aE2HHk46ODc/Ica4lO3lJl4gYi1Qn70QXMWaKy9WQuDaC/Gil7FkR1aKhICjey
 5gTl7vy+nJA7bEloe0NJkkDa48/EQNal5HWQBd8VhvOiX0TvnrGq3FnqSkwu9i/1CYSVH7Irn5t
 kV7FOkY5wW891lm7NfhUw8JJwE1aM1DF3wWblf4KT09Lz1iHKqpKRzPgL7FNeCWMw/pWNOuoNm6
 8SAsNETF8pZjIthhw5MmpKR+FRZUZ
X-Received: by 2002:a05:690c:e:b0:81e:87ca:4799 with SMTP id
 00721157ae682-841304da213mr5789877b3.23.1786978906100; Mon, 17 Aug 2026
 08:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260812204435.295067-1-richard.henderson@linaro.org>
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 16:01:34 +0100
X-Gm-Features: AcwNN1WW_HWdS_jS3dF5mVGmnKwDpUBHF072Nqs8tjTNLfbwW576k-8vQxXOLvk
Message-ID: <CAFEAcA-xmbhZFG+zVcQDt02UJ5ELY2bOiCkVVW=60oZgzujiqA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] target/arm: Introduce cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 12 Aug 2026 at 21:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is something that we've talked about for quite some time,
> having separate "max" cpu types for Armv{8,9}, because Armv9
> prohibits some deprecated Armv8 features.  Retaining all features
> simultaneously has the potential to cause confusion.
>
> Changes for v2:
>   - Re-reorg cpu_max_initfn, avoiding the build failures without tcg.
>   - Move aarch32 tcg parts of cpu_max_initfn to tcg/cpu32.c.
>   - Separate patch updating feature comments in aarch64_max_tcg_initfn.
>   - Do not avoid aa32_max_features for v9 -- the registers still exist
>     and describe the features that might be present at EL0.
>
> r~
>
> Richard Henderson (10):
>   target/arm: Tidy cpu_max_initfn
>   target/arm: Pass ARMCPU to aarch64_aa32_a57_init
>   target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
>   target/arm: Sink aarch64_aa32_a57_init into aarch64_max_tcg_initfn
>   target/arm: Split out aarch32_max_tcg_init
>   target/arm: Move aa32_max_features to tcg/cpu32.c

I've applied these (1..6)...

>   target/arm: Annotate arch revisions in aarch64_max_tcg_initfn

and this (9) with the minor comment fixups I noted (but not
doing anything about AA64ISAR.API or re-sorting the out of
order ID reg field setting) to target-arm.next.

thanks
-- PMM

