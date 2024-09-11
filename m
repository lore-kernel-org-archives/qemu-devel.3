Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3294EE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOoH-0000Oj-9w; Wed, 11 Sep 2024 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhn-0007KT-NZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhi-0007EU-Uv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ycrQIYgW1gN05eLNxaUg6SdKNvOfcU2FQLbxdjG4Rw=;
 b=BcxKmx2N0Xbp0chQzZaHeaWPbpJqIxPpEvJsWxYX+qYx9xreD7KnndhcDa6pQu1XAg5beI
 HhwSbnoLAu0vwk6kNdsLd//+1Gf5xy26t59ezRlzqYCvCnmUjTDPlW3x4EPq2kvdzF4Blk
 wCJPsz8HrJW/UJuaKWCrjlWnHJj8v2g=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-5mNS_49oPDCgvbWvTk6fXg-1; Wed, 11 Sep 2024 09:52:00 -0400
X-MC-Unique: 5mNS_49oPDCgvbWvTk6fXg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5c3c256e2a3so5362107a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062719; x=1726667519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ycrQIYgW1gN05eLNxaUg6SdKNvOfcU2FQLbxdjG4Rw=;
 b=PZpqkqMvVyvRjbl/0ov+f7XZFWncAallft1XNd6a1nwsoH+EqBMPe3Q1xh1DApEyff
 XEbvmUGyU9VII9Cy2tb1m+EdRuCJe3I8GRxMj4oCOqNZKyqUTgxv2quncwJ+eI2MkB1U
 JKEE5Aq8jXJOAmpbSRQ/FvfKbZiUnORbFYq7J7TN7Endg1puTxHc3pFzbuMbrUOrPZ9z
 kB/FLwf+P0hEyA0ibknTWzd+6MSzYacVO3zjwb+iyMlWtsLUVGlRrYAE/H6AHzRvuaMh
 KWkk7rXNAVjNvEbodHso5ocwGGX+exUIyfkpVWL1fDOPHMz1jdYDqZ525spyn5OVQ1Pl
 OxIw==
X-Gm-Message-State: AOJu0Yz+mB92nwhpP1/qKOWfiKHnZkEKIlaKRlcevhv8ihoEMIK4aFEj
 yaOitnpvxiHWvMpvPijuEfoNk83+yi+nNINTo07EBzCqd6n7q5RRXWe/4L4o2dikS39/m/ppfQh
 9N+uXv1zNNeAIo+ohMZ1J4jP/hhPOED4xfOd6PsGd9wElT/eHOtd2dlVmE6Icx3C2O2nM1mzoiO
 HDSkogVK7Czy8v/raG6+gKfNJy2GBj5w==
X-Received: by 2002:a05:6402:2551:b0:5c2:769a:df79 with SMTP id
 4fb4d7f45d1cf-5c3dc7c6c83mr12618121a12.32.1726062718815; 
 Wed, 11 Sep 2024 06:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa1U2meNUnhGlkhb8QGTZBePl0Blwq+nl0sH21K51an8Q2T6CcuWRGWK3mDSR+gMZEoY/yrA==
X-Received: by 2002:a05:6402:2551:b0:5c2:769a:df79 with SMTP id
 4fb4d7f45d1cf-5c3dc7c6c83mr12618092a12.32.1726062718157; 
 Wed, 11 Sep 2024 06:51:58 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cdebsm5375494a12.95.2024.09.11.06.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:57 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 10/18] tests/acpi: pc: allow DSDT acpi table changes
Message-ID: <ae77a40e3c7f010d1d18a92806246654f92b6f26.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ricardo Ribalda <ribalda@chromium.org>

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Message-Id: <20240814115736.1580337-2-ribalda@chromium.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..f81f4e2469 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,16 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.viot",
-- 
MST


