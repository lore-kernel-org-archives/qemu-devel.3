Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD98DD73E80
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 20:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlYg8-00066M-UX; Thu, 29 Jan 2026 15:31:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlYg7-0005zR-PF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:31:47 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlYg5-00056D-Ne
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 15:31:47 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7942fca0da6so11080687b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 12:31:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769718704; cv=none;
 d=google.com; s=arc-20240605;
 b=R+bIG2sTFaR3i5+yg6dydcfHb3+o34TxpfVoBED+Qto9jnt7ECPkU1271ktvSBfXJ7
 EuwYjtaPB0GcB4hbKYUk01fNB8F5AeumnaCZeCbK8/u2gV7sYC3ZLSiuUW9qp8LOeSHE
 Fk+2DJkW2fsGc2Ak7cUIPv26YDmOF8AIHSTEGOs2lW2n0u1olOniImx4Z744L39KaB2u
 IjHW9psDUX+2SIWVGFcHYQXLyMxUN31UIAjxvQZXaHXU5tLYy1tTZaTmRx/8tPnPmdCl
 4liJgrZuL1hMnu5Qmin3DUsXVskpQrBFzrd1uNLNgSFDhxSYsYKx0m0gTvShEodDjUMn
 gXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hGId40o3Y7yt+Eg2A4YaU4spngMhWh/mLiGEb0g1YEM=;
 fh=Gh+6rPnJCKSbUGceG2NZ96F++VbNzWbngnEyCt5Duqc=;
 b=CK1uoeZpkJpOjiGkfUW/Un/bmLcYLySEzv0L/SH5g7e020fNZKDMYqsXbpZchF7Kip
 DegxE+WC1R/AcSsMjxdkF18oYdHClsVE+4Np89d7kOpeA4OIASKGxtLSY2tpiLYWQK0D
 D8lmUzqlR9eIlWK5W2xl+YmXcW9pSmN9weAFU82vrT2ORUBp1xLF9NlK15K1fyohHE9I
 smPF1jokrQDiBwXNvXGYCfPAmkU/TidtB9BcjuiPPpp2OifueJtz3RaHl8L6Y3U3YLV4
 QbTO3OxWD5phXJIncHEuqipqaSOoAeUC8aZEtsSRStywkHQ/prcNmucXHdoy6ejlazBZ
 iZxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769718704; x=1770323504; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGId40o3Y7yt+Eg2A4YaU4spngMhWh/mLiGEb0g1YEM=;
 b=uUXfJqYd/hpLL1BkHCn22OuUSybeAIMmjFLQsHOWhUb9hY7uDQP/cviaTVWfkLs8hA
 DnksRsILTUqOdUifInAD7fTj7chReZrGtPMZ9nXVhNsX1uGDAJHAHxhA0D1bRRsnnQxE
 Tp88RzPgMJD8uTX6L/eTTEQaZr+7XydQSB6WvSEr9DqFljNv5I8TXc0uN5SmN+sgrxT1
 mOEH8HnMNCf8Uz3y8pbEHgfAiDv2vg8arcryKDo18KQNjrCz/u+gjk/YcN0t0OKU9u7p
 Zgs+S2sUDeLbaA+RA4giat0/NAOQY+uJmA95hbYWTcEGbz2XzQ6yECklDYmhgaPrCGcB
 +AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769718704; x=1770323504;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hGId40o3Y7yt+Eg2A4YaU4spngMhWh/mLiGEb0g1YEM=;
 b=bEYTN7mdYak1ur2Pz0xRfsGrRREKqnOYPPUEK5p7B4VSjReCJHhgxuo90R/UJUm4Vr
 aKdV1s7LeAjHWzoSq98h7LUQ6QnCkaqz7DVewWIE01XKqR5qbhSGZttHsO/l3D/O0d86
 76AxNdkMbROu0g0hRCxq/mqkcrVejhDA/aAul/bavNDtlQ/PJHkG8EK+xbRWZIaUumX9
 FG+mMtXVwUrm/Q79iYysszDayBTxVk5nOQV1v3Ia8bhnwV/k1kCTXdnp/55MiJcgzNEK
 S6zQGTNttxYa9Cm8Qe4+/2puu8JSpoyE2qieVOLzw5UZwMRQ0dzw34ymJJU0Vn3UeRyI
 jsOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVodhHQGtAnSD9dLvKWZCsZnAO5MJrCqSk5cHmvMGmDYceA6dTXXyKSjlIB1w2lHXK2FsUGd2BXkI61@nongnu.org
