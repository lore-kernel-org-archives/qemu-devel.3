Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3E1E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGw-0004UY-98; Thu, 19 Dec 2024 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tOGOT-0001hG-OU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:16:45 -0500
Received: from mail-mw2nam04on20630.outbound.protection.outlook.com
 ([2a01:111:f403:240a::630]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tOGOQ-0003hW-Qb
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:16:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrxGECFGcCRIp6py1Ol45JMeepGXoFG2a9XBR9BqYhmN1pAEYuiFPlCuoYLhr7pz9aI4K8CsIUp4HxsSKiS0wT5l5AcjTjuHMXUp9HkbeyQbx2S8tjaOBuaF1ZpcqcnCQmdl5nsq/xv8xUSwRTMOYmySlSVRCusXWuksvU1/YhkUKLhxd4wGHRHaTPtpFl7N0ps1pTTObOOeOmmigohjmZYeELFP3QSXTVCe3QfPy79ZthMW9VswOrsLDHRwLyQtzsDyBgUAJvn2x4v131B4UEAoTMq/SPvmmTTMFdsFvDrfl8Yyp/VOLThjjNqlXPouXAVm7+m3pI6GOsArhM25rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sna+lkGwqG5Z3O489qhDLZd8jiAz4pInILM/EidnUZk=;
 b=ov0UsysaV3SnT9ObI9O7coCHJNt+EaFCiZZY4f3CLexoKnXc3W2fZsdBmk+C0hUgLoPzKif5JoMejOllzrj5ewdSBVU/3+dkTC2JPbxP67oiMyibpBxYWio1D6JLCBF+4Y5un3rinzIBiTKEmIUVOH5UCtzQA/fPWjPHvW9yVfNTcFu4vduBbfWsWfm028Hd3TVN7wRJYrwAlgL+6Nq+Qony4nhKWVZzDGcaAhbdUNdAkrA11OfaGcR1LcTqivLmgD2q/WBsFs0Yt8+RC0kh7Ml6wj/UMic9xFXxD6bGKPrTCf41f8Ees1JHe3zH/VFMh8uMNn6C5YUn8ef1naLVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sna+lkGwqG5Z3O489qhDLZd8jiAz4pInILM/EidnUZk=;
 b=UFGZnq3HfTUZ0Js7Hz3HQTgjTJsE7JzJemKSF11lIK411J+FVNipYYbYz0GswDLPTXuNvhRrhxu8/nmiA/5VTIg1UFEmhtKay9pRBTRQvgvI4XkYPp8VRrI/Musin2IfIIxeQY/wk+cR9qRrkLsij+k16ILUoksLKznTMrDmeP0=
Received: from DS0PR17CA0022.namprd17.prod.outlook.com (2603:10b6:8:191::21)
 by PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Thu, 19 Dec
 2024 13:16:33 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::a6) by DS0PR17CA0022.outlook.office365.com
 (2603:10b6:8:191::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.25 via Frontend Transport; Thu,
 19 Dec 2024 13:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 13:16:33 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Dec
 2024 07:16:32 -0600
Date: Thu, 19 Dec 2024 07:16:01 -0600
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
CC: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>, <dionnaglaze@google.com>
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Message-ID: <20241219131601.ckebfuxy5ukpdcml@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
 <Z2MLfIFzzyEWEy5T@redhat.com>
 <20241218222951.v6yjhcd7j6uojcs4@amd.com>
 <Z2PVprpxdfa9MQR5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2PVprpxdfa9MQR5@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|PH7PR12MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f6f8a8-732a-4678-1ac0-08dd202f5bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6ml18OiD+fyhrMbtHv3d6ZkB8+tDKMjwxuYwRtA2ablgxQWQkAdZFSSoMl?=
 =?iso-8859-1?Q?HCSdKiZ/sNs+RYHvDHPGxXcsNE3J87UXApdW9e2e6YxgRYx/6yHk9mDqoy?=
 =?iso-8859-1?Q?fkDGn3q8UMv/sg0tyxLoYzK9fYVAbk8a0NeffPwfEdSbCvHGTY7N2gN34W?=
 =?iso-8859-1?Q?+pyTLIx+K/Odmzdqw+BAROAHvkwmNGr+wXd9zkqg/RDgMs4mM1u+MdxBGE?=
 =?iso-8859-1?Q?SQ90rFI4fGDtuoc8DLYZSen+cSzf3wSXJvrT0v4RjdfjGi4+7lTu7ShbOl?=
 =?iso-8859-1?Q?byGT+kEkOQvMLYqVgUJIwQnOJXpjLgi1sYKQmzF6mi+2c9OClfZvPsR4Gc?=
 =?iso-8859-1?Q?XbA1aqJey69MPjjUDORtmOgDKSfcE46h50ZnGihILxiIzc61pw0DLFe59v?=
 =?iso-8859-1?Q?ZXlnYWgwi6kQcSv0EUGx2wsuKbI02XCTU2wSTnpRowKQ3pbVwZT3K24ut6?=
 =?iso-8859-1?Q?9AYe45REZV9i8sPjCgX7fwK5IIeGfcXh+u0DMUg0Z0zSanPSqSa02qAhJ4?=
 =?iso-8859-1?Q?1Vj73gtA49uFJN/kAAiWMW7yfuHmcN8LUxi2c84v5+NJ3ppsGUR4zDXK0j?=
 =?iso-8859-1?Q?X9qWE4CyR5RU9JTLMrwSXo1eb4xpmrQ3347aj2wLxA0ee9bqhFdtczIiKR?=
 =?iso-8859-1?Q?vrDhYeEU7ai4hDG07IXWydaFe4NUe2QNP5cI6V84YcvUIlYtFHdvnAt7Xy?=
 =?iso-8859-1?Q?oRWSy95kKs+DNq1TeznniLpB+TJb34mAOC9k9WKsjxEBWAtuLzD5jv8U1J?=
 =?iso-8859-1?Q?CzKJgMe2MWFdzV86bJdlDvYp0wszycaoPh8l3H9lL+irsiynY+RN2Xr49f?=
 =?iso-8859-1?Q?cMVmiNYXQDHc4+e16gzB1XdoX2a8kb8xaBWnx7Kx/KVzArOii1Qe1TWI/5?=
 =?iso-8859-1?Q?OrIpvf9G73qwaFg30LzO5r1yD6S31woGjEF/axt68EtNuo4yvfGVtqblFH?=
 =?iso-8859-1?Q?clTzJ37FoqTdIaU8TPatiRPrpqW3OVFP8kzHmTWeSBfSiV2tZq0VI/i7rv?=
 =?iso-8859-1?Q?vh0bxUmnE4JUBj8i/0hOkC8lOi0bjTKlLWvi1cPTW0fTs70hLSUITi9ES7?=
 =?iso-8859-1?Q?ay8d4Eu65leYJRhjwQy+sLzgb0kUxfLciJONp55AAjbSprUHv8aFrCyzlf?=
 =?iso-8859-1?Q?zgDIG1Mh2HqlGw5FpUylQniFXpphANVXqJtmVXT0RKK3FaVyAGYPHF4F8L?=
 =?iso-8859-1?Q?oMtPSg1zjROWyHqcRmOywADi5DnnJeSKt/zO4Wz1TWPNUhBcNRBoNGJwod?=
 =?iso-8859-1?Q?15fVMMJKlqganT0IEPvSs89IL6oc0GWwMDhbTfNgaRqhbOTi39Fs7g2SXt?=
 =?iso-8859-1?Q?Gs0HtBqVfGCl4mbhUXEvmvzkfPYYI7SqvzIhkymeQXoH+9fTLt6QZkZ7Mm?=
 =?iso-8859-1?Q?Yz9W2cyKBlJ0574rEJQ900Qz09ta1sIrXkPIzXL4wQ9WY2UgJFJdVhfozy?=
 =?iso-8859-1?Q?QyS2enoTEKzTcF21z15Y8fTahfGqSkC5/QJcbbXbP756RsAobqTwzQJrkH?=
 =?iso-8859-1?Q?4WVaMO9fTLueCAIiJGLufh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 13:16:33.2839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f6f8a8-732a-4678-1ac0-08dd202f5bf1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8794
Received-SPF: permerror client-ip=2a01:111:f403:240a::630;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

On Thu, Dec 19, 2024 at 08:13:44AM +0000, Daniel P. Berrangé wrote:
> On Wed, Dec 18, 2024 at 04:29:51PM -0600, Michael Roth wrote:
> > On Wed, Dec 18, 2024 at 05:50:52PM +0000, Daniel P. Berrangé wrote:
> > > On Wed, Dec 18, 2024 at 09:49:39AM -0600, Michael Roth wrote:
> > > > The GHCB specification[1] defines a VMGEXIT-based Guest Request
> > > > hypercall to allow an SNP guest to issue encrypted requests directly to
> > > > SNP firmware to do things like query the attestation report for the
> > > > guest. These are generally handled purely in the kernel.
> > > > 
> > > > In some some cases, it's useful for the host to be able to additionally
> > > > supply the certificate chain for the signing key that SNP firmware uses
> > > > to sign these attestation reports. To allow for this, the GHCB
> > > > specification defines an Extended Guest Request where this certificate
> > > > data can be provided in a special format described in the GHCB spec.
> > > > This certificate data may be global or guest-specific depending on how
> > > > the guest was configured. Rather than providing interfaces to manage
> > > > these within the kernel, KVM provides a new KVM_EXIT_SNP_REQ_CERTS exit
> > > > to request the certificate contents from userspace. Implement support
> > > > for that here.
> > > > 
> > > > To synchronize delivery of the certificates to the guest in a way where
> > > > they will not be rendered invalid by updates to SNP firmware or
> > > > attestation singing/endorsement keys by management tools outside the
> > > > purview of QEMU, it is expected by users of KVM_EXIT_SNP_REQ_CERTS to
> > > > obtain a shared/read lock on the certificate file prior to delivering
> > > > them back to KVM. Only after this will the attestation report be
> > > > retrieved from firmware and bundled with the certificate data, so QEMU
> > > > must continue to hold the file lock until KVM confirms that the
> > > > attestation report has been retrieved/bundled. This confirmation is done
> > > > by way of the kvm_immediate_exit callback infrastructure that was
> > > > introduced in a previous patch.
> > > > 
> > > > [1] "Guest Hypervisor Communication Block (GHCB) Standardization",
> > > >     https://www.amd.com/en/developer/sev.html
> > > > 
> > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > ---
> > > >  qapi/qom.json                 |  23 +++-
> > > >  target/i386/kvm/kvm.c         |  10 ++
> > > >  target/i386/sev-sysemu-stub.c |   5 +
> > > >  target/i386/sev.c             | 249 ++++++++++++++++++++++++++++++++++
> > > >  target/i386/sev.h             |   2 +
> > > >  5 files changed, 288 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > index 28ce24cd8d..6eaf0e7721 100644
> > > > --- a/qapi/qom.json
> > > > +++ b/qapi/qom.json
> > > > @@ -1034,6 +1034,25 @@
> > > >  #     firmware.  Set this to true to disable the use of VCEK.
> > > >  #     (default: false) (since: 9.1)
> > > >  #
> > > > +# @certs-path: Path to certificate data that can be passed to guests via
> > > > +#              SNP Extended Guest Requests. File should be in the format
> > > > +#              described in the GHCB specification. (default: none)
> > > > +#              (since: 10.0)
> > > 
> > > Can we document the required format here explicitly, rather than expecting
> > > users to go searching for specs which are often practically impossible
> > > to find, and even harder to read & interpret ?
> > 
> > It'll be difficult to summarize in a way that will be self-reliant,
> > since knowing the certificate format is not sufficient to make sure
> > it coincides with the endorsement key being used by firmware. So I can't
> > promise to completely reduce reliance on external specs, but at least
> > give a better of the format and where those external specs will come
> > into play in filling out the data.
> > 
> > If it needs to be at least somewhat self-sufficient then that might
> > warrant a separate document in docs/system/i386/amd-memory-encryption.rst
> > or somewhere thereabouts that summarizes the whole attestation flow and
> > how certificates tie into that.
> > 
> > Any preferences?
> > 
> > > 
> > > > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > > > index 1a4eb1ada6..2c41bdbccf 100644
> > > > --- a/target/i386/sev.c
> > > > +++ b/target/i386/sev.c
> > > > @@ -157,6 +157,9 @@ struct SevSnpGuestState {
> > > >      char *id_auth_base64;
> > > >      uint8_t *id_auth;
> > > >      char *host_data;
> > > > +    char *certs_path;
> > > > +    int certs_fd;
> > > > +    uint32_t certs_timeout;
> > > >  
> > > >      struct kvm_sev_snp_launch_start kvm_start_conf;
> > > >      struct kvm_sev_snp_launch_finish kvm_finish_conf;
> > > > @@ -1355,6 +1358,215 @@ sev_snp_launch_finish(SevCommonState *sev_common)
> > > >      }
> > > >  }
> > > >  
> > > > +static int open_certs_locked(SevSnpGuestState *sev_snp_guest)
> > > > +{
> > > > +    int fd, ret;
> > > > +
> > > > +    if (sev_snp_guest->certs_fd != -1) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    fd = qemu_open(sev_snp_guest->certs_path, O_RDONLY, NULL);
> > > > +    if (fd == -1) {
> > > > +        error_report("Unable to open certificate blob at path %s, ret %d",
> > > > +                     sev_snp_guest->certs_path, fd);
> > > > +        return fd;
> > > > +    }
> > > > +
> > > > +    ret = qemu_lock_fd(fd, 0, 0, false);
> > > > +    if (ret == -EAGAIN || ret == -EACCES) {
> > > > +        ret = -EAGAIN;
> > > > +        goto out_close;
> > > > +    } else if (ret) {
> > > > +        goto out_close;
> > > > +    }
> > > 
> > > This locking scheme is likely unsafe. Consider this sequence
> > > 
> > >   * QEMU runs qemu_open(path)
> > >   * External mgmt app runs unlink(path)
> > >   * External mgmt app runs open(path)
> > >   * External mgmt app runs lock(fd)
> > >   * QEMU runs qemu_lock_fd(fd)
> > > 
> > > QEMU has successfully acquired a lock on an FD that corresponds to a
> > > deleted file, not the current existing file.
> > > 
> > > Avoiding this problem requires either that the external mgmt app agrees
> > > to *NEVER* unlink() the files under any circumstance, or for QEMU to
> > > run its open + lock logic in a loop, checking 'stat' and 'fstat' before
> > > opening and after locking, in order to detect a replaced file from its
> > > changed inode.
> > > 
> > > I'm not inclined to rely on mgmt apps never unlink()ing as that's to
> > > easy to mess up IMHO.
> > 
> > Yah I went into more detail in my response to Markus, but long story
> > short is that we are assuming mgmt is cooperative in this case, and
> > so as you mentioned, it would never unlink files while SNP guests are
> > running, but instead take an exclusive lock on them and update them in
> > place with the understanding that doing anything otherwise would open
> > a race window where guests might get stale certificates.
> 
> If there's an expectation & requirement that no SNP guests are running,
> then IMHO this whole thing is just over-engineered. Just remove all this
> locking code entirely, and document that none of this must be changed
> while QEMU is running - which is a common requirement for a great many
> things on the host.

VCEK endorsement keys can change as a result of SNP firmware updates,
which can be done while SNP guests are running and are often done in such
a way to patch bugs/security holes. VLEK endorsement keys can similarly be
updated on a live host. Both these sorts of interactions cannot be made
compatible with bundling certificates with attestation reports without some
orchestration in place to keep them atomic relative to the endorsement
key being used by firmware to sign attestation reports. Every CSP
implementing this will need to solve it in some way, and I'm sure some
will handle all this completely differently. But it will make
interoperative management/tooling a mess, and having a reference
implementation based around something common will make it easier to
steer CSPs to that common solution and give management tools authors
*some* reference approach to target rather than expecting to retrofit
some custom solution on top.

With these patches, you can update firmware and endorsement keys while
SNP guests are running, but it requires write locks on any active
certificates as defined here and in the kernel, and doing certificate
file updates in place while that write lock is still held. I don't really
think that's over-engineered. I think it's surprisingly simple given the
potential complexity of the above-mentioned requirements.

But yes if management tries to unlink certificates while SNP guests are
running, all bets are off. But at that point they are not cooperating
with kernel/QEMU, and we don't need to care about that. And if they
really do need to blow away certificates for a complete re-install
or data-wipe or whatever, at that point they'd just need to ensure
they stop all their SNP guests first.

-Mike

> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

