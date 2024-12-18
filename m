Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD2E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2ZG-00037s-NI; Wed, 18 Dec 2024 17:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tO2Z9-00033n-8C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:52 -0500
Received: from mail-bn8nam12on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tO2Yu-0002YQ-Lu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:30:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7ChWEN6xYzbyAngF+kx1jVbzgj/hcXj2HtITsb0lJeVu8S3JGt3Wn2OEeKabW8uDyT/8PK4f5Z80Noy7MY1KEdgy79sP/ZjnR20EHhFmd5X3rKO6mTA8GGZv/FRyWyEvmVUq/smhrivkuQCR+YzoIt7tyKsT2GPCPniwltZV/Ip6OmxS9xiniG8JFmE+0yVirn51GDaBZST+XfXW+6LOHOmZkeKtCLkvHuhHYCk4djBMRIuX3wjpgBBobfmlzTPeqZntuuzIIH5lE9v4ikuloPuzjHkZF0W+twjfMl/g/AlScpRSdIc2GizV+FA4cdfa53Q7ZRgaA4xko4DdSNhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TFi1xDkLezLfz4Fm0/7n8YihFX+OnXb/GLPqDPCuPU=;
 b=QfuBREjDmyp09+mTBGiOLgluSOAN2/q2lh9HpSz8LPEJbsMD+DNAEE9t3JdxBwdEq0kv2ikMcjX3DeQQ0nQNRNUZf9A48LJ4l0nQngT53+leS9apKT2X0AfwVNr96ltG4EVNpgkpd3qY4hdWqmiahrdbAAEI8WAkjkMsEM5BXKs53Lx6GSwWIrFGjYRfRtfwT2fF6mh1mcMl6lLrj7X0/+uaQuwGbNfjI/5wxMVcR3QHQ/AhyfN1xxPJBGI07/jLfRgODQigdzG5HN9iRJyOH0tAB/qAhW5IZNEZZpSGH0mmjw8Vv7ynEiLVkUlz+PdbLIYvTdHNBvXFnIEE9slDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TFi1xDkLezLfz4Fm0/7n8YihFX+OnXb/GLPqDPCuPU=;
 b=j8m627aHTRZ/VgTO3uNxg1CSufXRKeQdlOvZjnw/CdlABUianYLFrpXTGR1LlTjPiWgk2yKIdOnVzzz6p5tDk4gSxRl5QSqMyjVGwqbrUefwJwjLVqMLxVoovBKyZS8ylieO/OmdeKmYdeH2+VdQ5ycfqTh6HXij91feHkW+TTs=
