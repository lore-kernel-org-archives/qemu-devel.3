Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8352C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Ow-0004Sx-49; Fri, 28 Aug 2026 16:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Ou-0004Om-8s
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Os-0007xt-RF
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=38No7Zvu4JWoxS/YQOai+qQNR3oeuIyfmWZ/pcMVApE=;
 b=Y33UNEyiXO1zjX3hJc3ripp0hTDBGdGYWIVbzcle0S+7800rjIV/xnqv7QrJvhbwaAo1Y/
 aKpFxO7oIBfmVSwQnj8y8QzAqTnZX+QXmS2Recj88GN1SBKmjN4Npb+RYOZJV0oukCXBcQ
 Kzq5yGXVBSHi57C8oPga1P9xEq4Xg+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-QIvqBisEMXqVIjDgZqgW0Q-1; Fri,
 28 Aug 2026 16:42:06 -0400
X-MC-Unique: QIvqBisEMXqVIjDgZqgW0Q-1
X-Mimecast-MFC-AGG-ID: QIvqBisEMXqVIjDgZqgW0Q_1787949725
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DAFD1944F2C; Fri, 28 Aug 2026 20:42:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DC547D9; Fri, 28 Aug 2026 20:42:03 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:40 +0400
Subject: [GIT PULL 01/50] build-sys: introduce CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-1-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BYyQJVJWcRkVuP3sEmH0oMRFSR4xiTQ6caIPo7oXJmM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKT/93uzA8yuBw2zJ39gafvicIDtUpYgaKcD
 3LcDmV/3XKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5Y3OD/9VdvpwN8lKMCuRGeytVPD0HxKvsCnK3yKUqbAPyFW/p63jPj2EdpLxKALETvANbDEcRbc
 jbNAx8mCtwCproXjF5bevTDecHhKuxwH+X32VhhNt6PkG4Gtw/u782nOjp3kOJBt2ENESpZxJ+1
 1znTDPWJfKfPWyp4jFIENgnRTcF0cYU11RehUiqYCVHRN1u4TTLTZLmbKAB4unnJfOayFkXzUoU
 Gya36ATAR1wlFwOJsjkEDz6e6FQNckKFh3LqsTGUBW2t5sid3yI2bMnT2GRm/LcIWAAy6lM2+cR
 45U27mtCxpnStpPCUtgT0KhoVckHjq/0SBB7wICEW3eZXtmAlrMdJyRfwnJqBfuxfLZ2X8o68Y7
 ebBf8vpaHHr897ASjR8nXSZPGl+D0sM/mdaznQ37XTmymqFoT08sNIPhCh4nm64agFtu3a2fQzJ
 KeWpXUL+buOlC9nq/oyRqzFF+c1zE3yGJUqSBoekOwHijNViD85OBZvk6a1fWi+K2VYf7P1PImk
 vsxW9NVKe/tYbnTRq6G02X40urH0AquV5BiQW1vq/n7UKN0ZuzuuZ5t+y1xRNBQVfhqajMH8ia6
 1J126qHKa6lv8/wX6EDspgplJPsRfA19SQk1JhTtMOr1vga5KY0eS65NaWp9jxqFWY6K45dQipn
 NsZuV9yrxq2n9lg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce a config define to mark regions that should be compiled
out or disabeld when CONFIG_HMP is off. The actual meson configuration
option is introduced later, as for now, only "true" is supported.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-1-9227de146347@redhat.com>
---
 meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meson.build b/meson.build
index 6dcfdceb507d..aca56813ab8c 100644
--- a/meson.build
+++ b/meson.build
@@ -243,6 +243,7 @@ have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_
 
 have_tcg = get_option('tcg').allowed() and (have_system or have_user)
 
+have_hmp = true
 have_tools = get_option('tools') \
   .disable_auto_if(not have_system) \
   .allowed()
@@ -2266,6 +2267,7 @@ endif
 
 config_host_data = configuration_data()
 
+config_host_data.set('CONFIG_HMP', have_hmp)
 config_host_data.set('CONFIG_HAVE_RUST', have_rust)
 audio_drivers_selected = []
 if have_system

-- 
2.55.0.543.g5ebe2ebe4ea8


