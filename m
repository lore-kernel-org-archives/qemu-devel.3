Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF05D12D50
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 13:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQmbG-0002yl-S3; Wed, 03 Dec 2025 08:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQmbF-0002yc-KI
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:08:53 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQmbD-0000HX-BB
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 08:08:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso4406726f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 05:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764767329; x=1765372129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKRAQovvaI+/XnwttJqWqWC3SBPD0B4UsXTxV0X3LhY=;
 b=flR8/Da2j3Zh0Utgjmo5eg0jmDfIHGE2xdzsYeZmprH4R3iyZG0KvebglRVMsQeyyQ
 hJ8mZdlWysmKAv+osgPlKSGy+b/2GgnHw903FR3p9qbe5zhcXDniKouzFISRLBop0UE6
 KQMv2EHFblDFH3tHC2+gtiiDrfYuSfU+wnvT1CcEQBAzQeMGgrhksuZjgQ+F2iKPHEv1
 LpROtNZrzL/K/PdeiPK8kBWGX2jeRSTM+IMbK+/k3B5S5K+69n2EB9XaNbHnsoXwLK+9
 w1gBD0ZllGHgvZ4Nl5xMUkw50fAdCgnurpKaRNx5/Hr2nqSHpPxk3UgF6I6d/uPN/R0w
 w3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764767329; x=1765372129;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKRAQovvaI+/XnwttJqWqWC3SBPD0B4UsXTxV0X3LhY=;
 b=pwjFRO73hOlxJrBC/L8ADb8pnc3200MRsK3jRrNlRl4cPoPoKtfdbUHIP6Jzd9wDtE
 O4++CFCXSGmghmP/aM8B754eP8Um7MVJySU/UqIcQ1chSvf0SllIF5PvrlNLjH9Au+ix
 jJQzxNFXHs69zLIIGLhBETqWEA2RwalJQVwUw8GNwyF9UIAnvgIX8PQI//t3AXyYhJwN
 ABIdaRZy8U+0G6Gbr6NWfmQ16svZTOPbS8BnNqwz7VGn9v+sJfQx4gc2ykSi4FjnH1rI
 8wVfuxlLl14WCczp2Jn4N6ADGtYXTQ9r5ScDyyUOmKAOgri4sZzn19SnlwarPg6TZ9Kw
 Kotg==
X-Gm-Message-State: AOJu0YxW9vu9TUAw24akx4a39I6SPHdKWx0t1FSaeGJ6HFmRK8/9SQPC
 qudQ1ERq/zhntACnDbsTTX1pyj85w5xKROpGOFNNogTpW2CuDAJVVo1EcG7Iucyg+IY=
X-Gm-Gg: ASbGncvKz9e9QwUKZ8tqIC3uPvrBKMd6g1qSv82vewgTvpyiWaqUlcIORcsNE5Mfhau
 fc/x4QQDZExd0gStnzXC2GCOr6PeEVgoVaB2RuRVry1U3hYQ95K482m0yp1jjXSX08ua6+UEnaH
 XfemgtdHIUZTwkHgnL7jyuG5uZ2SIJVedc1f5kffvF6XsRPbjrDy94Vavm7B9CdoXeaxnzUDLLc
 ztHUBYK5CpNXtEs3HDbBZJlNZGFZFA585naBHWqA2tFQQIGz24BL64DsNdHWeYUOrHwqy2AsvKk
 WJVj9vQwi2M3XeFrvItV7je+Jzl7jwyv6olUQJv6GgCDzcoEibrJg/4R/PHuwZBlyocycoXUjUH
 beuzhRO12C3R/3PGR+JY5LcodtWZIDavpv7CA2WzlsHDps/+eLLblKw/iWy7bHR0A3D9Cdhi1fz
 +pS/5XkQ/x55g=
X-Google-Smtp-Source: AGHT+IEVt2uYKglnaWvxqM6QwWHo3cUPY2zZ4MpwiWzwL5/QoI4EQl+eSa1uhfBMcc2uwnmOmZ5Jfg==
X-Received: by 2002:a05:6000:25c2:b0:42b:2a09:2e55 with SMTP id
 ffacd0b85a97d-42f73105c6emr2436821f8f.0.1764767329164; 
 Wed, 03 Dec 2025 05:08:49 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d6133sm42417811f8f.16.2025.12.03.05.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 05:08:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A03F55F7B3;
 Wed, 03 Dec 2025 13:08:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org,  berrange@redhat.com
Subject: Re: [PATCH 1/2] docs/devel: Correct typo
In-Reply-To: <20251202131934.17324-1-AlanoSong@163.com> (AlanoSong@163.com's
 message of "Tue, 2 Dec 2025 21:19:34 +0800")
References: <20251202131934.17324-1-AlanoSong@163.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Wed, 03 Dec 2025 13:08:47 +0000
Message-ID: <87fr9ru2zk.fsf@draig.linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

AlanoSong@163.com writes:

> Correct typo in atomics.rst

Queued to for-10.2/final-fixes, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

