Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454EACAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0hCg-0001cv-EP; Mon, 22 Sep 2025 10:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0hCf-0001cm-5n
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:07:41 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v0hCa-00045y-Tz
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:07:40 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-72ce9790aceso29901587b3.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 07:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758550052; x=1759154852; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bya9AGe1MKcELk12G4taz6HbfdLxg/xP+VvPFK5KaPE=;
 b=hp8n4U1usvTdLF4a1zsaleNuHrK8o7Y9Hu+7vip2sjil0QtlgMFNat+2Lb0bRh0/Fs
 hxN5RjMP5k+vK6yFOCNKDuCUbI4frMvbay7sL03WXdprTvRDdw4YcrusqjX7AqdRTBhn
 /+gnImH7XNigrVCTCrD1/kzXZt8o/WldMzTuggxl4WBdDFVoAZo2G9d7k0mb1AM5womm
 HYYaQ0MFRUsi+h0kpzBpcCf8lIzVrdtRiO2Qzv1OF+rrB4B37O/Ik4a9g8yjvkTu1/BR
 Tx411jBiHb7TXkLfxXTE9AQ5DKuZvXplvoIFCGNvcT5cye/2it7QA5DBmmkjN+eSIRM2
 r4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550052; x=1759154852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bya9AGe1MKcELk12G4taz6HbfdLxg/xP+VvPFK5KaPE=;
 b=Dye2SxoLEbCOYL1JPifQGpofXn89DDiaAcXEKvVD4VcP15lLz6V1hR+23Hfmvo59IQ
 Q3fnmFmwg25PuElhAbkx1HA5m4AwazYDKut3GB1urfJ63YEMvnija6IVZ/CvdlWSl155
 ZM/o/i6YET9MhctTLA6kWdyEXcnKN9/TnNI4zFDcG9uuTnMBOsC26Cxmx8C38hdddacl
 O5aoTeQJUqvJvMg/Ao5Mf+imXE2KqB5WS956630FfcH/n/fukZcAw0+OTMkHAHaTdIic
 gHzVzwWoMeyFLNsyLcsatZc/eogSRpKFfSUagJzt6kDxtMZRVnxNGhj+TNyhOyUCmQp9
 hN2Q==
X-Gm-Message-State: AOJu0Yw3wkZUKTUifJdeISjwISr9xjzoobdmalpwjOfeWtgQ44BvyhBX
 amsSSl9qNUqt+GHjTCI/6nX2/lDXeAQ9pzxx8MjiadmwGCXJmikjF0Kq3K7aGD7dLyZ6VxjgjIM
 zF1pUizRdDU0Ju9eZV8xPfUiVk1hgnWqVELRQ+jiY7w==
X-Gm-Gg: ASbGncuqxnKGY3hlsl7gujp4uEmbxHBI6r794CkJv6jsFHCSIyspZFq7DdNULUAB+QH
 bPmVKrL0Y1BZ7I5NF5JP6/tuXjtum+aax7vmGCirvDhovS51aEuZpl7x8HTTD/Avi+w4XlFAYOo
 U0Nqgt7pAGuBvEZa7bj4lz8VjlkhPIoQ9gAM2NyVV5NcyjRvKQX3UW9PfFjr7IhYRpNspIkWWWB
 B1kR1cu
X-Google-Smtp-Source: AGHT+IEEQ+k9/2eN0BE0Yp7WNWSPyMDrnE3kx6sgjiX29cAOQlP8et7rbpwyv3BqJWXTTo+vErYol+HZ7NdjXw2v0i8=
X-Received: by 2002:a05:690c:e17:b0:728:a5d1:e340 with SMTP id
 00721157ae682-73d1efe65d4mr117627027b3.2.1758550052388; Mon, 22 Sep 2025
 07:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <20250913080943.11710-22-pbonzini@redhat.com>
In-Reply-To: <20250913080943.11710-22-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Sep 2025 15:07:21 +0100
X-Gm-Features: AS18NWAIcMLeGxS63iwhSXrZS1tSH_-R69YYQ_o_UJgA81eF28qpjG8U7Qd-QVg
Message-ID: <CAFEAcA9QA5WZnk0R2ZYg4rraX_+1LdRjfo7Ybb6MQkrBuaRt3A@mail.gmail.com>
Subject: Re: [PULL 21/61] configure: bump Meson to 1.9.0 for use with Rust
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sat, 13 Sept 2025 at 09:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Meson 1.9.0 provides mixed linking of Rust and C objects.  As a side effect,
> this also allows adding dependencies with "sources: ..." files to Rust crates
> that use structured_sources().
>
> It can also clean up up the meson.build files for Rust noticeably, but due
> to an issue with doctests (see https://github.com/mesonbuild/meson/pull/14973)
> that will have to wait for 1.9.1.


It looks like this new version of meson now creates a
subprojects/.wraplock file which shows up in "git status"
output. Should this be listed in .gitignore ?

thanks
-- PMM

