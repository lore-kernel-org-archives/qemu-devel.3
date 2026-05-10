Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70499CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4ST-0008OQ-FO; Sun, 10 May 2026 09:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4SR-0008Es-FT
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4SP-0004T2-S9
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnu/XDNhZBPnevIcXIp/sF0jXfGvDvpqUjDIedb8ZgM=;
 b=Xs7a35ksTZd1cH7oqso25ClBUvyVyht/z5U+xRtNoqPF8KDpZafdqL22Bt2Lqi7aZr8o3C
 DimaurCUZXxZA/PJZj3kHcREQS/TZ2U5/ZB/czcMozTwWXVMYe4k0c9d344669DLvOS7DE
 oewFuytpvVL1LHFxS/zcGJRglg+HLXA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-A508j30APj6_2y56KL7N0A-1; Sun,
 10 May 2026 09:44:31 -0400
X-MC-Unique: A508j30APj6_2y56KL7N0A-1
X-Mimecast-MFC-AGG-ID: A508j30APj6_2y56KL7N0A_1778420670
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A9B319560AA
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:44:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34B0C1803A92; Sun, 10 May 2026 13:44:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:02 +0400
Subject: [PATCH 05/54] qapi/gen: fix _module_basename for multi-dash 'what'
 parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-5-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=S2BoGZEFYq/GkpuRjSxq1QDOG+49zZ+uxEpclFTvRGc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItuaBSXA59ZonjJXldk/1dlC6F3JfXoqvJWs
 2XcpXFaqa6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5SkCEACgKMlHa58x55VYxWOphtE+XemYZ5JPOpvydCHpAYQ0MpB1j5AflQluGlOLkqQZbdRb9kW
 yXxabjpAfiC0/UyoUbahJXgo0FMClQfiRn4rWUqog8cix/OG7nok1BMxcr9Td0nXI//+uTwl9zQ
 B+WPYP6tdCRxktt9PaKlgt5xmTvZGZj4C7OnXC7mvCFiMvgjDitXnEBhuH2SmyY4tJiOUF70Zji
 gdVcxpNOta5tSsnwzmVDLm8PFI4V5FFmkaNvx7qH+GeD4MEquf3gHYSw5MQvixuNEgqIcf9bINj
 TB9Lb+VsT3lVBxmfLki40UDZrHID9b/TGlHbg3SivtqjcyT3CverQDab3n3YEVBEfKj6Al5FAcJ
 DthfG6Jv7gVWpHuaL7K5Yq8VpGCpH252lDBDpYyOy+gtFwQ9jp36R+T6cFUeIkdwDcP5eUdwzM8
 0hBj92RdlttzU/2J8lSSFaXbPKRbl4MbTjZQ1pMWyi95nyH+ZP0P+8ZVz/C4au71o7CS7a3qx9T
 IPDLGxe88OJsejY+R1aeWorpkQxTmBMtK7a1A8yWY4gRavclhiU6Gu4cTcE9CTV8K6J6vMs5w5K
 1yxq0J3e6w8DblOMTQlzCQW/0Ow2gM6z0aDvMtG1JyO5Ybi0j2taRLC16bmH5dTdhg7E58brqfG
 Yo8lOWvgLf9iRSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The re.sub() call replaces every hyphen in 'what' with the system module
infix. This produces broken filenames for multi-hyphen names (e.g.
'qapi-type-infos' becomes 'qapi-builtin-type-builtin-infos').

Add count=1 so only the first hyphen is replaced.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b02..690187d4280 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -300,7 +300,7 @@ def _module_basename(self, what: str, name: str) -> str:
                 ret += '-' + os.path.splitext(basename)[0]
         else:
             assert QAPISchemaModule.is_system_module(name)
-            ret += re.sub(r'-', '-' + name[2:] + '-', what)
+            ret += re.sub(r'-', '-' + name[2:] + '-', what, count=1)
         return ret
 
     def _module_filename(self, what: str, name: str) -> str:

-- 
2.54.0


