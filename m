Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8E6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weC5f-0006JU-Eh; Mon, 29 Jun 2026 09:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1weC5a-0006J6-03
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1weC5Y-00015l-Dk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782739910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AOEuTN+oLPlLcd6eoX66yCCNI2SYmHATIYHoZ7Srtcs=;
 b=SGvxVhjEoKmP86ufIcDQxpNm4aZ/CIaFa3r662FDt6YpBzBKxJ5p/+7dHuXt3XKrAStaUO
 i8N1ueU+rTWIaSrYr5c1cy5GVtpDF1P+ipEZbFUtbDNFMQrCp09ATO2IGvdxODbs7VVQxk
 u4SutpYDIoec+7Svi+HQIRvGxEQE8oU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-JAhE326HMi67dqczaiHP5g-1; Mon,
 29 Jun 2026 09:31:46 -0400
X-MC-Unique: JAhE326HMi67dqczaiHP5g-1
X-Mimecast-MFC-AGG-ID: JAhE326HMi67dqczaiHP5g_1782739905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52ECA1955F07; Mon, 29 Jun 2026 13:31:45 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.49.108])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B7DC18005B6; Mon, 29 Jun 2026 13:31:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] s390x/kvm fix for potential crash
Date: Mon, 29 Jun 2026 15:31:32 +0200
Message-ID: <20260629133133.1189753-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 60533c6193ede6ce403e82d09d82ae2bc8fb423a:

  Merge tag 'ui-pr-v1' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-06-25 16:58:35 -0400)

are available in the Git repository at:

  https://gitlab.com/cohuck/qemu tags/s390x-20260629

for you to fetch changes up to a57e4612b61da20ddab196502c76b4dc05da1de8:

  s390x/kvm: clamp stsi 3.2.2 size (2026-06-26 11:56:44 +0200)

----------------------------------------------------------------
Fix a potential way for an s390x/kvm guest to crash QEMU while filling a STSI buffer.

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/kvm: clamp stsi 3.2.2 size

 target/s390x/kvm/kvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.54.0


