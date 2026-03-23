Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C080AF483D8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ipF-0001Qa-PF; Mon, 23 Mar 2026 13:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ipC-0001PQ-Lo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:12:23 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ipA-00033y-RR
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 13:12:22 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79a60975dc5so5257657b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 10:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774285939; cv=none;
 d=google.com; s=arc-20240605;
 b=XEWUr89ouqNEwgTYRU7fLM9b5T/4OlLq4lNDDSrsSbu98nlvWZi/MSDclwIVTdPAXU
 kjGsWo3RCqYJdQKoNp81ty7ZnwNYq8hsfWS3G8gPv24rVS9zZXgsqBH8JxfK770eNr10
 8tiRrMRGQfaYET4hK+Ne5zuh6U0xV+7B5nJkQ6QzoLy9C5JMdKEB96yq1g8x0QYZtKRd
 p5afR51wi2H95uFQpwbIAyEtihpX5I4qaMyuMjNulG/I18YUYNYikng4hIQ4yioFim2j
 6y5HICT6U3thLeJf4/Wcz2IPYKfGArbZp34YqQIW3twvADs6PQgbCMEzZG5lCWE+eoz+
 h+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GR1VkcQo+oVYC4DpG+EQ1/sIRNf4GzzeXMm3yrpItcM=;
 fh=5edAaP18pyl3lodfbsgOZSnGzjEZI/vj89FYLcBlJUw=;
 b=X+//L6VHVxnmclpfI3omwTcO1OTD5veVrJiF8+W7On5nTnCAwtPp84fiffEA3Ozlr2
 VhivN8rbDqvT8trY7BV7XokTKl3L3U2q6Z4J7zO6TLntgci1Jt+EB8ABnCibAmkbhUG7
 KFQl3DDqJaVCPEyrMf5FpGLU31g5sfWhwwNMuvw913QThH9/UNFwdnKwnCmLHOXp5fFc
 TlBvdre1Cso1NZ2GJ32htGtJ2Pv2Ldpogh+87X1nNOlsLFUg3yP4vLlSZ+0HjXwn+pP3
 FsjqaFUf0idTChtO2gMWd4rZGv4hc13Ed4WIlDoc+BAWeZDwDU/nbUFwPOJBOaNrksKC
 NqTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774285939; x=1774890739; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GR1VkcQo+oVYC4DpG+EQ1/sIRNf4GzzeXMm3yrpItcM=;
 b=NpJxoH6hPcoqynOCI9Td65iOQ1ZSA25pVb+41tSKV2DcHQreCkAuH6gcV68dzsdfbd
 ghYp3cMpl4plJTYBdXBGHtm/mq7DTwV05jaxAaS55y/ievyt9BtFThUii1ZdLp1fhHv3
 NOknNzmY8Ub2b+4d4C5c6n6TDj1AL9tZOvMpJsM+x4VyOG1fzv1UXqXigFT3V+oitoZJ
 0glWAhrL1fPHpWHZcyuWISU0+vWynzNTf43cbL44mk9m/B3+PE/YwJDwYPesFS9EB7q9
 2V5L04Li+exs3zhikmp1jpLLNscm/lRg7vfdTXAPxsmQFaVvYE4E4aM5W9grCQiB4dQy
 a1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774285939; x=1774890739;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GR1VkcQo+oVYC4DpG+EQ1/sIRNf4GzzeXMm3yrpItcM=;
 b=Qi1OoqfBJR1FSnKJyz+0ayDO34srjsiUw0xf4LEruaBQPQ+zTNPfq0x7pHIEmDKyPa
 vgo5qiI7rx5/Qy9IU0tkAZchvpPGfokThPZpOWt4jTAq4omI1s7CJlE8iVjV51ooL9OT
 9vueelssvQJ3sxVMZ3u/sBFiVcUzRqI7mMaqPtDDInnr5k3qCdU5FsnVrqyWZT6rrenV
 sy8WjgqjD952g2Mx0PC3NNos0FvJKH7yJhl2+9YmsyXLlSKVDK/CV+o1vfwAA2cjoC81
 zZbvw9jVi8cm6BhuFjPpWNO0f1+Ss0LSIL2azJHrFX4l4gzRhG2pYcaR1FasOjOxb+RG
 JeLA==
