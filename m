Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8FDF4180B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcGP-0003Ue-H2; Mon, 09 Mar 2026 11:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFP-0001gw-9l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcFG-0000Hz-SR
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773069007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/nvY+FQXOEd7mADtviTKG5X4XDtAjCV+MockVMSjqaI=;
 b=D8YG34+jjwta7P4Ndo8Z3aO2mD3LzqxWnRJNqiUrt5/D0jYOLKGSX+oIk1x0m92qIG3ncN
 b65xWF8V/S1QurYRRn4JspaTnAppxw0rBl5KBPJPKH5p9GW3TXP64dV/zYfbw9GaAfLnx9
 hc3gdiAIpP3iC9VTGM++n5nFsy1DwCQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-fnYNy0oAPU66XbE3NDkCKA-1; Mon, 09 Mar 2026 11:10:06 -0400
X-MC-Unique: fnYNy0oAPU66XbE3NDkCKA-1
X-Mimecast-MFC-AGG-ID: fnYNy0oAPU66XbE3NDkCKA_1773069005
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4853ac455b2so12474815e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773069005; x=1773673805; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nvY+FQXOEd7mADtviTKG5X4XDtAjCV+MockVMSjqaI=;
 b=dXRWrzARBBNyg/qVYYducm74ox3QsCIempB3Hr18Hgl5UjE/KMOFCcLa43tPm/FPFx
 sSA65VHOfGi/fhn7OEaurERLNoHQ765CayNqeKLNAPNLGkJMDBLgjh2sUYXhrqj1Dqov
 nTsLDG3a38bcGnC0jOmBx2EegL5B56lw+KAaRx2/kNaq0OpjgD+WXmITYTyq+FUNuAYx
 c0dOu8/fFI2m8fclA1Cn5Cm2RlPU1utivYfs/JFsNLAVqIAJ8et2CVl84nGZdzZSNKGL
 h8B0vP9ohz+uoZdCvg494A/DH3StsDs5V7CPXmp8isUB/A6ZL6mm4kBZFAP6UMKHCwbB
 rvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773069005; x=1773673805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/nvY+FQXOEd7mADtviTKG5X4XDtAjCV+MockVMSjqaI=;
 b=VDGWkXceKnYrYyxemzPjefvNkYX0Z3dcdvlPr/yqrdU9lO/7/yUTxClkZ1PbaSQsQs
 sGYeAKmh5AeMmlOxEIhEvR+WwoXIY8roIqk0kBC6D9B3ZHXAO0H+Jjy1IKvwbC+TOLC4
 UJH4GTTsATBcWZw+ZBDYfob9rr/cX56ES3ufDcEgWBtD3PPJnwpaZ9Y5innHkNpLOoRw
 /F76EE+Hg3KP3hMBWxYhl6wPZw+JVJcP8ZwC5MrLhhf+niiTgEKhZx4Hj9XL7A7fmNPY
 rcd4p/VQ9xs93PLXzg3532vF5a07/wBe1CEAt1ScezioDb5RxYHUYKP3Z1qmZUFaPpi9
 JfSg==
X-Gm-Message-State: AOJu0Yya59Bxbd5DInKi7hEsV7zAwKPJXmgs7HqilcaaGH9diBGFL6kK
 mEPjbPuvBPB0snbbJsSU/25jNVLLjME6zYWOlGFJWGStbBM1+eEFlG/vCQzZU1xK8gZTeFaGi00
 w+s1fFO3Ey+RGg11EzZMBSENd43drTBYOUFq75nGfgEfanabHtkT2yWjC
X-Gm-Gg: ATEYQzyEP07ZTZ6Jld3ARQHQeXJzkXFDdsAsGGrQINoTJ6hXT8xtBQG+3MRtfzNLcOO
 TONPO3irBOQZWBZIzftf4Y5/av3Xcac6hEQ7XyT0odiY8vKZD8xXLl3DtcHYdX1OpguM21WrxAP
 MvUYg9SM2z8w1QZqt6Q5mQRiuFyS9pdvM7bN0vODgsTrUG+MdkU8UHMilIcV98kxePT2VCP+4ef
 bEV/Wh5dNdMSGtCDP0YOUwrXIDl8c2jmLCkIfrfK+E3e8RUMq3j1PmRH6CDXAtxgr9CvVI/2EjA
 +I4/DV+sZra9S5JuYLFjm9C/AClbqPk9qowgZa5qKZlZh58iieIThlk94lrvdu8eB2QdaUsShSw
 z1fhMmqucVjqOkFGFIvzGshJAEYq1Rex5buY7WbFU0oIzSjRBBKt6eW/orka2ZjMOxFEiPOs2O3
 BvJu/3
X-Received: by 2002:a05:600c:4445:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4852690febamr208987695e9.5.1773069004998; 
 Mon, 09 Mar 2026 08:10:04 -0700 (PDT)
X-Received: by 2002:a05:600c:4445:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4852690febamr208986955e9.5.1773069004559; 
 Mon, 09 Mar 2026 08:10:04 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485245dbe50sm91408945e9.17.2026.03.09.08.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:10:03 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 24/25] qapi/block-export: Document FUSE's multi-threading
Date: Mon,  9 Mar 2026 16:08:55 +0100
Message-ID: <20260309150856.26800-25-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

Document for users that FUSE's multi-threading implementation
distributes requests in a round-robin manner, regardless of where they
originate from.

As noted by Stefan, this will probably change with a FUSE-over-io_uring
implementation (which is supposed to have CPU affinity), but documenting
that is left for once that is done.

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/block-export.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index 160cd2e3ca..dd724acf1c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -164,6 +164,11 @@
 # Options for exporting a block graph node on some (file) mountpoint
 # as a raw image.
 #
+# Multi-threading note: The FUSE export supports multi-threading.
+# Currently, requests are distributed across these threads in a
+# round-robin fashion, i.e. independently of the CPU core from which a
+# request originates.
+#
 # @mountpoint: Path on which to export the block device via FUSE.
 #     This must point to an existing regular file.
 #
-- 
2.53.0