X-Gm-Message-State: AOJu0YxCH8XmhbpfhwxmRM8g504kSFsTbaL2xinF0b6/RdocxtUWC98s
 x16nFh1o/mXLef4KOSqdFSoSw5juKyh9tufFBC8GnbktWc22NEKYxAetLUD5cx1+NyxSU+JUIRq
 ZXNSB3N1I2KiT6yjcbcTCfYZjMIlqyS2UOkDTSteCLQ==
X-Gm-Gg: AZuq6aLvVXpctZgXErE4le7OMzYpxMJwU5lOlOljy/8iwL/eJlhunDcuopUBxSNAbqU
 vGEWyKmCkE8J5UtkNFKkewRRMAmSSw8PZbCN21TYXOApebDgpEJJLzg1T5X099KO8j/FBwh6OP3
 0Dus5QWGGvg6LYdxGHmG7aoIcW6gQpprdFn0XmElb3t1PP4XgSnQiRUDf4PlX9fTDxbEGLHguq6
 JBJwI85Oz1rcjYQWL+7niapLtk8fpi0XPXqgprCaTMSpWyTH12OYsaswBv7zsnIc7xE+Q==
X-Received: by 2002:a05:690c:6c8a:b0:789:6c45:5df with SMTP id
 00721157ae682-7949debf6c4mr7771317b3.23.1769718704133; Thu, 29 Jan 2026
 12:31:44 -0800 (PST)
MIME-Version: 1.0
References: <20260129190444.225306-1-rkir@google.com>
 <10b26b57-bcd6-4853-9e2b-b8410b404806@linaro.org>
 <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
In-Reply-To: <CAOGAQeqsvEDMy4EURsWNAmRF1ZmSfmj0+s3LzxSEw7JZVeCdTw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jan 2026 20:31:32 +0000
X-Gm-Features: AZwV_QiHB-fe4GNRxkADK9JDXe-tvJPvdU2gj6cDDLr0WG5NBTxk6-_t9L7DjZY
Message-ID: <CAFEAcA8E5RZ1ZRy2dETG_X20dJPq-E=uK9=wvM8oUn897gj2Yw@mail.gmail.com>
Subject: Re: [PATCH] ui/kbd-state.h: Make the header C++ compatible
To: Roman Kiryanov <rkir@google.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 mjt@tls.msk.ru, 
 whollins@google.com, jansene@google.com, jpcottin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 29 Jan 2026 at 20:26, Roman Kiryanov <rkir@google.com> wrote:
>
> Hi Philippe, thank you for looking into my patch.
>
> On Thu, Jan 29, 2026 at 11:23=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > On 29/1/26 20:04, Roman Kiryanov wrote:
> > > This patch fixes the C++ compilation error:
> > >
> > > ISO C++ forbids forward references to 'enum' types
> > >
> > > -typedef enum QKbdModifier QKbdModifier;
> > > -
> > > -enum QKbdModifier {
> > > +typedef enum QKbdModifier {
> > > -};
> > > +} QKbdModifier;
> >
> > Yes but:
> >
> > $ git grep -E 'typedef enum.*;'
> > include/hw/misc/auxbus.h:32:typedef enum AUXCommand AUXCommand;
>
> I also grepped through the QEMU source code and saw other examples. I
> limited this patch to ui/kbd-state.h because it is the specific header
> causing C++ compilation errors in our project. I hesitated to touch
> the others to keep the diff minimal and avoid changes in files we
> aren't currently using.
>
> Currently, QEMU has a mix of incompatible and compatible (e.g.
> block/block-common.h, BlockZoneOp) enum definitions. I think,
> everything outside the include/ directory should be implementation
> details.
>
> How would you prefer I proceed?
>
> 1) Keep this patch focused: Limit the change to kbd-state.h to fix the
> active build breakage.
> 2) Fix public headers: I can send a v2 that fixes this pattern for all
> files in include/.
> 3) Tree-wide cleanup: I can attempt to fix every instance found by
> grep, though this touches private headers as well.

There is also option 4:

4) Don't change this, because QEMU is not a C++ project
and it's not a goal for our headers to be compilable
with C++, with some minor exceptions.

What are we trying to achieve here, and why does it benefit
us as an upstream project ?

cf previous email thread from 2024
https://lore.kernel.org/qemu-devel/ZnqPpqfBxlk9tEdX@redhat.com/
about "drip-feeding" of this kind of patch with no clear take
on what the end state is or how much churn it's going to induce.

thanks
-- PMM

