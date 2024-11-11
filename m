Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19A7D3ABFA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 22:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAcun-0001Ge-SI; Mon, 11 Nov 2024 17:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcum-0001GU-B3
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:29:44 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAcuk-0006i3-Sg
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 17:29:44 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so3483647f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 14:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731364180; x=1731968980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+DQF4+IgvYfgWsDX+XzRu7OiFqnoAvW8JYRiJKK9t94=;
 b=BLNszsplYeKuCfS/tVnROaiRRLv1g5PqJgIRpDzowYLr2DTyBF+2c9fngRUAdViNqm
 4KNaIcIMo2cUyvEsZAXPtmc1CtQjUBg7hBqBImr0NUI4WwdrHnYI2AOuL5mwI/05Gzar
 lMb1x63iJ67pypmWy5ib89Z8SSUV//8sI46zWrrO0rSIwcf3appEZ0uM8jBdgX5z2dZj
 FPXq6F02oclP1Qomq1Ei1XoasUNnLiQ2AnYARK+a1wMS1Kqo3MbSQUJD7a7bpD+qxiCf
 vRNoJY9ZIbi/RSnhL3DnielB2vmWshiRK/Kw4cOIjbbP5ZTpzonJlNWBcxtB6Lk7wx2n
 hZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731364180; x=1731968980;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+DQF4+IgvYfgWsDX+XzRu7OiFqnoAvW8JYRiJKK9t94=;
 b=qrTncn6c16WMeTzbGJUWTai0rOygcgHAAF0eYvkrzk55STQCKRWbzaiwuBcVbopRIA
 P4WVf3ckaKjLVsDrH0AM65iV5bE0nOVOxjil7pL3t0vCSMe7DQojLLxtfKDYZGZahS+v
 Ozvazha/AfJtOCd43Ra/UxMM8SVrA1+n3x9FXPB+RJu4Vmw223BOBPpyFK2+VKcv7cg5
 bussA11/MST3sL0IcpiUrR+JcTlkJ7U4AQq5bNsyrEc0Ne8ZnN840ExUyW9KqYu+46vh
 4fMg+rpZ4YUNLcyTgaFIo7uF97zFNdfXPgpUkBwyiS4MMvKo7apDPzyvNsX7z+fT95TW
 Skiw==
X-Gm-Message-State: AOJu0Yx7aUBjBkw3ODBfpu1MalrYzKOgkZ7p+s2DDlrIa2ediPSoPngS
 Y3FU6379CyFQU6gVRy3GDh83EEhGNcaV9GDuhU9SN4dCNpr8vkpnTuTYS9Ad5lxudKLb9IgyAUG
 C
X-Google-Smtp-Source: AGHT+IG0+HteHe6oNY01bC02QK/jonYUz1x3HJKsQ+oSn6XgQ61LPVUjSUTOSnr71JU7nul3CJ34wA==
X-Received: by 2002:a5d:47a8:0:b0:37c:bafd:5624 with SMTP id
 ffacd0b85a97d-381f0f85819mr12514850f8f.25.1731364180295; 
 Mon, 11 Nov 2024 14:29:40 -0800 (PST)
Received: from localhost.localdomain
 (vau06-h02-176-184-43-163.dsl.sta.abo.bbox.fr. [176.184.43.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053051fsm187695435e9.6.2024.11.11.14.29.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Nov 2024 14:29:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] target/mips: Convert Octeon LX instructions to decodetree
Date: Mon, 11 Nov 2024 23:29:33 +0100
Message-ID: <20241111222936.59869-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
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

Hi,

Few old patches lingering on an old branch I'm trying to rebase...

Extract gen_lx() and call it via decodetree. Trivial IMHO.

Philippe Mathieu-Daudé (3):
  target/mips: Extract gen_base_index_addr() helper
  target/mips: Extract generic gen_lx() helper
  target/mips: Convert Octeon LX instructions to decodetree

 target/mips/tcg/translate.h        |  2 +
 target/mips/tcg/octeon.decode      |  8 +++
 target/mips/tcg/octeon_translate.c | 12 +++++
 target/mips/tcg/translate.c        | 78 +++++++++++-------------------
 4 files changed, 51 insertions(+), 49 deletions(-)

-- 
2.45.2


