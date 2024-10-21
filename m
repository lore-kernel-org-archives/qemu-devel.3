Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D278D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qiB-0003jF-9a; Mon, 21 Oct 2024 07:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2qi9-0003Yc-Js
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:33 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2qi7-0001oR-RG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:33 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a5f555cfbso279485166b.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 04:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729510590; x=1730115390; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RZMi2QZw3dSVcCzfZWFWdEn5OvePpayXlO9Jj50M+zU=;
 b=tj/Lg6mJ55i6tDWkCY89Rqt+uU97QMT2Hue02n4YSeT3vXaxXKhiq2rgSsFRYo1Bc8
 hwT72kS47rUlNMcV+izfJKX9xQb29R1aT4qJDXd4ITkHgpWxk4lnNFQcFcBAwPt5qr44
 flonwY00jlcuHXe2f35oMaAxjRqRw22+42JReJqo8eHQnqgY9ulfogEeM0M0OmpEpYqT
 NwiTOuCUUM0Jq71sffbwJj7h58ffiVsm7vmQQBXyKu65p/JM4ecr8TKv/yJf1v/Otm/S
 TxwtDQQNIfj0wvMdqKQnGNR2YeDyeKJ5oPUiBfi4LnWWqcAq9SDbH87/b13lI5PmrrjH
 lAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729510590; x=1730115390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RZMi2QZw3dSVcCzfZWFWdEn5OvePpayXlO9Jj50M+zU=;
 b=rU1AzI78yWlX3svrEkyMToqs0ec/I+CP7gVAI3rkLqpo1qs2dDKLlWf12cUVgxvVG5
 fyx+hKme1dQpUJMZLFn5YMdWa+CuIb93c1LdDEOgixB4Ju4odNqHTTJaRNaEudyPV4gi
 u/HCfhMwE4cJhmn7UHq/42jQhzV7LQOtXPHYRRn97H7Bpynd7SQKeboJYEbTChA+rSPL
 EpWTKgR4IbbjrtsTHZO4RdflWDW6rezC1A/yKKnNx68m1jXPlRTHH1oy5MPf42db308a
 sqnriqFU0iqe4eh+aoU2UjFQ5a76MnTiT8YXdjC6smpxE6w34I1fNA4ciDjLY0qyRCsx
 cJ5g==
X-Gm-Message-State: AOJu0Yw+FZa5M+NF2TcAcOn1bxf72ncQk+wy3aEpYV2v4zvXd+hfp1eS
 MLhALOBCTvFIYf9I9p40OvLtpKOCxxCmCzgRz/uE+VExFpWsSC+g7PNYQ6Kbx4HQdDG2/GJmdyd
 dtazTmhHyq0duHen7mMDGDp4ZGQY84CZuedRRHw==
X-Google-Smtp-Source: AGHT+IF90MWKJ6n1E/Wop70gcA3tMbWuQGLtjW2uk57qrth3Sm27hmsynCFURioIsRBpyr40vwynK9DcjTcQPsTWfaI=
X-Received: by 2002:a05:6402:42d6:b0:5c9:137b:b81b with SMTP id
 4fb4d7f45d1cf-5ca0ae81126mr13589102a12.25.1729510589604; Mon, 21 Oct 2024
 04:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241018134004.2110276-1-stefanb@linux.ibm.com>
In-Reply-To: <20241018134004.2110276-1-stefanb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 12:36:18 +0100
Message-ID: <CAFEAcA9hOvT1zFGg5X0njTtkCKLHnCHV_BYqm-JwpKTCvARv-w@mail.gmail.com>
Subject: Re: [PULL v1 0/3] Merge tpm 2024/10/18 v1
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Fri, 18 Oct 2024 at 14:40, Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> Hello!
>
>   This PR fixes an issue with a TPM test case under heavy system load and
> improves control channel error message handling.
>
>    Stefan
>
> The following changes since commit 95a16ee753d6da651fce8df876333bf7fcf134d9:
>
>   Merge tag 'pull-loongarch-20241016' of https://gitlab.com/gaosong/qemu into staging (2024-10-17 12:42:23 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2024-10-18-1
>
> for you to fetch changes up to d9280ea3174700170d39c4cdd3f587f260757711:
>
>   tests: Wait for migration completion on destination QEMU to avoid failures (2024-10-18 07:58:04 -0400)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

