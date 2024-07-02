Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60705C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCc-0000uV-4y; Tue, 02 Jul 2024 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCV-0000Cd-3Z
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCF-0008Lq-QQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGyASDiFbODYa7hIKIzPzDlV0Bv9TAjx5HfpD5vtANQ=;
 b=T5GdU7I+E8GLgwAFyb9XIqzWzBZKaHncT7TnVct0QbBWNZj78y1nzdChvTy7VXM/o3XOcz
 695ZxNTiFcTKtKceTz+HS0boQZduqFskNZr4VoOFpBib2r3HF31sSv+YfiBukr2yofcG13
 acue4bPLjxi2SQXJVJj+j2UV+zxsTbU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-tLwoAdioO7GXfv1yNxfJWQ-1; Tue, 02 Jul 2024 10:09:24 -0400
X-MC-Unique: tLwoAdioO7GXfv1yNxfJWQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e9345073aso273512e87.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929362; x=1720534162;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGyASDiFbODYa7hIKIzPzDlV0Bv9TAjx5HfpD5vtANQ=;
 b=uYvAGKHCIysHPJpr75DHlwgaM5pKILUgpssHcKc9lWErowDhEmrXq57pm1t8ob3lSG
 t0GGxU+5okjY73g92tmIgoWtv4rVMaGgM5VhD5IG9Uvu1JmttiYd5oCvXJNNM8tOj7LR
 GBkVtbqoxcMydpXeamIGHRkque8I9YV7zjuwaozhIexciX65BuHP3/F6YmjCTI8kDYp4
 gPassM1nfw4/+DtgYucLGjwSR3t+wtZy0HM+T7Z4Zg9I6qaXSKgmncAukt+NOKDbEJix
 W31Xd3Xm9nq+xglr+cy9PCg3VzaU5VA5r/9/WGZPALf/kFKFkiYnIQauQg8tWegU+HAP
 +9Wg==
X-Gm-Message-State: AOJu0YzdJ2T821Ym+uUkMiP51NfMrObI19H43sjzdsZMG5nkMsDsJKum
 IQalrW9wE6xYw7MgYY5PIUnRFjh2AmvDkWEGapaLHo7rUY2tptqXieAWS4d8gjzmMPrZ/rzYUpb
 MbZI2vch/VTxL9EteSOW5PWmxKovmWvK7DXwuXuIGV5Y8tinFKU9SuZDcO5b96DKD6d4DpljTK3
 h0UE0jZjUfEchblUpQUkGrvHZwQK63qg==
X-Received: by 2002:a05:6512:ba3:b0:52c:1298:7304 with SMTP id
 2adb3069b0e04-52e82661f17mr6206213e87.26.1719929362168; 
 Tue, 02 Jul 2024 07:09:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuH7WatXxtPZfjW5xJxKrk48fmN4oGK5WxTFxJ6DEO8RZjI2cZLcsdJoubAbV4txUNqXstWw==
X-Received: by 2002:a05:6512:ba3:b0:52c:1298:7304 with SMTP id
 2adb3069b0e04-52e82661f17mr6206177e87.26.1719929361388; 
 Tue, 02 Jul 2024 07:09:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b097bcbsm200181985e9.35.2024.07.02.07.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:21 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 46/91] qapi: clarify that the default is backend dependent
Message-ID: <34921eba4321d5a62fcabf1b57c79571cc68ac82.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

The default value of the @share option of the @MemoryBackendProperties
really depends on the backend type, so let's document the default
values in the same place where we define the option to avoid
dispersing the information.

Cc: David Hildenbrand <david@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-2-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qom.json | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e..9b8f6a7ab5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -600,7 +600,9 @@
 #     preallocation threads (default: none) (since 7.2)
 #
 # @share: if false, the memory is private to QEMU; if true, it is
-#     shared (default: false)
+#     shared (default false for backends memory-backend-file and
+#     memory-backend-ram, true for backends memory-backend-epc and
+#     memory-backend-memfd)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -700,8 +702,6 @@
 #
 # Properties for memory-backend-memfd objects.
 #
-# The @share boolean option is true by default with memfd.
-#
 # @hugetlb: if true, the file to be created resides in the hugetlbfs
 #     filesystem (default: false)
 #
@@ -726,8 +726,6 @@
 #
 # Properties for memory-backend-epc objects.
 #
-# The @share boolean option is true by default with epc
-#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
-- 
MST


