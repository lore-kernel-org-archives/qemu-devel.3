Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3154BC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgHX-00035q-0O; Tue, 19 Mar 2024 16:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgHV-00035a-80
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:41:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmgHT-0002J0-Oy
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:41:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso7780014a12.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710880913; x=1711485713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+N34bjtlE0MBwRIPDHnN0vLSoKG8RvsMm2IbeepiPyI=;
 b=WbUJpXIXG8zTy2RUvGzNMTA9hp67M82wDjewJ0I/ohdvLF//dVHBBqGkG4GBM7HTDW
 z7fL+6g6nmsXjpYmVekPt4blWvg6yB0L0zrU00si0mCYZMJK0rfys0tY70rftjtOuMK5
 zTDdBPPg3Me86iKEw7zMMCs2/46EAG56yfcJtGCbFHNzjiemO0+++nafvY77plMLfKmd
 lPdfQFViHlhGBLvo0vHOzclSBo2HPCewdvm4pOd3KQLcdt1ZAmrLrWQOArsAdN7tHZqH
 RkRXt5oST3RDJm2PlpjCxZRL77coArBY6YXNa1DYhi30hE9hTMoqzO4ZCf/69zoA6ihw
 ri/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710880913; x=1711485713;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+N34bjtlE0MBwRIPDHnN0vLSoKG8RvsMm2IbeepiPyI=;
 b=la+fMTUZtVY492JNADk3I4FfpXoj7nQh0UHOBDyqygrsG1K358eyGAcrCBXdmZDb7M
 qEnXyO7XS0UlvVg3EOxSYisAsuaAZBDnr3HhmtUZ77fth9/iCZ02LAkyEX9R3URd/24j
 ZGpuvRdkaEtCAJgiwTlNOdHFl5Ns2bWXnmZ3fKmjfQPYKWDWKHXEWLf87pzomulp2zb1
 PPgINizQMdPpyowKFBG0cHjyv7+5765yZ0kVmMIMSahDdwvpPg3Xb7LqGSBIxy3eRPHI
 BxoLNRiiMytoRQDT6qB36nmhJXzDb8vuR3I7h1PE6eerc+6tB8M0c48YDuZ0YeGn8Wxc
 cysQ==
X-Gm-Message-State: AOJu0YwHCG+LRJj3Wrfj8bQEZGJjLgJvHh4qZsQype3+hmt/7KKfHjyl
 eqKcZQQmYdmRwOPGVOwFsI8pw5ouktrzmLRi+SVqUT0/ieb7BocWsto+s5Ahupg=
X-Google-Smtp-Source: AGHT+IHbG8DEcXuQCuETvDT7VPk4CV+qH+bMBcmdYtNcM67gMr0Jbld84sag9UylMyE1TdwhV+3ATQ==
X-Received: by 2002:a05:6402:1f8c:b0:568:9b15:112e with SMTP id
 c12-20020a0564021f8c00b005689b15112emr10995306edc.19.1710880913584; 
 Tue, 19 Mar 2024 13:41:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p8-20020aa7c888000000b00567fa27e75fsm6107011eds.32.2024.03.19.13.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 13:41:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D12845F737;
 Tue, 19 Mar 2024 20:41:52 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v5 10/24] virtio-net: Use replay_schedule_bh_event for
 bhs that affect machine state
In-Reply-To: <20240318154621.2361161-11-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 19 Mar 2024 01:46:07 +1000")
References: <20240318154621.2361161-1-npiggin@gmail.com>
 <20240318154621.2361161-11-npiggin@gmail.com>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Tue, 19 Mar 2024 20:41:52 +0000
Message-ID: <87o7ba2bu7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

> The regular qemu_bh_schedule() calls result in non-deterministic
> execution of the bh in record-replay mode, which causes replay failure.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

