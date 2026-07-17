Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B995C44520
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkh8K-0003op-C8; Fri, 17 Jul 2026 07:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8I-0003ob-On
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wkh8H-0003Pu-Cg
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 07:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784289212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q+d6T9+yJ9dU49+A0guqVDhBG9liq68F/Lzwj/pugL4=;
 b=UVI5UKsaJ7X88c52xbQfu8DDXk3tlywrKctR4v9TaHnwLdSSrB/x43vMAZ4FYMkFe90gXm
 10Dez1rwfsVnW1YTo02c2gv4Znc5/cnj+PgJRCpC1bdjXRDkVqarINMIQJyWnazx3Feh4o
 P0rtMaoJsrcoiHRbnr1wYu9rdS4TVr0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-1oEFK3q5NCaHIKr5eOUItQ-1; Fri,
 17 Jul 2026 07:53:31 -0400
X-MC-Unique: 1oEFK3q5NCaHIKr5eOUItQ-1
X-Mimecast-MFC-AGG-ID: 1oEFK3q5NCaHIKr5eOUItQ_1784289210
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E6B51955EA6
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:30 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 978B230040BF
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 11:53:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 17 Jul 2026 15:52:44 +0400
Subject: [GIT PULL 05/15] ui/input-barrier: fix off-by-one in keycode
 bounds check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-fix-v1-5-cb9f7d49dc52@redhat.com>
References: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
In-Reply-To: <20260717-fix-v1-0-cb9f7d49dc52@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=E1B0O3fJnedNADK1atu4Jy/3wDCbzWfL0PJwSeRCOAI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqWheZA1l0n7OqMR0DOyjiVgdIQk1l937lZeiUs
 qgi4tnb+COJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaloXmQAKCRDa6OEJdZac
 5XfnD/9M0fuc6If8z+zhrnHjnT5fY9CvE52Nm7+oTVNSb8NDOkIfJHNIta1iQdepie2eFNh5iRv
 1UHlutCoFg8vhj1pAKp7ARWPdho3wb9VyonUVbtvgDvMRNDL8EGtElpQqKpKQ8B76DTzlKmTkLy
 a6LhdQDaFW5uO1Yk7czoYvSpKA9yTjfpDvLwz4Kr5GV4V1iKaMW6DaHSaX6kkcUJiVVe/G0496U
 D5IKD35kZAMFDZCV7N+10lfxlUSvykiXmF5CojW1zzTRc/+1c/o+9Lcqvbrwh1UF2JskuFjQ3pv
 Fmr2MWKDvSnGGToGYtEvQYDgSmsIDCsZ45LwWh8gZsu/v7Z4FAXu7M3j6qSG0NMQtnPaqV6y8Mf
 TwP/aB+dkOpXx8uc6GUpomISXh/8WPymj/6oFOjUvA2Xn7c6AV6e7vjouJPWxQH+/SW3GikPiO7
 eoJ/K02EJXtnxuYa37MHTkegIsuiKrsQ35jwgowsvfVhlMkJkE2VSYTk9bz4gdd2lQFKWzIhtwb
 f/HRhvyUTdoqx05eGUc+uTyIONvR1WdUj34lzXysUF3PovWCo545H7QyrEQlFvT1viwLAbWeGAe
 cI6i3BpRdjxOwihE1wEOfdKj7w9UKLKTtWpotWfWeP7xz+WNllkOfETmGXSgnu9gsLpqAP1j9cK
 B1SaB4DuNwllP1Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Use strict "<" to fix the off-by-one.

Fixes: 6105683da35b ("ui: add an embedded Barrier client")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
Reported-by: huntr bubble
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 ui/input-barrier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index d07027114af..0a238d4010b 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -87,7 +87,7 @@ static kbd_layout_t *kbd_layout;
 static unsigned int input_barrier_to_linux(uint16_t keyid, uint16_t keycode)
 {
     /* keycode is optional, if it is not provided use keyid */
-    if (keycode && keycode <= qemu_input_map_xorgkbd_to_linux_len) {
+    if (keycode && keycode < qemu_input_map_xorgkbd_to_linux_len) {
         return qemu_input_map_xorgkbd_to_linux[keycode];
     }
 

-- 
2.55.0


