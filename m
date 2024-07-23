Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21FFC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWHje-0001TG-QV; Tue, 23 Jul 2024 11:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHjb-0001Gt-6N
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:47:29 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWHjZ-0000EG-FT
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:47:26 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc3447fso4985811a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721749643; x=1722354443; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=izglbQ3GIU3BgoiYPKz5MZLD67lW8yYEtKCC5ugJN/8=;
 b=nHXMBm+Nw9BETC80xppggULiCAtfJ9MJMli1raZSFur8pZUaJzvP208BERDgenI9kX
 XZKRfwg+/ohfDWWG6i1kgGOMB3rdBYIf4vtkMSxLamqRXmij1/O+aI0bdkznB7QRmL1T
 c24Cpq5LRNS0PblYk6nBeVJ5YbRnle/jdEGGnht6HHdzKDvFWbyysxnXybr/8SYKhlje
 6gCVzB8kQ+85jfj/tlP4n0G70yh7x6JW82mQF6zOWRZEgQ/AyrjDjyp5vNWMmUhFG+Xz
 7Crb5RE/BZiyBJVynJlMz85dYCub0RuuKbNBCJIeyrzbNFk86OfTIVyKNrHpsL/Ughll
 2Qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721749643; x=1722354443;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=izglbQ3GIU3BgoiYPKz5MZLD67lW8yYEtKCC5ugJN/8=;
 b=vNIWl3H+jeARuxGnOXprMkoPrVzcwVukPzaSFYrh9tJEY3Eb6XOxcqCPwdgYU+lXGo
 56F/SkVinu2NIdRyw1889lZC7RUcbhjfhdBPwie9M3dw0AZl0Dg9QpPPwl0gpvaBdTzP
 iClkqjlC+I7JFQ6qyuy1JOAzCl2tYe0mtHRJGCdZFGY1rGpMfIdQSPc0QwjYHUTyL2e8
 zP3a8o4p8aPWCV8+nYdd1NjFHRuGu3pKlK6LBiPdZi1gdrd3ZWjXfTZhlHqUC0BHiUQZ
 SK3pBl9ZPQVg48ydwrcC40ltPnXSWzKvNDmt5jJbGviY676xSg4iGLU5vDTks6BrEcSm
 z7Sw==
X-Gm-Message-State: AOJu0YzubRq5RzISz+wlHS17fTwSAs6hvDLDeMvNbgRpmINMA+nJ/BcB
 FYY9J32ZtuVZ0sJBNbj5UWdogH6AQLX4AaSHxu1C8nEwctccNjEmf/8GJ4c3r6Syup8AUMajgd2
 e4qlO/t488oudoPobGvmtv+qiaANrMQfg/fpgrw==
X-Google-Smtp-Source: AGHT+IHjvcs4kBjCIXL9Fa0Gtpo8eVkzDilu9OCCQvM4tgeF/pIEicwFMPrIRtbP8zeCroKBjib1QFHAm98V8GrIIYk=
X-Received: by 2002:a50:a6c8:0:b0:5a7:7f0f:b706 with SMTP id
 4fb4d7f45d1cf-5a77f0fb816mr4636776a12.16.1721749643442; Tue, 23 Jul 2024
 08:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240320024010.1659193-1-gaosong@loongson.cn>
 <20240320024010.1659193-3-gaosong@loongson.cn>
In-Reply-To: <20240320024010.1659193-3-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2024 16:47:11 +0100
Message-ID: <CAFEAcA_8TvbqwUhDsvZm+oi0mj2zGbkFmMuKO+cFqAX-dm5S-g@mail.gmail.com>
Subject: Re: [PULL 2/3] target/loongarch: Fix tlb huge page loading issue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 20 Mar 2024 at 02:40, Song Gao <gaosong@loongson.cn> wrote:
>
> From: Xianglai Li <lixianglai@loongson.cn>
>
> When we use qemu tcg simulation, the page size of bios is 4KB.
> When using the level 2 super huge page (page size is 1G) to create the page table,
> it is found that the content of the corresponding address space is abnormal,
> resulting in the bios can not start the operating system and graphical interface normally.
>
> The lddir and ldpte instruction emulation has
> a problem with the use of super huge page processing above level 2.
> The page size is not correctly calculated,
> resulting in the wrong page size of the table entry found by tlb.
>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240318070332.1273939-1-lixianglai@loongson.cn>

Hi; Coverity points out an issue with this patch (Coverity
CID 1547717):


> @@ -485,7 +513,25 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>      target_ulong badvaddr, index, phys, ret;
>      int shift;
>      uint64_t dir_base, dir_width;
> -    bool huge = (base >> LOONGARCH_PAGE_HUGE_SHIFT) & 0x1;
> +
> +    if (unlikely((level == 0) || (level > 4))) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Attepted LDDIR with level %"PRId64"\n", level);
> +        return base;
> +    }
> +
> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
> +        if (unlikely(level == 4)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Attempted use of level 4 huge page\n");

Here we log level == 4 as being a guest error, but there is no
early "return <something>" the way the previous error-exit
codepath did above...

> +        }
> +
> +        if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
> +            return base;
> +        } else {
> +            return FIELD_DP64(base, TLBENTRY, LEVEL, level);

...so Coverity complains that here we will try to put that value 4
into a field in the TLBENTRY that is only 2 bits wide.

> +        }
> +    }

Should the level == 4 if() do a "return base" like the
error cases for level == 0 or > 4 ?

thanks
-- PMM

