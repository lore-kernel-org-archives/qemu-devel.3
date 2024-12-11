Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF0BE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZi-0006tc-5z; Wed, 11 Dec 2024 11:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZf-0006cl-LB
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZd-0000WH-QC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gss1FsL60dR5exmv70NK5RIAMB4XZY8Tdq7PdjogwBY=;
 b=PAgrJJ+XYLhf0ABVc+SEURu4xrpSiaMlwGRhcaxhjK2k9CVziFzYvSSqzWhimG7GurV1Uq
 CX91wJ7p6bq7hIQach7xDHJSSm/pKo6PPy0xHkLTJtxiT3uT2wLm3jM4ShAegKAYiZBYkT
 /ISg2b6nev9ETsPIaOO13zAQnJ8Fdg4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-8tMG5_zQMPaIP6oR6ZQ08A-1; Wed, 11 Dec 2024 11:28:24 -0500
X-MC-Unique: 8tMG5_zQMPaIP6oR6ZQ08A-1
X-Mimecast-MFC-AGG-ID: 8tMG5_zQMPaIP6oR6ZQ08A
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso2724879f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934502; x=1734539302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gss1FsL60dR5exmv70NK5RIAMB4XZY8Tdq7PdjogwBY=;
 b=Lrvl1740c4ukjneM3DKQQAPHyx+SgnrT1PkJAXxUlmVX8bLtvxYI71xuEd2Lc6K3wI
 R8Cp/weoYolhYI4MfPtCjdkG13FSK99n8dv3OJzM/d5EjFaEzl+xQpRusEbkogXCH6VW
 mlosSBBenqlJu5UepQvKLi6Oqver64CZdQebHmLojUCQNgsxCyiLCVyeCkBCvIOCxSN4
 BCqR4C2qM0Pg76z9fI5f6V1tjfvnB2PGkC8fGuGNR/CYqOzxwB+ZXR5z30C64Q13pTzh
 m8gE5DUdKQNJSuR7Jok2NC0cMTa/XT6m+sA9qAHWHOM0C8RsIxDnuoc+NNlBtNxe9Mur
 mS7w==
X-Gm-Message-State: AOJu0YxYEQK0cqmgnGQp5cEnFU+3T0n05ij+ZcYc71t8oS15/PkLONgQ
 0VuK9vXS5UofYdd2HTmyqONZCwRszZb+1Qrwq2zQIt7OsSxDV0UcnWe3DYawnl1dpFh8Di23v3V
 qpaxRetWLVfT9ry4igZFiJyPx24Vl8Bwvz9J4bOvMAhzsNrm3fs51pPHE4O/SfyKZBThd1XjUNe
 JFGhbE2wQND8gWK85/nkwQbqkQp/W7TBa9X29B
X-Gm-Gg: ASbGncu1eNMusqxcKqtNzAYXOy6PIPmpkQ65opmuUVjY4qz4ohoaXhxNsVP6EdQxhTL
 gxqMSH6AdN/Fr259+UnrQjiFHcwhLylajLNTOWkXT3SWM7rbsz62Ao4ZHnUP0ECSJ86U6jyXT2/
 OffwRKl/eART656q00fqYM693m0AeIiz3eQSUU1ymiJOYuM2fovUR6afo8T1p0ZkF9rnP+LM6iu
 Os3k/YBWBcFsc+INTPyNLrTY5cKbJtQhg5nvfTcSSpM8QVPy05yXq8d
X-Received: by 2002:a05:6000:144f:b0:385:e30a:3945 with SMTP id
 ffacd0b85a97d-3864ce542b4mr2783605f8f.23.1733934502293; 
 Wed, 11 Dec 2024 08:28:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvGs1q3jSVbR5IZ/k+HnPcfTtlGAUFIzmWsMw6WcgOFkE6ZWNMgn3gM9pYrpiujWdIHsehgQ==
X-Received: by 2002:a05:6000:144f:b0:385:e30a:3945 with SMTP id
 ffacd0b85a97d-3864ce542b4mr2783593f8f.23.1733934501941; 
 Wed, 11 Dec 2024 08:28:21 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e57fsm1665175f8f.8.2024.12.11.08.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:28:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 25/49] hw/sensor: Replace type_register() with
 type_register_static()
Date: Wed, 11 Dec 2024 17:26:55 +0100
Message-ID: <20241211162720.320070-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Replace type_register() with type_register_static() because
type_register() will be deprecated.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241029085934.2799066-8-zhao1.liu@intel.com
---
 hw/sensor/tmp421.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index b6f0b62ab11..82e604279c5 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -384,7 +384,7 @@ static void tmp421_register_types(void)
             .class_init = tmp421_class_init,
             .class_data = (void *) &devices[i],
         };
-        type_register(&ti);
+        type_register_static(&ti);
     }
 }
 
-- 
2.47.1


