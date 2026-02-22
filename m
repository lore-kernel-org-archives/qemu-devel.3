Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E33C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASK-00089l-UV; Sun, 22 Feb 2026 09:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASH-00086e-Sx
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASG-0006oa-GD
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ip7Nftynx750AYFZGC7Njs3lqOYCdZvd4rGc6p0ItTQ=;
 b=SZSvwQm/APvWKToIvAsMsAxlO78SRcfdVXl8927DbmrKx3iu2NihhZczQXmQVkElAjsxk1
 yGb1BaUrXSWy0SpC8b96pc5JdzI1Krb/PZ5kKpc9TSLGWn9Cnyk6D+McvZrp+YED2VHLNX
 2zPLADbY2ZKonL0Xc9Wj+I9dYIEa4Fw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-u7fYPHlnOLyTlA_KoCDpdA-1; Sun, 22 Feb 2026 09:29:02 -0500
X-MC-Unique: u7fYPHlnOLyTlA_KoCDpdA-1
X-Mimecast-MFC-AGG-ID: u7fYPHlnOLyTlA_KoCDpdA_1771770541
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so26138465e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770541; x=1772375341; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ip7Nftynx750AYFZGC7Njs3lqOYCdZvd4rGc6p0ItTQ=;
 b=heB+nrecBcfA3nuWALQPnMbDLmYcrffcoMEW9MONsWykNvq8neq88dKYROkPT2+lAk
 ohM9s9Yst25oU0bF/MIpvoHMx7+3BskHa58ZY93zeZnsts/tjBSqtMamgZ0C0H8+MCI9
 IFPv298VpyVg9BH18VbPU84hFDq18gKPVF+HWDrnRzV5qg9zdiIay2O6o4ck9BjePM6w
 Mz5C1lpFmP/qi9u524gcUWfbKCDszF2Z7biN4Uzaf6qFJzpd6+VcNv36q5DSMrsehknm
 l1j8wdMpJVmRvDiwoU8RJMVbdrv2EDyuQ0Q4aCGlKe15BAA2xyBbgPKAWhup3sletYXU
 InLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770541; x=1772375341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ip7Nftynx750AYFZGC7Njs3lqOYCdZvd4rGc6p0ItTQ=;
 b=rJWCZKNmzc3H02P8AclXe8vKk3oCyvcDBfaD2dBVV1Ie7fRW9iHJr6oTJOukBLlRlA
 Q3b6t8bscMHaichf0iC9asTG8CstlYLN17EavBww1Soh/3zheBKyeXdAKTQRt/3ZODPs
 8OmwPBB9xJ8cRcrGR50fOt7896h5qDRxeHMpgldqoiJnODgso2UKzLHTd8wiZXhVTlxi
 OM9Py7ibQhQRVV//etDZf5sBaM5aT1g2M2N6/UHXWndZRgzQ/ydcavQg/F5MU00IXJos
 aoo/FufY34tDDXGXsh1yldxHz6cpxZ724nDlOSyLzsA/rj4ZzGYlXY7nd7zNV0MXenu0
 ejWg==
X-Gm-Message-State: AOJu0Yy3ZgW+4Iu7m8q9WlYSkykFNSqaGn3CLQtBvSmXr7+I531Xc9qy
 kn9vtSOUSmW5T5F/RwZ2e3z6OI+ntBIPILkGZxlhee/+DBs54N4e3BUt61KTDfqkzL3Ndc04GHH
 pRiPX1opOgTQXnShQR+bIkqj6CPqyqLSgo1uriCH6fEQsKw3oTXq+wZF0K5efS0b7orzVsPp5hm
 LPqidS2As3FsccGxush8T6tJEtJNXinmAqkA==
X-Gm-Gg: AZuq6aKf3Q17VnWCFhHSdmSOl7X9vE+iq7Mw2HqkKkMZHhY+GJVVO86g7Dx9dblWJCK
 JQmuYVS/HdeAjAAANroPnO23nKRQ0D3GIeP83CLo7rYdNyF6Ebns9pcSsHmTSXe5fo5aZNQ0oDb
 RPFswVVNDRiAiPr81AoWtYdyHABFsxY11aExeArajhLa1LcktltwZb250TqNeryKaR6X81x4tIL
 wD0IH1xW/vPBbPIJ+NMOlrJoOcxu0G9Gfj7JrKUdpi08OMJN+8JyvJK8mv03OEe2TDZQ8MmYgYM
 Q6OMMYJbRmiDyIZmAPeDnnLlFzMBTPM6dtUBtIHkMVZLpi52OTt9W/hQiF4CQsPopwE25DGBm7t
 8nHncT/i8XUzEIJhUPbcqA9Hk59mafkWeDayMgrY8gWBzUw==
X-Received: by 2002:a05:600c:3b08:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-483a95eacf7mr83579905e9.17.1771770541025; 
 Sun, 22 Feb 2026 06:29:01 -0800 (PST)
X-Received: by 2002:a05:600c:3b08:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-483a95eacf7mr83579475e9.17.1771770540516; 
 Sun, 22 Feb 2026 06:29:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3e01c27sm75074855e9.9.2026.02.22.06.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:00 -0800 (PST)
Date: Sun, 22 Feb 2026 09:28:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 18/33] hw/cxl: Update CXL Fixed Memory Window ACPI description
 to include Back Invalidate support.
Message-ID: <e6742e71c24cf577a4677e9449269007c24ae4ab.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Defaults for these windows has always been to enable anything QEMU supports.
With the addition of back invalidate support it is necessary to specify that
host windows support this.

CXL emulation is currently only suitable for software stack verification.
The relaxation of the restrictions on this window to include BI have no
affect on the OS until BI capable devices are added and until now these
have not existed. As such no backwards compatibility impacts are expected
from this change.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204170936.43959-5-Jonathan.Cameron@huawei.com>
---
 hw/acpi/cxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 75edb2c0a6..f92f7fa3d5 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -172,7 +172,7 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
 
     /* Window Restrictions */
-    build_append_int_noprefix(table_data, 0x0f, 2);
+    build_append_int_noprefix(table_data, 0x2f, 2);
 
     /* QTG ID */
     build_append_int_noprefix(table_data, 0, 2);
-- 
MST


