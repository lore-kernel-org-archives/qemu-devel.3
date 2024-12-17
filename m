Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA400E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZQB-00070N-O8; Tue, 17 Dec 2024 10:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNZQA-00070E-55
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:23:38 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNZQ8-0004hc-Md
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:23:37 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so2148141a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734449014; x=1735053814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YwelTvnDdyHPTh4M2kE8HoLPPb7WDiLKmPAVFSSRyf8=;
 b=ycTkLnotRgbzfXwP9fOFs1maha0PzE7KoE/WAM/Qy0d3twhWQqbSvLDO00vHaxz5AH
 RQpbk22iYU4bFE1Yn30tGWWpYChw2kX7mGMvuhiWFYNRX8d+TSBmiGwnRQzDNtLzh3Mf
 Z/Fswi3/IGZtxU9aKJ11D+akF1RUdh9qwS05uhK2rppo0I8z8UzB5v8ZzacJwC7N0hYj
 XP8BYyx+ZTobSvHgGxzt4ntxRDvDPkaVLR1NceUNltZ70ZdgX59dqMId1LlKKLBagCJ7
 se/XlOlhA6mU0nszRa1sVbJWTD6grxwffTFmtsXlYt9QoBmvXUvZVr4mv5KF4rsQTbXK
 wc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734449014; x=1735053814;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YwelTvnDdyHPTh4M2kE8HoLPPb7WDiLKmPAVFSSRyf8=;
 b=Bntis1lelyE5lsApYxfiSnTWSE3mPgPda7HIlg0uXGyJaITItlpyFPFdduIarFNSJy
 CZL8BUkr2A3ckFcxLM+bNZEaRPVyaoz3S/0YlqbhKci8YvCxqJSjTJ3gkN8RyfpuAxqW
 YkdekHb+jIO1Rs5N1LhigQqRftXc7yyXtZbMGNm6rLMZTqTw6iDf7I7zMSjyL1136OFb
 HqSVpjYf/EsASvHaSPVlZfqfyVgD6nUpNoU/uu91XXimdBncmRXb0BNxuoAlpRbxne0i
 M4WnK97eTwG3kijF9j/q9ABHVuTT75o0KJ7UMrtwK6sID+ckY/g30J2VU5LPueN+x4Be
 gnOQ==
X-Gm-Message-State: AOJu0Ywblk3EyWDuiu3A8TAxXjjICFhoIcpHSE7aL3xbEFg21l0JskYD
 f/rTczYmq1JfvfibEBXP4BiZ6MvYp0pOuGPCWW/pGean5qApjCX7CS6WcIK7K3k=
X-Gm-Gg: ASbGncvNmqCW07wp8ZNgIcMDnTTL266WXTD3j56saz8sFU2fkMgczwJMmeQ5C8q3Gg6
 PwsC+7a5G9UQcK3GAqBVlqjp9AV+g7sJ7WfIl4Mln3Ou/oT+ZpLWfJ3RTC0bH+zaHoaL5wJpP5G
 u8fqRgS/GAHaLeXWJ3tRs8qBP1cMPL4cLtfnotNIeusfvcPo5MDTNE4jJkk2CsMWj8nFNyWDoZL
 G3knb6FrEw4hT6snhscmzUD4z49kTidP7El2mpUk9/HHqyEftvTpXs=
X-Google-Smtp-Source: AGHT+IEBjAKD9bHdpTfPUBTRyseDERJ5Hl+dv6SMdwtyQHdSvVLIeszXeyStvaJruiDrwMF9v5v1oQ==
X-Received: by 2002:a17:907:2d1e:b0:aa6:832b:8d76 with SMTP id
 a640c23a62f3a-aab778bf03cmr1384047566b.12.1734449014144; 
 Tue, 17 Dec 2024 07:23:34 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab963ce2f2sm453623166b.201.2024.12.17.07.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 07:23:33 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3604B5F953;
 Tue, 17 Dec 2024 15:23:32 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  richard.henderson@linaro.org,  Alexandre Iooss
 <erdnaxe@crans.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: Re: [PATCH 03/13] tests/tcg/plugins/insn: remove unused callback
 parameter
In-Reply-To: <20241217010707.2557258-4-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Mon, 16 Dec 2024 17:06:57 -0800")
References: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
 <20241217010707.2557258-4-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 17 Dec 2024 15:23:32 +0000
Message-ID: <878qse5o5n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

