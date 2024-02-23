Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F5CC54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdY9l-0004fI-UA; Fri, 23 Feb 2024 11:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdXtb-0001tE-Pl
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:55:31 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdXtZ-0008Os-Va
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:55:31 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-564d9b0e96dso666111a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 07:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708703728; x=1709308528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ef2SWWPe5HPlbfrJddMs0aQZkOkiz1Qquabee4Fw5HU=;
 b=gqKb8mM65CWvdz8LSJRnClTQvZQlZ0luzEpXS17tT9viWDNThm7Um+tzPmWJ5BboRW
 t8N7KFKB4EIENwXLVwk5M2/FFpe55bFXj6bmNif3gPtLV8dI1V/6lN+ofsY0/oajXXcw
 3vsKHfIXbFYZAoNOtNquclhMIGluOKKfBo8idQUYP70LMM5ONvcYTCbsJPULNMvtR8bZ
 KccKXPw9qB9Ot190howzLXzuGUqom1vLT0w/ZT8wFC7yDOFOtDb8bLNWjovfEnMViFBi
 0pHXAZ0mD9i201RrH3JqxCc5LNWxfx2T+9/6X1IAA1NgoictTqMc4HM0UWRJ4HRRyAmw
 R/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708703728; x=1709308528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ef2SWWPe5HPlbfrJddMs0aQZkOkiz1Qquabee4Fw5HU=;
 b=IzohSRxeVdWX5Uc0oF6sc/jgyUwGqOhcs6u0brCMgkOLxJjdAkQQOt5wTFDTY/tNYw
 z1IPnu1ICLuoU0Xl7YyFQ9OecFRZ3wfAErqQWBzXF51tBq+dudLsz54+q/juiNkmcr23
 zrZDow1uuKXOfXWQUOMQXmVfM45LXm74DR0LMPdajOr8FfaN/DY2skrvA2LOD/p/NtzE
 HAeuLyVGC6IuGGVhGF/YHjM3sgscPn9/4BfQ3OeKgd5df7qTYW6MpCDuKa8q2auWn6/l
 ebe8UTdxkdd5RDtANRUHaP2Y+DKaV6348Ty/sYa1Z6EVlFo6pTrI6708QEKAHsolAgjz
 Wdxg==
X-Gm-Message-State: AOJu0YyMCQCYiS3g+6Ol27mV+V7rQC0WzUvKhq8HiK6LsOVh8T4F2GdJ
 JQnBztObcHjMdMIT4O/p4iSYyoaCL4vWbP6jOXa4eO92WK6ggdlamDgvmnlgcyWa087DxkjLjez
 H+LKLT0kd4GxETqalKAAO8rNYhQM7nciQhVTs4/dELIab3J3/
X-Google-Smtp-Source: AGHT+IGdCRfei09MJ5F9cPW5RAbrv5beRD3vHfcYyuWVDaPB2YF7PUpj4UybO4dkW4ONycJOV2JccyUJCu1VN/JTck0=
X-Received: by 2002:aa7:c502:0:b0:565:6dde:e3c9 with SMTP id
 o2-20020aa7c502000000b005656ddee3c9mr153499edq.26.1708703728032; Fri, 23 Feb
 2024 07:55:28 -0800 (PST)
MIME-Version: 1.0
References: <20230721115031.3224648-1-mjt@tls.msk.ru>
 <f7656ee0-586a-a89d-6815-d2d378195811@tls.msk.ru>
 <bfd2f1e7-ac90-4972-ace7-517b27c666df@tls.msk.ru>
In-Reply-To: <bfd2f1e7-ac90-4972-ace7-517b27c666df@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 15:55:16 +0000
Message-ID: <CAFEAcA-wq+uwrX-u4fKCWQBt6R=9jxhY55FDH9zPjoHs8hu3zw@mail.gmail.com>
Subject: Re: [PATCH] scripts/qemu-binfmt-conf.sh: refresh
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 18 Feb 2024 at 09:32, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 09.09.2023 16:23, Michael Tokarev :
> > A friendly ping?
>
> A friendly ping #2?

Looking at the patch, the commit message lists 9
separate things it does. That suggests it ought to be
a 9-patch patchset, not a single patch. I bet most of
those 9 would be much easier to review than this, too...

thanks
-- PMM

