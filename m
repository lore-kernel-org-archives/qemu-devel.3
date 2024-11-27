Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4DDD6ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYF-0003hU-PH; Wed, 27 Nov 2024 08:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYE-0003h4-IX
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYC-0007jM-Iw
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMcl0MSS++Dl9hhYbEW3wwttoqPTslrQ++mjFH0r/Vg=;
 b=Ja0P3bpC1c61WflXKQAmNmke2zZ4a1OAD65pHjcC01ai0gH8DYIUnAPfwto8sYtDWeJm5K
 n/neGASjX9GAFz4HHSOwcCcoGPmH/vvTFucbqrhlQ1bWRmQn30KzHt7msRL8VCV33M0q0M
 LIqDOnjrxp4CkOrXi1QCkvBCdmVuX34=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-pRluDRE9NnO35IuYxP2itA-1; Wed, 27 Nov 2024 08:57:51 -0500
X-MC-Unique: pRluDRE9NnO35IuYxP2itA-1
X-Mimecast-MFC-AGG-ID: pRluDRE9NnO35IuYxP2itA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38242a78f3eso3542006f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715869; x=1733320669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMcl0MSS++Dl9hhYbEW3wwttoqPTslrQ++mjFH0r/Vg=;
 b=Yr1sYPinP9GLrI1nvZ3FIeOkb70H9/RY2USS2TSxdyX1Gku6/ZR1aWLzdFXyy9xvuP
 MasicR+VhcpqEL/6x8GSRdOtskpfvWpm/iIG0iPHs0nuxfeqV94A6VLBeTNZyQ0q7MNR
 tGmysOqknEUMwrZAUmmv6ahDsU/1VFsCpHtvWnSCANfM+bWK7GgzuTAzHCqMuIWjnX4n
 gkq1JEnGclycLEYvkWx7/pASzk/OZapqxqZvUcO+tow6SWxj9l3rb+ylW97EMxeVS5Z1
 WhQNydp6gbSxthjp+KfLbw+UkhumWXPV299gXNwM4K5ulA/xYsYYdSthBHU3vdnI4S55
 MyNQ==
X-Gm-Message-State: AOJu0Ywwc3w280+1Pi4sx4FzUiuuy9/GOXNXQlSL5Fi9EpIkbKNTcaAF
 AEGtTKeahZUDfh79v4t42yXFgRiD2WV+TeGO7m5T/CrTaOBj+7xpYs1LMuao756K6CFjEnmN64j
 jfDRAMb/SEZ1tKPaaNnIB8GLCqBfrG8U8hoR+AhMMvaAEtOJxXJHHx09qRRL68jI9g1A1xiFe9Q
 pNToYvuiFqlOB0TF2m4ob+CdZXnXQpfsBP
X-Gm-Gg: ASbGncswr9av94z0G1LugrPmOp9Rhu2uzweDuXrnHsERY+xs3YRz2AQIWGSUo95quzD
 1IJxyc+Y5cA3+hMkWgywHfULrz4QKhqWc1ij15PORICliL8RW8ytV8iWATHzdGIZUiRsM0yJgHe
 ht88rvraMI2F9Q/WoUe8RJey41O5QWvr1vIFfR7OyZbLgn/8dkqLukMCRjDAJsPSbZire4eROSO
 PG+FqpBEsczxVoK7Sw6/WJPX08VuSXxycdqJBllIHD5
X-Received: by 2002:a05:6000:1844:b0:37d:5352:c83f with SMTP id
 ffacd0b85a97d-385c6ebbab6mr2837470f8f.17.1732715869334; 
 Wed, 27 Nov 2024 05:57:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8zVZTYASQLLdwmEL8OSpzrpitTSPR32eerp6fYb0e3OyPz92snGztFChROzwkCqFK2gGwOw==
X-Received: by 2002:a05:6000:1844:b0:37d:5352:c83f with SMTP id
 ffacd0b85a97d-385c6ebbab6mr2837441f8f.17.1732715869002; 
 Wed, 27 Nov 2024 05:57:49 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc3a3asm16319437f8f.66.2024.11.27.05.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:48 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/13] qapi: fix device-sync-config since-version
Message-ID: <e069c115e00d9eeb1ad6bf224775585c3d30177d.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Actually it comes in 9.2, not 9.1.

Fixes: 3f98408e2e ("qapi: introduce device-sync-config")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-Id: <20241108071957.727286-1-vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qdev.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/qdev.json b/qapi/qdev.json
index 2a581129c9..25cbcf977b 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -182,7 +182,7 @@
 #
 # @unstable: The command is experimental.
 #
-# Since: 9.1
+# Since: 9.2
 ##
 { 'command': 'device-sync-config',
   'features': [ 'unstable' ],
-- 
MST


