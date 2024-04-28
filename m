Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCA3C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 11:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s12Rh-0004Vs-EK; Sun, 28 Apr 2024 07:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s12Re-0004VW-Bt
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:11:46 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s12Rb-0000ZI-Nb
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 07:11:44 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-60585faa69fso2326967a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 04:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714302702; x=1714907502;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oqrT6aUq3cF0ZFgXAGrwdFxl94n9uIRGqQ5UKYpt5V0=;
 b=q3/fFX6FJNYbNs+DX54WLmCkDNMtVJiyzYBd5o2pJrd33Pl8vXBJ5xOW51RUILHWBG
 jQ9GAOnNwWjDOG7PXJu7FH16U7ie4ir2ScDhmh+w57KKLF6rHdyQgci0q/oGNr+8gU7e
 Oi8WSOPs7ZovV7htTqCfrNeFSKNj3yAAbOVON5UKYrCWdwAdmZ5iQIMG3/UfZ5wKsf4P
 MvfO7FtCO7N0gI13UvIjOhpolbXjT+kLeegpMbI4R3W4rRq5GU2pCJU7vwjdKbpYqq+s
 NfZgj03NV20Oyt0K1XRbKR7y0vex/685jzqTe78o5HJQGciAN72vDYDFd+8svu7znEAH
 dDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714302702; x=1714907502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqrT6aUq3cF0ZFgXAGrwdFxl94n9uIRGqQ5UKYpt5V0=;
 b=sP3VeyGr2obVhbNmhu6OxGsDVVorJfMzbK3evby2qfgH/V64rQotWrZUrSAILxBiTm
 FVjo3AUwfUyUR1NuZGkcI7BeNdUxwTneIuTbuOAI1rqPDiv9IHkWhqFYRMSu+5PWGZ8y
 Z8OSRcuhJDA1sL3QLA0Ve2weJPa3NQvgvLgW1y4zgGq6F/EbyKOW/g5XaX57ZIqMct6D
 qySkZgTpPen33zJ/+I3Hovoh/Jr2TkUR1CFeqJY4x/n0uPZalyPdXBMQSjdHSMcKRKbn
 P8hqviBwM/7RV7UUZRkgjSX7xRElZ1HsXCAdt1P328doBR+3l0yR7ghFgAptEAbBHIUH
 xm4Q==
X-Gm-Message-State: AOJu0YxK0AbT2k6RDYFnKnnpcWJFPJU86JZKQ5wpRp3DbMyMkOLkyJaT
 2VTZelKcMIVxNObEHcvB1ZF14df/5kBpQ+M6CxDRODVzLJmMOsBamS3zuf4eBjY=
X-Google-Smtp-Source: AGHT+IFoqK4NEwJCXyVclBtGbs6d9Z35y71C/0kA6E4Jfjr5kvPsjcfrImecmSBYME49bEwhskVI9A==
X-Received: by 2002:a17:90b:246:b0:2aa:cadb:d290 with SMTP id
 fz6-20020a17090b024600b002aacadbd290mr10457226pjb.13.1714302702375; 
 Sun, 28 Apr 2024 04:11:42 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 so13-20020a17090b1f8d00b002aff85b97dfsm5274672pjb.27.2024.04.28.04.11.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 04:11:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 20:11:23 +0900
Subject: [PATCH 2/2] Revert "hw/net/net_tx_pkt: Fix overrun in
 update_sctp_checksum()"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-iov-v1-2-7b2dd601d80b@daynix.com>
References: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
In-Reply-To: <20240428-iov-v1-0-7b2dd601d80b@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-01a33
Received-SPF: none client-ip=2607:f8b0:4864:20::535;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This reverts commit 83ddb3dbba2ee0f1767442ae6ee665058aeb1093.

The added check is no longer necessary due to a change of
iov_from_buf().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/net_tx_pkt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b7b1de816dc5..2134a18c4c90 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -141,10 +141,6 @@ bool net_tx_pkt_update_sctp_checksum(struct NetTxPkt *pkt)
     uint32_t csum = 0;
     struct iovec *pl_start_frag = pkt->vec + NET_TX_PKT_PL_START_FRAG;
 
-    if (iov_size(pl_start_frag, pkt->payload_frags) < 8 + sizeof(csum)) {
-        return false;
-    }
-
     if (iov_from_buf(pl_start_frag, pkt->payload_frags, 8, &csum, sizeof(csum)) < sizeof(csum)) {
         return false;
     }

-- 
2.44.0


