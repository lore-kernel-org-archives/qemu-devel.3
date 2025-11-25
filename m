Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C1AD0E6E5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu5H-0006qe-P9; Tue, 25 Nov 2025 09:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu57-0006iy-O0
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:51 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu56-0004fK-4N
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so3687832f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764081107; x=1764685907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OzOPFznIgpbTG4xZi/XjCVhfc7BxnDRa1QWSADv6GTo=;
 b=Oeo0zjleF/qyiSmryIdbWnTIpDB47W4uMI/ZQF3yTkdfAeTpEYSMlcl5dBJMr7gV3D
 /iixofViboWNZJ/8jkFd6n1Nic5DzQv56mH7Vg4ix5lBjb/CpjG6qcMI95Ygb2i41vPz
 SSrwQQY/E5+dtBscuHDHn2YbXtBktXAMmw2z7olDGbm+Iw/wuLV9Z5GDYo9egbwS8kGt
 RO/UoIaWwAcB3SIVHuuNW/gt7288ZODElRUKsbjb6zlLxWdrxOQW0uXW6SDdE1Guy+Zt
 PM4BNlcvk+2SniDXA2SdVzi8joF5w3g47LMaz0ZiwLUoJaBNkzLsAyjEVFQBAfBxN7WN
 LjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081107; x=1764685907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OzOPFznIgpbTG4xZi/XjCVhfc7BxnDRa1QWSADv6GTo=;
 b=QShT4zmuyhmqbBZSmEa4SQ1XuC/I0xx0rfBUdSd+cR6sVZa6R+1JgV4tHQAjQZrcax
 9H6PgPvBuoiKdHqLrN48cq/X0zNOtp2puk6SdSPdyF7PYYNKgf35/SJvV1bh8Rfo65AS
 aveCGyPj9hTFRnXyiJrCLAS61SqtK4TApKXc214S4Ip+p6ODoCfOL8K+FjXKALWc8REl
 RqJndSziEC+LAn6SbUcYqkOpMHgu7cxOSxcFDL4QnfxM6xDPN2DSy6VIe5tq0smJC+pS
 hOl4a9x2BpUeTIG7LAsIN2BmPqEyG+wDZjAKYWK0Z93Dma8adn1OwR82GpUG+faleMDX
 0UhA==
X-Gm-Message-State: AOJu0Ywhmm0wPUPJnyW0XMfStCOfz5GYcx/lj8BwZLG3CvjzRdQM/lTb
 DrBYzdki9kaoIf/umekj+AxVZUg5MowOqWlwTMtDLbNq7bbX4n/UvdsmjVncEBqXSPnvdXJlKQ/
 sAjCU
X-Gm-Gg: ASbGncsHqT1PAlcGNcPhKAVoFjMGmgbMEC3k+QXrHQi1cOq41onkLwi0EqUo2oLrC5k
 n4uftI8XbcB2Yx6Dys79DUG2g9r9OdHcSvF9iZw3sI4x1x+O8dZsvK7yJ0cOmHTPli1iKXAEXAC
 NgId7DTvCeMOICqE9pdJXJDc9rhoNTjgf0pdI0SaPQ/kmwMxqKI7LLUf6k5US2iEUR88u3/AqBQ
 b9QAnd9bl3r0c+ENgIpTr0bXw1gQnkUm4nzF+JtCeHrqC8lUvDEQbP3GNDymhDdtyLxLvy+dcRz
 9yB+y3IG/H7RY0pIjJ969AlOqBX28sEZRa7WsdiKY1og3MrYIfwC/c6ARzrEOv60q3gBX67xc9K
 jIal3NgXPC2wKYpJ0mtw2IhR3ceQCVqgaeol7nyLISexWrkvX4H04ZNj3tQt56ka47R32U6eMRx
 lHNFqtBXmwvC3Z
X-Google-Smtp-Source: AGHT+IFOP/L/oyvSCRSDQejLlx4K6ylIaC8MzzUeFYRFKJEyIH/6YQN96ChdVoVAI0mo2lGdXu0MpQ==
X-Received: by 2002:a05:6000:228a:b0:42b:3e60:18ba with SMTP id
 ffacd0b85a97d-42cc1ac9ca3mr16735919f8f.8.1764081106642; 
 Tue, 25 Nov 2025 06:31:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm34485434f8f.34.2025.11.25.06.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:31:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 3/3] docs/system/generic-loader: move TODO to source code
Date: Tue, 25 Nov 2025 14:31:41 +0000
Message-ID: <20251125143141.216056-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125143141.216056-1-peter.maydell@linaro.org>
References: <20251125143141.216056-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Currently we have a "Restrictions and ToDos" section at the bottom of
the document which notes that there's no way to specify a CPU to load
a file through that doesn't also set that CPU's PC.  This is written
as a developer-facing note.  Move this to a TODO comment in the
source code, and provide a shorter user-facing statement of the
current restriction under the specific sub-option that it applies to.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/generic-loader.rst | 14 +++-----------
 hw/core/generic-loader.c       | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index d5416711e93..0df9b66976a 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -99,6 +99,9 @@ shown below:
   If this option is not specified, then the data will be loaded via
   the address space of the first CPU, and no CPU will have its PC set.
 
+  Note that there is currently no way to specify the address space to
+  load the data without also causing that CPU's PC to be set.
+
   Since it sets the starting PC, this option should only be used for the boot
   image.
 
@@ -111,14 +114,3 @@ shown below:
 An example of loading an ELF file which CPU0 will boot is shown below::
 
     -device loader,file=./images/boot.elf,cpu-num=0
-
-Restrictions and ToDos
-^^^^^^^^^^^^^^^^^^^^^^
-
-At the moment it is just assumed that if you specify a cpu-num then
-you want to set the PC as well. This might not always be the case. In
-future the internal state 'set_pc' (which exists in the generic loader
-now) should be exposed to the user so that they can choose if the PC
-is set or not.
-
-
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 433efb73872..508c090872a 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -30,6 +30,24 @@
  * separate backend.
  */
 
+/*
+ * TODO: currently the "load a file" functionality provides no way
+ * for the user to specify which CPU address space to load the data
+ * into without also causing that CPU's PC to be set to the start
+ * address of the file.
+ *
+ * We could fix this by having a new suboption set-pc (default: true)
+ * so the user can say
+ *  -device loader,file=<file>,cpu-num=<cpu-num>
+ * for the current "use this address space and set the PC" behaviour
+ * or
+ *  -device loader,file=<file>,cpu-num=<cpu-num>,set-pc=off
+ * to just pick the address space and not set the PC.
+ *
+ * Using set-pc without file= should be handled as an error; otherwise
+ * it can feed through to what we set s->set_pc to.
+ */
+
 #include "qemu/osdep.h"
 #include "system/dma.h"
 #include "system/reset.h"
-- 
2.43.0


