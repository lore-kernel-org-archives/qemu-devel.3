Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF42C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 22:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsrU7-0002Br-2P; Thu, 13 Mar 2025 18:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsrU3-0002At-Oy
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 18:57:00 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsrU0-00033L-KR
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 18:56:59 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso256738366b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741906614; x=1742511414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQPAkbwjR0XH9Uvwwn/ktXz5V14y535dveL/fuvRAjU=;
 b=fsf7Xca8Jie8Af/toRLk0kN0bDfcxyc9n4B+YgUq+BucfgXX+rbgrBp9tqZLQ9pbee
 U3OaVe0eTf66WUWM6FYDh91S8UAkyHTetEUrSwFvAdTQu6pej942PwmIrFJ/Ic7uhrcg
 /55mo6ju3nxJxKIxrhnr0ar52kr8HDcSqQhvLvwX+PiNM9cRy48DVtdRU5wa1m5izA7/
 +ozKHWTGZsdEMMqHiizVZW/fHz54kM4gY9kwnQv64lKJoek8UtboUUESX0WCbYUSPons
 Ap4gmpTZ3dBqBnbEcV6GM22EHMBBtYYsmafIqJUT+yvuPShCzolyH0rkFEvwZV9tXrCx
 NDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741906614; x=1742511414;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RQPAkbwjR0XH9Uvwwn/ktXz5V14y535dveL/fuvRAjU=;
 b=kkJsRMMJkWFwvnM3z6sjC/RKjclYyEq2heLJBZ1Ysb/z8HPp1SwyG2hYG3MuN4qrkm
 uzprG14mJiJykjp5jLIKRdpZyT9HK2EbejoGmz5M16ZUWJm6vwXV7Vuw+daMrOtTOQ45
 T5bPPtIXqy88KYH0YMbwhv3GixMPFPDJ8Onw27Qj0hyG7Dpd9R6DSpGZ1wx+He3m9sWi
 7L30UjYApv2pVbGhdxaDCE3sd0j1pVEYqxtYLfmakNtP2xsCSjMjjz33ohXFWN+rTOU+
 jxsdhPO3kXeZRuMNkoFhmywMuiEpUQ5yVuioLDPcx3eEfUq6SIOoj3clAce4+EXPMJH6
 pxig==
X-Gm-Message-State: AOJu0YyphsI808zmqAUYscaIfpPNecGRkv78QYEyhmJ/ObIrfeTW30ts
 oKo2hnhSHRP4JZjS+heoJiawWk+ZPTXxgbGEDile8V3FQG7Mcda2qZgPn8kE4wE=
X-Gm-Gg: ASbGncuRMv2OaiG9oMvoR73YTpumutqFAi3ugSvdJlFoO2cuT2SWB9y+QlqX5kZKBxP
 4mOj9XKJ20ivmrGo2GI8rmydkFfyKkC3gGbIMeeAJRGWA4b04FbaGg54yEU3E9QRdfWiI8Sf8Tc
 opfW4pfAzIwS9OMLbYEd/8zTwBu11oYMYfFPvJMfnoTnOOeJrxdJIGjONeUkZTDCAo/ANPFGAiC
 qJJU1+b4L56hrhP+at0TNj+DRWCjJcqCvkZc9YObj5bgXQu5U8yRNzjMVwQ4GIN6q7iwfzaGg8n
 ZcOz/+jpYFomUwpOKO8q6cdv68IaCLFAbY9LhRO7j97E8TY=
X-Google-Smtp-Source: AGHT+IHm4VIJ9UlALJuQDfmG4QbLpa0ZKPHmW60l5tMH4ceQyxHw/jmCJWJ2tP5b5hzJ0UNfk/stUQ==
X-Received: by 2002:a17:906:6a0a:b0:ac2:5d24:1fcf with SMTP id
 a640c23a62f3a-ac33027e7b3mr27400166b.26.1741906614214; 
 Thu, 13 Mar 2025 15:56:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac314aa5166sm137767666b.176.2025.03.13.15.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:56:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 12D225F873;
 Thu, 13 Mar 2025 22:56:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 pbonzini@redhat.com,  philmd@linaro.org
Subject: Re: [PATCH 01/37] accel/tcg: Build user-exec-stub.c once
In-Reply-To: <20250313034524.3069690-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 12 Mar 2025 20:44:41 -0700")
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 13 Mar 2025 22:56:51 +0000
Message-ID: <875xkc4k0c.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

> CONFIG_USER_ONLY =3D=3D !CONFIG_SYSTEM_ONLY.
> Therefore it's cleaner to just add to user_ss.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

