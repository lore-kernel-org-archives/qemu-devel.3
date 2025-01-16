Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5571DC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 10:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNaC-0005IW-2n; Thu, 16 Jan 2025 05:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYNa9-0005G0-SA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:58:37 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYNa8-0007mo-7p
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:58:37 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e4419a47887so1193576276.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 02:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737025115; x=1737629915; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FQDVStq64xfewT2IWL+LtacP2s9A0iotkXDYg2YqP9Q=;
 b=jXXin1NHv1RmNkUWBx9BNJD2KN4BUxKUt86eT29KlNi2HVBxKpDLD5gDS5DAofOTnO
 jLQS33YnHyzj5CU9NMfcTGQ2OadUo87OykFywY2ZU0fuF6RFpyvrzPN2fpw/GF+xInym
 Qmlbu6nov4rstBYVA0n7vgGDXgBfgKIBxL9a8Rp9ieh+RdvDG6nH2XAwwqy/b/IZ5aDi
 oV9OGPOKY0ibRd3fFQHSrbbebjJrAI+tnSIL1/Bq5ULtCB6HDSqJb+7SatodSx0Bh6nT
 GbR/LDL0NLK4DiqJBB0bqVSQcjzcdp+bVp3X2CxCnG6UAtlM7AtVXVi6K0nakEGnWctY
 NwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737025115; x=1737629915;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQDVStq64xfewT2IWL+LtacP2s9A0iotkXDYg2YqP9Q=;
 b=alxHk252yfG/iJ8IVsrq5xYE9wojNpbny6SP+7TnDju5mWj481VsIzp/PRBW+tmWXT
 0EGyqn/LaVrp/oCsq4ywtIblJHyv+E2d7Bvv4/324G1T/4lgxRLdmYy1P1b96PuRgySg
 dsgkxobAaHly8kzDRQtB7NkKGj0PZNUSzrtXJTql4S5ZqCpcO89gLpncWvhOQLpn2HJ0
 dIeh8Ek+kfKksFpjGKjKmIjRZqlF1mmMrVpV1xk+j3f6oL9xjkZR7GnyXvYH57dwY4b4
 W1LiFS4Uoa0qFRHivvGTnYm/5lWTQk8DuZKwbIuYATGYFm8A0NeGYQak/e1TlErm0uX8
 bCPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK5HBUJMuKrnrSjYeI2Javo27xwSRuYZ3IbY2VoOPRdDoEeMWwpkwe4Vq5VdbIv4Ox7kYiGus8yLE+@nongnu.org
X-Gm-Message-State: AOJu0Yw8HwzXlav/SNPecWw8XKhH8V9uro8BcMWxZpqVREpsxqB8Am/R
 l/ZNm6jGKgmHE3WFiEumXuUeHtdQHqdncD1cYQ4fOaRaS6TRjU4OLqJciJ2x9kmp7Hzni54NM8G
 3u3FcvIbzI1AftLnh1pEIAS0sF6hNaHN8Z1xeSQ==
X-Gm-Gg: ASbGncurCODegrzmleDh/zq66u3J9MI83J8oNlTu/kZPnRpwvYtFR9ziRkimu1uNk10
 NUsM87/dl5Sb3aYwJDmCCsaATLwFnahNKCFMdmt0=
X-Google-Smtp-Source: AGHT+IGpnRApe4yeaoaGVfZsx8iT2Aw3dW7uUAMkFnLKRxPqps5k1mzBj5RV0eRVmhyOn8WY+W9UusmoPXbGmPKq4fE=
X-Received: by 2002:a05:690c:62c4:b0:6ee:a81f:1264 with SMTP id
 00721157ae682-6f5312d1f1cmr261195447b3.26.1737025114714; Thu, 16 Jan 2025
 02:58:34 -0800 (PST)
MIME-Version: 1.0
References: <20240718072050.9503-1-sgarzare@redhat.com>
 <b6c50dd04d77d266a95d5752a24e97b65ccf3f05.camel@infradead.org>
In-Reply-To: <b6c50dd04d77d266a95d5752a24e97b65ccf3f05.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 10:58:22 +0000
X-Gm-Features: AbW1kvaXdDHOxU3qh_Y2ALxfy33kkMGlxHUGQRz1x5cNqPEHXMDhe2qXEfcOB0A
Message-ID: <CAFEAcA8npFet8ysFfRoPFdoJEZ-vY_58SvnPqQm7z5WKsHiRNA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/checkpatch: more checks on files imported from
 Linux
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 cohuck@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 16 Jan 2025 at 09:26, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2024-07-18 at 09:20 +0200, Stefano Garzarella wrote:
> > If a file imported from Linux is touched, emit a warning and suggest
> > using scripts/update-linux-headers.sh.
> >
> > Also check that updating imported files from Linux are not mixed with
> > other changes, in which case emit an error.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
> This now seems to complain about a commit which simply adds a file to
> update-linux-headers.sh and simultaneously adds the newly-imported
> file. Such as commit aa274c33c39e7de981dc195abe60e1a246c9d248.
>
> Was that the intent? Do we really need to have *three* separate
> commits, one for update-linux-headers.sh, one to import the new header,
> and then the third to add the QEMU code which actually uses the new
> header?
>
> $ scripts/checkpatch.pl 0001-update-linux-headers-import-linux-kvm_para.h-header.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #36:
> new file mode 100644
>
> WARNING: added, moved or deleted file(s) imported from Linux, are you using scripts/update-linux-headers.sh?
> #41: FILE: include/standard-headers/linux/kvm_para.h:1:
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>
> ERROR: headers imported from Linux should be self-contained in a patch with no other changes
> #99: FILE: scripts/update-linux-headers.sh:63:
>                                       -e 'linux/kernel' \

Just to state for the record the conclusion of our conversation
on IRC; yes, the error is correct. Header-imports from
Linux should be in a patch of their own which has no
changes except the results of running update-linux-headers.sh
(and ideally we would not have let aa274c33c39e7 through
code review). So, yes, you have a series of three patches:
 * change update-linux-headers.sh
 * automated-change-only commit resulting from running the script
 * the change you want to make that requires the new header

thanks
-- PMM

