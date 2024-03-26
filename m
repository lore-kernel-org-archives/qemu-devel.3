Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976F6C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAJZ-0006S2-EE; Tue, 26 Mar 2024 13:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJV-0006RE-3Q
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJS-0006X6-Me
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-341d381d056so980858f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711473012; x=1712077812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DfphgC1cwxQ4n12/gSrpOTjEXbIY4MpgcYXhU3OEoG0=;
 b=tXm9AQVCp2HrDr8gOxvwwNIlf8mUWHcmTDf1he31h2vzj/+VmzoyBw2BzDwD1+zres
 chiTTjg2RXkUFKBNAKLVCKNcIYEFThYWi0QnibXKxNtgTBNnd1mPG/msgYuSykhjpBEr
 SwPKgiZqW/sDeMLQD19LGzmtcf36XVyBNN8DZ7wNwTsf0opIzbHNTFekbBD+t94Mm2tL
 7q/ClvSP8XldDpTrPscskvfl8qN6Qp0qUCk7kwBxSEj86splw6iIvGFC1ZJptgeO0CC+
 mw2vnfwsQUngdlGTxW+QH5mQ7IeqM4g32LUTLNm4Z1rFTal7ei21zOnIRq+ODUXiF285
 /I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711473012; x=1712077812;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DfphgC1cwxQ4n12/gSrpOTjEXbIY4MpgcYXhU3OEoG0=;
 b=IeC0UiP2QBLk4y63CBSItpBjRsEMQpoujverMxDQ1VQm9fWIQiYDn0a9ui5C6iCQKV
 yC33ZdZoTKVjs0eqC+ABHpmnX8UAf26TydLn44tGMrZqMSlV0PIdT2fxpPMyrydOGSL8
 wtrEvHzLzLo5+SzmEbDkQ0qzVXDGE0C0JNYfq+exW7qb1ile2ltof6bFuwD0QV2PnYgz
 b+hmsi3kS0kW7ek3M4jaecxO+SA+DkoFNByV7SrY9BE6q0wdTIvnfK+1Lt91N4lSysL1
 FxfqoIYuT3s795h9Y5JSNSgHxO7Ne5IPj++WjFXj0J+w5GGG1/Ih7rqOZEMV5F4JIzGZ
 g20g==
X-Gm-Message-State: AOJu0Yw9Y+OvkjFQK1BarLL8zBJ070XCrvEs6bpTplcqUrA7qlgQ63yP
 2VGsmMmvOFX16+XLTztYZOKl3gXUqyqkbyBrG/egyN1Mque8CBE+qytThai7RPiHkketVkwq0u2
 l
X-Google-Smtp-Source: AGHT+IFrjYqA722H502bYPdcfKZie7sYcxBJI6LLMGJcNWrPpBZKs7QWwTo3IJUWpFhsRumhRIGKeA==
X-Received: by 2002:adf:f011:0:b0:33e:6f9b:7abc with SMTP id
 j17-20020adff011000000b0033e6f9b7abcmr6512744wro.65.1711473012259; 
 Tue, 26 Mar 2024 10:10:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a056000018b00b0033e75e5f280sm12598614wrx.113.2024.03.26.10.10.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 10:10:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? v2 0/4] overall: Avoid using inlined functions with
 external linkage again
Date: Tue, 26 Mar 2024 18:10:05 +0100
Message-ID: <20240326171009.26696-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Oops, I forgot patch 3 needed rework :/ Is it too late to
enforce that flag for 9.0?

Missing review: #3

Since v1:
- Reduce size_to_prdtl() scope

Mostly as a C style cleanup, use -Wstatic-in-inline to avoid
using inlined function with external linkage.

Philippe Mathieu-Daudé (4):
  hw/arm/smmu: Avoid using inlined functions with external linkage again
  accel/hvf: Un-inline hvf_arch_supports_guest_debug()
  qtest/libqos: Reduce size_to_prdtl() declaration scope
  meson: Enable -Wstatic-in-inline

 meson.build               | 1 +
 tests/qtest/libqos/ahci.h | 1 -
 hw/arm/smmu-common.c      | 2 +-
 target/arm/hvf/hvf.c      | 2 +-
 target/i386/hvf/hvf.c     | 2 +-
 tests/qtest/libqos/ahci.c | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0


