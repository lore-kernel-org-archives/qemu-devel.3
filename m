Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFDBE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOf1S-0000uP-R4; Fri, 20 Dec 2024 10:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tOf1R-0000tp-E4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:34:37 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1tOf1P-00024H-2D
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 10:34:37 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa684b6d9c7so371101166b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 07:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734708873; x=1735313673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W83AIqQqLys2hVeEH+wn1qz0/F+zPdg3O15Pfi5t+/o=;
 b=b35TA1i3F/Jj72weczoxNqCLGAz4L14sHQ+q5DbD3FLsmGc87q4sBmU3iR8z0FqWIx
 EER4Sva2DDbBgyRon69Iue34c9SETZdpjPdpry978Rd9QePys0QrFS87tfTXVLv55LGI
 ztmqEHJ4HdizKzqo0dVQk34leoyhBWevT6EF1WvRa1fviP2CDMCkw83FG2iMUFugRNHJ
 1sIdZ2ptX1FO1MAGy0gkj9pRK+23srfdTuHZVpv2rJ0jeLfD24aQU+nUAd1CK3EyVVae
 Pyt7P1P7UbflMJ9SUFMCTBS5Z3q+ybJ1R6blcVd8LIwKZGk6U1v6hgzbl8OtilyNEM0L
 WPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734708873; x=1735313673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W83AIqQqLys2hVeEH+wn1qz0/F+zPdg3O15Pfi5t+/o=;
 b=hdUxd/N9LiUwb2Wb338tmwYfebuorXng5wfCTUqXzFEM7rzRVJtunP94M6Ra7YI3OR
 XCaT856d5PsB8Ycy+nWiQc3N31ck1QYvhggM+Dg0HsJxNdLybetVO7g8Y0pZ4d+QtXzU
 3C5X+fUWFKWm1MbR4YZe+zbGW9oimRZEKZ25rZkWENDjjC6ul+bcyCB0mXcPqsAGKjoB
 RcOzTfSwyvrZND/HPQ+01Rqi4seEU8RJyxtHksKx03CLYMPgUXuUUpSn9HIYFHLlrDVB
 iLUEQRy9yan5KmxaGhCI7BQIravHvgEsdfgQcv7fEqL919mCSQL2ODFTvnG8aF+49rMw
 K6lA==
X-Gm-Message-State: AOJu0YxAKnWG9sU+Xk8xPgx1JhvTnyoGDqziDfKWwvlyRccGgnKFYh2Y
 Zm2Zr26ZTQIT3wDBz8bitkB2OG2GiVrLcjTibL8Yr3sEGXwty4KE2QSooWi5Eh7BETBMJe35rBK
 AgFhORQ==
X-Gm-Gg: ASbGncvAioBYCbWX3tdZXEA0TLLenCSJBGBQsASJ0EtfF5xXIWShMjPgGqmz3VvaOAA
 abO02i7Vs1/sfAF8SYmAZ/Rn2MFk7b7qaU1ETapeVmH8gWCKCZTUlZsYS3hYzfdT9SaxqrjDJF0
 Ub+V6NfK+SV4G0u4NYpikPYQ2EzkLl7eQLqMZj0lc/RkARNAESRQP3xqImQEiHnvgJwZhpqYHAx
 70ImcESASR6uhukTrggwh+tDswrSyPcTIoInl63OtgKttOuEBkg87gnBm0Xcy9DIdS5Ob/JVZs/
 dit56SuetFxZl5rWHSF03A4o50OA/HZMyz7eOWz+xMI=
X-Google-Smtp-Source: AGHT+IF7XXSVBEV3xvoz2KEItuUN5RIS5XcEr5G26cOuOd8uVIYdFHrx5ymKLMXFj0CATBZYDf408g==
X-Received: by 2002:a17:906:c14d:b0:aa6:af4b:7c8e with SMTP id
 a640c23a62f3a-aac34650860mr278690866b.46.1734708872678; 
 Fri, 20 Dec 2024 07:34:32 -0800 (PST)
Received: from paolo-laptop-amd.station (mob-109-118-46-116.net.vodafone.it.
 [109.118.46.116]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f0128b8sm188131666b.145.2024.12.20.07.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 07:34:32 -0800 (PST)
From: Paolo Savini <paolo.savini@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Savini <paolo.savini@embecosm.com>,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>,
 Jeremy Bennett <jeremy.bennett@embecosm.com>,
 Craig Blackmore <craig.blackmore@embecosm.com>
Subject: [RFC 0/1] target/riscv: use tcg ops generation to emulate whole reg
 rvv loads/stores.
Date: Fri, 20 Dec 2024 15:34:27 +0000
Message-ID: <20241220153428.16013-1-paolo.savini@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=paolo.savini@embecosm.com; helo=mail-ej1-x62f.google.com
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

Following the reviews on the previous version:

- RFC v1: https://lore.kernel.org/all/20241218170840.1090473-1-paolo.savini@embecosm.com/
- Review: https://lore.kernel.org/all/e8fb908d-4723-417a-bf88-b4050432ddad@linaro.org/

we apply the following fixes:

- Fall back to using the helper function if vstart != 0 at the beginning
  of the iterations and refactor the setting of the function arguments
  accordignly.
- Add mark_vs_dirty before performing the memory operations.
- Loosen the atomicity constraints and apply only MO_ATOM_IFALIGN_PAIR
  for element sizes MO_16, MO_32 and MO_64.
- Change the way we update vstart in order to set vstart to 0 if it's the last
  iteration.
- Fix the indentation.

We also rephrase the commit message to better reflect the new behaviour of the
patch.

Many thanks Richard for the thorough review and explanations.

Cc: Richard Handerson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>
Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
Cc: Craig Blackmore <craig.blackmore@embecosm.com>


Paolo Savini (1):
  target/riscv: use tcg ops generation to emulate whole reg rvv
    loads/stores.

 target/riscv/insn_trans/trans_rvv.c.inc | 125 +++++++++++++++---------
 1 file changed, 78 insertions(+), 47 deletions(-)

-- 
2.34.1

