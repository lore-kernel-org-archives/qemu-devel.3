Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAA4C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribV3-0008Kk-8t; Fri, 08 Mar 2024 09:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribV0-0008K6-NI
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:47:02 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribUz-0002q9-AO
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:47:02 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5682ecd1f81so836727a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709909219; x=1710514019; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U3hanExyLbHLGyRmNOddEGpvhs/TREzWCZGI+mjYB9A=;
 b=DtxLdQ9yQldih7+ohrKDc/fMnWnsCn518J/P7sUe92BDTUhsvA8gonjpxsb5xkvH6h
 JtrJlbX4fXYb6IReakMMbYf6Y2bGWbSsmfvt59sIt1U+97Wwf7RjXFwMWjXueXEF7Ioo
 u6N0EPtEdHNIdHGSZi51/eqdYfyI4cAN11bT7VnPpJ8E1K0RBxRy45h71s50q7lBRxx/
 sT25HUQowhvGggAhll03/Si2fB59AlDPHVx/6uv2sIa+sbONPsNJlg8Wr6Cuzt5Ajur6
 4LivecDmRsMv6yXRFycE9x9lHnbABNFC08r56i2fAWVdEGHNhUCij2gV9wxdK2ZcDdPh
 T8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909219; x=1710514019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3hanExyLbHLGyRmNOddEGpvhs/TREzWCZGI+mjYB9A=;
 b=jUAC+UnFLFk51AVzmb1Q91HznwQESgTKwZoZIoO9y6ISZO+d8r5reqQ5OcHAVkLve6
 iCNF27WehTbM1Xk1AgQQ29a+zSOAPyRqjee55iYFLj3rnq6CsdPOl8wxR0Btjyz/GXV9
 WYrP5vDS6Gmr5QAetTrspvaKH7VzvxxA4QyDfa4ly1fznUSD0LL98zauZ/qGDsqYQkpr
 xscSopnE1SLVcfx4+vz9X7hl/OjvFYjPrSeyewc2NKPY/ftdPK5cy1ntae1sBQKfJ2Jn
 U/qHynE5GvHhWCYLj5alBFPgBvH3SAX0PHbCwIM2LjZpn5w2ouri8AEpZ37UkGguIV1g
 egwQ==
X-Gm-Message-State: AOJu0YzW0bLJmd522gu7YV/lmSioRK5ftaBIxnJPTvgX8hmVYZrs8jht
 cF/i6dhomRq1aUOCAQn5+BJpQWNryDAWqky5+PYbVedyPaRA7HzXm2VZmtpcplVJ8+e2wcMwEYl
 wrNv+ORGBDd12GSMOLjFRUddwF2OEPA0pkdxZ+g==
X-Google-Smtp-Source: AGHT+IFZi/CUAkgXfofb/pwZNJkUwCBfIDF9WFSfUN4ZgJUbOYglWI/zbhhrtfon1Dm4xMGYWSgIbEEk1+TN4sLzzX4=
X-Received: by 2002:a50:cb8d:0:b0:565:a252:e171 with SMTP id
 k13-20020a50cb8d000000b00565a252e171mr2230514edi.39.1709909218779; Fri, 08
 Mar 2024 06:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20240308141051.536599-1-thuth@redhat.com>
In-Reply-To: <20240308141051.536599-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 14:46:47 +0000
Message-ID: <CAFEAcA8B9KLiHgUrH8uf2Lz7QiKaYwSaPkCU+KRwZ-7e-7UhCg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/arm: Allow compilation without
 CONFIG_ARM_V7M
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 8 Mar 2024 at 14:11, Thomas Huth <thuth@redhat.com> wrote:
>
> We've got a switch to disable v7m code since a long time - but it
> currently cannot be disabled since linking then fails due to missing
> functions. But thanks to the clean-ups that have been done during the
> past years, it's not that difficult anymore to finally make it possible
> to disable CONFIG_ARM_V7M: We just have to move some v7m-related code
> out of cpu32.c to a separate file (that we only compile if the switch
> CONFIG_ARM_V7M is enabled) and make sure to use the stub functions in
> m_helper.c if it is disabled. Then we can finally remove the hard-coded
> "select ARM_V7M" from the Kconfig file.

I've applied patch 1 to target-arm.next; thanks.

-- PMM

