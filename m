Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C90EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 15:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgnWn-0002hs-7S; Wed, 21 Aug 2024 11:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgnWl-0002gF-5m
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 11:45:39 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgnWj-0007iq-CR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 11:45:38 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2f3bfcc2727so49810181fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724255134; x=1724859934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLq8MHUDK3ra4Y9sqP7h06h0yraXqgvGgKRO9R94oR8=;
 b=KKntYQBxbxg5YmCnSGXqHtcbv2mi4BnahF83KQZJBG9HA7fjrmceAlgXZCM2kohwRX
 44FYaSJDh0I+ytDaNJ6qojI0ZgyuCnYGRTRrF5shVAEuWsLSwDYGMeafcpZPXTaza6XM
 f4YVSNMTE1BJGHWlKoOElVmSElEkkwdLTq9b0uWMxUzjS6ZYA+WJfD3ej1dvX4qyNV+f
 ZTpQdjo86rPI634gWE43vPs4kcVu4IL7xDB8TLu6S/ZeT3ONWbIh0anzelKSNFTuF5+t
 6FMtSMMZ3EhvEmPB7P31xvkGvZzBn2TvwtkMfEcpMFCXvvtShGyuEW0GAVXDNnF4Brzd
 3hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724255134; x=1724859934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLq8MHUDK3ra4Y9sqP7h06h0yraXqgvGgKRO9R94oR8=;
 b=AgJG7Qn5NuM/Zl0OF2q4DzMCHcX69Og935EK5FUI9dW4DRfPrpBsrvepvZiAokH7qu
 Z9CxapqOWFg5aR2mq5SqDk0h+WBufI9jChseeRdhIJMbt0HHtpl/VvEd0FGEcUbwdMxI
 AHvYPp1plOadK2zJTNiM7tJ6fEX9I5yrvX4G7osfYXp9FKcoX4X8A97lSM93alSF3ozv
 hHW/DmjIc3iXmA+3xpTcQgG4msWaEFkxkW+unLY5XdOaKa2iW4nVXYuRKEfWQRHX7Y3G
 dKkqlumY0xzkwG1WQtUrLLy4a36cPeW6Kj/wJ+qU/L4+vDy7mJWrGwCJGD06e/kdBYSl
 vwzA==
X-Gm-Message-State: AOJu0YyMFsLhVxK9NhAlQ6Bn2h6syM+KoXocyhGBGLFGUd+XM5L3OeIx
 4KeDIqfllW2beqyUJ0hzRJXTIemkFunSQ9c1oho2ONiqlb0usyVyci66lIVrREo7dSLZwH5NNbh
 eDVS2boPf/WeGtKUO2uguSVeyAdimb+ZztmEPeg==
X-Google-Smtp-Source: AGHT+IG9JSyALNSAWnw3MRGuB2N0lgnr40oxXJ4MWrllPizl36K2KMMrAYrJCn2rTmlPiEXPSMPuzQPQbm3p6ia2/34=
X-Received: by 2002:a2e:8017:0:b0:2ef:2f9e:dd19 with SMTP id
 38308e7fff4ca-2f3f87f158cmr22979331fa.2.1724255133911; Wed, 21 Aug 2024
 08:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
 <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
 <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
In-Reply-To: <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Aug 2024 16:45:21 +0100
Message-ID: <CAFEAcA_wpbEaX+iEz7syNd1tB7A77UVT75vzups=yZogJmiEaQ@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: =?UTF-8?B?UGh5c2ljcyDQndCw0LHQuNC10LI=?= <nabiev.arman13@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Wed, 21 Aug 2024 at 15:08, Physics =D0=9D=D0=B0=D0=B1=D0=B8=D0=B5=D0=B2 =
<nabiev.arman13@gmail.com> wrote:
>
> Sorry for not providing enough argumentation for my patch. I found a conf=
iguration where this error occurs. Please take a look at https://gitlab.com=
/qemu-project/qemu/-/issues/2522.

Hmm. I don't understand why fixing this field name would
fix record-and-replay, because I would have thought that
all that should matter is that the name that we write out
in the record matches the one we read in in the replay...

-- PMM

