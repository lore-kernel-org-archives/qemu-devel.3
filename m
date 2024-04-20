Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055ECC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 05:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ry3YQ-00033H-2u; Sat, 20 Apr 2024 01:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ry3YK-00031S-RR
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ry3YJ-0007HF-4V
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 01:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713591978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMWUQ3sACt7zOgNPCN2ljNdKhKO9rowCkaSFETC5Nb8=;
 b=WUgPrhVHkevfx76W09/R1RSDyarAfEDZZkySs18+sEym6y1jrzAp7Tlztx5QxoRSiDoHJq
 oQu8A+ywwvSz9Vsue2ZFQ9ehcUGpmQM9aRFqniTTN/t+LDoRyT0H8a+b7BJXPl41cs4fFA
 lGkyPNFGZlM/xaxkl+WOrulF+s60guU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-uCOIWAVkMEOZuYWDyslapQ-1; Sat, 20 Apr 2024 01:46:16 -0400
X-MC-Unique: uCOIWAVkMEOZuYWDyslapQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3C038884A6;
 Sat, 20 Apr 2024 05:46:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFA0E400F12;
 Sat, 20 Apr 2024 05:46:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
Subject: [PATCH 2/3] target/s390x/cpu_models: Rework the output of "-cpu help"
Date: Sat, 20 Apr 2024 07:46:05 +0200
Message-ID: <20240420054606.13353-3-thuth@redhat.com>
In-Reply-To: <20240420054606.13353-1-thuth@redhat.com>
References: <20240420054606.13353-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Printing an "s390x" in front of each CPU name is not helpful at all:
It is confusing for the users since they don't know whether they
have to specify these letters for the "-cpu" parameter, too, and
it also takes some precious space in the dense output of the CPU
entries. Let's simply remove this now!

While we're at it, use two spaces at the beginning of the lines for
the indentation of the entries, and add a "Available CPUs" in the
very first line, like most other target architectures are doing it
for their "-cpu help" output already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8ed3bb6a27..58c58f05a0 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -355,9 +355,9 @@ static void s390_print_cpu_model_list_entry(gpointer data, gpointer user_data)
     /* strip off the -s390x-cpu */
     g_strrstr(name, "-" TYPE_S390_CPU)[0] = 0;
     if (details->len) {
-        qemu_printf("s390 %-15s %-35s (%s)\n", name, scc->desc, details->str);
+        qemu_printf("  %-15s %-35s (%s)\n", name, scc->desc, details->str);
     } else {
-        qemu_printf("s390 %-15s %-35s\n", name, scc->desc);
+        qemu_printf("  %-15s %-35s\n", name, scc->desc);
     }
     g_free(name);
 }
@@ -402,6 +402,7 @@ void s390_cpu_list(void)
     S390Feat feat;
     GSList *list;
 
+    qemu_printf("Available CPUs:\n");
     list = object_class_get_list(TYPE_S390_CPU, false);
     list = g_slist_sort(list, s390_cpu_list_compare);
     g_slist_foreach(list, s390_print_cpu_model_list_entry, NULL);
@@ -411,14 +412,14 @@ void s390_cpu_list(void)
     for (feat = 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def = s390_feat_def(feat);
 
-        qemu_printf("%-20s %s\n", def->name, def->desc);
+        qemu_printf("  %-20s %s\n", def->name, def->desc);
     }
 
     qemu_printf("\nRecognized feature groups:\n");
     for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def = s390_feat_group_def(group);
 
-        qemu_printf("%-20s %s\n", def->name, def->desc);
+        qemu_printf("  %-20s %s\n", def->name, def->desc);
     }
 }
 
-- 
2.44.0


