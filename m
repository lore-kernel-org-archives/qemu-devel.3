Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0ECC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsPZ-0007Tp-5R; Fri, 31 Jul 2026 14:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPN-0007PA-Dp
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPK-0002B7-Qv
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:37 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso25905095ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524189; x=1786128989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NkclatltFH3U06EzMOb0zDwLWhoRoGGeDs9lBsxFDjU=;
 b=TgJGdi9/hrklWj3YUjlfURQsyS1HhSmgR/oNm3pZGtb0BGAxZWpXpbjn4AsCKsaT5h
 qBas+JDOCf5bthrkUuQVMUtwlQl35w4yg5IcK6/uDk3ANyvU8G8YxQqBZVdZUXuz2K4e
 +H/ZY0JBFBnOoSr4sX8sR2a/Tfk5mq8mreg+sjZCVoKBuPR9XgEqkE3qXCtZZ2QuY7tv
 UD9HLiUStoxa1gdiCv4dKVZ/u/0UW4lFCWksmOiOuLNXxNG3LaU8TRgcss0zNro2aAB+
 AddrNkfu2yMAlp5vlp3hC0iNde1pBXmzlZV6sRXhRirk2Q7q7VCO9oQ7HV5uxlif7VYJ
 FH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524189; x=1786128989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NkclatltFH3U06EzMOb0zDwLWhoRoGGeDs9lBsxFDjU=;
 b=eyeL5YQkcg1juDD4Ua0F5HZEdq62eNF7zAwmX8/GVcD6G8ClXnslpBk85tGVSukCgf
 p1LVqAVnwcr3BsnoFr8EWRs+8YIkA7ieO3D3sKBfEXDPM1w7Y1MekrNKJhHy4T3H0hgd
 kqlTUA8Ne6AIni511y+goybdoQuoTOHymsydgZkgik7VwjjppOm0Fkn0cSBSZw8KDq4r
 hMuRCRCQELKL7f6QljKT6pSkF1fElbPmiiEP2IM0c0ENAdinj7V/244TAMwK6fSrOisw
 N9/K3b0S+gz75A7u/4UN9UQblwgcR7DF0vCmBITM4s/iqhRC7x2+sS2VqKCl7WOy0Mhx
 uzGQ==
X-Gm-Message-State: AOJu0YzGIyvOzY1cfhZJnzYXlDsHYEfTpnImlODjJNVwX6TV4Tl+O9F1
 xQZ/TG3ktYgqbbWktfMR3TQVyiQrox4/4aRVaGn4x5nYW7yyIwk6ipF2CYpZozyXwmLSQOUzzBw
 zbmKo
X-Gm-Gg: AR+sD12p3+D34PA9ol/WL8sMZza60aFpRrF9qRqUTOcp9veNSSn1+J4nH7fNgI7gmED
 tSWngCYj9wxLgQy/tS3QBfmQyVlPBiBz1vCwbk9qlrtEmRFLYoY3mDTpZBlE56wvzm4884Uu/p7
 vlps1KNfB78p9kM1NR03SGhVmmFyMFXMgwzD1pcO5cEJOjCZBMvhUBBrrSnIvDJf16PTTO8vsHf
 TO+hLz9G9bymBzFcW5vhAmiSL17Z2h02DU6ZuCEWHuqbVJCuRjNtKS+DFzATtAEJytDQrrBVbCA
 39TpcimZ2/+sfsT5JX2QGSyXnZmFJfLsaS0quM/6u4apeGugVeLAN0Uy3HtJGrlZl8P2jfMEhGS
 11i9n9AEwXz6By0iXb53FiPwU4c0iKaWkDwrOisK9Z/Qr2Bw+SLcFHFst9cqs6KeLXPslYpzU0C
 TlVp9dYbPg/I6rev3k9I0cUL9bKrfH3EgJRKyMSNgoGsJ582/a8NzKljfgSDLEeay0UrWaDj7iU
 mxpndJ0SrwV4wddsXxx
X-Received: by 2002:a17:903:1ac3:b0:2cc:bdb9:3c04 with SMTP id
 d9443c01a7336-2d047e38cb7mr27563545ad.17.1785524189384; 
 Fri, 31 Jul 2026 11:56:29 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 00/14] target/s390x: Clean up mem ops and byte swapping
Date: Fri, 31 Jul 2026 11:56:13 -0700
Message-ID: <20260731185628.23161-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Once upon a time we didn't have controllable endianness in our memory ops,
so we were forced to perform the bswap for LOAD/STORE REVERSED manually.
But that hasn't been true for quite some time.  Tidy up all of the simple
loads and stores by stashing the complete MemOp for each instruction.


r~


Richard Henderson (14):
  target/s390x: Convert op_ld8s to op_ld
  target/s390x: Convert op_ld8u to op_ld
  target/s390x: Convert op_ld16s to op_ld
  target/s390x: Convert op_ld16u to op_ld
  target/s390x: Convert op_ld32s to op_ld
  target/s390x: Convert op_ld32u to op_ld
  target/s390x: Convert op_ld64 to op_ld
  target/s390x: Convert op_st8 to op_st
  target/s390x: Convert op_st16 to op_st
  target/s390x: Convert op_st32 to op_st
  target/s390x: Convert op_st64 to op_st
  target/s390x: Use op_ld for LOAD REVERSED
  target/s390x: Use op_st for STORE REVERSED
  target/s390x: Simplify LRVR

 target/s390x/tcg/translate.c     |  89 ++-----------------------
 target/s390x/tcg/insn-data.h.inc | 108 +++++++++++++++----------------
 2 files changed, 59 insertions(+), 138 deletions(-)

-- 
2.43.0


