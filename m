Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9982DC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtl-0002kT-NI; Mon, 27 Jul 2026 07:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtj-0002Xa-I7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJth-00041Y-SB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBzav5r/PRxvX7B889078bhSww2+z17xh67+UFrqARc=;
 b=UKq1LXeh1HNlfg78J096xcajcxVYneA5FRYqmMLYtyLd71nOe1kr+/KM4TqI/Wy5i0AeB2
 Wld7vpozr4jrP9gQ8bvppGlKuQ0AWrcbw5KlM6SvdlhDshv4Q04pVzaG5PNvyiWomnkwHm
 oK/ZgmA8hrJrhg2bkWt0e/ewL/Qv+8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-R7dGkwH4O86MTm3ub-zcUQ-1; Mon,
 27 Jul 2026 07:53:25 -0400
X-MC-Unique: R7dGkwH4O86MTm3ub-zcUQ-1
X-Mimecast-MFC-AGG-ID: R7dGkwH4O86MTm3ub-zcUQ_1785153205
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AEC11800652; Mon, 27 Jul 2026 11:53:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 55E581955F74; Mon, 27 Jul 2026 11:53:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:29 +0400
Subject: [GIT PULL 20/23] block: add missing coroutine annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-20-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=abdp1jnclsipbx9mt5zdr1x5wsYMVTEvTXCKXSBolV8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/kZftvKs1zl+AQgu3YmdqMOHDjglaIll+u
 +3ECNSoU5CJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5RN5D/9dWipxOoJTl2IVNraclkRjish1n879iDuaCgKPtB0ImT6B3QIsYqFXtmDr4TcYV43P83B
 zaeNCguayF9bODCBTjlsPBM8WrPla0+fosIdeEym9BRQhqKZBuCCuwy+mQ0ZFoMPV3TvKgNuRi2
 Z1L5Eokh8hBGdpieWbYCGfEQVXLyZ4Q4eY5aUVbiQOuzHfziYOOFqwY4IqQp9Q99v9M3Htq6I91
 cEL0562ekeHdVVQLBCvHmRo8vTHOO5iCYnWw6NTF8URTZE7LKzn6XYo8LbQyyELbFWZ3JHyAkIi
 stnmC6v60HRcxhY2QOYDB1x+U8vPVU4PmD9ZP1KIZy3FzFZf3nU9Cx/87VouK3BhtrFE9EZhBDJ
 3HJaSh3THEVDxZAw1nFeQ6SDgHlcLwiLaXqO/I5en+yin/A74JuzmWZFINU+iAcfiTXqlSSwkuI
 tVzrdyrUCcoXU+WZjrC4lq1M06hl90vS2z3xqOKjLg3MWh6i5bxLWkw1bh3y/umeHzF8C/R4xEE
 a2FfOzkDOyYE7tDgEZ9ELga+/0RL3sgsnwUeRB/4d1tldhD09CAux7QUr6KXKsjHku9rR0xkTs8
 AQ0wWvRQ2KggJWL301LiwGJ2x26JKxKQDz6B5vfioU6KiCrUIAKirydO4hjCvkQV9ZP5GfLuA9i
 yZmqERoslKW7iTA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function was extracted without carrying the annotation.

Fixes: 23743ab282af ("block: move commit_run loop to separate function")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index c5e3ef03a21b..2d52c39594cd 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -128,8 +128,9 @@ static void commit_clean(Job *job)
     blk_unref(s->top);
 }
 
-static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *requested_bytes, void *buf)
+static int coroutine_fn
+commit_iteration(CommitBlockJob *s, int64_t offset,
+                 int64_t *requested_bytes, void *buf)
 {
     BlockErrorAction action;
     int64_t bytes = *requested_bytes;

-- 
2.55.0


