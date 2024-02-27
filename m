Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCD3C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezqG-0001ff-RL; Tue, 27 Feb 2024 10:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rezqF-0001f8-Ed
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:58:03 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rezqE-0001pE-3F
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:58:03 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33d28468666so3900479f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709049480; x=1709654280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyG4WRApCpMm0PthLANK4Iv3IU7KnLmZ0cnKrqmdA/o=;
 b=vP5/OFs2lcEBj7fYJHIIO9NHijjjnq8lKS9SA3dfAKHvE23HYfiOZDZmmfW5zsq3S2
 5lOoz41LV4fp//r6dypwHO3IIThpZcM9linNBrt1IQzeXb8PSwZQThlxyfel3wwB/z1K
 3pM3LZCbkQBE5ySO6TR7ri5ifRwX+sq5+VmOwBuGdQp7urr6t+QvAKYPlrpNe75fBEAo
 v4G7vcQgFLsvTUR+F/MI3bq8Al+Z3qYjhEr9ocN67yMlQsnjelQsmzyxI5fXzwJmAO83
 Qo+qEetkBva+5YeK7brgz29V5OIAgEEV+BUGfCnULEx6J4nyVC258KRwn/2O6aaJHVDG
 K0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709049480; x=1709654280;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iyG4WRApCpMm0PthLANK4Iv3IU7KnLmZ0cnKrqmdA/o=;
 b=hru5l04tPWJ08KKmDjlq7tViUI3Sgr1a2U7rax/jTj9t5c0wF8SCxjyQ8RNxuaH03S
 r5EtKai56NgdwmFmGpoLhnjIOO9giIwTM4kcbjoXHbvaSH79ldJXEDTVI4ZVF5QGtjPk
 CyUjRn33HSgmIxntb3isDvrdhZjtcniQo4++PV89xiP1exdGk1MP7QzN8CCRrt3vZAuT
 vPdw6WdmJkgICm7qALSBzNXDtbyVIezvEx+V3K5Bzd2OJ52STe9agsxuS3sSxihNg17r
 DMJGMScPS+QmxCAy4JRvrJDUqwvTkXffrjzf+33FjHEJ7OY3OH/340xUwZBXgPehjOi8
 uOAw==
X-Gm-Message-State: AOJu0Yx/Szt73waKkjevfeEz3RC/Tw4pxP1+UAO8qe2THsTG/lMmAT31
 ZHUjqY79X38nDIemHvpX/WnRd3Z2b27Q4vkzqf4FiyfNvpkqLT/yYQMHbVni6PQ=
X-Google-Smtp-Source: AGHT+IEiU+5kJlAhT8AwqJHxwCFxraXE4AY8JbA2ZihKZUEg3jSzP5kNrleS5OpJj0iYA1mJkBkbgg==
X-Received: by 2002:a05:6000:88b:b0:33d:f1d8:7a1c with SMTP id
 cs11-20020a056000088b00b0033df1d87a1cmr1345459wrb.67.1709049480360; 
 Tue, 27 Feb 2024 07:58:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bx10-20020a5d5b0a000000b0033b2799815csm11990290wrb.86.2024.02.27.07.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 07:58:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C3E8C5F781;
 Tue, 27 Feb 2024 15:57:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>,  Cleber Rosa <crosa@redhat.com>,  Wainer
 dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PATCH v3 2/9] scripts/replay-dump.py: rejig decoders in event
 number order
In-Reply-To: <20240226082945.1452499-3-npiggin@gmail.com> (Nicholas Piggin's
 message of "Mon, 26 Feb 2024 18:29:38 +1000")
References: <20240226082945.1452499-1-npiggin@gmail.com>
 <20240226082945.1452499-3-npiggin@gmail.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Tue, 27 Feb 2024 15:57:59 +0000
Message-ID: <87r0gxdhmg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> Sort decoder functions to be ascending in order of event number,
> same as the decoder tables.

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

