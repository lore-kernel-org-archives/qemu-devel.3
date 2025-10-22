Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50379CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 02:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBOnU-0003PY-48; Tue, 21 Oct 2025 22:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOnS-0003P7-Ph
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:41:54 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1vBOnP-0002JB-HV
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 22:41:54 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-33d7589774fso3898358a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 19:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761100908; x=1761705708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e1wIE0v1euyYcy826yUBGHmG8cIEGIkUorfE6OvvIXY=;
 b=nnqkeBuh4lduosDBZRXNMkx1v+JOjqQTDn1YhtB+a5mVnMgIqvrVegEdkjbUyXjlkp
 pQe7PdIOyj6LqJ4TtCpYaEYMyELbZqbJYwI2kcPokIy9B85bc8cOnl1eUATJz/Vi4Q/O
 DUV7U9W9saytQEaDlQ1e442mBSHe7rgIGDVM3hG9NFtxidZLRSrZWrdomrmTUXvn+kep
 luefHAvjdeCDOeQCWt2ZWMPylFFPCk4/3T7N8fo0EBk/S6Ee0kSsEK3XBKY1vOLV+bhI
 Y1yHsHmG57SBUe+1L8+h8jhFnsO4ammplEBO+oGg7191ubaLhX4Ub1lHSGpvJQyn8lWh
 amKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761100908; x=1761705708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1wIE0v1euyYcy826yUBGHmG8cIEGIkUorfE6OvvIXY=;
 b=gV4H1p/iqigC+e64sIufKoOEjFJh4+eLa90vpJQ84kcBTElqF5mqtChlx0hdm92J0I
 mE6EeXR2jktXLIyF0G73tWtwNkfESYOBUGkuePmrW/ghUIMXYT5PDNDjLu9aNGdNgo07
 l54BJ501gFBunjQyCls+XNvgvH676/DfMU0l/JTAx0LJWJA7hwmwYm52IgyOMar261Bp
 WF9517QEAmg+qA091FQUG7rM3sqLLG5HHAmaxuqERo36DqAu0P1WFfv06WAn2FJjtRuy
 3455rx68ox5vYx/FU7oU4g65UoUam85h2hz1KYJATZVl4XX37+IdZYnZK2186JMdy18d
 HUYw==
X-Gm-Message-State: AOJu0Yy8IYLNPZxCM85Ed9rELP1Rn0Ytp3X5KL4YLmlvH/lT/CXcSDLL
 mClDO95Jt7W+IIyfiPvdpzJU+tR0TqO5hIKvkjPhLhDRoGdJsLJ4IftFwcMX6cBpsnD4Zcn1rd+
 y1bVN3qu+Ejgc6G8hMTtMr28CXzu98g9OgBzUr4Yce+Ei+YUvJsOA9bAv+aErbFyfv7IKj8Ym6v
 WggtB2XJcBqQEhiekM5e7GW+Py2yzPQUSqcRXeGBie
X-Gm-Gg: ASbGncuQ87Rf5eEpcytv77qwARp6cWlOAy5D38SoUhZHtkJZLtMWx+pJPbt5l/6LbPi
 zpL5aKd4fv38rvPCHgPdeamWBpBRpY4uuLmJLvApm8Es6/svznK/0mfhc+6ZQE3R5KthQk/Tk9J
 c0HVzv5nwdUxFyIp3rOYdgRdvPwL21Zf9ODyZksRRM9rFCHCkEVQKh7nLPaERAEvSOC1JA69tnz
 OwwI3ncBCuDThTZyDk1fF6Fg68+/NdXcgPUZjMMYRz20icroxb222hhQWidLI//6MmtkQM22dmM
 IAMeIVWqJBsI5wIvvCu75CVpQtnvu4SvLMr5slqu/FW1FbzuC+xbIXkmBnHAc5gBsRW00WuwJRH
 cDGu/ya/4AmLP7/wPIRY3xd8Yg2HZ9/oTxtnbWMYYcujOKjXTgOttR6ZtgoNTg27NXHaHuMZWgs
 LYscA2TZ1DnJRLx4yHEoCUSDKpfZaYGTklqChFY3ZX6V0PVCUpSg==
X-Google-Smtp-Source: AGHT+IGyHbGN5vf+qJZoSvIVrxA+CXhzLj/V6h+BnT6rSlmbAt+XcQIxpZlYMMZ5iNNXqZCq4jy79A==
X-Received: by 2002:a17:90b:2d8b:b0:336:bfce:13c9 with SMTP id
 98e67ed59e1d1-33bcf8e3d37mr25509093a91.20.1761100907515; 
 Tue, 21 Oct 2025 19:41:47 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.196])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a22ff1591dsm13204731b3a.7.2025.10.21.19.41.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 19:41:46 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jay Chang <jay.chang@sifive.com>
Subject: [PATCH v3 0/2] Make PMP granularity configurable 
Date: Wed, 22 Oct 2025 10:41:39 +0800
Message-ID: <20251022024141.42178-1-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102c.google.com
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

This patch series enhances QEMU's RISC-V PMP support to conform with
the RISC-V Privileged Specification regarding PMP granularity and WARL
constraints.

Previously, QEMU always used a fixed minimum PMP granularity of 4 bytes.
This series introduces a configurable "pmp-granularity" parameter, allowing
platforms to specify larger granularity values. In addition, the handling of
pmpcfg and pmpaddr CSRs has been updated to follow WARL constraints. For
example, when NA4 is not valid due to a larger granularity, it is silently
ignored. TOR and NAPOT address ranges are also properly aligned according to
the configured granularity.

A new CPU parameter `pmp-granularity` is now available on the QEMU command
line. For example:

    -cpu rv64,g=true,c=true,pmp=true,pmp-granularity=1024

If not provided, the default remains 4 bytes.

---

Patch summary:

1. target/riscv: Make PMP granularity configurable
   - Introduce CPU property `pmp-granularity` for platforms to configure
     PMP granularity.
   - Default remains 4 bytes if unspecified.

2. target/riscv: Make PMP CSRs conform to WARL constraints
   - Update pmpcfg and pmpaddr handling to follow WARL semantics.
   - Align start and end addresses of TOR regions to PMP granularity.
   - Ensure software can read back correct values per the spec.

PATCH v3 update
Change UL type to ULL to prevent bit-width errors.

Jay Chang (2):
  target/riscv: Make PMP granularity configurable
  target/riscv: Make PMP CSRs conform to WARL constraints

 target/riscv/cpu.c                | 39 ++++++++++++++++++++++++++
 target/riscv/cpu.h                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/pmp.c                | 46 +++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

-- 
2.48.1


