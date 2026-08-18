Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB46EC5DF70
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHrf-0006Su-EE; Tue, 18 Aug 2026 07:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrd-0006Nj-5a
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHrb-0006hh-QN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787052015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeRCGmLRaLKDeH+pxowsENnVfHdji1qJ2jHp+Q9raIk=;
 b=CYUPM5xAazB3dDAVtU9eTXGf94UJcSQsvL3FBdlZW7zDzXJPVfTe/XRM6d7s90fomGT/Pl
 LeGuUgSBTUe73W6lWsf/7gzDYzysEvgpa16BbtZLBRTaMmPK6m8Xs2KGlRn0IAVSTy1U6P
 ss58snT5ZI2WoaWwAkSlBfw9lJ48Ea0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-p9xpunObMz-G2Hn4M_G40Q-1; Tue,
 18 Aug 2026 07:20:03 -0400
X-MC-Unique: p9xpunObMz-G2Hn4M_G40Q-1
X-Mimecast-MFC-AGG-ID: p9xpunObMz-G2Hn4M_G40Q_1787052002
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B6E7180049D; Tue, 18 Aug 2026 11:20:02 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CDCD1956042; Tue, 18 Aug 2026 11:19:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:57 +0400
Subject: [PATCH v3 30/74] system/memory: fix "priority" property typename
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-30-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mI2IUxmCqF4Ty2FSFGECDQoj8Lj8y7mQsMNWDLxQYuk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD2540DO57Mpjuj5UDbwpmwJGgctHxkop4VnA
 UTgRPr7ZjKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9uQAKCRDa6OEJdZac
 5eaiD/9/AJ1KWHseMwQ6hX00FHhOu5bFtPsY9dqxDkrZzjvrHyzz+KRqezVHpXUWgth3dFNgKhO
 haMoA1ZvPdWI8nIjMN2WORFuiebCtf9ryVBtoULLPGVFInBPht6KgXh11kRVR9yYg9IGX6tGkjM
 BP/gF0whWx5ULVqGWU72+GyfS0ZCZV/tWh5ttLmzgISrA56ih1g2bPjiCInUe2TSp4ru4xPs2cq
 2Ih3LK5otg/LI8uhAIjN2mBG9dLXsoIegafLhoGoloRNs0t25oA0+5/slHWN8RAgnzMhnh2B6+n
 z7IsQ/+JCJpEjbrR/SFUueOYleVe27zVWvYeaV+itowzpobjETgAuucbNt8989ZBwz6DDoviHGY
 /1nZ+ytWx6pJ8sHDSLzlgNKNhG0yui+ypXXt/ZlOihTDFtV/++AFmIxFYAh1VAEzp+JB0OUkIMy
 rzyo5vhWFhf5oLznpkJ4Kynng/E5GM3zmcTIXGGihCuClk3SGnvMHevbzkHkg0VgPgp8t3taow1
 WaZ5j2ppLf+LFi38ljj5vGPqHzN4UjR01ICbg2by3MfYSwq1FiA/j5na8MiHM0qmQ+OvmsuF8Im
 O+EpiPBmdbzmbFdPxsBCoyinYVi16Zdty8djCEgAVoaEu6JkRu+wNfdZc3+rbseCFf3SITecoc8
 VQnOz2CuZ4msvFA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

The value and the getter are int32.

Fixes: d33382da9ab ("memory: MemoryRegion: Add may-overlap and priority props")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/memory.c b/system/memory.c
index da710bbade1b..164c18757f8f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1318,7 +1318,7 @@ static void memory_region_initfn(Object *obj)
 
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
                                    &mr->addr, OBJ_PROP_FLAG_READ);
-    object_property_add(OBJECT(mr), "priority", "uint32",
+    object_property_add(OBJECT(mr), "priority", "int32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
                         NULL, NULL);

-- 
2.55.0.543.g5ebe2ebe4ea8


