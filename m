Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF15C0218B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZzo1-0006zr-Pm; Mon, 20 Jan 2025 16:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzRw-0002Dg-Bl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:36:52 -0500
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com
 ([40.107.94.49] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzRt-0002PY-MD
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwH9GfUmLD07YcvKtBdUkWNw3wXLUVtcTkM/KZ+PLcyr0MZPv8zRYCbBITK1luPHMtd8vThoFvXUhby4i+hjjCFO+qx16ADcx40qv+E8VgVFlvd29M1dNp2wSAyOJnqiWx9/hZGH7Z79cTWhLh80jj4Xz/GM3VXOAeRkVcBRmjKhH7iPAkDOvPLqUYB2ERle4TtWLZNX17UPkMOwZ6Pv0XjUfHQtuCHUXN/pXU/6ciPH2bmWX/IYnzhgforTBUNdWCg29Svp3xo7JcgjOKQ8HYZZeoDZ/1uc7iB7xdM+zUaqCZUCu25YCq1zoLbHaolji/pAL6M1qz5/uRk/QaXyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkN0kETK4FYLVdivoNDUGZ0u0viRnxS05EHhYVLgfgg=;
 b=lzhYHrw0L3X1OCHaAPItVrhaY74qEV1sIifN2U36Fjm+a4aABuzCzUSGXYVXE/pWum9LkVGf2T/zluXMJHuL7bjB3NY0s+8fYkGPjvzIlvWGPclivTpD7q3fhS2+pDyfw4ju5v7G1wMBuLfCVU6JF2MZF8PTyLkl70bk/iFseUdOwqXlcmvP4iSXGO9aKEqt7ZeLID91wUKE5Z7zOdj72hOQ8p3L/I3bvyImiEon8XTJ6YOeKkp+qFuDmAcPKrHUqyXZj7JSnU5ky8c2QwMQ3GiXz9e5pbvDrfvRTInjB1RODG2kuYu2h+RsxlpfSIvuGqu6po58vFEo+6Nnj1NNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkN0kETK4FYLVdivoNDUGZ0u0viRnxS05EHhYVLgfgg=;
 b=cal6AACjzDBFhm0famxreEXhn1Q3X1UWoIkZb83xo/9DMMmafhRmaetUn2xTpfsptkWEAWxSteGWlTwBFXEOoT+zk5nxWBl+bDnPpxKVGEM6l9tQpGXjJpVS/ph42F7twesr//s+U96yWn9ht6TdvH1/XaTxmmmescgFSJFe0QI=
Received: from MN2PR20CA0007.namprd20.prod.outlook.com (2603:10b6:208:e8::20)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Mon, 20 Jan
 2025 21:31:34 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::ba) by MN2PR20CA0007.outlook.office365.com
 (2603:10b6:208:e8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.17 via Frontend Transport; Mon,
 20 Jan 2025 21:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 21:31:34 +0000
Received: from ruby-9130host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 15:31:33 -0600
From: Melody Wang <huibo.wang@amd.com>
To: <qemu-devel@nongnu.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <jroedel@suse.com>,
 <michael.roth@amd.com>, Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH v2 0/3] SEV-SNP: Add support for SNP certificate fetching
