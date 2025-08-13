Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FC8CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCvJ-0002Bt-11; Wed, 13 Aug 2025 10:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umCvG-0002Bl-Vw
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:57:51 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umCvC-0001o9-Gw
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:57:50 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e8e0aa2e3f9so6912953276.1
 for <qemu-devel@nongnu.org>; Wed, 13 Aug 2025 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755097062; x=1755701862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0wu/At/kBcWjIRC+i+xv5zTAJOsdYekZtKqMaZ3/HY=;
 b=nm4TsglQZrOLT0uq0uD+WIf3BOzIBmMvvcRiIdKB52+jjN/ruZDnF27Zb034Ht43yn
 PgRcRt2wZJ0GOze6wXBrwHGg4Et1alhKFfCyQbSQy5XPw8k7cnqhcfzrUpmhEXwnx1Sd
 QmtE8ON+JMKSEYtU27Rm1foYiiop2fwrqigPyKpW85AEqYX2vrD3BxwIwuCNPXm1N8ja
 R495bBReWZxl3W+usLah826RZyjnrHDhPRUlVm/h9GjceGYENCT/PMvOhRvOypV77PE2
 WNhsEhHeiEMpT2fUDiRvNpELnmvl6vzGyteQX3MENx7MoxQQfRZlYgxHfXy4JaFGCV9r
 TDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755097062; x=1755701862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y0wu/At/kBcWjIRC+i+xv5zTAJOsdYekZtKqMaZ3/HY=;
 b=FZfnYabjzxiW4eILc/Xk51AO/PYkE3JhHfcfjfp0ja0pHA+zJF5uyq14BiwdrN1n3b
 +w//ux8ItJmoeCvYPJ5nxoxtkmlEC13hDfhviMKpymNjIhf1Hgf0d2u6frB7plcxvJHo
 t0wnHBNONY8lyyibiwcRJP/3UQ1kAVx3RHDMeNBNgx1amakPkz9jAwnZvvcDZX5EMLRh
 N0yil9gu+DyZvqFtZjd+He+nrrF8qxVuxI2gpvSTKEwnQY4ebxWg1rdnRVmUnVh2dCD2
 VwABmPpuwlX25I5cqT3CMIzzvK5P7+eOKdFqaYnhpvJITlUnTNileIjceYI8aSk4uwFi
 nylg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2n2Rxu3qi/bNezkFKX+m6P74BxF2eWoSBkkc9JHqJGgmBLgTys0vPtVlIJ5B09aU4iGfCLtlrgXrX@nongnu.org
X-Gm-Message-State: AOJu0YxES1jykkqG9j/CWNCMZOORMyxLsc4Ewx9hetv5jK3Dv1dBiY8S
 2fJn9fGC+vOaY3meTgZYymJ+UU/mBqbY6pmygE7OwuBRcP06980GgKvT8S4ZurCdsYeZv6OGe+k
 rTFVW9xKHVw20n5YyZVMhP/Ov0+qHDJ1K7VCR2lUGvA==
X-Gm-Gg: ASbGncuPtLKmZsZtE5T/oTetQxWdT1MNtPrZr35ERiYHnbyC/2ZZryYOGFHWAxUEXpj
 NCKMSvoBXKNJitXNKLsSup/MDJMzuBm3gsDG26cXRzc69XHvWXdRQC2s736XdbZieT3TAuI5TOc
 yv6o7QOFNmQJgkw0lncOcNF8z0ay8NlBoJSWnajRevyE/jdZAzQR0Drw/81c5vSePr74b2t/NJI
 pdaoLRn
X-Google-Smtp-Source: AGHT+IHW9fA8tztfa6r4pPVge+R9CG2houI5yJ9hElNGQzLcoo72hyc9SvxfBDDPN2hJsKgewLWhRaB+f5xocADpylo=
X-Received: by 2002:a05:6902:620e:b0:e8e:1e32:c2ac with SMTP id
 3f1490d57ef6-e930bf0bccbmr3643200276.16.1755097062153; Wed, 13 Aug 2025
 07:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <1754936384-278328-1-git-send-email-steven.sistare@oracle.com>
 <ad82545e-702b-4127-a339-680d52065ae1@oracle.com>
In-Reply-To: <ad82545e-702b-4127-a339-680d52065ae1@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Aug 2025 15:57:29 +0100
X-Gm-Features: Ac12FXz7xKGvqrIw-k4a67Krpx9UiejEAEXo9VYdVlxCP41UAMMIwtR6PVGni4o
Message-ID: <CAFEAcA8sfzSSRBgJjAF0gZqkK_CGwZyJU5qmja2cjpmVhnuj6g@mail.gmail.com>
Subject: Re: [PATCH V3 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, Cedric Le Goater <clg@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Wed, 13 Aug 2025 at 14:32, Steven Sistare <steven.sistare@oracle.com> wrote:
>
> Peter previously said "looks good" but wanted a sanity check from a
> live update maintainer, which Fabiano provided.
>
> So, which maintainer will pull this for 10.1?

It's not going into 10.1 (it has missed that boat, I'm afraid);
it's on my list to look at and apply after we release.

thanks
-- PMM

