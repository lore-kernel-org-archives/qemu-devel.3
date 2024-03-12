Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925A2C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk29i-0004C3-AB; Tue, 12 Mar 2024 09:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk29V-00044c-Ew
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:26:46 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk29T-0000b0-Jz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 09:26:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5683576ea18so5195288a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710250002; x=1710854802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dv7+dDQpFHZQchFipqsoDj5snQTHogZtqZZooWVwU5c=;
 b=cHnET3/hUQUf4FlZkPvoTkWVqAIh26H6URU+7QbU/aDYRbulErrRlas6v5EfHKSyUa
 wiL+6OmBueE1efxA7n7k/FMFVgfiFEPvbye/XtcFwe9aU9t00p9eee6Lbl9sHh1UDtQe
 RnEO7o2AQx+searuc8yUTiO338P49P8PyTyD3feZeqQF330JvTwYP5Y0ZGO6P2vwbDim
 vFJlC+FsFJj0ZkLDy1jMApIKKeZfQCcXfYaGklCvoLKNKkOB3A/wCeu7qGWXppP+R1gu
 RneTIF+6Hl5HhoTxKutgn2CkuJsA+Zlw+2GY0KlAapG+yLhbyRJ7NrQEpwa9ilZR59OG
 xDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710250002; x=1710854802;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dv7+dDQpFHZQchFipqsoDj5snQTHogZtqZZooWVwU5c=;
 b=W9KInRDgUCR1+72SvrTQgDKgnJ/Y5MpPQwtPbCxzUKZmbyKj1FGoaY+BMIRAEmioip
 wm/AUbfqf5Q4ZbN+rCNaKri+n9ircJnBwqDMhhSngItGQQ7CttSMzyCse/6HEftUfmt4
 +GmeKGRy+99IHLh77AU4VJsec2CHnZKk9l7aUZUyPDwKSNDnhWkG35TBIFvy7T8Ur/Yn
 KfkT0ZS1ZSMCB6OV6VdfsjUHU9ceVqy74g1k454YbuW88q0bdARn6KFUH28Th8vgGcGS
 4mdkukLkNWgCZAxyPi4zz188RD0KP88/n/rN1bEQQ25DtvvVedcePtToKhLufp7gVIfc
 Rs+g==
X-Gm-Message-State: AOJu0Yxo9lRRUZBX/1n7pTpYTytSY/HhMwbmMKwvNCupXKcsvIKN3CtC
 V5leao83NgbzYKPd4qjRMs3m29JrHvwLJUYWqUiEKLsl/S3S2Ulkr8rVBex2kHw=
X-Google-Smtp-Source: AGHT+IGvfUyiC1lx31lZQ38CvynQpZLOVCMtSUDKvSrw96jyeoe8oCk94Xy+E/hTT2Xge74WRf4oIg==
X-Received: by 2002:a17:907:1184:b0:a45:2e21:c776 with SMTP id
 uz4-20020a170907118400b00a452e21c776mr4954539ejb.3.1710250001670; 
 Tue, 12 Mar 2024 06:26:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z27-20020a1709060adb00b00a4576dd5a8csm3810752ejf.201.2024.03.12.06.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:26:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1D2E5F863;
 Tue, 12 Mar 2024 13:26:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 04/24] replay: allow runstate shutdown->running when
 replaying trace
In-Reply-To: <20240311174026.2177152-5-npiggin@gmail.com> (Nicholas Piggin's
 message of "Tue, 12 Mar 2024 03:40:06 +1000")
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-5-npiggin@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 13:26:40 +0000
Message-ID: <871q8fpomn.fsf@draig.linaro.org>
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

> When replaying a trace, it is possible to go from shutdown to running
> with a reverse-debugging step. This can be useful if the problem being
> debugged triggers a reset or shutdown.
>
> This can be tested by making a recording of a machine that shuts down,
> then using -action shutdown=3Dpause when replaying it. Continuing to the
> end of the trace then reverse-stepping in gdb crashes due to invalid
> runstate transition.
>
> Just permitting the transition seems to be all that's necessary for
> reverse-debugging to work well in such a state.
>
> Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

