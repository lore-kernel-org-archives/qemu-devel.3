Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A22CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorP-0008IW-Vt; Wed, 20 May 2026 17:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqt-0007hf-Ql
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqs-0004zg-EG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBlj5f3wT4E4oR9tV3iE2UTgqMEBYhz+fMm03flQA0M=;
 b=RNB0qMq+YQ1wfg16fIKss8oXEodjuezn9oePcFNgOoooUCkBuWXnx5CNQZPXAGkQTNx7Kr
 7dM+msDQ9y/9R62uYP6E77BqGqxJOdSjXxjtOBHgL8w86F1YedEOThCUo40TSwcsg6TEf4
 TpD7aNHk4cGCTiGFbRYltzGtM3RKFlM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-1ATqXtd1MLe0_v1WX2Pneg-1; Wed,
 20 May 2026 17:53:16 -0400
X-MC-Unique: 1ATqXtd1MLe0_v1WX2Pneg-1
X-Mimecast-MFC-AGG-ID: 1ATqXtd1MLe0_v1WX2Pneg_1779313995
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 480D11956080
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:15 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9BB71956053; Wed, 20 May 2026 21:53:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:33 +0400
Subject: [PATCH 32/40] qapi: make HMP-specific schema entries conditional
 on CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-32-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YSxNCm8GyYz8MbWnmE5OfmTVRR1y3lVfgK99MtZ/ZCE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyE0BeexYWo+Hxsou2K0KsUXxLACioSXcUHk
 zk+L7h61IuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5ffoEACv2mj8xirn5uTzC7l7A6Vot3LEi3FldBaiAu8C7y+GPKm/bELI750sX7Riomjf+1RG6kf
 MW5mUh2EAx4lf9sTDYvPUpwtBjc9HRid/LfoVeozgRF8FF0CCesE9KQY9VfD1Vzedp6Ni8Rcwiy
 D3XIh6DTpvxx4YyAiJAdQJF0uP0ejURcZWTy7awhg4vhG3ZPH0CPVxKO2g4ztBO6lXcSnpnAe0N
 dpcf05083cI4nRcbsvz5vGJtfPv+0znhkJxNtL5pXrNNc0IbMXpaEs5hFDnalRxWiXkGWcOMS6f
 EqnH7EJDG3bQmSPanslyUmdjnPapM3xC/dXmSIixSQ3S9960szYlasEdnZv6kKF45XqPn0L5OhF
 5C0buCImI2Ikv9jDOwC6kr/sSC3PTypsw9Gzb/CuVvpIhmI3hdatEVf3Dh3yJa6hpebJsjasGsG
 RO6upCJ6GVbtq7izRbiuYt0wM+VOLDV61lAShNdwXW4ilrJBsWluIZOjtA9jjsIPpyjfko1XTwr
 OCF4tZzHC8dTAqD2W18pMfMQdKGatJcZh5oyicMK+FMwGtqB2NhhdB27rFcmIfSkv8vXLfh4UvJ
 hdAcHChOLh30cZkHSbB6OX7IMzUPDb6xFLDd71Ya2VPNipqKzMeLVD0C5iWzk178kwWGD5XguD1
 N5zuYCry9aaSwSQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Make the 'readline' value of MonitorMode and the
'human-monitor-command' command conditional on CONFIG_HMP, so
they are only available when HMP support is compiled in.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/control.json | 4 +++-
 qapi/misc.json    | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/qapi/control.json b/qapi/control.json
index 9a5302193d6..9898552814b 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -186,7 +186,9 @@
 #
 # Since: 5.0
 ##
-{ 'enum': 'MonitorMode', 'data': [ 'readline', 'control' ] }
+{ 'enum': 'MonitorMode', 'data': [
+    { 'name': 'readline', 'if': 'CONFIG_HMP' },
+    'control' ] }
 
 ##
 # @MonitorOptions:
diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f6..a21ba61b96e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -247,7 +247,8 @@
 { 'command': 'human-monitor-command',
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str',
-  'features': [ 'savevm-monitor-nodes' ] }
+  'features': [ 'savevm-monitor-nodes' ],
+  'if': 'CONFIG_HMP' }
 
 ##
 # @getfd:

-- 
2.54.0


