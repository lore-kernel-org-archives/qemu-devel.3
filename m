Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496E4E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 17:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIs6-0005Tr-OC; Fri, 10 Jan 2025 12:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWIru-0005Ss-TX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:32:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWIrt-00008k-6i
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 12:32:22 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso23146265e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 09:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736530339; x=1737135139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1geqepvWjvdNv6MYjhswXQ/0iKJo05ix/ma33tjNerw=;
 b=GUSanGj+NaHKdfEECf1wi4u/5fJGwlK4cTe6zdyJ00jPFurhPBO0eWoCVlllUBEuna
 QnZINmJAIQ5T992YUtTbwMgYV70eXCVB4pTcICmkYRxUIPoaoSZUcNCS0np9XlKagNny
 8r9voF+ZlH24fBxuwHrMv0rCDksBU2XQaZuSKxNi0933cAIwEr/C3mH4BOdaN8MTa3br
 vr/dSGaIa9ZQppRf/TaWWcQdjgEzMq5lZiGXOy+KNBvpV1F3gI84Y3vdWL2pUptvsjni
 7ZklZD9o0A930YGRymg/b5lo+VgYLoe9fZ/wpmNFhR8AaYEKFGAqshG6TzKypMIF9jyg
 pxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736530339; x=1737135139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1geqepvWjvdNv6MYjhswXQ/0iKJo05ix/ma33tjNerw=;
 b=fnGDL9QH9TZBRtXEvEtDUcOW+g4k4bTuKsjNOxNMFauwz8o9x7dmcjkq5BcxEQuhSz
 lH6ximMZa8vxgWZgbf6XVV5XXWu4XJhuWP+NwOQqCFCY+kamSAWXnGAwm/xaXiFksk8H
 6wVRGGAPUAB11ndv9hGlLOnFs+/dxaQjt90iyhQgrA3lOig4v6gQUCgdEfGpO9ZTOUw4
 iQcD8MIanH3mvwhipNmjHxCc8oZtOpOT+BzzKw5mo6D+Mz2T5piPLcV4WLb7Ap/Ew0ni
 3VTqwqAgYFip5oBlEv1amjonInP9olyAb3zpcNg2g4dkLqyolryOGk14D3kjOKqZhROJ
 NLFw==
X-Gm-Message-State: AOJu0Yy88qwGCNY8WCGfijuF/O5SdkiHeq5q6p1iBiL9h3j5UCqe6FNA
 E3mXZzNfYEBD70F2Lmv5GHMDV6vbkj01GHSsR0lxv+K8RGrVBM63bbmi8QMpDHVWBrkG7xKPpbB
 ZIPA=
X-Gm-Gg: ASbGncu17BvZ7fKlmF759Y2pgguErWAYJAf1MMyInYLspLIjEJBeHMs7w7q1gBChhcw
 CEGvFNAa1K2RGJlmrPR8/rp0dWwSLM7VDtOOL2kOKenjqJwmhou46OY9pkfx5ACRGBajm1B06iV
 C2E5ZBDhI3OIGh3tV5wVhNQUw5SDiAYrkzg+WqPOjXcwpEiBbibrXZyVO1mTcPBYjkj0qwzEFY/
 1h2sMV8Yf1k5VdNrKX8qKaI5ZZYwushPpgr1RtoUocyFtr0OcOKVOMA4LjHq1yvy1RgPAehfEYn
 k1ONoaYLinqKafUQp3Q2FdDx33dMxMQ=
X-Google-Smtp-Source: AGHT+IHTvrzdlXpddjRLdHG8FqPbb3QGsKjsNI6X7RnPsxFOm/B3Nvu0ijtECqaNCKLHZ0snWtMnZA==
X-Received: by 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id
 5b1f17b1804b1-436e26d0cf9mr101839715e9.19.1736530339335; 
 Fri, 10 Jan 2025 09:32:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383965sm5142998f8f.31.2025.01.10.09.32.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 09:32:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/ppc/prep_systemio: Remove &first_cpu and fix IRQ use
Date: Fri, 10 Jan 2025 18:32:15 +0100
Message-ID: <20250110173217.80942-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

- Pass the CPU from machine as LINK property and remove
  one &first_cpu use.
- Call qemu_set_irq() in ResetExit handler, not in Realize.

Philippe Mathieu-Daudé (2):
  hw/ppc/prep_systemio: Use link property to remove &first_cpu
  hw/ppc/prep_systemio: Set IOMap IRQ in ResetExit() handler

 hw/ppc/prep.c          |  2 ++
 hw/ppc/prep_systemio.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.47.1