Date: Mon, 20 Jan 2025 21:31:13 +0000
Message-ID: <20250120213116.521519-1-huibo.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: ce745378-d46c-432c-05a1-08dd3999d05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnJhcGFJU0Q4SlEyYzNCTzkrckJRbTlCZm5sQzBWdEtZenVmOUxzdVU4bVlX?=
 =?utf-8?B?ZHFabWF4RGNNQXJ4RHhKaXlIUnM3L0NTWEd4TzVKa1F4eEoxQzlMRWdGeEpX?=
 =?utf-8?B?bWFMbzdzdHMyNjRmVFExWlNTWEpTV1ZCWWJQOUFWYm10aVNtc0Y3eXNYTFdS?=
 =?utf-8?B?NVZMRG1BK2ZVaU0yU1g5dStuWUpueUxiUW1OWktFdGRhaFdvSm1CNWZZVjJl?=
 =?utf-8?B?UTEyeHl0UGRBT1BWem5uckFYdE1oVStOanU0YlR4aXZFeXFiMndXVEJSeTRD?=
 =?utf-8?B?MUdLaDYwOWxYN2pXRy9hR1l6ejd0bFBrZmdyTFl2YmkwUW1VUVZNZU1udzln?=
 =?utf-8?B?UlRDdlFYMTM3dHV2V3BPSmk4YkVOZUQ4YXlmbWlTaFdnWXJ1dkhyZ1JMK1VD?=
 =?utf-8?B?VTVEVk9HdnlacUJIUmpmd2hSbS8yckZYM2l6K1VHKzk3OUJrQjIyeWk3U1Bn?=
 =?utf-8?B?K1FUQjR5T1dRN2JNdUxJSFFnSitqY0FkOHlIMWltWFVyTXhuTGJjTllHM1pQ?=
 =?utf-8?B?RHdaMDZSTFJNdjgxMWVUY1h1RUFXZGU5dndDMWd6Q2dzRWNndHVOaE9SNk81?=
 =?utf-8?B?ZWJhQzFobitOdm9CeWFYN1dCTXEzN0pWeHJ6d2tNenVHbWJBZ3VZWEFJZ2o5?=
 =?utf-8?B?T1B3THFld3A3YWlBaWFUQmxCa0RCRlhvNXg4MmNZUmUzVHJ5dHNMeDM4cnhL?=
 =?utf-8?B?c210bk5IQzZpblhDc3hENDBMbWxNcnkxUTYyaVpXRHhBYTJRcHAvaTVZTnhk?=
 =?utf-8?B?Wi90NjJJaXFmelJIM09UN00wWmFTNkE3cWlmSDZLbG1EQ0ZINmNydFRCYXZ6?=
 =?utf-8?B?czNiNTRtSURkS05rOTIzQU9pK1Z2MUx4UGhiQThFNFRvb0R0V3VxaHNoS1Zr?=
 =?utf-8?B?dGlCdldYb2xMVzNEdXV3dFNNK0NoTWxURzNadDdFemZHRHNUQ09aVTBndFUz?=
 =?utf-8?B?dnBrOHVFSWNRZHJoYjJQN0t0NnVqRUQ4VzB5aHF3QlBybkZHS1Ftelh1eEhC?=
 =?utf-8?B?Q1U1K2h5RXVlUzYyaytXU2pnTW01VUx4R0NtQ2tmVER6OWN3c2xhM0VYeCtM?=
 =?utf-8?B?cmMvdjJoRDZIQk5UNlk5dFhxZm43QlF6UWdLVlIwZHNHM1BSd0hySXFtVVdy?=
 =?utf-8?B?a3Z0bFJMVmE4MDJZdVhzWmczK3MwM0QxY2cyZ2FOb2FobEp4aDRLOTVQdW1P?=
 =?utf-8?B?T1liaUVVcWhvTUN1SFlnN0FYVS9EVXk2ejJrYlYzVGVzU3ZJUWZCdjBraUlE?=
 =?utf-8?B?bkJyV3dNVnpBZTdGK1JrNEdJbWNnRy9iTklReXVPSjdiUjFOZ1BId1VTMWhi?=
 =?utf-8?B?VDJuLzJIcjltN3o2MElTM3BRdVNOWTBJamJ0RDlqcm1OUWoxVXVEblhpVDNx?=
 =?utf-8?B?ZjY5SldBemYrM3hiazZ6SGhmaXZFUHI5akYzc003a0VhaWlpUERsMGljTWxm?=
 =?utf-8?B?S1VUMytTSjhGcUUzbEp1dHRTSXNUUlFkbnJBK2hmd1llSEF5YkxVNjVNTThj?=
 =?utf-8?B?QlVETFllMTVCYU56YVFYcGY0NFZIMlI5RklXUWxsZXRtZ25maWxPRitGR041?=
 =?utf-8?B?ZVV1alBKMEZmZk9STGpFOGRuZzZyY002N3ZkOTdWNWIwajRmbDFmTkZPaS9C?=
 =?utf-8?B?WU8zaUFOUTlFRVlsZ1ZNZ0hkeFp1M1hyRVNQQ044NjMwaWJrSHh3akY0TTQ5?=
 =?utf-8?B?QVJnSGtaNXZsU3FZWjJCb3ZNdklsMTdsZ2g5ejNzQ00yNFQwWXNmK2pyM2V1?=
 =?utf-8?B?U2N1d3gvaVRRMXJ2RVBGcjVpc1BOSDJCVUxHMDQwNDkzYmtBd2VNMFJ1bFp4?=
 =?utf-8?B?eDlDSHZobWVxaHZkWmtlOGhocUhKWUpsTndXLzNHV2tUUjZCWWlNS1NtSW9E?=
 =?utf-8?B?K283QjdXZWpGb3o3UExxUkU1bHZuMzJnMU8rdk5UN2RKRVMySmxlYXZUMFJV?=
 =?utf-8?Q?QSWf8vc6j4FMCGMu+JzHMpZUzLfrjmHp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:31:34.4037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce745378-d46c-432c-05a1-08dd3999d05a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
Received-SPF: permerror client-ip=40.107.94.49;
 envelope-from=Huibo.Wang@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jan 2025 16:59:27 -0500
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

This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-certs-rfc2

and is based on top of qemu master (7433709a1477)


Overview
--------

The GHCB 2.0 specification defines 2 GHCB request types to allow SNP guests
to send encrypted messages/requests to firmware: SNP Guest Requests and SNP
Extended Guest Requests. These encrypted messages are used for things like
servicing attestation requests issued by the guest. Implementing support for
these is required to be fully GHCB-compliant.

