Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B24C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiQb-00029X-Ec; Thu, 29 Feb 2024 10:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfiQM-0001us-FU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:34:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfiQ1-0006o5-Df
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:33:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a14299a4so8100925e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 07:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709220836; x=1709825636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaYHN89FLqaB2XgfxZpmq7YKqG6dfOIjv3vq0ydw7O0=;
 b=s0HEFjY+T3CCGh6ZJGeY1ZboiC2TFcMjaYcwd/CadMEZuZkU3Td8GuNEMRSvw+RdF4
 MODtHl5kdf91RpIVatCVqVlm1q7QL6QzzP+i4LL3ujkcnFyTaibpO9CNZ4tf8Q8+cqgZ
 T3ODQZseZeLg4jGoup8WUFwKD9m5jDXdzOQOWCWlnVnltxQCEMR36CLsEHRk1Va0ZVM0
 SVbfq99uXqmYT1IDZnKTrICLlt7++iIgGsu/aMPKQS5H6IuwxV+wT7VW3i4wHufMAQKm
 EHUuTcWah+vsOc+eS/81q7vzy4pIaMAxX5T8zJUlit+FEBBnIJLTpGX39Ob8/Fl+Ctus
 qvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709220836; x=1709825636;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RaYHN89FLqaB2XgfxZpmq7YKqG6dfOIjv3vq0ydw7O0=;
 b=PUGIb0Ni2B652zlnwgVe2CSDGQ8aYw+2DUV+YRYnsFrnXQoPTIuhCrhD2tSki0Uoa6
 nBTVNO05l1L20W9bg7gzVpJmLPnHtHr1NyCu8XfLL08W8OjbjuA017vA4M+Nhkdzd8w2
 jmM5aWt/d80Z9lB6xlJjBkTywVAGwCCHXy1f2BC+f+ua6DHUaBRdOQp5MllWvNeHwGnC
 UrY7AqE8vPKPi1UE1q//aUTRyM1UhyVGW55zZ3AYgBXRlEHpFyc7YaSrsHSbURAtliGN
 XyexBaisbzu/RIhwupYGqz2R9lcja/giAE34W32Pa1oRbq9v0wJ/+jctXz7lYTx3uGiY
 wrCw==
X-Gm-Message-State: AOJu0Yxr+RiXP+c8e84BCQF9xbS0qCybptEsQDHBe6ADGy48LkIrGKJe
 iYuyWnHCeXS7bCqlQ3elVttLt5vgIB7a9iy/a+XfQ9Pow1KCu8qJaNZH3REVAi/fgrtVNWc9+wM
 w
X-Google-Smtp-Source: AGHT+IH30/kcl1vGFcNlhTWz4PsgyvtKVPcK9w1iMbJ/iLzsWhy7YMqkNxqRjgAgUbUdKr1hUZwW+w==
X-Received: by 2002:a05:600c:4fd3:b0:412:c1e5:a353 with SMTP id
 o19-20020a05600c4fd300b00412c1e5a353mr850977wmq.12.1709220835836; 
 Thu, 29 Feb 2024 07:33:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jp16-20020a05600c559000b00412a482cd90sm2351424wmb.25.2024.02.29.07.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 07:33:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 296E25F78A;
 Thu, 29 Feb 2024 15:33:55 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v5 02/18] gdbstub: hex conversion functions moved to
 cutils.h
In-Reply-To: <20231220162555.19545-3-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Wed, 20 Dec 2023 17:25:39 +0100")
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
 <20231220162555.19545-3-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 15:33:55 +0000
Message-ID: <878r338eu4.fsf@draig.linaro.org>
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

