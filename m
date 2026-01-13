Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26C1CF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfTaS-0006cZ-MZ; Mon, 12 Jan 2026 20:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTaP-0006cC-7e
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:52:45 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vfTaL-0006GH-9J
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:52:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rF045M9R2q+5kafdRtrjgE9HLtyepsZ1uUlzwhYKRf0kWmWXHsh4r55xBzlpbowYSrbbREwZn80fqYmygpSEEAmwULHfmTTi9BVyWPW23kdYobjLfNM9VWjVgbuXcy/ZeyuaB4GdL55Rlww2a6Vqb9uBhxlXk4RuZfatDvHDLKT7Hzfl3YKlYGlvyJ6zmXenflVWPR6hO6qfIVxIcSmOmHFjdaDGuvX9d/Ji9QWx3Z6mmj02NbRUrgpovCtkMkVLgAk0vYwYqbVBQG4Yww4NVNAPFpQzT+JtsVci7xMdrbRpj9REX+tKxDho2e+YJqSUhBMGOJ7Ed5fxurIXCpwk+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEX8m8fGGshdR7ZHUegkKnaKfi8rXuueZp+LhgZ89+o=;
 b=f8OFV0Bu1RF4DYC9gHbdwM//SiBVPBM1Pi3/Yp7afnJwpvbC/jcnJKJtpsEcoJmLVgm54OPlJlZhiBszaRyMZ0cOGmIVGsOAhQ9pbN9zzHxlpNTm438Hk0frEWgKGyuxePR5GE+yQjnQdMjwzxbB/mG7D0WD6yO3lPSGEu7y3d7NKO33ZzPRF6TdLH53SNAZVm48xmxZjYIckl9KAIzioJV40SoSaBWShp7c2NmQjLNeqZ3dKVvWAexUgk8wS8GhGoCnkq7fbXXNI4hghB7yS7mYnbfGHn7dj3EV7f3bYt6bta+DBl/EilY7zCEveKpwB4cJGMW7XKPC/N10SJ9LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEX8m8fGGshdR7ZHUegkKnaKfi8rXuueZp+LhgZ89+o=;
 b=2gSEhrV/87nj1A7WKnaRZEbphAqDnBb1KtNQ/2h1Mku19Pb9+vSk3KUM67voIaLRC5itH/IPiu9ZN0KpJZe/5i1bapRKM9VYcU4EyiSKoc7gSaTtgu5E+9tYPyNdcXoJIt/+THZ20uz8kt20qy9JmOaOuAC5r3NAqOYHo6iP3eA=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by CH1PR12MB9695.namprd12.prod.outlook.com (2603:10b6:610:2af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:52:35 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::c3) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 01:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 01:52:34 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 19:52:31 -0600
