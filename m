Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C11CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScM1-0007Vj-Pn; Thu, 28 May 2026 11:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScLz-0007VS-LL
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:08:59 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScLy-0003gF-1J
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:08:59 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-7dc93d02916so7587047b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779980937; cv=none;
 d=google.com; s=arc-20240605;
 b=bUuHmhccu7VdPK50PhKXvJdQuVjhX9WP4nnzxmVR6lGu4vX/7VIe1Wp2jx5bpq2BYs
 x4VcGy7+cygVzJ84vLs718GIJDo2gbYSzxU/gH/y8Tby/SiHoqJkGYZGhvGQ7JKFTc0K
 O+7qVSQDKiApSv52PkFWn1KL8Eb9Mkq/JQcS+K/mBFobN0nNxkxbSPFKNzBgfvoRMR+Z
 vT1jvSar4grvB1U9gZQX2BQknDvdNMf530x+hjBUWUJLpswI0Hd0Gh18TB1wtythls4V
 SpLJrsMc7EJGqN2Jj3fuiitGG2EtLUIKBgZXJpToNFo9W3uaO2PZyxgktjKO1yK92kGa
 WH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZH+Pr2gCxkUA8KclhiyGn3ySabYvxbuLNcuyTXCLJcg=;
 fh=Q3krpAQIA0wAxp6tS0EmfBAbNCwv1IVxVd0z2YXKEao=;
 b=aOHIu3eg8kazV3OfMr/03RRH3K97OUEXb2pBkHv2q9igULeaPYW7lB1oITHo+fD9i2
 eYlvv/G9io4EHEiWsjYjQhluYx55lwDe0xdzxNFVrnYH3xCrv5iBAllsaOnRHEhFHtw6
 iP3wK8z+81WKPNaZiz2/w2/mm5jKYrCxFntDMZYS6/flGxa26Xe0edgXzW8qnK3uErqE
 CsfHbpZg5TCLrZQLqlas3TN8Dvo/uiRyo0U8CZ1usa5EHrVsOLNaxOCUeDeIAXoXJlBX
 RzHQkKGTzDZD0rz+yZKfzFm8a+hpLggB/mgNI0cpB6VzcMQknLLkAbRlPdTe3QH1XipZ
 FWVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779980937; x=1780585737; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZH+Pr2gCxkUA8KclhiyGn3ySabYvxbuLNcuyTXCLJcg=;
 b=IGAiBfPXaI5TMRTGAxGLTkdWRJXh18VXODX8pH0uew77gvJ8nh6B3js7mv8coLxJH2
 Mk7LitrAwrruQF8VmjILuQ1ZoQIwsoITzlnXVAUfAYF+fonnKTx8QpEuRIMpz0SxTyjS
 ert+Nx9Dg6u3UJKppybolOInOymCjI/tg21qRGOHq2b2KXK0+qjf6kIrGf/VQErx0Pxj
 QazY5pQCUX7pNDpnmOifHyYSi/AxSDUUxpJJl1R+YhyXIOw9hZPtZ2Funh0EJBLJzdef
 beToslwGlcjjt/34499/vqYIv71C/klwvQVojnvqwW3oe05DdxHH607cWTEOnmOlbnKg
 crHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779980937; x=1780585737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZH+Pr2gCxkUA8KclhiyGn3ySabYvxbuLNcuyTXCLJcg=;
 b=NFwnun4Y7AiIRAIPfm0V9eEhn1vdTc32MkQoevxw0fR4HA6cPG0Bwe6nLV9K1WOQe1
 FZFQTNv1RsfDKENrFZW3h8g3GR+LmbcbWLfIRzTLh5cAtJAz9eom65Oxdixegi0rv3sX
 AYYkK1x9AuouUBJ+g/VMquPGrrAeQldNASg8sTShmjruKhkaj58+R7GTHlagYB4Pxo+i
 P/5g15CSXtdwWMT3/cWawLJsMWUI8p7cMhOE38pdNEjUYERLLGhFRM6XE2t1Gv0VEuve
 fteDo2CCG/3g8Y2jVpleDOflxq+6pPzmq345ZF5tbIZi4ZsLZpxm08RVEMcA3XVJUgfP
 gvoA==
X-Gm-Message-State: AOJu0YztQi+rR60yt3uCv0jY9mExg/EZfwAvqDffR/UPoztNOdn2KtnE
 qolZ8IkGhoFSJNpmHYyqbUL7AjTrL6D7UI5iuZnThWFtMJCDTISvcOBzAund8bOEmAHR/Ta2ES4
 x3l3dF7bmmgG9kR3NXuF9zKRedzfnsZfwbxWKU4zyDA==
X-Gm-Gg: Acq92OF5673xYGsMl7RwcYtBjPnm7ZjDXBeHfHKYefp+VxRtvFIW22b17LxEGmZ8omt
 48mQ6B/PrJPkkOfO/PgTAjDm0KH3+la2ZhnbcUbWjmXr4C3jgISPEBAD5gNUwMwnPGycjC4lR5x
 hNBUYFhEcfmklanvN0x3o2kkEJA3u6jIOYBRq+jljvzh1nyp3ulwjxDAJi5fTz6yhimyY3BUYXe
 KM6owTEifLCLUsgIkuuXYX5DeN2tuB8U0ubfYDgyXgzX5oMJn53X+ExGW1tXKw6rPg7qkrR23NH
 MEgrFNh15KnvvJuSu5FqNIGacrahzkmiRbJdWhc9co9/D1RfSUMjdQVgMlTRLiKT7kFKVbXP0a3
 sgQ==
X-Received: by 2002:a05:690c:6982:b0:79a:daf7:c4fb with SMTP id
 00721157ae682-7d33b44d216mr290968997b3.50.1779980936798; Thu, 28 May 2026
 08:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
In-Reply-To: <20260511-feat-mte4-v6-0-8557cc1313b9@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 16:08:45 +0100
X-Gm-Features: AVHnY4IrFnMULkPvEJHqjIRbadQy4hTr57kVoMRxxpQGeVzzBA9-uSHz-ZVWP6A
Message-ID: <CAFEAcA9J0DVUbgKviEjwEN8K0M2aAJTLaOpkndus6HNCPNRH0w@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] target/arm: add support for MTE4
To: Gabriel Brookman <brookmangabriel@gmail.com>
Cc: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 11 May 2026 at 15:01, Gabriel Brookman
<brookmangabriel@gmail.com> wrote:
>
> This series implements ARM's Enhanced Memory Tagging Extension
> (MTE4). MTE4 implies the presence of several subfeatures:
> FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
> FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
> currently implemented in QEMU. This patch implements all five.
>
> Testing:
>   - Included for FAR and STORE_ONLY.
>   - The MTE_CANONICAL/NAT test from v2, modified so MTE_CANONICAL is
>     enabled in user mode (removed from tree in v3).
>   - A bare-metal testsuite that sets up page tables for S1 and S2
>     translation, to test the Tagged NoTagAccess fault.
>   - The bare-metal testsuite also was used to test LDGM and similar
>     instructions not permitted in user-mode.
>   - The bare-metal testsuite also was used to test the mtx related
>     patches.
>
> Thanks,
> Gabriel Brookman

For me this series causes "make check-tcg" to fail, because the
"mte-10" test segfaults:

$ ./build/arm-clang/qemu-aarch64
./build/arm-clang/tests/tcg/aarch64-linux-user/mte-10
qemu: uncaught target signal 11 (Segmentation fault) - core dumped

thanks
-- PMM

