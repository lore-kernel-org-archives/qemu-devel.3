Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A95CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9c4-000387-G0; Thu, 06 Jun 2024 05:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9c2-00037t-Tv
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:40:50 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9c1-00084P-73
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:40:50 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a50ac2ca1so875762a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717666847; x=1718271647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5XY4eDgpMtBLBOk0U83HCS95c98UfpM5U0shIx8moTA=;
 b=lq30akjqnlbiPJtU9VZ4oAYt6KAJfe+TP0SnCj5/2Ah9loSmumni4u5AAMhtXvitmf
 2InIJgTlYfHViq4KpL5QOyMUeHv+bABtvfMMkWD0lYp7XoXkCRwg/FFRW2HNkJjOeAgA
 2btx4+zh0TIdEQTyiZG4EilRI/2MJS1ky8b7D9k4wrmnQm+XH9hESZJq6zjrPuptZGgS
 PzihSkPuVNew4j8kZKfgDEo7sRZEzGAvS0Kv1IpbnYoUnLfT1fs86dFBkwRWPEs6E2Bn
 K1Gxh1bdDfY0uxAgAIv3kpC8QU0NypBvRbYm+0WH/RmtLpHbOFvPf6qI+t93pHHDnnyG
 wT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717666847; x=1718271647;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XY4eDgpMtBLBOk0U83HCS95c98UfpM5U0shIx8moTA=;
 b=OvguvXaRcx3YHGH82Yx1ZjLRqAkW9EvrCU/z19YcZO/Xq7mk7C0ML7zrhF2b2khz6z
 yWmD5OPgWC7rZ7nIZJhTGpGdAHdHEosABm9qcXWkRokdt8E4d7n3UlfFHGYV6CGA3l36
 c6vpG/RY5nVjbPWwsyxvBEkkMzGzqidc8fZUGkm6ypIC1t1lfLWkjlC9lhmabcBnJu19
 Ew1zL1eU9VHxp8ja1Bg+I97pCe32y7NOYEn0iNjnaicIeDgbK2xU4Qo1TmIWX86EkMPH
 4fGSCVSBHIAyyUqqBKZKLd1Ua/UUKj646CbB+aUgK5smEnZ+VSUtdkbmMGZxgpmvxTOB
 tszg==
X-Gm-Message-State: AOJu0Yxnw/QyZWXT2E8dgq/g1sGbIKIJoO3F4/y8OXkeZG3gohqYD/Ie
 Hma6l2ilIVgdluycDQxwTwPn99imlmDfUG2cagwZ9NPc/TCAZ4Ib5THRAlQ4QWY=
X-Google-Smtp-Source: AGHT+IGHryAJPGs5JYRxw4RK1AscbOVTNxr36K02Br54Z4GankVmvb2ls0G/KIOcHTiedKkfgg8WnQ==
X-Received: by 2002:a50:d6dc:0:b0:57a:2400:6fb9 with SMTP id
 4fb4d7f45d1cf-57a8b6b7059mr3107125a12.20.1717666847347; 
 Thu, 06 Jun 2024 02:40:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ff792sm786396a12.40.2024.06.06.02.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:40:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 897E15F7AD;
 Thu,  6 Jun 2024 10:40:46 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 1/9] tcg: Introduce INDEX_op_plugin_pc
In-Reply-To: <20240606032926.83599-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:18 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-2-richard.henderson@linaro.org>
Date: Thu, 06 Jun 2024 10:40:46 +0100
Message-ID: <87bk4emmsh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

> Add an opcode to find a code address within the current insn,
> for later use with unwinding.  Generate the code generically
> using tcg_reg_alloc_do_movi.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

