Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526C8F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEU-0000hD-8O; Mon, 09 Mar 2026 11:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcES-0000fA-Qf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcER-0008Jv-ES
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSXZAuWYpAshM63pW80TanRP4MfbiawAfcaxsHKGA1o=;
 b=QUU/21ZPUsexLWxlViJfjPnlrFpp8vKh+qd0gsKEf/c1Na1j7RqJl7ofUDeIExrsv411wQ
 03hf6+TZtQcC4ohJpK4bvwsgxc+oHD1CdWQiLh1oHT5aCjh3FGjQYnYFhx6bna1s3+sOBx
 u/ooYLAf59g9UexIo0lAuRdYgtEKTIY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-bJ_ivm-zOX---Gz9079qsQ-1; Mon, 09 Mar 2026 11:09:17 -0400
X-MC-Unique: bJ_ivm-zOX---Gz9079qsQ-1
X-Mimecast-MFC-AGG-ID: bJ_ivm-zOX---Gz9079qsQ_1773068956
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439cbc5fd75so4083655f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068956; x=1773673756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSXZAuWYpAshM63pW80TanRP4MfbiawAfcaxsHKGA1o=;
 b=myLdHjcUSxsZQ119K7UyROtREAdgOnP5Ymuvm2mislD0Vn5TXtuJhpDPHhNGIj7/lb
 oGh7i7Zbf/cntirHAtStwF9r7kwkBlWvYWOMPt6QuBmGQSzcKuBpJolWO+Zq6+L5w78t
 ciBIZQlteQqlhW4Hokn1eTioyo0xtX8ovOmUEhGPRJyidigsGV5oI1m9jfZTbEsAaLGB
 WiON21tVh0qYSTLoJLIdT/9454qw1z8i6H7MrW+a73gOV9YbEpy4A6lDXyuCNPvFRjYB
 O5eiEr7ZllAiu7+wUGGbPeKoVESgZgd8GhGGOCt94hVW7PlCW2G84fo1qTLpxBIHhj5O
 UmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068956; x=1773673756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OSXZAuWYpAshM63pW80TanRP4MfbiawAfcaxsHKGA1o=;
 b=b2Xy6JEgEal90aFmFyfHwerne9b/s1pQ9t5QV7omdnosFUd1Npn744On1fDR2TP5+g
 dENEX3Hrfl7Mou+PqNDdfOLSZVfe/6bKdAb5DH0mdO90bh4Synzy381R1Wg5U1hKNwjx
 Wef6hhMIMvviuA5tszFba3hf3WcF5UCg6HpDLgFe87GHewetlyee4WH/ixc8s+dd8t5i
 xW8nsCCBHLDKx70TNjnXu7zCLSoqAXYEO2wzG7tNCRq3n8AZHX7xHbQPsE132D+Sl3Zb
 kWeRPfXrT2GisMF0tHPAtFCjMV4jyiELOeBxDMLkcRR+QQ7iViJcVYRQxb6E4nglBrz9
 f1UA==
X-Gm-Message-State: AOJu0Yyu+lzadYeuzs3l2G/ZbzrSVMIGe9BVYG/ewQ998c5fYk9u0wbA
 nd2MTKaDG4iD3/JeR8xBXgdYlBnXUdzkrNMg+31zM8iERCUML1hK9I1XHK7KH0TZUTS8wZ5eddq
 B28OGlQD7om4kORcW5DsrH6BcSDngCrRIgZI/xWrCniqyiHOxc9l038Wk
X-Gm-Gg: ATEYQzwqGbJDa4t97wsEIDOJKrjkfGEONhqP61rpEjIH+5FEwtGqBzobQzTyOasDD9w
 HC3L63Mey8wk2I8uMcPjJ/rtDobHdlALyxLcRFCqsLNkwre2lavvtcqmGAyj1PbIxoSM5BBPIea
 TBD5FnlAc3N+G/Al2l9TTSXA3YlWnx1A8eXIM+LgOCcD+RC7GvMYrPcrep++M5m/DG4DyNAIJkk
 8y19s2f+vL3odCE0NaXYgSVA09J4B0R4ACUvvxDJVm65FqN0Mp9Qdn/Jq0IIp8gIFiezc4Ylw2D
 cs5a4joTdha7SZMh8CyiDQhe74IJ2lORM4nFwnzlxa2dnSyFM2hWP2YluUEUTbusjf7fDjfSS/M
 NC1dWgL1rkPbvxF4GxDQD8dQRkeZPPnbTBD7Ba1uSRSdSpXaPgPYO8LWFrtaZTg2oWPBSJ9IV2Q
 Mi4+YR
X-Received: by 2002:a05:600c:450b:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-48531936f91mr112981985e9.3.1773068956124; 
 Mon, 09 Mar 2026 08:09:16 -0700 (PDT)
X-Received: by 2002:a05:600c:450b:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-48531936f91mr112981355e9.3.1773068955627; 
 Mon, 09 Mar 2026 08:09:15 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853c784813sm63842925e9.5.2026.03.09.08.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:14 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 04/25] fuse: Explicitly set inode ID to 1
Date: Mon,  9 Mar 2026 16:08:35 +0100
Message-ID: <20260309150856.26800-5-hreitz@redhat.com>
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

Setting .st_ino to the FUSE inode ID is kind of arbitrary.  While in
practice it is going to be fixed (to FUSE_ROOT_ID, which is 1) because
we only have the root inode, that is not obvious in fuse_getattr().

Just explicitly set it to 1 (i.e. no functional change).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 4cdf527d69..a56f645c05 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -432,7 +432,7 @@ static void fuse_getattr(fuse_req_t req, fuse_ino_t inode,
     }
 
     statbuf = (struct stat) {
-        .st_ino     = inode,
+        .st_ino     = 1,
         .st_mode    = exp->st_mode,
         .st_nlink   = 1,
         .st_uid     = exp->st_uid,
-- 
2.53.0


