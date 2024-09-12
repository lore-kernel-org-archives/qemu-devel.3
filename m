Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21AEEE6458
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 07:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soeQj-00023D-Ls; Thu, 12 Sep 2024 03:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQV-0001AU-1S
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soeQR-00008H-Ii
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 03:39:38 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718d8d6af8fso421736b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726126774; x=1726731574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ty7Rs9QHnECV8EUUJMzVINdjzR9zKkzYj9QmIBEPQw=;
 b=WZTqg3LSHGhk6Zhy1xWlGv10+14xPk8lykm2+SSBL6pXWDeXl/q+tFIEATNhVJNZVI
 lOr12kncf+c68axriRIuoryVYU4NNB+0AOFKl2gnEgmU6CtatTY4JTfH15MHs2ObMvEW
 zEBqLSnf7RYwJRWz4q6QfDeynH9Ae6PyGyYBtC0cRL+jLG5OVwDw1Mr6jgRAqnplvmvZ
 xXT8DqeGYvYKDTe07nxybvZjdhtKc2opCZUmuUJMd2RiBdHBuk1kBPH2R5GAESnRpviZ
 euNN5zTV+WAtzXW1M8oMBCf8isK+jS4G/mcdpNbkF/ka+JEZsTbQwI54RM3zDCDRvSSh
 skog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726126774; x=1726731574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ty7Rs9QHnECV8EUUJMzVINdjzR9zKkzYj9QmIBEPQw=;
 b=XH+RlvDK3tA8kLuvVmmvXOxQGNQ+msYZUDV1KIWna9k6kv/YT5pOit25cTFY+C/IQW
 YGO4gEJbN9B/sTnsue9zfvX5ps9Pp5lPHlJrsBk8advW2JTW/llvAUqn8S1L17kpBxJD
 wIIs17x1DmsmsYBIOAx3VrOQ2ucuyiF6CmlKNMmcu54w3+Vj5U6lwji9ADPdHoMWqQb0
 KV5bzGNm+65vShLuWcO+lSmRK/v2/4w/jNo0IJQU+awI/fs3v60P6ZuNWM1R5buErgxm
 qokl/ONAJvw5kgrSMXUlzzhbY4PrEylQzHU0IQEk0dTXoOEgoBlKPNk1HKuPZ4gZwyv1
 famg==
X-Gm-Message-State: AOJu0YxKoFo60WchVYvrBI0BJABy/aRmm9NohDtSIcjaKRy/hJzBPyvS
 uWP6mFOKIvqHgCWXqBqrdqzdE0MCFHHMhht3PkJEMf3wBkYWYgPjlRex/dlf/V8tH3QOCPi0CzC
 n9HpckgdF
X-Google-Smtp-Source: AGHT+IGdy27o3NWIMJUV1QTbS6arySwH8o8Z7I8EmJsXVX+I+rG8YMWPvIhqlvjs8uvVetmJE6ek9A==
X-Received: by 2002:a05:6a00:1a86:b0:717:839c:6838 with SMTP id
 d2e1a72fcca58-71926095e9bmr2094282b3a.14.1726126773886; 
 Thu, 12 Sep 2024 00:39:33 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fb9ad87sm983458a12.6.2024.09.12.00.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 00:39:33 -0700 (PDT)
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
Subject: [PATCH v2 03/48] hw/arm: replace assert(0) with g_assert_not_reached()
Date: Thu, 12 Sep 2024 00:38:36 -0700
Message-Id: <20240912073921.453203-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/highbank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index c71b1a8db32..72c4cbff39d 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -199,7 +199,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         machine->cpu_type = ARM_CPU_TYPE_NAME("cortex-a15");
         break;
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 
     for (n = 0; n < smp_cpus; n++) {
-- 
2.39.2


