Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263ECC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg86j-0007Mm-K5; Fri, 01 Mar 2024 13:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg86h-0007Ls-I1
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:59:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg86g-0004KQ-3l
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:59:43 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d509ab80eso1108337f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319580; x=1709924380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ForxCwRxQPhQOXs3n4FwdU8zqqg+YL37+9IjHlcPlAc=;
 b=bLIgXrNG3AxczG0vsjpK+iUjJj+NO0OJn0Sm14iiT/YLVhCqp4bl+XU31xvmguCj84
 5VaTED5mfrTBLTCkGnHMh4SNguB3M25o6aaH8DB4hkZIktS1V6uDhNsuThRd17Xt2fRX
 3uuu8UPPGzR81veUE2hg6mpWmm3LF/RAKXG51Rw+qWK+NuzoI10o0ur4lGAsn2Jc10ua
 Uh3ZwZD8Zn384dgAo2d6LePQx99WN/d3fcMbGXqghAo+Y8UNCCBcKLX3UkXMz3Lj/TjT
 jcObZp32SOoUxpYq4MS49YtLPtEAk1OiKmzLtidzvODfzbGjtSRRAS4v0EnBvRlQjyCs
 nNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319580; x=1709924380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ForxCwRxQPhQOXs3n4FwdU8zqqg+YL37+9IjHlcPlAc=;
 b=eRYFeShxkesPAQwmZH6YB7dKeDDFkLf36I83chp8r0Ljst6EAJbC57JKm7Y2k/b2VK
 MeukX+kO3m3DTRKNO/h1hBi1RuzSvw0foaHPWvkjupPzHSnIQBp6Lpy67UHre8ZjJjyx
 Q/ikauz6sQ2qXhEgkqANho7IiXUnn+q0iLIgBn3+tbdV0wzng+JrWkQEffocrQq0NoPJ
 QHoJaV2UKzE/T+hdalN0nTMFaedv67jJgPKdLWDObd5My4BcUpwQLGJNVFaYYVtAVOEX
 zWZlLxsI4BwOLKDt/DUFItwpW8pZJETyXs6U3nS0r7DMVQ5SszgtnLf6Umq6SdsSdyxW
 yOww==
X-Gm-Message-State: AOJu0YxuO2zPlzHob8TmWz2gYZ+/UvF87Y3rBmslQlGp09BfeOcUDof7
 CnkgOAcMX4tUDYbZ3XuqpGGrIA72a5zzMOngjbARTBs/y6tzE2LjNWuPNe1Yja8m1HUZddGf9IU
 O718xXA==
X-Google-Smtp-Source: AGHT+IGoD1o0u7osqWHycHOxow0ZB/NLOF/AvtpVZA+f1LM9k0sycOJxjAsC2txXYEoFcmNkB3oagg==
X-Received: by 2002:a5d:58f4:0:b0:33d:5e19:e1eb with SMTP id
 f20-20020a5d58f4000000b0033d5e19e1ebmr1903848wrd.9.1709319580145; 
 Fri, 01 Mar 2024 10:59:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 bu28-20020a056000079c00b0033dc7e50488sm5405762wrb.96.2024.03.01.10.59.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Mar 2024 10:59:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
Subject: [PATCH 0/4] hw/i386/pc: Trivial cleanups
Date: Fri,  1 Mar 2024 19:59:32 +0100
Message-ID: <20240301185936.95175-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Trivial cleanups, mostly around the 'isapc' machine.

Philippe Mathieu-Daudé (4):
  hw/i386/pc: Remove pc_compat_1_4..1.7[] left over declarations
  hw/i386/pc: Use generated NotifyVmexitOption_str()
  hw/i386/pc: Remove 'host_type' argument from pc_init1()
  hw/i386/pc: Have pc_init_isa() pass a NULL pci_type argument

 include/hw/i386/pc.h | 12 ------------
 hw/i386/pc_piix.c    | 18 ++++++------------
 2 files changed, 6 insertions(+), 24 deletions(-)

-- 
2.41.0


