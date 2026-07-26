Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD58C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5ii-0008CU-75; Sun, 26 Jul 2026 16:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5ig-0008Bd-SI
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5if-0004O8-E5
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+FFIp2SBJj7/UmITR6GElKqfeokWCJ3beC16SLLIWMY=;
 b=d9eUFR7cxRmwYZbxxVIBUHFWhWeIwQ4LIBbLel9oXgyWYbHz9wj2YXjtGFpSs0QU8C5iCp
 rg+zGjSlCHaODJe7M4i8MvHCQ6vqO3W9JfnwmlrnzLWFYBdWPeEMUcnODhTs0eGX/kQyKb
 l1bS40IFncIuqhQSu6XjqkdHzsqjqdY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-SXfvALBEOgO8GzBQWRvcbg-1; Sun,
 26 Jul 2026 16:45:05 -0400
X-MC-Unique: SXfvALBEOgO8GzBQWRvcbg-1
X-Mimecast-MFC-AGG-ID: SXfvALBEOgO8GzBQWRvcbg_1785098703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 939971955F01; Sun, 26 Jul 2026 20:45:02 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8B77419560AB; Sun, 26 Jul 2026 20:45:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:06 +0400
Subject: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1803;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3UnWZex6baDzxFVuUrTLJxfd3oiqd2OltWOdP/euIvM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXzJ0ABEJmKJsuXsfXQAGERWo8tNNTFGByc
 JHhjqKvqcOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5SpYEACJH1ameo9+zi+gvE2TYQV/5Rnkbi+pq0DNMvr3n2gHRm9HYCvTbYghyNbND/7wzjF8bVw
 d4CylRj13bri14R7cvmOKxT4AiRWNOPo7DBUmTZByXdxHd1iLYgPpMRuzNirJSu1YeKnsYBpV4k
 ZB32b3FlbOzQxaBXiClHdDZ1pqoLYb3YVoAtvT/S6umIxEzYVVhw9OBzm5K0+JZVTkl+Ny6yJY+
 S92cvphIO3im9VMutVJpnRHGA9uAGXZXwprk1efpQEWfGZsSnM6YTZuk6Y/nWDDC6RL4KQEGPFR
 jDu6MNA2KwQDDyQ5IwJRGVxqnbUdJA7/UCCiRzrIWRaa4NpH/l+Zv6MCXrXSoFBh8LbciBh5MeI
 KmBw0QDxK69trDgPpaqxi0Azuv3Qu9TbOzfFf6U7zKzo+3tr4QKXhMC+3yLNM1aukxVH2HK1N6U
 yOLZxZxNPvFonjx91Be1KiWJUG86iV6CouCeuWNlxwc//3hSixcLvYGfVMQHC620mWGbl/kQ+ib
 zu55xP0PR7oFVKAkrSSn+lL2U+nEzIEUHAXYCxnNnkagGoT1yV6+8NImV2Bx5KZTPAX1pylJDmz
 PIW5kkYMr2NumoNyF57sJFjLlhpF3Cy0l86nFJ/Ulk65JNnnsEIYNgUqckUJjjhtuh5vv0OADJm
 +zpaTFFRkp7JHSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When compiled with -Og, gcc produces many false-positives
gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).

We already use auto-var-init=zero, but better be explicit.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c             | 3 ++-
 target/i386/emulate/x86_mmu.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5805d33ab92d..28e4435df23f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
 static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
                                          Error **errp)
 {
-    const AVX10VersionDefinition *def;
+    const AVX10VersionDefinition *def = NULL;
     CPUX86State *env = &cpu->env;
 
     if (!version) {
@@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
             break;
         }
     }
+    assert(def != NULL);
 
     if (def->version < version) {
         error_setg(errp, "avx10-version can be at most %d", def->version);
diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
index 8d4371467fd7..65bcccd4751e 100644
--- a/target/i386/emulate/x86_mmu.c
+++ b/target/i386/emulate/x86_mmu.c
@@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
     int largeness = 0;
     target_ulong cr3 = x86_read_cr(cpu, 3);
     uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
-    MMUTranslateResult res;
-    
+    MMUTranslateResult res = MMU_TRANSLATE_PAGE_NOT_MAPPED;
+
     memset(pt, 0, sizeof(*pt));
     top_level = gpt_top_level(cpu, pae);
 

-- 
2.55.0


