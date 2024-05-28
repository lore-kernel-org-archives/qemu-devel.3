Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED622C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 17:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC0MD-0000T5-MU; Tue, 28 May 2024 13:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sC0MC-0000Sl-6Y
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:11:28 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sC0MA-0000fd-NI
 for qemu-devel@nongnu.org; Tue, 28 May 2024 13:11:27 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-529c0d5001eso197894e87.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716916284; x=1717521084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hGO6UnpPltNGyhj8myW4rCgCDSgUCzsjI/5kNMZDqLg=;
 b=cE37T/Mu7zQ9OXNDuLnNmvZpQ/GEHT0ymvjOcvR8pa+kq1avhd5YFj7TllnaDRIKxH
 MqxLtPwuFg7NfoiL+XTaQJsQnnuBHAz16O4vQL+3Q5npOLG+0o40buytiM4F78HXyt9D
 1P5umg1XgYnwk+zKYQUFXdsDGmqctrr0uk+gDUGqbhc6DV3WRWR+UFJKOu6MI0VnHnhm
 X+NSOT5wIatx4HREyeXxSNzlxMv9pQU61W1yMZXJlcA6tj9Mdm8Di5txsJpS1gHgYGmO
 ApJttl4ehhWo05mG6uCoWuddMFHY1rxcKMBgX8DJEqZ8EiSST6WVFvh8LiQb3HH3E6g3
 NB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716916284; x=1717521084;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGO6UnpPltNGyhj8myW4rCgCDSgUCzsjI/5kNMZDqLg=;
 b=xEZ/1E+n19GZjGjkIocXNil5hcObApHgBX2e5tDh3snHUbju+oD6AKKcNcAhjDp4Ay
 lp8DCxuPi07WUkn/5Y1lhm9Sq8WnbzghkEZgHPE3lCdpm/F0lq7h6wVL69Efx/ha0Be/
 87hnUMliNhDjpsU4CitVoFF+CJaYd9jnicNNQH6jc6AM+UzFvq1isdNhFoK+D72qOEvN
 3NX4255rdsyZAG4KFwtZZemk8KbM6vVN/jpPj6d9CpMeDR9FAlZcBaBzEVfj5jMdp1ET
 CajaYtKvl+9KDqAkdLSs8BeuOb2RgqMZj56D0qprTahDdXLsqQJCJa1VmTWceUFWewTF
 RpwA==
X-Gm-Message-State: AOJu0Yy+J2tfd7oSEbbzpcpK5sCtSqXD8oP2grppVB62dtW7iSaMcwFF
 nUH1unUULP+/Rr6f2+hps2YmiaSYWVY7UlDi6G2ZanIbH1ARnBjArCSYWT7Q5xM=
X-Google-Smtp-Source: AGHT+IEIGm7Q10EJD7JAqsqqNHlZd/J34zQ7XGjKQ3xIC4X4TL+x/0eh3l17xfOhVgYcW1UY+6FfVA==
X-Received: by 2002:ac2:5489:0:b0:51c:cd8d:2865 with SMTP id
 2adb3069b0e04-529668ca0abmr8031647e87.44.1716916284258; 
 Tue, 28 May 2024 10:11:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5785234a7efsm7545119a12.4.2024.05.28.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 10:11:23 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 518C55F88D;
 Tue, 28 May 2024 18:11:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/5] sysemu: add set_virtual_time to accel ops
In-Reply-To: <20240516222047.1853459-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 16 May 2024 15:20:43 -0700")
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
Date: Tue, 28 May 2024 18:11:23 +0100
Message-ID: <878qztg8uc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> We are about to remove direct calls to individual accelerators for
> this information and will need a central point for plugins to hook
> into time changes.
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Just a note, when patches written by other people come via your tree you
should add your s-o-b tag to indicate:

  "I'm legally okay to contribute this and happy for it to go into QEMU"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

