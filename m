Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8DCD0C854
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcLg-0003HB-KJ; Tue, 13 Jan 2026 06:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLe-0003GF-6V
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:14:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vfcLc-0008Sz-Kr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WoHmlff5qVInNJa0c5xb24mKFyNRNi6bvJSwoHs/ngM=;
 b=bF9CDDNE50POj7ptI62RC8E4pBcLq9ZJ+mIfUtgnhI1z79xCMQjvDRINOUU5M4zLn3H6lV
 FYaHWFg63gAElvPUBta2+TOgW4stG66+gdIQOT34aj0SdklMpsbV+6F1yPO3TqwPeFGL9V
 4Nq/a4XyLjkRczlir68Myv599MPvJqs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-wV9oZq2HOaSTer5JWVmslw-1; Tue, 13 Jan 2026 06:13:52 -0500
X-MC-Unique: wV9oZq2HOaSTer5JWVmslw-1
X-Mimecast-MFC-AGG-ID: wV9oZq2HOaSTer5JWVmslw_1768302831
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4776079ada3so74286945e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302830; x=1768907630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WoHmlff5qVInNJa0c5xb24mKFyNRNi6bvJSwoHs/ngM=;
 b=kpFhmyTKSe/TedFYsRVW/YYf/jIDXJWRzLSXdSviDhUe554QdbpBaNLp1keTFt2iQO
 WB9ViAXC1pdvedw10ZCNUz49dTSN/FYj3KjVZZ2gkGc9UvSin2KMD36eBl/KievJDtI0
 8S27ZEo5Z1yYjxQjU8zeN8/6oZ8LGOpta5Q9x68vWUWgz2YafVN7a2umspQt5rbWf0a0
 7rD1HqNn90Ww3AUSeTybVok6vT4yAH3Ypdr6Ywj5yMrJlCq0eFBjfhsSeDDHt7W60Vew
 QyWvR0Kz/hCr1kgimpIkigCw0auW9CrfCn86nGxbMYttVU9gI1JFIOf/GtPiTCIhElXL
 h6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302830; x=1768907630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WoHmlff5qVInNJa0c5xb24mKFyNRNi6bvJSwoHs/ngM=;
 b=JlFmzmqWuJc8iNw5FraH0/A7cCogwHpog3IMBp2+ntETYAKui3Fk0juknj2Jabiyrj
 P/swOJfyu4SlFTHoPTYavrYvUTcHhWDj+/GPVubpX6K5moXexzI2FKL7KCUQWRcEzlEA
 mE9EsR8VNFYjaYn3rqkmMwaWbbpUad272STAfiKbp1Yqu6TFy7l1TkvxBiwK4pKatyJR
 BLqX3agrLiErgNkKRlmpjVjj/LloLm9fxYAnCdcTEwZJh2hp26deqfIbQr1mIYJZ+zSx
 6irYgXIRtKeAdKVU8LfeWFX4f3DwF23nHGJic/CrCV2Jt8Wk974e/JddJSyPe8WfOzGz
 hvsA==
X-Gm-Message-State: AOJu0Yz+91wOmGaoGC1Co3iepyhk3ojr/b6oAXQqA6sgKmeO+24jq+gZ
 aLBBEnBY5cOYtF9oEHniDrEbLWEpMN6HuEPRvIf9XNIBLJXwLuWt3gYvMc9R/max4ywREacHxWB
 CFupNuguBjs2riB7YcRxwwo+Q8M9PgQx63GBN9G+zv3W2H9LGb2ZlZJTK4K8ydMrCMGcRoTp5MJ
 V8LZghMKotGt2Am8g6CCApS0ZnJ9n97OEpjjbqBH1T
X-Gm-Gg: AY/fxX5oBzkfhCsf4mOARlowuMsT2aJhODgYqMZP3ynR3/HWD3YjWQ89ou7h2VWqtj7
 zpDsiefuKvtCc4CNR6yOELwh5KBNxFfafb/hPvTBKplxggN0yjAfIaxUJ+V3WZs3CWrfFK7+mRO
 qR6HCNObVfrWCq3+KG7zbKAYxeas7Ak4O6i4gRjBqXZLBvwEuErarE3f9mQ3Cotd3FXU6MLUtlR
 95h0BvrKtrNNpsMx897F5lur1njU1fXFoPGYDBWVD4rrdQj2/g/iHIfB98eDypY+KremIBj8jE6
 VfaWQ7AG8cQvAL2/dyFEkwsIMBWLcmyOqEQtJkjIZrxXV+zwaP45U7gsl0BEYRCdGy89NIbDg54
 xXii2WCQcX2/9z6XUvy1b719em8J1OiXRMf8BPf2BNmJ3TjYrn+JJTEuzJIPQSbko9Bjf/xqYBE
 3kESsaG2efu2A8VQ==
X-Received: by 2002:a05:600c:1393:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47d84b3bad4mr235285325e9.19.1768302830322; 
 Tue, 13 Jan 2026 03:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdULqhZlXJ5a1TLOpcM++a0MpEZu6Cb9nKZW9GtBzFwE298R1Iky4D+vNkH5XdKludUKnvpw==
X-Received: by 2002:a05:600c:1393:b0:477:55ce:f3bc with SMTP id
 5b1f17b1804b1-47d84b3bad4mr235285025e9.19.1768302829546; 
 Tue, 13 Jan 2026 03:13:49 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695956sm410025415e9.6.2026.01.13.03.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:13:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vulnerability Report <vr@darknavy.com>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PULL 6/7] hw/i386/kvm: fix PIRQ bounds check in
 xen_physdev_map_pirq()
Date: Tue, 13 Jan 2026 12:13:32 +0100
Message-ID: <20260113111333.1138160-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
References: <20260113111333.1138160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Vulnerability Report <vr@darknavy.com>

Reject pirq == s->nr_pirqs in xen_physdev_map_pirq().

Fixes: aa98ee38a5 ("hw/xen: Implement emulated PIRQ hypercall support")
Fixes: CVE-2026-0665
Reported-by: DARKNAVY (@DarkNavyOrg) <vr@darknavy.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Vulnerability Report <vr@darknavy.com>
Link: https://lore.kernel.org/r/13FE03BE60EA78D6+20260109023548.4047-1-vr@darknavy.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/xen_evtchn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index b65871f3542..8b243984e41 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1877,7 +1877,7 @@ int xen_physdev_map_pirq(struct physdev_map_pirq *map)
             return pirq;
         }
         map->pirq = pirq;
-    } else if (pirq > s->nr_pirqs) {
+    } else if (pirq >= s->nr_pirqs) {
         return -EINVAL;
     } else {
         /*
-- 
2.52.0


