Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6561CD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvpN-0002w1-R5; Tue, 23 Jun 2026 03:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpK-0002r4-R1
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvpJ-0008Bq-HR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtnkDg33MYu/ghaopwN30hvH/Rt4UQH+q1oST+NTnl8=;
 b=aYhgFAlIdzXPvYUrpFi9Q9JMwaV6o/kISmBSAIp7i7cpSJCWHm9ZplOa8N0/Vi/yKaQlQZ
 DEtEJbodZJV80dZ/PeieImaoz/8eVdyndBDxLSHeajQe/oBQwKgOzPvjlVDj+dt36E+Wjy
 uv9MdEtgz/Vz1b8KU413W/SdbyBpbV0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-3qVESBI3OpuFd0iHwmvAcw-1; Tue,
 23 Jun 2026 03:45:40 -0400
X-MC-Unique: 3qVESBI3OpuFd0iHwmvAcw-1
X-Mimecast-MFC-AGG-ID: 3qVESBI3OpuFd0iHwmvAcw_1782200739
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B33E19560BB; Tue, 23 Jun 2026 07:45:39 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DDF41800591; Tue, 23 Jun 2026 07:45:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:26 +0400
Subject: [PATCH v4 11/34] ui: stop ui timer when closing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-11-4656aec3398d@redhat.com>
References: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
In-Reply-To: <20260623-b4-ui-v4-0-4656aec3398d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=794;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1hj0l337W3NJOgj2iQ5HiEquhGCiA0qJG1NmyVMnuVU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldw4I4ykcPvw7ZvVoGqHPQvXA2cIxwJJC8X
 5HSVf3pC/iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5RybEACTs3yctlIY1dp+e781ZIyiu7TD5FzvmkAJD3udlODyT/yXwMdijHp881dAPVLe1oM7A+4
 IYhdoCg3m5va9f/3BCz6Ng34qGCziV8sj5c+Vs+DBOAswEhbi8FfjA3CNsN45b7xU4sg1T6GDIC
 O72V64QEA1UIPu4KLmzZBJd0npn7ddF7gaamyyDKdz3UWdzML187Ohf/qeS3170JjCZSeenS33T
 4Zs/N44mfHC/M7H10rnoVduDpwL7pbflnt0/Gpglye4UoSgYV4x3m4YKTh20y5fnptqIw2XxSvF
 XbvsJh5uo3jvItovt229ACM5jByt/aZjlg4fw4VhyY9gFWaEPvupBvvaLe7Basq0Z6flFDR2SLV
 kOeu46ax6ArF60Gqz1bjHORdRhAcZtwb9e+yd8b6xB/Mgoe18ITnIkmqmTEOoDX8bSYaGiIWNsX
 blAL/ap1rRPIotOhb6t1Ouxq6rJjKxhKk34eYdy1gJM/YAI8QpvsH4eLCnva08TbIIOICdqXviU
 VHIuo+FzHgy0dCTY+WMVXcI1O5+T0FDlm0Tc6H11ETndVqqouZFvTkb4qqDzzbUg0Zow1Fu/Lqo
 sGH4KlrMTeoX7EdZsHNv5VaT07Fq+3/wjhmf9faQ+P917ar85ZNvkzxdiGh6pL8Cy179Xsjaz9H
 YxwmkWUewvJNEtg==
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

hwops is reset, so if the UI timer is pending it will crash.

Fixes: 9588d67e72 ("console: minimal hotplug suport")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/console.c b/ui/console.c
index a7c977d0c44..436444723a5 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1136,6 +1136,7 @@ void qemu_graphic_console_close(QemuConsole *con)
     trace_console_gfx_close(con->index);
     object_property_set_link(OBJECT(con), "device", NULL, &error_abort);
     qemu_graphic_console_set_hwops(con, &unused_ops, NULL);
+    timer_del(con->ui_timer);
 
     if (con->gl) {
         qemu_console_gl_scanout_disable(con);

-- 
2.54.0


