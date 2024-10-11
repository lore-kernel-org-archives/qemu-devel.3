Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595ADD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJHe-0000Vk-HF; Fri, 11 Oct 2024 13:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szJ8A-0000hu-8v
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:51 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1szE50-0001qp-SE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 07:45:13 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539908f238fso2368489e87.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 04:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728647108; x=1729251908; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KoYJqYzV3j89I9O0Y4E7Gf3d9b4b/PDmrkIe7rqz+BU=;
 b=IcQKZU14QtfbmnBaCUIMErVezcvCmDVusKcmwJxtWLQAHbRvSNLuKIuJzKO5PuesrQ
 3UQ8BIW/sImZVJzpi64Rnp/7SIHFkL7wvKyDWau4d+YPaBhh6QXwW/x+oWCWQIgt8X8o
 scVCBY0dWlfPQYnlmW/SLKKtSWEXjSEi9jabNE2g+eELjCpwewQKLMMZdljCv0NTgyYF
 X6SmPByjOW92ArgM72YjI0H7j5oOriojCFPRjLsE1T/ql5/UgnD2IHMdndVi0UWaH7me
 dsZGYHy2xnDMPmcpoivHrSYjLZ1q0oTiu/+6qu/4oRlyMg5+NiT0ejEJSzpnBycWiGG3
 zmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728647108; x=1729251908;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KoYJqYzV3j89I9O0Y4E7Gf3d9b4b/PDmrkIe7rqz+BU=;
 b=hL3wzhbV9yCzcqE/cvI1upQIyPKRCu4M8Hkwr//bgG+UzwbRbQVdaXc7UGaJjGX7Jw
 WoV0y8snwct5ko8OQNU4jtX1V4A98HMgMXglZjmqs7hckXiclSQUsdu9hn61uIJmP/XR
 tJbvqalR/CwUe+jf2OsYTB5i+ER4RXjL51K445/HSN23HWUABfLtWWieIu5XY7F0orlP
 0xsfWVVbmjaDvejWKhsFtOExGOBpaWaxF/+p4L0Q6rKSE2fzZlE+66JiWe4/78NhEX5D
 8jsO7tcP3dutccei0s4t31WavPXi0JLhn3lFAj+tCjEm02qP2t3XZrf6d2u3PlG2lYzT
 lEMQ==
X-Gm-Message-State: AOJu0YwdQEVsjM3+KxL0+gE4enYS7IZonuXow40GrDlpsRCtuF5+8kmF
 8F12ZBuGh+saslQHnAC4ve5qB1aH3Nvi0qgO0F4aBN5gxf2KDQKNYHFO5nK4jPljm53n9dbG+MZ
 FJ8NXUa5//Z34U/rU00XvSx74NQKMeeGqvCMFcw==
X-Google-Smtp-Source: AGHT+IGfrJjVckAUdrcSZMJZoxFSI0UGe1MclMlmdmBkvlrlvQ6djuD3nJMM+gBF2OqDwf9mUReJcHXgTbo0vSgUF/E=
X-Received: by 2002:a05:6512:3f28:b0:539:951f:27c2 with SMTP id
 2adb3069b0e04-539da59b9cemr1089226e87.61.1728647108001; Fri, 11 Oct 2024
 04:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241011111249.47530-1-pbonzini@redhat.com>
 <20241011111249.47530-3-pbonzini@redhat.com>
In-Reply-To: <20241011111249.47530-3-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Oct 2024 12:44:56 +0100
Message-ID: <CAFEAcA-ZkWDMMVYW8N_WspmBnM1e=41wmPeCOxbNQz=YhHuKsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] docs: avoid footnotes consisting of just URLs
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Fri, 11 Oct 2024 at 12:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Replace the footnotes with inline links whenever the footnote text
> consists of nothing but the URL.  While at it, make the link texts
> consistent in the surrounding areas, for example avoiding usage of
> "here" for the link's text.
>
> In the case of acpi-bits.rst this fixes a build failure with Sphinx
> 8.1.0, because the FOSDEM link was duplicated in the paragraph and the
> new version is a lot stricter about unreferenced footnotes.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

