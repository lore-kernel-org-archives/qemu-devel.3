Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D88C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 16:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD5UC-0004HL-Hn; Fri, 31 May 2024 12:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD5UA-0004Gs-6i
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:52:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sD5U8-00079I-DI
 for qemu-devel@nongnu.org; Fri, 31 May 2024 12:52:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4212a3e82b6so8935225e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717174326; x=1717779126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5As9vLHkS2Qh0UJXdiuXk1ypG4SLjcStHRxN+UfbFlA=;
 b=ooUNHhs6lrqPOIEiYTFk2X/YThIN+gfqbCdmJpkzShjx0Dn6b/tOpGfH4G6Rcz8rB+
 jzkDOPu297Ti0g9O9A6UoGu2pqdIt4ehH+4QYiqLx5uZ8838CKxNRXhRDjKNUo8/lUsw
 nytSrQNmOPmW1qhKVE37d7Rpj0eBJVYOXuDSL/74K1khJCa4HI9/Fi9LDoaqxQFM0bij
 16SJN3v2XOK5UmDpzrOP2gLLCOA5I0JBtx6/8YX0QBREzOtGwn/bLaTPYDDcT1IqCa3o
 sGTPXqS8dZhhPI38bkQR3XmryNCSjNuwzR9cVJ5a1jgHps7P8/w9pvt3oRwRvA7XXP5K
 Dmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717174326; x=1717779126;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5As9vLHkS2Qh0UJXdiuXk1ypG4SLjcStHRxN+UfbFlA=;
 b=BnKDnhOKTxDI9oPVNt605Oo7S9K9KjzERb1DxIytl7YEJyWWNuRRhSfcmUeQKUeXhp
 mUioU40FZMSssjpe8iTGg9pg+OMOqZFdJX3Iv7JGP1V8ggsXUxc+8gstWAb9wXBd6Bkv
 t+A6/atnP2hQZ37iPVID2l/V9fzsvOfxdHr0PaMzs4HdJ1uaJSvPKhGEaywwK9qjDxtQ
 6k0zagVQ9Z+nossbV8SoU4dKByUAeq+knISYzdd/gkBru0HOvhYhtVnE8gy70sWGhB8k
 pWdzLHkfHhvAw2P+Ehls+F8Tyn2InOnQ10N/84siR+xMsLFy6iJnNtYsLoKff3WXCxFi
 OQ+g==
X-Gm-Message-State: AOJu0YydG01fr59cUc9F294LQyFkzFB2rOAQsFpxeX461T/MsSaT/J8g
 LZiCm6mvcKf2IN7NGYpSvnG4pVDdD2MZx7gyRLzIFb3iXaq7FFNnbXixKePM/Ak=
X-Google-Smtp-Source: AGHT+IGPbDSWeWHAoL/cnLDWRH7KaL8lXpSTNp6CJrBxjU9p1NxbtF53NNScqQOwU/44wSZRBpZv4A==
X-Received: by 2002:a05:600c:1e27:b0:41b:8041:53c2 with SMTP id
 5b1f17b1804b1-4212ddb68d0mr24213795e9.15.1717174326151; 
 Fri, 31 May 2024 09:52:06 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421292205ccsm51688555e9.4.2024.05.31.09.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 09:52:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CD3E5F8A3;
 Fri, 31 May 2024 17:52:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 3/7] accel/tcg: Return the TranslationBlock from
 cpu_unwind_state_data
In-Reply-To: <20240416040609.1313605-4-richard.henderson@linaro.org> (Richard
 Henderson's message of "Mon, 15 Apr 2024 21:06:05 -0700")
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-4-richard.henderson@linaro.org>
Date: Fri, 31 May 2024 17:52:05 +0100
Message-ID: <87y17papqi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Fix the i386 get_memio_eip function to use tb->cflags
> instead of cs->tcg_cflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-common.h | 9 +++++----
>  accel/tcg/translate-all.c | 9 +++++----
>  target/i386/helper.c      | 6 ++++--
>  3 files changed, 14 insertions(+), 10 deletions(-)
>
<snip>
>=20=20
>      /* Per x86_restore_state_to_opc. */
> -    if (cs->tcg_cflags & CF_PCREL) {
> +    if (tb->cflags & CF_PCREL) {
>          return (env->eip & TARGET_PAGE_MASK) | data[0];

this has a merge conflict with subsequent changes.

>      } else {
>          return data[0] - env->segs[R_CS].base;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

