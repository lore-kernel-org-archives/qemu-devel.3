Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44206CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1o6X-0003qz-O9; Thu, 25 Sep 2025 11:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1o6V-0003qb-9P
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:41:55 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1o6P-0004ra-6D
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 11:41:53 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71d603acc23so10691687b3.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758814903; x=1759419703; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tvWNGS/s1fVPZX1n0yonShFn4S8GuldVD8xSrjMnvXA=;
 b=PCGDmdQY68SJ27UXQRuhWjnyfiDHEa/oeiuiWfjJly2Tvlt0hPkC0UEXI+K7tsk8El
 4XeqNxzTNAW8YqwjMIqHve/wLieAbdvrQ/LKLruop89wCxYj4ycH8EgBTAQ5lS32WkGx
 e5lEU0YUHBXwaoKnMFkJEwHTViWCfWUPuWf7oRH7Qd8gHw1aOyBr/+V4weVbn7IqWbJV
 4Zpkt4x1VGqx5r6JtAQZfbtD1ta93fTO7DnSbzy7dI0Qb0Uf6EZ4XY+ABksrF6RgpFaU
 BZWPcOAEG7QQhuSMMiqTQEJnRym3EQalAsWMtR24LCUP1TLdWJhbWV2q18nEFMbt6M8H
 qM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758814903; x=1759419703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tvWNGS/s1fVPZX1n0yonShFn4S8GuldVD8xSrjMnvXA=;
 b=aPCMQPGjrmXflTGUdl6gpaLT+Jw7Q+GeKTihvmg6VzMzFvfHbqBntnbRrO8UDIpzsU
 Yq/X0R5QtqW+jlg6nSr4BWfz8CcnTE6J98P/siVsf+gT9IswhxGJNB0S+dulX8y6Ao5/
 apCRVhR0/rJ7d6LSpQKRmsv/hNK/a6gNSoUYCotjwwsM5v2wfknyzK+xUBkI77PAeI53
 bfx0zzvPdmFj1ow2OzhFEyOhQU1+5uEYrapyT4Fai78eiAVn5LeXOyBLb9Vw4j4i4nRT
 VjEd2Hi/iSD1wl5N1YGMIpOe6s0x6H2KZ+4axfFWbZ2BLNG6Z7rX1UFwa2KTVR1bVA8T
 83HA==
X-Gm-Message-State: AOJu0YwJ3xZy5ItV0wrzwz9DK7VarAh3otOt5a5+ySZaf9Gs8GXK9rku
 v2duytK7bVTc8p1zznyEkGQv1W4ZuncgOpnZ7EiccsNIxIeUt88E1JNiVqNurxKq2UOUKIkEqJ1
 4nbdKo3c0G90VC0d5XZng3rFEX0ovdFHFQ0qxjQhDEA==
X-Gm-Gg: ASbGncuYSWgYTiP19tXb3fQ85yFyST3Yzz706KVr1rXPz3D0FsRBDWwnvSAnpRruYYM
 zC7WrcyXdLv9r/Qx+SXa/iWSVlina65XEHDu3/PlbkGpN46PqzQCzwloUgZBNPckBAu1A67KdAB
 /aeX9SaJ6m189CGDK/ylSiV97PSmiWe1ZoV/FBBbvV0WzmCpgz4t/Gs+lLFudDzMAM7dpRjTEy4
 JWs3N7A
X-Google-Smtp-Source: AGHT+IGQcqi0MAvuzXquRKNN/MWKhEkZH94Bwp4Cj+quYa5IRywgMje0wToF4sMTybgKTrqUd9jPdGEPsntsj2Agns4=
X-Received: by 2002:a25:e087:0:b0:eb2:5e5c:1740 with SMTP id
 3f1490d57ef6-eb37fceb9ddmr2704333276.52.1758814903275; Thu, 25 Sep 2025
 08:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250912100059.103997-1-luc.michel@amd.com>
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 16:41:31 +0100
X-Gm-Features: AS18NWA8rFWinkLk4XjFqxDDBdBdJ78U74wgBPBwGapGRHSAMW6t8p3ZQ1kF2wU
Message-ID: <CAFEAcA8L-9hMZdMgvJLottXFs=ys9uNhmQk-3GFR6QtqahU9pg@mail.gmail.com>
Subject: Re: [PATCH v5 00/47] AMD Versal Gen 2 support
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>, 
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 12 Sept 2025 at 11:01, Luc Michel <luc.michel@amd.com> wrote:
>
> v5:
>   - Patch 36 (xlnx-versal-crl versal2 version): replaced `return NULL'
>     with a `g_assert_not_reached()' in the versal2_decode_periph_rst
>     function. [Phil]
>   - Fixed remaining memory leaks in the Versal SoC by adding a finalize
>     function. [Peter]
>   - Patch 39 (cortex-a78ae addition):
>      - Switched to the last r0p3 revision.
>      - Removed the CBAR_RO and BACKCOMPAT_CNTFRQ features.
>      - Fixed the comments referring to TRM sections. [Peter]

Edgar: are you still reviewing this series? (I noticed you'd
left comments on patches 1-4 so wasn't sure if you were
intending to continue, or if you're done now.)

thanks
-- PMM

