Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD02CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waChX-0001Tb-Ni; Thu, 18 Jun 2026 09:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waChW-0001TK-T0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:22:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waChV-0001dr-ET
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:22:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4923139e940so5278105e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781788951; x=1782393751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/F0+Ax1zYQEzhQ6Gr26gkcQR7UbRcGCmo9VNENRVu1s=;
 b=Ml4QFCxmUzvxnzvsoBCF34U079p0bwCo2PyzxHlsIo+v9ea0FpVPPrarOLi6HJ/f62
 +ELLKXauIK4QadMCSOf4/YQHL8RdSrI/slp2n+bS17mejPjfWtdLM+Uaj1vdTdFZeVIt
 l1ea84o3fxRjHMwQws5iNzkMFqhTGTZTorWtSH3NNpthF278HMfJDDq4j1t9gRNt7NqP
 g6OkAq8aBUJW5cxpYF5ouGthPQZH+bgBBoxEkv3507XgPVpB6LJpjxfbSz6YJz3omZvl
 FY75oey0d6tsRR+Do9g0BzS7W7GNP5nJIfqb1TU28qoGw7/4FImL331W2xTb3ejkeAdw
 NdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781788951; x=1782393751;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/F0+Ax1zYQEzhQ6Gr26gkcQR7UbRcGCmo9VNENRVu1s=;
 b=NTm0EdmYqyRUlOFz+1hiROg8Mt59H11+9/Ib6I5ctxM4JsLwP/vTNi4eEshxG58pQq
 OSNtTU9dzvvINsi351j63gs7LlTueaD3koZSM+vrJoyKFIZ9M58o6+nVEa0QcP6SxsjN
 CXJHDV9EfCKPbhAWjtodLNiG2GsTncER+Rqn8asl15WI5bWI1p0wyTzqdRyMicU4Oe7Y
 RWyUf/Y8YWiWDpevwolwJH0fw+CNqaXtmKOeRE7gFzh07Xavua6EGAxY8eRqOZ/aW25q
 nyqJBikbOORInJ8YzqjJX8nlmpnqx5XdJ+5fTJOwRAyrZ/kUlD1TO6Fu5C/s7H2k5Iho
 +EyA==
X-Gm-Message-State: AOJu0YwZ9DfBHEmW69gebSlBaLOwI3GkFufW6joL2I0nUhWqP6pcXXTa
 TRVX9+kqc/K3V500LdGfo7xCDBL5mg4FzeKPBOvC1tOj8YdED0sg7MXjXxPjPQGcLaE=
X-Gm-Gg: AfdE7clXNWNM0CUI3E5IM3UL7fbyFDJFZhmMZ1sCXIBcIe6zG8tY9XQZNmptQ5Fpqqx
 jwRxdcV7JY4sTXVHiZN2tDnxHQ+uZTSmDz0KQzAjnFJYyfashSEKaIq8kAz4VbM+NXTu8+j56PZ
 dGQZG3zvZXt7dNZx0ia7izRKjVwoK6OTYvVDIOSRzKP45uKs1QM18I8DnGcuEzf4SV5sUkTXILm
 2EydU45o3QO85EsxPlTY9nuk7MNjiAMJBgIDRI0PvnqLyjsihlM0FT/6tcDPzyPqyfUt2e4EFaB
 /sx7jLRvscgaCgJVcugxRUgsbwZeNp9IOfhnl/CDEW6Ze0XllBDAwPWxSbeYIy0QeOD6tv8sU/z
 IPC+aApxLRmTo4+w/0YNJKvBFQaquR6FebHSXYjGXZsaInoxbvNZJT7GmiF/f6czwOOQoFb1gDx
 jsTe2nwSxM8w+e
X-Received: by 2002:a05:600c:c84:b0:490:b58b:a8ca with SMTP id
 5b1f17b1804b1-49234131ffamr119754035e9.27.1781788949696; 
 Thu, 18 Jun 2026 06:22:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d2d9esm41763215e9.1.2026.06.18.06.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 06:22:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C09705F905;
 Thu, 18 Jun 2026 14:22:25 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 3/3] target/arm/tcg/cpu64.c: Add FEAT_FPRCVT to cpu_max
In-Reply-To: <20260618-jmac-fprcvt-v1-3-1b4475bacf51@linaro.org> (Jim
 MacArthur's message of "Thu, 18 Jun 2026 09:20:25 +0100")
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
 <20260618-jmac-fprcvt-v1-3-1b4475bacf51@linaro.org>
User-Agent: mu4e 1.14.2-pre1; emacs 30.1
Date: Thu, 18 Jun 2026 14:22:25 +0100
Message-ID: <87eci4gezy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

