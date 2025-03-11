Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD707C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCA-0001AZ-00; Tue, 11 Mar 2025 08:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzC2-0000xa-Ch; Tue, 11 Mar 2025 08:58:46 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzBs-0007pE-Ur; Tue, 11 Mar 2025 08:58:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff80290debso7719591a91.3; 
 Tue, 11 Mar 2025 05:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697914; x=1742302714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBgrSU/V9kiJHYlPQWXMJ6s9y81s7RCCnVq7DtgjGLI=;
 b=RvCu2h6SQ4K1A5XZ/zwwX8z0ORn0Y8ZU02QGHhOCD8bPzynVdovCZ8BwP3Ae6HHHvd
 qnk6cmePQsD7kBDKcgOKhiP+KHSvYy7f0iH6fp++Zprqa9icIiWeYPaFOXM4Wg1FrLJT
 kGHW3DYmmHrs/ED064+3apWU3LhhIBv4S73FJZxsqJGbpba24kV+xdogVCTB7UjIqPNE
 tP2KfM/8vWlIjFFQlJkEMpdsPZMnZf1jMX9cIEAbgNu1czRHT3/Tq25AFjsGk5WRVqCw
 ZbCfazQA0DKhzjIMskIImMbBjJ51jDMDDx5E6cSi7jOOYOyVpiLddcK3eNAfkcYgf0Qj
 CNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697914; x=1742302714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBgrSU/V9kiJHYlPQWXMJ6s9y81s7RCCnVq7DtgjGLI=;
 b=LREkTCp9j+nfWkTHTZ4RHJVs4fT1MIUT5qssqO+U5K+Ne5FgyVdQLXwRb9LB1pQG9u
 wnjYvwWGNsMj8FDivi2ZqeMifRZDbTese91quJcPTIul2rS43Nl5RskOuMal2lI2FxVa
 hKQSzdKBf/fjQKygmQpvAG54zeCOo7FnAa7g1lyVoCus6RoH8/iIa7UkGRVRZtfPaMjE
 QAUSMzXbBZpUS7Ckt7GlrrJlMpq19PkNlwVoCLDgSGMgyAtEV9O/Xh3RkGeqxge3unxy
 y9saf9Yxw97+BdD67LXwFJJAkJ0fFzL+2e38NDOyp41pwmn5NnFXw38p9QK0KOIZpAoK
 +qOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWmpsbMbZPS99fT2RdigvurkQU5rwUIuk+ybYDP2rHhUrjHCs7Rio7bwZn/6+VZtgzbji06MxstQ==@nongnu.org
X-Gm-Message-State: AOJu0Yxf6LbiaDyghklLQfMMIgfmkh5mQuEwQ2FHsDiKq4c3eQNbOV5c
 Gdr64HAWL+sMwe7Fc8CzSYF6G5wlqi/CcP5zQ5CkSdvK0TaVJ3V7L497TA==
X-Gm-Gg: ASbGncv/lo6//BXXZ7Vk4KS/LZRJmUD7hI03SLJH76v9J4pwo0oYnEx0jvUguPkqzQf
 gz7l0hXWAuMBvDNxxfRPoqjDysZvnZMpuNz9MFwb2hQQ+7E6PMA8wzTOoXtrF5VYSQ0xIIo56cA
 QCWY5td5Qf6kIrzzL2pmb7Bxh82kPKfyDBuhkkvk/w+LHcCAs8F1wbL/stuwhXwK5gSNCHl7Qpq
 qQ9JYYd4kCGiA21wGscQkCZzW+aQLocZIHeS0PSMZfnCdBIrjsnv6nNFMf+YIcFvPKzsp+Ke3V1
 piUv7caxjwrG4sV7awfSitXFLg8vgI3mPmPc9LEKU27HOuJS11Pa0ROr2X8eMQ==
X-Google-Smtp-Source: AGHT+IFjxpTwGyFJIK61Ujhn4nfL8tUwiE4L9lGL6UtH8mIRIcJfvV2tskX7D61uLejfWBGjJbpMTQ==
X-Received: by 2002:a17:90b:2d82:b0:2ff:6aa6:47a3 with SMTP id
 98e67ed59e1d1-2ff7ced8c45mr27732195a91.25.1741697914329; 
 Tue, 11 Mar 2025 05:58:34 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:58:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/72] hw/ppc: Deprecate 405 CPUs
Date: Tue, 11 Mar 2025 22:56:57 +1000
Message-ID: <20250311125815.903177-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

The ref405ep machine is scheduled for removal in QEMU 10.0. Keep the
405 CPU implementation for a while because it is theoretically
possible to model the power management (OCC) co-processor found on the
IBM POWER [8-11] processors.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250204080649.836155-4-clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 3d39d2a9da..e2b4f077d4 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -266,6 +266,15 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
+PPC 405 CPUs (since 10.0)
+'''''''''''''''''''''''''
+
+The PPC 405 CPU has no known users and the ``ref405ep`` machine was
+removed in QEMU 10.0. Since the IBM POWER [8-11] processors uses an
+embedded 405 for power management (OCC) and other internal tasks, it
+is theoretically possible to use QEMU to model them. Let's keep the
+CPU implementation for a while before removing all support.
+
 System emulator machines
 ------------------------
 
-- 
2.47.1


