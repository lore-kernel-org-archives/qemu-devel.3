Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A87C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHjd-0002ef-45; Tue, 18 Aug 2026 07:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHjb-0002eF-LE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHja-0004n2-AQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sRnXKZYrzbjyn4A8hYpuDdRC4OzW1AM3O5ymYNZ3gBk=;
 b=UtFGM3ebgyeZzib9QLvse7GzuaAUPa6Di5YTLaJGfsbuV7BcTZfZ9OiBvBYKJvorTuHGtb
 43k1sqxfmhIVtxJly4+bz6SqNu38g9aOQXwkKOEfNfhiRp6S0eOLMeWkueCcfjTmHZ4nJC
 G0iPEG0GWdpkhkqxKvwLgjWNPiiDphY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Bb8Oy5bKNLuFafGtK9hbjA-1; Tue,
 18 Aug 2026 07:11:56 -0400
X-MC-Unique: Bb8Oy5bKNLuFafGtK9hbjA-1
X-Mimecast-MFC-AGG-ID: Bb8Oy5bKNLuFafGtK9hbjA_1787051515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7FBD19560A6; Tue, 18 Aug 2026 11:11:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 768371953944; Tue, 18 Aug 2026 11:11:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:29 +0400
Subject: [PATCH v3 02/74] qapi/gen: fix _module_basename for multi-dash
 'what' parameters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-2-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8qQ5+NhKhFTbUvRZ8NDUWUg42L5+gNHRkxrEPEB9zC8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD22HbhnBVzaGd/FMcWR/BJIbg8HkZ3hAE6e9
 yGONcSC2giJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9tgAKCRDa6OEJdZac
 5SL2EACAElf0Jc8QdNyiPOJT597wCTgUwP3Zz+iOLITBgszVk7sd2v2B+urYFdeONoWdItIlzE7
 5w/u9SDR/+Z1GPa07RxmaJeIVvf6KF0rUZ8CBGKvf53XcKdbFFGU0DwCWP3r5eSJ/9pBjY7Xv1z
 2dvjkIzRIQw5xEkNQnACFcVfyZsSVxZ+BZgfjzqYc4TmGGZ9gf8KOsZd1chYlS8PWv3wrUUTwK/
 qzIzHQSSWZLGCVYCXo2GPcTckz2de3WC081SbUESUG2TN40KhDuh7HJkqH+axWsmrMuUmA2fHkB
 EBvgTHrb24vsmavSLGIcEWGXhROfePZpt5Ll+VFj7UbW8U57YrYS40GhzjhO0HVNmU0MBcfa/GD
 ZR/Y/0JVACmo1h5TbY+2dkMFD0EMXsb8K+XT6eNaIsSI+PPut6IlkWTQLTYCO6sBroucpDa2y52
 9Oio1EYjwrwbn48WqiBIoVhp7M5M+CgSZFBcB3qCh6zdbBBq4NXXniWtGVfydOfGLGaOXdWE+5y
 ACnpxgfeXorgin7h5bJyvvtHUK5GeSrrwyZfcUdrWZtGGq52ROSn5h96WKaoTsiOTls34UXc/m9
 ZUu4eK8AWVLv2uy8a5Ph4rxgDKRO+pou4oua36MRuRYPioV2Bc/Zr5cYWhSFN+zzA/VcgvpLvLx
 ADGanScd+9CulHw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The re.sub() call replaces every hyphen in 'what' with the system module
infix. This produces broken filenames for multi-hyphen names (e.g.
'qapi-type-infos' becomes 'qapi-builtin-type-builtin-infos').

Add count=1 so only the first hyphen is replaced.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/gen.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 0c9b8db3b024..690187d4280d 100644
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
2.55.0.543.g5ebe2ebe4ea8


