Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B43D6ACD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 14:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYO-0003it-1e; Wed, 27 Nov 2024 08:58:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYM-0003iL-6m
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYK-0007kF-O9
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSBqlGSMGO71ouqzAy5nufmGT2K8poJn0RVdXU6iYP0=;
 b=bzFbGOihZLNFdu6NOJ93Q8VEoQa7aShb9F9z2DKXs88kmHrcUpw1yDMVu0jf1dW7m07frW
 oT9fPmsMwr2qNEmG6CeEGXVyyCPijbGh03GPOLN1IIvTYvWAkl+Sf2pDfJ6F2zI2OCXO8t
 BY28s+Du1Vypdq5vyFUHTF0Adi3fj7U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665--JdigCxeNEqeDF_Ue7Oyzg-1; Wed, 27 Nov 2024 08:57:58 -0500
X-MC-Unique: -JdigCxeNEqeDF_Ue7Oyzg-1
X-Mimecast-MFC-AGG-ID: -JdigCxeNEqeDF_Ue7Oyzg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38243a4ba7cso3612087f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715877; x=1733320677;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSBqlGSMGO71ouqzAy5nufmGT2K8poJn0RVdXU6iYP0=;
 b=jb92QiWFa/dPNJZCzHF6f6URrjmj07KpRtavcqJ+rsWNh9KUN4c7Yh+aAtwz211yio
 bZM7PkJOdHuX0auDRpBQkI6r38tGU6iPaq5sUx6w23MqzsWRRCseN4qxRXzJuiHyt7+R
 QRn+uh+2xQOf8SmoJ7ZsAXbJQpJeSqXMpbfL0RIQa8dO7+gPy8Beb6KXjwX2sfNlHFyf
 0D43dBsM+jlS+c7pB02508aIL1AxComdeClQo9UN/hX4GSPYrDaMON22fzm9ccdSr2av
 ESsVD2lalghBcevB3hEKlPqKGJtz4ZJPCJzb1V7mvpRnhPWa3R01HFEvuJvfeP9yfPcs
 uSAQ==
X-Gm-Message-State: AOJu0YwySFH229Nf50cmgyZeeq4ys3WQok6w/7SupsRaNY1uv0HoZ8cN
 1jWo4pH54VyAphiM3YPqkaA84TnWP1bKJf/6ZFocxjzEzVw1O6HvqVWcT/JXRd8pMah1Nh0CtUp
 Qd1Ey3Qgp+LELsqtLWQhYWErrpmCJnjYRRHQ607vZ2kOOP4zeYwQ5a+cI/8al2dizg1hE8Ac/zH
 vQTROe/qJySuIDS0+n/rGnZ9DMirVNOlGR
X-Gm-Gg: ASbGncsSEQsGLWDydcdkIb4YbrW2Iocaib9ZfQ3IF+aXUfjXxXb4ymkRprTqbWIuTpj
 AcLHzd48fYpeN7ei5WHU6x8/1gtJ4Y/pmiu6XCE5pFPxnegak+wgYfeDngOQc/Wh1i6J2qzIet+
 RkL/+hPxTaYgqsPRwAqUVFgx17/aftEMSUq1cvT4fw/4uQE/0bqTjXNC/vgYcH2+41yU+wgIhCr
 owxSuJ2rbiajC+Rvi4f0BLqNUMgjxPXryLcvjPnBOoc
X-Received: by 2002:a5d:6f06:0:b0:382:383e:850e with SMTP id
 ffacd0b85a97d-385c6ebcb69mr2665392f8f.13.1732715877323; 
 Wed, 27 Nov 2024 05:57:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg/2F7t+g1Gf9CMhMX1i0I+XZTOpGkQP/Q+oLvE+8IB528S/TwUgNV3COpO8AxqVw/qU+CVA==
X-Received: by 2002:a5d:6f06:0:b0:382:383e:850e with SMTP id
 ffacd0b85a97d-385c6ebcb69mr2665371f8f.13.1732715876933; 
 Wed, 27 Nov 2024 05:57:56 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedce3sm16353473f8f.97.2024.11.27.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:56 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 10/13] bios-tables-test: Allow for new acpihmat-generic-x test
 data.
Message-ID: <2cb740932c567b57f6f51c9ead036a1d31d3e620.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The test to be added exercises many corner cases of the SRAT and HMAT table
generation.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241107123446.902801-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h     | 5 +++++
 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x | 0
 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x | 0
 6 files changed, 5 insertions(+)
 create mode 100644 tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
 create mode 100644 tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..3c0967078f 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,6 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/APIC.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x",
diff --git a/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x b/tests/data/acpi/x86/q35/APIC.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/CEDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x b/tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/HMAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x b/tests/data/acpi/x86/q35/SRAT.acpihmat-generic-x
new file mode 100644
index 0000000000..e69de29bb2
-- 
MST


