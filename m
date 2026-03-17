Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D293DF3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Q9w-0006Jh-Ew; Tue, 17 Mar 2026 04:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9D-0005kR-5H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Q9B-0002jc-Lx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiXAJmp3K+uqffJudDLR5G/KuISSy+BLtS5bv+MaCbQ=;
 b=WjrtWbEzd+jr6dROCR5bvKH68zIJvMIcXUlf6d3MVTgp7gEmU2XSkvRQ36NtSjE7/LbwbV
 Y9Cy0mR0TmuwmzM48STdACio3sDk5CGpjtJq7eI2lK9yjYHtDtX5igmKju3gOGyewqzhST
 ixOPwGzBfEhMXx0LCOLkiX0trxI0z6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-JWkRHH3DO_GFighqonUqOA-1; Tue,
 17 Mar 2026 04:51:27 -0400
X-MC-Unique: JWkRHH3DO_GFighqonUqOA-1
X-Mimecast-MFC-AGG-ID: JWkRHH3DO_GFighqonUqOA_1773737486
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65815195608B
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:26 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C4B01800107
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:51:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:22 +0400
Subject: [PATCH 08/60] ui/vnc-jobs: narrow taking the lock when pushing
 empty jobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-8-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=765;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1GiMfRYvH2dTxsOggAmtQugVHNETWCW7xXWDOfihhNs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXaulgDo7cS17JhnRdURAIZOSNFeZREcGsee
 QB17E3Hs5GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2gAKCRDa6OEJdZac
 5UqRD/96zOLFZV2v+tPV+nNnZ3M6knU790b+i7f5GLAFSIYGhkuaispU5+qIGiQypq7stSCYL2K
 7QvMWM0FRkhs5/DVcnLr0kTPV7r8BJOwHCTgnDWdo0I+02xU67lfyR7BQzSo3MBodsAd+QjsAX1
 Bydp+k2rSRSmhD5G/DBozXJVC1Hzg8n0IW96L535/4qn49RzMoAo4+4UEUaregA1P/KsSK72dy6
 pKd4lSGreSGCtYxJtHGCgMGYMYYhifOiclDKQUElGnIf4Iz6IEt+jnYtaw1W8ECYnfOMe4qeWZH
 pRxdOj5W/ZQW143p5iHpm08XrDzjMnmra0/T0wC1J037HulRns7S539/Ih27wLNU6WAE0vrq4tM
 JGaZwxwTOlcomqeYzsy3SYyegk9TkrwXEs9iQn9F4flDw3133zdBdpsHjj/OuP1WCghbi6mCbbK
 xcLwzTn6sMZ20fXlWKEHbCijnOnSoX9a/nhcx6Eko2lEp5/W2bFYkVleZuy2sOYy0Bd902alEsR
 6AJNv+6Fm+XZEueqm6KvV1RKZ3iSiJr9yfSmNnICkAuEjsE6NNeLRfkTjD73ShUjshmozykXJmb
 Rcckn0Gz6sQN6jGoE/CwXaBf+TgXEio7KMEqHXHXNzLh+tQmKsEBMc0JUIEvP1++3qX3mbNiy+h
 TA82Aule99VVFpQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 28a4738f1ec..ae925171fae 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -122,14 +122,14 @@ static void vnc_job_free(VncJob *job)
 
 void vnc_job_push(VncJob *job)
 {
-    vnc_lock_queue(queue);
     if (QLIST_EMPTY(&job->rectangles)) {
         vnc_job_free(job);
     } else {
+        vnc_lock_queue(queue);
         QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
         qemu_cond_broadcast(&queue->cond);
+        vnc_unlock_queue(queue);
     }
-    vnc_unlock_queue(queue);
 }
 
 static bool vnc_has_job_locked(VncState *vs)

-- 
2.53.0


