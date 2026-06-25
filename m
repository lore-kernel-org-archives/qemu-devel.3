Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19E7CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUg-0007MB-Be; Thu, 25 Jun 2026 17:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUe-0007Lh-If
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUd-0003ZZ-3Z
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ftVnIrg7IhvTgsH874VGkrhm8Pf1lWF5j+NY0pcecck=;
 b=anTbhioYza07X4g0ozDd5fOtxftg7KcKURWoW3vvcdn2rXwWWVIdaoueis4piYabRgrzUr
 4rnOIAslGH88MpN5gaDQgbBzlx+2ZCydWY5R1le3uK1adQpWkAkfww7/yBpi3niYIDadSO
 ytpGp+Xre2SvfJMwj9i4SKLV1mDi4us=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-nT2W2dvrNk27tEmOmPjXuA-1; Thu,
 25 Jun 2026 17:20:12 -0400
X-MC-Unique: nT2W2dvrNk27tEmOmPjXuA-1
X-Mimecast-MFC-AGG-ID: nT2W2dvrNk27tEmOmPjXuA_1782422411
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A35E41955DE1; Thu, 25 Jun 2026 21:20:11 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63C5318001D2; Thu, 25 Jun 2026 21:20:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:08 +0400
Subject: [PATCH v2 07/39] s390x: prevent crash if given invalid CPU#
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-7-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=679;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0ZX8MI33C7olws3WyEP4w6WQCQONCzm0bGIQjW3TgEc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcm3dbxAu36aCwW8dyDHFprKxcZ0n/08WEN
 ToYEk15V0CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5Ql9D/9UOouZHotPPSPZXDFhFOTzTRPe5XAFoAMVPZxFO/xeO003zHrHr1KKbh+c8APAY3pvHsc
 4L6DbT1gM6NWfKDV13ioicxB3jzWBPg/ZrmdTkaI/7DCUrqEY+ukamvxFDaDvULbzZMqzfw47TV
 SnndMZ8/tjsTyF2urupd6TO5pCqfffFxAPtuNBGWIX6hGMe/Juhcgu/xBGIn/sxGOaC+n5ipHI+
 MuTn+RJVdyZZbO9n0Ihm2oiRfCt4ivoJ/5c2JYaQkVA4cW5LkKS/Wt3NZAAxpOENFYavEoXT2D/
 Mq8t/6dx47O2bS+/ydhFg8bbGeb14i4fKQ+09BsZHpjRtemKQRBMXJcI0j1zv1o+VyDqcXH9T//
 jVCTdvVrhvpkRH9AWjCKstCf9NYptgeWVIGddMMUo4Wu1qT2A3bP6/Y3d+AG/bDFVje33maGb/K
 JrUznwVYZKRtprKTFTexMd74tnQvuRFpibdhhS9gQI9icxq+DOGnFTA0qb8Zcosz9kDCIlfDbqx
 AvzmCTordaJBIOtpG9c6aFXxbpZ4jj3R27/blo1xBFcVMBY+i16sSDmw9C8thnqiRrFZNZPFAf0
 RKFgum1szry8tnXcNaWCGAQpQB//0RG3lZQD8CsQ5nbVb5s1TiI1dDqG6TnMvSoBvmBU7CmUjEV
 1aCSCC77T9qQ2Rw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 25a9fa49554..d0fd894eb67 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -729,6 +729,11 @@ static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
     CPUState *cs = qemu_get_cpu(cpu_index);
 
+    if (!cs) {
+        error_setg(errp, "CPU %d does not exist", cpu_index);
+        return;
+    }
+
     s390_cpu_restart(S390_CPU(cs));
 }
 

-- 
2.54.0


