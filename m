Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD7DC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZARQ-0004wx-C0; Wed, 31 Jul 2024 10:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARH-0004VI-Uo
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZARD-0002eY-Tb
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:36:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42809d6e719so38481705e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722436582; x=1723041382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kb8rrJWADVvXdHvGrD9NacsP9WtS53Udc5d9elH1XfE=;
 b=riK9jB+hX43CTzerMc46tCM0xe5OWLgf2LyD6qTKFCPQ0v+6lJwrlJxLPpBipsKIe/
 PIfg+CW1CleQ08QDnfoTtnhqzuS02iRBWFLtYrKREVeocF3ToL1CVUg/CvQSSVu+B+uk
 RoSl0y1kJ64My5Izas5+p7U4n7iuzyodew1cuPQ5NtE7tOfiwy7zC26hlkCQlhWiKnFQ
 2c8GedKaazfs5wccxdzK70GK2YtYz7/JgzKBVMYmFfN+DuuKM4PdOlr4CbU10T227tp+
 YU3bYkfpPQ8X2D78W0bTHcSyXym/guarmNf8acp4k3/cCe4CdN0dC2FtlCJ4LW/sSzB9
 dXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436582; x=1723041382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb8rrJWADVvXdHvGrD9NacsP9WtS53Udc5d9elH1XfE=;
 b=ujpHn2O+LWyfxjJxrkzXRDyJuMAMOpmeSIEsFglaG/Kx++ngh5IojXKtPbi0/oXg2j
 7Hi+5/GusBaoW3GO9KEvXGEgQVtZrGR0EmunNAG5Ey49wdB0Zcghnc6Zynd3dEiC4m7k
 URr9Qi2ujy4AFwBpwcoXsxJyb5+x+AXPjel72Z2v+yBdMSH1ZIItRcXwV0/oofJ1nMSZ
 gPm3kg7SJM3oamSww1wzSraXJDa0B8bShc4XBWloJFWpyjnawsDoCLM3Y0VMj9lZBRkm
 S64eSblrIcos8ySokPLCS/AGiW9f+RILjSTfaWHoBzoA47frFMrgyjPFkgNqoaGBL7Br
 hR4w==
X-Gm-Message-State: AOJu0YxtHz7U0/QfrHdCzPzJdKYjLA7gq5M7RIhkxY/pnYDsByEGLtr4
 58CakdinEhEOqrYlbx0qDknZFaGmFQeZivx+ezKAVIPOC+HwpiH/eFpyMr7wkgo0M+/U1PfFaby
 y
X-Google-Smtp-Source: AGHT+IG0XFFcFLY//fT1hQqd61SRyvaqYzAYw7RFo5X4drLqLTChawEAhPlWrrlxFYXH9Sj3Qv7E2g==
X-Received: by 2002:a05:600c:46cc:b0:426:5269:9838 with SMTP id
 5b1f17b1804b1-42811d73f0amr94743475e9.4.1722436582479; 
 Wed, 31 Jul 2024 07:36:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89a86dsm23976025e9.1.2024.07.31.07.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:36:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH 6/7] hw/ide/pci.c: Remove dead code from bmdma_prepare_buf()
Date: Wed, 31 Jul 2024 15:36:16 +0100
Message-Id: <20240731143617.3391947-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731143617.3391947-1-peter.maydell@linaro.org>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Coverity notes that the code at the end of the loop in
bmdma_prepare_buf() is unreachable.  This is because in commit
9fbf0fa81fca8f527 ("ide: remove hardcoded 2GiB transactional limit")
we removed the only codepath in the loop which could "break" out of
it, but didn't notice that this meant we should also remove the code
at the end of the loop.

Remove the dead code.

Resolves: Coverity CID 1547772
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ide/pci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 4675d079a17..f2cb500a94f 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -266,10 +266,6 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
             s->io_buffer_size += l;
         }
     }
-
-    qemu_sglist_destroy(&s->sg);
-    s->io_buffer_size = 0;
-    return -1;
 }
 
 /* return 0 if buffer completed */
-- 
2.34.1


