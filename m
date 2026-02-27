Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869B6FEFB4B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:01:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvxTD-0004sP-8r; Fri, 27 Feb 2026 08:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvxSz-0004oK-60
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:01:19 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvxSx-0003Qe-LL
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:01:12 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b7cf4a975d2so260964666b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772197257; x=1772802057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1WCMnCAA+GpVtzd/jntjUdhyOOLXmW3poE0ezo2YIVc=;
 b=XaocvXukamAb6rpekxyS/nHOPyiXf4ZgUgOOUuUUsrQScmqm980OqSsrnx0LrQq/js
 +aYvBq3czt2I9ghMEcZN57eO5lXgIrfKd2Nc5NytkYmeCenyyuh3JWqpmjngXwD3QZST
 5X+afO0wnHa+fVMqavpCx7h9ukaXalhweNj9rYan0a0yHuraJb7rPkTvvGiX44Uw72z6
 vjZVeE8iB2Ebz6xZCaYpJP7cYihGUONsh3OMVjXzYh+BngYLKrbFYwqEVDqwHHEfw1Fv
 7aRXl7wZo+6S4Mn3AVApkKrddv8beJBu66PRwi1te7kFlgLKRgHZ8aliOrtHTtLU+ROD
 zI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772197257; x=1772802057;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WCMnCAA+GpVtzd/jntjUdhyOOLXmW3poE0ezo2YIVc=;
 b=TJFg+rS+TKn4nge9NSvCPN7qSikAWlKtlcpL7WErvSjI85rKyAbw8gRkbohwuGVZyd
 XLticFDrbDktDnTWuKsu5OEY9++UO341erIYSQVSYTE8ZB9U3T4vz8GZZH43c6jUicOj
 EHLUY7GlMNtOWjwd75hLV7FLtf7EOeaEJPSSn8rAxVMhdgeWiCEVG12bPATeZcs2w6ta
 jAFwHBEHOXV3UecL2ZeLNV1Hs1fwND6qd1pimtyrkW+0mrEtgA3iyT4B6csjXB0whcDg
 RnnbWE0AfLYzpHI4MeM3kHYTPsPgXYo32eZKuVe6uEWPvA0ljO7k7lxUANHxiwJK3Y9T
 yKwQ==
X-Gm-Message-State: AOJu0YyYIwoE3bi++9/S0GKm+k5p1gyHYISsu5JZfiYOYqFTsDJ6JDha
 QmJfC6aPMROJF1PwDouDmribeswwmQsYrMVq037XOsWZH6Zp9/1b80ASDgB5j6QXDKw=
X-Gm-Gg: ATEYQzz/mRgzGfoA7JGuZ1o3fH/QXW5a+wCA1S2O5p2X6hjhvWv4IFpzbBN+9Mew1Aq
 MgvMlrPX1rR2MvAE8JcPokIE66sfY9vDI0g6sJAOJ2qOFL7N4Bn+UluvdaQi28GAjTBJsWwxLAd
 QP6s9ygIRqC13ZZsE6/3YV4rXy6tbeemaFwiBKmIRZaErcTKOubhMxjkMCihjH0t/AJ4m0CR9BX
 VJhB07xvbXTUv7KpoOeKnToHWorY8zAKBOy5q9NzaC8DStKQm4nUAnINlqgx8vp1V+280DEYfiM
 sOdhCFg3gth487RFwpAr1KhAPkniU0MGaPwcyj0bhf2sLHNmI4/JhgnN/OXunDVtxeI2f2vUdMv
 QkITPy+iKP72CC0eMMnzROml1MbCZAt2CTK8Cb0F6pGXp9RDaSK2C7Nro6PS/X20thNHyUNzvFO
 s6rO4PNyiBJwiyp2Kwir2J+XA=
X-Received: by 2002:a17:906:7315:b0:b93:8460:4a7 with SMTP id
 a640c23a62f3a-b938460083emr44545766b.56.1772197256557; 
 Fri, 27 Feb 2026 05:00:56 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab123e8sm145035366b.4.2026.02.27.05.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:00:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B367F5F7D1;
 Fri, 27 Feb 2026 13:00:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 3/4] gdbstub: Move gdb-xml/ within gdbstub/
In-Reply-To: <20260227104314.81038-4-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 27 Feb 2026 11:43:13
 +0100")
References: <20260227104314.81038-1-philmd@linaro.org>
 <20260227104314.81038-4-philmd@linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Fri, 27 Feb 2026 13:00:50 +0000
Message-ID: <87ms0uxrwd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> gdb-xml/ files are only consumed by gdbstub API.
> No need for a top-level entry, move them to gdbstub/.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

