Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D81C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riID6-0002Te-O0; Thu, 07 Mar 2024 13:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riID2-0002Rk-Cz
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:12 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1riICy-0004Qi-Px
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:11:12 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51321e71673so1265967e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709835066; x=1710439866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IH8YxlTbSFFE6WXD8byS5PFVC3jXcSt1MmTksNm3ntE=;
 b=yhOr1oPKCSw5KaRZ8hdxvTrGPCS5NLTjbwjGpjEdDTnUhzqPeYfK1q1Og6cnzL2ByB
 8xFqNzpLXHDCwBwsrooddBYP7kRwiLR2gEnriy4J/MmWVH9topx4ukbeddKTROV2VTje
 PUHbPWHC/q7CuCJ29/I+EQUJmJ3ZS6oeCp4vyCb3RaRNRTksRNk04otcJwAYE7o4crkT
 bCHHcalWabDzl6RduWk4cxCF1fQSKRYQsB91WFOzBFyp4017gSlmjIGSdLWeAi8kRFE3
 XgBMx9Y+0j1zB6Ak/Dy3VVS6w9XFdp/Qq0u2hjuO8griKLz492riPblLuzgnUXfZZzqN
 zd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709835066; x=1710439866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IH8YxlTbSFFE6WXD8byS5PFVC3jXcSt1MmTksNm3ntE=;
 b=vjIf/OGD98rFRGGsWcOnqkXxdCO1KcrW3ceSCr+QLsegERLvkUqIsReh5ejkjFVAdA
 /3HtOFbfxV7XwH9rZBauQ4OvhPLM59GpI5Qd4uc6/Jyn3tUB2S64XxlIAU3MXjdwj+Zd
 +Ln0RuBTLe8fU4cliUVbX08cmLuFEhjdFudQDY41XlTJCJyyQYgsjAABt2pPTZcpA26H
 4TSwyQ4V/1IBADqnX9LY8LFRtucIXlA64yZgg6JthQgA8sa3c5Qb75e5npxD/1VFxU6+
 WDN9AOMy4fubAgCaLSrnHzt3wsCExb8SuOa+cY6GkYZz8LlGY9OrAp19WP8oFeMH7jbT
 R+Rg==
X-Gm-Message-State: AOJu0YzePfdthVjoqyhwZ52XV+dateYB9XyxVKag+nHMVCRXLohnBeLj
 BUFb88hvJhoGepKQKIgIsY3SMQCGMvY4MTPusFtXNaKsENpqMb7VL4pPvksveNo=
X-Google-Smtp-Source: AGHT+IHWxAPLvpkmB1sblxbLye5fV1cNX8vt1XeXz5dm0RJ8Hy39vcqfyAOH+HTkw+baz7LPLylPZQ==
X-Received: by 2002:a05:6512:104b:b0:513:28b9:76da with SMTP id
 c11-20020a056512104b00b0051328b976damr2557089lfb.46.1709835066238; 
 Thu, 07 Mar 2024 10:11:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u15-20020a05600c138f00b00412706c3ddasm3460168wmf.18.2024.03.07.10.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 10:11:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7844D5F7D9;
 Thu,  7 Mar 2024 18:11:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 0/5] docs: improve the memory API documentation
Date: Thu,  7 Mar 2024 18:11:00 +0000
Message-Id: <20240307181105.4081793-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

As I've been looking through the Memory API for our Xen work I thought
I should take the time to clean it up. I needed to teach kdoc about
our QLIST_ macros and I found at least one unused field in the
structure.

Looking through the definitions I do wander if the meaning of
romd_mode and ram_device could be cleaned up to a single bool
(directly_mapped or use_ops?).

Anyway for now just cosmetic improvements to the docs as we are close
to softfreeze.

Alex.

Alex Bennée (5):
  scripts/kernel-doc: teach kdoc about QLIST_ macros
  docs: include ramblock.h in the memory API docs
  include/exec: remove warning_printed from MemoryRegion
  include/exec: annotate all the MemoryRegion fields
  docs/devel: mark out defined functions and structures

 docs/devel/memory.rst   | 49 +++++++++++++-------------
 include/exec/memory.h   | 48 +++++++++++++++++++++++---
 include/exec/ramblock.h | 76 +++++++++++++++++++++++++++--------------
 scripts/kernel-doc      |  9 ++++-
 4 files changed, 127 insertions(+), 55 deletions(-)

-- 
2.39.2


