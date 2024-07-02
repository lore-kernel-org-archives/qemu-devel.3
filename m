Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91897C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnDO-00024b-Ce; Tue, 02 Jul 2024 19:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDK-00023q-Q2
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDH-0007V6-RO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fab50496f0so28947385ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719964021; x=1720568821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ETuY7W8IgKosE6oyNram3ybN2ni+Fatqp87Qqjd45yE=;
 b=a0v2CDSym3rUfnxP5M/Xg+gJSlehAFMthnsiL5cpGfD1mb4JVJ9YKblx2ewDPvJze+
 QOoOkMO/8rnOMiNfnL4CuiPy6VNVB6lkyYk5U/yGQRmbTc1kYVDWbsUhiNj74KqjS/eE
 Ctn2WTHQeeZstcH25cCFtSTf9GfqsJhe0VM0TGOGghJGYbRiRMdktPBbYHv/rAsCcDEA
 YBh5I2WLhWOUc538kqMF5Y4OYj+4VsEwqGD3G892FoaGXeIIzgmnpTIwvsG3RnY6017w
 9bQubjO+jFcEWcSYcspGxor3P8mbH/eZpuZ62vwUVCIHOgpI+b34lrCzLHIBehh3yJ+l
 LYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964021; x=1720568821;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ETuY7W8IgKosE6oyNram3ybN2ni+Fatqp87Qqjd45yE=;
 b=CzmgGIf6dsUKK0rhUWAIEu9MhiH7E1KtCXmz9HZEwjigBk/EB3g88ZqeV/ZIf4mMHh
 d3GLPNYMbphKJHKkUQAeYS608O0kUMZ05Uu4Vb/6f3Jm3FKVkDLyXyh8ztIj4qMBvnpM
 i0PVbyCWX0yTqndACcNgkPmSqry4RR2rtpNewAtnPmlciUsHh7xcUXhcuFwvFWXn+1vG
 UIt+ziP8wFQRNJBldyEajHRKxtdieGjNtemnJZxj1RB+/D6qMgTplEwRAijSjS1odsRZ
 C8kX26cAL4hZsRBYcyLcDEhKSw9IHVaqYMzpZ0evrMRKy6DfksWKPk017fO0FlhCorff
 4Y3Q==
X-Gm-Message-State: AOJu0YyQeWB/E2Hc5UgPKA/v5HtiJq7oaYs3wP2cOs4m7zTszgylz7QE
 i24sY1UdrTT4gStWuCcFf+EqLa6A4X0lFjhtGHCeG7WNZf6jfLqHA6MWxkzOBS0kXl8jlgMWjuz
 P
X-Google-Smtp-Source: AGHT+IEJgTehorQdzoDnqecgFuDdNrsYkCfisA4sS6916ZbvJjQB1yqAx3vJ9zk8/CStVRPkhuy7KQ==
X-Received: by 2002:a17:903:18e:b0:1f6:7f05:8c0e with SMTP id
 d9443c01a7336-1fadbc5b502mr60909945ad.2.1719964020918; 
 Tue, 02 Jul 2024 16:47:00 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535e62sm90147045ad.154.2024.07.02.16.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:47:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	balaton@eik.bme.hu
Subject: [PATCH 0/4] target/ppc: Cleanups for dcbz
Date: Tue,  2 Jul 2024 16:46:55 -0700
Message-Id: <20240702234659.2106870-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Hi Zoltan, 

These are the sorts of cleanups that I was talking about re
the dcbz helpers.  This makes only a small difference to an
artifical memset benchmark.  However, see

  20240702234155.2106399-1-richard.henderson@linaro.org
  [PATCH 0/2] target/arm: Fix unwind from dc zva and FEAT_MOPS

and compare aarch64 helper_dc_zva.


r~


BALATON Zoltan (1):
  target/ppc/mem_helper.c: Remove a conditional from dcbz_common()

Richard Henderson (3):
  target/ppc: Hoist dcbz_size out of dcbz_common
  target/ppc: Split out helper_dbczl for 970
  target/ppc: Merge helper_{dcbz,dcbzep}

 target/ppc/helper.h     |  6 ++++--
 target/ppc/mem_helper.c | 37 +++++++++++++++++++------------------
 target/ppc/translate.c  | 24 ++++++++++++++----------
 3 files changed, 37 insertions(+), 30 deletions(-)

-- 
2.34.1


