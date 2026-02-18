Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FC5E9A04D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 11:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsfzF-0005dX-IJ; Wed, 18 Feb 2026 06:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfz1-0004Vy-2r
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsfyp-0000DB-Th
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 06:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771415071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNOtE9iAdY/fz5zXRGOHALzxPR6yavv/SKATwTTFh+E=;
 b=TCM4Qtmw8H71yZo/+9Ch7r4JuaD6noICSCOb2PmrLNoKpkRYuOvKvE7Q+SLH4ARLb5jD8x
 9wq8tTUjma3fH2Q5uwV6mOaAwenakUFOL66AkIM5Yo0yFcJdtfNzYd0c/HiaMrWim5iY2l
 8ANJCOkDMb+KBLGR7yGaAcUdyEieULk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-dfzRB1vKNK6m7qjMrTbauw-1; Wed, 18 Feb 2026 06:44:29 -0500
X-MC-Unique: dfzRB1vKNK6m7qjMrTbauw-1
X-Mimecast-MFC-AGG-ID: dfzRB1vKNK6m7qjMrTbauw_1771415069
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2a7a98ba326so11896075ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 03:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771415069; x=1772019869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNOtE9iAdY/fz5zXRGOHALzxPR6yavv/SKATwTTFh+E=;
 b=LcZV4Gonm2W7NipZXPj/nC8KuJ+2U+8hqIWT+qBmm5T/bs25PKNXnP/gmwKB4fQpO4
 Ijl1C4opcLc5DD+1PGwogedPqqelgjLPMWZpnWE0pXVac9KUSfUl2RkUEhsjda+Zavpu
 arzfufpFQXLMp9cOiB0NgJlWpoTwWmR4JlcjwPL1ZJ3Op1FWbqP5WDj0Hd6NywvU6zlE
 EnwyJxAG9TnapB+ZycxnJ2clMKogs7oazyRuN29v8OcGDtVutv8OYoWgkd2UgGuB1G+x
 5YSlCR3pnAdKlj/n281hKsgfKsflp8GxUCnuej5TMMa1JgrAVEXJN00+BOnuy9WPSumY
 nAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771415069; x=1772019869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wNOtE9iAdY/fz5zXRGOHALzxPR6yavv/SKATwTTFh+E=;
 b=ARJPYsdY0Ve5cifAmtdz+NyNruE1CEmI1DGTPn7eHFpZTQWZ/9AWaeySDtdDqL6OQd
 jays+Vsuwwf2yC8N2qGF6kOU1J1kOdv8k5AJ8wToC7mvGGP3u2gY0wHL6E/RkjeaQ6eR
 dyAWGaVGSsZqkcYsLVpC3V+aDJWcGrXcbHnoP6UkB9ql0qAVCrJpVLM5ABbOvdZ6A0tc
 e3GxnAfUhRP9TOsBK0RRpwhUpS3LHSSGZBFWFxCLzMm57ephv9UW0Wwrdv4qQPAKjeUs
 NXvhHPm9pBiQvkV9LBHDLQmX7KXR7vAJjx8JCzQVK0p8aLJls1S3sAtORaFhXXOs/LDf
 0bBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBjKONs6684XjQVVJqQXgJm4CrbBNEHKP5dBV0ZmKf+uMmWarfA01p7cjd95o6iTdWNS46g6gLMWKo@nongnu.org
X-Gm-Message-State: AOJu0YySOUFU1xSaDIGlq60FlY35rS1Ugv8uDVAohyy9wwcic2l0Iq6h
 CdSGPl18kZMK0A5r0sPIQ/k7y9kwjIU2J/r2SvT4G/ENXHlU30g+Ycbo+OCoA6rdi/h9PHnlWlV
 7ETkZH+C/zvLCFcIZTr5oHmZqyhIG0XpOrTfrocunstHNVDqOvUyZCICU
X-Gm-Gg: AZuq6aK1HmbZnsws4AxRQVns8F68lUdNrRfOnn5WbQ7IjitVvgjCR+5lKKRmWIdI41g
 LYvHHJxtU7nwuC3rinrhueMeeYtTA+34LM2r8S4VJXjDlvK7TwYk3ZAzqTYO+nRYsC6TOCIg8jz
 e2fXkFTKMcgFMn5VqwYRCVawmQ8OcuqQY+F4B4OuZnOVkfNWupryjjSRaeJnEWJUbnxgQQ33s/+
 J8y1TrzTy96rGNK5Vlq2M50TqWdiJ1Y3+rYTVxMrFTsSznMCd0SQAnhrtZLwf3cDcpf9Hi9EJCy
 JN+5YhzeCnfqvEsoykv7P7+5LtDXYan8fsUYH6e0MDB7dfeJ+GTUB4ve0k4gHtbeksBOjvgSIiA
 JhhaZGFobM/cYJr7Uxz4JBmUul13v0gmYNJlnqM/d1xEey6NrPPKg
X-Received: by 2002:a17:902:ef03:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-2ad50bbdcdcmr14727675ad.13.1771415068725; 
 Wed, 18 Feb 2026 03:44:28 -0800 (PST)
X-Received: by 2002:a17:902:ef03:b0:294:f6e5:b91a with SMTP id
 d9443c01a7336-2ad50bbdcdcmr14727525ad.13.1771415068359; 
 Wed, 18 Feb 2026 03:44:28 -0800 (PST)
Received: from rhel9-box.lan ([117.99.83.54])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ad1aaeab38sm127803425ad.82.2026.02.18.03.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 03:44:28 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 33/34] qom: add 'confidential-guest-reset' property for x86
 confidential vms
Date: Wed, 18 Feb 2026 17:12:26 +0530
Message-ID: <20260218114233.266178-34-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260218114233.266178-1-anisinha@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Through the new 'confidential-guest-reset' property, control plane should be
able to detect if the hypervisor supports x86 confidential guest resets. Older
hypervisors that do not support resets will not have this property populated.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 qapi/qom.json | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 6f5c9de0f0..c653248f85 100644
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
2.42.0


