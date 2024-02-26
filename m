Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED93C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebRI-0005QQ-HT; Mon, 26 Feb 2024 08:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebRH-0005Q8-MF
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:54:39 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebRF-0007TQ-Ut
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:54:39 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-564647bcdbfso3055811a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708955676; x=1709560476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QciyHgdpbvK4vbD420qln7gWc4lW77b8IPkbdD0k6Qw=;
 b=jQxfItkmrrpyvTL8ey5PSsR/pPwR2ZJQ3pp1PiQjXfeNQNfhCQBiwOUivqkMMjDdAH
 S36ZEK/eB0tH13F5iiTIMLkOywnoXnC+9zYJ10rXuh05eo6QI+gbThF9kMQ6wU9wUa9U
 YmacFqk76Yg2S9JU8ykyUAWaeNrkH6AOWWsV1LWg4OO+l/9XEvNDddEk1rpCV6S09ugU
 zNdS6U7MdlJJIJ+0DqtdbxxVbtOXAYyT0TVOLOlv8nFCRSfCD8CinG9a2bEs/LWF/sU3
 H3dsMVTT/xmiy3TPF6desM1MeBncFEuvFVG21A7E07SGHb1QFto/KXo+g5sRj7Umbjtl
 InQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708955676; x=1709560476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QciyHgdpbvK4vbD420qln7gWc4lW77b8IPkbdD0k6Qw=;
 b=C0RHopVD6KcDJS7u5urJ6ZjC9tslQTO9k9sC45kPM74ZpeZl+cz0kzXmanz4Djk5fQ
 fioEcycjqQ9UDMnU2rqP+4ibc4vv2waGV/KbnwCMSNUepXuHSzhpyWX6BNGgEughQZIr
 5HsIzDriyt45MEYByiAAsNkslng5ry/u/JSrZ9Pqs6HMpG9zdc/fcJysuRT5+wdO76bC
 Jvh+2E8S1xu/ZPkHKPqqFg/4oLx5JiK3O9yRfTFGMZV5SXFdgCfS7L2nEC9CWibxgKNn
 PTf8ZxNDwm3O8/WXDaokGY8PVi3jqgQeYhUHMZQWoikJgq3LpuRgdhTm2QfllLR5RZ3q
 2epQ==
X-Gm-Message-State: AOJu0Yy5LeK8m8klEicpYf0wsUaMt6Ufi4kBEZ5l7uGqvxc7xtXc2LyV
 96KtuGnQHZ8ixwgIRVxVymA6dSBmerJ9mVIsE16hsJzTO55TWjOPlCUf6YHzi4Wq2UxvTe6hxPk
 JJS3P/QUnfl3+r+WqK2E/y0N3XS4k5yg9UKiRTg==
X-Google-Smtp-Source: AGHT+IGKL03oAwgYeDuRA6Y6EblY7JtTg1Z91ZeXLGZmuLAxIAa9lxc/QxlJ/UGqhUDT/VPBQZQbAD9SbAqUn0j9xAM=
X-Received: by 2002:aa7:c695:0:b0:566:ef9:a499 with SMTP id
 n21-20020aa7c695000000b005660ef9a499mr1011682edq.1.1708955676071; Mon, 26 Feb
 2024 05:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20240226104954.3781985-1-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 13:54:25 +0000
Message-ID: <CAFEAcA_tbkGdK9jXCGzWHRaDjDvGYhaJ8U+LUsxoxMzBtyLmwQ@mail.gmail.com>
Subject: Re: [PULL 00/17] QAPI patches patches for 2024-02-26
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 26 Feb 2024 at 10:49, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit dd88d696ccecc0f3018568f8e281d3d526041e6f:
>
>   Merge tag 'pull-request-2024-02-23' of https://gitlab.com/thuth/qemu into staging (2024-02-24 16:12:51 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-02-26
>
> for you to fetch changes up to adb0193b90bd1fecd7d6dda70fc1c2d2e45ceae0:
>
>   qapi: Divorce QAPIDoc from QAPIParseError (2024-02-26 10:43:56 +0100)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2024-02-26
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

