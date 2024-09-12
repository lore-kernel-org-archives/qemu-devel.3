Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1D1EED618
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 16:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1somQe-0001Hn-9D; Thu, 12 Sep 2024 12:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQb-000142-E4
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:17 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1somQX-0007U2-UA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 12:12:17 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db174f9050so442880a12.3
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726157532; x=1726762332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2RDX2fjFJQRiytlapcKfuKzsswRML3AeBvlkH5UKQw=;
 b=mPhQCxnesSFRAnRy9nSy67Qik154JleVck+GIOyjDXh45FsXtiiwcSGMXfYZ7sbA2Z
 Oq9fh71bC1yyU+zMU5WcmRdPikFDdle7E18SZmz0m5ulwMVmFikbQ6/vIvk87Ps5AK8K
 6FMzjLyveZd/AuJBA8Y1/JY7gT9AijU0mI/Ocm25KH+PzxM1Q+4ousjQNERQSer05Qm0
 15AmV5P5kK/Z0VZHORKCXkfLjVoVomiEoa0rV/QgYzzWDnigF+iF7EHtI95gt2HRO9K8
 ugDbEHekzmc1BmqP3n2015hj5Qc91LfSL9/4eYxq6eC+Dh3G4M+v4bgMAPLSjcGOXcSK
 Nu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726157532; x=1726762332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2RDX2fjFJQRiytlapcKfuKzsswRML3AeBvlkH5UKQw=;
 b=pQGhQMUm8hJkb47hBbSXPNYtUIHml9h6/7HEN1PLLZZYkSFdHa7W6ldAZqY/YSpoxu
 WBG79Sg2at1Xkmnh8pOm6IB8rP6aJERwXaonYMlV3lxbMLyDyT5A40O9ks+PoaCwSwFD
 pwhXb8xi5LeCcxa21gVbHOyQKVDtUgjKTB/E8hGadeHk7TQhh6fVupxSkMP7mBN3Y9ug
 e9HkB1Lj+8gAXNKhpoqVzn55j5QwFwv8D6nKiTWAjcsSnOTS1reLZdMUkAKxICpC3hu4
 kqPMyoAcpxad55PkEkS6AfBNSToi1nqiqztcysaparQW1k1yhvk7x3rzQYtNYfmK23LT
 SG3w==
X-Gm-Message-State: AOJu0Yzc8Sjj5ReaLvlSEOGMkLtpIoaYftY9i8Af1t8QrgqI1kkUXO1H
 G4P2bS2SU716mn7SkhH7ZIK/rPh8COYbEMGc0cb9jx5fjRy53iFkKQw4pnI14fL1eEc9Cohxk8F
 mGvUtt8XU
X-Google-Smtp-Source: AGHT+IGK4aCZmCNuEDtLotPImMG0hqQX92keeNScArTDh0uI/me/xdlfLavv9yxHnNep1l1nzhsFEw==
X-Received: by 2002:a17:903:2285:b0:205:2a59:a28c with SMTP id
 d9443c01a7336-2076e3155demr54911595ad.1.1726157532316; 
 Thu, 12 Sep 2024 09:12:12 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2db0419aab4sm10868139a91.15.2024.09.12.09.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 09:12:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Weiwei Li <liwei1518@gmail.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-s390x@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>, qemu-riscv@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Jesper Devantier <foss@defmacro.it>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fam Zheng <fam@euphon.net>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-ppc@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, WANG Xuerui <git@xen0n.name>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Corey Minyard <minyard@acm.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 47/48] tests/qtest: remove return after
 g_assert_not_reached()
Date: Thu, 12 Sep 2024 09:11:49 -0700
Message-Id: <20240912161150.483515-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
References: <20240912161150.483515-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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
 tests/qtest/acpi-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
index 673fc975862..9dc24fbe5a0 100644
--- a/tests/qtest/acpi-utils.c
+++ b/tests/qtest/acpi-utils.c
@@ -156,5 +156,4 @@ uint64_t acpi_find_rsdp_address_uefi(QTestState *qts, uint64_t start,
         g_usleep(TEST_DELAY);
     }
     g_assert_not_reached();
-    return 0;
 }
-- 
2.39.2


