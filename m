Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8924CCD343A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcd-0002Kb-3n; Mon, 04 May 2026 07:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbt-00012t-2T
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrbr-000132-Eb
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZjGVhYb4QZLufbxawDaTzTncLfnO3BZmIoFwaaoY5k=;
 b=J4RCXpdpAZ+SoLqcWwh4p186/9sTkRTr81BJNcpRcbcuhhCQGKnvbCycOe+BajE9gUSssQ
 Y358owUIfXeDij7F97rPkSXnJHBk/ceGOTDW9Pm5O74RtJKMhcEzKR1QfSdlcJ2Vy+wCHB
 Qv2JRU65O/HUhNEbQqdBu2XKmu+gaWA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-YTQjBe9qNzWIE5qtKCYItQ-1; Mon,
 04 May 2026 07:37:09 -0400
X-MC-Unique: YTQjBe9qNzWIE5qtKCYItQ-1
X-Mimecast-MFC-AGG-ID: YTQjBe9qNzWIE5qtKCYItQ_1777894628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A08E9195605E; Mon,  4 May 2026 11:37:08 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 953AD18001ED; Mon,  4 May 2026 11:37:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:08 +0400
Subject: [PATCH v2 20/46] hw/core/resetcontainer: free children array on
 finalization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-20-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=915;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ecp3xjUIPOFrGW3mQ6rq12qeT8hrpA6G57ukebTH0ew=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRsys3drwFThkmwqHtjXN8JdvOS0zp5hc5xj
 GD1+knW/DaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbAAKCRDa6OEJdZac
 5V4mD/9UlRMmm4YAug/ZYGAtC1pjCVCyUW0Wla6ZebxF6KPQH/vDNxicMdI9oO0G/PJEg69kVjo
 MiS7cUJVtmKvjV8wU4HG5b91SYQH3a6OHj0o5/vQ63Ewf8wL6CHhXky+BmFHLm6NwlexaitVtSY
 tumBOVxG3AvcjjR72XguN+eoS7MZmi4XdCM0Aw3hZW+t75Mjr9ucFACIq1PBpLJTkdIx0OkkdRE
 /Z4pJXHXNTDvnCEFF3DFDNj9ORyiFCeB5B7eaXTkBTKUbZEqYd5GwvapUe0h2hw/Ij5qkG759fp
 3wVYtN8c0hueZMMDod50IpKiZUE53pawUw8sGNauquAksiUF6cujHI6BLeJguozGa5pRh4OL2p5
 runJ7w7viZ5elBzVFvA2hmgg/Ecvpq9Dmebsq28qB30PK/kiI6vj4QVuQV3WLGcz4CjkHo9ut53
 uF2hcfgI+2LN4Fcz+LEyZQICALhzpscVumQr1d6QzQNaj7oYZgR+aRWs6bF5rz/TmKP0f0XxS7t
 Q5+zmhocrctWXpyyxfAryOT7+W1AdU1mINub3oCF72OF8HBCjxpDeGkwjgmUnIOpHP0Ink18uuX
 zSyterv8StUMbTDsKgNv/IN37+ya/3LVwdNyMxvrqb5BDtw56GLCVJ9vgCS0o+3vaELbn4631/z
 rSDxipKAlb4PXLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

resettable_container_init allocates a GPtrArray for children, but
resettable_container_finalize was empty and never freed it.

Fixes: 4c046ce37af0 ("hw/core: Add ResetContainer which holds objects implementing Resettable")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/resetcontainer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
index ef84aa2374a..a4a6476a036 100644
--- a/hw/core/resetcontainer.c
+++ b/hw/core/resetcontainer.c
@@ -66,6 +66,9 @@ static void resettable_container_init(Object *obj)
 
 static void resettable_container_finalize(Object *obj)
 {
+    ResettableContainer *rc = RESETTABLE_CONTAINER(obj);
+
+    g_ptr_array_unref(rc->children);
 }
 
 static void resettable_container_class_init(ObjectClass *klass,

-- 
2.54.0


