Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BA2CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 16:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOtP-0001A2-G3; Tue, 19 Aug 2025 12:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoOt8-00015t-EV
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:08:43 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoOt6-0007MI-Dm
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 12:08:41 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e933597bc2eso3808691276.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755619719; x=1756224519; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eVyyYYXyOJj+NZEZbFWHzFlRWzCEdKPdsKMkh2aNiG0=;
 b=hmvxUZp6MRR4Sfikyc2S+vXA6BuJlh5QAiX+bA3l7X5DXXaIMqfXWe0sbOEgFDQkN4
 A6xhPqkneyEAUX088LzwtbebIMINzGFS1wmxAcRLqfb10lo+/LIuwZXCXh9yIqed4SV2
 ywNua06MpdV9hQly7zMZQHG7yftnpP+DM9oRYr+qcwFc92/Z+FuiCGDjgk+4Af4K3rR7
 WmgAOUDL3i2OkMa1NWd90GY1X1dYeUWcPLD9e4mLI9TZFxpRlKou1BhE2bhlR9QRvo0q
 YtEDQvswuDFtWEPKfwjJDaQmGgc8koX/wbP3Bz3NWSskBLiOyyqRhM8IOmgQ9xNDncjn
 Gt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755619719; x=1756224519;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVyyYYXyOJj+NZEZbFWHzFlRWzCEdKPdsKMkh2aNiG0=;
 b=EjRmRMJ7vhb6xmqONHhRE3/TO747ziS2qxJcZ/OBLVv6c2ze9QpNWWxskdUMNI6pb4
 7lUwAvBKrmQx/mDmLqKqn9DTElmEjrAmosxAi75uJ9tBF9cfboDKpEeqHQdmfK+xwDjC
 2cY2rOFeFihR6ivkALSdDrRNSVWyyL6olSlaN2j/DshhewhsfOaWuMEVRCMkdCcf9trH
 WloxTFw80keeR+ta9++/Pu67nit9rC6FEkSn9UIFidtvGviBTq7tYlssAIhDErNFMghC
 4FLjM0qKeynmxyTcndWBQ0DxG48lg9YwHZ7PZgMIMAGHCQzuCw6czuYhTirpsmu2+pYD
 Y0Qw==
X-Gm-Message-State: AOJu0YxjKyC5YxlG8O8TPNz8TedozzixAE+is3AByU0rjfRS2fCl7IGw
 UK9lA0lrrTD2cDHx6NztsYZ+/fNRhwxaYtXwwp0QV5BUGn4ie0jQLi7CGx6ACLGvl6DUQtDFC76
 VOokK007iuDSqjLHb/XYu38iT3xeZnlhwd/+4S+JB2g==
X-Gm-Gg: ASbGncsUyNMAXc6owjEYVgyMA+6bF6xMVvpR4LiAO0Syf3SYPqZlI7Ni/ifOe8p5UfB
 jmXeP67OqNxDX+PsT1mHJzBQ9u6WpPg2PHikkbWDl7Gs+G4uL5j6MReNVOTiwHnsY92jHqTGkeL
 cNVVJGdSjXdf4W3lGIGZEVg2nTNjmpKi1QKfvcrOdNxPNhCr5YHitGtd9IXnvDhIoe8aPmKu2Ok
 cXohblq
X-Google-Smtp-Source: AGHT+IGKSfV3LrucbBhJGQkuePjXbRYXpm9aJkhl9g5Awrsx5Fai1mUTTS2neNgVWPljvy8T9kB8i3uukMx9IMBmW34=
X-Received: by 2002:a05:6902:c08:b0:e93:4e5d:a149 with SMTP id
 3f1490d57ef6-e94e61e36d9mr3422403276.22.1755619711986; Tue, 19 Aug 2025
 09:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154237.793315-1-pbonzini@redhat.com>
In-Reply-To: <20250819154237.793315-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 17:08:20 +0100
X-Gm-Features: Ac12FXxXnPNjwFIwYReYIkHf7vnhzOSvp5akWkol6KiDbcNaXkXmIfVM36uqTRU
Message-ID: <CAFEAcA-JDHPZaayuQQE-rcASP78E5UPL4UP-mHbrJAB+Um3L3g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add a few more files to "Top Level Makefile
 and configure"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Tue, 19 Aug 2025 at 16:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> A few files in scripts, and the list of packages in pythondeps.toml, are
> strictly related to the toplevel build scripts.  Add them to the
> MAINTAINERS file stanza.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a07086ed762..3979cffb042 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4403,6 +4403,9 @@ R: Thomas Huth <thuth@redhat.com>
>  S: Maintained
>  F: Makefile
>  F: configure
> +F: pythondeps.toml
> +F: scripts/git-submodule.sh
> +F: scripts/meson-buildoptions.py

This is already covered by the line in the "Meson" section:
F: scripts/meson-buildoptions.*

>  F: scripts/mtest2make.py
>  F: tests/Makefile.include

thanks
-- PMM

