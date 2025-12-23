Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E662E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Py-0002Sg-Ip; Tue, 23 Dec 2025 09:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PC-00016l-2c
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P8-0003lz-0t
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mF+Ha4mX5K/3Q9gfAi2xtogfcDdAXHrzxjz+aiuLiLI=;
 b=faPkL6H5td7xVuDBYgYDEEOTU+Y8rRviJAxVbligj559V9DbeVVpn3A8WR37hAHcA0dvf4
 gWrV4uJgsFn8CQyP7I7xRcuhy39ZKTKUsib28jgFUYwtAron/E9DhGycrMixt3DD08XhN2
 EYJlVjnEWu7rftSMBgD7rot0Ib6v1uI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-qB-bA6EaNi-w9T0m_EZAyg-1; Tue, 23 Dec 2025 09:30:22 -0500
X-MC-Unique: qB-bA6EaNi-w9T0m_EZAyg-1
X-Mimecast-MFC-AGG-ID: qB-bA6EaNi-w9T0m_EZAyg_1766500222
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2e235d4d2so1801978085a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500221; x=1767105021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mF+Ha4mX5K/3Q9gfAi2xtogfcDdAXHrzxjz+aiuLiLI=;
 b=bXKHgqEIoGcsQf/I7PyI3clXOuIL2V9wWhEO6zYlg6l7shkOOjLJBuN0WZbPMf/SEj
 88ImpA5zxTaw8Eyyh1pOKS5ir5JV7490VjT9+XIL+4GQihize9A2A5fa7u16vI8LTCKe
 CNHzurngM68q1+W+QRZcMNHUe0ltMQ7GNbEPks+Xthzn+DaDjfw8ZbaUPJO66pYNncaJ
 QM8bUeykVSbzAiZv5W9kAgFqcwt987SRC47MbEAn7RdIWlhU64DimYzhnTpo/hCuf8zQ
 G2sEtjmwmL7G5W4vJNRdbHBn1iG6QlpbF5KJ6WT80BPMuBrsPmUIUOpMgprVBwYqAm6u
 8kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500221; x=1767105021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mF+Ha4mX5K/3Q9gfAi2xtogfcDdAXHrzxjz+aiuLiLI=;
 b=rIhsf7/bSBv3YyAyvGTMl4Y5CsRQSI01pz0mlEoNqV1bQitVbcdNSv1pbrdZlKOId/
 yinJ7wXZ6PigURuAb9FrF8cK/wA76IspCg2nvkGjUWGQXBRWbDUDdbjBJXIoNbEZbecp
 SCVn1twxZh0nMlVauVRtxmq4sWS3d6PU5n8G2rJFbrZ/NpOq8tRKjMENwV0btdSDNGiA
 CSO/4tROdTI46JQsoxbdak9By0oSsIBih3abYepmFyDaMouVn1HDbgZ7y6FpwZPtN6YN
 mg4u4QlEq1nd0gpRyO2tkOThbL9WEWJsqsFQ0pFO8LX5KeFFxGMI67ZEStoWSbbmVZt+
 nciw==
X-Gm-Message-State: AOJu0YzYaDlBJHJgacSqn0h+xJ72t6ozrOtxFwFPcGgFTkxdKHh7QdtX
 7rmMBgwHYoUTCQ8Xtf9cnVjbQVedkEI9xYlVcFoAIsplxmkobZ5Evr6qxhNM1FmrNTZ9QKfS8H6
 Tc4qE1NtzLtqFqNiyhmJ6lvNHe28U42WNW4qlm6talLto8Gqjbxt5nVvm1Vi64k4Y8rIKaMukBr
 DyIy9JP0qirptq8GBL+8+DX2jdQM00+GU6NcrPgA==
X-Gm-Gg: AY/fxX5+hW3qraKcN0NNQuYOE5ElOjowZ1p7vju0OSVMxbs0P4VIu8cZ2WDigzS8r5w
 Nw9ip8CG+eEMiaX9T+QfvlGwnyCDpucw9D2VKVpbpA8eY9+tqcKjVuzsVLoshv0Lm0Eo5fxFsRf
 2PKHy7D01WssjqtjhG3PRbpAnqoeKisq0fd3IXE/9HPJMYLLJu6t0AVUDBFg9rbGg8o9BXhBwj5
 nrvJOYU3QBLr0jxj+/aLBL9ZZTpJNsUkvlCg783slpG594UIquqPh8rWNr3cjnUXobSD63mYRSz
 EwBg8OIwYRHZlHWDOg5+ekIjl5225a58pgqB92nnYs2fmgzZGvLm5kchQTZGFKPCDggrCPoFcvu
 9TG4=
X-Received: by 2002:a05:620a:4611:b0:84a:d3ce:c749 with SMTP id
 af79cd13be357-8c08fab8868mr2314761785a.64.1766500221226; 
 Tue, 23 Dec 2025 06:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvjyHgsym9CWFi6Si3slgwmLo0ybW1mP0myTpfxbJANDdjFEcaMC7B3bozcKU1z98psjD2SA==
X-Received: by 2002:a05:620a:4611:b0:84a:d3ce:c749 with SMTP id
 af79cd13be357-8c08fab8868mr2314724385a.64.1766500218720; 
 Tue, 23 Dec 2025 06:30:18 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:18 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: [PULL 14/31] MAINTAINERS: Update reviewers for CPR
Date: Tue, 23 Dec 2025 09:29:42 -0500
Message-ID: <20251223142959.1460293-15-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ben Chaney <bchaney@akamai.com>

Signed-off-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251210143624.416697-1-bchaney@akamai.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..dc6235e174 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3118,6 +3118,8 @@ T: git https://gitlab.com/vsementsov/qemu.git block
 CheckPoint and Restart (CPR)
 R: Peter Xu <peterx@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
+R: Mark Kanda <mark.kanda@oracle.com>
+R: Ben Chaney <bchaney@akamai.com>
 S: Supported
 F: hw/vfio/cpr*
 F: include/hw/vfio/vfio-cpr.h
-- 
2.50.1


