Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56826C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSGa-0003e3-UG; Mon, 14 Jul 2025 19:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGB-00039E-Ll
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGA-0005QD-6i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPL2XqQemou8iuVCHR8eDk7k61bY1QQbrF+6LyUB5KM=;
 b=c2eyEPm9hzpB/6H7sCRcNY5bP8bHFWI8IEfTqwqyNAG7rXLdiJ+Slj/s+vZ/zovac7eCQp
 myPjmjG/zDLRjo0hp9z9ajUSR11tv8s+0gGECMM7XlQ0M9GdA6wGfhv+j1IQnJPrzECyAP
 5daJkZf+FhqVUfTq3sYxDNKIFmRIY5w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-z4IYySEvO5ud7oEMfmMZ0w-1; Mon, 14 Jul 2025 19:06:56 -0400
X-MC-Unique: z4IYySEvO5ud7oEMfmMZ0w-1
X-Mimecast-MFC-AGG-ID: z4IYySEvO5ud7oEMfmMZ0w_1752534415
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4561c67daebso4306215e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534414; x=1753139214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPL2XqQemou8iuVCHR8eDk7k61bY1QQbrF+6LyUB5KM=;
 b=j8/4Q3RpLMRisOSZFNW84vU2/khjh7/mGMb90Ng1iV5kd6B4WQxn4uKQ6cEloBtQig
 Qhs7y8U5nVdmHsTEdWsIpcrEwDxKEmQosX2cQfjt74c9Z2m0NmyyDQy2JTjqhEirWDXw
 ozbO3FSUWEkvQQ5c27rjkascyg+JFtFd9/JcIZX2yPJ3Ua/OUGQTKZVmt4ZelAnTCpvj
 1kYtPQ4mMz5UDmpOBDB0ONP3QrYUSkEaEsJXl08lnteJRHxCVyMHyPFAdCF0/Fsww8Ia
 MAQpapW2p5S6EKm8FGoX2u9PjzoJ12wxkVakfWER29tt/c5btKG58y1NB01OtelJZzjP
 pnUA==
X-Gm-Message-State: AOJu0YwM8Z9HnPGK7lXDzhRRr9GjfpHDBhMcozABx/huR4Pue+ZbZ3az
 P5Ebxc4EZOgy2Uk6s0BRYW/Q6WS/WoWJbeORs92PmLUzq68rFfReH28T8CkLpglf6UBKYV5bH7B
 SE65pYP+jhGDOOHg99YNkprMK6FgKJY9vWjtyC6eJShm6kCYVEGVpLc7UDhYY9Kn6DjKQm7GmYY
 kSEeDP5QEGLniVYigSDg6sfMd+oasK/1QtbQ==
X-Gm-Gg: ASbGncv9kpFl+W+hpKI8EMRed8+6KEDj1I/GHl4a2L0HepggEy/9zZwzDTQdwO2aYga
 +F5DnyXA/svRtazRvRHOXekyK/cq6PASPpZMqPJWdOBmR/vJleB9gK3Fb9Rfz7FzS/1ox77gry6
 3wRgfzgoKOx8YAjgVe01mjVnygt5+NOkBVrBuuRwj4UkjrLqMS60y+dP55kOzX9QM9nBY2AWkr4
 qUyeWL6vu+jKGbThsbdkCsWIk3tflcHPtqIQpIFcGjaC3vZt8B5FdxYwRkN4ERkCqR/IuZOP3jQ
 PNyNx5MkX6w/Rt/J5tgIeUXn1l5v+0+Q
X-Received: by 2002:a05:600c:c4a7:b0:456:189e:223a with SMTP id
 5b1f17b1804b1-45625e69aafmr11936245e9.10.1752534414360; 
 Mon, 14 Jul 2025 16:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6QF3+rqlFFUoMscPIQZG60Lld4e3OOMpEkCsffDLAWynHH7WCJ/WOc80JfUN53oDuV1jynA==
X-Received: by 2002:a05:600c:c4a7:b0:456:189e:223a with SMTP id
 5b1f17b1804b1-45625e69aafmr11936125e9.10.1752534413966; 
 Mon, 14 Jul 2025 16:06:53 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d289sm13782074f8f.55.2025.07.14.16.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:06:52 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:06:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 15/97] tests/acpi: Remove stale allowed tables
Message-ID: <85240876b2f6f9edd72a6f324cac0ee9ee28ab0a.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Remove stale allowed tables for LoongArch virt machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20250612090321.3416594-6-maobibo@loongson.cn>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bad1380eec..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,9 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/loongarch64/virt/APIC",
-"tests/data/acpi/loongarch64/virt/DSDT",
-"tests/data/acpi/loongarch64/virt/FACP",
-"tests/data/acpi/loongarch64/virt/MCFG",
-"tests/data/acpi/loongarch64/virt/PPTT",
-"tests/data/acpi/loongarch64/virt/SLIT",
-"tests/data/acpi/loongarch64/virt/SPCR",
-"tests/data/acpi/loongarch64/virt/SRAT",
-- 
MST


