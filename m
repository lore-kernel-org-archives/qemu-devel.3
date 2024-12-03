Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2722E64A81
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR8y-0000uA-1A; Tue, 03 Dec 2024 06:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8w-0000th-Mn
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:38 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR8u-0000bT-Ty
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:32:38 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385d6e36de7so4640220f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225555; x=1733830355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkPA+7sTb+zksQscjRLpnKKKt+PKAd6deC8dAij30IE=;
 b=he16EbLc2a+EOpPulgqlAJROAgVrftDkh2xSSUDHVkk/c2BWnpz8i7u7X8fNeAm8rH
 hkjlzVk7hCyFcZS5D9G7KwnnB6YRWBwSvtCHEb0tRlNbKeTtrai/m8lmXXkSb0vJ3vf+
 9Osje6UHtHBbCNLIOdsOBy2szTfvrt5w0PhbxQMM5rGd1Wfx0sR5gn/tZOUiwcCoclIm
 qchnjGonl8mn6lCC4vjF4VJYOlzj83nPy5eoPLoZFxQOCNIPv1cTLqF8PVFiqp0zeUGs
 iUMzK0QCCOpu55EUFUu0wyE5nt00pc22zkFtGEe3Tx5Xp+yzTeXpOaC2bFOpdj4XstqV
 CBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225555; x=1733830355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkPA+7sTb+zksQscjRLpnKKKt+PKAd6deC8dAij30IE=;
 b=j5DcnChWKRTMNvLrcA5PE7MXoMVcJIucPZuYdqhDjK0JYKiUKEC3y7p+gFkAAVcZcL
 kk0iy0/FpSqDZNdiaRwWIoy9+Eacww0cQKHRE2wO/TR5v4b3eQAVb587GMydOmC9FoI7
 1mtbpBFkhEqE4P4HhNzGki9Ng4ZTejMFmUqre0nuTJdzitYjjCKnSVrgYnhnN1kIGzCe
 SrJLciNKvlGx9fvz+IzYIYEHfODoFynycVo7oLZf5rPVIsnD87fRjVYanU9vGCqWVapN
 dhXgQyMpUOlo2Z/FlW6YMVOOXYnLw/onE9BTd+UJmEcwNm8TvzLjeJutM2fISlvn0Jlh
 W7Jg==
X-Gm-Message-State: AOJu0Yz+RhpUHnNW9hwlG5da3qh5Lgf17UjlWDtFavlWds/vjEmjokOW
 db8VI7xRyHTo+GUqvZMQ1WRXU7D5/eIxrTWq0Zh0/4TzemKqS/irVAv9lxoFwDET4nblSE98xAL
 LGoY=
X-Gm-Gg: ASbGncvYY14cVMK4lVi3nCQ/wptoiRgsh/xOjgz8JoncZoE8nE7ByXfVm2ENoD9Tw2m
 h5S/+h3E7A1mdAMq/SpZNmjRNM3lRUCunmTQ9qNpWdN6L6JTYJk7H381T/PvlibwTW5b0SalG71
 Q3EqNjAkE/xZrEQmKa4DWCGRvz09ZimspXsJh7iqOt0v5odDa1NtdivJwnmIRv7uNWQ5ac3V/EI
 9KmpRqAj/3VKk/Av1lZuCov8igqtVoFEpnj0EGwLTHB4dxfmQrbDtYLzvJaUPamPrda/Kmh
X-Google-Smtp-Source: AGHT+IEsSvHBK/KirKh/PQovDt/62PmlOWWNREJ3zaV7YejD4DXKamWNWsjA7XfJ01hHxxPGPdlMgQ==
X-Received: by 2002:a5d:5f84:0:b0:385:f1ac:3ac9 with SMTP id
 ffacd0b85a97d-385fd3ea448mr2064523f8f.17.1733225554837; 
 Tue, 03 Dec 2024 03:32:34 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385df50fa9bsm12523649f8f.72.2024.12.03.03.32.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:32:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/13] hw/virtio: fix crash in processing balloon stats
Date: Tue,  3 Dec 2024 12:31:37 +0100
Message-ID: <20241203113140.63513-11-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203113140.63513-1-philmd@linaro.org>
References: <20241203113140.63513-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

balloon_stats_get_all will iterate over guest stats upto the max
VIRTIO_BALLOON_S_NR value, calling visit_type_uint64 to populate
the QObject dict. The dict keys are obtained from the static
array balloon_stat_names which is VIRTIO_BALLOON_S_NR in size.

Unfortunately the way that array is declared results in any
unassigned stats getting a NULL name, which will then cause
visit_type_uint64 to trigger an assert in qobject_output_add_obj.

The balloon_stat_names array was fortunately fully populated with
names until recently:

  commit 0d2eeef77a33315187df8519491a900bde4a3d83
  Author: Bibo Mao <maobibo@loongson.cn>
  Date:   Mon Oct 28 10:38:09 2024 +0800

    linux-headers: Update to Linux v6.12-rc5

pulled a change to include/standard-headers/linux/virtio_balloon.h
which increased VIRTIO_BALLOON_S_NR by 6, and failed to add the new
names to balloon_stat_names.

This commit fills in the missing names, and uses a static assert to
guarantee that any future changes to VIRTIO_BALLOON_S_NR will cause
a build failure until balloon_stat_names is updated.

This problem was detected by the Cockpit Project's automated
integration tests on QEMU 9.2.0-rc1.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2329448
Fixes: 0d2eeef77a3 ("linux-headers: Update to Linux v6.12-rc5")
Reported-by: Martin Pitt <mpitt@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20241129135507.699030-2-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-balloon.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 609e39a821f..afd2ad6dd62 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -167,19 +167,33 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
     }
 }
 
+/*
+ * All stats upto VIRTIO_BALLOON_S_NR /must/ have a
+ * non-NULL name declared here, since these are used
+ * as keys for populating the QDict with stats
+ */
 static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_SWAP_IN] = "stat-swap-in",
    [VIRTIO_BALLOON_S_SWAP_OUT] = "stat-swap-out",
    [VIRTIO_BALLOON_S_MAJFLT] = "stat-major-faults",
    [VIRTIO_BALLOON_S_MINFLT] = "stat-minor-faults",
    [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
+
    [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
    [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
    [VIRTIO_BALLOON_S_HTLB_PGALLOC] = "stat-htlb-pgalloc",
    [VIRTIO_BALLOON_S_HTLB_PGFAIL] = "stat-htlb-pgfail",
-   [VIRTIO_BALLOON_S_NR] = NULL
+
+   [VIRTIO_BALLOON_S_OOM_KILL] = "stat-oom-kills",
+   [VIRTIO_BALLOON_S_ALLOC_STALL] = "stat-alloc-stalls",
+   [VIRTIO_BALLOON_S_ASYNC_SCAN] = "stat-async-scans",
+   [VIRTIO_BALLOON_S_DIRECT_SCAN] = "stat-direct-scans",
+   [VIRTIO_BALLOON_S_ASYNC_RECLAIM] = "stat-async-reclaims",
+
+   [VIRTIO_BALLOON_S_DIRECT_RECLAIM] = "stat-direct-reclaims",
 };
+G_STATIC_ASSERT(G_N_ELEMENTS(balloon_stat_names) == VIRTIO_BALLOON_S_NR);
 
 /*
  * reset_stats - Mark all items in the stats array as unset
-- 
2.45.2


