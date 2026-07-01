Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B778FC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes5F-0003QB-0d; Wed, 01 Jul 2026 06:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes5D-0003HV-6H
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:22:19 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes5B-0006Xn-HZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:22:18 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-664ae993e4bso216524d50.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:22:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782901336; cv=none;
 d=google.com; s=arc-20260327;
 b=RI0ad1XgnJvHV5btxM/LpaqiJDi7+QZR1Fw8bZ5SkW9ZqcHF6PnAVKyTrL5tJ61i32
 S4VAcBkE+fzlxCikgRnrpbsum7XkJEiHl5TZoemBeoJVxcfyEpMlzVVJ9Kb2ceHuCzmf
 /HRRpAkJ+vZ9Y/WnZqfm6a+5aY8GNK5TSZi0B8VaVnhjoHI1Yvzr65ZNc9nR58ZslQcC
 ZmdENFAmHrE7Xu/jW4kF69jVPj9FxKX8TpyHEJVZCuk8ClXf1nub3PI663JIslvxatLn
 RXGsEIgQ+p9wUjQ5Heq4DUNrHmDxBgr9t57uHcaEBSySuF1PBhyOy0BjcJAhGDeuU6vn
 FgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4YYewtcOQlTmqmGkOfcSqHWwPhrvhvwpQ2LXYFHJZzs=;
 fh=4ijmDUT0TLvi2F6n0a7z2Ewl7NiOlyANt+C6H+O+vLI=;
 b=Fk/VlCDSfKDGb5Wvk6yUqxdkBngNBIp17dQBxTKERKsQad0ei4M9AEvrF50rSqDb2y
 mvpsvNKFQ6d9y77tWBsKNaPy9Np55L8DpUT7jPojhujHCLR6MP2TfwlNTd8mXDI+M8Gm
 bleNlTaujZ/r9ZD7o3SHNcMTXmXAnGd+ZNvPd9L0E31Pk4uOhiH/GfUrDi7nA7t+/bIB
 FvKinYICtzUstMnUGOiTCPEYRuUVoV4n9VAvnLuRQKHWZUiVEdU4YUeC4mgfwppkyKAa
 I7dAt3Bep3IIBMFLVITy0eRTGOl6k+TdLyNb5pURMBxD8O96jSVvn8XOWk0W4AwBwRjr
 frGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782901336; x=1783506136; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4YYewtcOQlTmqmGkOfcSqHWwPhrvhvwpQ2LXYFHJZzs=;
 b=whPz0NbQgiRGXoKkGZRmsV5YSudLbAbo5XpZ34UfPbrOayQijbaH03ZMZQBiLSy0Xu
 k24Pmg/TPvz7dov2zX4VuYqTDEeP4l748gYUV44PhI242Xz8Kbwfid5b7YbazztO68el
 UcYFsZFp8Sj5NcOCJ7NtKWcyhmE7UhSiHAwzaOnbcqR7YnCu181FOUmej19OmSlViJjJ
 WOOpviZcKx2sHrmD+bvV5QLXlemwhSd1IUa2b4+XlKrbuBAxAqcjBpWCMihl7mjSJl4H
 jx4avvsRxrxdcRIPyzfkzmXVJqJ94W08cTivP8rxuYdUwZjCkWqyiOfeArJB2/BOT9DA
 3iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901336; x=1783506136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YYewtcOQlTmqmGkOfcSqHWwPhrvhvwpQ2LXYFHJZzs=;
 b=jUxijsVlyRBmPdWHgJUG8v8xsrC+eec8k2pvhnMRHRW9Md5mEAo5/JDRt+KAfYD9WT
 FG4L2f+KYppizyk8fbDruPgfMdnEnVaLE1yHLxktWX41P13wS+airKJa/chei6k4+zp8
 XjSjBsf9gwAPrGSQcjnQ8Q2IGFbvTJgfyVaD48c0bW7XMJt09v+3ngJKWYQM3kI/eivD
 vG4KeNnSSqBpzwx4l7aXwyXoXVVy/0TuzSCCl5cKujMRgqfNFsRNKAeNVjtigcg4Ll/R
 KmqwsXhW03sAbuGpiOwbLhgalzem/RcE3qgQkqD3Mj5dtwMrsxkdnu0FXFgcPu8tzL+a
 tUoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcOXwcMxcnzLuTru8nDoz2RfX2H3b7g+epnv0IkiXSE7DzpXqejRlb6pvcLV+iCFVsl6eDqlqXrbly@nongnu.org
X-Gm-Message-State: AOJu0Yy0/XovzzKUFbbTRyMSXISLgcIAHvRSEhfhDui2MB7VL3IyZor7
 l0Ilz/xYF7UqUM3uaDf1vu1NgwkIt/6BKr6Mo9sIVxwvHo3fDw+tPl7oHqwIhiHsksM19zR8ikh
 pqkwsKDLVNuUhFuTPcDsUxbEjsbW948PgL4u4Ol6v8NqyOX6PWDSq
X-Gm-Gg: AfdE7cmqf8G8AbTCZd++dUJjTp6a7kgsqH6lrWoM9D1Dqe+iTR91+3euipPlJSm6OBk
 c/DIQXGyyxJMwnkM5C5rf6lfWhWxZEPnPvnVbEGsgNV+9ntY0yRiIkdLbGE62JYqOWrq1paFdGI
 jdVlz4Fa2kcF6sn6vx3YmUKSk6iWQ3rAjz8DojL5ZwlOFqQiI1Me18lDu/jq1BXPx71VXJnXz7k
 cgWaq68zwqa968QsYB6eiwWxTMefrfgC7no87SLcsfgu3mLzAO2+G6VvRgBSUC3VtAdtvg0abB7
 ZmrxuuTQeVXoHqccywr8DsP62tYavdTTbvJCoKv67aQvFhB/Vs5InuWP
X-Received: by 2002:a05:690e:4091:b0:664:ae87:c770 with SMTP id
 956f58d0204a3-665212b967cmr864588d50.36.1782901335983; Wed, 01 Jul 2026
 03:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260630223159.68737-1-christianslima@proton.me>
 <87echnwapl.fsf@pond.sub.org>
In-Reply-To: <87echnwapl.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2026 11:22:04 +0100
X-Gm-Features: AVVi8CcvKLH4voPiP1BSQ4PlIqc422C68Hob01OnPU2JU3qqOu5tYoD0edpA3bU
Message-ID: <CAFEAcA_z_TQuK=72PAV9t5daBWAHyZ+9FS3YmpRUe7GEc8Q5rg@mail.gmail.com>
Subject: Re: [PATCH v2] disas: converts malloc to g_new0
To: Markus Armbruster <armbru@redhat.com>
Cc: "Christian S. Lima" <christianslima@proton.me>, qemu-devel@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Wed, 1 Jul 2026 at 06:17, Markus Armbruster <armbru@redhat.com> wrote:
> Up to the maintainer.

I'm not the maintainer here but I'm kind of coming to the
opinion that where capstone supports an architecture (as it
does for at least alpha, m68k, xtensa, sparc) we should rip
out our local disassembler entirely. This old "borrowed from
ancient binutils" disassembler code is not worth the effort
we end up spending on making tweaks to it prompted by
static analyzers and other tree-wide stuff.

-- PMM

