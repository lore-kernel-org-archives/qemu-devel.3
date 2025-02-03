Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A78C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teuw7-0008EM-GO; Mon, 03 Feb 2025 06:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teuw4-0008E6-Ta
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:48:16 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1teuw3-00086q-BZ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:48:16 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso740240766b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738583293; x=1739188093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QvWE3c0tQCKYVVRxIOKFczQEcf1q5rm8tf1xsWNvEY=;
 b=mec4273pYUyyvV0Z5wB5RFySt0kZDAZ8BuaZHakE2ykkDcIh5GvJ7DPBf2B+BO9kGD
 jCWOt8rVVDsWG6BlLfnQQbfCnRYBrl0s1FOkJJJJdf4nBMaqwFtooO+HzpNI+NVJRTNv
 iNQx2KShC+0+9alL8n2jDnHsue8z/5kKZ8bQMZfmteJ0Cr8//FBbj6QJFusTRHJbhP3n
 Dl7UvDX3YqWEfKelX9EtBdSjU92Mcm4UJPAMkn+o+NkKonbo/H7GuD1ZIt8Wu4pFJh5N
 +vcUiUXKGFUFuRFkSh99RqA36WTMmAketmoSaYscWt7R+6PLL5e+URMKx9IhiVI3yiYs
 M2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583293; x=1739188093;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+QvWE3c0tQCKYVVRxIOKFczQEcf1q5rm8tf1xsWNvEY=;
 b=Cmr3IzabQT7IvAFd+Vtl3FXz3XPbw/0zeOgwivCpxRFx0QYxoUYbyvUR6S2E/J6uR7
 0RS0QuDVT9SZMEaRqXxbzjUR7/gje4yiHVZdfrqd4edNUskLke65XbnnWTYhPP69k2dR
 rtsASNTtBRfB4QWfK6Kqx9+zXxwpMj2y3S2RsIeCzLqo5ElcsiRMcGgg8yPX1/f36FMT
 RDB7dGb/c6om7PtvMcr/dgKBTpZ53iKXLNfPVJtz6V13ew0xqST8N5fXUfmamGmhgQCt
 3LRWC7Hr3A4RrdqREnqGYAXARI3XLMYeTLnMCEINpphj+wLLiGuoGlyyeBLlboslUiv1
 0pgg==
X-Gm-Message-State: AOJu0YxEHDYtJ9sZEmEzTNkiwUBgvswF5s1o832GDRTdAPHMgg1z/Kwi
 47xEs+917jjo+ZDVFKy88SwlbuoazPgX5CRd2lG0OPxc9KhR6WIl8/gHotsKSQ8=
X-Gm-Gg: ASbGncvAUReE+a2o5s3uZjQ7HinSTVxAW3T3eBAJf+DaF/YpUu9oJs4N68TddeWG6wM
 bqdQvikg2d97NJm+BYxPPv6uGA+Ew8H32Mgo40IvDnDtKsH4GmRgRjYIGN0MAuCNBZldPHQB5W2
 GF4vlUHG5ufTb2lw7OZ+uXJc6c8VlvM7HJJBY29gETUJaGN11UUDdCe/+kJCEtT09zpAqWB4RQw
 QmcJV2VnFtUfnhRyab5IEx+P17CBorIhrr0TmveY7lGy4oOOGPMGsGeMjQROUFb/1AZiOIGHZDT
 lenxOVud7J3h9cDi1g==
X-Google-Smtp-Source: AGHT+IEXisNCMLKmfOkA1V6+nexxwP4svwMDtI8sdsJQbKSVeXAHfQs4fDyer3tKNnx4KldT8TsLvw==
X-Received: by 2002:a17:906:4fc7:b0:aab:92bd:1a8f with SMTP id
 a640c23a62f3a-ab6cfd0839fmr2234277266b.26.1738583293590; 
 Mon, 03 Feb 2025 03:48:13 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e49ff774sm749792566b.92.2025.02.03.03.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:48:13 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E3115F954;
 Mon,  3 Feb 2025 11:48:12 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,
 mark.cave-ayland@ilande.co.uk,  berrange@redhat.com,  philmd@linaro.org,
 thuth@redhat.com
Subject: Re: [PATCH v2 05/14] tcg: Link only when required in system mode
In-Reply-To: <20250203031821.741477-6-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 2 Feb 2025 19:18:12 -0800")
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <20250203031821.741477-6-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 03 Feb 2025 11:48:12 +0000
Message-ID: <87pljzdzb7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

> Rather than unconditional linkage via system_ss, conditinally
> include the static library via specific_ss.  This will elide
> the code when CONFIG_TCG is disabled for a specific target.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

