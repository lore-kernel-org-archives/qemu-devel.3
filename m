Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E4FC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC3H-0005kw-QQ; Mon, 04 Mar 2024 12:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC3G-0005ke-3v
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:24:34 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC3D-0007RS-RB
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:24:33 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5672afabb86so1435122a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709573070; x=1710177870; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wtWH2GKLVB9TTORLSeHbin5g5WMKQBuWBoDKhCB8zvI=;
 b=hDDPbgPBRx/sfSYtagELWcq46HAh+VoQ2m69UHomsrGEV8g5vbt8737NME0Pmex3xj
 5nG1VL0NLFJN6gig1VdeIqFZXEUyfemF+xUt5PEiZJs0uD7YVJSrniiY5u74WM38NE5D
 Z2xapjGEegAQEVIfSudF86n6VNyA2MmZmUT1dPvqog0mY+oUtHIck6hPrwED4Js7xrMY
 /SwKa0XrPxL+5AKR9P+F/7tlp8/32QJSWpS1wcEM/v7aolsBnW8BQQK+msjUzruj2Rf5
 JQUg5PDQz9MsTeCrhZ2j3N56+m6AITaIpBKinKc6zk+Kolo2cF89ER6cOpHOb0UPQUf5
 Yagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573070; x=1710177870;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wtWH2GKLVB9TTORLSeHbin5g5WMKQBuWBoDKhCB8zvI=;
 b=sFY50czsg3Gx7SFAZtK3mr07mlWNnoB03sWMV+y6NpI5rc2tV3BCh+labz7NNvrD3w
 bgskC+s8OJQpFdGvvzjNhy457rQE+CAXKom0YeNliRpLKTUxwgb0pVjJ7phFL9INJYd3
 wSWTHmeXgF+ml4GwluTjRWK/ifA4fek2uA1u0zSAc6diMBH3PEduTQm+mapSuF1PsWtx
 A4mE+3lqqmsyG/g6zm4s2F0L6EdehxMyfqFkv8mQ94OuV+wyZ6Sf9QE/0bk+HhgFsErP
 W1xN0eUxu8OacddvMnU7FX29BqKBxmZUWJzSZc60eykUhwk+bYK0e954PGsALWddG8Zk
 IbVQ==
X-Gm-Message-State: AOJu0YxxgpmaCKFXkFX+eUofyQOTJJHls6YcY6v6SzGNWEktBZ3dITZK
 Z6cLa3auYfQQJfSXqSiQGwAKJe/o+vsn7wRlE/jSMNd3Pkv7QJhkadvj1GtSA9BFFKb6CB7GK3j
 JC2bCZ0vXBP6p6nZtLp9wzEYgLMOlnj7me3JW5g==
X-Google-Smtp-Source: AGHT+IHRWwFGNXQIBoY2J4SadmHWaENkjKoE625sDdFV006HACD6iwSRJXkvkca45tlM3424aqr+FQxk3nuSCT1HXqU=
X-Received: by 2002:a05:6402:1d3a:b0:565:6dde:ed2e with SMTP id
 dh26-20020a0564021d3a00b005656ddeed2emr5999272edb.33.1709573070119; Mon, 04
 Mar 2024 09:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20240302010627.12998-1-richard.henderson@linaro.org>
 <20240302010627.12998-2-richard.henderson@linaro.org>
In-Reply-To: <20240302010627.12998-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:24:19 +0000
Message-ID: <CAFEAcA-_ZbgmF0qxNxXevU4yztWYdgVL74QutHtDsfp=5kojCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] linux-user: Implement PR_{GET,SET}_CHILD_SUBREAPER
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sat, 2 Mar 2024 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The "set" prctl passes through integral values.
> The "get" prctl returns the value into a pointer.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1929
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

