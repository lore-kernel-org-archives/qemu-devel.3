Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F52ECD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWUET-0007YQ-Iy; Mon, 08 Jun 2026 03:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEQ-0007Wv-CO
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWUEO-0008Ik-Fl
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780903027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2NOLZxbPovEmcF485gB8YHfSGPUMzoplq1iZoovF3nM=;
 b=Kx6QwbVOpTQLxx6lq449tmDnYo4f08XXiAa96ubRYjFEegt+Kbfcc2hLW2Hls1uh0LfTij
 POZJmrQUu75cPLkAjpl/c3F6BQtgnRkPvfUvEsYSZZrTC+t5MSaPvd0B2li0h7BBHjp5LT
 biSESY8HeUhwNAEPPT66fVibx/dcV9Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-u90KAHsiOvSiQ8MY_3cy8A-1; Mon,
 08 Jun 2026 03:17:03 -0400
X-MC-Unique: u90KAHsiOvSiQ8MY_3cy8A-1
X-Mimecast-MFC-AGG-ID: u90KAHsiOvSiQ8MY_3cy8A_1780903022
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9946F18005A6; Mon,  8 Jun 2026 07:16:49 +0000 (UTC)
Received: from localhost (unknown [10.44.22.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E898B19560A2; Mon,  8 Jun 2026 07:16:47 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 08 Jun 2026 11:16:20 +0400
Subject: [PATCH v2 02/33] build-sys: build with -fno-omit-frame-pointer
 with ASAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-b4-ui-v2-2-9ea6355ea08f@redhat.com>
References: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
In-Reply-To: <20260608-b4-ui-v2-0-9ea6355ea08f@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gmRieSy7YIQF3DAHwWXNcE5raE5XS8w6VE6DgvhJdaI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqJmxHqF8JnReriRintlpyIy+szK4T8G5ei/6zn
 tRenmifyAuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiZsRwAKCRDa6OEJdZac
 5UG8EACkjoFzhyW5J8KrF6YsexN25RXyfgVlgdUcXvLvweqfEEEaq4UKc/8UNNch+lWEp+hIQXS
 ZOsOAUDYLS4tknBZJqAjn8+qqxyKcbrftUzNA4oqqlBmymQg1XDyO3JDCKaivIAG7USCavvqvfd
 5oSFY42cxrGUrK3y2br+Ll4Uqu2hHN6dJfTMMWMSMhA0kOhWKQfJJZvg4dDlDqbkhBOvsshh+YW
 G7WvDqHvgVWrgQB0L8shI2x/fcQWOjTrxGxXyCpyM8a2pQdDtInhMB9/8GMKMNLmxxkFk/EOV7b
 tCOMTWgzVX6Mfqx6NW2/+KQQpQ3vYcTp1eGbHdbWlR3jlBBpPCYQUvIGcogMfv/IsyzCnedTyqw
 fVnuQZqnPcQdc/QxSSXgYJkU4wutnIl02JoBZU26s8i8B+SUTnzmDR5mLy9zxsn6Mxbbe6GNghs
 XWM2ZohD51MHYJRMbudTWUH8HRIZ+XoKlIDZkAUHCctO1rtt++aMudPLL6/J9yTLUWQDnB54/l0
 PLlf6KOIjFDmXFAfjrwg0CcEj5kZb81tN59PxqBNRmEwyx1c8G3gZnTxzU48dc9np0RMWsYtZJr
 PPMWJ6jYUOgXtXr+1NbiFQaN4eUmDfFPITu49egspuPBJBZPwAiNuUV54gRXBa+P41o5JRAn6yr
 rlXRi+aiiPCtyWg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 19e123423b5..3711483b95e 100644
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