X-Gm-Message-State: AOJu0YydmAROC3i/c7Xt2kNjHTrpKvC5HgkLRTEVggvLM2r0X368Oum9
 e1GE8mMmz72n99ERkxR2MYh2ELsSMMtyp3XcINOSu1ChfLoqTQS8YHVj5x/vsFoAwiewQFcs9yn
 k2BADzoXX1DmxM6AZilz/YB0wMINEpZDDY6pYL8UY5g==
X-Gm-Gg: ATEYQzzN5RzkEFmZAYBNUMNXzLiUfL3x4PWp8J6d+od3j+kolxt/6qXrkBf5VS/s0dW
 Y5GanzEhkAkWyJNVJLMbCL45wKBXo0fyZK382VydIjE5qBDvQutohW42PL/E1rryYKWW/ZAJ9s0
 mP/axsbeLjzTsdTeWGn0Wv0KAFwUNxSV5E5oN5JTO9+fP4gzah2AqRWusqTc2eTM8PrhaG5osrK
 Ayj9K8YUIqrRy8s47Pd4LIaLCY+ghOm01eJPdbBOs9+MCl0GSp2JTXOTC+FPXz4kTMaP6oG9tjt
 Z8bAD5838YS52JnJqWAaq+dpj/5ZFVzD4xIrPiQUtDZRm4rVjD0NmBfXgINKwoPgwrkeFItusQz
 tDQ==
X-Received: by 2002:a05:690c:385:b0:79a:373c:107 with SMTP id
 00721157ae682-79a90aa0315mr137772517b3.12.1774285939204; Mon, 23 Mar 2026
 10:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260318174522.87902-1-sw@weilnetz.de>
In-Reply-To: <20260318174522.87902-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 17:12:07 +0000
X-Gm-Features: AaiRm502k7P7ZrbjeTCpd6UvfsJjeozmxOau-WnLR5rw4Huae0ymBeWmMLPcHlg
Message-ID: <CAFEAcA--mf5DoEkvPi+9M5zHhxhqOScX4hWKowcR49zE5iwFnA@mail.gmail.com>
Subject: Re: [PATCH for-11.0.0] Fix include statement for u2f-emu.h
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 18 Mar 2026 at 17:46, Stefan Weil via qemu development
<qemu-devel@nongnu.org> wrote:
>
> All examples on https://github.com/Agnoctopus/libu2f-emu/ don't
> simply include u2f-emu.h without any added directory.
>
> The additional include directory does not exist when libu2f
> was built with meson.
>
> It's up to pkgconfig to make sure that u2f-emu.h is found in any case.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Hi, Stefan. Could I ask you to try a tweak to your git config
which (assuming you use git-send-email) I hope will fix the problem
where the mailing list rewrites the From headers of your emails
to "Stefan Weil via qemu development <qemu-devel@nongnu.org>" and
then when a maintainer picks them up they need to manually adjust
the git commit author line ?

This is the suggestion that our .mailmap has:

# If the mailing list munges your emails, use:
#   git config sendemail.from '"Your Name" <your.email@example.com>'
# the use of "" in that line will differ from the typically unquoted
# 'git config user.name', which in turn is sufficient for 'git send-email'
# to add an extra From: line in the body of your email that takes
# precedence over any munged From: in the mail's headers.
# See https://lists.openembedded.org/g/openembedded-core/message/166515
# and https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06784.html

Hopefully that will help...

(I don't really understand why our mailing list still does some
address rewriting -- I thought we had configured it so it never
changes the mails any more and so shouldn't need to rewrite senders,
but a few people still seem to have their addresses rewritten :-( )

thanks
-- PMM

