Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E7CC53219
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0N-0000f2-4h; Sat, 25 Jul 2026 05:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0D-0000dm-TC
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0C-0004Tk-Jr
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/K+1AUXVnWWVKlHiV4xOB2JHy4bJFnMoNAwKxtUWMM=;
 b=O38j6EkGEdfGhXB0qwF/rjMb0mOZJptIb8V/YtpJBDLf3Pq8mnSCPQ4wnBd6Tw2R9RrbsT
 Rsjerc6DoMgZl2c4lKUpn4NPblyDsvu+9t4InN3JcwkzqzuTvq3YWVDEWPAYG5gK5vOv5p
 37qe9GTNVDZO+EJE2KNcJtgIYdm1i88=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-kqW6JzhCMSGvGk6dV2OZ9Q-1; Sat,
 25 Jul 2026 05:48:55 -0400
X-MC-Unique: kqW6JzhCMSGvGk6dV2OZ9Q-1
X-Mimecast-MFC-AGG-ID: kqW6JzhCMSGvGk6dV2OZ9Q_1784972934
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57AE31944D07; Sat, 25 Jul 2026 09:48:53 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC46B414; Sat, 25 Jul 2026 09:48:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:33 +0400
Subject: [PATCH v2 2/8] migration: fix qemu_get_counted_string annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-2-d3552ddb3931@redhat.com>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=30QVK4Yftj1iMTz1RR+q67DvyJxcMY1WCMPrbYrInjc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZzO1HZBtKMLGFKp3fYeR5gHjF+rjEkFyuzI
 0CxABrBaD2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcwAKCRDa6OEJdZac
 5buBD/99haUzF1FiNgKLiFuyz6+SuHqBPF3MGW6my12xjC7Af9mOxeD9wqgASB6p8LNAqsfw3Rf
 8sJJdoEZP+Cv0/ykaAmcDhUJYjmRBCYhjsI0bkf6vgAPkQUl0LJZDuDLKYn/9i4Tpv+nEZ1F04f
 aVEEEdI68AMq7Hznot0B9b9LCG0tzzJrO2Y0OlXl49BqVhTGJ3fb/OSV2e5r1LMPCVJLK6vEJKf
 SyAZNyuB5XCSCIYfgFOcu7h4K6yRH75p++quoBFHKqHhIwEn3V1wBuVorxEGOQBEv9dgdVt2ZeI
 mjKwctY3vLgVWEzowRy1cdxFKeKs+u2t9v3tM8ZcpgTOqIcYxPFt/ecfCgpaQwCSdOYG5RNEoeR
 IydKsGfkRthqCPdjBjIc65krISlvtbM0PqljjyPgsELy0YGxPMICjJTzbovK53zMt69Swx3pGBK
 CoEeriygam9HZnbKjwC6KEVYteJUdDxzVgqR9XLiIPptHVCrlaLBVr8VVY9Wl+jgzpyV29b5sTx
 0Ognto50yvAnke/1swfgvGt0dpELPO6ot5n7j76wu9ChnaojU4w19Vw7rAENuBpDxuBkWqNNdWP
 Whc6clSymH5W8Or2yeUJIoTkN8fzfPh95eYWo6c0y8KFzuQrm1ArZtB07s2K7zqnedCRJn082RD
 fjk5NV58LBo2agA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Fixes: 394b9407e4c ("migration: mark mixed functions that can suspend")
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/qemu-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5a48115bd63..f30e13c66d77 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -830,7 +830,7 @@ uint64_t qemu_get_be64(QEMUFile *f)
  *          else 0
  *          (Note a 0 length string will return 0 either way)
  */
-size_t coroutine_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
+size_t coroutine_mixed_fn qemu_get_counted_string(QEMUFile *f, char buf[256])
 {
     size_t len = qemu_get_byte(f);
     size_t res = qemu_get_buffer(f, (uint8_t *)buf, len);

-- 
2.55.0


