Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F695C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WHr-0000zF-HA; Thu, 02 May 2024 09:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHp-0000xZ-Cc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2WHn-0003V6-CF
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714655740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=q+v2FNLJ64igVrqlESkJZ+E0/w7AQ4Dw5n7i22YLXCk=;
 b=E/0iZhh4fd0NIT0OrCgBZM/YXo9qSPVD/8XN1bL0YnU+eoGPzMWxTjV4o90c4sic4IF/LD
 vgibenljKfg10PS0rkAcXoxThOTfyozqldoL7u2raab+tVt9tLNLwzOGyTKhYz54MR4Ifr
 xxxp/iihOWFWySOHM04CrIGFdP1et2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-1NXxuKuMMjurIJRhBxA6dQ-1; Thu, 02 May 2024 09:15:37 -0400
X-MC-Unique: 1NXxuKuMMjurIJRhBxA6dQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7483834FBA;
 Thu,  2 May 2024 13:15:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CAA341C060D0;
 Thu,  2 May 2024 13:15:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 0/3] s390x: Simplify SCLPDevice usage
Date: Thu,  2 May 2024 15:15:30 +0200
Message-ID: <20240502131533.377719-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello,

Here is a little series reworking the SCLPDevice initialization in the
machine to simplify its use.

Applies on top of :

  https://lore.kernel.org/qemu-devel/20240430190843.453903-1-thuth@redhat.com/
  
Thanks,

C. 

Cédric Le Goater (3):
  s390x: Introduce a SCLPDevice pointer under the machine
  s390x/event-facility: Simplify sclp_get_event_facility_bus()
  s390x/sclp: Simplify get_sclp_device()

 include/hw/s390x/event-facility.h  |  2 +-
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 include/hw/s390x/sclp.h            |  2 --
 hw/s390x/event-facility.c          | 13 ++-----------
 hw/s390x/s390-virtio-ccw.c         | 18 ++++++++++++------
 hw/s390x/sclp.c                    | 15 +++------------
 6 files changed, 21 insertions(+), 32 deletions(-)

-- 
2.44.0


