Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C39C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvK2-0005ME-7g; Fri, 28 Aug 2026 08:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvK0-0005Ln-7d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvJy-0001fd-N0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGBecOaVJy0oKWRymDIJd5zXeBs6+RiE+whg9IglWD0=;
 b=MeRiIWOC6P+FS0mGDziYxegjEN5iwrQtrnvpUqJ/u/Lb6ulsw5wHO0ibl+UEcCqW/rIv3S
 6N2SY9WCjIK5u/4pbbfLgl1tSkz/zEnkQVdnCI68938MP2Xj+5sVvoFaBi0k9ROBp24op4
 oeuEZlm/7VtVq4h5Iro0WEKG9/FO2qQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-6TrY_2H3OWS9snvRPphGPg-1; Fri,
 28 Aug 2026 08:04:30 -0400
X-MC-Unique: 6TrY_2H3OWS9snvRPphGPg-1
X-Mimecast-MFC-AGG-ID: 6TrY_2H3OWS9snvRPphGPg_1787918669
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD0601800A3B; Fri, 28 Aug 2026 12:04:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B921D195604A; Fri, 28 Aug 2026 12:04:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:03:58 +0400
Subject: [PATCH v5 01/50] build-sys: introduce CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-1-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xO75wBLlx6wjMDz4T9oMHecN49z29GcNrAM1Db+DwBU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk3vchU/hTU7zHZpRUatP86nMxd5nq3wYyC+
 WIt3FN5qdGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5NwAKCRDa6OEJdZac
 5bTED/9Zajj6tRc+yai4gsX1uOLIgkb7IK1Wn7FmWZPFnMg8U4c70Wb+qk/MBXYEbrwf8THdehQ
 eO4uxZ+jP5PmkMb2V78rotIserGY6C9zVTO9fOYnvhhXbK9Q7HUPQC2n2w5MM8KrQa2e7ixvMgq
 Vx2UgZyKjQYT5J+1xcxrvV2xK8K9FAdgF0L6sjxWmHA8DHt5EljXqaEcQy3D/Rh0vyIeK0zQP6a
 iMcn92waRakDPj0NKJrOLcPP5am0GX61uILNx3+5s2UI7+n0Sxe3NHUfXt9RPReRo5+jbEg5vpz
 Y4UA+ESLYx3o3U1lZpIuiOLbM4qDWGahg477uFQH4KwmE/pL9wQ2qcpgF0jDXUsmR9BMBu6ZZpg
 zyL4eGTSD8fJV2pUYeT0fgY+Z6vcDG4oagpcaGC5bI9+aWlmaXWp0v/1fJwlnciOkDCLQdAU2F4
 IU52mUHfBpPUbHEPkqO3Xzj3RI6zA7WLLGxHorxm7pk3uF+BVD9vaEgdSiDTH0uth8oju3Td2ty
 en+2ymiXpgXG5ese+COmBFRu21Mq9e87WSCwWZDFZa2G8CKvr2NE0cn//oGhNXxM9JE849f2CpH
 waq4KkLGyIZ720ZonZbMdYSeSAUcs0My/SKLEQJzKt6y3PhDd6Ym8pRHm+MogkdO+q2PJatAU7b
 9VXnUxvoJv6ol7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce a config define to mark regions that should be compiled
out or disabeld when CONFIG_HMP is off. The actual meson configuration
option is introduced later, as for now, only "true" is supported.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


