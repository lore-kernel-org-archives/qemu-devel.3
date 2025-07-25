Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD37C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHnd-0004Y8-JZ; Fri, 25 Jul 2025 08:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufHnM-0004OM-4a
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:45:08 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufHnI-0005hW-5s
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:45:02 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae0dd7ac1f5so376096766b.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753447495; x=1754052295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onGUHhmWLX11JQTN/xoeZi13l2aBIIwmjjNBvz1ngNI=;
 b=YxgTwgiAe8FlBqr1jkMJU4NT0tQrvi+Zen1NEDHOk9yON84srj28c5FgTsrvDtj3bn
 lfEpTuf2QpKyLNGk1ry8BE0w50rP4NSDuFIrpxC8IF9lkzNVyCQHvmqcVoURCoqT+iOw
 6YSZTfEVHtTJ6B5uRmGWpf1Hh0d8unv8bZAkz3ixHidfXnW/zgAGlKZySkevU3okMTDY
 kbnEf39CLlY1cSUgt4WXaD1akUahmO7rnPxrem6jko+mp0rrUGKbNBv51f3e68FtUbvs
 QpT4Q2tBeEMWg2KhPT/m9iszl4te19uOAXl63K9GMUDCwutxmB6mHG3kyGGIz6qg3/w3
 DOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753447495; x=1754052295;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=onGUHhmWLX11JQTN/xoeZi13l2aBIIwmjjNBvz1ngNI=;
 b=mg3V4Crmz2ta+WTFHFaw8gLJGh7Hwtsvi5zsp4iIm3PtOUCaJ3G0fkYPIABQYAaaOg
 u30+u8rRW9Sm/eiinJFtp6nlyd22pErevT/+427VXyXBEmxSPLy10O/n9uF5wjxmnPQt
 UDxX/8xAs84nlE0GHflihOvY56AhVHFrQM23YT31xCi+OqXY67Gyy1wVpFa1Zc1mxy26
 DrirwF3gNkUrUDsVatTdHNfyOVBbcZkuRN6Db/BmnmnI2fvhjO0xG4/LrTi4YUq2VXOz
 7dnc5lWXTOGTe2N8hm64CZo0Lle0J73EjjsaIE4+RMmnRBWNlqJBgjGa/xDLNQFISsaF
 sntg==
X-Gm-Message-State: AOJu0Yx+lxi5BfO8u9aFA1QO3p2npX7Fav2AaEbaUzprXKxL5Kvc046e
 Pj7xmeLiw/Ui38zinkHCvsGHJA2meYmb8G5QPwyEknys9MaFtWttmfY/JGVFilVqUm4=
X-Gm-Gg: ASbGncv0pWT6cyJgSvS/BrnNShb6fO46cytHBbhubY/6gBocvVXFQqht2jmBkAVJhUQ
 7CqGnUhujDTsLwqhaRU8ISb/7M69lPbL0EaU6k+0CgnM8kTl8fSkZ6ZcVmqHHa9B47LMRQ/sWch
 Xcvr/m8yPr6hu1htmNU9a4bjd8/pxn6WaDlUhCxKzy6fJ/68S8tWAOybcVvqxEO2qoZZLJUvEWf
 DWdiYzxEqdoYEJu6Dzb5luf6KtdXoZroDu5qeD9DBh09/abLHOMhMk4go+yzesI6smYNDFdWpvR
 j0BSa+Z6XgsLNrKudbiyqtWrWawb3ysPe6CkfJMPyTS6QUsgj/G9pEjNFpRbJJownfpvdwRdCv7
 WTGrf1fm/rwOkWya/6dqJH/Y=
X-Google-Smtp-Source: AGHT+IHapGQwh01ydIFLvAaGN201r/oK23+C4ETTjuUJ/5oPMelyi/JD6MhPkz5efNCZprv7xmJ7Kw==
X-Received: by 2002:a17:907:d2a:b0:ae3:e378:159e with SMTP id
 a640c23a62f3a-af617d0afbbmr240836866b.26.1753447494681; 
 Fri, 25 Jul 2025 05:44:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47c495dbesm269822566b.3.2025.07.25.05.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:44:54 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7900C5F7EE;
 Fri, 25 Jul 2025 13:44:53 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] tests/functional: add -k TEST_NAME_PATTERN CLI arg
In-Reply-To: <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
 (Manos Pitsidianakis's message of "Fri, 25 Jul 2025 12:41:25 +0300")
References: <20250725-functional_tests_debug_arg-v3-0-b89921baf810@linaro.org>
 <20250725-functional_tests_debug_arg-v3-4-b89921baf810@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 25 Jul 2025 13:44:53 +0100
Message-ID: <87jz3wsam2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Add a CLI argument that takes fnmatch(3)-style patterns as value and can
> be specified many times. Only tests that match the pattern will be
> executed. This argument is passed to unittest.main which takes the same
> argument.
>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

