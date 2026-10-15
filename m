Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59A7CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ7v-0001If-VC; Thu, 15 Oct 2026 06:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7e-0000fQ-JM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7d-0008Is-2P
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3L+mwE5QbfD5712hDCU7HpEGNBD5LLbZ2ajF6yWOII=;
 b=a9ZhAeUQb++P5iJaMwIkxpqyur1ZF+hG91jRlbX2vZoIuPM5jaMZZFDxg4i0h2XPYtLh6T
 3MEUzD1dKyD74LlFLsD9hbCSzdQCFtmgXeYNWFbmhHnk/s/GJfqRal3lPasUXtZbJ4qoyz
 sY+22LPbHPMAN0iAJxXe3GbtX4Xknu8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-v1fbyV12PN6i-qTHYXjXRg-1; Thu, 15 Oct 2026 10:55:39 +0000
X-MC-Unique: v1fbyV12PN6i-qTHYXjXRg-1
X-Mimecast-MFC-AGG-ID: v1fbyV12PN6i-qTHYXjXRg_1792061738
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1b11e7837so21488535e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061738; x=1792666538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O3L+mwE5QbfD5712hDCU7HpEGNBD5LLbZ2ajF6yWOII=;
 b=S5Zf2Xr7Tllfl8KUfw8UvavZLHLFV+M+IXySl8iE+n9Kx9r3szWENAKaB0Qt2+9K77
 xuIC8vNGhmFxHT5NRnMgi4/K8FdbOg4m1xq1FlUJTz/1cp0NuTu3TkIpecZJnT9e1PFV
 Zt4AgLLeiSpzCXl4Mw0VGX0kvunoiXo3395V1mfQBGMDRN4tzaPkPD0oZuJzYhBIeZAb
 9tL2PfgOOnWOHErMM+pUYEtTqR7eWVUCvtsQy53by1xOmcSQ2n6LvAgMDgd0NsM6pnxQ
 lCW2C4Futt8+MDYZEh3Fck4/TQdK5+ncrJWPsFHuv9rh3MOvFwwb8CPsx05aLe62SiCp
 ODmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061738; x=1792666538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O3L+mwE5QbfD5712hDCU7HpEGNBD5LLbZ2ajF6yWOII=;
 b=vR3b612xuLbqLaTHw9UnjzfJk+1T9Nmz/watryzBuAxOvycD6GEdzubgYHX6aeCLt4
 9Q0z24e9s2mvOBKFfRUq2VyQLRrXkBBW270Kt4JYpi4RtlkomnBWuwvpaE049q4/55sw
 dsZzUzBUOqHzByTbgqy2JREebymIn4Xv2mV9Mwvjw4iVgxsBHqYEunIkRezNgjYKe0gt
 ORaG8U63JSQ63psDSSIRKlB/NkkOzhyXJH4sFizPeVi2UMobBsRluuBuV6rI39ElaUB+
 mESIPG51euoxpQlp1Vi0M+b8+6ZrtMtDmk1dT3iixmaFV12SPqs5Avhwke07dwTM016F
 jgdg==
X-Gm-Message-State: AFq9FYIqrDq8VM2hVbQSXWJFjU5tl+Ruzo1UofuVwsYsCNSC0eexuX43
 dF2yRRLxmDLLcCS56R0wBKtIjby99uxrjKE4EvhyzrGw+tBxRXDXwHz+5ltmTu6z5laXoAnmd4n
 WnUPUg3SuoJ9KNojykA8qRUCD5ceQZk8I/C6T/eUqyOiqqxtUK2S0TPOpZbUZrPS8LGvkORaeLN
 /welj2dUFC4S1xyElYwHOdfT+5i7AP5AlusDz5mJTu
X-Gm-Gg: AYBFou3bb+jVfRdqNJn6BnPnjB66yVfnV8m2mHXmM5Tp6PPnuefzdBxtoUo4yd0gPVJ
 vi9lPTMM5IHnKKynGQtI0g0FYD3DHp6GLXq7W648H9kZzL4Ius/IuNin5yFcKwlXbuUku8T9/ZS
 ngP1rt/nrLkdK/6Zxbuz6GVW8vtNn1Q213WOOsCOIEMaQ/Qc98V8ajEzLvb3OpxL0EF/FdABeqe
 Iup2TWV7tXFCqmXIQK5/tvRIr0LrRyuNqmB3RBAB3g1ux79vqZUV/DU5VhRhLcLjee5YC4eAwtr
 Fwz/v8E9lvMkHi9t69Mc9php9Axz6wphuRlhPEpNAJlETwmRLF2J6VmomeJlxi3UHDVFj0il0p6
 XCKySJvCsaOUwORERacp12N4uv90Od3pdXEs5MpHsdpkYsg/3FHdZLAvDtLDCgqc/fZFBx4OEtp
 /LYFH5
X-Received: by 2002:a05:600c:6099:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a18e4e7a85mr355736495e9.30.1792061737903; 
 Thu, 15 Oct 2026 03:55:37 -0700 (PDT)
X-Received: by 2002:a05:600c:6099:b0:4a0:1feb:de6a with SMTP id
 5b1f17b1804b1-4a18e4e7a85mr355736105e9.30.1792061737400; 
 Thu, 15 Oct 2026 03:55:37 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc506asm18563085f8f.47.2026.10.15.03.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:55:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 13/13] scsi: document PR_HELPER_CLEANUP command
Date: Thu, 15 Oct 2026 12:53:47 +0200
Message-ID: <20261015105347.827029-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261014142847.1354701-1-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/interop/pr-helper.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
index e926f0a6c9c..8ea83dd3d78 100644
--- a/docs/interop/pr-helper.rst
+++ b/docs/interop/pr-helper.rst
@@ -54,7 +54,8 @@ together with the SCSI CDB using ancillary data.
 The CDB has the following limitations:
 
 - the command (stored in the first byte) must be one of 0x5E
-  (PERSISTENT RESERVE IN) or 0x5F (PERSISTENT RESERVE OUT).
+  (PERSISTENT RESERVE IN), 0x5F (PERSISTENT RESERVE OUT), or 0xFF (PR HELPER
+  CLEANUP, see below).
 
 - the allocation length (stored in bytes 7-8 of the CDB for PERSISTENT
   RESERVE IN) or parameter list length (stored in bytes 5-8 of the CDB
@@ -63,6 +64,19 @@ The CDB has the following limitations:
 For PERSISTENT RESERVE OUT, the parameter list is sent right after the
 CDB.  The length of the parameter list is taken from the CDB itself.
 
+The PR HELPER CLEANUP command is a vendor-specific command without a parameter
+list that has the following effect on Linux device-mapper multipath devices and
+otherwise has no effect. This command is intended for cleaning up the multipath
+device on the source host after live migration has completed successfully:
+
+1. Sends "unsetprkey map <dm-target>" to multipathd.
+
+2. Sends "unsetprstatus map <dm-target>" to multipathd.
+
+3. Performs PERSISTENT RESERVE OUT with the REGISTER AND IGNORE EXISTING KEY
+   service action containing zero values for the RESERVATION KEY and SERVICE
+   ACTION RESERVATION KEY.
+
 The helper's reply has the following structure:
 
 - 4 bytes for the SCSI status
-- 
2.56.0


