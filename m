Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33B6CCFA09
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 18:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFypc-0004CT-Pl; Mon, 03 Nov 2025 12:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypa-0004C1-Kf
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:02 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFypW-0005o7-BN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:59:02 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4771b03267bso31600655e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 09:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762192733; x=1762797533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uk/65okiplYoXoAlEScDnyxFPuCSndnCiwAptkhh6rk=;
 b=MsDdVKVXzBjA29MY3AMtrL6dWmlusrYlEuUmg5Edi1qbySjM/FlP9GhtbmN8+sxxVW
 1Sy+mSd2RdxiZ8NiIo0uf1Ejf086eOcckhNt9WiEZhuj7PIdrAyYA+FxQo1+el/u2WTi
 1f+88Dvqj6GAswzUaIUVuMMIrPLXm12nqOQCRtHZO32pAxm62jD67ROE/syD+A2EWggW
 ZeY20nvDgccCW0BstmF3bDZXcet6Bk8+YbsgZbvZrm+3Nktxh7RNH5UpHXIs2G4XDckg
 apIDAiOU2rXkvYf3xmaSWVDIRf55oEubwan3CaDP7DN6AJhudFTTuzV3dHxG4n2PqALv
 YOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762192733; x=1762797533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uk/65okiplYoXoAlEScDnyxFPuCSndnCiwAptkhh6rk=;
 b=t/M/SZOxhGgGjXwN+kR7k+07lyLRWLWN8IQDw6qv4Ad5vZLbkiibabAdqt5sZYdAfk
 RMDFqZ3NPvEK1SK1+/nZIY2jV4RduoCRl5RJzSC1QMnGFg/t4fQAWlrIQP8xTbUWZpDd
 xJQlBVr52G7bOFaFClfkS7pTq1KtzAX6nvbHoLVByPGWaGIXarwwMYIyIHJGbqNOgHdv
 6uEA6hRZnUMSAfAWn7hLKQTqN9fnDJAmZFQe5H0zBjRjNFBTruF4z3RmbUtH7AzuS+Tr
 fiAXlNJYMHQv9u1kRzGNSI/kv6Kzky2hI2OQK7jfmgn8Ji5ScWL8wsm0GQHpqfF84uKn
 zsrA==
X-Gm-Message-State: AOJu0YxF1JZdkRP6ol7gYjcJ28IF/Z5Ktns8AVQDSsPf2MfPbXfI5sjm
 KWkQ0PoTPucXfJAOlnd7JTyoG/EF0F6C/rUcT4kBGKE3SYrO1kaQtmap6fMkGWcgLukmAIuAh65
 iqnSU
X-Gm-Gg: ASbGncvRZvZ8m/URerU0FuXoNlPNumDkKz73qBiYj0OEI6ygxCNF/Dlhfg+A9v9yfis
 KVQkLnOMZXWFLDztYDHmJg0A2yVxX32wVi8VNRooijckjUBbGPeDq2+Vtxd3XSPrT3LieASxRI4
 +1bJy9BBRIQAPqWRpc0YyWPeBLv9oSh7lHWAe2LJlgdX+VrsDvtmhj1QtCn+dEwSEsJcVPP4dwR
 LCK4F2BbgKg2u8ckqhab/j8uSkQZho+kTFKPWWCSF12rs2hWyomrGzRUt0i6LNpdiY7/nS/9DU8
 xv3WIUhcVh+kLoBmFe2tcwvxaJl9/c0Wv6dD4+MtV5tUcDpa+CSZk+aYZSCYyPgJDg6GK21NqMx
 Hh/2wm+RiKfGVx0lxtFBPnonk8bTv/GWbiI+kF/qXdTgL+tmeEpWQTf3ZgfPcdIy4X/UT8QhV2G
 WQXBs04w==
X-Google-Smtp-Source: AGHT+IEVNRiABOnE6bKEo59MIdSe7BEwzpi0XhH7XXFiMyCAPfAzyg0yUd4IhPHvb8J3CTjIOEu+kw==
X-Received: by 2002:a05:600d:838e:b0:477:5486:ec73 with SMTP id
 5b1f17b1804b1-4775486ee6dmr4950885e9.39.1762192733209; 
 Mon, 03 Nov 2025 09:58:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c569390sm165120595e9.16.2025.11.03.09.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 09:58:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/3] hw/net/e1000e: Fix assertion failures in
 e1000e_write_payload_frag_to_rx_buffers()
Date: Mon,  3 Nov 2025 17:58:48 +0000
Message-ID: <20251103175851.428816-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

This patchset fixes assertion failures in
e1000e_write_payload_frag_to_rx_buffers().  There turn out to be two
ways this assert could be triggered.

The first is the one reported in
https://gitlab.com/qemu-project/qemu/-/issues/537 where a malicious
guest could set up the device into loopback mode and then send a
carefully sized packet that trips a bug in the logic in
e1000e_write_packet_to_guest() that tries to calculate how much data
it is going to put into an RX descriptor, causing us to hit the
assertion.

The second is one I spotted by code inspection, where the assert is
slightly over-eager and could assert in one valid case of a just
exactly large enough packet.

Patch 1 fixes what I believe to be an incorrect-behaviour bug
for descriptors with NULL buffer addresses, largely because
that makes the following patch to fix the assertion less awkward.

thanks
-- PMM

Peter Maydell (3):
  hw/net/e1000e_core: Don't advance desc_offset for NULL buffer RX
    descriptors
  hw/net/e1000e_core: Correct rx oversize packet checks
  hw/net/e1000e_core: Adjust e1000e_write_payload_frag_to_rx_buffers()
    assert

 hw/net/e1000e_core.c | 85 ++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 26 deletions(-)

-- 
2.43.0


