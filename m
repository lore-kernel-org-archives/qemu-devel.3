Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59ACCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 19:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNc1Z-0005RG-50; Mon, 24 Nov 2025 14:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNc0y-0004uL-4D
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNc0u-0007h5-8H
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764011653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gelZrngp3V92h2SIQEGY0OiQAaFLy6m78tZblQoOXwo=;
 b=IkuasGmBjKw4k1ZVt5HFnIvQpqM9yVS0+Xxk0ApHPQNpD7/6bubW5rlRqB8owMlW4T77hB
 tIJH2AC1wwmC0TrMrCA1jHaktSVFzGvpcooYhagrkmf/QHP4mvElsmrb/MAzcwQbJatZ/D
 vobILGv/mIbeWYrzxkuBEAUWvLQ5tLk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-RA3inBbCP929EilreszQBg-1; Mon, 24 Nov 2025 14:14:11 -0500
X-MC-Unique: RA3inBbCP929EilreszQBg-1
X-Mimecast-MFC-AGG-ID: RA3inBbCP929EilreszQBg_1764011651
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2d2c91215so1225790985a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 11:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764011651; x=1764616451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gelZrngp3V92h2SIQEGY0OiQAaFLy6m78tZblQoOXwo=;
 b=YnQQ80o32x7gefugtTDdF69lcHtC+Ib54PqZoirkjd1GQP8sKjr0XpCP1Z68DBxWF4
 FZ2QI4GsUhGNbhvt8o4sluZ7DDnB30fKVgKNELOrznnQtthgdJERiy5rGut1jmbOVeRu
 ++wb2PIvNMZJVEBgKFXqNwaRhTNIJZYC94vRQN040rZWejgC/rRJuUrbyTjHzXIbriMe
 QMbdl6Z2ALQlE4pCCZXURD/Wsvql7Pr31zbh2BmYjLhYUq86nMYfn+sDh8uNW4r04itt
 3sOnFP0SWSMYt37SIq3y3r+n1J45Xal7V8toIONBGj9kdFyrBp8pCwdo5ZlpWyN0rZ9E
 JSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764011651; x=1764616451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gelZrngp3V92h2SIQEGY0OiQAaFLy6m78tZblQoOXwo=;
 b=we/HznKnKv3LkJ0ejvlbVLzZ5fQkQ8CKB5qkaD8V80IE8Zlg8MzOMXoEZTramSgQVG
 jIMMTS+ZM2QlWovUBcPpsBATZ8BHJDvHhqaRmYRolR4q1uBi1Y5ZW0Nx+DIWMnLekZ0d
 NN35T+G6CKn0x1WNl9c4Ux91jFWL2n6caaLRnYKlq1aZ1i/+JCta7EsCyZ9xNg6+fclj
 Urkt0MlpNrGrTKu80KGJQ4GFKf+HjmowP4xJONASArzoClUi2f2jhH5vrH7moPhhTCaF
 4YrDPscjUzabc6/ZnC2ETYMGv3tkfbqS7nUGKlci/eu1tWnVgITDHgDBrp5eiibDDXqN
 w9Nw==
X-Gm-Message-State: AOJu0YwgBkPnJqIuKG/PpDqiwsVn4RcbPpCsA4IdlOBz+CKTZhaht5Ku
 fBHwBLJw4VtfHxcoxsaum2JjiCRTxjS2IuROwLx4j5VjoGxxR7jPD59gp1csm9BOYNCwvWOC/4h
 ebUF+2YU7X6jwkP2cE+m9l23aORBfRA+1fx2TphX+o+MbTz2ySN3Agofrv285fJqGOD7+wW5fZM
 mdIg3wJavqnyF4/vgBMf41kGdwN/xW7HO54E4tOg==
X-Gm-Gg: ASbGncsQYUjUaZL96EvX5g35Qa3AYX8RjiTdczghkRRbdWRLPSeyF84iKEfZXC6/R1S
 4vFDZ8Oq2eImfB23/XlQhYDE8S3kDRyezfOZhM5omIFvu4KMYfY4NN0I6eHvkz7Rtb+op4y1tt+
 vTL/web29GoY6S8bVSQSX/zxIpQVdimKynYONbLlgIuDpz5IhwFs9XZHtt3CORyIX+6VXlsZBJ0
 VCgaT3MuXU71bFQOjQ0YON7jqV8iwb1cco4HipqEGod00YEfN6MmQgJRicuMGZFTFDw6I7QhTfX
 B2zRGpk9Ktn826WSvEbYQDJ7ZjgEgV0iGoBxML7pOC+fFf2/gEr2WE1waFXBTgFJvHJOTTRFJeX
 E114=
X-Received: by 2002:a05:620a:4004:b0:8b2:ec1e:fe30 with SMTP id
 af79cd13be357-8b33d269ccfmr1520802185a.57.1764011650772; 
 Mon, 24 Nov 2025 11:14:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETHKTtuTY1d6080nh5W0xOiXwGKA7usY2oF8jp/l+/ogF10hKJ38JK7e/UQbVnnXoJjVRltQ==
X-Received: by 2002:a05:620a:4004:b0:8b2:ec1e:fe30 with SMTP id
 af79cd13be357-8b33d269ccfmr1520793385a.57.1764011649994; 
 Mon, 24 Nov 2025 11:14:09 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c3306sm1010311385a.31.2025.11.24.11.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 11:14:09 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 Zhao Liu <zhao1.liu@intel.com>, peterx@redhat.com,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] machine: Provide a description for aux-ram-share property
Date: Mon, 24 Nov 2025 14:14:08 -0500
Message-ID: <20251124191408.783473-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It was forgotten when being introduced in commit 91792807d1 ("machine:
aux-ram-share option").

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Fix spelling, s/auxilliary/auxiliary/ [Fabiano]
---
 hw/core/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 06e0c9a179..27372bb01e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1204,6 +1204,8 @@ static void machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "aux-ram-share",
                                    machine_get_aux_ram_share,
                                    machine_set_aux_ram_share);
+    object_class_property_set_description(oc, "aux-ram-share",
+        "Use anonymous shared memory for auxiliary guest RAMs");
 #endif
 
     object_class_property_add_bool(oc, "usb",
-- 
2.50.1


