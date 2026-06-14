Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7597CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDR-0000LA-NW; Sun, 14 Jun 2026 15:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDE-0007iO-Ov
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDD-0002ho-BT
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4BImduj3c60I0euzQ/n3wljbD+0Z+LObGuPv1tHebA=;
 b=GkfRba1d2yDbOyv6pxyoG83cM5hQW0hnw6huZTW7rwkjJ0IKsJiGm+VNxsl5oTM5l7xjlk
 RBDpt5dD8q7/D0cG9BfoSEicEFOU6IdgATTcFuJPGyKOHgtZosesgQ2BMImjW0o8Ll11tA
 D4Wt6ypM2smd8O7ZG7S1bEYADQYIg4s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-vsuLENsmPDKJyC4sud9qGA-1; Sun, 14 Jun 2026 15:09:37 -0400
X-MC-Unique: vsuLENsmPDKJyC4sud9qGA-1
X-Mimecast-MFC-AGG-ID: vsuLENsmPDKJyC4sud9qGA_1781464176
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45efa2f7009so1710484f8f.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464176; x=1782068976; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M4BImduj3c60I0euzQ/n3wljbD+0Z+LObGuPv1tHebA=;
 b=MclPO9k/AGKGzzAI/bIySfgtlLg6bPlGAVF9Ve2T5cSo7TUMsVfG1jXduyUOabv4eU
 3bMwBOEkKTDUtiFHSU5LuZcIdc6tI+Vdayedw551qergA0LDUZ4P1R1PUNxSwMpeVwDF
 ekyNn5qW9hlIi5w3ONqSTX08vEuCNchYl6PhgYT2gFkLVgsc5NeQB9e8xL/36W8Pwswd
 yKWuwTwC4cPBGnkj2Gi7yXsUkgHGF156G5owvNRNuTFQRIrI760n8lysCz/fAuXsIGk1
 bqi8zofbHFucX8u97eXEWPsxZR7Tk+gchbGjFdEq5r8M0jU2RWhzFOR8aok9/Oc4H3Vn
 BHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464176; x=1782068976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M4BImduj3c60I0euzQ/n3wljbD+0Z+LObGuPv1tHebA=;
 b=K/RIIROfDs9Qy+WQu0DgIDccqG8v3tvnoag731P5sx/0URvizOL1GMMk33I2lL08E0
 W5ov1MqWDRbAC7mYR+I+tDTQqylI2f+2KlrvBkyE1oYS3fu2j4HJezPmJGIKMbSyBM12
 zA5OuzWZ12o+ia4ffz3c4XlSgpPp2psvXwATewQnSG4W+y+RyjoQwCcxAr+C0+VXCU1X
 SWQtfHt9cmBPYNTwOwtrJRjhikbWmrgBo0bMvZBla4fjSAWj8mezlGn1wxtO1RVlLzVC
 aGoH622YP5x0NcwQ8oV9k02Y4KSeaT8GTPoAG3LxLK3ItIT4kksudJPng+nFFo7E4omr
 aDfA==
X-Gm-Message-State: AOJu0Yzr1kG96IsyOAFLcHeDkgoBCAER9mTSoF+y05zDk14MHPezzWDZ
 0QolYH8zSrDXvcRlZCXoVc8N8rW7pDQtVaeqLRwCHiM/xkNXWX04aCLqEsZ6Pak7r1oR18yOf2+
 r3Uq/lBQSRxaQ42J3wmK53kK2+Qyxa9D0WG+XX6rm+nthWsIzXsf/F9Dage/ZpqXhE0TY7e/8jt
 //zN5NgbDaDxkrnLx07cUpc1sqKTLOfUek6A==
X-Gm-Gg: Acq92OHb7tH3cfY1u6J9/ASBHMTxPPLClNput4AmwXmPyo6b6hTaNeTorPnDxoviHDl
 PcWDBZhRV995KTBxD87ELv8bXMGKrOpI9TCUwgEetSDxOG2vfgYWQsr/O35oGMFDBM7SQb0GrZa
 4egWnusWxehsOBCTQD1hiJ/7ovGCOTqICiLErI6uFO+tGICl8PrgrdCyqbSy11YZPuMlRYIlmWi
 06ARCpyDDT4BEbUcVPH7z5xYSbfEdSJDJqigBU87PUnUx66j1qLknzXJWcuCAV/1+5IZaW+Qn13
 6/5gPRO5WKkQqTCAuJJIcqnpvLUATIk7J7iVy7cgo4Bn0zKBTXbuPKXWgys8zk1UiVbwqmJwdMG
 QUIx90ITMA62uKQymhVzxAxHUdakEaFfWWw6BurUKa2c=
X-Received: by 2002:a05:6000:178e:b0:460:25f3:b25a with SMTP id
 ffacd0b85a97d-46077f2d2abmr9193453f8f.34.1781464176301; 
 Sun, 14 Jun 2026 12:09:36 -0700 (PDT)
X-Received: by 2002:a05:6000:178e:b0:460:25f3:b25a with SMTP id
 ffacd0b85a97d-46077f2d2abmr9193424f8f.34.1781464175814; 
 Sun, 14 Jun 2026 12:09:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cf5d9sm23858260f8f.32.2026.06.14.12.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:35 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 092/106] vhost_user.rst: Align VhostUserMsg excerpt members
Message-ID: <8d0e94927a80f02562e843cca61cf65cef32db5a.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Albert Esteve <aesteve@redhat.com>

Add missing members to the VhostUserMsg excerpt in
the vhost-user spec documentation.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260304165223.2166175-3-aesteve@redhat.com>
---
 docs/interop/vhost-user.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index e8554a3859..883b1e90a2 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -378,11 +378,15 @@ In QEMU the vhost-user message is implemented with the following struct:
           struct vhost_vring_state state;
           struct vhost_vring_addr addr;
           VhostUserMemory memory;
+          VhostUserMemRegMsg mem_reg;
           VhostUserLog log;
           struct vhost_iotlb_msg iotlb;
           VhostUserConfig config;
+          VhostUserCryptoSession session;
           VhostUserVringArea area;
           VhostUserInflight inflight;
+          VhostUserShared object;
+          VhostUserTransferDeviceState transfer_state;
       };
   } QEMU_PACKED VhostUserMsg;
 
-- 
MST


