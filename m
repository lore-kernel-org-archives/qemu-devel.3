Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4587DC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 18:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU95V-0005pb-Ox; Wed, 17 Jul 2024 14:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sU95T-0005kM-RQ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:09:11 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sU95S-0006f9-49
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:09:11 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso7497595a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721239748; x=1721844548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YS7ilWHz1zIk0CbJ+TBP+oNR/GFHp4ZMIlyz45drTeQ=;
 b=ucBF7hz+eW+lTjGalGItmO/agUDXTrfJc0Wxe5B7CLkF6wk8SB+BKK/y1o/jvq9qbA
 B/jLmhn/f00Ep3Tzuvbe7EuIRcsi8P2Pi/Er7AUmDg7+ADiQ8Kp0qy4uNuNIy7FGstoz
 s61sNed0fi94H2W/xFVPPJbDRbE4thMTAUoJ4zC9kB1w/93/lv48YWdCtEg3bodrQYtA
 9zhHj+X5ZjIz5unfg7zPtGo/HFXP1qb1aKW41xdTCMOquqrvfEF++y/UqcvVQeA43dpR
 FvRsTfzFNpiqsGkY+hrRMvDU8B3RicHnSh2NlUNsyAfBO+ZkPM9DOFufUV62sw3RXDWF
 XRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721239748; x=1721844548;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YS7ilWHz1zIk0CbJ+TBP+oNR/GFHp4ZMIlyz45drTeQ=;
 b=ail9KQY0ogI7rsTL19FslneawoIbyuuJpiAEkDEqm6zhqRuHhStYTIOZsM1UF0tYY0
 KVcaPzS7ZI0ro0zdD7PRtlq3AgVz+clIJnLPfDsHDwxu5aLTW8+0be5yuuBRl8RvosQj
 DxHZzVOQnEsjczbuO2BTHXz79ihXYe3a/86hyEG1YvhPHxEPL5x3AbAIO4aq2rjjsunf
 iZRQPSgr2OVJOko6huTf1TATSPeau+hWjqvpsI8Pr0IhO6ShsgjhbV7zrYHBd+zNWalS
 7qNyeOQYGRzvLGiK6RMnAXjncI0Peo2XPlBIZ6HQ+UfsJn2n6OjPD9+IxjzZEPwSFoxF
 5tGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZHc/6lmq/qAp/xFWxxGanOWeuitqGg39VufgxRxmqIAMbf0AFk3k/amc+80VXSADKX/mZDd2mSXEFeUg/HKDYCU/OqM4=
X-Gm-Message-State: AOJu0YxPkFUTWtb/yAYWdvbpGi8L54b6eAGPkQWLHt5kk2hlhTqvXzrk
 FlWd5gFEm1t0NMi06c8EMAO26Otx3QiUD806NQweQv+b0+QUAWOqYUluHoa3BZg=
X-Google-Smtp-Source: AGHT+IEkWpUMDeoaxwqJe1aBZoLdkZINn1R/GgXVJ1Pox16T+k6Ga46fq98V16vchXDO4hycqt3BRw==
X-Received: by 2002:a50:a41b:0:b0:58b:abc6:9cec with SMTP id
 4fb4d7f45d1cf-5a05d6bcfb1mr1441721a12.40.1721239747722; 
 Wed, 17 Jul 2024 11:09:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-59ca3e68567sm5791665a12.1.2024.07.17.11.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 11:09:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 150A75F738;
 Wed, 17 Jul 2024 19:09:06 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Cc: erdnaxe@crans.org,  ma.mandourr@gmail.com,  pierrick.bouvier@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] plugins/execlog.c: correct dump of registers values
In-Reply-To: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
 (=?utf-8?Q?=22Fr=C3=A9d=C3=A9ric_P=C3=A9trot=22's?= message of "Thu, 20 Jun
 2024 10:38:05 +0200")
References: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
Date: Wed, 17 Jul 2024 19:09:05 +0100
Message-ID: <874j8nhovy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes.fr> wri=
tes:

> Register values are dumped as 'sz' chunks of two nibbles in the execlog
> plugin, sz was 1 too big.
>
> Signed-off-by: Fr=C3=A9d=C3=A9ric P=C3=A9trot
> <frederic.petrot@univ-grenoble-alpes.fr>

Queued to plugins/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

