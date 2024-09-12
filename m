Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA6DEE645B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeXR-0001sc-6q; Thu, 12 Sep 2024 03:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeSB-0001H1-Cx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:41:23 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeS9-000178-Nf
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:41:23 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3e0438e81aaso388875b6e.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126880; x=1726731680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufez9dB+YBOc+7iflBPh4kX/ooB3/U9U7kq4P7lOFRo=;
 b=W9T+xQefqZW2iJPzY7Yi866VhWXeH2R0CKurj7+FYdhREkUF3VMXpGcsmghFuhFa1l
 T3mexpIEiR5+hf1ns3KLYT+w9RgO/DgzBvbOqgkK5uSXhi0//MovGtwwUQCWftxxzloo
 2vpIQ34H+5I96p70j4JDj/aMlqwAvMkUAAXgvLkcW2WXB5RIPzshMVvSOM+9tNscETQQ
 +8PF3dyavH23HL0ueSbOYwR8J9jWxaiQ1htxSnzGYqM7bzzkJ8CfVH9TfnaLarG+QEvJ
 mJoxayoMRipyqhf/f0dWa229+rXOPYgfhg3J9DOI5UxmO2tWGUNkqcyxCV6MxZfsxDZk
 m4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126880; x=1726731680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufez9dB+YBOc+7iflBPh4kX/ooB3/U9U7kq4P7lOFRo=;
 b=Qyq443qRStL97DbZ5IQqXryumiqXqYDJuhxq7Hc7gNPm0i0qJ9DhLd3S3mBoYnChzW
 OAD/fzqRvY726u2dFsd41wlfrQcK5hKFNyqGxjXsTekmNw+2hTQefg7rZm+wKC0opkmr
 i4F6Spm1Qev16RpVUVmBR0O3bYSQoA60knqMxBPHi2RcOUS8MofP3FKOesjFTnCSKSqp
 sbA5d+C1D9Ujs1rC8Mb/OCsTIJIAbtqjC/ZAnWwxcB8w2r5USgP2r/JvRnjv2Wghvh0d
 eAJSN8XFqkyC6N+wBmSHvQiQn9Rgq94SmKe9125ozGjL28ySDTo51GeuJpagJTa/VIZR
 LnMA==
X-Gm-Message-State: AOJu0YxgfQ9B0xIH0JWF3NEhnkkA8zvA7gEzlaLPcblBJmv1L6AaQEoZ
 ZSz6V6ddOcCZwIjqYcE+RVQshAio4JRcCq1GYKcEgu9VklMaa6eU0kyPGw4Ms2d3DBcUODZDemb
 +KOBsREWN
X-Google-Smtp-Source: AGHT+IEahP6jvi2FuHplutVqQN81TXossfZA34JXn70LhsQgJakrG7hFdv/bnJa3CeA2ta6y/uKqJg==
X-Received: by 2002:a05:6808:159f:b0:3e0:4faf:242 with SMTP id
 5614622812f47-3e071a9a5fdmr1180584b6e.19.1726126880116; 
 Thu, 12 Sep 2024 00:41:20 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:41:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Klaus Jensen <its@irrelevant.dk>,
 WANG Xuerui <git@xen0n.name>, Halil Pasic <pasic@linux.ibm.com>,
 Rob Herring <robh@kernel.org>, Michael Rolnik <mrolnik@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Corey Minyard <minyard@acm.org>,
 Keith Busch <kbusch@kernel.org>, Thomas Huth <thuth@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Hyman Huang <yong.huang@smartx.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-riscv@nongnu.org,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller <deller@gmx.de>,
 Peter Xu <peterx@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Eric Farman <farman@linux.ibm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Gibson <david@gibson.dropbear.id.au>, Fam Zheng <fam@euphon.net>,
 Weiwei Li <liwei1518@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 43/48] hw/ppc: remove return after g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:39:16 -0700
Message-Id: <20240912073921.453203-44-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch is part of a series that moves towards a consistent use of
g_assert_not_reached() rather than an ad hoc mix of different
assertion mechanisms.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/ppc/ppc.c          | 1 -
 hw/ppc/spapr_events.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index e6fa5580c01..fde46194122 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -267,7 +267,6 @@ static void power9_set_irq(void *opaque, int pin, int level)
         break;
     default:
         g_assert_not_reached();
-        return;
     }
 }
 
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 38ac1cb7866..4dbf8e2e2ef 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -646,7 +646,6 @@ static void spapr_hotplug_req_event(uint8_t hp_id, uint8_t hp_action,
          * that don't support them
          */
         g_assert_not_reached();
-        return;
     }
 
     if (hp_id == RTAS_LOG_V6_HP_ID_DRC_COUNT) {
-- 
2.39.2


