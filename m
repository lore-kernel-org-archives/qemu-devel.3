Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E395CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSJR-00067S-Of; Mon, 11 May 2026 11:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIP-0005q9-Fg
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIL-0001qv-Vq
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:47 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so2650641f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1778512305; x=1779117105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yv/dVX0kdD5IT4KjvoobqGU1SwaEsj6wNpgpDbOtol8=;
 b=FQftJiFmPSpvrhvk9nTBEli3v0D2U1Rsdhigh43LmJOtju7RlC3c8QFX531Y4OyDwx
 w6ETu5456yvYZEyFp0kdgn8caWH9PFmU6hOLJYNjqd0Z3vUnOLs12/kf5UP64aV3HvzE
 D5qKz38qMiFedaBaIhyS4KhKCECA7BugziMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512305; x=1779117105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yv/dVX0kdD5IT4KjvoobqGU1SwaEsj6wNpgpDbOtol8=;
 b=QUcwBDaXbDfFoAanbl5l2DllYUmk89ShJkHYQaUVh1e3Ujv0Gyr40Q3VPBQq6UdYQ2
 sns7wLFCYhppqTYQ5Vlc/ad6Pn7udtY/C+pDoFftcGjB3DM3RHtH++XBMcfRcqDuBk4G
 +88oD+718fMKul3AIm39VDWQhg3Tvj5G8Hhm8zwwQE5d65maoTmvJtpYqmKQkpYV4wOo
 Q+UrWIrJBH9GoT2eKNFrvrPYwdILOdXxUKLykWyH9ZTJbPf0QkvXtSN0YJm+4prjDGME
 sKoH6rRQ7w+dM/Tku9SL4NaQQ+gNipdeV8gIRfn69j9sDKNTs4stnIWo0EyIxCT0crpB
 Bdvw==
X-Gm-Message-State: AOJu0YycK0+hNOB7jIcjoHKFDGxsDW1J9APCbI+PAm6BEySjpAY8Wr+L
 xUKVDdT237Vqp1+6+ZW3zajEPGC1Wtg79ncQuUi2Q7FHTeHNc6/stOjc+6uxu32KR8zS7h1/A4o
 5/fiIUIQ=
X-Gm-Gg: Acq92OFRR22q6WzkeBp9UCHtuYNlWiImJHq+C+LK+DcJACnnKkLodad+Evbp1xXtBt5
 JxhiJ9mtNNfKugJL+U9UcoCmmjEboB2i9aYWRfaXAltvWiM6hQ4zB5LiTlfu4M+0+RVeAaCNMyT
 ma/D7UO8TRa8MAYZyyMzb9XM1L/QYNUY0cRS7w1q/WyeFc6KRhA3jbQGFklRmzHMvAyZbVIls6N
 gzJ6yEAEByyJTPK+WijmjMxre1kjqZ6QD9XHlqmUakpk4C58C2MavcfK0iP2HOfNw0fiD0Czm4b
 mF7fgwc2gDAdLqMP1J8xFBIibWuocm7YYoOcVZy+cREb2LcM6gxEybJUVfUhP41ZyN887dwcSAf
 inaTL9w7Nn2uMXIolyKvbe53LX34SnCZ57TyokNInvhLOYuqdhrzKH4REnCTDdk5OtmuLULPhym
 koC4MjQ5Ogce2M1K8u8kEd7K01Hgzy9yjGqx6CqaxnlGcrvEda+YPfnl73spcrenZ/s7LPQbZA+
 NK80yWwwKDuiirjpjNk
X-Received: by 2002:a05:600c:5248:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48e7069175fmr167350045e9.10.1778512299862; 
 Mon, 11 May 2026 08:11:39 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00267b069c8b2d0c7b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:267b:69c:8b2d:c7b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6813sm65766925e9.6.2026.05.11.08.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:11:39 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v7 5/8] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Date: Mon, 11 May 2026 17:11:28 +0200
Message-ID: <20260511151131.483217-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511151131.483217-1-alexander@mihalicyn.com>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x430.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Instead of unmapping req->sg in nvme_post_cqes(), we can do it earlier in
nvme_enqueue_req_completion(). When req completion is enqueued we don't
need to access req->sg anymore. We only care about req->sq, req->cqe and
req->status.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ffee7ef224c..31c1da4a61e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1534,7 +1534,6 @@ static void nvme_post_cqes(void *opaque)
         QTAILQ_REMOVE(&cq->req_list, req, entry);
 
         nvme_inc_cq_tail(cq);
-        nvme_sg_unmap(&req->sg);
 
         if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
             qemu_bh_schedule(sq->bh);
@@ -1564,6 +1563,8 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
                                       req->status, req->cmd.opcode);
     }
 
+    nvme_sg_unmap(&req->sg);
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
 
-- 
2.47.3


