Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226B2CD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9la-0001eY-1u; Tue, 09 Apr 2024 07:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru9lX-0001dd-3e
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:35:51 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ru9lT-0002m2-J0
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:35:50 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e2b3e114fso5272649a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712662543; x=1713267343; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cSxRDMAliphU7EFGIyy5nGjl1rH8YLGIzs4T7Ruv+5I=;
 b=WSwdy31VP4/oS7sXh2kuiKSfmcewy+B0y264k2C+WPW0m9rkCo0Z/QCxJmuFejTitb
 ODwfBcg/VRcfP3pAfe3DOK2rDVcF5Fd683Ja08UJQhYEkARLMEDxevCdFQTwu2njRlmn
 lSzF0G4NNfC6dAGArpsj1oPQvA3BLGAXSdNF9wY0xixI6K1sIZaerFgMI34NrdNS/JD2
 XOl/2AZXmdhRAef4NesWg+t0IHnuPhM3x7NN/GQX7OJTeDSJgNpGmlbxuozC2VTu5+Vf
 4cdsBvLVOaZIspdVMf+lkas8eiKM+TDnXKu/bHr3hHpNWwJF+I0vuBxpaZuNKkNIw7hu
 88yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712662543; x=1713267343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cSxRDMAliphU7EFGIyy5nGjl1rH8YLGIzs4T7Ruv+5I=;
 b=RxOF5jqXErguc4Bupet2uof9flSLN7HrMKqifnVg3fMjeARgTN1EeRDWpI1KVmYmN8
 Xa3dJT4TDCFQNPBXAGTHRMZzi6rk/Yoya+V2F6ejlCx+ZGtdyYyK4QCWNUmKEOaTyqCD
 Qdt/LmFkm/bizeGbCmNF3ZsNgrk53YGXLob5ce9VXEUVN56JBOVRbQHzJ4M55W+S1x27
 PN21tbp5wtPqxddptplVAhKZyki+ktFSU+cxApK3CeNS/hsZ2dl4u8hgXFnyUIaNmQb7
 ViAjRA9AZKB1SbF3XXtVJkCfLEsxXx7IQmMo76VwwMCSZ6ocP97ezC3+paCHt77g2MeY
 anUA==
X-Gm-Message-State: AOJu0Yy63/qAN0PTmf1XkGuB0OrOD/ldZJmih6X5sy6zTe0us/VBJtnz
 EcxTLn13O34bDu0CrNPeRCBKNLa/VPFgDz1dw0fAlFu4EVuOLOdZ6j0mb0B7H5434dAXBHL2r7F
 Ojz90ihSIyEWiDd/8pv9cmqnTe8rumRFpTfvahw==
X-Google-Smtp-Source: AGHT+IHeFU2ES8/DXKJRuRPL8IRqoSMs8BQQMeoePJ57t9oIbuOrP59DZt2gAMdPbzgC6WRLTxNHqx0tqn1t4a1SVTY=
X-Received: by 2002:a50:d60f:0:b0:56e:2452:f864 with SMTP id
 x15-20020a50d60f000000b0056e2452f864mr8691780edi.35.1712662542799; Tue, 09
 Apr 2024 04:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240404085549.16987-1-philmd@linaro.org>
 <CAFEAcA-nrJc_WqTgw2uugqKoOdfoF8-NiKwftZczk38_XR5_CQ@mail.gmail.com>
 <CAFEAcA9iLiv1XGTGKeopgMa8Y9+8kvptvsb8z2OBeuy+5=NUfg@mail.gmail.com>
In-Reply-To: <CAFEAcA9iLiv1XGTGKeopgMa8Y9+8kvptvsb8z2OBeuy+5=NUfg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 12:35:31 +0100
Message-ID: <CAFEAcA_A54DX2VHCq=GPjaJrG+V_UJrsvvZq6RafgHutwMOtsQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0] hw/sd/sdhci: Discard excess of data written to
 Buffer Data Port register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 qemu-stable@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 8 Apr 2024 at 17:42, Peter Maydell <peter.maydell@linaro.org> wrote:
> So another approach here would be...

That said, this is all quite complicated looking, so
for 9.0 and backports at least this patch is fine.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

