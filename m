Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9A9D58E7F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzC-0004mj-FH; Mon, 02 Mar 2026 03:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywp-00036d-P8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywo-0002Cf-2T
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cwmzy8ApbarQ0EKqSLibn6yOnXmpyRilOlMnlY+cVCY=;
 b=IBJZFb1bxHLNsBw556tghCYyiqf4RLt4CNgNofmovzrBgyDT2GCnKsLqUhrDtNOZIhCRk1
 SRrlSQcY1xoE1XsF8DAP7Z3e3Fpma+iBAH9AE97twtvjQeVFGFNhC5PnuB+xs06mAFMWoN
 lBeNl/CaioMR0pvVjliW68ktyUlciI8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-SrKTnsk4ONKQKABASD4XLQ-1; Mon, 02 Mar 2026 03:48:12 -0500
X-MC-Unique: SrKTnsk4ONKQKABASD4XLQ-1
X-Mimecast-MFC-AGG-ID: SrKTnsk4ONKQKABASD4XLQ_1772441291
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-483a24db6ecso51445985e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441290; x=1773046090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cwmzy8ApbarQ0EKqSLibn6yOnXmpyRilOlMnlY+cVCY=;
 b=EAXOH2p9XV3kl2jNkr+PSwAEu8+X0zrSWRSabwXjfUyj5CoCXDEntXTHen0MrtvUrB
 WxUWaS60lFPY7zEZ0Z5hKkjzE86rkw9Z10mwWLmuc5ICbQCQUCvPMz5ZsYXNDrbUdoXg
 W/Zh5UhBaAyL6maN3evXPZU0caT2991jdfUbyBlCejL+MwT0bhN8FYiWyg7vSZme1YMu
 lrdZERBT1GLlQhgFBz3NIkDj7QmlNj7siSvifhnFzqqLB4FQ3VsRIdd58+kwLdh5eCfS
 K4riWKzXlri0/MtvTtixLXH0Sk5X1iVdpfRku+ZKkxGKHZGik1oD7Ea9CZbu203G3KLh
 556w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441290; x=1773046090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cwmzy8ApbarQ0EKqSLibn6yOnXmpyRilOlMnlY+cVCY=;
 b=uLUD8DYY1BfW2YvJCwMgWAnL3ZTbz6RNcL/kud7vuZH2mqCBHPEReQWaM3j/T/bA7S
 EkOSejft2FtepSeObS5qCFaCZqcZqObIFxPKqFLDIpliOs/cet28b15GNfUycdAW+fPS
 uA5psXLZfVPwKiRykiSYWCEsfMeFJSUb8bwlk63FAcDEpI1TpTcqCkG8oXork3r6JSx8
 FLyD+sSvbyzJQ7dLxEp9yO8qsIkUR7eUc7yEnXGK0nTKWqUkvK4RMFH3W4oE2yxOF4cl
 005dz2uELIxQpx5PZUkIKnRIaiHqAaD3/gR1Agp7m7jm+GO0treIsU1WXUe5Oq68q3wO
 6eug==
X-Gm-Message-State: AOJu0YxhgSkG3rdVpn+S4b9kOyDEUErUpawDjTvkRLvdAsz0+MZmIswY
 fDIENvC94rAZvzWRIUYcXezyl6kr1Na7VSe65or6zGJN+fT+oqu5v5ve1hbm4ZKrGZguK8Z3CCv
 KyrhtsvU8hDwp/V5gC/qJdUt0j0kxxRgA903g5HTxCBR4QSwFxXnz83YQl+XneczWS/EHiCrJ5V
 YGDq8gDwShXqB/lnZkp/avttPBby5xspSZouP0cSpN
X-Gm-Gg: ATEYQzyLnhExVshyAneELlRjFSkrQgc9Peo+HFMk+imIpHwQPwiAehHCirKY+awO91Z
 6wyQkdL4M9yqEQBmxxMeq6vuQYgL1jHz/+taeIYxDKTBgj9GiA24CeX5U4x3Slj9yrBqPlLmJ+1
 N/tt5GJta1ruiRIEQ+p0Sf+CcqBK100WbbtYCvDCE/meEm7eYevNYbnbUbJZBcsXvomITY1FAYk
 +YWVvi0HwkmL3zsXVdkFuAnfD1GjSO9hI5TOXZC+PO8iQGSFVNga1LLsqrt2vJdUjzfLVuHaSJN
 g7l8StQoR0A9OYOWBBRbaMw+KJATIs4uM9B55YAmabczdLuy/1HWOuBHM0M8YRSAa3lFS/zUx5F
 szbN6nxbjmI38CHNDZCOqAoFK+2RGpU7I1SQUttGSfLitATi+da/K4gOM36penfywnIwdkGUV2j
 hLiSEDcX/ZaivCqdpw/A2Hb7+OZoc=
X-Received: by 2002:a05:600c:348a:b0:483:c12b:fe4b with SMTP id
 5b1f17b1804b1-483c9bc19e9mr196756505e9.9.1772441290339; 
 Mon, 02 Mar 2026 00:48:10 -0800 (PST)
X-Received: by 2002:a05:600c:348a:b0:483:c12b:fe4b with SMTP id
 5b1f17b1804b1-483c9bc19e9mr196755915e9.9.1772441289776; 
 Mon, 02 Mar 2026 00:48:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd765604sm343156315e9.15.2026.03.02.00.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 075/102] qom: add 'confidential-guest-reset' property for x86
 confidential vms
Date: Mon,  2 Mar 2026 09:47:21 +0100
Message-ID: <20260302084749.474955-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

Through the new 'confidential-guest-reset' property, control plane should be
able to detect if the hypervisor supports x86 confidential guest resets. Older
hypervisors that do not support resets will not have this property populated.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-35-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 6f5c9de0f0b..c653248f85d 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1009,13 +1009,19 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# Features:
+#
+# @confidential-guest-reset: If present, the hypervisor supports
+#     confidential guest resets (since 11.0).
+#
 # Since: 9.1
 ##
 { 'struct': 'SevCommonProperties',
   'data': { '*sev-device': 'str',
             '*cbitpos': 'uint32',
             'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool' } }
+            '*kernel-hashes': 'bool' },
+  'features': ['confidential-guest-reset']}
 
 ##
 # @SevGuestProperties:
@@ -1136,6 +1142,11 @@
 #     it, the guest will not be able to get a TD quote for
 #     attestation.
 #
+# Features:
+#
+# @confidential-guest-reset: If present, the hypervisor supports
+#     confidential guest resets (since 11.0).
+#
 # Since: 10.1
 ##
 { 'struct': 'TdxGuestProperties',
@@ -1144,7 +1155,8 @@
             '*mrconfigid': 'str',
             '*mrowner': 'str',
             '*mrownerconfig': 'str',
-            '*quote-generation-socket': 'SocketAddress' } }
+            '*quote-generation-socket': 'SocketAddress' },
+   'features': ['confidential-guest-reset']}
 
 ##
 # @ThreadContextProperties:
-- 
2.53.0


