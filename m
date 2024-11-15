Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF1D6DDFA
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 13:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBwHl-0004n2-0S; Fri, 15 Nov 2024 08:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBwHi-0004mN-Ce
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 08:22:50 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBwHg-0006mJ-1n
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 08:22:50 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so2035772a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 05:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731676965; x=1732281765; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NGPP4i7QbtYZwZYRq93bb60RZTSsE/TgJjIB0NxYoKI=;
 b=rPLDjCJq/oFelSV8n2WedtlK3sUPV1xJa+yf/w64ezXpJ2EddjigoKxCgs5tbCU/m0
 gCWf/Ca2nfPMRP5Xka61n0PZ2Yw7cM4x5gEgWYFfj9Qe5KP6mGRjQB/iC7uupyinuKeJ
 e3+GoMxakjViBkIBXhjYtaPJj3E7xSE1xJc6GoH1LPKQEA0avfT3fCLLZaIxfmRMOAO0
 PRbFrH0sSyADP5V0ML/yTmj5k9rlGfCHRT0bzkb5LVEbD08Kanqc1LU/D/BnnozTU7mF
 JgWhbX+WP8dqE4mtZtK3LwwF88rugVbZAIOhK8oRI9T5OUxqHYObEEBWiwy9wVCjFik+
 HX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731676965; x=1732281765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGPP4i7QbtYZwZYRq93bb60RZTSsE/TgJjIB0NxYoKI=;
 b=LV2l07duMh7i+/kXT98LB6dHAtAQ/uhb1Ca1IUMGIzOrFOqSc3Ogcn6Ye4HdB6uw70
 xVwMfG2WE1Nhf27nN8SqXGeKfONuJ5GCJUXxvaifuh0kVfHGD5btnJPiQztugVridPbw
 bicya85Y9bjrRjeElLqTB/dtaQkBqNVaY25Ff3w1nmw5HyTwTvk0Pjm8sFtbxesF0uR/
 rluhTaZOJDS8ste1wXG3HZU/oo1IwH+/taQnnJx/L0ltcVIAlnZyZnjcO96F2mXWYqYh
 nThPPje+J0FxGxJ4xiPKnnkb8GgfL++ymzxd+e9uzHXEZsW5IWXztdR3MEEXiplUiwSu
 MbIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw6T3Ly83sTGyNF9vMZJzEDQ5Ce4gJG+4ZTwGKpxyNFrGy1b9XPY+ntiEfwdNG7MO9JhCF3Ohm4cFK@nongnu.org
X-Gm-Message-State: AOJu0YxA1gx9ahaWSFJKUxHVuism0aMDavRcTXXldTeXBl3bMtoB9912
 GE3Oev4M6XrBmNkd4+xymi457b5YFtx7NsKsrHV6b+Hdn4wRqt6NVt/bMsN4DKN9GvAZM049GGZ
 Sgdo7fvqvqfZ83wh+vmCLfck02tgBXED40X8EnpU3VtakT2nq
X-Google-Smtp-Source: AGHT+IESAv97IbXeIXpGhyudYUVOniXFk+wiC8hKy0YazJlmx9PrMxrnNcWbhZ9/ZuVx7dBR1EEd04xP5HWJa0VwmbU=
X-Received: by 2002:a05:6402:4309:b0:5cf:704d:238d with SMTP id
 4fb4d7f45d1cf-5cf8fbfe648mr1897399a12.1.1731676964999; Fri, 15 Nov 2024
 05:22:44 -0800 (PST)
MIME-Version: 1.0
References: <20241114165900.6399-1-paskripkin@gmail.com>
 <20241114165953.6894-1-paskripkin@gmail.com>
In-Reply-To: <20241114165953.6894-1-paskripkin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 13:22:34 +0000
Message-ID: <CAFEAcA9i+YmGj5tznoc9FQkDQKqN4vx_0grOjh_ZFGyj-aPgng@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm/ptw: respect sctlr.{u}wxn in get_phys_addr_v6
To: Pavel Skripkin <paskripkin@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 14 Nov 2024 at 16:59, Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> get_phys_addr_v6() is used for decoding armv7's short descriptor format.
> Based on ARM ARM AArch32.S1SDHasPermissionsFault(), WXN should be
> respected in !LPAE mode as well.
>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  target/arm/ptw.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Instead of this, would it be possible to have get_phys_addr_v6()
call get_S1prot() (replacing most of the existing open-coded
handling of PAN, simple vs classing AP model, etc) ? I haven't
looked at the fine detail, so we might need to tweak get_S1prot()
if it's missing logic that only matters in the short-descriptor
case, but I think that would be better than having two places
that need updating for new architectural features.

For instance, we are also missing the handling for SCR.SIF with
short descriptors which you can see in the S1SDHasPermissionsFault()
pseudocode and which we would get if we could make the
short-descriptor code call get_S1Prot().

Couple of minor notes for v2:
 * if you're sending a multi-patch patchset, please use a
   cover-letter email. Some of our automated tooling gets
   confused by multi-patch patches without cover letters
   (and, conversely, by single-patches with cover letters)
 * our coding style says all if() statements should have
   braces, even for single-line bodies

thanks
-- PMM

