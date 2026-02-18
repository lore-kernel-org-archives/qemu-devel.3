Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23124E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfA-0003pD-Ox; Wed, 18 Feb 2026 08:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshf6-0003oI-Ti
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshf2-000546-3i
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yWcGLprdpXgo2UanWZOxr3c/Uu5d1zE+FoOX3fFgguc=;
 b=Z/q3DZLPHhWwTJW3iiigHPCMCPOdcl43XdFKEeiS+nWqAHgxWPZASjCnLHjcprb6jFHz3q
 gc/doRaKCneGz/NAQOd1m7mVnMU16SnSfRKoNcLAaokDhOBbPKF5zw2Gr3WLx2Cnelym1A
 GNa8RN0wVKQsw4qRj7Nln4mueGCff1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-LUVopu8ZPdmRCbCTfR509w-1; Wed, 18 Feb 2026 08:26:49 -0500
X-MC-Unique: LUVopu8ZPdmRCbCTfR509w-1
X-Mimecast-MFC-AGG-ID: LUVopu8ZPdmRCbCTfR509w_1771421208
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4368060a5e5so5642639f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421208; x=1772026008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWcGLprdpXgo2UanWZOxr3c/Uu5d1zE+FoOX3fFgguc=;
 b=D/SHPUPpG5gE9D+pwLeTDU4Pcbvx0/1d0c10AYgfWNSlefQi4Z9ilxgtJnFWnLFxTp
 Mq7r9Jc3neeX+aJmhr3a6g9svaUxihI+5PMPk6SQBX4/ASpphfYchJj042rGFzrl3Atw
 QuAORszsT4fPLpuOZWhuV9pHLb6sLETl+/jEsQ8Cfn/YMfJSwAQeV9qlR5fqvLQcH4vf
 DcWCXCcHfPcIqlifaFS44VoKybBBiMEhHHbhr1VTErrjEF0nzEm6qMvB1q2c/B4lq3bL
 Mg3s8j5FGWNBIo8P/B+EwpmYJ/6gtExyU1kc3QgU5/vt32pQEOBKr1LFygC71G719YUx
 6C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421208; x=1772026008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yWcGLprdpXgo2UanWZOxr3c/Uu5d1zE+FoOX3fFgguc=;
 b=bus7eGLILJtx7aW4SBZ3yHTYNkQWk/78lSMxheSB5Ir5bhX4CTEoGgi1pLV7CTOeKx
 +8P2zbpIpJ24Wl35YOMtRBZKBcVS8mb7h3hklLNyRBWuG6b28eja/3NB/u/gHFreRern
 DHD7oAF2a3kI3SEDOLIm4YpibyVWNXYoxwb1a0TQF2E1BpSD7BiXCrJb4WXNVbN9B5i2
 fj55bxTXeTXIkQklS6DlqakZWmcWAcw4dhl2QM1vUmxG2NjsrQ92Wi+hMiHxF9rtrFof
 AF0x5UIvW5SlK2zwmq0VZbfmbFF179FSZt8+fzdRfLWvYBvtSy+xGZoqC3oUg+cM6C7/
 /gnw==
X-Gm-Message-State: AOJu0YyRy5tRT+aFcQyeKGdiKI0rBy6viVxUuOaYxPAlFG3kf/vlvxhx
 r4ItnPglI1DHPENozdq4JS/P/ha1oW6j1m0bg2EXwgZqgSI4Rfs4/TI5Og85+FXz+vplB2upKO2
 1wQgE4CvyZIDU07abqMqUfJ5+NK0uqgp2jtEfW4uN5gclNCQRC9VcvyTk
X-Gm-Gg: AZuq6aLXi5CiUTLOd8sJXdKCdlOrbL+oBV+p7mfNmPbsNLYIk+zeIlSSyeqbiclSr8o
 2LSetFOfMYsKPjd3wZq01D1wm9XSNwyP8X0wl4P6dRkr/YOA17m0gD6Z4AQkb5EDO99A1+dsfv3
 /m78nTLzO5XV2ca8/z4++nHzcq+f8ohDzulyPQKlFRiGx3a0NprAcLewEV0nHxvoK6sHAX55tnf
 G/4Zmu1n8oBmUrKtVVR6bcR4ve6fL6Q8yDSmYut/CR3IlsTDnlen0waA/k0fr0q1AHTmM+FI9xT
 olfU1WgmU4HFL7hLVg5gjWbkIFQiRg5p8clEE7EoBUJ0anxSdy/u2s4iMsbGbKJCggVl5ueo5SR
 ZFlJbo72sX0n0A0MfqjZhgf6eUQ6hDKB/khfvu/Ouu/CboxS3k2ufuBaB6rr1x39ASMIDYeXJOJ
 v8U5t4
X-Received: by 2002:a05:6000:2508:b0:435:8e14:9877 with SMTP id
 ffacd0b85a97d-4379dbae484mr23152421f8f.60.1771421207816; 
 Wed, 18 Feb 2026 05:26:47 -0800 (PST)
X-Received: by 2002:a05:6000:2508:b0:435:8e14:9877 with SMTP id
 ffacd0b85a97d-4379dbae484mr23152382f8f.60.1771421207355; 
 Wed, 18 Feb 2026 05:26:47 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6c1bfsm43078466f8f.13.2026.02.18.05.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:45 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 02/24] fuse: Ensure init clean-up even with error_fatal
Date: Wed, 18 Feb 2026 14:26:11 +0100
Message-ID: <20260218132633.29748-3-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218132633.29748-1-hreitz@redhat.com>
References: <20260218132633.29748-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When exports are created on the command line (with the storage daemon),
errp is going to point to error_fatal.  Without ERRP_GUARD, we would
exit immediately when *errp is set, i.e. skip the clean-up code under
the `fail` label.  Use ERRP_GUARD so we always run that code.

As far as I know, this has no actual impact right now[1], but it is
still better to make this right.

[1] Not cleaning up the mount point is the only thing I can imagine
    would be problematic, but that is the last thing we attempt, so if
    it fails, it will clean itself up.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index cea9de61f1..2ed22c6b2f 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -119,6 +119,7 @@ static int fuse_export_create(BlockExport *blk_exp,
                               BlockExportOptions *blk_exp_args,
                               Error **errp)
 {
+    ERRP_GUARD(); /* ensure clean-up even with error_fatal */
     FuseExport *exp = container_of(blk_exp, FuseExport, common);
     BlockExportOptionsFuse *args = &blk_exp_args->u.fuse;
     int ret;
-- 
2.53.0


