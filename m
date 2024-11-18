Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CCCD49207
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 16:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD4VT-0007Sn-9c; Mon, 18 Nov 2024 11:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD4VS-0007Sc-0i
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:21:42 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD4VQ-0002gO-9w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 11:21:41 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cfa9979cd1so3844716a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731946898; x=1732551698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7UUkR2GzToY03cpQGomfP8vp5af2lC/Je1w8P399As4=;
 b=jGL/hNZFAUm9S+OAupUWWv+0C5nCGwYRRWg01p5EhNT0kqDDKYxPE3yriEJCM7PTSz
 WiwvIEH+lS9qmLNCbQq5tWmUSexuc/jO6+NqiJ0ciN1+5h0V2ufs5bR7Xwzt/hXqFlJj
 YpynZOwWLBnMjzv9/+Wqo8LrlstqkDnNPyO7YROaRTasSjEr0JnAGG0wbbNT8hzc3Ell
 JaFILoyBzu2ZoW5Z5zs5FHyc93K/ZncnLLumBhj+UoXmcZhMuTj+XOpExj/1bFf3yZAL
 RJix6lW8ZwJ6RR68XG4uijaImZq49IKuTS76+W06ttB4KS/ZcUCNfB0f1fGj+TL+3Oc6
 e29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731946898; x=1732551698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UUkR2GzToY03cpQGomfP8vp5af2lC/Je1w8P399As4=;
 b=VKIgIbRVmjByo1aDGBZCuzknsWMm2bv/n6I7Xr/8AoSZreEDj9Ts3GuEQzJLeV0a5c
 u7IO5uplkw5VbAvoDLl42R/M3q+NSXjIJxtKlrzU+vtUQfp9JCYBFeTtZ6wuUPZvUZV3
 m4ewrRhyZsH4pVoiBoEsWtT0ddRa/mmn3X6VJVlkj2m/grNOmym+vH/TtRZAkURRtzKf
 HswYFuwNOLN7EueS5owFI0ItzT1Ojrs5bEl6276BiXUldRjuPu5LKOOsPgFzLsndUfPQ
 qqw95DvdYJFRljJNw8wkhT23QSAdTFQXLEUKZDW4CyKQrTOLI1PmpYPZz1Rx0Xquku8G
 1TTg==
X-Gm-Message-State: AOJu0YykDq4hnoySnyiuM4o8M9NQj5PxvKyTW6xrKAbp+yyisPbvzyNM
 drPXJyoJSgpaRqpmZXSd9L6O6nSlIBC7/zYBrGuizDILlogSgSdLqd2lMI3zjDkamd1SG61QuoS
 CWfNI9LBtGHOUu8qzeO/oMWACxBC3zNOAGOzIEg==
X-Google-Smtp-Source: AGHT+IF42jiC53wiWUrQLxv/Le+/RFFcXIuWdFW2Yr1pZoHXfB70wU/psttRlrlfZAncVNHAE4tH4wOFx2MXUZ2jVGA=
X-Received: by 2002:a05:6402:1d51:b0:5cf:84c:b7bf with SMTP id
 4fb4d7f45d1cf-5cf8e0201d6mr12629894a12.15.1731946897774; Mon, 18 Nov 2024
 08:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20241118134253.2071319-1-pbonzini@redhat.com>
In-Reply-To: <20241118134253.2071319-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2024 16:21:26 +0000
Message-ID: <CAFEAcA9qavOHXaDBJjUvf_xvZ=LEG-tZ1OABoXFWNU8O397POA@mail.gmail.com>
Subject: Re: [PULL 0/2] two tiny patches for the next QEMU 9.2 rc
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Mon, 18 Nov 2024 at 13:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit f0cfd067867668870931c9411d96cd518564b7a8:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-09 12:34:01 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ebcf886d88e0fcae322d063b28846d20b23b5321:
>
>   configure: Use -ef to compare paths (2024-11-18 13:44:54 +0100)
>
> ----------------------------------------------------------------
> * target/i386: fix compilation without CONFIG_HYPERV
> * configure: improve check for execution in the source directory
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

