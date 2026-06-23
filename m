Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EA4CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvoY-0002ME-2f; Tue, 23 Jun 2026 03:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvoX-0002M5-1Q
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wbvoV-0007g7-JV
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782200694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUzXrAPMHVvzD+oeqhkPex9ckI+tMZJ424iTr2LXjZE=;
 b=ZE7FAesKrr+JPEcUbJJay+V97dXs/yT7iOAtpC8RXqoetOhK81blXvDl6uR8vntqKI9KzI
 1AsBfC+b5MyzYN3sTTD+EUHDQWFESnD5VyfFt7rSasWYXoUaUVXxw9KIqxN522mB6f6Ip2
 f85iXxB0N27yynUZXeI8Crd2DOatZZ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-JefB-1bgNFW_LIvKQZ3rtw-1; Tue,
 23 Jun 2026 03:44:51 -0400
X-MC-Unique: JefB-1bgNFW_LIvKQZ3rtw-1
X-Mimecast-MFC-AGG-ID: JefB-1bgNFW_LIvKQZ3rtw_1782200690
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72332195604C; Tue, 23 Jun 2026 07:44:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFF5F1956040; Tue, 23 Jun 2026 07:44:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 23 Jun 2026 11:44:17 +0400
Subject: [PATCH v4 02/34] build-sys: build with -fno-omit-frame-pointer
 with ASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260623-b4-ui-v4-2-4656aec3398d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=836;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jujKEWqUwtrd6lFdi2u42Ft8tJxQte8AB+Dwe9NS6L4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqOjldQs3OlWcyJlnyzdks+cwqBQgHetBkshYh7
 Y1A11pcSXuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajo5XQAKCRDa6OEJdZac
 5SGTEACsCMKwXNtx+1cqXivEWEnm3L/O6TYKL0STPC3vhem9WdLnlst5bGNuWlQmo4Ct1aFbCs1
 5B+b15NsA0srjKnCX3NgCkX0TnlV+oxk4P1mE+rYJ1AJPzlCl9fBcmu5K4qs18oT4eDVB93BHiJ
 J/vJOIPvJi9yWWGxdBgV6VRrGXshYwTdKUxJEMdFpBQiHml5Jb6B34iFskdD6RJ6+54HSeaeau4
 dfOSEJ//ZF9ovreems2nkA5+tiRcWIJNka6xZREvh9Eq9nf/9Sa9dlfUXXhqikjYYl3Awlmbixa
 IUpPIUmS3nb/guvJhmkJ7L4JaaqSteDQySBMndAmggqFjWiNVBwDhXP/szKz4Xl5bpaT5R7WbW/
 KM3CYe8suKoLeiWqSyS218xHIbt4485HjsC3iDFgTNvltXkC69GEQ9ltrEmtRKgqwdWLd7Qs9ED
 U0jaaAMsQ5bjOwtoB0w4sF4iMSO/GrVnGDmX0Z8JT8+FycBRNZ3u3STR+jMXwVD3rIs9T3eiA7Y
 c/Z3EI0cnPFlDz3FTOU5+rtV4dLXz/3In1bMcn5wLzOX8KsD58Z2wsc7YH09ARKWURKg1zJ0CBE
 Wc1LDvpILM6raEoYJbKRH5NgeAYOoNQNnhctrFyLGvd32Fb1J8ajrAYNImz+j23Rw3oTRmmV09D
 zBsBQhZyIoYN+Mw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

On fc44, LSan fails to suppress leak:qemu_irq_intercept_in, because
the backtrace isn't deep enough.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index e026851309e..0d1df06ccc8 100644
--- a/meson.build
+++ b/meson.build
@@ -545,6 +545,8 @@ if get_option('asan')
   if cc.has_argument('-fsanitize=address')
     qemu_cflags = ['-fsanitize=address'] + qemu_cflags
     qemu_ldflags = ['-fsanitize=address'] + qemu_ldflags
+    # Ensure complete stack traces for LSan suppressions to match correctly.
+    qemu_cflags += ['-fno-omit-frame-pointer']
   else
     error('Your compiler does not support -fsanitize=address')
   endif

-- 
2.54.0


