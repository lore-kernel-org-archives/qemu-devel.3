Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBCBC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9qH-0007xC-6Q; Mon, 18 Mar 2024 06:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9qA-0007wp-W6
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:03:35 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9q7-0005Pa-Rg
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:03:33 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a44665605f3so454950266b.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756210; x=1711361010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=alDI3jd5CH/OAyNX2SP5M7HkwfV8PmsuqFQ7Xp9Hgorc5w/o3g7F7neQuD6YNSkDiE
 OlRIS/dwVL4BDlTvbxDQNlVIccIx9a6OrkMAztgDHtCTkrTB2ZBxDAL/SBx3y8V19+qn
 GiPMbyS7SIe9cr6XloslErPqx7Il7wP2PhTH9Ja7NenhXmpPm+Zx1iOcNuSdCzpb7TX4
 cwlR9/bYOcHkJ9XyhgFvs8h2sgNpsnJ7UboHDzWjxPGB49RaeZqB6UDD1gwqMrZnGpU4
 Ie3rXAvidOVNtdYMIncBWx1MZ/PwaCKgd/x/47sowuZNYdZTcFsZuy+p7V56HjpTk1zv
 zEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756210; x=1711361010;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nUQpIw0J7gYJntdrF3+fYQvrBvEG+S/20aOM1DWuFCc=;
 b=VK2hADapotIrB7ArcSu5YDPQjAkwGtGdQVQAVCKweDYXXArNk67/Eo2WgK7DL4oD3u
 I57y14SKCJTKQQJSi3MoeE8wEXTqVaP7zbsAjigxqAu2zSMFjVjFfdHQc7LNrF8cuQ5W
 FxBzXtNnUbu5H+iENlpTvgt2dIYiP6/2igGasFeVmEltsiF12LsO+2sxEeue2gPukdx3
 7TYzY1nPN4E9VG4HJ1+FNsfF6kCJBqGGD8mq1Dt8hhs1Vu1Gmr6SqvyWhb0VUbg+T/Wj
 L+RAyZY4Tp0xCwplyfy+qJDojBx0YFZYxAZY6F/5UUx+Tiu5TQs0DAmjmHaj8AEJvqy7
 Og4g==
X-Gm-Message-State: AOJu0Yzl1+IzOuOuNkwLLQ3l2JPmC0aR+PCi5PBNU+cbGdOlzwWiAspf
 MbmHhge9kGGizdiKyabdmTLXLCRBW41boSqvAa36E7kXLX3Q6aoAsvKscPKNsbc=
X-Google-Smtp-Source: AGHT+IEgNnAmyKaj7MOcboByXYk+emFZUioDsiVtGhca5Pr/0j9ZlEKChesQqV+VKYgftZvmbG9gpg==
X-Received: by 2002:a17:907:7e8e:b0:a46:ade5:7e67 with SMTP id
 qb14-20020a1709077e8e00b00a46ade57e67mr3587135ejc.22.1710756210031; 
 Mon, 18 Mar 2024 03:03:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 dl5-20020a170907944500b00a46ada81f1bsm1974362ejc.124.2024.03.18.03.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 03:03:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 707F85F7DF;
 Mon, 18 Mar 2024 10:03:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 04/22] plugins: Zero new qemu_plugin_dyn_cb entries
In-Reply-To: <20240316015720.3661236-5-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:02 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-5-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 10:03:29 +0000
Message-ID: <877chzoo0e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

