Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C713BC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 13:38:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPLe7-0004gx-IG; Wed, 11 Jun 2025 09:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLe4-0004ge-Cy
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:37:36 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uPLe2-0000nv-OP
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 09:37:36 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-607873cc6c4so2100992a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 06:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749649051; x=1750253851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONHbH48quKQ6AaGNzJcEegS0OWBBUfyvhqjz9Ljd4SE=;
 b=oG4vRxCfY4zcIGtNAJD8A89ySklbYP+tzuNkf0KaONoCdcQStenCE/bYYMBifB6hOn
 m0uY0KIzg05QDbUl6sDwhTrnBa0vbmTnMi1Antq4TFMsc2Fn7Ln6nSZU2KpcyktW0+t4
 BMhOckKyIBUHI519dtx9IY8qQhYaH8ji4mS6dZVoE8DhOtp6zprBhWZ+JQGspl7Cvmsl
 L9NEz/lx6Pd0blgLTfDYHk/xHVir2+oWW5cjN83AbNrGLQK7wFpW7S2/mTSnWxyLFgPN
 9RIoeBFjkUy27V+vFvc/sK2mNqg8g8n3oKvSmUsxBJVRBJnFJwOQPCTU3RGjtOM+B9Dq
 5SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749649051; x=1750253851;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ONHbH48quKQ6AaGNzJcEegS0OWBBUfyvhqjz9Ljd4SE=;
 b=euGfLm49fWGcl9Z3AJv+/USkb0JEMse7iixRT1FB5RD3Bfof2mRyesQk7HkwBCLGh/
 cIgH+us5K4MwojuzqER55vqbJ3yI59kMOZYuQE1IPfjk76aHnQdn/1kIh4Wl3a51H3aG
 mcYe3oHW5HlL+BFxl/eEG+2s7Wey0/aYHy8OxUs1+370lY8hcHS84vw8B+GvL4oelsNv
 XyBmtrg8RO+hDN9Umqpxe7zKg+Xo4hRr90SN8aqHghJRkn+L72OyqMsGpRnoknohALgb
 pOJktT7YSiyjawzukmyjhbRT20P+dhJ6fuilno2jkipfpKuVulETh6MK1fgTkz/v+L5+
 ThYw==
X-Gm-Message-State: AOJu0YzQ2TkjSakgPYOnNJzq7+hDDZgmI5b7yA3al60RgevCVZFJPEjK
 r5pqKg6EPK5bE3Sv+l/iWE/kZfMXS265/R3mcIoAJ8A4yvNXQSK2GGnLfNMoLlXZ18Q=
X-Gm-Gg: ASbGncte29oM24NJjA5lcmxaC0JpnU76DMmGrY6kTJr/M74Z1YfVY8hjM295R6mvlGh
 P+11iUMihYOv2/wkoXxnIah2+P0CI+Vju0FtouAeuPqGehDY0kAkleg8JRTcpAzRg0+dP2fUoYu
 bZ5qhm4CThcuJq2TWqjFxw8hCWLcPw2jmEeDG88dH17AIg8N9q5mZBGaykZEOWVHL6odVLDt+ec
 dBKXzjCi6QDKB5feZ2KqeBNXlOdiLLsO5W8P5hdpd8yA8ImepDg18JkhMEnS/rPg9TykSuU7Wwv
 bAduBbwpFJHyiGKzWRszq/SUJogDLdB2GROT82sO8gp/Px/3wxgJMINnYLfUO2NBK4up8eJpgg=
 =
X-Google-Smtp-Source: AGHT+IHFcWiLsR46U/CyczuDCyFCKJl0WZ3PoExyTIWiJcmTRtgZqlAudyI697kYGYHPHUauJU1dfQ==
X-Received: by 2002:a05:6402:27c6:b0:601:cf15:c093 with SMTP id
 4fb4d7f45d1cf-608452a59c2mr3113437a12.14.1749649051244; 
 Wed, 11 Jun 2025 06:37:31 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-607e83ad824sm4613569a12.15.2025.06.11.06.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 06:37:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B8A6F5F7CB;
 Wed, 11 Jun 2025 14:37:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 01/19] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
In-Reply-To: <20250606164418.98655-2-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 6 Jun 2025 18:44:00
 +0200")
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-2-philmd@linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Wed, 11 Jun 2025 14:37:29 +0100
Message-ID: <877c1il7qe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

