Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D248C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezpn-0001M5-32; Tue, 27 Feb 2024 10:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rezpi-0001Lf-RW
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:57:32 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rezpf-0001iH-Dh
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:57:30 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d6bd39470so2459586f8f.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709049445; x=1709654245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8vgbcee2yAiUAzlLG8r9x7AsJ9NiZOTZ6l/t1ofD124=;
 b=AGa9fUB4wnWgLwDcN1Rz2fgGX0ZgxeUCSBEOpNsIIdElbhAzV+HLEu7mUa93V2Vtt6
 /OWlboinIe5ud7DY3KsPO2KqCQi74X3eKvQM8+hZsjb0ZK7u/CWiDN5L/V2iomrLCbne
 Ub6DwzcFcjNgFgmPDanhDjqE68Q43OQwyc50/7GGpb5XDZyFOjEN2mWuNIbZcRMqn4Rv
 zx+h/7VGkBj2LQzUxZbMQ8k3aiS2Mwzex6yVubcPD2jM0M1BgUxJNdUk1nxJdqq37C88
 dmLE/0uEOZMCsFnKaOQRnFpMb7j+CZInVTDRlROS9By1zcdGJf97JkRsRJUmpry9Uh+Z
 PSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709049445; x=1709654245;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8vgbcee2yAiUAzlLG8r9x7AsJ9NiZOTZ6l/t1ofD124=;
 b=HtzHJNRrKbFLWHd/LGGlSDailoXl2gpwZJqxEeGs7yWP04OirEOgNGT3cdfRzytprf
 LlkKEbczQ3UGpdRdVq8JRA90ce36ONv+PJ1eBPNSj9NhbX4qLvZLvt7DJyJgdgxaoM2E
 UXM+vfxxdOhLTWDP3qfKjY2jH+ehfMTmNhRL/IS5fG2qeVt7DooLBaubr3S+JCqGgbxK
 maQkx40v5cBXYA89BVqEml693xh8KCTMycd70RQg2SX3cO9hdO2wwGT55yADuKKDM/u6
 lf9ywDRypz8RBehb71D0Mt3PS2VElpYpd540gyiNNf3Ov6SlI0mYxh6R6HGx5xNH9SY9
 ogQw==
X-Gm-Message-State: AOJu0Yz/yzbGDgdue1ozEFFhNNR/wm+CfDAnmADUj/udP1YzBFHFV+I0
 h+IwDjDCoO45JWjA1ZymSfAd37kONUhDtbbGvvAIHBR1uG1M3nbTCQyX95t5/Hw=
X-Google-Smtp-Source: AGHT+IF/CjRV81jB/kaqxOD95RcmRw5dZVqRAo2cGFEbguksYNV7uL8IUqvQRQRABHYVu0PXpGObTw==
X-Received: by 2002:adf:db4b:0:b0:33d:76a9:89ae with SMTP id
 f11-20020adfdb4b000000b0033d76a989aemr7041434wrj.12.1709049445453; 
 Tue, 27 Feb 2024 07:57:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b00412a3420e71sm8075644wmo.0.2024.02.27.07.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 07:57:25 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7CAD5F78A;
 Tue, 27 Feb 2024 15:57:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH v3 1/9] scripts/replay-dump.py: Update to current rr
 record format
In-Reply-To: <20240226082945.1452499-2-npiggin@gmail.com> (Nicholas Piggin's
 message of "Mon, 26 Feb 2024 18:29:37 +1000")
References: <20240226082945.1452499-1-npiggin@gmail.com>
 <20240226082945.1452499-2-npiggin@gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 15:57:24 +0000
Message-ID: <87wmqpdhnf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

> The v12 format support for replay-dump has a few issues still. This
> fixes async decoding; adds event, shutdown, and end decoding; fixes
> audio in / out events, fixes checkpoint checking of following async
> events.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

