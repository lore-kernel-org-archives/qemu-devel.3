Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E38BC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Wvr-0007SI-O8; Mon, 07 Sep 2026 06:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvp-0007Ri-Er
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3Wvn-0007zV-V2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 06:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788778231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBkpBlDF1/WyOSTwBP3AO4eRPfM8j2PH9gxozKjXdJ0=;
 b=GLosgvepDVJxkc6eg09rj3Q3D4cziYf3VeNx6qDbnr9BIVgjXbhRrzZ5YlzKfjXQK6Qu5h
 /tJXxcVlIIZFcEC7JCwVHSoZV475CLRAtejAg38HL5nFZ1LhBwJJ3Uan/z45d1AVFEtfRG
 m5HtKVYOecX9cNYn9OYzhlidc4pD3GA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-Zl8_28IPOoCDgFUzZW_7vg-1; Mon,
 07 Sep 2026 06:50:30 -0400
X-MC-Unique: Zl8_28IPOoCDgFUzZW_7vg-1
X-Mimecast-MFC-AGG-ID: Zl8_28IPOoCDgFUzZW_7vg_1788778229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B15019541BF; Mon,  7 Sep 2026 10:50:29 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F70618005AC; Mon,  7 Sep 2026 10:50:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 07 Sep 2026 14:50:04 +0400
Subject: [PATCH 06/17] qga/vss-win32: pass character count instead of byte
 count to volume APIs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260907-qga-v1-6-86456ad356e2@redhat.com>
References: <20260907-qga-v1-0-86456ad356e2@redhat.com>
In-Reply-To: <20260907-qga-v1-0-86456ad356e2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2051;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZD0/7tpVdeRuw6ZXemEgNAdRCybVIjmkKDSXJhLrI0Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnpbjYMmCGLX/nEwP/XJDyUJXGPhIxa3w61Prt
 LsK/Xc2e4aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap6W4wAKCRDa6OEJdZac
 5e1RD/9GiTN1hfQDLO/Dpbz8S4ygbxF0lRyk6Gn8q1t494WujAElNqcRqmzI7WTDgGqUsULhw8t
 LTc7El5cRco6eHGWCyopQiVstvu9ecuj8wASqh6C7xCfNEh8F8N5Q31zrVwct1nqu52sf+9jNq8
 /a9+Jl68OorasL7KICrx0Y5glT4BSnsD6DlktxZ+bR9pvyJ9ICYMKLAFPk/kpC7iyMDV0s9aWlh
 VBGZrQOuxm1K0bVCLIkd6llE3q1lMBPRLYdQWWWZ3FVEmiFM+fu7CZIDqw9ORlDZPL1WZ0QFD66
 Ir5W8/UC3C4T9grHt7DcTAe8v4XF3zbXCUbMRqxxVH4nWxRTf39c/TMcdumS2qdgCB02Cm5EaiB
 P3lpJSOzYGhzSh8lNnl1sYS0cHFp41J3m6EtTjDzO1QMs1ZeBL5Uqp4hdbDdVzNnveG9WX7IHW/
 vKZn4E4J/bhY1TiqWVe5xbsPAAcb+ACRa3mh2L9Wc+UpaOvXIh2TLu4RfjwAPedmHrpsyn7eqBF
 LkAfpcAmW3drWIophPl2a9Ac3OE1cjzx9kv8fpHf1QQXpQ9LrUm9RPUztR1/Fhl2Xo4p0IiKRL6
 uzprMUtr2ZuXJ91mc9tlr4SRvJIbcYIfUeL3W1yCne3qy+D68kFQmOKJaNMu6anrBAnt8Rkx9hl
 +xW55Z07peTIaQQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

FindFirstVolumeW, FindNextVolumeW and GetVolumePathNamesForVolumeNameW
expect a buffer length in characters, not bytes.

Use ARRAYSIZE() to pass the correct character count.

Fixes: b39297aedfab ("qemu-ga: Add Windows VSS provider and requester as DLL")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qga/vss-win32/requester.cpp | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index b9269acb5b8e..1fd73312bab2 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -432,7 +432,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
     }
 
     if (!mountpoints) {
-        volume = FindFirstVolumeW(short_volume_name, sizeof(short_volume_name));
+        volume = FindFirstVolumeW(short_volume_name, ARRAYSIZE(short_volume_name));
         if (volume == INVALID_HANDLE_VALUE) {
             err_set(errset, hr, "failed to find first volume");
             goto out;
@@ -447,7 +447,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
                     WCHAR volume_path_name[MAX_PATH];
                     if (GetVolumePathNamesForVolumeNameW(
                             short_volume_name, volume_path_name,
-                            sizeof(volume_path_name), NULL) &&
+                            ARRAYSIZE(volume_path_name), NULL) &&
                             *volume_path_name) {
                         display_name = volume_path_name;
                     }
@@ -459,7 +459,7 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
                 num_fixed_drives++;
             }
             if (!FindNextVolumeW(volume, short_volume_name,
-                                 sizeof(short_volume_name))) {
+                                 ARRAYSIZE(short_volume_name))) {
                 FindVolumeClose(volume);
                 break;
             }

-- 
2.55.0.543.g5ebe2ebe4ea8


