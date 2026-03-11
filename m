Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716FB112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M5R-0004J9-Me; Wed, 11 Mar 2026 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5D-00041t-1V
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M57-0005kx-2Y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8nAERr/lqwzZ66zzq6bUdpBFGK1YHDQGeIptE1RzBE=;
 b=cvmhPcgXjA81T7OZeYc059R5pMal8vFx7XfAh6phb+x43wxGWtWltK/XiZTyPGQMYyaRTz
 M/4SullZfLdwChnLCMnRpmdAjk86OmpOwh50jbphtJOhTeCEQmAOUqonEGmqwVomZX6drF
 33931CbYraNiZFylMDAitQvsNFhu5rU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-vfMSZsPVMAa09EcI7irBAg-1; Wed, 11 Mar 2026 12:06:40 -0400
X-MC-Unique: vfMSZsPVMAa09EcI7irBAg-1
X-Mimecast-MFC-AGG-ID: vfMSZsPVMAa09EcI7irBAg_1773245198
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so117626895e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245198; x=1773849998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8nAERr/lqwzZ66zzq6bUdpBFGK1YHDQGeIptE1RzBE=;
 b=Qn8eZMReO9ypktkOeh/avqCzkZcE8V0vba6NHgTgWNNoRUsGyWopL5X1pGfWMQ+b4m
 NdEvWoB7/nDM+7ry47qtAyGdaEtcy2M/iho1KT+vXfhgJZ75wsGoIr4a0tzoe3RK5aH8
 RwdqgYczZqwstwhiujrsqueaSuKrcTjismYUUQyTV6y/aAmBK+kdBMWyKU7/nAKdS4+T
 TLyyF6AgQFLdsa6DS12zsy5ULbNGv/G9UPfj+Mh3oWBBinneweMoyDDFcz919hR5hg+f
 /G20GJiEQaIajWdPuwbrMKZyqr0Sefx/NVpgharNPHwFwp1jHxfeD69p+cblGS0uABSN
 5WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245198; x=1773849998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g8nAERr/lqwzZ66zzq6bUdpBFGK1YHDQGeIptE1RzBE=;
 b=cNOsdwxRgwZxytUhZTm35MDH+KrupoS2GZdde8ZuVyi268iCuYx0nvqgOyXahcwa82
 LYgqDVRoSO/GrGLpdHnoKcKsOa03XAMRrYURK3XWz2Cq8Lyca9NJGuuoneqB/awuooe1
 a4U3rUDNBZcXiVAeelEslXP6m3jEsstmAK+JKu8e+x/e0jeaa1pwsmOv0yEq3njdG6q8
 LyuPeC0ADeIf57oNZ3Prg9kh7glwtXwKrjxUl7CgOFWZ/HvbA1yAmmyYsHEBzWnA4fz/
 3a5PhqEOnp01on/uLdtpcweNL7TPRJAq4C/yrhrJviHvnJC6+mweG5ixGLQuehiAlaCG
 zaBA==
X-Gm-Message-State: AOJu0YxZcZvMzBj+FFs8I5WMsgX5CLuCCPw0p5XqWDsS0aVuZPO+R9VT
 42rzqqntjQjQvuaZO0q0RWABgiZ0PyUDG/Gs2tEpXy1wl3EHVwjz+z2kohgq31qojOZnGgrmvOF
 6zvnFQIrljGPCRfgJr9K4UZZhugdM+pTyyq4Agc735Wou0pm8LbMeFIrJ
X-Gm-Gg: ATEYQzyxCchEri3xqPMXWoeAQHNLuGluTrqb11ACTvSHU1PbDRDBpkYG477mY1CSjEj
 YkxZCEz/I3rCD/XDxZImtvNhUZaP69BPsTcR8pS3BF74XpZVwArWfGVw3PEvsZphzJgPfB0C7lE
 brTqv5TzJPBSjIRzo4u/jSoOFjH8Zp5xbo1k+32QbDcW8LnujIQSOFfOEeeERYrcfMcjjcIsNTp
 1p8M5RC+194/T0v0aKSLGLoatGGwE7v1sJWROuUiLUshh0rBqI1qTXOMCkPsULwQkcuW1YtdnQX
 RAjWgXpBERv4AZzAAC4kxoesvDpTgEwfCKmK42wkxM7wNH9PIkPLLGKKcvuvQLCM0PhgGJ7sUEe
 8VzLCKocLh7BbRn2Zuu9jlvNa6CU8XgksCDwT6ALfTxjr3AUNcM104MMEGBNT+o1aMGlskD2dzu
 BLy7IN
X-Received: by 2002:a05:600c:4fd6:b0:485:3b34:2f51 with SMTP id
 5b1f17b1804b1-4854b0a6a96mr57409545e9.4.1773245198147; 
 Wed, 11 Mar 2026 09:06:38 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd6:b0:485:3b34:2f51 with SMTP id
 5b1f17b1804b1-4854b0a6a96mr57409015e9.4.1773245197678; 
 Wed, 11 Mar 2026 09:06:37 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541ab9f9esm168369045e9.4.2026.03.11.09.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:37 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 1/6] qcow2: Skip data-file resize if possible
Date: Wed, 11 Mar 2026 17:06:23 +0100
Message-ID: <20260311160628.344838-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311160628.344838-1-hreitz@redhat.com>
References: <20260311160628.344838-1-hreitz@redhat.com>
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

With PREALLOC_MODE_OFF, we currently always resize the data file to the
right length.  This is definitely not necessary if it already has the
correct length, and if @exact is false, we also don't need to shrink it.

This is what other preallocation modes already do: preallocate_co() only
increases the data file size if it is too small, but never shrinks it.
(And note that for raw data files, PREALLOC_MODE_OFF is silently turned
into PREALLOC_MODE_METADATA, so this commit only changes behavior for
non-raw external data files.)

For the next commits, having all preallocation modes behave the same
will make it easier to decide when we can skip taking the RESIZE
permission on the data-file child.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 81fd299b4c..cf9189b829 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4572,15 +4572,22 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
     switch (prealloc) {
     case PREALLOC_MODE_OFF:
         if (has_data_file(bs)) {
+            int64_t data_file_length = bdrv_co_getlength(s->data_file->bs);
+
             /*
              * If the caller wants an exact resize, the external data
              * file should be resized to the exact target size, too,
              * so we pass @exact here.
+             * Without @exact, we leave it as-is if it is already big enough.
+             * Implicitly handle bdrv_co_getlength() errors by resizing.
              */
-            ret = bdrv_co_truncate(s->data_file, offset, exact, prealloc, 0,
-                                   errp);
-            if (ret < 0) {
-                goto fail;
+            if (data_file_length < offset ||
+                (exact && data_file_length != offset)) {
+                ret = bdrv_co_truncate(s->data_file, offset, exact, prealloc, 0,
+                                       errp);
+                if (ret < 0) {
+                    goto fail;
+                }
             }
         }
         break;
-- 
2.53.0


