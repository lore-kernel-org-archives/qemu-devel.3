Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59642FED2C7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0XTy-00006P-VS; Thu, 12 Mar 2026 00:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTx-00006E-Er
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XTw-0008ML-2F
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773289027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qop9iAmQn1QJUZ8RAGJLSEnZxR8JmQrzT1EQUFiNBPI=;
 b=br3DEBhujqiN0ZDCqU7sIJgZZJQDQAhJeJBY5JX+Pf2O99pCA+kjjJHVT7XBYmTduq8UG+
 mqRl1pG8f6U/WBBjOH2UkAYA8i9/aG1Ns4YBJ9EnFsMY813QfjoY4Qk0kAS2ek4FgYmnvH
 NWuqccmTF3lCtBZsSX2IXQZi3xtL2t0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-6aqRynNqNTSOcb9M2aDsWA-1; Thu, 12 Mar 2026 00:17:06 -0400
X-MC-Unique: 6aqRynNqNTSOcb9M2aDsWA-1
X-Mimecast-MFC-AGG-ID: 6aqRynNqNTSOcb9M2aDsWA_1773289025
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c73935acff2so273510a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773289024; x=1773893824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qop9iAmQn1QJUZ8RAGJLSEnZxR8JmQrzT1EQUFiNBPI=;
 b=TjOfP+BPbSeJHxKQosD+1GGc0WUPo9ocTwu1nWZPNFwvNPoJ047nS1q50vxP70qHzx
 g1pFBJ8gJ1K9VCSr8ChvdH5P5ws0sPvfyzO31Ktn3ujBi17UINK7vNexEXRATIu/B0x0
 7qDwkRKbEa6r3orH/1JCPYNaN759od5rVuAOYNPe6bk5IK24sqUao/ojOha7TB79aQpY
 3tZ/TDpUAfIxNkyk/1P83VglnFuQdekvS34AXvDpFBrhnLFgEDvEiJp+V+BuUsiKoQ4g
 ODLOqkMceQee+6BPf4d2gIUhoJslAKzyZ7jrCfe65WGCG3yyDT6ZAFBqdyk3WD/IY5hF
 MC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289024; x=1773893824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qop9iAmQn1QJUZ8RAGJLSEnZxR8JmQrzT1EQUFiNBPI=;
 b=reeoNRVP1afIZU6u1iFCL9ZwzmSs7OmcuKxMS7e2EriCCISC9vuWCuZxZhUDFo/Z1K
 qp+VeYP36oP31WhleQExcPs5z5Yymfqt7n6+VP4R0RRVbmv+rNsSkht+ONihLJOgWEQw
 ZrxcpvfC1FkZ70P4dcebjtUD4X3iHJi9yhSZ5xUhkYBKJ8p5KRdfXh0KHcApnRNHIgB9
 7BsrNZSjuhs2YCqitMJST0dohXDiU/st6XmPkfILjeQfdJ+8e9HG62OJxQUlX6VkKw4q
 tRmvjl4z2a1q0jlrDJxLxYh0hyHsqMZFvG1PrJS/8WZC0f58cp+ZdTrlBUslnu2emdp1
 K75w==
X-Gm-Message-State: AOJu0YyaEDL5axCYzq0ZgkAmpVXrjSAEQFeB+W5Xju2kffqlBiXTa2To
 vH3tf9rMqd4gC9/y112kUL4vq+x3K3GPFp+Y7g41XW55oOE3bzREkgCbnm4rPDABIX71edXfvnp
 2vKBi8gAH5Z500UJ6If8HqN0VBRtmXGeS189mrREBJTMFsPhOuIswuw3rIUvPWosWHoCTgzt+7E
 B2+JCDh6RpwSqM/5fNnuLllkK1pcylr7WbTi+4TBw=
X-Gm-Gg: ATEYQzxsfRxQbtEPkVBNsj/rzkuANl8Tfw/yTKLSfb2hBXh+mmi9QcA0713wyY3UsqV
 Z1C4x2cnIRMrxhNRXDlKLaCNgvR7AeH0xDe6qX+B/drzbHSpwB3yXHKGytRBdt7wh44SZQfeBKf
 R0xrINJQgWCtWA92a04/sE8wImlRszZUqHfW38QiSjO9a+1qj9l/y+RIRdfoGFdUk6gsb004KRt
 U18LtHihhtElvxoHX97uS3VSQq49NcUq8oVY1EVUi5KcxD/WitS0UEt3MGsOFEoHIChsBr08MiB
 V8DVNvuu1jS0HjVEwMU460quhLEGfwAnhzYPAlIt2yewVdeCFvgbWMP4xUzRonA09+60U4Ydrtg
 HnD22N9sZexsnFFib43cilVQh3xGm3x9GHn8xvoUWAYppnpCLG5PkzLPCCm1JLA==
X-Received: by 2002:a05:6a21:a43:b0:398:78c0:6dca with SMTP id
 adf61e73a8af0-398c5e6dab8mr4736425637.15.1773289024383; 
 Wed, 11 Mar 2026 21:17:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:a43:b0:398:78c0:6dca with SMTP id
 adf61e73a8af0-398c5e6dab8mr4736395637.15.1773289023928; 
 Wed, 11 Mar 2026 21:17:03 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e498sm3634490a12.3.2026.03.11.21.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:17:03 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC 2/5] hw/tpm: Refactor CRB_CTRL_START register access
Date: Thu, 12 Mar 2026 09:46:47 +0530
Message-ID: <20260312041650.181411-3-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312041650.181411-1-armenon@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace manual bitwise operations with ARRAY_FIELD_DP32 macros
No functional changes.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/tpm/tpm_crb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 0a1c7ecdc6..bc55908786 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,7 +145,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
-            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
             s->cmd = (TPMBackendCmd) {
                 .in = mem,
                 .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
@@ -194,7 +194,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
 
-    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
-- 
2.53.0


