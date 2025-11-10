Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE790CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU96-0006TU-LP; Mon, 10 Nov 2025 10:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU94-0006Jv-H0
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU92-0000xT-5a
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kcZ9cJ7XI8zX0UMxvj6MtEZfatW1I55Tpkyvd/DszeM=;
 b=AZ4N9SSJ5fnZi7ME7llYwuNvrUPOtWKrYBoJrOiM3nMrVS+13/kqSmXOBTcvRRhkBiKkcT
 f+KMIDeQ28H0Ak69S0791qw7A0vEx3SuRvX24a7h5hfZpPoxtNLk9LEjVLiZlzOjHUf70i
 hwcS9I/eoITsAyVjOhL6C9J1kOCMD2Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609--rNLfSNwOC-PsTFK1DoyZw-1; Mon, 10 Nov 2025 10:49:25 -0500
X-MC-Unique: -rNLfSNwOC-PsTFK1DoyZw-1
X-Mimecast-MFC-AGG-ID: -rNLfSNwOC-PsTFK1DoyZw_1762789765
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c5f1e9faso2506313f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789764; x=1763394564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcZ9cJ7XI8zX0UMxvj6MtEZfatW1I55Tpkyvd/DszeM=;
 b=OuEA9Xw2eJ0Oc2mYE7sG+cZbd2NPJzzZKYebmOZC2a85WpTXjIGbFPz5F/98FNgxT3
 QcXJoYTPntv1qlHGbXArEtt2kFq4HYiB+3lnm5DCviLG5C4tThiQjM4VmULaKf0jaPlr
 VpUHY7nqJhySCRVDay/YYVsW3R7CbIppnghwKGZYVrvZzz07xKRNx3D9J+RGPZwFBAfZ
 psChpLt/Wd7zOkj4b6cSozrI/qPk0a2uQuikXcLGPWq+TGphCPa48as4W8nh/Qr07gJE
 gGTX2GKSUPgaiY660Hh1E0dUuGEUNRxbidANXd+MpPKBLGph6j+lt7l1XMBXGvYfBTye
 /h7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789764; x=1763394564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcZ9cJ7XI8zX0UMxvj6MtEZfatW1I55Tpkyvd/DszeM=;
 b=bk0bOlPOPvN5Wd7Ct5UxcegicQaN3Vd9ZO9RY1ltTxXpZuGTsv8+xCG2OWtA5vRfND
 2Y2A82zllwa3Hi3iCiW2maefZJ5BCVj6WG63RDkK+GIng9gt4B86Pr//2P4T4/S9IlXm
 XPxAbjvep3hsNjrEkACdUx7MpHfKx4tRZ3H980ZWQfIi1gZYnPzHx00oF6YA4WZOU44j
 jzDsFfVjuWrXtX+qxl/t2pfMj0AF948RLhgp3LCPoLGQ38Q92MmEbKv6ImFt/RgAQUpo
 T7p5BQLrbsgcqjVBJ39o9oNsT7RKmsHsrdxBJ0AKN2z+C7m6IrtRJquTs8Rbgy+sSnRb
 lCzg==
X-Gm-Message-State: AOJu0Yyc4kOAlLlyFesVl/3EVTYG0UuBXPcr7ER7n+iNyyhXQK48QYAi
 Wdoz3+yR1kH7wUsrP3Kn9KXgrpksdshaT4kziUiSgEeqKT3RrK8WUTLTCTzpdGnT2136h5m8yim
 oGtRhVVh/enGAE65AhFw2EjZFgwsmtTdOu6tSEjdHd0yl1x9J6C5AmGt8
X-Gm-Gg: ASbGncu4ZNpUEBmomU0+/BL3lKkg+ZodVCTsKnpfYeMY+yBSy/mdnqMGWtQFSz884fg
 2GEX+r2qpD2h163/0eIcoUcqs0+LDTj2aFdfVi/1DKtIwKP3cFiTxOHchkIA6H5Rju54kYMZaK6
 hwFPIjXOk/2GKXkpSKTKynP4BTYx7ZXiDDlHrUZi1wy+mtICbX9NIDJiN3V+jSQpfGrfpUGeMgI
 +2AyPn5TrAMdiJsyVNd7/VSD/JYCpDMhznE0BRPT+zXPVaUOaeO5t0cyo7X9aadBefmcqxnsfxE
 1MiXiqeq2XDTcSalg5Lg/KVRLbs3/t3OOHx+VukON3uRpuKsiALw8t1TBLyDl8YURp/tmJViKIW
 huyJogJQwETXbbjgQKuOov3TRmwk2VIWk3gUhocfeq0Il4lh0Jfu02S6iBQ==
X-Received: by 2002:a05:6000:4212:b0:42b:3c25:cd06 with SMTP id
 ffacd0b85a97d-42b3c25d15emr2680114f8f.22.1762789764440; 
 Mon, 10 Nov 2025 07:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMzYHbRYGc459AF8fuJ+BcXpot5aWeQZFSTZQxsQG73NJOnqkFgTeJXT+c4kjmUbrCZSYMrg==
X-Received: by 2002:a05:6000:4212:b0:42b:3c25:cd06 with SMTP id
 ffacd0b85a97d-42b3c25d15emr2680084f8f.22.1762789764041; 
 Mon, 10 Nov 2025 07:49:24 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b32c1ad2bsm11323758f8f.6.2025.11.10.07.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:22 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 07/19] nvme: Kick and check completions in BDS context
Date: Mon, 10 Nov 2025 16:48:42 +0100
Message-ID: <20251110154854.151484-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

nvme_process_completion() must run in the main BDS context, so schedule
a BH for requests that aren’t there.

The context in which we kick does not matter, but let’s just keep kick
and process_completion together for simplicity’s sake.

(For what it’s worth, a quick fio bandwidth test indicates that on my
test hardware, if anything, this may be a bit better than kicking
immediately before scheduling a pure nvme_process_completion() BH.  But
I wouldn’t take more from those results than that it doesn’t really seem
to matter either way.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nvme.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index 8df53ee4ca..7ed5f570bc 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -481,7 +481,7 @@ static void nvme_trace_command(const NvmeCmd *cmd)
     }
 }
 
-static void nvme_deferred_fn(void *opaque)
+static void nvme_kick_and_check_completions(void *opaque)
 {
     NVMeQueuePair *q = opaque;
 
@@ -490,6 +490,18 @@ static void nvme_deferred_fn(void *opaque)
     nvme_process_completion(q);
 }
 
+static void nvme_deferred_fn(void *opaque)
+{
+    NVMeQueuePair *q = opaque;
+
+    if (qemu_get_current_aio_context() == q->s->aio_context) {
+        nvme_kick_and_check_completions(q);
+    } else {
+        aio_bh_schedule_oneshot(q->s->aio_context,
+                                nvme_kick_and_check_completions, q);
+    }
+}
+
 static void nvme_submit_command(NVMeQueuePair *q, NVMeRequest *req,
                                 NvmeCmd *cmd, BlockCompletionFunc cb,
                                 void *opaque)
-- 
2.51.1


