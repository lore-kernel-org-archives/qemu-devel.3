Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2CFCA600A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENFr-0001GJ-Nj; Wed, 07 Oct 2026 04:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIzb-0001ej-Fz
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:11:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIzY-0006fh-9P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:10:57 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso2056439a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791346255; x=1791951055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jKRx1YyyivMARcN7Ip7PPc1gr4r7pEfYbwdTqcTWbBM=;
 b=sWHY6eIwf3goh5GVgDhTzxYllEOwsKKe9WWHHBQiDBcZFjugCL0mHza0fqkA7EC2mP
 xLyRjJ98x5fSXaZwoZsnU49xOB5KkjVobPZ9LpgC7AJANgGNMKCC86ct4VXi83UvmUcV
 /q/i17NE/Usq5832wJXSDUncyopOXaF0RVGtCjsombGq3yo7+PRV2Z2BdWG1Y1qCu+uM
 J1bP+fsLT2i9lqWPCVduJh2oYktMk1LvaLGjslANQJhOeNLo6vwYLdWg+Ip735uw9EeX
 MncUWiRPglN05Mesrkti0Dqj5BLFJqqz7VdVOuRSJgiKxA3qpxib6/bZweqj2Fx1lxR1
 tYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791346255; x=1791951055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jKRx1YyyivMARcN7Ip7PPc1gr4r7pEfYbwdTqcTWbBM=;
 b=eiFr+40QvlTRtAnKvqCs4SDpIsjomiYpiU/RSA2lLxywxvDdrA7rTpjRTiMJdoeWKB
 ghG7I4W1kPHCv5GT/nsUFN4DnRg7rPqpQ2RnqJ0UA6WSDX+IHOJoe/BQIjblci8BGzDk
 eZ2PQkPMVYvaIwDsQmo2OHYaHmoD/UpTmtPn2Mh8tMRLXlJB+sBuOZZ0fhFjtwcJem4y
 OndqPnI81+L2rBalsIIl3ig0bWnSYvkJt6VGuoq1IVJedmz1QHBlVno9YdbMhhueSCxQ
 K4tuyeA2L4lJhn7ZdrMyWX0VO2wk7joBHFwXCe5SWJAdj+S6ozzAUrf9GFh14ITZ5KcI
 /yow==
X-Gm-Message-State: AFq9FYK6MXDKvjVuq5ExTtjrByV6l6d35uS9rrX4Kx2OwzcZtgt1ig1a
 aXsnvDn9cpwyFrdfwzKAn+2Nj56e8pRhfKtxCxr+oulJJhnVBK/NcxzYsxH2eg==
X-Gm-Gg: AYBFou1jli7wC0SC9Vfqqa4l3VNcS0TTZo5eIhKhZqqAofy/vvjVkk1BUpeJn6o1R9z
 NppfUOee9CriQfyKLke6bF5m5O1CLrkw2yGW5tWe2Z8DjdeLiSIwmNpHJrcmW5/RkwWsPLRO61O
 z19tqBbzX2UYtyqhSs3RQ+zluvDtYTqc+xXF5bdWGig3NwvB17w9cGGiY14utzo03Q3wfv7RFlK
 kQ/eTQb0DozAMKRg8HC0oxCN8QHdlVVE+ZGgDAJNQaKW+ebM5Mt2xMbXEKbu1lhH3FSmzE+DzoY
 i6WhLbjfr6bIwfUtiobrrqvtbps40Th+uV4j/TsS1Qdn4B80zlmgQel6h6qphdP+il47h/+nJ/T
 dRyKVu41xrAFqrxcu+0UujvtyIJ613KeWzharHon0XBYthZNVekHagOhnLS2uy5q+tS4ugvDHch
 NKZzzv/Wz1+JpJY+bCm46P1t+iHV0FVfhSTgAIZZx52aFSiC4RU2+/PSRJjDyjPhiDG/jRSqbY1
 8Tfs3T0q1+5I6IikVUAmyWn2dQsC9ZKiejujg==
X-Received: by 2002:a05:600c:4fc2:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4a17b4f4d36mr14958855e9.4.1791279912496; 
 Tue, 06 Oct 2026 02:45:12 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 8/8] hw/sd/sd: Remove unneeded forward declaration
Date: Tue,  6 Oct 2026 11:44:47 +0200
Message-ID: <20261006094447.43491-9-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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

No need for a forward declaration of sd_realize() since it is only used
after its definition.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6295e7a942..e6452226bc 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -209,8 +209,6 @@ struct SDState {
     char *preset_auth_key;
 };
 
-static void sd_realize(DeviceState *dev, Error **errp);
-
 static const SDProto sd_proto_spi;
 static const SDProto sd_proto_emmc;
 
-- 
2.56.0


