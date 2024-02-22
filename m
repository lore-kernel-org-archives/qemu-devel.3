Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F21DC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cW-0006Sv-4J; Thu, 22 Feb 2024 07:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cP-0006Gz-Rj
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:56:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8cN-00057C-9S
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:56:05 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d146737e6so5194002f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606561; x=1709211361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fiMAHxMKyZo0atwcCXeNwXI7oIw0a2AWdKKNEO+8KQ=;
 b=VMR+cqXzncKn+tBrEvJ9rICGNY0FU62FsKmsYACOnXUb/tT4Rchox6nFj1GPTlFLNf
 I0Gb84VjbClL6VutIjZYRHdBeskPwiUtHfKOGSVul959+UnmspOUkFU8ijs2+vUH/xoW
 c4J/xklRMNl3AuOLAbUhdcDUZJADl9u4VexyIVghcGec1B8yQ4Tc2HCp24LZUEZ2ipzJ
 3u7PaI68n34jFAltBwbN2USo5ODineNZ44L83xr/u4l/m+04lPvWC/KaF6VHTkX0e83W
 TyDGL+MAzaou+v0StRl43nCs97WfAu+qMS0ai/7Q7tnLGrwX0a5+y8XhGfsDFRsriE50
 UMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606561; x=1709211361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fiMAHxMKyZo0atwcCXeNwXI7oIw0a2AWdKKNEO+8KQ=;
 b=Q63hv2lHIz9dsIUFHB+Npk/05hZRDk1fp9mjUV/ca+x7FexOMY2zA6EzZYQ0mAhwMe
 GjenglcKP2Ppc2XQc49ZvaTLwjXNHRlh0w4swDt3Vi3GAMMzj+iROpFXYizXvXrvIUEy
 9yt08UWb/W+xX9K9blMT7ainQFWLPTVCX6xchqpeju+1y8/jY3PTLrbeLHOymJxkAdRl
 D5ZRUgOeTfGM+fq9yy7tYXCkuacc+nOIbapprnzgSRQZOEUu+h7ZqLwmN79e/x0QP1g6
 /lFWjD1yZZP8V89hT9ondw2D3Vb8jNawXxLvzKAXLYic781JEh1W9r8GB2A4IWDY5pvB
 4Shg==
X-Gm-Message-State: AOJu0YyvyfCi6cdql4ucGO6PV6p2EjFHjqp/8vVYxd4jU5YimyVCSlV9
 ACb+lcTTGGo7ai3fcERY2RCK29HEwwrpv8Cc/PMUsaZ6Ywswb/vjQJCbZM2bQw4XDPA2SyaFgrs
 X6Rw=
X-Google-Smtp-Source: AGHT+IGTmRTAz9Ol8N/pTaq7wrVi+PC6G/sOgUWTzvPBcVNGltf0aYqLjtVY0i+eXvRqybwXgTp/UA==
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id
 j5-20020a5d5645000000b0033d3b82ab2amr9485069wrw.19.1708606561338; 
 Thu, 22 Feb 2024 04:56:01 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 b7-20020adfe647000000b0033b406bc689sm20495892wrn.75.2024.02.22.04.55.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:56:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 24/32] hw/acpi/ich9_tco: Include missing 'migration/vmstate.h'
 header
Date: Thu, 22 Feb 2024 13:55:15 +0100
Message-ID: <20240222125517.67131-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

We need the VMStateDescription structure definition from
"migration/vmstate.h" in order to declare vmstate_tco_io_sts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240219141412.71418-4-philmd@linaro.org>
---
 include/hw/acpi/ich9_tco.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/acpi/ich9_tco.h b/include/hw/acpi/ich9_tco.h
index c4393caee0..2562a7cf39 100644
--- a/include/hw/acpi/ich9_tco.h
+++ b/include/hw/acpi/ich9_tco.h
@@ -11,6 +11,7 @@
 #define HW_ACPI_TCO_H
 
 #include "exec/memory.h"
+#include "migration/vmstate.h"
 
 /* As per ICH9 spec, the internal timer has an error of ~0.6s on every tick */
 #define TCO_TICK_NSEC 600000000LL
-- 
2.41.0


