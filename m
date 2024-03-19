Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1A2C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdjn-0007Lq-Ut; Tue, 19 Mar 2024 13:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmdjU-0007Fi-Uw
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:58:43 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmdjS-0006cd-2h
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:58:40 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-513e134f73aso3703265e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710871116; x=1711475916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W78Zc6G5lsi0HCi6vbvdjkDkkRnTZ4lv1NHIrHicZJw=;
 b=c8w6Ym/jXznkT6+93q3MWjscbUrcLoGjEulcdxWWvAO3f6n2IipDYXWo9i0oN0ZqLG
 qI7/rn7nv42uwNXv3+0EOlEVzpVGjPFiO39qaiU6irjU1B9fRFVDebG34+gxgltDadIL
 X+URNIila8b9prGHL12NMLCV0OQrH70+oWTdUxV1ip+GC71DAPZXi9ihnO5XkU0EM/qF
 BM8mbTYPeT2jNgJii8sa7geq6PHdM6MpR0HwN7BVAvPbHJBfJOAmod80KasuxAK3mFDi
 EFM2v6qA0bw/Bxah38CQYK32GZcW432IqjiXQq6jgWKiduszUq+Ea3oZxfaha/Txi7kb
 KnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710871116; x=1711475916;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W78Zc6G5lsi0HCi6vbvdjkDkkRnTZ4lv1NHIrHicZJw=;
 b=a5U6mMerbOVbGaZs3PS1FRxaloWR6BbjSfFgty8Ol8jc6sOkEv000qIowZY0PN588X
 oVwoDVF/30stWF+d6/zzFn0eZR91jQbhA76xo4cGgX/qX4TQcDXcWVQUXbIwgR2YCGKo
 tPXwvlV0HexU/iqre9rGvOihKCfQMuzlpfJD5lUXf1hTOUiSgsuxRcEoGPt1SM/5Gxiw
 hQFe/1dKlxcuVnfkRDe/RTXy5I80DVdDiYichuE+oaqcsbh1pbikM3PnTamrjG+FFLat
 C5x+vvhYbLFP9BZ3iffHpYmVrM2DsN8pPVts1N+rXC2S9pgEpY/Tdah4qg2/Ltb89kMW
 GWmw==
X-Gm-Message-State: AOJu0YxGzeLwg9zxmxHihyEw4kUlGn4zRk9uO8xSxzahd0vY+mzXnVwx
 Y39ypKZTAfuJ1olVlS3R2WZm5fG0yJUSHIgvxMcF6GvinyzIeWOoJjNWEwuEGO4=
X-Google-Smtp-Source: AGHT+IEJrWNVfyUf0veAX04Dy6ikcGWp7I+IggTiJsfz6k4/H8RaFCzbQOJzdhSZCLB9tR9st8xb6A==
X-Received: by 2002:a05:6512:419:b0:513:d22c:419a with SMTP id
 u25-20020a056512041900b00513d22c419amr2376756lfk.61.1710871116011; 
 Tue, 19 Mar 2024 10:58:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l3-20020a1709061c4300b00a46a3ad035esm4381473ejg.179.2024.03.19.10.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 10:58:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 454825F75D;
 Tue, 19 Mar 2024 17:58:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 06/24] tests/avocado: replay_kernel.py add x86-64 q35
 machine test
In-Reply-To: <20240318154621.2361161-7-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:03 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-7-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 17:58:35 +0000
Message-ID: <875xxi3xys.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

Nicholas Piggin <npiggin@gmail.com> writes:

> The x86-64 pc machine is flaky with record/replay, but q35 is more
> stable. Add a q35 test to replay_kernel.py.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

