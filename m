Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07366C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 19:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf3Lu-0000wi-LW; Tue, 27 Feb 2024 14:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf3Lt-0000wG-Bj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:42:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rf3Lr-0002mr-W2
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 14:42:57 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412a38e2adaso19962615e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 11:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709062974; x=1709667774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=JSbunR1cAXcQgXxOPCHi/o51V2u4peBNXWsRXE4CMVdnLLUvUzy3ukVrv4YWZKaQg8
 PK+mGxnxPOmR9E3d0vWoSTnnrwOYuhCyAn6+sGNKBb7FME8tisEQxyGkUlDSArYJ9FNp
 43OIh2eMoR6IS1usA86m7a7mS7h8S4CQkas0fWmGvdGVOt0jReBLZZIJSfpzqiKevQ1r
 wWV0Y7pY8bsvdxS6i31WsEDswosOsuGjvWAgfvljJNIm8KEtwUqVTbi0+tI/ScfIiGzV
 Sh1merMvvwjfMOZ/3wAs414IjDGur4yaStBIApByD1n9mkrMcR2nA0/l5wr5ijO5vGBn
 +FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709062974; x=1709667774;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=idwyTpwyKTgLovifEN/cWlCuJ/q5olQdW5mZqxbBm4WxRf72l/dkilIvlzUSou/vvv
 585ScV9SHoMHSOs493csJc+kPlwXZ5HEaLgXmtAmLQdlH9h8jfnzNXeHOV9xWCsOxECX
 zi6rF9WDopggg//23gaGElbLyCSlHpyctSgTDgsOREOTW9ytXLs7KbqEJfHD/aLCi7C5
 jsoXMazP1FnN7FAIPSSttA8rijpb0FRQZRwWTLsYwGC1B3uWjSdaHgenGThNdoUDaC/o
 cLxDmw6cEn9+ftwZx14Nc6lUoNM62VwZ93pFElZjlClTxXasfyeKt1VqOCHmcis96P9f
 V/8Q==
X-Gm-Message-State: AOJu0Yy2nTmWzIvk4WynLBWySryk/mCo5Uhuk7lUxOs/KNUIz66puGgw
 wSoZaiCEdlFJIKxcpK5wUp/q3BssFcGkSRr/OdWLuC97zAVz+QzBvnNea7gvzaGNBy5S51Jj262
 h
X-Google-Smtp-Source: AGHT+IF0hizc1kqLIiZuA2WenhWxnHqHbO4SLOJ9Vi7m9r/JQqx2G7pg49765nNDxSpkDZQqr1KIjg==
X-Received: by 2002:adf:e284:0:b0:33d:3098:c1f with SMTP id
 v4-20020adfe284000000b0033d30980c1fmr7877830wri.44.1709062974565; 
 Tue, 27 Feb 2024 11:42:54 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bt21-20020a056000081500b0033b48190e5esm12611582wrb.67.2024.02.27.11.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 11:42:54 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E539B5F753;
 Tue, 27 Feb 2024 19:42:53 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/14] linux-user/elfload: Merge init_note_info and
 fill_note_info
In-Reply-To: <20240227184833.193836-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Tue, 27 Feb 2024 08:48:21 -1000")
References: <20240227184833.193836-1-richard.henderson@linaro.org>
 <20240227184833.193836-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 19:42:53 +0000
Message-ID: <87sf1dbsn6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

