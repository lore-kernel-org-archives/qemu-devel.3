Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CCDC369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4JsP-0008An-VB; Mon, 14 Apr 2025 09:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4JsM-0008A3-VV
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 09:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4JsL-0005GU-Hy
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 09:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744637364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bi0MnrBJUQLkSnnCS67WM7FeZzZK79tN9Cj3N9vJQ7I=;
 b=WhLeZZI4c+z5pEg5rllW28UuvEPBSwX5TfF2l31oSpj5WZW3/mPeOzvN63xxZPaqxX+e3N
 S3fAmuOP9Duu3ml5HvuuGG4j7/srVpATOfhe7LZd5I661hskZDYv5KWSPBqXKevbLg+K2b
 1LaCp+BeqralCRVa+eZx6ED0yJ4sQH0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-TK_XIBMnPZmsVGnTHYZlMg-1; Mon,
 14 Apr 2025 09:29:20 -0400
X-MC-Unique: TK_XIBMnPZmsVGnTHYZlMg-1
X-Mimecast-MFC-AGG-ID: TK_XIBMnPZmsVGnTHYZlMg_1744637359
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3456D1809CA3; Mon, 14 Apr 2025 13:29:18 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7566119560AD; Mon, 14 Apr 2025 13:29:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH for-10.1 0/4] s390x: Remove deprecated machine types v3.0 up
 to v4.0
Date: Mon, 14 Apr 2025 15:29:10 +0200
Message-ID: <20250414132914.250423-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

These machine types are older than 6 years, so according to our new
support policy, it should be fine to remove them now in QEMU v10.1.

This series is
Based-on: <20250115073819.15452-1-thuth@redhat.com>

Thomas Huth (4):
  hw/s390x/s390-virtio-ccw: Remove the deprecated 3.0 machine type
  hw/s390x: Remove the obsolete hpage_1m_allowed switch
  hw/s390x/s390-virtio-ccw: Remove the deprecated 3.1 machine type
  hw/s390x/s390-virtio-ccw: Remove the deprecated 4.0 machine type

 include/hw/s390x/s390-virtio-ccw.h |  4 --
 hw/s390x/s390-virtio-ccw.c         | 80 ------------------------------
 target/s390x/gen-features.c        | 43 ----------------
 target/s390x/kvm/kvm.c             |  6 ---
 4 files changed, 133 deletions(-)

-- 
2.49.0


