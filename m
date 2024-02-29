Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF74C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhVF-0005qA-8q; Thu, 29 Feb 2024 09:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhVD-0005nc-Ps
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:35:15 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfhVC-0008Ij-9y
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:35:15 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4129ed6f514so7078685e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709217313; x=1709822113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Rl7oKUWzEf0mraJT3KrgwcszxjdCft6AKKs5tCD/r8=;
 b=v6UZxKRTy0a078KXW38VB9/++P6klYlOmaARl2MPx6n4B1skQmW6nnNfX3cKQQ3KzV
 wdTPXh1ivs42Wue+DCMG3A6orzofXI/TvmFJ5PPIbToPA2jUVLrln7z6VBHXTSjqGjzM
 sFrbwkaxc9Jnx9Wnoh7quToC1HSM4VscwwzZLHJDfXKrCuRnk2VTT6hsdBAAwSjOSfYe
 JXQzFKU421vH2auZCPFSr0JSYEM18cRxZc1WC+oRGTUj/27r53Cko4QAROZu+oSnYskP
 cI3AWbffLzAVS1Ji04Lnsyqtm0ZLJW8PeMy04vXrxxpyyy2WibeGPGMGJZ9E1N9Wr14A
 FP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709217313; x=1709822113;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Rl7oKUWzEf0mraJT3KrgwcszxjdCft6AKKs5tCD/r8=;
 b=gioMjjQUe9z3qMUhAMSVDUfJphYJ/ZE5MbwofFr2Md72egbLlbGUlv7Y7p8YHHEvxt
 1utEwarAxV85WiGhjlMJW/q8RZ5TvOiT2HDzB5NwbWQ9AZTgzn34Khqa7YMSqw8+9Sk8
 9W8M85dxni3LGupwCqGA/O0u1QQ2V/8+u8nm0oJ+Rv/ka5YQwyi6VX1flVzq8xVX8a1Y
 IJmQFu526/wpaldiqkNAIlYl+RnBuu5DV60zVR07fpbUQMQubjbVl71lDzAzC/fFffMq
 RsEbb/zLO+CEvVDTWHGzDssLtuuowG+dvIukrg5GAWvRC3Pa1cbMnrLd3VThIegZCEtU
 ypJA==
X-Gm-Message-State: AOJu0YxfpXA9/SoJOlFwIuKvuBb4wdd4NQ32p37ezPjXDKA98+va5fPN
 TKVSZAR9LzShd7ULEjucloXisztZFePw3SmUlwOLAxibo4yGpzmGYqjE57u+yg0=
X-Google-Smtp-Source: AGHT+IHBtxwjElPmncwL5v3BymKSeVYGHkMX7ZiKaRmzcqf+dANsi96dXwHGYV5Cv1Y8g2tQdXRpZw==
X-Received: by 2002:a05:600c:3b29:b0:412:bd17:9d62 with SMTP id
 m41-20020a05600c3b2900b00412bd179d62mr1495433wms.25.1709217312684; 
 Thu, 29 Feb 2024 06:35:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 s15-20020a7bc38f000000b004128f1ace2asm5314031wmj.19.2024.02.29.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:35:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BECC35F7B0;
 Thu, 29 Feb 2024 14:35:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 10/12] contrib/plugins/howvec: migrate to new
 per_vcpu API
In-Reply-To: <20240226091446.479436-11-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 26 Feb 2024 13:14:42 +0400")
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-11-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Thu, 29 Feb 2024 14:35:11 +0000
Message-ID: <87cysf9w4g.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

