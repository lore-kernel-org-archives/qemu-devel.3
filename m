Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D188CF31B7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyK3-0005kB-6B; Wed, 02 Oct 2024 08:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svyJo-0005j2-Gb
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:19:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svyJm-0006VE-QZ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:19:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso59412915e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727871537; x=1728476337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nL1NKeL/SJWly8UEXyUTWDBdWaCTAKVEYbE+1JoYOTQ=;
 b=pCwuAAM834uTqi3cIXwIRv8QvqohFLKiRLAVWZQXBd46PygYXcVN7L+MR8bCCqxT8d
 NAKxvGUDUa3QSrmdmq2W0rIDz98pjzdrci0ZQnvMqai8MBeihRAF0EInocuco1K+H3wi
 mc7MFsCEH666+saaRzcd65bGySEsuCAxQDAF9dW9v4+Qimtpg5yGo9nnLIqVe7vwbaWZ
 3mqXG8TlZ2JNIZQObgYOEqTUcVXGIlL1OUFk7cN7by6u9QyzJlUTIBhsJfMfr4TPPuPc
 ZO3mV8SAPg9t2COf4Dqv8Au0MEBa5HiwiK11PnDEFRBbVhJW//5GItwT58QZwpt1/LxT
 7Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727871537; x=1728476337;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nL1NKeL/SJWly8UEXyUTWDBdWaCTAKVEYbE+1JoYOTQ=;
 b=uZyJ9vPMck8bd/fddgij3D5DaZA7J8ny6UOFKzCk0viOWxuKpbTUmrGOoB9pkSOlOI
 2b025C4VQiyWcEjygTZslPFOf0ZNaTHSwY9EXglhuFx/sJ4O3y5QItGo7anW5+NZZvNv
 qZ3j/z7MKeONpvxPaR7//jPlvF1BfdNqDLhZhZgDGD7+ohnhyPEDLc3B9kiZFpwdjEm8
 XQp+/Q8tawjPhKhJQu2K/8seCtDT0EuDfIa+VM/oSmrdEER3OvzS+MgExHsIqbKfrmvQ
 nECTbf7NQXawo0FCPp2AQeVaq5YZiR5lVDbU3Wrh6kVklaCidGK0Quq97gR+5rVfBuLt
 XqJg==
X-Gm-Message-State: AOJu0YxP/T0wUgzYc/vul4xJAKAEhAkPLJmdaagSENiQi9xhvYol1tz2
 muXXZoSoxIG1+XA8h81pNl4z1pgpOna1fqPVyX2+9qfhemnQ6Bbz8Mta5UJwyW8=
X-Google-Smtp-Source: AGHT+IGWTgVGHg/HvxfaCBtIB4GgWODIDUgKifd39GecC9xP1H2eeTKAP0OqPyejctDlkF7nWX67Zg==
X-Received: by 2002:a5d:6d86:0:b0:37c:ce58:5a1b with SMTP id
 ffacd0b85a97d-37cfba16a81mr2249045f8f.51.1727871536775; 
 Wed, 02 Oct 2024 05:18:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fa2fsm13732798f8f.68.2024.10.02.05.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 05:18:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A29F5F780;
 Wed,  2 Oct 2024 13:18:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,  Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,  Huacai Chen
 <chenhuacai@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,  Sven
 Schnelle <svens@stackframe.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org,  Aurelien Jarno <aurelien@aurel32.net>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Max Filippov <jcmvbkbc@gmail.com>,
 Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH 06/13] tests/tcg/plugins: Use the ld/st_endian_p() API
In-Reply-To: <20240930073450.33195-7-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 30 Sep 2024 09:34:43
 +0200")
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-7-philmd@linaro.org>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 02 Oct 2024 13:18:55 +0100
Message-ID: <87ttdun1e8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Refactor to use the recently introduced ld/st_endian_p() API
> No logical change intended.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

