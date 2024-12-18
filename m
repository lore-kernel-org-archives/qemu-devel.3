Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852DBE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwOO-00041Q-6q; Wed, 18 Dec 2024 10:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwOM-0003uw-0B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:55:19 -0500
Received: from mail-co1nam11on2045.outbound.protection.outlook.com
 ([40.107.220.45] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwOG-0007at-Rc
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjoWazJiucBPc0SIqu7ZY3cS7racqVDB8SZa5TiwA+Zd14xypbhJHE19xW1cu+hkTi6fOfs3Bb/ty2N/rosAeImsNWPjJ26sBsHhOqvlYhtP85QJtYogdDZ4KT1MVdWCoSngH2rk36MHkT8Ywf/lPLAMleY49BSQugbVnu8q6XTMMWULHBWTd7TEBnNHEM/4aO6DnArZ9h67PizRhaW5l9hc+iw5CRUokjr2UhvXr9r1hTLq/s2uAASqCDZzZAQwrvwOmo6WnD5sw6XOkkCA3cR4KlySex0MSxGV23ButZPzVnlidrBdwGVQcCJpakRNNulxLUY/wMgw1ZHWrE9gsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3l/anm9ZYRgjiXIb5ECwV1hWqMLrcxPdqtfxWPqkz0=;
 b=jUyxvXHCkOElpXiCavRExKWwTEAfYFUzz7ibn/QfXOKZb46NTmjSUHWEHDQy0UvUyCl3VRNehgGh2ccTSXu1YNTZvDbwotRnJg6pjuErbpenL/a9dfhGnWEHy79+RTrfNWX6kspeaYZ+Xzm1lKpSgXUIccqSDNZILHPUhpOIl2+Nq3PNXUHuphjRf3JfEJX29esDhuE9NgenOw+2UqeGTH1lFnBHmhwvWzb7ZBx0FWOpae4GNvqteNBjLZFHWhdm5BDl7X0RWL8ADSMDSHZtGezPN1UlTTcyL/S+KIkzO1NFxlRlAG5/rfAxW5+XQNhUX9vEmO6wzHtn9gVDYImDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3l/anm9ZYRgjiXIb5ECwV1hWqMLrcxPdqtfxWPqkz0=;
 b=wyiBADbmMdI25US+Kus+hBw6+IngJ7QLS+QZ02DKxXnD5grUaiTMbxUJf7/Z2yTNymKuR9rwo7I5UNgv6+20bGUp2xnAxrztHwJaLmBdbO68ZM9pLBL3eSBnf0tL3LV2oJL0tS3Aa3k3uWm7kijQ4O74btea9LXiu66dyL1ylKA=
Received: from BN8PR07CA0029.namprd07.prod.outlook.com (2603:10b6:408:ac::42)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Wed, 18 Dec
 2024 15:50:00 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::24) by BN8PR07CA0029.outlook.office365.com
 (2603:10b6:408:ac::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 15:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:50:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 09:49:59 -0600
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: [PATCH RFC v1 0/3] SEV-SNP: Add support for SNP certificate fetching
Date: Wed, 18 Dec 2024 09:49:36 -0600
Message-ID: <20241218154939.1114831-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ef574d-8cfa-4b6e-8520-08dd1f7ba126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pvpb67WpXtWlEs2gVyNG5pRiE9pb0+KL6TxxU2BKBSPTq+wsokaoYZkOV7yT?=
 =?us-ascii?Q?2wQBXav+CXIZPGvO7k6h5lTizbD2sXtyBbi8K6MqN+nHqhr5k8lofLHQyfT7?=
 =?us-ascii?Q?5kBBR8XXwtBAn6unVqPE8fNO7sm1cbDbsvBSb8qLJDwDP4bsV28JsZLStZvc?=
 =?us-ascii?Q?NLAzhHUpG+S9r+qaTpC5bWsOFDOX1+kzgoIRUceq3cB2UDHFBBsNsOS1VgIp?=
 =?us-ascii?Q?U138JcZYeunjPPG7iH5cGCalQFs28zzj7Orxh8GJCgJgqAOGxGm05XKJt9rf?=
 =?us-ascii?Q?1FM1rUZebaQXJeQY5FnNASENs8LhhaRWsTw5rzzF7eTPgAL7BaWl2y4nC3Jh?=
 =?us-ascii?Q?IEgTzY+EmqYM/GVI/2SLDXYrOcBo12VsO2q6Tw2VOlL//ObXgxEXoTisEZJa?=
 =?us-ascii?Q?PtDtwKd0ccooZLRrKlAW1ft6d7/D7aMS5AXDmzsxJnh/KwZoD71M8Jz7EXBb?=
 =?us-ascii?Q?OK2j2v4/oYyChWwsoTTkIaFZq711MA/+9hf1iyP8JIp6xWwq1v0+NnCDW2fA?=
 =?us-ascii?Q?Q4jllRfTf2CmLsv/TxBkomn3sHNg//TN6bZxANQODFO+Cb1O8H4xWldkZZ70?=
 =?us-ascii?Q?lktmeLESDRGug3cau4YklUtxk1viimZDTTZzA/+DMLKPdGHf1WmCl4mN7zK5?=
 =?us-ascii?Q?PBQKG1cKgqNNHqAVfEK/u3BmPQZZVDr2vaP6tXQ4KApyskpW5h/b4RUFrf8U?=
 =?us-ascii?Q?vonidiyEsPrHSmujUBcvUycBxukplt1Y0f08k3UY1NDDFJljEoM/QfhTjq4w?=
 =?us-ascii?Q?2Kuo9T1VeA9Af10GkmDD3kSssopxkJXGkNCiHmlm5IK6I6kZlDghM25M2r9e?=
 =?us-ascii?Q?fXKo/Ly7/Y3+iWVU3cYeRBxoxZsdBG21EoKZGOC7j3QKCXfDcBxwlm5E96VN?=
 =?us-ascii?Q?6mECNkzizVEIMr59Dtlypj8hAPgYXuGL64GVxAaQ8hoFijVpcqcuGuMTIMOZ?=
 =?us-ascii?Q?NLnVmij34tFaxvisJCE4JtptXILpBWoxyZxZvV4r+QImn9EpIee+pVojl5YV?=
 =?us-ascii?Q?0ZjN+asN+Y5Ztmzc6klLp+KcHWyXmkGrv9pz564bL8VwJDK87k23lW8aO2Ht?=
 =?us-ascii?Q?Dr27KRZXeTgcDngV/mP0bN6+9T+79XbNP+LRNKp701c08F34pozJDnsCbJqv?=
 =?us-ascii?Q?lnTPziv+OA2vU5xRvJEaEqvxupli06mmI85Gv6hsL2W+iVbR9nr/b8v6qa4A?=
 =?us-ascii?Q?mzMlHg4fLiSYTNPxyhJ34N/3WRDOFL3KOdq7phb0AF/1aH96WruegPiXWnBJ?=
 =?us-ascii?Q?uqP6c3Ii/MHEGQFFrAVl7G4yP0si3wOaLXgkhmAbLSc6zwalOEsNjnnYPEpy?=
 =?us-ascii?Q?q6EgSULQD3vlVu1IjaXiMqLG79nHSdlEMnGpbw5WfIIQkV29FsrqU0vS2Lpu?=
 =?us-ascii?Q?A3CNBdmOXFikMkkmPV3gNgzG6egM1mFh+Tyc5jgT3OpoFWmnUQjgdnthsrZB?=
 =?us-ascii?Q?rLXFc/Er1ksGWlRdmEPqMUb6sZ1oEfZf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:50:00.0948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ef574d-8cfa-4b6e-8520-08dd1f7ba126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
Received-SPF: permerror client-ip=40.107.220.45;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

This patchset is also available at:

  https://github.com/amdese/qemu/commits/snp-certs-rfc1

and is based on top of qemu master (8032c78e556c)


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

-Mike


----------------------------------------------------------------
Michael Roth (1):
      i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for certificate-fetching

 qapi/qom.json                 |  23 +++-
 target/i386/kvm/kvm.c         |  10 ++
 target/i386/sev-sysemu-stub.c |   5 +
 target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev.h             |   2 +
 5 files changed, 288 insertions(+), 1 deletion(-)





