Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB86BC79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38dw-0002V9-TS; Sun, 06 Sep 2026 04:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dv-0002Ug-Os
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38dt-0000o0-Sn
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uo1vyG+VFq3hO/+8bOAZhuY/jMoCwIibajRfx3GTxbM=;
 b=QbNITsqEuKZbsDkhFzFFA0FlpQ4nXOPtVNRFceS7PohwAt314rDF/RB/wMYqXNm6fAKx3s
 JGYo+pIHGEUCeetuLx9Gs0KKiQvf58CTl577N4TxQJX5vFcL/67RIj/ZUv9apAoD6hodMd
 hMLQtZo23PJmzbLsifxeVyy3RBB9eC4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-ITnTRN5iOh2hRsihoY2kcA-1; Sun,
 06 Sep 2026 04:54:21 -0400
X-MC-Unique: ITnTRN5iOh2hRsihoY2kcA-1
X-Mimecast-MFC-AGG-ID: ITnTRN5iOh2hRsihoY2kcA_1788684859
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1442E1805A20; Sun,  6 Sep 2026 08:54:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14ED61800767; Sun,  6 Sep 2026 08:54:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:53:39 +0400
Subject: [PATCH 7/9] igvm: release found memory region on success
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-next-v1-7-2b21e63974f3@redhat.com>
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Gerd Hoffman <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 qemu-s390x@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nyQcpX2O2JaBarZgpXAo4ALUM2REr/Vy7wrbwXQjNBc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSoZv5Ptq2a/g08nt+tp4yi2WH6V8BkJT3mCc
 V9ZLjhaHLaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0qGQAKCRDa6OEJdZac
 5Ve3D/915jbscrwaxltqZJ5WmWsXTcy5Mf9/x2rRx4SLVYOH2vGknFhI/LJUwQ57PhQsOyJEwHT
 XoZw8k93odPRlSSOKz1stT0XKTIlakDKeUlq7WHVaZrkXP2lvuOW+NECPDBCmCEcKdG3gCayqpW
 sSEqHOzUCxVxFZsZowfw3K9OKNavuadBschHBbvJboX4dkccgvdekP9BfbU0NXux/pQSHG24dYq
 I44BUfoUme2f+uY/JbDQCgUlx0jI+/SFa+CDNL/G6h+sgfR4fvWveCXxDZBX5R6iHJ65deOO3GP
 KJAEllWCAUuEqqZpju06SwrI5MliaILHhxRxtne3rMzhkLGZO1eNYXz8foas6MC5AYiGz6X2jBm
 PZdpVNDyiic0w8Y+HV74yBJ/Ck05Kr6fa7oyroQBCiW0SMBy9l2XfobMZ+yycrsUjVbQoIMiHx1
 k3Esi1KGHoK5MCEShoOwiHc4nHfksbLlLDX8T7KtcfKi202LTJQ9jOABanDSqcdGYkX9fGdcP1a
 MavOIn6VkJuJj6GyeUu7fe3/K5tXX8ohbZ+xRdkGsa1z1ab6Yg3/BCaDyDu1h3zDwpw7ij6fg6z
 DaEj8Z9DmqZFKaoGd2zbCSBIy3+HBpxbiJGWyQPQgQ8WjAs+JD/Qc4VK3B3huj+uAnSEAzxwtfg
 z6L/0b56FvxuSYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Not only in error paths must the mrs.mr be released.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 7b7bdc72b75b..784a56504e77 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -236,9 +236,9 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             return NULL;
         }
 
+        memory_region_unref(mrs.mr);
         gpa_region_size = int128_make64(size);
         if (int128_lt(mrs.size, gpa_region_size)) {
-            memory_region_unref(mrs.mr);
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "

-- 
2.55.0.543.g5ebe2ebe4ea8


