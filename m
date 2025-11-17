Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D6CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxqG-0000qh-RO; Mon, 17 Nov 2025 06:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKxpm-00005K-72
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vKxpk-0005qw-0L
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763380547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=BUa6Sl+Dg5WhzI/v7q3HZK8l6tcgozuKXb/i0bCpSk4=;
 b=ML+ySiTwgDdmmWFoHPKJVM+dsfh//COXmaICmxNezlfeTShtSvG6DRKzmPQ49bRn7B+0kM
 nOtHC1micxYOWMRNH3Tk1weihf3yesF6zO+irsVtbNuc/XXuBOEt0OiOyHzaLq+SQ3vyB7
 ZfX9+tKzOiK9QgFynq/QQlxMPLHqZ3U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-ipb4xmixNXuG_GK0P5_oDw-1; Mon, 17 Nov 2025 06:55:45 -0500
X-MC-Unique: ipb4xmixNXuG_GK0P5_oDw-1
X-Mimecast-MFC-AGG-ID: ipb4xmixNXuG_GK0P5_oDw_1763380544
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b30184be7so11635f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763380544; x=1763985344; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUa6Sl+Dg5WhzI/v7q3HZK8l6tcgozuKXb/i0bCpSk4=;
 b=mbq3JwZKHKRsuAe+FqaeeAzt/ec/ZRnl1B6XmYQk3MKRUdnAl+eHxpC5g4S27yPYa0
 JOYiAurCl5Suq3cIyKYUabIPJNmhdnrup3UxrZoF02OKpSPRF1PMCVwcg3LUsCaSfKxA
 ELzBBGaG7L8Z0FIg8ju0ufsEKb7Jwf4bxTvtX8wbJbp/1ThMCazuV27trvMLLIJwlOvO
 e0O2gBG1LeZZqslvXBrTDkWeeSrgW3OXnLQChH2EBc6nhEmO1tAJWPdOo+fYVwtqlFmu
 mlnPVUuFwhJlkVdcrflqasV9JSNkAJS8syIdIEBSdIFWlk7KeUQZc+aRc3X10YmeSc/A
 ZR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380544; x=1763985344;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BUa6Sl+Dg5WhzI/v7q3HZK8l6tcgozuKXb/i0bCpSk4=;
 b=cb3ubyhKtuHxKFyCjEFi+A4GBvq1P5UVeH1kWloVYWV9FxdHpPunOumYmX6d7jcj73
 DZXkvCNotf98H6jna592nbnywVrXCOc2AVgIh06o/G33T2+6wLfGlXWiyq5jQ/Xa5ZSu
 nKbZ4WoYBnYmavSwU7o1VIrTNScxdo4uzTrBcuL8tdVUMNje7u7AqAJugQGGdgbO0jHn
 IdJZPv2npIqK5xDIwLhzcn/dRBrXFR0JQarI/jClcQBeA8iAoeMKkO2h/tRjRs4WK+2u
 1Q2Jw+uBf4N3V+s3W1RPMfFvxWMHrJDsK8leFl/pBDar44c6Ft6899gSPJMbEt93VUe3
 22GA==
X-Gm-Message-State: AOJu0YzwDSVkASfuxgZnY6Yl6msV//GfgQtyfdXUUjezbKBqIigIiaRP
 W7Sbdn8JSVjfHna0SmJYFjWrfqg22LuK4TY5GvisJDMr27B+qdI/MjhdyjxkybzcDy/KnrCzmhT
 TLTcXeHGMK/SIN/kpgAcNooxg/SxBNEWWxN36hwaE6ppYQMC/8n3aXqBCIJOvsov9/NBZDb9e/H
 602iALsTaKqlZY5BMcKLbDDG/Hj/5Xp/DAag==
X-Gm-Gg: ASbGncva+vzNCuR27HBvxLnWrCHeuAzt1DcCGazKXFtbjCtpUgHqdMvL8VfLx7Gu0v8
 792QQa+YP9RR74NmY7TD1PFkO7ZmDHPjv9KEfVTVdbIm7VtKkIJlqdEVqVcfCDCqd8U+O2By73q
 wjG+YfKP4ba4UdXAylZh7U5nnYv2Zb+aKusyV6KQT6cw6ejZemZQEgvWkj4BOBtgG0HNBme2v92
 dc4+LutczBAsrUYFAfcAput7biFBaHp8BcBjDaG6MNJZE2W/LgVLXBG4x0Fmj90cuKrpWB/S9wW
 UEK6uxowM5epv1iHRvI/DiM12Sq8WcugXsX/W0wSH7N9t5WK6zlx6L7gkr5oKS5ojH+/ZJTVaG5
 UnEZnEf4eIlaKxL0TDJw=
X-Received: by 2002:a05:6000:2210:b0:42b:36f4:cd20 with SMTP id
 ffacd0b85a97d-42b59345109mr11234595f8f.27.1763380544014; 
 Mon, 17 Nov 2025 03:55:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEltX2ngdk0EGRJwMze2bJ+7hVCTTnjxoDfHePl3avJXgfZ0axMLAPENve6iTMwDtdKGUWiw==
X-Received: by 2002:a05:6000:2210:b0:42b:36f4:cd20 with SMTP id
 ffacd0b85a97d-42b59345109mr11234570f8f.27.1763380543507; 
 Mon, 17 Nov 2025 03:55:43 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42c97745f79sm11691382f8f.23.2025.11.17.03.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:43 -0800 (PST)
Date: Mon, 17 Nov 2025 06:55:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user: ancilliary -> ancillary
Message-ID: <44f5010964049b9988923ce1429652e0a9e8ebaf.1763380540.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

My dictionary says the former spelling is incorrect.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 93a9c8df2b..93f756d3f4 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -411,8 +411,8 @@ in the ancillary data:
 * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
 * ``VHOST_USER_SET_DEVICE_STATE_FD``
 
-When sending file descriptors in ancilliary data, *front-end* should
-associate the ancilliary data with a ``sendmsg`` operation (or
+When sending file descriptors in ancillary data, *front-end* should
+associate the ancillary data with a ``sendmsg`` operation (or
 equivalent) that sends bytes starting with the first byte of the
 message header.  *back-end* can therefore expect that file descriptors
 will only be received in the first ``recvmsg`` operation for a message
-- 
MST


