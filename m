Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D146C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rawZy-0005Df-W9; Fri, 16 Feb 2024 06:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawZw-0005Bj-Qy
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:40:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rawZs-0008LN-QD
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:40:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-411f165ef9bso15879075e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708083623; x=1708688423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a65JjfFK+ZznfVKA9rXr8wh1Kjh+9UE0VG0YP4sWVno=;
 b=A/vCPpUUveZmaM6l2MQsm9OgOT0XKLcEXk2ahNZDKNxhNYxN5NC54Aa0a5eIAx0EXL
 HpKIJ3H/Br0Yqj1XUVzb+RKw6VJTloa2oId9y0rvM144QfHfOpgrtC/k6tKfRDygUuCa
 vnqfAm7rBbn6c7QEXfNYiNrA39gkb0MMWRwvgxqI9iqUwtWVDjo3qvDzMQ+WGGmGgq2e
 mPBm1gqQ+BVCszRZ8f2jc8+ncjZBCKvNCeD4b1ehu4ZvjdvZIi5NJ0FAQ3ho3eUn7vA/
 06VIrmmyTr8LK6oxN3mG+mWAvIT3ROMRzU+nW1sy6b47Kf29uvg9gUnbZwJWcdSTaVNX
 ODXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708083623; x=1708688423;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a65JjfFK+ZznfVKA9rXr8wh1Kjh+9UE0VG0YP4sWVno=;
 b=Nq55d8lHKTGmlYmD4NPVSd5V8Y5W4tmbtPMih/dhspZFe7bpQO1wx4QtTXGFzzZ6Z8
 WR8sovQ/zbPqHvaUph5V7enQ98Q/n8dwX5ccms342/Irun7oGQgmOEp9CZmTsnP13OTF
 VjAeRWqAAYbgdBD0esmRM596PudK6MF4kXvpoVVV/P4pXiRcmYDXYQsFTF7l7E53iYcI
 NupIe52YFBM2TlCo7k5/IBp+VKZlfw1xG1QUk46tSjc+djYkeQLv/aVlnZgfK6B/cU14
 k1XDH25TtDR4rLuWg8IHvr9O1nnbqRIzJzPApoGMPrA9bqi7qi5t3/wG7nYxRDDoplTe
 4/pQ==
X-Gm-Message-State: AOJu0Yw+JLFxh1Z7TvobPmWKf1KCwszNlz8xsGs1FtovLmCU2FOaSuT4
 hxQfydU946KoHyEaHd5aPZ90mge5dxwjHGMvW/nHpP0kZx+aF+vzeYN/H6zcjEw=
X-Google-Smtp-Source: AGHT+IHVynA1cDXEqQnXK8U2PkqA34VjsFbQiAckdivMd04+AEdkxvNJPkgGCnTnHroWOMIYzAiEBA==
X-Received: by 2002:a05:600c:3513:b0:411:c390:ea43 with SMTP id
 h19-20020a05600c351300b00411c390ea43mr3508518wmq.10.1708083622721; 
 Fri, 16 Feb 2024 03:40:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600010ce00b0033d06dfcf84sm1946480wrx.100.2024.02.16.03.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 03:40:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E001C5F83F;
 Fri, 16 Feb 2024 11:40:21 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Charney OS <mark.charney@os.amperecomputing.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>,  Aaron Lindsay OS <aaron@os.amperecomputing.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Subject: Re: QEMU 8.2.0 aarch64 sve ldff1b returning 1 byte when 16 are
 expected
In-Reply-To: <BL1PR01MB7795E154CD5AE6ADA60C0D53A87C2@BL1PR01MB7795.prod.exchangelabs.com>
 (Mark Charney's message of "Wed, 31 Jan 2024 20:44:55 +0000")
References: <BL1PR01MB7795E154CD5AE6ADA60C0D53A87C2@BL1PR01MB7795.prod.exchangelabs.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Fri, 16 Feb 2024 11:40:21 +0000
Message-ID: <87mss04oyi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Mark Charney OS <mark.charney@os.amperecomputing.com> writes:

> Using QEMU v8.2.0 (and also the HEAD of the git master branch), I
> encountered an unexpected situation: an ldff1b is returning 1 byte
> when I run with the QEMU user level plugin (and setting FFR as if
> there was a fault).
>
> However the ldff1b actually loads 16 bytes when: (a) I run this same
> test natively on a system with SVE support (no QEMU involved) or (b)
> when I run this test interactively (logged in to a console) in GDB
> running on the QEMU (with no plugin involved).
>
> I was wondering if this one-byte-per-ldff1b was a known/expected
> behavior with plugins?  I guess it is legal to only return one byte,
> but I was wondering why QEMU did this and if there was some way to get
> QEMU to return 16 bytes in the absence of faults (or as many bytes as
> it can up until the fault).

Could it be a change with the location w.r.t a page boundary between the
two cases?

>
> There is *no* page boundary being crossed in the examples of interest,
> and no MMIO, so a partial data return is not expected. The page
> referenced is mapped and previously referenced.
>
> Talking to Alex Bennee, he pointed out:
>
>> I'm wondering if this is a result of the fix in 6d03226b422
>> (plugins: force slow path when plugins instrument memory ops). This
>> will always force the slow path which is where we instrument the
>> operation.
>
> I attempted to revert this commit locally and no longer got memop
> callbacks for any SVE load operations, first fault, nonfault or not
> "normal" predicated SVE operations. But I believe ldff1b are returning
> 16 bytes (judging by the control flow).
>
> Our goal is to use QEMU for tracing with a home-grown plugin.  For our
> purposes, we were expecting to observe control flow like what we see
> on SVE-enabled hardware where ldff1b returns 16 bytes in the absence
> of faults.
>
> If necessary, I can provide a reproducer, that includes:
>   - a sve strcpy loop from one of Alex's talks.

Yeah lets add the test case.

>   - a simple user level plugin

It should show up with execlog as well right?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

