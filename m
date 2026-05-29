Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7979ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvQz-0006fz-Se; Fri, 29 May 2026 07:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSvQy-0006fb-RG
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:31:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSvQx-0003XJ-80
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:31:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so221341f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780054281; x=1780659081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xy6WDsGYXcRtEqK8afiW/ypCWJ+L/QEktoifCxXW8oM=;
 b=WlIzHGVvtKx8RsBCSgsiDc31ZjDnmtG+jKtWlMWE/gEaeYvp+Vdmc37zMqNFLpOR/V
 jAOVlpk+tv0noloR0jLfaK2AMCA/yDiK88OOKrnEq7QbeQvvYvO2ghfQozMorwtvr2Pp
 jwpXkVVZ5RYwN2PvLP0PX7Gv+5ufcGS1htJtCIp/O3cMGPJSXG27HawmfKhkULYYx4XE
 y1Gx/RRv9F1jpYNdd2U4SRZzceTFnL8go8HIxlP59RFVDfjwiuzqacunSFkYXpzkvcr8
 zm698QZQYhlect6Lp/eoOlvU5Cvc95NegyuAJ8BpJbZgKkQMb+iWoU8m3rLnOjY+nDtK
 6A5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054281; x=1780659081;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xy6WDsGYXcRtEqK8afiW/ypCWJ+L/QEktoifCxXW8oM=;
 b=lfl5Q1tza2GmQzBz9qHjuRDOoh4V6LAMD6hvUv8R63C/4qrxBETUopYCM+qXsgAATl
 JYGveAVoEJUXxVcxizNizTbeKOIzenNMRB5FCQcvvv3/h40Mu28aaiPvDbew9+ylCgCf
 Z3/EVe4KAeIhViiV5NlP35kaL+ZTzMPdttAvk84k1N4LUFyE1qX8uYV0gZkfj1iBKgIe
 x+pWowmZiUZc8lJ06LDYtcMRNabk+5X9rOdUY4eylG254n8RRirvtnuKtg/Ris55AVVD
 /Xpo8QxuMrzti1cQ914ZWYS2a6lFbFEOUycRZUdaSrugR2WVU2P0nrMQlSimOu2dIJeX
 dc1Q==
X-Gm-Message-State: AOJu0Yyu/eECNQ/XBhgKvqZ2MyybSAIwUTGRzMKnVZsROdvFtYLZ0+mC
 gsWdpyX2s5PHHpRs+z6IGZIF3rDH/gZFRIUqSuYTEa3JrPo4etQq15ptlTPMl28iTwE=
X-Gm-Gg: Acq92OGfgLakNyYkUhzDpuYNcKDmQCu8PVWd44lMVWdbesalM6NGu6Z8jeWAnzU/sA8
 Q+PTkk+UoCx+IWpdUx5jBYlq7u91Ee1ymHIl7kkIEE6g4YKmq7X1iQnHVBUoqhuwy21fDd/hj45
 84QTk97H7PCi1lGEppxsJ98Fh2/vnrqPXeE8DAu9gHiSQvijvAg7oKoPO95axnaIFfYMV+V5ph7
 0drWWxheye8BEcQ1gFz71JaKkghniA9yP75xwijtUQpqGEKplDrU/mIuL5tn4kI+fSO9YSvTTJ8
 A08hFxVLzhieW46EJY3N+YdRsRJ7PiIoE5T1rHEH6zPYg/QtUvwknzYg+7dWQHO9upnLgEKVO69
 vR7pgxVIWFw8NnYTW3Jz7pfLSZvZHA3PDhL3kqicUNyGM07z9sJSuV4QkmdNVDrekVwLj1rEeHh
 nRf0gh1PDIdhQg+G8DAI1+M6H6/Z9lcFZOLQ==
X-Received: by 2002:a05:6000:260b:b0:45e:f29d:d438 with SMTP id
 ffacd0b85a97d-45ef29dd6femr3994850f8f.28.1780054281467; 
 Fri, 29 May 2026 04:31:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34c50f6sm3325636f8f.16.2026.05.29.04.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:31:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B81715FA5C;
 Fri, 29 May 2026 12:31:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Cleber Rosa
 <crosa@redhat.com>,  John Snow <jsnow@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair.francis@wdc.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Paolo Bonzini
 <bonzini@gnu.org>
Subject: Re: [PATCH v4 01/12] docs/devel: relax policy on AI-generated
 contributions
In-Reply-To: <20260529101437.410181-2-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Fri, 29 May 2026 11:14:26 +0100")
References: <20260529101437.410181-1-alex.bennee@linaro.org>
 <20260529101437.410181-2-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Fri, 29 May 2026 12:31:19 +0100
Message-ID: <87jysmpi48.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.

Oops crossed wires, see:

  Message-ID: <20260529094619.1034458-1-pbonzini@redhat.com>
  Date: Fri, 29 May 2026 11:46:19 +0200
  Subject: [PATCH v2] docs/devel: relax policy on AI-generated contributions
  From: Paolo Bonzini <pbonzini@redhat.com>

for the proper v2

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

