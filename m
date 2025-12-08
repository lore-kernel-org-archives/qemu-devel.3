Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21430D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXwe-0002ut-75; Mon, 08 Dec 2025 04:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXwU-0002u4-Pr
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:06 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXwT-00007R-6p
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:54:06 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e29739ff1so1722171f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765187636; x=1765792436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=paGzFyo53OkBV/BdGArZazs4ZKWQyyJVqSX+sId4Inc=;
 b=B8ams8Gp/qJc6nC2otBcb39NCuCNJmvef1rtKEesXt/Anec66dsoCKimACgbjV6/Fe
 Dw2JVlQnSen6/FH0UMgkk/JNmSMOgFqp5b6cVPx7P4EWWB+XkOSfOEHRAeKWDzqtgiwV
 A0bxtPnThYWLSYORRVRI/zNjJrzpUuyVEMMupNTCwelHp8/0d8nNXq6+cpx/wdhI2DLf
 xUMuxWIbcKN1ep1z0zZ2bBoF+Dp+JCpOkYTlisYMXGbwZvVnSDYUwDb2aBEXvB3C/5yf
 AdH/HtvX2oX/mxImQQesey11UbV55lxIPI/wO4A503OvLFDIMNP3v8Yq++aui9LntjaN
 EfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765187636; x=1765792436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paGzFyo53OkBV/BdGArZazs4ZKWQyyJVqSX+sId4Inc=;
 b=JKfr/GBUyrX5RtydC+TPUduOAEeFsLBwMfBDpI+tUSMqlpgfem1j+fK98z1VR0KJZy
 SSHtJaVEawlIyu303cIgOHlQloKOEa/2cuXO2o2BXM6jH9S6iQ43vPRuSaQdYmQzGC3F
 JV8AuaNbOMHn5SQnaaCldbowh0rTvPJrogEAhxVmJGAG+shJ3jnlsY+e+QEKEFVMjhDl
 WPOnnYiYn5YS4g/qhWnpTm0Y00rtcL3OK2ABunzBmJgzimhxXNBsXwo3MYKulstu+sW3
 PO+Koh3AL9sk2WH4kC2dwUFKzLDZb0ZrhM6i5ODqZnFNfn877ECEGU7R03BQPa2HIOmg
 UViA==
X-Gm-Message-State: AOJu0Yzqjftwomso1AZK2A4cE6Q/G2UBS1CuqILpM6JMVQXOm21Q2tEA
 gKSzBWjcZ7QGnD8hCz3okWRaMJknRlKfotp9GQek9vNhF7hTqU05AwDSMP3ukBcOurQTW8j++m8
 aC4BssfY=
X-Gm-Gg: ASbGncsvFcJ7x0Ixe52Yu6yCKb3BYc4YcpwpNWU5SWARL0lEWDLZ99X/JVlmPEHa2X7
 dll9AwpYDz7dTGVfirjxI+7npFJe933DV0sP0nj2GrbrYrm5iXE7KXjHg5YpLK5fDOUNm+PB9W2
 vDfNTyQ44vlKHKtTIMRzdN2AkNf6yN41kSq8G393O/P3Et3RUARx/wPO1U9UBkz/LVJydPdNQTv
 mYi+xoWCENXoOq8ao1XLyPeV0o8U9omuFy23IB1Hc3frox0iDrbGeujVX92OfnllF0KheneHupo
 YPHWETt2zAtnxy3DxAe6VDIzbuXf2wIx/ZmLdn/tsq4+mUjH02/iSFumejYc7tywdI4kT1qcEAI
 5Fa2xOcdOpOoUwCy5HkEw3GtveUEst+dPOiYnfTERTRN/3ck0kMNqYyHaIwwNqjchSFKMOD/1mF
 J/s07WDer0A1ZsydiO7PxS6MH/QSYY5XA1VuQgXt4qP9vuUpV+bfShkXmBaPBw
X-Google-Smtp-Source: AGHT+IHUm2oZmnHW0B+pxLe5+bFcRt4EUSdsf+EFsTr7CBkYUCnBaiGh40p30hAxJ6zdEuU7MdgB5w==
X-Received: by 2002:a5d:5848:0:b0:429:d5cb:dd83 with SMTP id
 ffacd0b85a97d-42f89eafa93mr10124778f8f.2.1765187636170; 
 Mon, 08 Dec 2025 01:53:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee5bsm24739180f8f.16.2025.12.08.01.53.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Dec 2025 01:53:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 WANG Xuerui <git@xen0n.name>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.2 v2 0/2] tcg/loongarch64: Support every TCGCond for
 cmp_vec ops
Date: Mon,  8 Dec 2025 10:53:52 +0100
Message-ID: <20251208095354.25898-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

v2: Split Xuerui's patch in 2 to ease review.

Superseedes: <20251207055626.3685415-1-i.qemu@xen0n.name>

WANG Xuerui (2):
  tcg/loongarch64: Factor tcg_out_cmp_vec() out of tcg_out_vec_op()
  tcg/loongarch64: Support every TCGCond for cmp_vec ops

 tcg/loongarch64/tcg-target.c.inc | 119 +++++++++++++++++++------------
 1 file changed, 75 insertions(+), 44 deletions(-)

-- 
2.51.0


