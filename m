Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E48BCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgG9-0003f2-HE; Thu, 28 Aug 2025 13:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureRI-0001TH-2s
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:21:24 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureRF-0007Mw-6U
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:21:23 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71d603b674aso6907417b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394477; x=1756999277; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FpCOVeM0TOMP4Ezx+tq8XhorgzHnen6CUbxS4VUw/30=;
 b=HmTEehdyXpW7Yh3Dhq/WI0dISNRj/XGwHgNg0ia54RkgXEETbaWd8L5ZFTvfi5L8ku
 CuxJQS+g1aBZZ/1NFE6FSE2d9+Nxqs0/7+3gvZF8qxEbdypotnAorVbxZYnuEJ7Mj2vV
 4sQxtDMEN9OjCySsCGittrPi3gJXgxgzqaYzH2NsANeikbYobUlYHs2B2P2Uo/pPROlD
 LOGdTbS+gkuvASQnP6Cs2RT9q1G+YqqnIFAE9qnRV6B2ozdYB+l+mVuhYDmqBA/ZBJwh
 V6O5qTRa3VdW9JNkKnwirAzBS6LZSowBEXflNwWPWsklCvmQTQEZmdUAC+nTvqG6Kn5J
 rPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394477; x=1756999277;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FpCOVeM0TOMP4Ezx+tq8XhorgzHnen6CUbxS4VUw/30=;
 b=bF/t07YYe7D2juz8t+kFAvmS5LVlftYys7prCRIsEis6iGydyVazHwS9n7ZpzlQDB5
 bVExTHiUmeTbp71L5wAEegCpG09cIAJxZhm/HfEl+g3EpIsFpjxJ4ZyJX121F+IMeufY
 hFbkDqNiBMJC93aNy4k/tTahIuptGfy4HBkXis5tccocU6TAvvFECK6CyFheXVWbBrS9
 sx6BBWgLGIIzsiohb8ALYIiOs+VeZiKNsnXmFb8812BnBNT9fXk+NVcH4eGC48GE2zzC
 Yz7paQSOVZNjiovKrDAqRQ/phJMhfrYrqA38ftRzJ/I36VMIagIleU64qOTtFqMyOBCN
 6Qtw==
X-Gm-Message-State: AOJu0Yy25rBYORm37ScTf+aOggizniocZByK0mN80CquQ7sHihXxodSF
 U1gPwS4df1l1OJZued4j1KhKcqZHPZhHt0PztCXpY/cytr8RGXrPiTyvNp9iELKWvUi/PWzwa4v
 +gU0QJkRgXST0Quasv4X6YR54Gp50zNj3fMvTqFDmzQ==
X-Gm-Gg: ASbGncunR623Qm1W0TTZ+2zb+3CxtdqPRxTow3nUoDMEg0BTAPkfQYVJGIZO+f1Kkw1
 BN1tp4z9Kx+hTMNr4IxkzYoXG3MusWMcsTitLDWCtLM32gH4Uvkr8TBOLa4kGEudJLf2udyj9So
 WEQrAAWL1eXpIW6wUcJmVESJf9Xxf7HBMXWDzpE6cr7SYkox7TSkQ8dAMJF9Qnz64evwbpX4Xju
 EhZdW9B
X-Google-Smtp-Source: AGHT+IEr7GKIA+xVpeBBkx4CjArOUR9hXLNx46ZxHEOJ6pFsVPNejBv23gPo0PPr60TMjnblM8JGR0bq68GW/8hU3nw=
X-Received: by 2002:a05:690c:fcc:b0:720:b6a:ff31 with SMTP id
 00721157ae682-7200b6b8437mr187585767b3.16.1756394477338; Thu, 28 Aug 2025
 08:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:21:04 +0100
X-Gm-Features: Ac12FXzmr_7KWRSCpYE7ELN07H-ut2QBxNRlNNCm_F6DRe4937SS0HGtgc_KUMI
Message-ID: <CAFEAcA9wtYKrHPcYu0y=HQ=7Ja0Oa1iZBTcbOYRxRipoCAw99w@mail.gmail.com>
Subject: Re: [PATCH v3 00/87] linux-user: Split up elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The goal is to kill the massive target ifdef ladder in elfload.c.
>
> The functions get moved to linux-user/target/elfload.c.
> The macros get moved to linux-user/target/target_elf.h.
> These are mostly use to parameterize include/elf.h or elfload.c.
>
> The init_thread functions, storing into target_pt_regs, have been
> merged with target_cpu_copy_regs, copying out of target_pt_regs
> into CPUArchState.  Merging these found a few bits of silliness
> where pt_regs fields were initialized but not used.  To encourage
> this never to return, remove most target_pt_regs and hide the rest
> within the relevant signal.c.
>
> Changes for v3:
>   - 48 patches merged to master.
>   - Don't eliminate target_elf_gregset_t; instead:
>     - Convert the array to a struct, which can be declared abstract,
>     - Move ptrace-y structure to target_ptrace.h, if applicable.
>     - Use it to define target_elf_gregset_t.
>     This resolves Peter's primary objection to v2, which over-simplified
>     the interface to elf_core_copy_regs.  As an added benefit, cleans up
>     some other really ugly bits.

I think I've reviewed all of these patches now -- ping me
if I missed one.

thanks
-- PMM