From: Honglei Huang <honghuan@amd.com>
To: <alex.bennee@linaro.org>, <dmitry.osipenko@collabora.com>,
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, <armbru@redhat.com>
CC: <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel@nongnu.org>, <Ray.Huang@amd.com>, Honglei Huang
 <honghuan@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [v6 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
Date: Tue, 13 Jan 2026 09:52:03 +0800
Message-ID: <20260113015203.3643608-3-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113015203.3643608-1-honghuan@amd.com>
References: <20260113015203.3643608-1-honghuan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CH1PR12MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: 1683a47e-279c-4c8b-4654-08de52466c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QU41THkxVWwxV2hxT3RsMWxEY0s1YlA3YTZwNlY0aDBwcktRSUFQMHptNHh0?=
 =?utf-8?B?K1BNZ1dlcE8vL3poamdnbnZXam5KbXJHSHRZL29kNVpWaDlzbktFdXVnUTNw?=
 =?utf-8?B?WWszSTBRbVE0aGVYUVNJdDZicXJqbjIvcGU0R2tybm5HTUEvbitBajZicHgy?=
 =?utf-8?B?bEJ4THdVOXIzZnRxeXJxZjlYVjVESmlDVjR6NHgwYWFxTFNQNHI5YWR2RS8y?=
 =?utf-8?B?SGVyUjloZWdnT0JaS1Y3S0huTHdCZFl0V2hacDFqMld0MFZOU3FhbFlNS3Yw?=
 =?utf-8?B?dUxPZldxVGZEUTVoMkRBNUVPSkREYkhCampwcE40Tk1VMktlKzNwaFl4eXdT?=
 =?utf-8?B?b1ZiLytwMGd6cW4wc0paT0dFdzRudFlLYlR4azVNNUd4S2ZQUEhDK0l2Uk1q?=
 =?utf-8?B?Zmg5Q1FtQUNvV1hNTjhVTzQ5K0wzM0FaQWRPME12cmIwVFMyaWxaSi9wbTZw?=
 =?utf-8?B?R1RQdUFGMHFIR2h5VjVyMmUwVnEyeDl4SjRTbS9NckdWU1lBdHZWa2Z2eW5q?=
 =?utf-8?B?dWdpL1Q4ZlJxTVNzRUVBZ3Y0cmROa2d4a00rV2hTWHJ1WndFV3NLUmFaaUZY?=
 =?utf-8?B?a0RFUTBqbC8vbi8yL1oxOFNrTWoyVWlPUWxWNjA3V2Jscng5SmpUdXU5VHp1?=
 =?utf-8?B?TytQcjRsODEzQzI1UVdsK0l3RklTeEJ6S3dEV002MHlGSWl6TXZPZzI1TU12?=
 =?utf-8?B?V3drYWpnYXJBRkxoczFpQng0UHRXcllTK0J0SlFydmFMbyt3Um1FVzFVNWFa?=
 =?utf-8?B?NkZIN1F3QngrdFowckhxSzJlMEZvV0xqTjNVVzNNdHBDMjhPZ3VNdS9NbVZG?=
 =?utf-8?B?aHlSUG1PK2FjYWZ4OVNFTzFKWjJnOUsva1o0Q0xwbVk2YXpvNTN6bEl2cDFJ?=
 =?utf-8?B?TE14UUdndjl3Z0g5Ky91RW9FMlpPL3dJekxWT283STB6Y09vTWtrQ3gxMGw5?=
 =?utf-8?B?N2NJVDkzWXplZ0gvT1c3NEtYeksyOU5XQTlzTVpnNUlIUjF5ZUVTWXNUcXdr?=
 =?utf-8?B?RVNuaHRaSSszVEdZSm8zckt0anZVVm1udnpwZ3dFWURTdi91ZmtvdTVPRkNt?=
 =?utf-8?B?UGlqQmFjVUlmejJqVGw2Q1RYSXdyNVdEalVrODlZUndDdGRUNzFqNnBMUEx5?=
 =?utf-8?B?SnFvWmgvWW1iQ3AwaU94ZGNLUGpPTnVBbDRXWXIzcXhYZ3pFaEsyZHEyMktX?=
 =?utf-8?B?VzhOM2x4WUx2eml5Sk9XNEpQa3kvM1dlYnRGclh1cXlqdlpRVkhUWE9CWWhs?=
 =?utf-8?B?aythcWVpWGFrdjkyNDJ4VWRKK1ZvMXpoTk1wS1F3RGt2NDRIdjZsNEpuSStK?=
 =?utf-8?B?bFhWaWdRT2VyYmlJVTR2R2dJWHdUckZKZHU5dW4zUWxtM3doWDRXSzZubDk0?=
 =?utf-8?B?VWhQNkZRbjcwOUVQVDUwSzMyZHlmK0NMU0c0ZmQrNml0cTh1a1NyOFJPcGJF?=
 =?utf-8?B?ZHdkcG9uTE1HdGxhTnpRZzVPd0pmNzc0RVlkNmY3RGpETEdRclZZWkpsclRy?=
 =?utf-8?B?Y2NiSjZic0JoNlg5eXV3dWJCY29DY0dTVTRUZlI3MC9LSTlxTGpZWCtWUkE5?=
 =?utf-8?B?MDBVbnFUbkRaR0wrNzdIdzMvczNySW1pWlpJbFFGQWs3Z1RhU1h3ekxQVXBi?=
 =?utf-8?B?bjBNWlJyWmtQdVRnV3lRRGhMWXVzZGtzN0NES1VVQ1M4WlVqSkgzK0tIOUQ5?=
 =?utf-8?B?WFdTVGtMSEdxc2VLVkZORzRQQVRiS1pIclVTM0ZvRFBIQmt5RDdPWm0yV3o3?=
 =?utf-8?B?ODBKbXp3eGpOMmJLUmQ4eWxGUkZsK0xySkNuem1GM0lOdXk5YTR2OUxFa09l?=
 =?utf-8?B?UG5lNmZBM2U0aVZ0aGJrUmVqbnJMNXpKYTBOdFU2eXhvVkVPTDBSTzhOekFs?=
 =?utf-8?B?OTRDTFNDNWRVdHNKMWF4R000WWVucjlrWHI4amtnV2tvWlFhKzBvWS8wOGZN?=
 =?utf-8?B?aUxYbG1QMmxhQ3o2N2xsdEVzVVlqaUFEZ1E4dkd0VndGdHNlVCtkSTF2aUhh?=
 =?utf-8?B?bVJKSnNQQzlITlhMeG5NNWxHZkpmRjlrR3JmQXhqK1ljVFVFd3p2VFFqR2Fi?=
 =?utf-8?B?YmFWTDI1QWtYUTd5bThndHVhZDNzcDRUUVovU0ZUNkwvS2xNTEFuYmwyU3p5?=
 =?utf-8?Q?m6Q0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:52:34.8413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1683a47e-279c-4c8b-4654-08de52466c34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9695
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Unify error checking style for virtio_gpu_create_mapping_iov() across the
codebase to improve consistency and readability.

virtio_gpu_create_mapping_iov() returns 0 on success and negative values
on error. The original code used inconsistent patterns for checking errors:
- Some used 'if (ret != 0)' in virtio-gpu-virgl.c and virtio-gpu.c
- Some used 'CHECK(!ret, cmd)' in virtio-gpu-rutabaga.c

For if-statement checks, change to 'if (ret < 0)' which is the preferred
QEMU coding convention for functions that return 0 on success and negative
on error. This makes the return value convention immediately clear to code
readers.

For CHECK macro usage in virtio-gpu-rutabaga.c, keep the original
'CHECK(!ret, cmd)' pattern as it is more concise and consistent with other
error checks in the same file.

Updated locations:
- hw/display/virtio-gpu-virgl.c: virgl_resource_attach_backing()
- hw/display/virtio-gpu-virgl.c: virgl_cmd_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_create_blob()
- hw/display/virtio-gpu.c: virtio_gpu_resource_attach_backing()

Signed-off-by: Honglei Huang <honghuan@amd.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 4 ++--
 hw/display/virtio-gpu.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index e60e1059df..6ebd9293e5 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -557,7 +557,7 @@ static void virgl_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
                                         cmd, NULL, &res_iovs, &res_niov);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
@@ -701,7 +701,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                             cmd, &res->base.addrs,
                                             &res->base.iov, &res->base.iov_cnt);
-        if (ret != 0) {
+        if (ret < 0) {
             cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 0a1a625b0e..1038c6a49f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -352,7 +352,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
     ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
                                         cmd, &res->addrs, &res->iov,
                                         &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         g_free(res);
         return;
@@ -931,7 +931,7 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
 
     ret = virtio_gpu_create_mapping_iov(g, ab.nr_entries, sizeof(ab), cmd,
                                         &res->addrs, &res->iov, &res->iov_cnt);
-    if (ret != 0) {
+    if (ret < 0) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
     }
-- 
2.34.1


