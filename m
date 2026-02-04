Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED6FEA7943
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAS-0007h0-Q4; Wed, 04 Feb 2026 14:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAG-0007ST-M6
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniAF-0007sb-5Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdyYS3Pk1FuMAygMwTfkSPyp7PDdnzEguqKZ3ur3qG0=;
 b=H7Hk+ht4IGni1OUqNT8jd82gynmdLe0D4ntYovJQ2kX707irVP/8BbIKH7MjdVU8opmsa7
 DpSTiRmYqxaSNuyC3/yQL2dCD1znDITsRm7oq0S7c2m/CrcXaKgPYsoWFPm8oGpzCZngfQ
 GppWLWrTYnhpzcjvoHC2Q7MkRaGux4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-7cmci8NaM6-NZkKGShmNwQ-1; Wed, 04 Feb 2026 14:03:44 -0500
X-MC-Unique: 7cmci8NaM6-NZkKGShmNwQ-1
X-Mimecast-MFC-AGG-ID: 7cmci8NaM6-NZkKGShmNwQ_1770231822
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4806865a01bso1120995e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231822; x=1770836622; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CdyYS3Pk1FuMAygMwTfkSPyp7PDdnzEguqKZ3ur3qG0=;
 b=OpRLuMa1U6tsSfbfHJGoJxqpqwusa+TTncz2YgygoOoWPeT0ZPU5lfDo7Ilz8qm7XW
 MDLzfTVigvzPWgDCBiHoZfze1hOMqppe4sobOwxxrrF3z2/aySQMmcmtFW6dTD9swH3t
 aHvgpHZRK0D8jgb716+5wtfSI+gDW9SCr6Wl1/JELssowK/AvrRnYk/6ZlWL1EJDkagM
 KxK7G1EBvpMelqAmZxnwCJUO1QtA03zspfX1Nb/80Es1H54beMrQ+ru3/zF3WqMHq6xZ
 X6UK5d8ihBlFL/af7vNMaK2VVxK3CDATcWQZmvPiSbLvyTZHC7SSOIjbMbihHeoOvrrD
 bX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231822; x=1770836622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdyYS3Pk1FuMAygMwTfkSPyp7PDdnzEguqKZ3ur3qG0=;
 b=b0EVHyVI5nP2qQgBi6zx2stLi46uq1ru6dGUJDBit6E+NHhqRmfoyRMkKYY0wWAnMz
 OSOuaQKuGrVlX96h3Hbsb8pBzIZdYeJq+9BWHq5msoxJ5YhTYT6nucXJNFT9sJ3F1h0s
 ZnRG1eHe93HugMrvSi2sk4/8mWnLtjIITH3wIcPaOwaEgczXqS209AKGQ/JLkkfHvU8T
 4/NeR9lAlcFIDTAHFiYHVV4yqY5OT4pyRL8Nd7GixPyLX5uWSZFcvNUeZeUR/fW9X6J8
 hwHCzo0YzJ0yqD7E5XCNi1kwbBKmqVvLBmw9mEyqlfT4r5BbQBXtisBILmm1ACPtr9G1
 a+YQ==
X-Gm-Message-State: AOJu0Yzp4P62i2VAPJ0haF36CxsBHHBbFkmJalUujvM/8RGVw8KtOR7i
 dlMpMvTgwHObFWNGoUdcMET7rlfWHz9Ks7ObzBzBRCS2XTCKm7XpKpht/sfwAO7faK3DmyKQZWw
 mqUI3zyQ6sRidd0KpD4Hzm2rqg9vFa169Nv5rkWxX2C0jl1XqFMYgdNiTKyJAdgwxNxsqrb8XhK
 umYaNfz4W5YqUigo7feBguP2Mtk3yvYJHfkQ==
X-Gm-Gg: AZuq6aKbODawLtpzdpp5O/Y+BbJ7ELJbg+JW1f7y+mI9hpShvuI/79cnBkDVKeTSefx
 EKUK9lVv2z2+ksE7AvATATjaA8sjGUNZeq+Eg3RKKpcqZGbZy+SrfCzyhdtBrDBIDHJyeV6KPpD
 81SNGDlMX6SVbPdgvrj+3XMThULmu0f3uaavAq3U2IakYn7OHp2/5HyiSvsINo0WjbtlNLNmyXv
 RhFEFSAx27N8NRomPhfsBZVfO2nPPmZR+0qhV2vceHXr3jll0dXEzfmQ6/68VSXRzojGQXJBrM5
 vAsmmO6qsE+h5243+knY4H37We0rB/skEb4oNfuqwKgpZsxfF7+bjA5vnWAuxis9LT0vEafq37P
 kdBMWHqpzb5Zd4qHRyY+PCGMQqyB2YfqrhQ==
X-Received: by 2002:a05:6000:1a8c:b0:432:dc1f:6982 with SMTP id
 ffacd0b85a97d-43617e3c35cmr5483700f8f.16.1770231821953; 
 Wed, 04 Feb 2026 11:03:41 -0800 (PST)
X-Received: by 2002:a05:6000:1a8c:b0:432:dc1f:6982 with SMTP id
 ffacd0b85a97d-43617e3c35cmr5483649f8f.16.1770231821395; 
 Wed, 04 Feb 2026 11:03:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f93sm8042619f8f.24.2026.02.04.11.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:40 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 22/51] tests: x86: q35: acpi: add WDAT table test case
Message-ID: <8edd47eff924cddd9e0cb8ace4ab8e62ae9b7f61.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251030123750.136175-5-imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  1 +
 tests/qtest/bios-tables-test.c              | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..14b680debe 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/q35/WDAT.wdat",
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e489d94331..99cd714aa7 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2511,6 +2511,18 @@ static void test_acpi_isapc_smbios_legacy(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_wdat(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .arch    = "x86",
+        .variant = ".wdat",
+    };
+
+    test_acpi_one("-global ICH9-LPC.wdat=on", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2805,6 +2817,7 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/cxl", test_acpi_q35_cxl);
 #endif
             qtest_add_func("acpi/q35/slic", test_acpi_q35_slic);
+            qtest_add_func("acpi/q35/wdat", test_acpi_q35_wdat);
         }
         if (qtest_has_machine("microvm")) {
             qtest_add_func("acpi/microvm", test_acpi_microvm_tcg);
-- 
MST


