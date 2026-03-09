Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C60F41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEa-0000lB-2r; Mon, 09 Mar 2026 11:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEY-0000kE-1W
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEW-0008L5-Jt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FfndHSyArVwAQZsbpd1CUY8UJ74t3/0SFuGSjOnWRHI=;
 b=OoQmfybZu0K2w4LL0PV6Z1USa8B93MAdKzrk6w2FknzWjeakdtBklWLm8hhmoxXVQJXd6u
 kYRe6shb2VEzFYhaav7RSAXkHY+RxRKlMYuCZJPgVDbcPFYbLRpx6kgx9pQNz08FejLM0d
 TgxN6nTQVeZwFqetc/UC+0NYmdySIjs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-qQSXospPOPWCmwx4aJDLQg-1; Mon, 09 Mar 2026 11:09:22 -0400
X-MC-Unique: qQSXospPOPWCmwx4aJDLQg-1
X-Mimecast-MFC-AGG-ID: qQSXospPOPWCmwx4aJDLQg_1773068961
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso138887145e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068960; x=1773673760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FfndHSyArVwAQZsbpd1CUY8UJ74t3/0SFuGSjOnWRHI=;
 b=Run/GTrkQLrcFZWu5m38+gwOR1xuQCNOfasRafK/Kl+yGVPpPRXoSXhPO2/C5P1d3n
 FPaxaCjbafJtAPaduxc64CXD3HcWCgLNLKKS7M+D2y4mF6BVCtwTQ1aSJfIcvPF/VCW3
 xyUWf05TOfaKPdQP7PncWU6gsWq4H9kE6BEOszM/+Er9NDitGKSIwxHNxYZEvbDdctYX
 HvBtWgDyFmXqldjSrijpPr0St2yL8/xcTRkDWeitqoolKIjl+Fpx2TLyar42T1Jqi36O
 qul2RvTf7Dcw54JW/xpUcESOs1ydT5VGnka2jtnw+5KJbZbl968ac8HqeOxiGPR9A5eM
 zEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068960; x=1773673760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FfndHSyArVwAQZsbpd1CUY8UJ74t3/0SFuGSjOnWRHI=;
 b=R1tAGfpDi2TmTUslIuvY9VHaRTkGOMFTqvwDh9uIAHtm+Jfl2Iu30CIN4sRxRQoGtQ
 uaAo5U+Ug//ro0s4apUyHRxNFqPy3FqDXm5km1jWLdKJh9C8rfLS6GL0GJJxhPTMKODW
 jJ0ZwEKCy6BkaIqAIrE9bIoOYHQVFTP0Qt9uqxFGGUfu/v3cjyL4WD5JlVQaJ/2GnxTo
 FGKDyjoENKBLsTNJGhc7W4obP4tBgS1stnfTkc2pwR80eITZCuGn7ChDCRR07I8cRiDu
 0AGKfjSj3CqqnVRVf5U6uD+RSF7wf77nwQk1ATUj06tA7hvjiZyn4iyRZFryisVadQ3T
 ajxQ==
X-Gm-Message-State: AOJu0Yw2lTolMaAjokiWITxgC62oxXqkuqPG408gudfE7WvpUxOOkYhZ
 v4hhDxS6PYAAyjJl178OJ/ujhTE7Y6iZISZEKI7Ueeyq3nilpZaRHrw/+yhJMKODMeOKtt0El0g
 WsINXV5pM+nJYaELlTvhMFu2EIPGJGfRgjW4rvzp3SyDHitYBsHfuLSSh
X-Gm-Gg: ATEYQzyX970/VY6/4H+FNlsvkGfe+j4CPLLJ9UHgTfr22Bf/RhNhsbSSQIb4Mm1bzC4
 EoH5mik6oUE7kbuJfFNaSPM0HFuJ8Ccnp8/xdcjLszq2ztB5A29XxdCG68EJHQhwjuU5StoIJnF
 RkF/l9cYZlg+K1Fuo1JSER7N8lBGqP3vCGr+Oywqg+SrYcNOcN5ah55su+FyQSfD+Ewv+UkG4c1
 gSkZdROv8VPMpHolOcIgKLnCzfBk6UNOiOmerD6h1pF7PeYIAlbv4wX2frgsCXmZYvyYTfsyYlA
 oHh/1F3do06DiLCUTiFLOQU4GsgzeS8JqLJGs8FTIKm6NBPPGC6rVXrS8XIgutUxBnDZlwpGxtC
 dSJHMjgjws+DiP+rqVquqlRTS1cFzO29x3QGXS7piJeCGtFIekVsF6WgBZ9rfFewj5XMQTpEaE+
 DmMn1h
X-Received: by 2002:a05:600c:c8f:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-4852695b63emr198004375e9.19.1773068960401; 
 Mon, 09 Mar 2026 08:09:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c8f:b0:483:703e:4ad9 with SMTP id
 5b1f17b1804b1-4852695b63emr198003655e9.19.1773068959920; 
 Mon, 09 Mar 2026 08:09:19 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48539e574b5sm115359235e9.8.2026.03.09.08.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:19 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 06/25] fuse: Destroy session on mount_fuse_export() fail
Date: Mon,  9 Mar 2026 16:08:37 +0100
Message-ID: <20260309150856.26800-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

If mount_fuse_export() fails to mount the session, destroy it.
Depending on the allow_other configuration, fuse_export_create() may
retry this function on error, which may leak one session instance
otherwise.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 00bb2ffee4..82560ca071 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -270,11 +270,17 @@ static int mount_fuse_export(FuseExport *exp, Error **errp)
     ret = fuse_session_mount(exp->fuse_session, exp->mountpoint);
     if (ret < 0) {
         error_setg(errp, "Failed to mount FUSE session to export");
-        return -EIO;
+        ret = -EIO;
+        goto fail;
     }
     exp->mounted = true;
 
     return 0;
+
+fail:
+    fuse_session_destroy(exp->fuse_session);
+    exp->fuse_session = NULL;
+    return ret;
 }
 
 /**
-- 
2.53.0


