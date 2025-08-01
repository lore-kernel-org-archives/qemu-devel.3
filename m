Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7013C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvnN-0000XS-Eg; Fri, 01 Aug 2025 15:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuAb-0000GO-8f
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:07:54 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuAZ-0002Tg-Es
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:07:53 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70a57a8ffc3so20929747b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071670; x=1754676470; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QVn/2U6Hz1jZfK2R8MUhGfHOWMWOaXDYRY+kk5dckJ4=;
 b=rDi4MYVu7y1hDvdYI1ZBal8EHVOlhaJjtgWQEAqF199KWu7nbysdGFqS2EpFXggvj+
 yOljsJ9ymjS8cxjJe+RJwfTTOyNYI4SxwJVdKZXZsPX6pz2LgLSeg4IX45wJzA/jkdOo
 n2HyAtz8RoBqVMSodgtuVABTm1W+QbC71NG/cg80wzFRxoUJnEM/G9Yvj34JM8h9pYNQ
 vlsuStF0rVJzXCy1suRW6QmHLz4Sc/YZOLypU5jsRhdJlXOuhMBCei/Z2GA0eZn4An7D
 7Ke9ALC3owVLJQa1TVhBOejfU/9pDjtYkCw1SDAUGRHTegm7EUc0UXci7wzgY0cMM9Ce
 TegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071670; x=1754676470;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVn/2U6Hz1jZfK2R8MUhGfHOWMWOaXDYRY+kk5dckJ4=;
 b=xQlgt6PG9Hj8IEy0XU8WAaY0bx+2HsQi/F5EhoBjAs/HUh4b9pxj5XHVkYMpb2Mxad
 FuGYPzlpnrrSxxrKzjhlIysKCtyo2ypqsnAn+enTlZqotK9u8t+XCl8ofqnBL0E2iXI3
 tG/0LuPhFA2KYXC++M5Y1a46s1HpMW9oi+2AEhl1/SkRYev45IYawyan1DSE1fmyhZa3
 B3dZU72g6xskzoqq0/38ySvZlm7ph6n8kZevDEYgv0c22Q0qMzvpYNVX+50+gtFggYF9
 sN4UoR2INxxe1+/qKISynqSrnxgOnctbMBodNyUaWi9x+NpNB/AJAABF9TxJRbt08DF+
 pUTg==
X-Gm-Message-State: AOJu0YxKiJm6foAq5uQxXxOtFpQii/WKLpHrDIxa1kr1FXn7LAvlZsXJ
 RXhoZYOvHYyxO+YOd2xuYbiGAChSzQLcjpxzYEbIgeG4/vnne9L+xVsA85hfr+SsfSrE3RQCVpK
 Iw3H3xfvZ7iy1hZx2c7pMU4tsYW094x+wlSEm5UVy4Q1y7nwQFXiG
X-Gm-Gg: ASbGncu6XrHsuU2Axkctb4Ijpce06jMJCH/L7BxatEaIAT+mING5dXbG2LTW6n9SexN
 fhEepMdjLTaKmThMWqHT8mzG214ptQCY0XLP9EcyZ9zFo9fmqKy7b20hQjnj6KzA5FznKa06/ke
 8SVSAKunHNymdjmexSdYc0JwcP/hBnHjmvuU7zh/MhzVhSiDVc9SzZ48Yt7DlED1IBpJWMuaMpb
 ZTX1F4c
X-Google-Smtp-Source: AGHT+IGZlPO365Fhzt8y5eluVizm+j8O/xDXDe1o293VMHWTWvg5leGFUc7A2ohdZir3z+G2eX+QGGP7DKniKxVEK0w=
X-Received: by 2002:a05:690c:6d82:b0:70f:83af:7db1 with SMTP id
 00721157ae682-71b7f7f5e59mr7316377b3.19.1754071670322; Fri, 01 Aug 2025
 11:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-56-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-56-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:07:38 +0100
X-Gm-Features: Ac12FXxKJ0JTzgV2monnyHusEojdR6crT7rBLvqboEp2GBEb9BJEfBysh-CjK8o
Message-ID: <CAFEAcA983-Nhj14bN5+JFH+iSOzea+YtBXix5NtC0zCEexmTYQ@mail.gmail.com>
Subject: Re: [PATCH 55/89] linux-user: Move init_guest_commpage to
 x86_64/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h         |  3 +++
>  linux-user/elfload.c        | 20 --------------------
>  linux-user/x86_64/elfload.c | 20 ++++++++++++++++++++
>  3 files changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/linux-user/loader.h b/linux-user/loader.h
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

