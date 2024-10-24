Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF93CCFA451
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 10:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3v0H-000827-K1; Thu, 24 Oct 2024 06:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3v0E-00081m-4O
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:23:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3v0A-0007VQ-OL
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 06:23:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so7611105e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729765412; x=1730370212; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u8yCiViDHhU/JoC7HoI+6GT/YVXrZnCmwOJeWprysjE=;
 b=RwQLTDi0YfzUfBh5prQYbLikpXYBAboQufU1AxxVcgJ8aLnTU4Sbm81XSj8hACJzTD
 oCDh8dtZ3qtkpKidMpjubpzIMydYTyfPdQrOO5dZ+Fep7Tx3LrTBAcYq1I0VieIHq5aw
 eh221DPqnmdJS2huII2UZJ0w1gmMgpq4kR0OdpcSPBI8OlC6ik3BvY7rafZfi1oCdYaw
 p1ByXJPOrq2mZnQqX9XYu6ROXsBvsBnAL8dWidhExkOQhlYrz+wnZyCYLXtGfE5KDue7
 Jr2bH98bReJGZOtDfwj+wIwG7F7Eb5CIOKXSsROKh45TqUeRb+AlL+TYjJvSpRhqVbJu
 kYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729765412; x=1730370212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u8yCiViDHhU/JoC7HoI+6GT/YVXrZnCmwOJeWprysjE=;
 b=pRRsJaUoUuJoTpDx4HtiFvY2M9PX7hlFmA3Mz7WscsfrU1BJWeBxODgVpU6uJIkAs5
 bIUfc53Mqi0omCsdfKOEJsqthy1z+5VT2NjQoTcDhir5w6KpbBmbObpcYE9U9WmVmq8+
 6YMUoQiQIDLY/nfL87RzerUTBax9Mx6FufqXFUV5MYNvxQKpGycr/jCNeSn5221aVgE9
 LIHlIwTW8uH+EjqDFpe9u2RQtwtXhgH8jLjKfws19qpcVk+nTOj4VaHlkmpc8/HOl+Jc
 hwUr0GhIVoaxp7V5kUJIZCa/9bvqPecEkTl9zRyr4DobSe+wKMec3mFUW+oaqU0m+nTQ
 K9xw==
X-Gm-Message-State: AOJu0YwQtPbeMnqTdP3RBKzed7v6k/T44LlO2EHktRz3WX8xTyYzOS5i
 IdDsW4FnBQY0Wcy/ItQ9BFoIXU9rpnzp1PcMV215nWd/DgH0Dvm+5VCGZq4Yv4VAeRcMZrcsVsc
 RoNL/H+OtAS/ycWTa6e7FDYbsThbO6pHnWZIFcg==
X-Google-Smtp-Source: AGHT+IHbT9y73W6rkexFcedasOsEPUrpFXN4/f51UMTPKqJhIx7JC+j7K/VDjVI7GaJgVEOiMBO9tskT3fLVfLeCGw4=
X-Received: by 2002:adf:ef03:0:b0:37d:493c:f7b8 with SMTP id
 ffacd0b85a97d-3803ac84066mr1047826f8f.2.1729765412023; Thu, 24 Oct 2024
 03:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241022061533.1304493-1-mjt@tls.msk.ru>
In-Reply-To: <20241022061533.1304493-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2024 11:23:20 +0100
Message-ID: <CAFEAcA9dULCs15JWsvX2AhQ801sj7hxUN=u3Xh827a4yRTvKpQ@mail.gmail.com>
Subject: Re: [PULL 0/5] Trivial patches for 2024-10-22
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

On Tue, 22 Oct 2024 at 07:16, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55be4:
>
>   Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qemu-tpm into staging (2024-10-18 15:45:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 5ae3ec63631a907ba474094df99594cd545590df:
>
>   replace error_setg(&error_fatal, ...) with error_report() (2024-10-21 22:40:47 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2024-10-22
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

