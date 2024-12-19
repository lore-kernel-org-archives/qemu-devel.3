Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B2EE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKkL-0004QS-SN; Thu, 19 Dec 2024 12:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tOKkK-0004QF-W5
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:55:37 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com
 ([40.107.223.63] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tOKkH-0004r7-3h
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:55:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1sYOfFUsk49Qo8nMTDEQHHeL9rLmMFDrL2bq4xYWRXWrcbm9s3oYcKGwlUkH6kVKYyAQP9lAKP2vJAluipZRCQcbhOePUzFwDSiCmAeSO3mm2sUzsVHSL5z+JEoEdzcN3vhAF6N9xRbZgSYn8+wXBwnXlviTWzo1p2EkyAgVCJfiVwW5idtdqZyW4GUEZ0XCn9Q4o2t/U3XSwawch1A6jk3OcVhtOvK1fHfR6soe9KRcArx02vfQAUf7Tqlb5y0p9Z/w6G/5S9M0WYLKYVyoBODKaRKy5fuExusDGfKp4CugGWVxr9f+rDJIk0Af6dEBO2ynuQu/ibp/HgfOCTtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUBP3TxbCqeyjX9kltdxR8QOAlpyW+9WyxOg+77y5FE=;
 b=OjKmNzxC6NuvJrE6hW4AGihvs3pNWVp9Cg7gJub+RmxfSq5kcH3FC4NA8JYIrovRdWua2i6unS8aloNPQmticrsT4LiZgG2Lxc++2w2RcJ9MOVwjF51bfJ+ViUzmSiH7Xrti7tWxSCFkO9X6FxNZIz5VyiF+TOrLOu+s/lUgv8FFxoayRV4e1hg+Dx4KXZ4Wq5enMhuHBV3cyhhE7QPA8DhcFpT0ChXFg9A6bULJCzw5DlNBi3WI4FQ8I2CJjab8kdcLHFIKlx4Dn8kWlkg6sfrJo9Tc6J9zn2TPLy5MsTQj/2EspClZ3onetzsifvEBo5rkm75H/jVEBBZSsluLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUBP3TxbCqeyjX9kltdxR8QOAlpyW+9WyxOg+77y5FE=;
 b=NcPyxNPqH+lOOh10oyPPWGhSz63nNBHj4+Q+p1OXcQi6oU990IkCwIZ5k9/1u8SNXgZo6Rv+G6dmgJuV2iBw4mmavQYViiTu6q9DQW2GaGpwzBp7XriA4fvuCJg/S1yErBXzbogUfxz7+xfB4bJtXeO5ngIv4+Ywh8OvlyXpxJQ=
Received: from SA9PR13CA0161.namprd13.prod.outlook.com (2603:10b6:806:28::16)
 by MW4PR12MB7484.namprd12.prod.outlook.com (2603:10b6:303:212::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 17:50:21 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:28:cafe::fb) by SA9PR13CA0161.outlook.office365.com
 (2603:10b6:806:28::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.11 via Frontend Transport; Thu,
 19 Dec 2024 17:50:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 17:50:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Dec
 2024 11:50:19 -0600
Date: Thu, 19 Dec 2024 11:49:49 -0600
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>, <dionnaglaze@google.com>
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Message-ID: <20241219174949.wtmw7gosb4hkfjxg@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
 <Z2MLfIFzzyEWEy5T@redhat.com>
 <20241218222951.v6yjhcd7j6uojcs4@amd.com>
 <Z2PVprpxdfa9MQR5@redhat.com>
 <20241219131601.ckebfuxy5ukpdcml@amd.com>
 <Z2QhjkgMQ0JDJYkb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2QhjkgMQ0JDJYkb@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|MW4PR12MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: e73f063a-4706-4c9f-a7e5-08dd20559b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?z8ZQzWADivzO/lAwR1Z+4c4yaPCrRA+LJMYlBPuX8Br6KzkjKpYGs57Ny2?=
 =?iso-8859-1?Q?HB3LsoMc5xtzP0Mf+oae/yZUUFCn/NuFZynCa+z3xmdUwS+Kl0isYYBjEr?=
 =?iso-8859-1?Q?5s93JLJmwKFQ9P9IOjJzqVQsOSw+ZD4XnAm0BXMrEkUEYIBOnGlPzLdAyY?=
 =?iso-8859-1?Q?ge1mydUttzecDns6/y33TKeWVo+3TWzV638dNJRKKiNQzJIivlp0z6D23I?=
 =?iso-8859-1?Q?Rfu2V2m6abqQq5H1nUoZThdDVGuCFz49ef8RJY1yEk2NLz/l5rvJ+B4Ohu?=
 =?iso-8859-1?Q?PGK3z91oPyxUtzCqUFLaVro4Y6Gh/EwKrPIk9BX3S0IsXVDTlz5M1tzOCw?=
 =?iso-8859-1?Q?O/X2vaH30NBg4C9ZclrkXGBziHUy/kNE56Abgc3UBfwhZ71imLs9jZP9SS?=
 =?iso-8859-1?Q?tgD7pgcwCTG+hP28kRKsMkpE8FgPSJF0g661yQVCcCRlKpTd4s9SNFxO/q?=
 =?iso-8859-1?Q?gnZGsgsVMs9l7Pke9/Sr9V/CE6OJP8A4k98+fO2rTKNJL6vlcikm3MUIGy?=
 =?iso-8859-1?Q?tGumrqC6KgAITLXzDR5tYytKaVDTAsVZSGHkkaENa/FBusK0vYgMlEefZr?=
 =?iso-8859-1?Q?pRQ9IN0/jYqZoGh/OW+ZzXMD8VmknKqaffTcDnt3nXidtMg28aJbiOFcVg?=
 =?iso-8859-1?Q?r/eUcPn3t8WaXsYPPZLkEAn6ddxSjCoGsmWV87d6cl2GpIEzJdkgnNDLIX?=
 =?iso-8859-1?Q?9bM0kepoNhOIu6BqkrXVhVCdVnWtpo/3KRQrNqA4vj30wWCgz8uYLQlq+p?=
 =?iso-8859-1?Q?nmFslhuJGdXlj/xkgadToN2Fu8W0KyV78EJxxJypuF4xpAaCMdJGeS3R8I?=
 =?iso-8859-1?Q?39jtDjXsLjzfZrDGZUfmHTIAYje6QVV8P0PARXxSyKDUj4T8Bu4ONAcaUd?=
 =?iso-8859-1?Q?BH77tpdM+V9/vhizCRKA8KGMTP49+W363oEjoU2RswD9OFRL2zgdMOqhQh?=
 =?iso-8859-1?Q?87sQlgmfgxWDBGbzlWAvdoJWLcWaV0u9VjgV2fmXpcuWgWIXAMTTc+W/3Y?=
 =?iso-8859-1?Q?/F0TP6QYAfc8rlQpZLSsiF0fVozLS5Rcj+mgH+CrYst08VioFxFgQ33IuS?=
 =?iso-8859-1?Q?B57tqeqZj3PLydkqhmxI6n9E0aRWzINzUQURpIIrwJWO+ASePH0/DtuZPk?=
 =?iso-8859-1?Q?Ov1vwAjnVcjq1O1tKEgHPxPhrVOOQOIUw5rQqMow6CboFmg61zf9ukJV+T?=
 =?iso-8859-1?Q?1L6lqKCl5C/c/BhkRfiHKQ1i5qotDZiouP8+5mYstESZOoeRoT+OgNJ2ZI?=
 =?iso-8859-1?Q?iMRyG5ds8FUGdMzllugbaia+S1V6KkmLFjhcpRKBKWRAT9Vj6yFjlaCX5m?=
 =?iso-8859-1?Q?CiYsETht6o+Mk+weqVYVvUFuSv5oj1oCWzOF4ZhZjrTxRPQGY177MEF1f9?=
 =?iso-8859-1?Q?YvzcYVkbn0l71rJa/lSiMlAgEOz3QtEezESDH3hn/38mCgSuOLMa1b6XzN?=
 =?iso-8859-1?Q?sLSf/rt5rUIIiTwqcBDBOQN+CqTSHk8RYIrSUclKJGATrTSQIHhWJHMx8d?=
 =?iso-8859-1?Q?F+f0gkwg02VmGIhevsGqAN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:50:20.7529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e73f063a-4706-4c9f-a7e5-08dd20559b6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7484
Received-SPF: permerror client-ip=40.107.223.63;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 19, 2024 at 01:37:18PM +0000, Daniel P. Berrangé wrote:
> On Thu, Dec 19, 2024 at 07:16:01AM -0600, Michael Roth wrote:
> > On Thu, Dec 19, 2024 at 08:13:44AM +0000, Daniel P. Berrangé wrote:
> > > On Wed, Dec 18, 2024 at 04:29:51PM -0600, Michael Roth wrote:
> > > > On Wed, Dec 18, 2024 at 05:50:52PM +0000, Daniel P. Berrangé wrote:
> > > > > On Wed, Dec 18, 2024 at 09:49:39AM -0600, Michael Roth wrote:
> > > > > > The GHCB specification[1] defines a VMGEXIT-based Guest Request
> > > > > > hypercall to allow an SNP guest to issue encrypted requests directly to
> > > > > > SNP firmware to do things like query the attestation report for the
> > > > > > guest. These are generally handled purely in the kernel.
> > > > > > 
> > > > > > In some some cases, it's useful for the host to be able to additionally
> > > > > > supply the certificate chain for the signing key that SNP firmware uses
> > > > > > to sign these attestation reports. To allow for this, the GHCB
> > > > > > specification defines an Extended Guest Request where this certificate
> > > > > > data can be provided in a special format described in the GHCB spec.
> > > > > > This certificate data may be global or guest-specific depending on how
> > > > > > the guest was configured. Rather than providing interfaces to manage
> > > > > > these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> > > > > > to request the certificate contents from userspace. Implement support
> > > > > > for that here.
> > > > > > 
> > > > > > To synchronize delivery of the certificates to the guest in a way where
> > > > > > they will not be rendered invalid by updates to SNP firmware or
> > > > > > attestation singing/endorsement keys by management tools outside the
> > > > > > purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> > > > > > obtain a shared/read lock on the certificate file prior to delivering
> > > > > > them back to KVM. Only after this will the attestation report be
> > > > > > retrieved from firmware and bundled with the certificate data, so QEMU
> > > > > > must continue to hold the file lock until KVM confirms that the
> > > > > > attestation report has been retrieved/bundled. This confirmation is done
> > > > > > by way of the kvm_immediate_exit callback infrastructure that was
> > > > > > introduced in a previous patch.
> > > > > > 
> > > > > > [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
> > > > > >     https://www.amd.com/en/developer/sev.html
> > > > > > 
> > > > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > > > ---
> > > > > >  qapi/qom.json                 |  23 +++-
> > > > > >  target/i386/kvm/kvm.c         |  10 ++
> > > > > >  target/i386/sev-sysemu-stub.c |   5 +
> > > > > >  target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
> > > > > >  target/i386/sev.h             |   2 +
> > > > > >  5 files changed, 288 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > > index 28ce24cd8d..6eaf0e7721 100644
> > > > > > --- a/qapi/qom.json
> > > > > > +++ b/qapi/qom.json
> > > > > > @@ -1034,6 +1034,25 @@
> > > > > >  #     firmware.  Set this to true to disable the use of VCEK.
> > > > > >  #     (default: false) (since: 9.1)
> > > > > >  #
> > > > > > +# @certs-path: Path to certificate data that can be passed to guests via
> > > > > > +#              SNP Extended Guest Requests. File should be in the format
> > > > > > +#              described in the GHCB specification. (default: none)
> > > > > > +#              (since: 10.0)
> > > > > 
> > > > > Can we document the required format here explicitly, rather than expecting
> > > > > users to go searching for specs which are often practically impossible
> > > > > to find, and even harder to read & interpret ?
> > > > 
> > > > It'll be difficult to summarize in a way that will be self-reliant,
> > > > since knowing the certificate format is not sufficient to make sure
> > > > it coincides with the endorsement key being used by firmware. So I can't
> > > > promise to completely reduce reliance on external specs, but at least
> > > > give a better of the format and where those external specs will come
> > > > into play in filling out the data.
> > > > 
> > > > If it needs to be at least somewhat self-sufficient then that might
> > > > warrant a separate document in docs/system/i386/amd-memory-encryption.rst
> > > > or somewhere thereabouts that summarizes the whole attestation flow and
> > > > how certificates tie into that.
> > > > 
> > > > Any preferences?
> > > > 
> > > > > 
> > > > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > > > > > index 1a4eb1ada6..2c41bdbccf 100644
> > > > > > --- a/target/i386/sev.c
> > > > > > +++ b/target/i386/sev.c
> > > > > > @@ -157,6 +157,9 @@ struct SevSnpGuestState {
> > > > > >      char *id_auth_base64;
> > > > > >      uint8_t *id_auth;
> > > > > >      char *host_data;
> > > > > > +    char *certs_path;
> > > > > > +    int certs_fd;
> > > > > > +    uint32_t certs_timeout;
> > > > > >  
> > > > > >      struct kvm_sev_snp_launch_start kvm_start_conf;
> > > > > >      struct kvm_sev_snp_launch_finish kvm_finish_conf;
> > > > > > @@ -1355,6 +1358,215 @@ sev_snp_launch_finish(SevCommonState *sev_common)
> > > > > >      }
> > > > > >  }
> > > > > >  
> > > > > > +static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
> > > > > > +{
> > > > > > +    int fd, ret;
> > > > > > +
> > > > > > +    if (sev_snp_guest->certs_fd != -1) {
> > > > > > +        return 0;
> > > > > > +    }
> > > > > > +
> > > > > > +    fd = qemu_open(sev_snp_guest->certs_path, O_RDONLY, NULL);
> > > > > > +    if (fd == -1) {
> > > > > > +        error_report("Unable to open certificate blob at path %s, ret %d",
> > > > > > +                     sev_snp_guest->certs_path, fd);
> > > > > > +        return fd;
> > > > > > +    }
> > > > > > +
> > > > > > +    ret = qemu_lock_fd(fd, 0, 0, false);
> > > > > > +    if (ret == -EAGAIN || ret == -EACCES) {
> > > > > > +        ret = -EAGAIN;
> > > > > > +        goto out_close;
> > > > > > +    } else if (ret) {
> > > > > > +        goto out_close;
> > > > > > +    }
> > > > > 
> > > > > This locking scheme is likely unsafe. Consider this sequence
> > > > > 
> > > > >   * QEMU runs qemu_open(path)
> > > > >   * External mgmt app runs unlink(path)
> > > > >   * External mgmt app runs open(path)
> > > > >   * External mgmt app runs lock(fd)
> > > > >   * QEMU runs qemu_lock_fd(fd)
> > > > > 
> > > > > QEMU has successfully acquired a lock on an FD that corresponds to a
> > > > > deleted file, not the current existing file.
> > > > > 
> > > > > Avoiding this problem requires either that the external mgmt app agrees
> > > > > to *NEVER* unlink() the files under any circumstance, or for QEMU to
> > > > > run its open + lock logic in a loop, checking 'stat' and 'fstat' before
> > > > > opening and after locking, in order to detect a replaced file from its
> > > > > changed inode.
> > > > > 
> > > > > I'm not inclined to rely on mgmt apps never unlink()ing as that's to
> > > > > easy to mess up IMHO.
> > > > 
> > > > Yah I went into more detail in my response to Markus, but long story
> > > > short is that we are assuming mgmt is cooperative in this case, and
> > > > so as you mentioned, it would never unlink files while SNP guests are
> > > > running, but instead take an exclusive lock on them and update them in
> > > > place with the understanding that doing anything otherwise would open
> > > > a race window where guests might get stale certificates.
> > > 
> > > If there's an expectation & requirement that no SNP guests are running,
> > > then IMHO this whole thing is just over-engineered. Just remove all this
> > > locking code entirely, and document that none of this must be changed
> > > while QEMU is running - which is a common requirement for a great many
> > > things on the host.
> > 
> > VCEK endorsement keys can change as a result of SNP firmware updates,
> > which can be done while SNP guests are running and are often done in such
> > a way to patch bugs/security holes. VLEK endorsement keys can similarly be
> > updated on a live host. Both these sorts of interactions cannot be made
> > compatible with bundling certificates with attestation reports without some
> > orchestration in place to keep them atomic relative to the endorsement
> > key being used by firmware to sign attestation reports. Every CSP
> > implementing this will need to solve it in some way, and I'm sure some
> > will handle all this completely differently. But it will make
> > interoperative management/tooling a mess, and having a reference
> > implementation based around something common will make it easier to
> > steer CSPs to that common solution and give management tools authors
> > *some* reference approach to target rather than expecting to retrofit
> > some custom solution on top.
> > 
> > With these patches, you can update firmware and endorsement keys while
> > SNP guests are running, but it requires write locks on any active
> > certificates as defined here and in the kernel, and doing certificate
> > file updates in place while that write lock is still held. I don't really
> > think that's over-engineered. I think it's surprisingly simple given the
> > potential complexity of the above-mentioned requirements.
> > 
> > But yes if management tries to unlink certificates while SNP guests are
> > running, all bets are off. But at that point they are not cooperating
> > with kernel/QEMU, and we don't need to care about that. And if they
> > really do need to blow away certificates for a complete re-install
> > or data-wipe or whatever, at that point they'd just need to ensure
> > they stop all their SNP guests first.
> 
> IMHO we msut consider unlink() to be a valid thing, because the right
> way for apps to perform crash safe atomic updates of existing files,
> is to use rename() from a temporary file, and the rename() in has an
> implicit unlink as part of its operation. ie apps would be doing:
> 
>    fd = open("foo.tmp")
>    write(fd, ...)
>    fsync(fd)
>    close(fd)
>    rename("foo.tmp", "foo")

If we still want to allow for this rather than enforcing in-place
update, one alternative would be to just allow a separate lock file
to be specified rather than locking the certificate file itself. That
would provide a bit more flexibility.

I can update the QEMU implementation to take -certs-lock-file in
addition to -certs-file so they can be specified separately. And if
-certs-lock-file is not specified then QEMU will just assume
management handles things different or has agreed to not do endorsement
key updates while SNP guests are running.

I think we'd considered something like that originally but the thinking
was that locking the certs themselves was more organic in terms of an
"obvious"/natural solution. But it does end up being a bit more
inflexible WRT how libraries/etc. might manage file updates underneath
the covers, so maybe a lock file is the better approach after all.

-Mike

> 
> That final rename operation will have the same effect on the locks
> as unlink(). To cope with this anything doing locking has to run
> in a loop comparing the inode either side of acquiring the lock
> 
> TLDR: if we're going to do locking in QEMU, it needs to be done
> robustly.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

