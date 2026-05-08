Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D756CD37A7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 11:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLJJz-0000bR-LI; Fri, 08 May 2026 07:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLJJx-0000bG-Cd
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wLJJv-0004n8-Fu
 for qemu-devel@nongnu.org; Fri, 08 May 2026 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778239477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UsfFQUq1tbPIEwHxvLCASoldgt5Ebgua/bCT72rf2Fg=;
 b=e9lR14yGeKWFmq1ueW1dD51RlQXR+3/t7QbKHUiJab3TDzugXHcLHaJ1Rwrxq/cggqKNaY
 OIuu0OHVBRGsrbhJFAD6bdoTT3JO7J9gsWvyj8ZBS4auH4B3Bs1rNYaDKLE9OWtnd3eXu4
 hfG61TlsfWRG9v+t+lYvcM8U9qOMbAI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-m68FcJsPP-auyU0mzA4M-A-1; Fri,
 08 May 2026 07:24:34 -0400
X-MC-Unique: m68FcJsPP-auyU0mzA4M-A-1
X-Mimecast-MFC-AGG-ID: m68FcJsPP-auyU0mzA4M-A_1778239473
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B1611956061; Fri,  8 May 2026 11:24:33 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D41F1800240; Fri,  8 May 2026 11:24:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 00/10] qom: misc cleanups / fixes
Date: Fri,  8 May 2026 12:24:19 +0100
Message-ID: <20260508112429.643360-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The overall theme of this patch is to move some logic out of
object_interfaces.c into object.c, since it is not tied to
the user creatable interface.

Changed in v2

 - Ensure object creation always triggers module loading
 - Remove redundant NULL check in trace event
 - Remove double #include line

Daniel P. Berrangé (10):
  qom: add trace events for object/property lifecycle
  qom: validate ID format when creating objects
  qom: make errp last param in methods taking va_list
  qom: shorten name of object_set_properties_from_keyval
  qom: have object_set_props_keyval return bool
  qom: move object_set_prop_keyval into object.c
  qom: add object_new_with_props_from_qdict
  qom: fix ability to create objects without a parent
  qom: allow object_new_with_prop* to trigger module loading
  qom: drop user_creatable_add_type method

 authz/listfile.c                |   4 +-
 include/qom/object.h            | 121 ++++++++++++++---
 include/qom/object_interfaces.h |  18 ---
 qom/object.c                    | 230 ++++++++++++++++++++++++++++----
 qom/object_interfaces.c         | 101 +-------------
 qom/trace-events                |  12 +-
 system/qdev-monitor.c           |   4 +-
 system/vl.c                     |   7 +-
 tests/unit/check-qom-proplist.c |  97 +++++++++++---
 9 files changed, 409 insertions(+), 185 deletions(-)

-- 
2.54.0


