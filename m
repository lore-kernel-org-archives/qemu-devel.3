Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC4C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTkQd-0000pT-BE; Mon, 23 Jun 2025 12:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkQX-0000op-0s
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:53:49 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTkQQ-00087c-St
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:53:46 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so40498187b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750697621; x=1751302421; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SM5s2yfTsPaxKw+Zimuw1twYcBHdG3Ow5gG+Cm+jkjk=;
 b=I20YTm6MVEZ3wDqCg7cznsIVYpYfG1RYUjigdvcAbyoEeksJ4ppDCDMXayYyK3UECn
 yDkqk+oKC19JA/lQMHt05B20PPNmxEqA8qevlz+ospZTskjOUXjcsDcflCL2vWSb4sfL
 gwCSsuy7SQEB/VCjx20jeY9xgWJ244HqrQKcajc3KSV520g74i0EQ4sbB8pf1jlFhFLw
 nKDlKBBilzYX4/e3lWRiAbvKpvcxyxN0on55eKWTrUfjz4/39pnizD5SM05NbDtCco8i
 PjG3zMUxCDJpcXp8CniEMT7yPDVHUjg1dQdEHnTB/OQ/yVZx37UmEAJW44oZLO6XO0Py
 XokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750697621; x=1751302421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SM5s2yfTsPaxKw+Zimuw1twYcBHdG3Ow5gG+Cm+jkjk=;
 b=QGxSSB9PmIKy7LoJNlsJgyoySOlDpPaeZSVTVWSwRb7xl7pq/lRDh6HbAppr5ZuOQW
 5VOXxJm2Lq8PRMKYXiu/aHRSw0GX775QFJ4sMzUzGbNYEuEoCebKzz8O00sRbdGWpwBj
 9ZpUmQ2vptBZcpJ1MZYv70ps4Oe5+UhD4TgC287OJK2tsKfdSrDdEHYCdgGM9Ka7eIpm
 rqyk+fzQdnrTAOEoC3Q4o2WcsGIq4vsCVJw01tRwS6uCPNIPXCxRxbMaKHN4bxC5ZGAf
 WBOdfo2Wxb2U4atsYl7UqV6TraQjbiJbY7gYL2uHxx8NhjjbvqKTGm1YBH3obe5if5dZ
 yohQ==
X-Gm-Message-State: AOJu0Yw+s9EGYkz3pXLo0EGA3vV1J+uLSbDIMJPNrpaf50Jv9xYl8nzV
 YO8uxB+2v70V4v8r4jlAo1sEcvwP/lBFbFjFkeqvaU/s3l8JP6lUc3m9N/X1wH9SpeTVXpq+ywR
 ahyfr0Dp/lKQxWh9qq2hUWgBTQBi24C2rS+KNeDrH5QplNHpjxjpZ
X-Gm-Gg: ASbGncvVLg4qX4ZdHB9Iee/hPVRpym8kU9YJkzP2cGY8uqXTDP64st3icfxomx7fZze
 dXvsc13tj26gE++t5/A7GaXyXUJa2d+YK5pJrS7f6Cxyx3JyDOWoJNGr2GN5b6/QDI3iHlF9g5s
 5yUo2W0Wd+0omxtcMiZvLk/XtKdAVavJSvxFp2Nc1miuOc
X-Google-Smtp-Source: AGHT+IEgA7os6zOXlE2YjwCG8EhcpGjNdg0HJJirKqrW9++EKr1V+oe50XlltOnzNtoxKB2xH2wgcaaCVg1OLPKZp8Y=
X-Received: by 2002:a05:690c:c1b:b0:70c:a57c:94a3 with SMTP id
 00721157ae682-712c64fbf57mr201291937b3.19.1750697621474; Mon, 23 Jun 2025
 09:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-38-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:53:30 +0100
X-Gm-Features: AX0GCFuAxpZq2zsvVaCkGB7nbHEBCE_biejIyLkDBXwUdmZ9W6rkwAz8NxjRcpE
Message-ID: <CAFEAcA8aPdKLHcLub6_hCnDHRQZ-Nx7D1FU_1sJz=ye8qKn_Sg@mail.gmail.com>
Subject: Re: [PATCH v2 037/101] target/arm: Implement SME2 FVDOT, BFVDOT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 22 Jun 2025 at 00:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

