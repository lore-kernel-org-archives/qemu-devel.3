Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F59C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teusc-0006yc-A7; Mon, 03 Feb 2025 06:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teusY-0006yL-9m
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:44:39 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teusW-0007fy-KA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:44:38 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so679348566b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738583075; x=1739187875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z916Ej0riuhXVXWMhG09twEW09/WoZOqf6vs+3kZL+8=;
 b=Kltqc+liRVSiEvCxDfWYYU609JfOOtsaZsZydBcoRphfJbXz0+aNdmefq8yYbbdo34
 1eNILXM2/xspoceI8P2bYMqLX46A0hKCHCvXOOASz3G6mr955FEqillRLFqslP0NGfk2
 iI8jL2L+Vu696qeZcdNq4SvhRf/dn6bMHXZTuwnZkPbNMI6N8mdW097Gw2nb0iZ4XXGm
 I2GH7L8JKHWxK1pUqS5iJpGC02QOxuVXZNaLLxTpa1obn8vOYs4JseyTl1GgUVLs1tGZ
 t6HH3l/sHNiu6pqV8jNsorRGn8NY2vKsT3PF5ISzu3XWFrZSFHJWabVuSeoDm8afqJFg
 I9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583075; x=1739187875;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z916Ej0riuhXVXWMhG09twEW09/WoZOqf6vs+3kZL+8=;
 b=Ck8joJkd2XbUpsth8/7U5958b3GTcR3lqnmLCZCO+rK/Tt+PbXVMu51px3ekkgjYkH
 bcgjedR+SBw2fdo57KTx1kGTyBdyPu4MaLZ3D4mkFxbDLRDZht2b8q/nQQeiu4gDNhy7
 e5TdU+NyvkbzBONnnPngVhIgn0F2v0vkmYZkjRSo5ibg/W6A6nptJuZUPJ/PJ3m63bj/
 dviYSB6aRKqLcf4e0RVQ4o2nDhXACAhsfi9w1XOsbsYH598+Qm7NWgRzjhKh0XjSC3wI
 w6xnukFDKh5SJ4xgjttEEu6VCDDjLM0oY8MOyr+CoCDVKRFh+20EI/layAHtPmkqJNYp
 9Jjw==
X-Gm-Message-State: AOJu0YxoG+bejIt78kAH/IGf3vImvFZnx9Eix7ujIpGPnrBnYk9A5WT2
 TrhyhGoYOC6HA/wYJ2XBkLMTadi3uffHVpzje/WHQGgRoItzKI/Qcku1tTinKDE=
X-Gm-Gg: ASbGncsFibhb9b7OJbQ6oTi7WGmk7ZQnqBJrIJeSmw3JSgvu9V7gX6aCX8nnhurLQ1p
 5gOprBFPnv30Ow68SgvSyOc6oCjJswiOLhUvg4EycVEcXbLuTW6w8ZeoWUZwFPnTZjwcl7W3Zsq
 6DGx5gO7qIQy0SD/RBOxH4sO7/E9pUbfUtjdKgB4ay0txarqllIELLBr9/bN3Z02/78vTMLgk4/
 proL5Xhl/NHyKreAIgJKqHblEypx1rjQ4OqGa9v2CCVsRxuM3r7PlEd6wDaJiCJoQ6ObyWZSKb7
 YcNVxnfS9KgKDiVG6w==
X-Google-Smtp-Source: AGHT+IFR6gfcDf2fqN1ngUe+rnraxUHlLJQ0ditqTgnUoYvyLJBcW91ICEMPUg7qVVTzq8A7e5563Q==
X-Received: by 2002:a17:907:868d:b0:ab6:d7c4:fc7d with SMTP id
 a640c23a62f3a-ab6d7c4fee7mr2433123666b.39.1738583074759; 
 Mon, 03 Feb 2025 03:44:34 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47cfba6sm755335966b.57.2025.02.03.03.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:44:34 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CE925F954;
 Mon,  3 Feb 2025 11:44:33 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 03/14] plugins: Uninline qemu_plugin_add_opts
In-Reply-To: <20250203031821.741477-4-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:10 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-4-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 11:44:33 +0000
Message-ID: <87v7trdzha.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> No need to expand this function inline.
> Unexport qemu_plugin_opts to match.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