For the most part, KVM only needs to handle forwarding these requests to
firmware (to be issued via the SNP_GUEST_REQUEST firmware command defined
in the SEV-SNP Firmware ABI), and then forwarding the encrypted response to
the guest.

However, in the case of SNP Extended Guest Requests, the host is also
able to provide the certificate data corresponding to the endorsement key
used by firmware to sign attestation report requests. This certificate data
is provided by userspace because:

  1) It allows for different keys/key types to be used for each particular
     guest with requiring any sort of KVM API to configure the certificate
     table in advance on a per-guest basis.

  2) It provides additional flexibility with how attestation requests might
     be handled during live migration where the certificate data for
     source/dest might be different.

  3) It allows all synchronization between certificates and firmware/signing
     key updates to be handled purely by userspace rather than requiring
     some in-kernel mechanism to facilitate it. [1]

To support fetching certificate data from userspace, a new KVM
KVM_EXIT_SNP_REQ_CERTS exit type is used to fetch the data similarly to
KVM_EXIT_MMIO/etc, with an associate KVM capability to detect/enable the
exits depending on whether userspace has been configured to provide
certificate data.

Add support for this exit in QEMU. Additionally, because some of the locking
behavior relies on kvm_immediate_exit, add an some infrastructure to allow
for callbacks to be registered and executed upon a kvm_immediate_exit-induced
exit from KVM.

See the Documentation in the related KVM patches for more details on the
expected usage and kvm_immediate_exit handling:

  https://lore.kernel.org/kvm/20241218152226.1113411-1-michael.roth@amd.com/#t

[1] https://lore.kernel.org/kvm/ZS614OSoritrE1d2@google.com/


Testing
-------

For testing this, use the following host kernel:

  https://github.com/amdese/linux/commits/snp-certs-v3

For the guest, any 5.19 or newer kernel will do.

A basic command-line invocation for an SNP guest with certificate data
supplied would be:

 qemu-system-x86_64 -smp 32,maxcpus=255 -cpu EPYC-Milan-v2
  -machine q35,confidential-guest-support=sev0,memory-backend=ram1
  -object memory-backend-memfd,id=ram1,size=4G,share=true,reserve=false
  -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,id-auth=,certs-path=/home/mroth/cert.blob
  -bios OVMF.fd

Something like the following simple example can be used to simulate an
exclusive lock being held on the certificate by management tools performing an
update:

  #include <stdlib.h>
  #include <stdio.h>
  #define __USE_GNU
  #include <fcntl.h>
  #include <unistd.h>
  #include <errno.h>
  #include <stdbool.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  
  int main(int argc, void **argv)
  {
      int ret, fd, i = 0;
      char *path = argv[1];
  
      struct flock fl = {
          .l_whence = SEEK_SET,
          .l_start = 0,
          .l_len = 0,
          .l_type = F_WRLCK
      };
  
      fd = open(path, O_RDWR);
      ret = fcntl(fd, F_OFD_SETLK, &fl);
      if (ret) {
          printf("error locking file, ret %d errno %d\n", ret, errno);
          return ret;
      }
  
      while (true) {
          i++;
          printf("now holding lock (%d seconds elapsed)...\n", i);
          usleep(1000 * 1000);
      }
  
      return 0;
  }

For requesting attestation with certificate data attached, you can use
something like the following tool/workflow:

  https://github.com/virtee/snpguest?tab=readme-ov-file#extended-attestation-workflow

The format of the certificate blob is defined in the GHCB 2.0 specification,
but if it's not being parsed on the guest-side then random data will suffice
for testing the KVM bits.

Any feedback/review is appreciated.

Thanks!

-Melody

Changes from v1 to v2:

- Recreation race problem: Add a while(1) loop using the libvirt example
  with fstat and stat for the locking certificate blob code in
  open_certs_locked() to fix the recreation race problem suggested by
  Daniel P. Berrangé.
- Fix the json format and filename suggested by Markus Armbruster.
- Some text formulation comments.

Michael Roth (3):
  linux-headers: Update for 6.12 and SNP certificate support
  accel/kvm: Add kvm_immediate_exit callback infrastructure
  i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for certificate-fetching

 accel/kvm/kvm-all.c           |  43 ++++++
 include/system/kvm.h          |   3 +
 linux-headers/linux/kvm.h     |  10 ++
 qapi/qom.json                 |  21 ++-
 target/i386/kvm/kvm.c         |  10 ++
 target/i386/sev-system-stub.c |   5 +
 target/i386/sev.c             | 277 ++++++++++++++++++++++++++++++++++
 target/i386/sev.h             |   2 +-
 8 files changed, 369 insertions(+), 2 deletions(-)

-- 
2.34.1


