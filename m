Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEB5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNyCd-0001C6-39; Fri, 15 May 2026 15:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wNvpa-0003qs-8X
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:56:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <williamdapinho@gmail.com>)
 id 1wNvpY-0004xv-FS
 for qemu-devel@nongnu.org; Fri, 15 May 2026 12:56:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b150559bso270525e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 09:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778864166; x=1779468966; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J2Enlths/eUd5QhHIfN949Lxdj1bjWYVyTCF5+VraFo=;
 b=luDAsgNcSdUlceeZkOmkNV301W8plqeSvWhDJHGt7H+PLN5xAK7H0+C2egMhviJcwO
 0d4MSXZbvWQL+hDDdobmjDArQcspXJKil8+ipMLBmdiIbTrF8TBsiFeR/VRskCElqMOO
 +4/FDXdGq/RLxv8gPMQ0rDlMFTwsSvJqaD/WFJGhzJYfpDlxAhgsLk39xtxOzMORIhgf
 Z2oAz/Pmv5ncfufmajr4rTH2AfXbFfcpuawaG5YTJwq88EW4QS10G7OhcfLY/cUK8nky
 b1uP4ZdKq/YQEgP5zsKRf0gVj7VlCJLcwEB9wm9VCgOx/WoOPdxCSwHOfYQXQNljAtJU
 wseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864166; x=1779468966;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2Enlths/eUd5QhHIfN949Lxdj1bjWYVyTCF5+VraFo=;
 b=TV5MHKt3IcG1Uok7k7fsGIP1WfhqLeT7EGNDotCDLJgVU3Hzeb02Vp84XWQNgc/Qey
 TcWfSlFdPt0BGl+RsV8tPaeOQnkjwa4y+fhnSZxFr/nqEwCiavVr1f9I3gpwqerGUoyK
 xU6aP73MxttV5uU6jkJf9gH9cepAwbHTwncJ1S8BeSEy/uz8Yp2pro4osgnUuTH5WYVF
 vQy5EZUKErPcxvLOYlNZsZOlKFOBunPBpuqmaXDsbJ1x8ZZa0uE0TZqDGEdATgAmJMAR
 sQgwQYg018pbtqhWPyLuOWTnRrGd7dvfx4ODbLB+kdkl3kIV6VjwhprZluKfwvLj4ZSm
 E5FQ==
X-Gm-Message-State: AOJu0YyF5z+PaoG2khe8qvIkniPPgWybyXEuoq/i1CBXR1V6P5tdJ7Fv
 RGH3VRGEkapkjz6A4kpxPIXywnO3fdvRWFUAmQA4KrMr2aXXntRNGaNZ
X-Gm-Gg: Acq92OE8ijaXE3GL590v184BUCeZsI4lei2AJ7/nQD5fidnN0EBUlbBGlkA500KFDtO
 0etreHwKqVizkmvm+YIbm50JTTDNjx8bMhh12FJh2VTMqLEV+IkPZepM4XC0s8TGKDRhkjUihyh
 YvjBrVOPBcQjvFTyDQv2Prrcy4H46qwDrEiWw8KCfPp7C6k7zk/N9bKc6VIz3w0G5Drb+VllzAm
 /k787i6YFu2hNYe1UUg39AH2GxbI/ImkA7QnDXf5QMZDwpH7dJSaYTjZ8hIhTwQXH53OI2BmQcC
 w9iGGv8Ecbs2TQ/3wHquoClJD6wX+VRu84KgD/JH4aFhghW2BHHo2mRU0m8Yv54u0jo9wuRlUNe
 5e+Rt5yUgxN1foHdnwbILIauT58WsbZ4XJg6waB2rEN/YtexGtJr7EgWRuk9Tmh/Q5kT7luIjJk
 Mct0z5cJWBGH+rK9mHVrV083tJuGVuS4fO
X-Received: by 2002:a05:600c:8210:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48fe6322447mr63064365e9.19.1778864166219; 
 Fri, 15 May 2026 09:56:06 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm14151347f8f.0.2026.05.15.09.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 09:56:05 -0700 (PDT)
From: William de Abreu Pinho <williamdapinho@gmail.com>
Subject: [PATCH 0/2] hw/arm/aspeed: add anacapa-bmc machine
Date: Fri, 15 May 2026 09:55:49 -0700
Message-Id: <20260515-add-anacapa-machine-v1-0-9765ce0b9426@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZQB2oC/x3MQQqAIBBG4avErBvQIIOuEi3+dKxZZKEQQXT3p
 OW3eO+hIlml0Ng8lOXSokeqsG1DfkNahTVUU2c6Z3prGSEwEjxO8A6/aRL2cTCDw2IQQbU8s0S
 9/+s0v+8HOxZYeWUAAAA=
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, William de Abreu Pinho <williamdapinho@gmail.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=williamdapinho@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 15 May 2026 15:28:05 -0400
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

This series adds support for the Anacapa machine type.  The first patch
adds the machine model and a functional test.  The second patch adds the
FRU EEPROM contents.

Signed-off-by: William de Abreu Pinho <williamdapinho@gmail.com>
---
William de Abreu Pinho (2):
      hw/arm/aspeed: add anacapa-bmc machine
      hw/arm/aspeed: anacapa: add FRU EEPROM data

 hw/arm/aspeed_ast2600_anacapa.c             | 362 ++++++++++++++++++++++++++++
 hw/arm/meson.build                          |   1 +
 tests/functional/arm/meson.build            |   2 +
 tests/functional/arm/test_aspeed_anacapa.py |  25 ++
 tests/functional/aspeed.py                  |   8 +
 5 files changed, 398 insertions(+)
---
base-commit: ee7eb612be8f8886d48c1d0c1f1c65e495138f83
change-id: 20260511-add-anacapa-machine-cf7076ab0afa

Best regards,
-- 
William de Abreu Pinho <williamdapinho@gmail.com>


