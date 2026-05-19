Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75176CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHw3-0004zD-7V; Tue, 19 May 2026 06:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPHw2-0004yv-Js
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:44:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPHw1-0008Vi-2a
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:44:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so50427755e9.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 03:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779187463; x=1779792263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5NkfIU0TuaDxOuifhlhaWQvtm+pvv4YYezcr0hTWZf0=;
 b=VsXQwNTUpqs3i5fN5TAX14Fe6KXHLDuDYy2HQcV4R/8Vj86yRWNHN5bKiprHYEwMuW
 sXYOI6oncCayBV0O0CZBW7W3pWZrwZJRyAdt9cQJsK61664vcQNEHRe87se6tVTMABZx
 IhaaXXLozXnPHypG0E77go4iLYgtyzBhDdqNj9i0gGNXBlVI+3HKB4lBGes8lwkOgS+q
 MfhvW95N4ukBJ/maKk3pdwVm+MsqPm/cp+BiyiXqczR55phjqjl8KTeAhAvUNI212pwZ
 DwMC4frFBXp9cYUPRS+WAjAQkMKjhEjiuBVx+y4AoBs1Zq+sHNfUhpHFJlphBSoxzYlT
 LWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779187463; x=1779792263;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5NkfIU0TuaDxOuifhlhaWQvtm+pvv4YYezcr0hTWZf0=;
 b=o+LuabKmiuvLLm2fwrIlSGTFviwSvYdw1mYidV3vRBZhS+ASB4c7Nh1qS0Q8R3jCjQ
 ao+1chyNXTWcZ4TbGXmpE8dcyFSZc3PWZjpW+ixWkN93pqhUP22+a3TP6wszbxpasv7k
 TSkFXZ6jyxDjVV90QTggNpdcjmR7vuGMCdTnNExNDX5iu2HnJ/bYk0qorA/vWg7qeNMN
 JPhRzU37Zwhk2hneIq7DV4x3a20oTL0281SUsz+1vc3cYO5nBJc37hyqvCeo3redfGjv
 WIaGvK1xDi+TIcDH6otN+jlJWxOjPQDCfP0hTIxq5exuKTyFa6aMA2ma+yQYKvVKPwju
 vFIw==
X-Gm-Message-State: AOJu0YxbDclW0W/TG52m+SFATaBqStIo5yjuB+vcPV2KCstHdJcDN6G4
 Wbb/POSR8zndjAHAyDBY0D4BUiYK2GuhKDh4SNkiUD2ZUikbD3Rm9Z5rjt6oCWn/9rw=
X-Gm-Gg: Acq92OGEylQ6wCeXTm6/SqFTE4VUnx89uuy7nxTWiiAcIE0bsQRZyJ+q3eGfrEF5fh1
 rMdm0jKt/Lc/d4oxxmWAm8IsWUP/b3TFRDegRm4Mmqrmq3Y9yfm4y2nYkBtiZXQI4mVdcwYRw5Z
 04HnvnPCG8dIQlfr7hC4qLrHYwfoAubTTTuTd6kofclb5N5xmcISMkb2Y0abWYwiRXJrRnwSn6Q
 +Z8w2/lBL+5xpZ+QGVrOVzxMj7bSZWLkS6uEVUdqmOf+0FfElZXjkf6n2k7gnyC2TUyPjci4QLn
 Oq0PnPJ18AO6aOwLNgeCueSNLjUCE+NPh2JnO0npmeQXgya66Y+EUBGP2YtyPjDrNWXadVymle3
 /QPQcAc8jiIODMg4JPHj61rZdEtPjxVELJ/FRTHI9LP7wD1wW5gyNVwiMQYYKjC6F2PgYAxA4oq
 YlmJ1+7gFGH6P6iFWX8GmRe54=
X-Received: by 2002:a05:600c:8184:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-48fe60ee4admr290018745e9.14.1779187462983; 
 Tue, 19 May 2026 03:44:22 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5694f2csm320056325e9.4.2026.05.19.03.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:44:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D9065F81D;
 Tue, 19 May 2026 11:44:21 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 dmitry.osipenko@collabora.com,  marcandre.lureau@redhat.com
Subject: Re: [PATCH v5 0/4] virtio-gpu: enable Venus/Vulkan without OpenGL
 display
In-Reply-To: <20260423180315.53821-1-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Thu, 23 Apr 2026 15:03:15 -0300")
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260423180315.53821-1-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 11:44:21 +0100
Message-ID: <874ik3d6gq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Ping (second). This series has been on the list since March 17 with
> no review on v5. Marc-Andr=C3=A9 gave Reviewed-by on patch 1/4 in v2.

I don't see the r-b on the patch.

> Patches still apply cleanly on current master.
>
> https://patchew.org/QEMU/20260317182049.33848-1-lucaaamaral@gmail.com/
>
> Thanks,
> Lucas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

