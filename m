Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56402C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trhLq-0003ZE-WC; Mon, 10 Mar 2025 13:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trhLm-0003UC-8A
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:55:38 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1trhLj-0007UZ-6Z
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:55:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so1560143f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741629333; x=1742234133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Rl7oKUWzEf0mraJT3KrgwcszxjdCft6AKKs5tCD/r8=;
 b=Q3CM3MkF5e9rbAfG8P7Bl1CKguftr8wigGp2NS0i9ly968DwwI3PLsjbR6gqamrcg+
 mV7EWQSncyA8g8ge7tbGWU95xb4BkHfUYmwt1V8ZArKVhVuI9eu0EdGdkd7Ig318S4u7
 AYb5x8jgb/ISOBsLPNvdbCQPqVsiknq1+NmZT/aK0rOLiJH7VgTxrXbOiKnH5IOX/8em
 wlTTsD5Bjv83a3uDnn3I+DP+Q8mVT2oHhZsMy33lRej0U/qYz82QW6xF1/Y0QTKi7pmG
 HNiEu2KGsuW96yvjEK+HB0zV0S/WwYi4P9eHrJJV7R31nGzuuyqdIHq3TtuQQMhTdWPo
 2O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741629333; x=1742234133;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Rl7oKUWzEf0mraJT3KrgwcszxjdCft6AKKs5tCD/r8=;
 b=v0yWMsEam4X9+z5vAWN/wJlB3yJtOYlp+Cp7aR55O8gK7tlz0G3QkMvZMXM0zURN8w
 YulqGWJObCiZRhfTYvkzzeoxn82cQ9y3uaY1yhWoMRhmNLLlvdL27J7x6Tl/qhu6Uicz
 gopEIMI6RSzWf5F9IdlcR72T3GrvJLu99kduhpKmeW/1ujfRSylUKgCJvClq2VCNJ8Zq
 x3tHukAkOT3Yn22WaMWB9I5SaPLuWNaCAm2ELAuC9ga+ta+Y7yfPgbrxnSyMUiE89n+f
 9tgj2hl0mwwzoSkvWacuX5BE/X0CZIwYcN+o25McG3X4YVe+qc/YzWLX1TVC+A+zd6d/
 i5OQ==
X-Gm-Message-State: AOJu0YyjzLpZsKaxeNwdilp2VI1m17JYRcx8PGEnznD8IivAlgXL+xJy
 p7mKSb/autdlnyLck7xkVNH+aUv1URqt/W5U5yTQo+6vq9lt3QfbUX2/laE0EHg=
X-Gm-Gg: ASbGncswpQuw8+HI/aokM1Xxxpjy5S5KEa33n37Nkst/ZB3mzLIKJtx41YZ/r+kDDFf
 QwkFKklvA2jeAzNy+KaF6pxbkZHn+n6EffIYyrTBHwRh+bZqJFQ9bYWeZf+7xW7PcEkOr17Frv+
 9uFJrsqgIOEPRmQdjWgVyH5GRveS41HBCPZj/NpO+14pvKf7ZL75HbRlEmlDKHSMJc5Hdqa+OY5
 dhbsJBnO9AOZfq/056BUBp4VzsgvhpoSjFJJX2sC6YOjL40hlZ9WrJdTmGXv/kvrUHTiWZkWddP
 fBaIf33pDTbkxbPZNujCmXYmfvKN1tOuLDQDFbwcNhOZcL4=
X-Google-Smtp-Source: AGHT+IGPkoOeC0SuhnkOm6b3cN6drVHXipZIh6M8O6As0oq5GHEHbyeY0rFUoKlFONGFF+UW5Q2iKg==
X-Received: by 2002:a5d:5982:0:b0:391:476f:d3b7 with SMTP id
 ffacd0b85a97d-391476fd660mr4739736f8f.49.1741629333023; 
 Mon, 10 Mar 2025 10:55:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfad7sm15497044f8f.26.2025.03.10.10.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 10:55:32 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 90DDA5F748;
 Mon, 10 Mar 2025 17:55:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mads Ynddal <mads@ynddal.dk>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org,  philmd@linaro.org
Subject: Re: [PATCH] trace/control-target: cleanup headers and make
 compilation unit common
In-Reply-To: <20250305050716.3460989-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Tue, 4 Mar 2025 21:07:16 -0800")
References: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 10 Mar 2025 17:55:31 +0000
Message-ID: <87bju87oto.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

