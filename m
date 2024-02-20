Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882ACC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 18:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcURb-0001gK-JZ; Tue, 20 Feb 2024 13:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcURT-0001fL-1o
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:02:07 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcURR-0000D4-IN
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 13:02:06 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d0cdbd67f0so81317351fa.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708452123; x=1709056923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q83jTzfZSF5Rw1ObSelqDU+22TG8z19cj0NLvRMXHJ0=;
 b=yxDZqL22A9rFyNDF0osjV9fc7O0sqsEdzPFibuECMotOEbwofwBPOQmkNQPyAmrnaL
 pb1Fh3K+cBG8XFHhyfVfEk+WvWXSciVWIaCAexnEJTCgFvP+7JFeSKvWVBHAlHMEHwcx
 s/HDyzck1ykoicatv4fZqO4POTzikCTRGYlvxBDZ5DkFFix0lLhpbpVFKA49oaR0jTOZ
 L8LXxbASTl+vvwNO2tqHcbV3ARWY3qVLLGN4rCDdX/EpohuZFBFAoHgWjeDW/SJmu4FB
 3iu9DTpG8VWKVWWqIWt0jAWwYMiKE2i4GepF8H5vNuAGaWVdT67AM9m9Z2pW9voNZ2hM
 1o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708452123; x=1709056923;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q83jTzfZSF5Rw1ObSelqDU+22TG8z19cj0NLvRMXHJ0=;
 b=L4sNlDmlX0UfHcDoO+ZnarofpG9hyb7iL3NO4DahGuoVbPEsDt2ZVrGhX1Ri82//gH
 VEg5sGmWZzyiiKqcEwWkvaMTiHq0o4S4+URj4VWDHxZfnEdC1NjivSu2pTcj5jmFUwho
 L8nUizoVM2VeH8BkcqVKyuCINHjeHgJlOfUNqNXxrTv5dn71EEkwBxLs/VCy4XBAbcz4
 LbO9hwmM5++IyB3jgs5RfjhPvtHEWp9J91nfkroejB+gAM0Uf1Wj2AKEWIh4NkjMCI3z
 KZY5AlFaDXqds8B0/zCM6DOtlfqhn8g1b2ic1uGE3VUjtrCp/BOl+cb29Q4hKwjj2983
 6ebg==
X-Gm-Message-State: AOJu0YwcD9aqJVF/P/xC7/om1/j2uy2FkpCA1dQWSnTV/Q+K5L2skHT1
 XtnWde900YBO8WqcNKnjcyuOEXWxe9BRugpqwZb2+oHyX7afWd3COG8I24fppEM=
X-Google-Smtp-Source: AGHT+IGQXrkMtJ5cs9+shO65wJzORvRC9uJ4JmSQjFHY9OMcosd+4UOpbFVZuwQ0v+4mEHoBQEKK+g==
X-Received: by 2002:a2e:a4b8:0:b0:2d2:3d31:220f with SMTP id
 g24-20020a2ea4b8000000b002d23d31220fmr3050783ljm.25.1708452123260; 
 Tue, 20 Feb 2024 10:02:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c014300b0040fccf7e8easm15191938wmm.36.2024.02.20.10.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 10:02:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A2A95F85F;
 Tue, 20 Feb 2024 18:02:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 1/3] docs: Document that 32-bit Windows is unsupported
In-Reply-To: <20240220174412.155885-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Tue, 20 Feb 2024 17:44:10 +0000")
References: <20240220174412.155885-1-peter.maydell@linaro.org>
 <20240220174412.155885-2-peter.maydell@linaro.org>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 18:02:02 +0000
Message-ID: <87msrvauat.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22e.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> ---
>  docs/about/build-platforms.rst  |  2 ++
>  docs/about/removed-features.rst | 15 +++++++++++++++
>  2 files changed, 17 insertions(+)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

