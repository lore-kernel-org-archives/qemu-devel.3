Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A6DC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 10:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd622-0006xG-Hb; Thu, 22 Feb 2024 05:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd61z-0006uY-Mf
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:10:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rd61y-0001Ji-5G
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 05:10:19 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41279203064so9334085e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708596617; x=1709201417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIfQhlM8i9KIYuh54HREiBAAIFec/DKc01PRCZ9ZVyA=;
 b=BlufdZTb5IBUVKtcojpCnlWgOLgHfqoMDapZkr1NOgUdUPf786vOGcRs/rI0MSw21b
 dipUIhfXFyeRd60acmwmDg27j80iL9OcPKH2v4iJy8TeMkmw3b4lAbQBpaKxCK/LgJZV
 GNoJzC+pi0cS3uhed5msaNk8gdPa6baHsqKrP7xb2YzhvQRACGUzgdjc9r63z7nJHf6P
 0KJc2SXsI3hZHi5Xfi8Jp1cSucLOazKpeTeZkQBs/v6XYWBnAYudUbYjXi0cDXeuJ7XD
 9fQQMgU/68sc9b62IGFUYiw/ynOkgemsdtkQymFLhy7f+ySsaTuw4fZtxtXs/tuQOEix
 GhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708596617; x=1709201417;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SIfQhlM8i9KIYuh54HREiBAAIFec/DKc01PRCZ9ZVyA=;
 b=UaYVN8U8DnjX/q6jiconkJvQsGVD+TzMbIV4rQj2KmwHrrUUngIqp+1zYbAQqnpfS5
 xSgkXi0KExX60fjZ1XRG4hQQckKXBSy+Y53Nc+gjO8zeJgxmxBV7J+hj2GXsOJY/oCA8
 9aiO9PpOZLsp4AQTlO8AHFcpo8uVuMtfrTrsEGXg2PfL7BI5ZOR/vOXW8oh9ayoLn55h
 vLdSw9cNb+FynjuBNN44N/4U0TftbP4g50koKZZCNJ15HA2X2P3kKjFPRQOo1tWRInaw
 20x7ddMQPM026fGRdHs5cZNXzpK6FuHxEBkW8abRhYSgHM6VmZca9S2JkfcPwINaDHgl
 CCRQ==
X-Gm-Message-State: AOJu0YypAKnfh8BTqYtXrGFF/j289LNn+5Ec/6fS9Yh0grjt/V9dbQ8q
 IoIbDzDKwuwaFMpW8a9GARJa8zrmDOLuO5/1Mvk/ElXS/Zq+miv9ASqb/syidJQ=
X-Google-Smtp-Source: AGHT+IFs8nAnu+ERsGueLqAkeXUnmE9SpqHiC2y78Bp9OoTi/33sPTfEIuqoDJjA0nFaVkFGStDtnw==
X-Received: by 2002:a05:600c:4fc3:b0:411:a70e:3d20 with SMTP id
 o3-20020a05600c4fc300b00411a70e3d20mr15687268wmq.1.1708596616676; 
 Thu, 22 Feb 2024 02:10:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f14-20020a056000128e00b0033d87da9ab3sm2556802wrx.110.2024.02.22.02.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 02:10:16 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02A695F89B;
 Thu, 22 Feb 2024 10:10:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] pl031: Update last RTCLR value on write in case it's
 read back
In-Reply-To: <20240222000341.1562443-1-jrtc27@jrtc27.com> (Jessica Clarke's
 message of "Thu, 22 Feb 2024 00:03:41 +0000")
References: <20240222000341.1562443-1-jrtc27@jrtc27.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Thu, 22 Feb 2024 10:10:15 +0000
Message-ID: <87il2gajy0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Jessica Clarke <jrtc27@jrtc27.com> writes:

> The PL031 allows you to read RTCLR, which is meant to give you the last
> value written. PL031State has an lr field which is used when reading
> from RTCLR, and is present in the VM migration state, but we never
> actually update it, so it always reads as its initial 0 value.
>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

