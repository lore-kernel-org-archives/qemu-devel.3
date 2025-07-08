Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DF4C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZG0y-0005mN-Am; Tue, 08 Jul 2025 17:38:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEbz-0000Wy-BL
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:08:23 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZEbt-0004eZ-Fw
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 16:08:15 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae0d758c3a2so801243566b.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752005292; x=1752610092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SPXiBNAeIxZ6oWXDfUjKv0P0/D5GWS1c5YZm1LqKShU=;
 b=Tr/1Lo8he6ZIq6WwPKtAygZKDWG97Bj9xSB0rcsieGNW/ZHct8lfzm/JOnG6d0qjxY
 SnINaELaaq3120X/AXGwlmaJYT1WL9yUHtKHM0U+f6Dca1H2nm0Np9NdxvFPvpC0IfRu
 73Q19aaJcZchPVSR6HP0/dCUVVceUJ+qwgj26Rv8IS/eHNybh8ygrYMusn42SkKffQWh
 ljegypz0km4KK5QzQ6qYhWPwKzK/ZoiRpAYLi5TCDZfeqS7Y5hgkk1U05/y6FZ0PfJZD
 5RN1f68bgE7ZWI1kTOMgWPyqGt/QJ6nfBIBlqRPgwoM+kmEUwitEeYUpzMrDquDTlYGT
 fqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752005292; x=1752610092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPXiBNAeIxZ6oWXDfUjKv0P0/D5GWS1c5YZm1LqKShU=;
 b=OexqRuSEShx6kCemfRqSWZKy1dymJVmJ+oUc/ofx/cf2S7C1IvArWiG7cPb+6x2UtY
 NriO/TQlVUiuKc3l3P3h/mBzhCTOhvW46HCZScP7MHFe3741YJ4NnL0RbMa6LGGI20SD
 Pl85PjbgKZrDegcAvfOFPRRJIEgFV12j4CMZG9MOztVjOQOYzE+JJEothO/JJ9QYeZWB
 TOdEqOeJsHD0xs4SLb6dy8zKgkVl6SAQ/dpHT9eV7Jhn/8ZNTgvxnboNHsCk/FUSj+t0
 X75VlhMhEBg2uCmMQLY3Fc9qi1lI8Ie8T0s338DxtH+IWAIhHZ+qGtnqeomVwvGQOaoz
 uNCA==
X-Gm-Message-State: AOJu0YwUd/bpJL2XDHcahUf7XhqH2pEgvvPr0stMOavz3AC6JpdloLGi
 ogv6xtx6oh2qYikzsHL/GPvuriu0p32toAbs7ebtmb44qXMsPB/F4EDlvrNylAnjXqSYCmdfVoj
 NA0RHFbI=
X-Gm-Gg: ASbGncvWOnTsJyHXbh0FZgo6n/zC4UY0GFK/T9aC3QsQCYsuGErtFWzLx9JnYeTHcuS
 lvzL1HbOM7E377cxdvaTWfUe/fPs3FhXd1pRLPzVy6gxYtTnk2kWqiqaukZIJkzEVQMT5vVI2GD
 GUvNPC8q4Uq+6eBm2Z2HJkm+pc8MYu/x394hu5uHpQA/JzB78OXCKPxMWEal+SSvAOeTWViaTJi
 Kr9aqOpj6RU+HPXdfgxI+VkCQJxT+lPVdeYsQf4TzIB/f8V5dlkA155R28wGJOSCYsFf64YlnGy
 yi5mzfqjvuYlsNdX5PXnh7f5TxsVjobWapxUsobXT/QDvrai08yg8eLMUYBGlVG26y0Fs+rT2IP
 HNL1j17s6rNDTd3lT1zq94MpXhxYLbueLtGgD
X-Google-Smtp-Source: AGHT+IGH+gHLcboemOLmFAnx87cdobUwi5dLoAXPHfU06QYxWDWgqAYMVTKmvLIx8lWiHEMBKqc4Bw==
X-Received: by 2002:a05:600c:530c:b0:450:d00d:cc with SMTP id
 5b1f17b1804b1-454cd4ba75emr21094505e9.2.1751965141684; 
 Tue, 08 Jul 2025 01:59:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d0beesm12557056f8f.36.2025.07.08.01.59.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 01:59:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] includes: Remove unnecessary 'qemu/typedefs.h' include
Date: Tue,  8 Jul 2025 10:58:56 +0200
Message-ID: <20250708085859.7885-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

v2: Split as 1 patch per MAINTAINERS section.

Philippe Mathieu-Daudé (3):
  hw/intc/loongarch_extioi: Remove unnecessary 'qemu/typedefs.h' include
  hw/vfio/vfio-migration: Remove unnecessary 'qemu/typedefs.h' include
  system/os-win32: Remove unnecessary 'qemu/typedefs.h' include

 hw/vfio/vfio-migration-internal.h | 1 -
 include/system/os-win32.h         | 1 -
 hw/intc/loongarch_extioi_kvm.c    | 1 -
 3 files changed, 3 deletions(-)

-- 
2.49.0


