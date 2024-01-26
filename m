Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F19C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 16:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTP3I-00046E-DL; Fri, 26 Jan 2024 11:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTP3G-000464-S9
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:27:34 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTP3F-0001e7-Ct
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 11:27:34 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e9ef9853bso12147535e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 08:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706286452; x=1706891252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bwHI28OMF4B+oCtt6RV+W6pZfIo8GRqjO7srKjRGhw=;
 b=xmB/rg9n99gPQlBVjR0vld0HaDqYXqI7r7YLYBTQED61cHJqX1GjadSWLRj85REDvr
 bTPgCDeQR598kaPqJIK/0CEs7D3+bSPsr9SsL7Kx49VFvckCDBqDuPHuTtF3UXNyAKTn
 2Ste78EIU8Afnhb3/FcZEsjgHJTpfL7ojv15SA9VuSSZia0pf6mYuLZLubvJg5OLXuUH
 KxvhPlX6YkfmbOLkx+9XjBtdP7KF2MAx6SpbV4z2WcqqYZZvaivF4vEQsuwvC6lfHuhf
 ipfjRNzj61crnsZMwh0r/avbB5nisn9wnLvZC/yhlkgVOiV+OPVWW0zOKMqLzgiD9kCD
 QWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706286452; x=1706891252;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/bwHI28OMF4B+oCtt6RV+W6pZfIo8GRqjO7srKjRGhw=;
 b=Ya32v5I/3phzlREgpqdgxgMYlOve0Batr/9oSqQ/Qwc7+TqjjsyvO9MgYqFu4Wwh84
 QWlvFrTJQv8BYpLD51kivOpzBeW3q7MoV9Jr12gEDe3boGFGawHwmtX9lbYs75BEBNxe
 jjzLhQEdU1+hkWKMAcQJpjEmOIMsmAgVKWZBMB0VV1YuBAKVbrRCD+qVAXYRA6l0c9By
 pCNTbVoJdSZdzwgdmz9t5hYOmPpThG4VwbJFk7SrdcM8dlVrnqzWEgFEv42zJv88xsND
 LQsCdjW7boQdc83PPi4WkiqWWosdW/M5ptb2hXehr4toCx1ib77UBSbomK+NzWEquBP3
 hN+w==
X-Gm-Message-State: AOJu0YyG3CSYL/PtPmdDypGypByfGZnUWHzVLAJVDtAn2kZvjZb199Ph
 MSAvyGiRVl008SWIYNT/Y1RvGMFJX5gfaCFMDXYCA3AoL+NRe/6dI8DNFBBrLBs=
X-Google-Smtp-Source: AGHT+IFO8R7srTiau4CanMVpjLJDQ82H2mZeXaNL+8su+kMlv7Q1NbzMAOZ7ytOSeUwQKRtfw/VZvw==
X-Received: by 2002:a05:600c:54f2:b0:40e:c4cd:8053 with SMTP id
 jb18-20020a05600c54f200b0040ec4cd8053mr48355wmb.147.1706286451838; 
 Fri, 26 Jan 2024 08:27:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m5-20020a05600c4f4500b0040ec8330c8asm6225115wmq.39.2024.01.26.08.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 08:27:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42B445F78A;
 Fri, 26 Jan 2024 16:27:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 13/14] MAINTAINERS: Add myself as reviewer for TCG
 Plugins
In-Reply-To: <20240118032400.3762658-14-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jan 2024 07:23:58 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-14-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 16:27:31 +0000
Message-ID: <87sf2kqcuk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

