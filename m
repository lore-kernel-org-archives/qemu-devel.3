Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5156C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIIv-0007S1-Vw; Fri, 12 Apr 2024 10:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvIIh-0007Qm-Ea
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:54:49 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvIIc-0008Mf-DF
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:54:44 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a46de423039so58326666b.0
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712933680; x=1713538480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fy0rMmid7rKAn87eUQOzYFJ4yOMfe7Ycv7fBWrgZdGU=;
 b=cVZkFR6Bk9sCDDaLSrAMm2dI8wfuTspF8WPgZm87VMbS9Jnsj4IaoxlR8x/mH6f61P
 WukrVbv2OuU1ue6eIoKhwMvUkyIN4tiHQd264GJYpmqw0QP6T2zig3sEd/tKaHxOv/ac
 uqyjLU6NJWfNf4NtJPKQ5rRhHyB7i0z8fwd+G9Ii7fWlaKWWKcKGQyKl6om6uoub4yDi
 jmCECeCUvc2nJs9g4bkHokQKQdeWuxjVZ8hMWI8fAX1plFe2vlgCPGDI2Rq1wj10FGzc
 zpgn1mnnl6wzhpFNT2P9RnCbEXvw2BYSBHFl6tEpiU6UfTjQZc6GaXCgTxH7Tv1pQ1PY
 /DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712933680; x=1713538480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fy0rMmid7rKAn87eUQOzYFJ4yOMfe7Ycv7fBWrgZdGU=;
 b=OOZnjQqE+AIlLrOLnF3npNgimK2qw3+5RSRolOASjfLqu8Gs1uJHYR8U7w0R31WCxv
 y1nbjdpyGEkgP6vvYvCC9zti23ehDQGyzxlj8FombU5N0HhGLwlO8F1eeeU0j6jXKqjJ
 vr/Dsz2wPqyguCVIkocqbTtu1+BG21E3K3wbspt2V8jORsAQWEX0M0a0yHqgkgmNZ2o4
 UkUfSfE/D1uzTMg2P68j36MZgitCMZu9A9ZLsPdzg1DQlcwEgrNkHQ4/33ZxoFYi5Xsi
 Ho2uK4XSns0UQAuqhxlW+0Vfzt60SByq1Om/ZFei/MaC/3iOFNMVM/hwMFZdclW7qpcU
 vt7Q==
X-Gm-Message-State: AOJu0YxlACxKGFLz6pfyAUSzG8dMuXysV7mJqa/VsVyYYrO4g6uWTNE+
 V1KtAnAvOufzdfzavvwEga4J5usiNKcJTQ2OQv4la4AvsuHcsp1e86IUrNqUbj+kd7CLFzpeFDq
 /F2qJflGYY+/bddzw/9Az8pIO4+KHDEc3jmMuYA==
X-Google-Smtp-Source: AGHT+IFepbNOy478BzGbKBzGr3nbgKk0v53sSTDFRVDsZ5HMqtKSU/Cb9Hfv2P+cun6CJNpLh5lUE21CUuooSZAe8OQ=
X-Received: by 2002:a50:9513:0:b0:56e:ddc:17ad with SMTP id
 u19-20020a509513000000b0056e0ddc17admr2658461eda.30.1712933680348; Fri, 12
 Apr 2024 07:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240412100401.20047-1-pbonzini@redhat.com>
In-Reply-To: <20240412100401.20047-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 15:54:28 +0100
Message-ID: <CAFEAcA_JAZQKaJtbercmL0LKAnO=wHtt+35XsBU2fmPFaCT9Sw@mail.gmail.com>
Subject: Re: [PULL 0/2] Final build system fixes for 9.0
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Fri, 12 Apr 2024 at 11:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 02e16ab9f4f19c4bdd17c51952d70e2ded74c6bf:
>
>   Update version for v9.0.0-rc3 release (2024-04-10 18:05:18 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 2d6d995709482cc8b6a76dbb5334a28001a14a9a:
>
>   meson.build: Disable -fzero-call-used-regs on OpenBSD (2024-04-12 12:02:12 +0200)
>
> ----------------------------------------------------------------
> build system fixes
>
> ----------------------------------------------------------------
> Matheus Tavares Bernardino (1):
>       Makefile: fix use of -j without an argument
>
> Thomas Huth (1):
>       meson.build: Disable -fzero-call-used-regs on OpenBSD

Something's gone wrong with your pullreq : that tags/for-upstream
doesn't have these commits, it still has the contents from your
April 9th pullreq.

thanks
-- PMM

