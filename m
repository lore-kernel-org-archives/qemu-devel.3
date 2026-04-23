Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F6CFDEE44
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyqq-0003dU-8R; Thu, 23 Apr 2026 14:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqj-0003cW-Dh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqh-0001KY-2p
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776969146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4TOxFz2OPjQ/+oQDmc3kby3Xa/zYowkiRjWGoIPwB0=;
 b=aT8O5QItOrQg96kILQZ91bZ6F/EhYCdkB8sw8As4UyX64nTizdNf4P/0sXCMEsZP5fAkH6
 DzG8BFCzzgH9JrizBs1X1vhuWHIMhRhqZXPBJjp5T+HyL4vaF5OweXgXtBWjWL92hiMw4M
 qZW2W6NJ5qBNQ6ZcVfoa4PzsYV/5H5E=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-dP2DTSY1P128HbBspiyExg-1; Thu, 23 Apr 2026 14:32:24 -0400
X-MC-Unique: dP2DTSY1P128HbBspiyExg-1
X-Mimecast-MFC-AGG-ID: dP2DTSY1P128HbBspiyExg_1776969144
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a275472d89so106458876d6.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776969144; x=1777573944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4TOxFz2OPjQ/+oQDmc3kby3Xa/zYowkiRjWGoIPwB0=;
 b=Df92nuZ1fhwCHxzub0eWHTF/6sYYOi1eztP7I3zApvmEOg906erANy51grSsr69Sca
 P9DIHGyC9rndyzKMH4KMSlrQbkVtElovtRQks5m0I7qDJRnD+/VkVfXFLjwgFi40nI2D
 ym0z5cGjOqlGEWoVDTj2fKUBnIBoUe7FrzGhI1KB1yzX2EQhNbrXNwH786G+dzaVWhVv
 10/mM9sKG6OpJiQtEhEcc29hAjsGhizYT1VqPagvT13TGWorByurjoANws9tD7O5YZq3
 s9jH6/evaXz3wXLzTn2BrfSY8RyV/KLvHCzMWvZYh4KADEdhEuaKDyWJvBsY8GCslsJb
 BWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969144; x=1777573944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O4TOxFz2OPjQ/+oQDmc3kby3Xa/zYowkiRjWGoIPwB0=;
 b=Akh1adFZCLZOi91wKSPWTa+xhPcYsEPnNbtaE2qPeaoXdFHHUgke9AjJaQns6ma/wv
 Li7KmuUUwm11zmaGsSbaQHUfFeMHTo6gr05T9lXFEKBDKS0Opr169c9uEG6LmYhPADiO
 mWMLRR3A+w4IC4wXmBWzXC/AyF9q+w5bGlBGfCoNmChBYrpT/ns9uea7c4rR3Zcxm4Ia
 CoiSdf6KRSENyUaSHLDG8ny9ROReLoSNUL3BuZC0So6MnOLKK+HorcAs/dBRqMGSUQpd
 4rThjDrl3x2q4vDvwbecIPgc0ePN1Zg3BDhlm6OykfjSRYfL8vvqheeIbxTRD5N5mcRA
 xKFg==
X-Gm-Message-State: AOJu0YwG7a2L5udvEQJrvR0uwJBRctxxaPaDiHICcN2krxC0710fx3CB
 fHJS+l2yuyWlb9HwRCJiz8mpdkAV3cUzB/Ybdcn5st240oSKpYKFkUOWj4LDYqoP7em+b3Nt0FQ
 I5yy/tPhLyAwl+/V9L5dSdeWGbk/DGG6Evm5LphLB7Feu68IWPKbMvz6dZHelRyChh1W0k6EPCT
 mO1eYKCLUuk57IBScb1e7qIQvm9m6cNOPY2ftlFQ==
X-Gm-Gg: AeBDieuPlyOYortTIB0FyYhLC+s1IdXbSfhsmTSHGTHYt8v+j4AVa8GupWnAj7T8SZV
 hC3vE42SiWXpmBrR+xHEm9MVQaP4Fpcg38sYPcdleqaTV0pXQCu5oQTcfpGIuza3N+Y4Px6/hU3
 WVhAWjXpXWh5+9bdiDsbaKfmthGzdL3unQrIno7eRel/x/uLgba7saOy4ys6FhEordoC6EPyfzI
 TfECbqs0GFweB1enEvol0yFUUaRAiFB+doWZEAxIp8ZlzBGPeWmzcnZXYEFsAaY6y8OxS/eDbhH
 lJtonbP2SaNOXEoCFIM8+j0tZQYb7W7AFGi/cocaZpLm8d8jFfoTz70h2m7o5uXDl6oVvL6GVHg
 oE2SB5l/Rq+TX9DzgD8feQJXU34crQKJtDn8ZRgyNBs7TG2DXVx9rG2g=
X-Received: by 2002:a05:6214:27ef:b0:8a6:1216:fb78 with SMTP id
 6a1803df08f44-8b02815a617mr443043396d6.46.1776969143589; 
 Thu, 23 Apr 2026 11:32:23 -0700 (PDT)
X-Received: by 2002:a05:6214:27ef:b0:8a6:1216:fb78 with SMTP id
 6a1803df08f44-8b02815a617mr443042586d6.46.1776969142872; 
 Thu, 23 Apr 2026 11:32:22 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae92fc8sm160665566d6.40.2026.04.23.11.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:32:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/3] system/ioport: Fix qom-list-properties crash on portio
 list obj
Date: Thu, 23 Apr 2026 14:32:11 -0400
Message-ID: <20260423183212.468047-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423183212.468047-1-peterx@redhat.com>
References: <20260423183212.468047-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Currently qom-list-properties QMP command will crash when querying the
portio list MR object.  It's because its finalize() assumes full
initialization done in portio_list_add_1().

Provide a simple fix for now to avoid the crash.  There is chance for a
longer term fix, ideally MR should be initialized in instance_init().

However that'll need more work, and that should also be done with cleaning
the hard-coded MR operations in portio_list_add_1().  To be explored.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Link: https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org
Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/ioport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/system/ioport.c b/system/ioport.c
index 9209bff2ea..1a0e01fd06 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -346,8 +346,15 @@ static void memory_region_portio_list_finalize(Object *obj)
 {
     MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
 
-    object_unref(&mrpio->mr);
-    g_free(mrpio->ports);
+    /*
+     * This check makes sure any random object_new() (without doing the
+     * rest inits in portio_list_add_1()) will not crash when finalizing.
+     * One example is QMP command qom-list-properties.
+     */
+    if (mrpio->ports) {
+        object_unref(&mrpio->mr);
+        g_free(mrpio->ports);
+    }
 }
 
 static const TypeInfo memory_region_portio_list_info = {
-- 
2.53.0


