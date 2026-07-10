Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02602C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi61N-0004Od-9c; Fri, 10 Jul 2026 03:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wi61K-0004OV-U3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:51:39 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wi61I-0001oK-N9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 03:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MD+hxfXqR1r49qidM5Uw2s309JVBFw6zV8MBkoOrXF2bZnBjY57l5VoAFdeEcqs8X7E7uLQxjkSX6vFlDNX8FMYVlnKWH5Uh4pLa09gHsWndCImlSPSFIF4zsLiZsKg8p7lPGtdrpoKRB3FIw5ukk5QN2I/EuCDf9LxNvd1x5FCSzp8rkuTVenhna+x0cJkLqvaiM5mz/RZV050C28yxEmY7licUo2kcusWZ7uLpisaDw2O/Ti2/mHYiELxaf0J+IwxU4jvSFjp+LMRLmDp5NBBH5YKfHFDk2/F5TnaoBcSMEMEmQ1gGdBRjsnAEDaJ711zfpZLckZEwTRo2TlLjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaJto9UyZTIoXR4PzIkhbYx0Y1DdpzXHTteb+QQ99So=;
 b=dsSJf2rJnFlhovF0FvcfaYoBI+5JBlBQtuzoa8WMtooU6thrB1ja1u8zNEDYdzME+WI1FZOKzhz09M+24FltTe/NGP1mI7DJk6Tow2iKfLfwoc1tjxvq9kfJynzk0sc+uZZ1juA2vK7PlWPCj2rDDw3mS/86ww+XdDgCG6vaimfCVdSnut0DWeVA9/L/SSDIQZU2zWv9tztF+DmQU6fj4UUtK9HfmkQdMNnrOP2OTE2460X0YbCzKtDGbN6wlMuochJm6wOZL0+9MOuWI9f8y7eMPClScX7r04iIStIVR/8JkS9vy53KleRZdO0sz9KBeU4rUkeQ8Zh6Zo25wqtU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaJto9UyZTIoXR4PzIkhbYx0Y1DdpzXHTteb+QQ99So=;
 b=jEhKFaty1gzJ9w96+SNpOVJqxoRg7lj08v4bZx8R4CnzSOoAJmCvQ46sbzRTN71MWZcHk+f9iXRt1ouBpmjt8j1jxcXeUoNAcKEQDSmMxprUd9AaPm7i2sfUSeOUlDG6cXOHUcsIKp7hW6eOTf3qxM86ON9dVgZ/xrSmCmJ8ohg=
Received: from BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::28)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 07:51:29 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::40) by BLAP220CA0023.outlook.office365.com
 (2603:10b6:208:32c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Fri,
 10 Jul 2026 07:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:51:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:51:28 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via
 Frontend Transport; Fri, 10 Jul 2026 02:51:27 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, "Pierrick
 Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Frederic Konrad <frederic.konrad@amd.com>
Subject: [PATCH] meson.build: re-add explicit gcrypt/nettle request check
Date: Fri, 10 Jul 2026 09:51:12 +0200
Message-ID: <20260710075113.35631-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c775a9-4d4d-47de-1c1e-08dede580d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sYqbEp7zovSQV/nx99Ki+MlYdbV9dnBVmSRPkUuOcRS6D+emIQQfValrL2vnIYXEPqq+iL3oTa+BE/6cfaPPimkVRsk1doy55qJXpEqsU1UCx1uuzGtspCZo2viwpsTBOwQkeB589L1fa0Rk1uZJ9sfwavcBgczSBPZ1IJWoX6GN3iB0nEj/J+1EUZ3vNGX2vcxiKG62bG9y24z5AuUixsRagejHdVyBuiZxCX9Y68JRwVJ9CfWlzGu/zlSSkR62mxsZQr/oKtqV9iiUiABrC49BVDLbAXSkJeOceW+bpojqfb6Nnl0QWjnpw9ia1C0SiQxXJaI8c5Wq2XrwTMQiv163woY8kiB7VLk9TEYvcK6mJ2xVKlgGwt+rd+dA+50PPY2/bm/uNEuGfsRg9ioNpvJwm9/p8gmEm+NQEc6oAybsPYfWEfNGU47ybhmfnxUegL5EMjEArpGMNUfbPjN4sYlId3HCzxTQ3xSzWbwaNedJOb3l/f5jhReKMob/cwUlmseavImnPojHzh/etHW9kqIlwb3urvxcUrxk23RH6xo021DqWfUjgarFTH9S3JmZ5+2RKNs/eoyxIXzPeJQwoaYt9ri2lCCpi6Khwl3M8bj0jnwOc+IIdOCFQ+vEDle8Jdf1/uwJXTUsSqsugDCxjiDVtsyTV7UBKZ+5IHKPue8VaJC8LScZ6BqeiWUpRj5iK1rtwUcnNuwXxN+ejc4dXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ir4SgHO5nTu9WwqJN26BoOAuLmZyY4Xe1L7GL+0iyqEJsNsdeGvav/pC0+9QWjK5wXSvzAWBpQi/GB88qFIlA8My9rp5UhbcH76i2lrKjUkOeFxa7zxfPkm5Q0NLD5xIunqN8+V3lMoQVD2Usy2GHfEDUt6f3hXymnZRrMx3jvnJn/B+K0AXFJ+YU1YX89hFRjAxsayJxlFkpp3ewqaBXewqKUOxjdVpAO5X40MRzJKX+T8ux2sQyX9P4pFzwVQW/kjuEzth3MaEwnmeG1uZLSkKXdty/BxyrYcngYEoM8EUgmaLV2WEhvRfaZRnFwZlkKN/IhTNM18jgvDFi7yhXg+qB/oMvEdwFM54kTzUtmXbVbUQ5kepz48FGlBkZttfwsK5a8PU6G6AFM6SOq3GjNUlVfmsP0kYt8QINHQdGrgT8sSxsteF6f20KS44iBPm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:51:29.1972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c775a9-4d4d-47de-1c1e-08dede580d28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Luc.Michel@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

c4b3d0074 removed the check that nettle or gcrypt were explicitly
requested as the crypto library to use, breaking the --enable-nettle and
--enable-gcrypt options. Re-add the check.

Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
 meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/meson.build b/meson.build
index 164328ded83..475c5922030 100644
--- a/meson.build
+++ b/meson.build
@@ -1809,10 +1809,15 @@ crypto_sm3 = not_found
 
 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
   error('Only one of gcrypt & nettle can be enabled')
 endif
 
+# Explicit nettle/gcrypt request, so ignore gnutls for crypto
+if get_option('nettle').enabled() or get_option('gcrypt').enabled()
+  gnutls = not_found
+endif
+
 if not gnutls.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.9.4',
                         required: get_option('gcrypt'))
     # Debian has removed -lgpg-error from libgcrypt-config
-- 
2.53.0


