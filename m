Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308DCA5FB8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG5O-0007CA-5e; Tue, 20 Jan 2026 13:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4w-0006bB-Cf
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4u-0000T8-4r
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5184390f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768932223; x=1769537023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ObhW9j7iVZMnL/DYXgdUoxnMKmIHFreb1e5ON17wdqw=;
 b=wy/1oUeWbCVCqnd1xtFdhH44aUZV3aucseai9wiuMsSjHxkzPvJPiMEybKmbGV1tr5
 qfIztmlY1GLht78ZfbIgd3Q212+LY3U7kgeNVAYDRE+rwIyMO3ojYslcb7f/tgNq2HHL
 irVKRZCkqUkLRpVYHIXPYWVFxUQDoSXyJU7gIz2AGCp2Zyk09y1/dSchBBzZCTLtG52g
 SSPsfXUYi21iel9a6td3ts+eoqTILWZECWft5pwvhhTIzrqWLXaWZ1d4KxPEKl/h39oR
 H2Y6u3sxWOT96LvyWiINgUEEfaaj9MOgtaAMZzGid4FmN7g6d/OQeADW6ZgJKWlC/g6d
 Ldmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932223; x=1769537023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObhW9j7iVZMnL/DYXgdUoxnMKmIHFreb1e5ON17wdqw=;
 b=Aytd6FSMQ8XDS0o34yQUJ6uwWyUA6tKYVqscsoWK+ch33p+/13SjcJqvtPw+6+RPqq
 DKX32QgQufcdvA7iD+T6MbgEiAELQydCrdITyCCO6/TJDTTD2X1MRXhmwRWzT+SYQD0+
 +Fo/OrLMgOf2tKx68ZAHWJPxFg3fwfzK7S2zGeeGXdkBbBgLs2X+SSYPEioBt3Y9UTDP
 stCrUlp7k7kSTtRQ0HKvH+xAeu3rASB/aJXjiWk07QJ8FshIvqGVYic+CZzqFN1eHDrD
 lG6FwZzxMRmbys/PA33g32Mwz0D1sajEcRWgfIgaVDx9iV5E1G/H6x4UyybtxnnnM5gu
 MjtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVKP8iQm2GDQRFZOVe9ujow4wBfZNJ57OyaeOg43wZKvFqjk9Tz8H/U1L9Nw4vToghp8u2xXbupbCK@nongnu.org
X-Gm-Message-State: AOJu0Yylo+oxNRlhrkhg+j8ALRWE7EA9CXVBNxltx+VTLqI+dIhYUpBH
 SXWA+eHmjPTsWyc4n8DtqGy+D2/WV+8um3JwlTw26q0hEhtPuh0c7Im5aAKIGbOb5mo=
X-Gm-Gg: AZuq6aK0xVoGLmp6t+GTAEIXrvOEPvKfqPgo1ZiJ1E/Ul5fwLDVwG3vWhHx733z+ACi
 MeQay79ORce3jvq8I/4iDEbCWKlqSE1SqO3sv+IHGrSFZMboPfOyLZ+XRKMdIUY5xV4k2XSQ9VV
 IS4M8+HrKPDab7Zj1gqgX+RHg+IfMggpo50nLacaOBiVJqIN6Gg7lZQDY5G8RV8AC9q38Muf8Py
 gHbZUR7tEdUMFhITwsWX5/9i1zLYOl1AVG+cCLluOF0KPSrnRbEAjsfJnDwxBj5PJMYrueHxoEO
 fv/E5PyqdiCoCp0QV80BIWMf1gr20vsRFgx5ewjRdU59WMtaUaBdc/YkJuujrEYlqA2mU7fnQ+x
 ueu02AXCDGxT8873epQzEvUvWGkYz2uCxZdpLoagUkSR8sA2FH6LQW2zsIFOOx5fvylO8lipayM
 vte0tE8XpPt48KdEHKwKkDt4SM/Uu2QBVA/+ZH00zRE2yhj6KRP5n5
X-Received: by 2002:a05:6000:26d2:b0:431:1d4:3a71 with SMTP id
 ffacd0b85a97d-4358fef5f11mr4599198f8f.27.1768932221167; 
 Tue, 20 Jan 2026 10:03:41 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm31310889f8f.22.2026.01.20.10.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:03:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 0/4] hw/arm/virt: Deprecate 'its', introduce 'msi'
Date: Tue, 20 Jan 2026 18:03:35 +0000
Message-ID: <20260120180339.1416328-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

This patchset is an RFC sketch of cleaning up the logic that we
have for selecting the MSI controller, so we can add the handling
for "hvf and whpx give you a GICv3 without an ITS" in a
hopefully clear manner.

thanks
-- PMM

Peter Maydell (4):
  hw/arm/virt: Clean up MSI controller selection logic
  hw/arm/virt: Don't use vms->tcg_its in create_gic()
  hw/arm/virt: Drop VirtMachineState::tcg_its
  hw/arm/virt: new "msi" property

 docs/system/arm/virt.rst |  21 +++++++-
 hw/arm/virt.c            | 108 +++++++++++++++++++++++++++++++++------
 include/hw/arm/virt.h    |   2 +-
 3 files changed, 114 insertions(+), 17 deletions(-)

-- 
2.47.3


