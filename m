Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ED4C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXM-0004AK-S9; Tue, 25 Aug 2026 15:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXL-00049x-34
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXI-0003ry-V3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/fJ1CyNejRoo+qK0w/miGDBvyJfcNNUpShbXpHkw5bc=;
 b=Jn4GJoFiOVreeiSlZNLW//tbPZXsP48W4uwTuZf/1yW6/Ec7vkrnuX3J2V3D7jiLCbXRhh
 FqmXl3eaJiXTmpFSZu1mZQJbOh1xUMGEl9y7rw/hpKIawQhy87e3eOmPjfLG2QzffLwM/L
 VF/gcUoC4H6jLAzNm90UcLUcD2nQF7A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-NnxYWqOFPRCTEbUfZYZsqQ-1; Tue,
 25 Aug 2026 15:10:11 -0400
X-MC-Unique: NnxYWqOFPRCTEbUfZYZsqQ-1
X-Mimecast-MFC-AGG-ID: NnxYWqOFPRCTEbUfZYZsqQ_1787685009
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7342F19539AF; Tue, 25 Aug 2026 19:10:08 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BAB41801AFF; Tue, 25 Aug 2026 19:10:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:08 +0400
Subject: [PATCH v4 01/49] build-sys: introduce CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-1-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BjQzrX96/2TCRCuhB8WDOKZUyWrHd7nZfvI+I+3Z/8s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiG/57rymXIzpActMZ//RgbcduN3xi+wVNoi
 5hJHjNvYniJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohgAKCRDa6OEJdZac
 5cMbD/4i+QZ+VwkFYfMVU42f44O5IMII9TdDfmQ19KuKwjnM1k6jHtsfSErbPIj1jMcKemHWG4R
 1pqEXRfzCGZJHyLC1wM7qu2Mx3CHiSMLpoql5HVYTQrpe/iDN2IEPC3bkGUnJdRpkPdsryXwlzx
 ZacDgsHG3RV+sur+AI/EkzQQBryykTT22631tY5H3e/bs7/hfOFpQyUJxZZCX3G0cU+c0SfCN7e
 jyT23MEBkx2o8uLihe10605g/ok/aMOothqQh6vpZtaJE/nCuZSjrLwzSK3upaM235SHpGLyghZ
 Klvh3qIpt2HxKeJAafvBGOj39X/V0+JgumO6hXvMonmMPA1YmfeD3R4drqBb4KYDDiHihZipftX
 ypgmxYAQ7QubsCTe524kWVHXzxxLFQtLiFg8+FlOHfakxfUV0XOp1N2f0i3zUbuvriqA03/l2xe
 D3l3lH6ah4o4/6dlCO/XLkx872+z7Vjtzgn86TPvyQ5k4paOArgaDFUJqGk3KpS3A020oYUxD8D
 ViZrqVh448T8KSD5iWNk6Bi2GDIEd8rOFnBvKKEJNg4+5qG/obPyg2aIQiOm+25lBv31hEy2t12
 pfJZQ5GYhlZie90qjQVzSXhIcQE8NFfGbnpDiQCdXCZV1SZ6WU0YhRnh9DHp5x6xdKqQJgeeYF8
 DAOTBpczK5iQ5aw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


