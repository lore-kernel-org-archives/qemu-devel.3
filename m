Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21843C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 06:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiIo-00023j-En; Mon, 08 Jul 2024 02:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIn-0001uA-7r
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:45 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQiIj-0001wP-Qh
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 02:56:43 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7276c331f78so2971611a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720421800; x=1721026600;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLjKua6/1Hq2H1WMYp9C0UeVmJOmPJCabCtwzxYyu/w=;
 b=DVN8qqyoedF0LwyM5e6XliCbYOd7wEqHOrZuUXy2nsJGEkFSn/7Rx7uB0It69yFUKF
 ZT1+saYscXc/yduH+61iKXb1AW+fEgSz7JXNL+2CvIam5smUjxLjxihHf2OjyERf7SRk
 dyrevOjqoTJXEiyO+9QEGIOOI+EdURNBKn0cZLAZVFirA/WE2w7I3TVTvHsZtzrqyTqL
 wk1KUkJzQ++lxmCnv6uuIUwaozD9uml+w0LJwrMkvp/aVBNstvOya15I+s+UHNKLqu/z
 ppTX5i7KeyCaMPjAvMfo/jioC/f0w5QrKK5pv543px/dR9t81FOSfl5IjwwjjZMGoyze
 7BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720421800; x=1721026600;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLjKua6/1Hq2H1WMYp9C0UeVmJOmPJCabCtwzxYyu/w=;
 b=RxFL3LblFj9uUuFtO/VlBFPALgt10ze5wM7US2cxGDXw/72/sFxiqubyJsiKWnbODr
 DXklxN0H126SJppx7Yy7P+4ZdkMUKYF9Z3RPEhimfuCZ2CINKFyjtfLb9k+BOoxQa5vK
 d7cdgZpw3WC9TXyi7yudgkRUJISFrN8KOhAzxixthrZTwRxZXiDGrTBil1M2YsQAfK8A
 ZfbXO3oR3QpYETMVs4DPH1oob6au4leFaKgp5sK6ROk3jN4fL75PsJEioEmcFunGb7RE
 wHqRgcw3WULXOAc5H5T7HIF7Y/WaV3QiTbky7vTs2JmOkTSlNUg4L8+7KEiJwFv9SOiT
 67GA==
X-Gm-Message-State: AOJu0YzJbTXHnX8NbEh7kjph32KM2rsW6KuHcN4H+Wgs+vLclqUL4Ixm
 Bqh1YuWEXp4EQ+5EjNXUcR5TQp4glTalnScJPqWwbKioJAa7I2NA066cYJNQv4g=
X-Google-Smtp-Source: AGHT+IGimfWqqHnSqOntC/f3ozquovyx9nC2f2NQCfqeGesCHlONjh70lg+bYJV2RrwbgWKdHUVV5g==
X-Received: by 2002:a05:6a20:a123:b0:1c0:eba5:e19d with SMTP id
 adf61e73a8af0-1c0eba5e35bmr7575031637.18.1720421800288; 
 Sun, 07 Jul 2024 23:56:40 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-72c6d1f77bcsm14717594a12.79.2024.07.07.23.56.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 23:56:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 15:55:19 +0900
Subject: [PATCH v3 8/9] memory: Do not create circular reference with subregion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-san-v3-8-b03f671c40c6@daynix.com>
References: <20240708-san-v3-0-b03f671c40c6@daynix.com>
In-Reply-To: <20240708-san-v3-0-b03f671c40c6@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

memory_region_update_container_subregions() calls memory_region_ref()
on behalf of the owner of the container. memory_region_ref() must not
be called if the owner of the container also owns the subregion.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 system/memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 2d6952136066..09c98042e443 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2625,7 +2625,10 @@ static void memory_region_update_container_subregions(MemoryRegion *subregion)
 
     memory_region_transaction_begin();
 
-    memory_region_ref(subregion);
+    if (mr->owner != subregion->owner) {
+        memory_region_ref(subregion);
+    }
+
     QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
         if (subregion->priority >= other->priority) {
             QTAILQ_INSERT_BEFORE(other, subregion, subregions_link);
@@ -2683,7 +2686,11 @@ void memory_region_del_subregion(MemoryRegion *mr,
         assert(alias->mapped_via_alias >= 0);
     }
     QTAILQ_REMOVE(&mr->subregions, subregion, subregions_link);
-    memory_region_unref(subregion);
+
+    if (mr->owner != subregion->owner) {
+        memory_region_unref(subregion);
+    }
+
     memory_region_update_pending |= mr->enabled && subregion->enabled;
     memory_region_transaction_commit();
 }

-- 
2.45.2


