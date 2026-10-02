Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC27CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfG0-00035z-BK; Fri, 02 Oct 2026 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfFx-00035o-Fp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:33:05 -0400
Received: from mail-ed2-x0c.google.com ([2a00:1450:4864:33::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCfFv-0008Os-HV
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:33:05 -0400
Received: by mail-ed2-x0c.google.com with SMTP id
 4fb4d7f45d1cf-6acb88abebdso62269a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 08:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790955182; cv=none;
 d=google.com; s=arc-20260327;
 b=nCtBg2kQFbgmtraoPkwT4ViN/sXYzgSB8lGLE5sYBxDq6jGvrjnTLwmfaBVyB6Pg8/
 sMR57JA44g4pFNTl2DO2lClTvHBaeW17bU15yllM10S2n8OkxxC5bG/gs6UOnMFevhSR
 e49KbU8oxkfFNUrZoKSDmLQGileh5PSllgXhS4+D4VdLNuwq4LV9aZliq7tWISY+/53m
 Qe8Rgqw2+TxCs21JCNWHICCb7na6kSb59Wz9FPFZxmKneJ/kFMaR8QWSAcNU0ZOI1kH0
 NOvmhuJB8Q4R5fuvqJThWZOCI3w4pvpr+evWiSMDCFZVbQw5KL5WpIHbyYl/aS0jQlpu
 Kkfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lLOZhLFNBrc3vBBzAT5hGhq2WTtO+vjeRokjDOPds4k=;
 fh=lgu5DXaluqoheOb4+nP0lQozQqbjUeOmtzLYLd1zWTg=;
 b=PIHfsTPxSHQR5Krb+Urmc2p9t7YzoJ3z2y3iBZrI/9m0Ip+ABBBgNBDG7pYECz3gY0
 NJ7D5GSbj2gfJVosr0so8c4Ck+l+TMhi5VzipYWHMfKKJ/6Gw1iC5EiFqnvoD5GiQKQM
 l6W5nw1QGn+eyKXOQny0MMDFb7zNe8OFKt+mGovAjhFoQok0oz2KKrpM7mx5MNQ41JEP
 Bbo9LR6JQZS6MzW0DX0UYSUh5eAF3hFVJU7us/PiElvemiymQJ44DBSWDQZHNrVTC8PE
 NrJckt69s5DTskZL3QCeQ04D8j7cetT0H0EvHUgE7A4CjUqflvoz0TywQOrGkacCW40O
 NVHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790955182; x=1791559982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lLOZhLFNBrc3vBBzAT5hGhq2WTtO+vjeRokjDOPds4k=;
 b=Hzod83jcT4M618/GYw1uZFpf5yOz4yy4XK0f3HQnIyVyXXjabM4/r73xAFvDUwPMcg
 UU5D3zkfLK4yxCnXTLTqb8KbgiPqRhw8isS0tJU+i6k19tjgB8Ks0BmVJFX1SEnBHrZ2
 rhaNdAoTYt67NF3lVa1IZAWelKnCZRb3nCmnk3BAUyXmfhrD2eSpwzvioR/t7uHNN91z
 JhE3tAQ2RzNpo+7FEtoZ+MjQ4dZH3RZWo8WIBLsYgU0WM9ysbg0PV1IgbFgRD4EzBV+2
 vfXlnihpXUnndAE4S+bklWAm76TwxW8HoaHUjyUbFHWNpy77GCeqQAUK3hZd72RctSpQ
 6lGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955182; x=1791559982;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lLOZhLFNBrc3vBBzAT5hGhq2WTtO+vjeRokjDOPds4k=;
 b=KzZYkHR76wWiJC1EefkA8qSol0cuz+9+zF7q9S9cXXtQr6p4qSYyoe0sVO7CGh3BWX
 hkehqZP/m/PtY6gINdcOnmmgKcPWla8SnaD2BAGNHlc3kGzzgfrTKfavrfUxxXMkJZRU
 mDa6MN5FKKifd3Ej6/w+MlGMpYhjPiD6PUxb6lIYUY0N01ixMCc0McHY0t0F6+3p8ey6
 xoHfr/Q6c0tBlK2ZX+lLrZO1U0oT1cXoOy9huKnZfR1/Ox2TZlJ9UGvraTR2tyRs2yUj
 zHEW9XAhWTy1Pr5wN8otnV4PCqot+jZuxOthwtFDQ9SMPkadSbV+m3enzKlNR1XrzFnM
 KnCA==
X-Gm-Message-State: AFq9FYJ/eYxsY/w9N6fcvjWGX0LLyC4Ag2XV/Oe9XjND6ngEKST1yyrq
 M4EqmScjXnuMWHmY76o2WM8dAxLlguH+3X/Hm6c+7nwq7+scmStjeGvUWDVrZ7zxmzD4noV9VA8
 4VpoXR//pLkDmlSYezIvgXiYPYQxJ/LZ0yB8s2j4=
X-Gm-Gg: AYBFou031gLRz6c0FuDcKgbRELDpSPxK0ghRcQXCmdpdIdSpPjnX5c3N4+ApWD0s53T
 HxnAC82aCkeVq0I5TpdGeUzhA0zElOQEy77Hi5LvZaDPlC5Lw652HHDwMViZLcHt2LtcFMvm4Zw
 B5Zw68ujY9lj6OZEgQY5jHSwbZVrkoEGE17tUwYvR6DtRg+8DWZzcBikcp0LA0QIgeN+sFnu5rS
 /KIatYK0rcK2puzKF2tSF87dFJUXTBWEkHUNJEULJDTaH6AL1phj93XB4E0lljxQFPpoBEPqkyX
 JcnywUrqfwuxMX9rx8kvkM7MWQ9UnFSzVNF+f0FrKn6GetDbUOxs3IY=
X-Received: by 2002:a05:6402:434b:b0:6ae:19ec:c2d7 with SMTP id
 4fb4d7f45d1cf-6af9e2ee205mr1957632a12.37.1790955181698; Fri, 02 Oct 2026
 08:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE9X99kzBMWBo8rxmRGnT3NysHjf-GffC9X2796GGipUkg@mail.gmail.com>
In-Reply-To: <CAE2XoE9X99kzBMWBo8rxmRGnT3NysHjf-GffC9X2796GGipUkg@mail.gmail.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2026 23:32:48 +0800
X-Gm-Features: AclHuK_cO6YdcfRzEI0BPfa5Lu8eSaLzrx0S06zQgqGgnA0xpu9bNEgtW6fx5uM
Message-ID: <CAE2XoE-_8jpRaPDE+uYYzszT38XpdB8JJJyXg51Z0-GD=4gMsg@mail.gmail.com>
Subject: Re: [RFC] Target-aware machine inventory in combined qemu-system
To: qemu-level <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now I place this RFC at https://gitlab.com/qemu-project/qemu/-/work_items/4=
635
Maybe there would be a better dicuss place if possible.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

