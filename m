Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6C4CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWos-000651-9t; Tue, 16 Sep 2025 10:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyWoq-00063h-5h
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:38:08 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uyWoo-0002Oi-5o
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:38:07 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d60504788so39673287b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758033483; x=1758638283; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qX0GuAamKBTfw0frA2HFTZ5/tUgwMIal8NRgrJpGVa8=;
 b=YCW6xiWmdeemPgvob2fuQeYP5FiPq1dZfLXX9YDWGD+CmDEwJvIjef0TiMx4li7O4m
 MHCZZPdpt+2JVwxCyC6+OfYfGAw0o6IacxPEO06oTaOU1mCx5R/Jv4JhQMKz4G8sQayt
 LblG1UD+WXsbrpNNwEmlN5XnFvCWCbHQ0JKm2bWitAvE7zDNAxV6PJj3AmEOePw6harz
 9n9KX4bRFrnJS/1MdznHoQlIlTgclf/djorV/zqcLFBIliNggBryJCexF4DRwXngsuKd
 hpTc1bE2jvwAMJrbyB4FjHSBtuiLE8AvMYNgPVO4HmlTy3YBIR7ipv1OKa/2MqVMHzMS
 4a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758033483; x=1758638283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qX0GuAamKBTfw0frA2HFTZ5/tUgwMIal8NRgrJpGVa8=;
 b=UsKWaZkG+1NxVO3DN3adIorMnlJUq1USaHqzjMIWbVS3kXoSXGSm9Cy1mwg/lMFssd
 07ZXu16xXO/hASwqrVjUsbph7ce3qm2U3R3uAqG3wSTTL0k1a6Q33Asjbqvo+IqdsenU
 9R/grUz+Sdv4EJks6vBeC+D30j3KkA835qLMG+otVM/j+PdVNZmjTQ+d3pfq4vhruxkJ
 dsco0a99jWzJKHZsd31VfexxJ9n86PplXWoQBzaaBNLQfvgfFpGMv2Zwv2VQN31STbNv
 NDv419ECQSLPHhB34QNWVkngdbOOx2jATBb0Fo+Fo7geos3sYcN4JKFD+HWBuGIH8owq
 tCNQ==
X-Gm-Message-State: AOJu0YzSXMY3iXnvAk6NuMz28SPBX3nK5dJkaupuG4EpVnMwzOlzNW3F
 p60xTmaR55GmZtBc7KBdP845WTKU0yJ8zCJoAIavgxAOFshqgN+ujWU6hfQu+DOTBII5UZe+w0H
 OBKjOxaD935CVAJrOJlby5z8qr96y1Ymt8JJNms+iS5iWyX+a5FUA
X-Gm-Gg: ASbGncsd2psTJ61kKoRpiSIh+/Pe1/7ZRqhRSN94TEm9VV6lopBTD9kjvVycuu2yPCt
 DAG14MXSAQAtIRPsXZnDc9aMhxrb3KBAX8Bauv6T/Se734uDNkXwTTlOc2UnbjPbLpsuu3k4FIk
 qmNyavxrKXWxQAy4WlRNoNy2sf8ba/yw39VDYqnaEdtMSIBk6EMKl61t1aSq+Cvfl0VwQFes3ab
 aYA/A1Jc1RgEN3jmGQ=
X-Google-Smtp-Source: AGHT+IGNNZs50oB77iHUmCEPCMZOwNHTR9xEy17OTSjLDn9zduGycbvuiPwUpl3truRDbi2XcztSyb4U2XU2urV5hJ8=
X-Received: by 2002:a05:690c:304:b0:721:28ef:a9b0 with SMTP id
 00721157ae682-730623e2afbmr125908077b3.9.1758033482421; Tue, 16 Sep 2025
 07:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <CAFEAcA8nFU1fRFMQ_jLcDzKPoPKeV789L5iTgq-kqoa0zULmaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8nFU1fRFMQ_jLcDzKPoPKeV789L5iTgq-kqoa0zULmaQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Sep 2025 15:37:51 +0100
X-Gm-Features: Ac12FXy0-HQu6hEqC2MSVEvI4rjLguf0vkfkzJ27q1YAPrXFqs5p9_y1UqjLjww
Message-ID: <CAFEAcA_+6hXCO3ruA+P_pYVGjtdCA-Li27D13McTf17GX4S94g@mail.gmail.com>
Subject: Re: [PULL 00/61] CPU, Rust, x86 changes for 2025-09-13
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Sat, 13 Sept 2025 at 10:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 13 Sept 2025 at 09:12, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
> >
> >   Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 8733ddc08165d901eb2c87f364f814f58ab9fd19:
> >
> >   accel/kvm: Set guest_memfd_offset to non-zero value only when guest_memfd is valid (2025-09-13 07:52:55 +0200)
> >
> > ----------------------------------------------------------------
> > * cpu-exec: more cleanups to CPU loop exits
> > * python: bump bundled Meson to 1.9.0
> > * rust: require Rust 1.83.0
>
> I still have an unanswered question about moving our Rust
> minimum version forwards which I'd like to get clarity
> on before we commit to this, please.

So if I understood the outcome of today's call correctly,
we should hold off on the 1.83.0 bump until that version
has landed in the relevant ubuntu LTS distros (work in
progress on their side), but after that it's available
in all our target distro versions and we can take it as
our minimum supported version ?

thanks
-- PMM

