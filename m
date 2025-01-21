Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC0DC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDbk-0004rQ-K1; Tue, 21 Jan 2025 07:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taDbe-0004qS-Fj
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:43:49 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1taDbZ-0004gI-7D
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:43:45 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38634c35129so4699861f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 04:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737463419; x=1738068219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/20K7kwQqhBk4keQO67w7ok6qsYivQguJk0eS/RHCMg=;
 b=KEB00ZmzbXV7B1bve6wgNzQtN854Otc0jo6E8xwv/wkIkVYWDxSIH6nEl7Nfnf7v6b
 7nKO4Q+m6TuQai+JGvQo6AD4VpB7PgG3zjFTBom8iEdLJEmPd8QFg2TWLxqXT/vWMazh
 LSiTNlCasWsJHedENjInA6mS2GWFP3k2MZU+eCA0jBkA4Z6xGWPDx4El2eJqLhYEscc8
 oHcGnaluVKG3l18Ra0qHRrw6FJJYiKKRjEdaEj0KPYbMjNbCKI3wOhDFsSEjhmxprp7r
 JhO5MX084ZX2kCQbusazLCovtbzuHf521KNW7OnGiDCewa7VXYQ4URK0SMSjNf2NGr/l
 dK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737463419; x=1738068219;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/20K7kwQqhBk4keQO67w7ok6qsYivQguJk0eS/RHCMg=;
 b=vP25uzjAFpi6uQ46r5KalgKsxgb4+URxJKOJ6/ECpPZNkOQxCZ7s1qkiWoj+j8HBpW
 MnON/TDZ2gwJsEvLeVfiT0957Aw91mVPEMZ/JteYsxNXMPdFCrC/KG2732AIwvBbWhHI
 yNSy0EiSXZFNM8+CGyCU2UW5x3luiX2cvR1l7PBvhnod1e2jy6stolcVKqJ61EVQ2l9b
 bq5hgtT1J+ViY+wJywOgG0jGIaXNxygs/YHFXSwsphVTWE9bp/NGWC1SeVIVLZOwkZGD
 qdxX9agTVvxAveme8xkrfhJQPpHnWNDZQo8jY7pNjgPtm1ltzg5crcKdJKFpO//Y/Pu5
 6uig==
X-Gm-Message-State: AOJu0YzHH1FOKRCC6HRWybs64notYkU+J+sDPGIJAfkwkaDIzWrsXqGj
 y6/JlfMYRWE33F8SV3E7CrZ39Vd0BO9wWsT6QC3M8xbYO144tQkn4R/+G7lJ0UE=
X-Gm-Gg: ASbGnctbK9+XsyKzgNrc5gH9GxqB4VK0/TzfTQvAQxjHNNQTWEKF/7zr506Im4G+mNv
 mZwWvBBgpqu3mzt3fJQRzWo3T2JRHfPBhJF6G6TpBj8k+5lbk5OegYwEYjF6TDEefTq2CcCgV/V
 cefJskgOdRb7KwWHH1g4OttQ0L1pgljeqZnJTSSO3GwXi94k3YV9UdX2xPSgnY32I2gq/8nL44V
 ft+R4y77z2FJ6TQPT5PmeepLehAA3ZzsHo2BrpSyFyvuccAN7CzkSOHXDwtPz2kXVhR
X-Google-Smtp-Source: AGHT+IGK8gQzb5BZqmQb+7dkaCpWtb1B28TKKcYWxAxT4ebONjTkD8p6uJiHSffyAEDWG4P7PeBY3w==
X-Received: by 2002:a5d:6dc5:0:b0:385:df5d:622c with SMTP id
 ffacd0b85a97d-38bf57a49a9mr9724272f8f.30.1737463419512; 
 Tue, 21 Jan 2025 04:43:39 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32151e6sm13040011f8f.20.2025.01.21.04.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 04:43:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B4905F756;
 Tue, 21 Jan 2025 12:43:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-arm@nongnu.org
Subject: Re: [PATCH 09/11] target/arm: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
In-Reply-To: <20250121114056.53949-10-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 21 Jan 2025 12:40:54
 +0100")
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-10-philmd@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 21 Jan 2025 12:43:38 +0000
Message-ID: <8734hcpcat.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> CpuState caches its CPUClass since commit 6fbdff87062
> ("cpu: cache CPUClass in CPUState for hot code paths"),
> use it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

