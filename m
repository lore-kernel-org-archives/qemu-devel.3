Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B756CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyKN-0001ch-AR; Mon, 01 Sep 2025 02:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJs-00012O-9j
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1usyJn-00031I-Qh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756709226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVfe18M4q0EFJ8/F8tYRbmjQ+B3FZ3XR4msuAFUfPrg=;
 b=VUC6GO5v7X+FIr0FcPoA3PyE6Pp4DdyiXel9n9aQElkQgQUN2HWLY432LmHjCMmwvyMg+c
 jYx+yNkTELA8HsrREl03u0kD9dMvZ8S4fBRm5oDKVCko0ONHqBiJSHI/0Ae9ZlfO6VyRsK
 L7uG9i+HWjQAeOeJtbt3K4VStkkPhR0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-I3SHNyN8Owaf-aIELG_Z3g-1; Mon,
 01 Sep 2025 02:47:04 -0400
X-MC-Unique: I3SHNyN8Owaf-aIELG_Z3g-1
X-Mimecast-MFC-AGG-ID: I3SHNyN8Owaf-aIELG_Z3g_1756709223
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77A76180048E; Mon,  1 Sep 2025 06:47:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A81DF19560B4; Mon,  1 Sep 2025 06:47:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 8/8] vfio: Move vfio-region.h under hw/vfio/
Date: Mon,  1 Sep 2025 08:46:31 +0200
Message-ID: <20250901064631.530723-9-clg@redhat.com>
In-Reply-To: <20250901064631.530723-1-clg@redhat.com>
References: <20250901064631.530723-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since the removal of vfio-platform, header file vfio-region.h no
longer needs to be a public VFIO interface. Move it under hw/vfio.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250731121947.1346927-5-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 {include/hw => hw}/vfio/vfio-region.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {include/hw => hw}/vfio/vfio-region.h (100%)

diff --git a/include/hw/vfio/vfio-region.h b/hw/vfio/vfio-region.h
similarity index 100%
rename from include/hw/vfio/vfio-region.h
rename to hw/vfio/vfio-region.h
-- 
2.51.0


