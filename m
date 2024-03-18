Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A0FC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9pp-0007b7-15; Mon, 18 Mar 2024 06:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9pm-0007Z3-8A
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:03:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9pk-0005Lp-Sk
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:03:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a46c2f29325so71413266b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756186; x=1711360986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpPm2FRiZFZHJaDq+VXiDxmYT7rGoMt2aSaMaCV4GBg=;
 b=rXWdVyBZ32JIhKy4IWlRDJNQ8pW4YI/rAio/UmLeTgJ9624n+T/A3Y8EwwlBHMKWIy
 TmmSV3vcmP5yEyIkT9bYlhBw6QfWoZ8SO15fiXBVMsCbSPB+fz7cf5JZjzP7SbWR+zSF
 GUqkpQwpbks+f0HILl9UG4/LBh/hxKcSJIRL/h43ZUCzNNg9NNUlQUwAZKTIPD/Dh88p
 L5KimP1QJG4J0BsUf6hHB0Y/9mHvgcp/KtJIm04urVcDlMTXWucRX2/h44ppfTMprqgm
 kksJqCXumRL2Fq1l9jNsZ7JMg/GEDhEy1CosPcBlQDunC6nhGTphCjBZab8xcdb9cLkX
 nNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756186; x=1711360986;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hpPm2FRiZFZHJaDq+VXiDxmYT7rGoMt2aSaMaCV4GBg=;
 b=pj4W+c/KYKINNq7vHpyLgEHYMQy20voMXUr5hKAHsqac+b4yedB4fIjg5jpdJCJ7wL
 DhdtovMLlRI+YbQtK1ccB+pgktsFKXqpVu7hOdeS8Lqcs3DiFWpn3TdC5RWSc8ZLRF5w
 zzqZuuiZOErC6Nc5Aa8HGY9sWkziC06DLEqbA5b2rwn2I63L2VchL/djOfY+dbZbvuys
 vREytP3vFQbcmRfAkBmkbd7IWppVFwqIk25XRB6gK6esdcdogevtnxOdvh/yiFGjplAX
 0tEZTa6csVG9yV6oE7l2EN3swq08vDtx0v+FnkxdrzXP8J9Mu8zyh3+3sNsqt24ona3W
 c4Eg==
X-Gm-Message-State: AOJu0YwNnrEbMQlwTkP2Z9PvfTSjsHgN6kd3rkmRX+QM34TWcGIcz1Cq
 UajliZm7P+spB8iq6fZr0iX0bMz4tgjZOhoOqlvuRISm1DF+I74OyTIPLCCY3Df6yVz/fzeKPTd
 D
X-Google-Smtp-Source: AGHT+IFWQh2bBygpz9o+hrYhkYi9DrroWLs0OewzaDwc8kiFlyu2kEHdAmLzLwRE3jukfCU0HzaCyQ==
X-Received: by 2002:a17:906:7304:b0:a46:c8e2:40f6 with SMTP id
 di4-20020a170906730400b00a46c8e240f6mr1038236ejc.1.1710756185857; 
 Mon, 18 Mar 2024 03:03:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 lm9-20020a170906980900b00a46c0191306sm840347ejb.213.2024.03.18.03.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 03:03:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3FB955F7DF;
 Mon, 18 Mar 2024 10:03:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 02/22] tcg: Make tcg/helper-info.h self-contained
In-Reply-To: <20240316015720.3661236-3-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:00 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-3-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 10:03:05 +0000
Message-ID: <87cyrroo12.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Move MAX_CALL_IARGS from tcg.h and include for
> the define of TCG_TARGET_REG_BITS.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This may have broken TCI:

../tcg/tci.c: In function 'tcg_qemu_tb_exec':
../tcg/tci.c:391:34: error: 'MAX_CALL_IARGS' undeclared (first use in this =
function)
  391 |                 void *call_slots[MAX_CALL_IARGS];
      |                                  ^~~~~~~~~~~~~~
../tcg/tci.c:391:34: note: each undeclared identifier is reported only once=
 for each function it appears in
../tcg/tci.c:391:23: error: unused variable 'call_slots' [-Werror=3Dunused-=
variable]
  391 |                 void *call_slots[MAX_CALL_IARGS];
      |                       ^~~~~~~~~~
cc1: all warnings being treated as errors

the gift that keeps on giving ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