Received: from CH0PR08CA0011.namprd08.prod.outlook.com (2603:10b6:610:33::16)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 22:30:28 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::96) by CH0PR08CA0011.outlook.office365.com
 (2603:10b6:610:33::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 22:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 22:30:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 16:30:27 -0600
Date: Wed, 18 Dec 2024 16:29:51 -0600
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Message-ID: <20241218222951.v6yjhcd7j6uojcs4@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
 <Z2MLfIFzzyEWEy5T@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2MLfIFzzyEWEy5T@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 3060ee72-51c3-4b89-92ac-08dd1fb392f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?VpyXbfqc2nSeX+vJdAYlq4Q6dV0JcQlw+lQIkxP7dcA4WEM5ybcpIzrh5Q?=
 =?iso-8859-1?Q?jtUykXnoMAADRrkoHGHcrkBtgiMswifn8Hi4L8JklDEG93WVPZMooGI/yo?=
 =?iso-8859-1?Q?3gPoXZWrD0lPOuqWc4TXdqdNJ7NzXj7nDp2QngsarDvlQUYNQCiJU6CrYQ?=
 =?iso-8859-1?Q?ELMieC+g9J0N6bSXWRFDjmINKfTv/JCnD0Hw96hxKY7N0QEZHNcQv1ae9l?=
 =?iso-8859-1?Q?fapl1p0QX67Db6cx50mTIoXtP5R08dHpbzoWw094V3HIj65mojl6pbMeU0?=
 =?iso-8859-1?Q?6lXEKmHJUrT7eegs20NMzaCWasdldk9Hxihjz21p0EFCe/d0U4EnYo8q2l?=
 =?iso-8859-1?Q?vDgh8b+GqebqVqNP55rqqq36DsPV+ByAthKLicW/VsXT8bDyTIzllsNbhR?=
 =?iso-8859-1?Q?BGQkZ5BNAzSnx8cElEaELL1n1APLmFExlIwFITs3bb3eQmH2Pp9zBjx86S?=
 =?iso-8859-1?Q?gLs7PWvqxZBZMqk49ccccGXaK1Syj9eoSZANWU30CMGoYdmeL0aJlKVgEQ?=
 =?iso-8859-1?Q?zkHFDfOBUWsyzZFfS7OsvxwnD/rDyo5O/KYOjuPj9zDq/fULaowc+qDELK?=
 =?iso-8859-1?Q?M5IErmoEoY/+yBvJDsjZ5q4rkbax6gdQWTqt8RkAEqHiiymtwkxRpU7IXZ?=
 =?iso-8859-1?Q?lKKvzZ3pjIGcL3OvW9wzpiEf3AAV6JrNqU42FoCDsxCaASVXkyR2A0++Av?=
 =?iso-8859-1?Q?l3qLiZ4pCs+VO3EchOpewgA6ac45NWBQJ1N8luWO9ODy8rfRMJnGkvcbg+?=
 =?iso-8859-1?Q?W3t4ujM6S6gQtKhh9D5StoE+kvCELuX/jNt307o1h3HAGYYBYCYOJjRZ7I?=
 =?iso-8859-1?Q?KGhvX6XWqdslVWOf0S80M4r8W3cQpo3OUZa1nW7t09TtUsVZVvhiX1Es9v?=
 =?iso-8859-1?Q?TXKNgbSQz2awnpYv2KvPmBKu0FBT35by/N+Uz9ry5Nzb6Ikfe7yvPDtzQa?=
 =?iso-8859-1?Q?8w8IHS95ee1DmYKXUgrNr/UpE+eT8WfOzQ/mn5roVIZc3XpsQH6Vj92eQf?=
 =?iso-8859-1?Q?7/fO1NWkWt5LqVfYGxCxMwzLIDbJAs5oy9Yi3pO1MJxX+VIvQv3XD8ceYm?=
 =?iso-8859-1?Q?ffJ5+J8Hnl3O3792A6jyHPIzOpgf/cxtcC6Bc/wrkM2i06YBFci7QhJi2M?=
 =?iso-8859-1?Q?ub92aWX9RAgVWtrDtOCXiJiMTSMgmwqBWBYKZQ4wQibtJI2rpkHZjO3+Lt?=
 =?iso-8859-1?Q?3DCn7QbpMN1PLUn60+xS3K6cURbftS+35EZKNVZIIynCmEQOAuECoKGD2k?=
 =?iso-8859-1?Q?dr9lvGCdQAKc3LvtFa0ku7wgygABiubDduseMdWmbxNeHoZ0zNTCqvBwo+?=
 =?iso-8859-1?Q?UCXYxvGyt2B/x/6vZS6tX9Al+eMi+Y9gQnTm8HbPzY2hMSClHSTCd/2Y+q?=
 =?iso-8859-1?Q?7WlIcnMleCus65ULpM0IM/VI32NasaiYHQUtWgiaMGEJafACUdAFoHfjf8?=
 =?iso-8859-1?Q?YUw/urP/XMeweRvPGNIECWaZ43qyF5ehaqjl6MmiMJAdIYymBW20oWbhsF?=
 =?iso-8859-1?Q?Yu7DGx5IngsJbBaIjH9jHl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 22:30:28.0675 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3060ee72-51c3-4b89-92ac-08dd1fb392f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
Received-SPF: permerror client-ip=2a01:111:f403:2418::61f;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Dec 18, 2024 at 05:50:52PM +0000, Daniel P. Berrangé wrote:
> On Wed, Dec 18, 2024 at 09:49:39AM -0600, Michael Roth wrote:
> > The GHCB specification[1] defines a VMGEXIT-based Guest Request
> > hypercall to allow an SNP guest to issue encrypted requests directly to
> > SNP firmware to do things like query the attestation report for the
> > guest. These are generally handled purely in the kernel.
> > 
> > In some some cases, it's useful for the host to be able to additionally
> > supply the certificate chain for the signing key that SNP firmware uses
> > to sign these attestation reports. To allow for this, the GHCB
> > specification defines an Extended Guest Request where this certificate
> > data can be provided in a special format described in the GHCB spec.
> > This certificate data may be global or guest-specific depending on how
> > the guest was configured. Rather than providing interfaces to manage
> > these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> > to request the certificate contents from userspace. Implement support
> > for that here.
> > 
> > To synchronize delivery of the certificates to the guest in a way where
> > they will not be rendered invalid by updates to SNP firmware or
> > attestation singing/endorsement keys by management tools outside the
> > purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> > obtain a shared/read lock on the certificate file prior to delivering
> > them back to KVM. Only after this will the attestation report be
> > retrieved from firmware and bundled with the certificate data, so QEMU
> > must continue to hold the file lock until KVM confirms that the
> > attestation report has been retrieved/bundled. This confirmation is done
> > by way of the kvm_immediate_exit callback infrastructure that was
> > introduced in a previous patch.
> > 
> > [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
> >     https://www.amd.com/en/developer/sev.html
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > ---
> >  qapi/qom.json                 |  23 +++-
> >  target/i386/kvm/kvm.c         |  10 ++
> >  target/i386/sev-sysemu-stub.c |   5 +
> >  target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
> >  target/i386/sev.h             |   2 +
> >  5 files changed, 288 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 28ce24cd8d..6eaf0e7721 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -1034,6 +1034,25 @@
> >  #     firmware.  Set this to true to disable the use of VCEK.
> >  #     (default: false) (since: 9.1)
> >  #
> > +# @certs-path: Path to certificate data that can be passed to guests via
> > +#              SNP Extended Guest Requests. File should be in the format
> > +#              described in the GHCB specification. (default: none)
> > +#              (since: 10.0)
> 
> Can we document the required format here explicitly, rather than expecting
> users to go searching for specs which are often practically impossible
> to find, and even harder to read & interpret ?

It'll be difficult to summarize in a way that will be self-reliant,
since knowing the certificate format is not sufficient to make sure
it coincides with the endorsement key being used by firmware. So I can't
promise to completely reduce reliance on external specs, but at least
give a better of the format and where those external specs will come
into play in filling out the data.

If it needs to be at least somewhat self-sufficient then that might
warrant a separate document in docs/system/i386/amd-memory-encryption.rst
or somewhere thereabouts that summarizes the whole attestation flow and
how certificates tie into that.

Any preferences?

> 
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 1a4eb1ada6..2c41bdbccf 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -157,6 +157,9 @@ struct SevSnpGuestState {
> >      char *id_auth_base64;
> >      uint8_t *id_auth;
> >      char *host_data;
> > +    char *certs_path;
> > +    int certs_fd;
> > +    uint32_t certs_timeout;
> >  
> >      struct kvm_sev_snp_launch_start kvm_start_conf;
> >      struct kvm_sev_snp_launch_finish kvm_finish_conf;
> > @@ -1355,6 +1358,215 @@ sev_snp_launch_finish(SevCommonState *sev_common)
> >      }
> >  }
> >  
> > +static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
> > +{
> > +    int fd, ret;
> > +
> > +    if (sev_snp_guest->certs_fd != -1) {
> > +        return 0;
> > +    }
> > +
> > +    fd = qemu_open(sev_snp_guest->certs_path, O_RDONLY, NULL);
> > +    if (fd == -1) {
> > +        error_report("Unable to open certificate blob at path %s, ret %d",
> > +                     sev_snp_guest->certs_path, fd);
> > +        return fd;
> > +    }
> > +
> > +    ret = qemu_lock_fd(fd, 0, 0, false);
> > +    if (ret == -EAGAIN || ret == -EACCES) {
> > +        ret = -EAGAIN;
> > +        goto out_close;
> > +    } else if (ret) {
> > +        goto out_close;
> > +    }
> 
> This locking scheme is likely unsafe. Consider this sequence
> 
>   * QEMU runs qemu_open(path)
>   * External mgmt app runs unlink(path)
>   * External mgmt app runs open(path)
>   * External mgmt app runs lock(fd)
>   * QEMU runs qemu_lock_fd(fd)
> 
> QEMU has successfully acquired a lock on an FD that corresponds to a
> deleted file, not the current existing file.
> 
> Avoiding this problem requires either that the external mgmt app agrees
> to *NEVER* unlink() the files under any circumstance, or for QEMU to
> run its open + lock logic in a loop, checking 'stat' and 'fstat' before
> opening and after locking, in order to detect a replaced file from its
> changed inode.
> 
> I'm not inclined to rely on mgmt apps never unlink()ing as that's to
> easy to mess up IMHO.

Yah I went into more detail in my response to Markus, but long story
short is that we are assuming mgmt is cooperative in this case, and
so as you mentioned, it would never unlink files while SNP guests are
running, but instead take an exclusive lock on them and update them in
place with the understanding that doing anything otherwise would open
a race window where guests might get stale certificates.

-Mike

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

