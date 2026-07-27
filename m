Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251B3C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtR-0001Yb-DM; Mon, 27 Jul 2026 07:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtQ-0001Sp-6E
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtO-0003yl-JD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dPp6/Iz6emP9faagVMHidtrIEEZa8zoC+YjDWgEts3k=;
 b=D8kowrS6ptXwXuNoaszFODlwDddIfJPcH8zx3HBwHzpz5R+SsINgD1zR+27bNen/FTxn3u
 WxKhjRZE4Fjj8E4AT65Uz7RiLVUCllDxf1la02XFPMNPofRaZ6SFoXrt/budHRUYYjvenn
 7WTHMoXT8Xde7uk/RsWJF6EVuuKxcV4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-9i4V26UuOVKA4FY5nNPMlw-1; Mon,
 27 Jul 2026 07:53:07 -0400
X-MC-Unique: 9i4V26UuOVKA4FY5nNPMlw-1
X-Mimecast-MFC-AGG-ID: 9i4V26UuOVKA4FY5nNPMlw_1785153186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2645180264B
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:53:06 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 825C2180029F; Mon, 27 Jul 2026 11:53:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:26 +0400
Subject: [GIT PULL 17/23] monitor: annotate
 monitor_qmp_dispatcher_pop_any() as coroutine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-17-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u5SYt6HOlXpoYkBe8zmUhNbcCVIM7I1SQQWsPqoY/1g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/5QPEg5KL1rJsLnNf6I+DP6f6zidKuoF4k
 S/QEJZ0Ue2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5fU0D/40NwzjMKD1q6N8CBeO/Xb5jvVU2qMLbmccD4x4ASQB/D7byAYGcjuQs+QwJv+CBPWwft1
 AsjWYwmm4itFyzhKPvSprP4BVr3eRZmsmZI0UwarHvLgg5Yl35JUISPsVHfXrT6Ozqo+682CiKC
 ls1ZLGNAqqocgkTWtOpr9Kj063uiE2Bgzgt36+TtUVmj/D1M6d4Y/eay8jkr5XnxEvbberGgFoc
 K+BzCaPpdGGHkpkUDlwL1GckKm5ZNgTm0w772pd4LGvzt87o6VI5/w0hodjTLKdu/OQbHP3+ayg
 mFMKU+5ubTMRmvfxMjntGtxD8jgnyD3CXwu4P/b9Vv89m2tzXRtN4LdLKJ44j9ZC3mwLwQGnoBL
 V5Q01HUDPTr2G+AdNFpXi3o/dN3mDjXxYgWv+yfGLpuUFYgdCNjF34cVvc3x6jXTyTLNtpTWh0h
 gkSAtqfibR0MKMASNAm7myG/xroXIlaQ+13v9++u3yG2LD3oP71JwShU9NNd/KCnqXgBBjCAYaz
 wSpLQAm364LYZR9gb27HpCPqU9WwGHYwjNBiV0ZNrIYZcRxhP3Z2J7vX0/iQ3OzkFuKS87WJ7xR
 M0gFTqoAQ2yHpMT1m61Q4SEDOe07l/k+NzNO4417V3uqIr8tkDOYk8pbfBtQUe3gQCoMJTDGze6
 RtcCQrVxAzdl38Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The function calls qemu_coroutine_yield(), and is called from
monitor_qmp_dispatcher_co().

Fixes: 60f4f62efeb ("monitor: extract request dequeuing to a new function")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 monitor/qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 223e0643c2ad..338d37cb7e5a 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -342,7 +342,8 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     return req_obj;
 }
 
-static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
+static QMPRequest * coroutine_fn
+monitor_qmp_dispatcher_pop_any(void)
 {
     while (true) {
         /*

-- 
2.55.0


