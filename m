Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802BDC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJtX-0001i1-Hr; Mon, 27 Jul 2026 07:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtW-0001hQ-BP
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJtV-0003zH-1g
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/K+1AUXVnWWVKlHiV4xOB2JHy4bJFnMoNAwKxtUWMM=;
 b=Ho7EPGwV+6MGq7f/e0yH+jya7cwPL9+t9DBi3iyLQln9tg3uP4o5sfPvr0jVR7wgB4y7aC
 /cVphXQOFN5Zz8mxOMVNR2Rz3QB4Ktf0Cx+fKFCI4235oobo8T6Ia0Q7J6QAp6AdhYC/yY
 ubTGkdpIuC3Kisprn+1ITjN6vQkgoZI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-bHfj6XDAP8qi2dWl3GAD7A-1; Mon,
 27 Jul 2026 07:53:13 -0400
X-MC-Unique: bHfj6XDAP8qi2dWl3GAD7A-1
X-Mimecast-MFC-AGG-ID: bHfj6XDAP8qi2dWl3GAD7A_1785153192
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB071935314; Mon, 27 Jul 2026 11:53:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2085F1955F74; Mon, 27 Jul 2026 11:53:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:27 +0400
Subject: [GIT PULL 18/23] migration: fix qemu_get_counted_string annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-18-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=30QVK4Yftj1iMTz1RR+q67DvyJxcMY1WCMPrbYrInjc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y/v0XT2lSZWRp3OQW6ix/qG17ybK4fxxXro
 iJsPicAcI+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPwAKCRDa6OEJdZac
 5e/SD/42i+N9Eyz3oy+CmpP6KJNPNVk8FJuznzO7p2flHGXnXJsDGoRWAOJbTtWGHpUja6jGseD
 44/BKERmLtRtkyyoLnoK3T3q1Pc18gH1AfnmcqKIPGzPJ1cunHe85aA114D+g3oHIJXQ9Rmeddn
 74WXt1gEz6K9CR137FxKa0/4S6ZG0WDF3amMGY4VC1bhNj9sNi5029gMIjhdwDcL9HzY+fWQh6N
 t3lOFPpVqyX3i+eMw1/6yg9vUvQBT+jnxitL91xPvKImbs5lk4ZzfrzWewLEiARcAMGIQDtdNA9
 rGJazDnzl5yLdmGNC4gr1+gZpdrf95Lchm4Ah+uULe2I+FGwEVQPyTJUd1PH2Mef1sOcE5hZw3F
 HI6HVEJQ8/xYL0FafXkHqb/3HoLffLEBjgLzbITvj+kZR5zbxJe/1nnOtGN1wnn+4MvdxYkQkMb
 Zz+xow9NWpNTwJ7+SkhR5VCEMbmYCyVvHiiMgM3DQdlx6ED0tD/Q4D2cbcO+kEiMXh1R+463xkc
 3qfreG/6ZEa/AH7eE8eoOqwJn2bL3c4ZjaDDFLOkv6ADh9WtBhYaeTK5a6lG7Qvszu4DdVVaXx8
 RMTVC2k9Jj9NTeXaN8rIk1+MAHoZ0hfJUH1pzQvWjRcEkQ57HwGgvzLO0y+jqfF99at24peoOgg
 WWh1XaXOAuvdzUA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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


