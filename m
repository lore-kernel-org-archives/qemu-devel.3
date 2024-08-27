Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBACC54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyRj-0003Q5-Ph; Tue, 27 Aug 2024 11:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1siyRh-0003Ok-Js
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:25 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1siyRf-0004md-80
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:25 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2d3da6d3f22so4403435a91.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724773762; x=1725378562;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+hjeHCHtdkd2RYRfSgVvQKkJ7Af9cnuMXy3JgW7EfI=;
 b=rXEJttXXRMF1F6dv0oMdwJqQvc4Dh+9Lbp1kEkkplwi+xX0FTwjkYId9ivshc9MneP
 mUkzmnei68byi0eFqMknN48Q4Tz7uExscZQh67qRXSXGd5ax73KV7pCz3RB+KnEtYhpB
 /2Ccvpm6XseD+Dtjf8CHltJEorJ+oGvjdJqgZrwzz6oicJ7FsVrsP2E5ktTz0od0nUKI
 WCLuRbqO1UtpWv69012vf2p++2Y2nJchTowipHLHlTYm/DdyJD15xPlab2A1HVrQyD40
 IEQ4c5CoGXfoXzEWfmu+sNOzmd3W6XyGII+gX5eIy8qXJW//mdQ493agvQZ5okAZspWQ
 euhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724773762; x=1725378562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+hjeHCHtdkd2RYRfSgVvQKkJ7Af9cnuMXy3JgW7EfI=;
 b=tMSA9uiHN3j8NXCNwwt7c+qBVFHY2x0XKtQgS3qqpdBOXSD9xQNSPMSf556coY9sik
 pvdWix029RyYonCaZNUaFXCDKhE6taYMCrPcovuGhTHRmMHbKxcwrIAWDOEhtWgN7aqD
 gMdLv9StQIfUno6LW9xJq7sDfDblaAkoL2GeV6GXF6SJjjiDeeBzURImCO39hfRPm2c8
 NCoquLUmlF1qvdrfea4R0bLXOykDWW9oE5rojVgAvX36bo/InaKLYDqVazjXnk+ih1Es
 mtZee8mJoSgwQYQ2uUtUxTjpnC+zI7vZxJBCzF+3Zl5EBUOUhGMMPb3zldbrJdjGIh8A
 phoA==
X-Gm-Message-State: AOJu0Yw9NQmPOl6Y6UD30Um+sjVxm7a1SQWK3/lpND7e3bY5D1EH+7YR
 ouqhucFc8t3YTaKiY6dc3K1K2t9itHnJAUzcyHtfdNaZoeDRAfChXYOaPE9Vd1umFJXk+PG/sZq
 j
X-Google-Smtp-Source: AGHT+IF7rjXDGR6GqfE+t6LDWFixtz4mDvXzXd5QOt1Rz6yfrwz8vpprxFC9zMy4emKhfHAoErWBzw==
X-Received: by 2002:a17:90b:2390:b0:2cf:7388:ad9e with SMTP id
 98e67ed59e1d1-2d646bcd7bamr13133308a91.2.1724773761493; 
 Tue, 27 Aug 2024 08:49:21 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5eb9037a2sm14624478a91.13.2024.08.27.08.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:49:21 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org,
	jag.raman@oracle.com
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v12 1/3] Update subprojects/libvfio-user
Date: Tue, 27 Aug 2024 08:48:59 -0700
Message-Id: <20240827154902.607926-2-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827154902.607926-1-mnissler@rivosinc.com>
References: <20240827154902.607926-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Brings in assorted bug fixes. The following are of particular interest
with respect to message-based DMA support:

* bb308a2 "Fix address calculation for message-based DMA"
  Corrects a bug in DMA address calculation.

* 1569a37 "Pass server->client command over a separate socket pair"
  Adds support for separate sockets for either command direction,
  addressing a bug where libvfio-user gets confused if both client and
  server send commands concurrently.

Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..3dd08768ed 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = b1a156d86f55a8fa3f78ece5bee7748ec75e7b82
 depth = 1
-- 
2.34.1


