Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D1E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMBA6-0003q6-8Z; Fri, 13 Dec 2024 14:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7n-00080k-Io
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:59 -0500
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7j-0007ft-1C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:53 -0500
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-29e149aff1dso667498fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117289; x=1734722089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OnU15FeM5nm4zjB+qIgK7H2LoZzBt1ZnxMW14wBH+c=;
 b=L8HGTFSyUzRaAdW5uqGI4XDd8gckTAX+aCjlAetd7H3L+Y/KZfM7BdBaOfu15W9Tq6
 BAiJXPzZdcWG1QgGyFjquGlhKOKfqSAo4IdNblfU5vvieJ7O3D1VfrnMQWM0NPayM+vw
 rSg3lQyIVbVIaMON979BRxAQIoYGzX4HuhVofoDfHVaGgnP+VhAC6H/5fYNajcH34WJ+
 Gifeexa9Cpbsn23QBySlI8HWDnGovZVeEFHclWv3KzfA5kcfftgdVI5uqbfCGKwHMoL7
 9u3nOIet3epH9BQ31Sa1b/mngt2lC4I8FSEMVZbZo9iO2LX41WSQS9aWNujM3+07goEL
 0wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117289; x=1734722089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6OnU15FeM5nm4zjB+qIgK7H2LoZzBt1ZnxMW14wBH+c=;
 b=HQBkS4TihHPPv7eRp7BoJw2oEQCzVYwlZG+TeyFWVk4dI5UHCMxVnohp7nvYHnx1Km
 +nrU94aOHK3iZKw0Wg6Ay3w2r7gCpOIlcvwD8q5/6DYa5MBfv3mpY8H21fRE6jZUdMiT
 KAHsuZRLFtnqO2aKtg4g8PuV+2ctP1a1DsqdNv5ZE29MKiU27Ijp0X7L1VhD/NNlKDIO
 pfHv4jP214TbpNv0so2AfFO6QnQ97941NzjlqqF7gwIS6CUe13TGysx+mqhzpFjlwhkY
 fvFLPtScf3rTwouHv/Ipz9QHX6Wyi8wMZDa0XjidPT6Sy1AzuybbYJHt8xl5ql9ZnIp5
 g7gQ==
X-Gm-Message-State: AOJu0YzSrrhdESu98CTtQmSxtgY9Ylwi4dpU5caaVGRfsj3VKEudhwbb
 iI9kUReOEVlQcK93oRuhSSDMTmQoTQiZG1vPNNYQ0eopNmmxuvNoNhDLACo9bMmuJ51LLXVAvF4
 a7MfgKj0q
X-Gm-Gg: ASbGnct3pffhM/5qb6ffA7+r1CrCVszv39p3r/9i1cCOYGqnskhpi7VfeLOqTQlfRCj
 6aH9bmxMVvj2nir4vDmheh/9pYa3m/iCbUZBEnAKLRRtM/lFx/eAShOw+HTmZeC1zGQLcqu0pEs
 wLrXUNFwj1a6AMe9NJUuElfrR24c4M0GZTezZFPnUfHh7/rPpo4dTmaGc8blXdQlzWvTfwkZNbc
 9/nfALmlrB3yvbGCC38EGcJ5eIC6krSjZO1QzuzYlbPCrkf693WacnoaLlW22Vs
X-Google-Smtp-Source: AGHT+IHBaL8kU6aH1nsbh/jV9sNueSj6IVgpCh5TYFJ+elqWaL/x8lEG+im3oCTlGW5uW2PWj4PG2A==
X-Received: by 2002:a05:6808:f08:b0:3ea:aa8a:c121 with SMTP id
 5614622812f47-3eba68957dfmr2183697b6e.22.1734117288969; 
 Fri, 13 Dec 2024 11:14:48 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a497sm3545b6e.10.2024.12.13.11.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:14:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 61/71] hw/tpm: Constify all Property
Date: Fri, 13 Dec 2024 13:07:35 -0600
Message-ID: <20241213190750.2513964-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/tpm/tpm_crb.c        | 2 +-
 hw/tpm/tpm_spapr.c      | 2 +-
 hw/tpm/tpm_tis_i2c.c    | 2 +-
 hw/tpm/tpm_tis_isa.c    | 2 +-
 hw/tpm/tpm_tis_sysbus.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 5cd5a2533b..2bf6e7ffe9 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -226,7 +226,7 @@ static const VMStateDescription vmstate_tpm_crb = {
     }
 };
 
-static Property tpm_crb_properties[] = {
+static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 5f7a0dfc61..e15b67dd45 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_spapr_vtpm = {
     }
 };
 
-static Property tpm_spapr_properties[] = {
+static const Property tpm_spapr_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprTpmState, vdev),
     DEFINE_PROP_TPMBE("tpmdev", SpaprTpmState, be_driver),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index c5548b0a45..b27af230cd 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -491,7 +491,7 @@ static int tpm_tis_i2c_send(I2CSlave *i2c, uint8_t data)
     return 1;
 }
 
-static Property tpm_tis_i2c_properties[] = {
+static const Property tpm_tis_i2c_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", TPMStateI2C, state.be_driver),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 21109edcaa..9b2160972a 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -91,7 +91,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
     return tpm_tis_reset(s);
 }
 
-static Property tpm_tis_isa_properties[] = {
+static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 967f264634..88c1f1e478 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -90,7 +90,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
     return tpm_tis_reset(s);
 }
 
-static Property tpm_tis_sysbus_properties[] = {
+static const Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


