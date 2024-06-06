Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E16C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 09:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF9gq-00051O-Pf; Thu, 06 Jun 2024 05:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9gp-000517-AV
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:45:47 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sF9gn-0000S9-JB
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 05:45:46 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso62400366b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 02:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717667144; x=1718271944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BT7KYn2G1PfhtedwOhihnialDtgn8uBirdeqKLzhxe4=;
 b=bUb/9UixfnVEZENP8naaL4OluASjoCG7/UPj+OPnVVryJPJlmLEpQmGM4bGwheaUxr
 s1gjRo38dKqEj8cg/tttnOfkWtJjgyYbGDCj82R1Nj4ndmsNp2YCRu0Fb4DQu2Y7gmp5
 prkmdf9O/KkFS6Nc+1jli1gPEnS2Wtu2EpN389bvhrK0tz9Oy2ehbd4PgEaAi1AmsXuV
 lDh+Qs25nwnBsCqraIjiw2MG0fikL5J7jw50y1JrUFdWkLtUY/NOovzT3odh1SxsUkaR
 lMa0jxsQqmLZ4yjyC1nFvXTNCnDzmAIsU26gpat6eZA9weeub6P9ZQXynNKC2sqgq28b
 Zomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667144; x=1718271944;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BT7KYn2G1PfhtedwOhihnialDtgn8uBirdeqKLzhxe4=;
 b=Ezn5b9/Awhf9Mhge4C1XXfFE8MlWL1GsMlHHquIu86ojl8OpYxi87UYHv2pLjwzsnQ
 CrccmB88X3/yFOiYxPIXZs+huQIt2NtmLIJuZWpoFYZExPJ96MPIq6rF5Z9Ntm6Je9Sf
 LOwxXmFPX9p5ceGOoBYusaht/Tos31ab2xnyckpCyv4ljQSokC9Pi9I5WdhUlYHTl2Dm
 46ueNgyQcKmjcSSw4rYqCkfcU5LqADoNAP3K6JN0pEtpSt61nDC602QzBbgYRdvOzUgr
 1VRSKSEpU7briY5Ae4owunZrduIu8zjic7omVG8Dp11SQv3Tll+CruwCJfioxmZ18Sb2
 nOGQ==
X-Gm-Message-State: AOJu0YwaP4Xma4zS8aioj9lxD8FbnuH2pg45d45atTb34gkhmrUTO/oW
 HA37CIe6rtNoci2+YAg/MRbtEVog9cQLHPPYo81/TpjZ64mUirhfSnJkvm4A0mV3QaD2yTjBX9Q
 7
X-Google-Smtp-Source: AGHT+IGsGiKmLLqcIFu9I0FjXm43i7HbLmtRF5FsOkqMBF7tNi+/mB1luDU6rVbAvyrCnWh8sePDHw==
X-Received: by 2002:a17:907:9556:b0:a69:6a89:5cc6 with SMTP id
 a640c23a62f3a-a699f361fe6mr234212166b.6.1717667143954; 
 Thu, 06 Jun 2024 02:45:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c8070e2c0sm70354366b.169.2024.06.06.02.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:45:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 536895F7AD;
 Thu,  6 Jun 2024 10:45:43 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH v2 3/9] accel/tcg: Return the TranslationBlock from
 cpu_unwind_state_data
In-Reply-To: <20240606032926.83599-4-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 20:29:20 -0700")
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-4-richard.henderson@linaro.org>
Date: Thu, 06 Jun 2024 10:45:43 +0100
Message-ID: <8734pqmmk8.fsf@draig.linaro.org>
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

> Adjust the i386 get_memio_eip function to use tb->cflags instead
> of tcg_cflags_has, which is technically more correct.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

