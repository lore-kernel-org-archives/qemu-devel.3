Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CF7C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyim1-0000If-4Y; Tue, 25 Aug 2026 00:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyily-0000Hz-EG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:28:30 -0400
Received: from mail-westus3azon11011015.outbound.protection.outlook.com
 ([40.107.208.15] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wyilv-0004wX-Rc
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIjzzAYWozgaEtohjY3orK0Bu6pvyLuZWEmsLu3+QxSU8bkinQsHSIXx1JKAmtnhgccyzoNzzfAFXo3ApZa8sLfuu+/raiYqMy9oQXOrN5uT6xA7BS3Qajni5Oc8oY8fPNJWZJi7qNLFJ5jjuX225ZB8TdGPf6to9glnfM0/ezpqDntKq1epOvTtf7WAORSBfa3afzho4GvvoHMuHU2K+tH+TQFXbzOZxwD/k30JraKnrrCRHOg/TFK0Lgrz7c7ELT0AYN9hYgYzbnQn0zlpbxUwZvEmB9oVamDfuBcOrygC1B5CkUYl5nK0aBpLbj5UZ6TzUAwfo4pVRWIh/kRV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oECZsVAHqnzTVY88HorEbQKTpnoj297Es6oKMpfl0/U=;
 b=c4Lg4EmkHQi/B/7d8OmC74SKrLZC17Pq3WLZmBXSOUZKpCE5elEBt4tRZxixupRkLT7LyS3PdgtqZoOsVbxrcI2mv+b3a7yxn0hUd5yAHYmkKMHZ+ieT4c3YT76q3oQl6Rr+qsoDSna6ni2XAXy7IdHSw8K/xnmLyWVy18xSh/PR26TAlakwnU3sOh/wiGvSnX9yK++1jFs5Akc2EjyS6zr3axxs1ShiEC6D3+h3qdH9LGk34IVmXKGyxNjBiA6SqeMZ2qJIsm2RumkJ+/rRKmUVXqTBw0vQn5us3p3F7RiHvDRRIvnG4ZdgbmD8UkWG8+vUWBfFp4faWTrjeCp7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oECZsVAHqnzTVY88HorEbQKTpnoj297Es6oKMpfl0/U=;
 b=DDTX8GaofFO7FRzvvUoxx8AirD3a4Ppe7FSvWl7Rjd6ffWlMN1b9zhhXxwcH9cVkRpLQDPLHmiXnWkYUEYZPf08JmZjHET5+9IMmqV/uavpDvvSgw8OaDqKsT1blTTohkjWhIeru1aYAe2nFqeH7OWN4hYvkdB2LH/x7E9ojMX0=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by IA0PR12MB8864.namprd12.prod.outlook.com (2603:10b6:208:485::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:23:17 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::79) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:17 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 21:21:09 -0500
Date: Mon, 24 Aug 2026 21:04:43 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <jmarcin@redhat.com>, <david@kernel.org>,
 <pbonzini@redhat.com>, <chenyi.qiang@intel.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <nt7z5pzaemffdy6pctihft27quaoaaa3admicmss6ym2uthdb2@ug2m7nqtnzop>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com> <an3PWdPIdb6afDsS@x1.local>
 <an8yCp9qZ498aLu2@redhat.com> <aoMGNz9AdOnDQkKE@x1.local>
 <2k6hph3cnf4djvjd72g26sdgxluixhm2mpyf2emvgmkrfturvj@ctnctjaks7jq>
 <aoxADcqox7eUPEXT@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aoxADcqox7eUPEXT@x1.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|IA0PR12MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c32ade-fb86-4dfa-e013-08df026096b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|3023799007|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RYkgSyalJ/9uTRvhtcKMCjcm8xknQayycWrIoP0zUmYKCgRdMuXqQtZZDRX0lW5mfOyui7rSHQS0mlvcuwncqopvOHvQcVKYItyOXJCqwXIoxXN9LJScdopDmVWMMGxhZXKJATVHMl7md1Cl1nXGsOgIRCBD3q0Blurf1ECkqhyiYMwFlsHuGCCHxnET7LdngM/PR8zQriS6swNOc4+yGu3+Dkz9qXi1wq7IYxLZmDkvc60gHSd2QbSZ0DcFYyMBewbx+BtHzjNeOT971u2mSvU2V6b2fFn1C7BX1i3cEdgdebiEmQZyLOJ8iZ/kATUdlAlnTjqr3+G3yE5H6YX4dl2pe9h0g7nAJRhWcfr6fuWBY92xsF5TdMrldZZyt9jNK7WvQdNmUMqQ6cZdLCdZNWJ+CoTHA556jmezSl9YUG3pWEMLDtEKXd+f3S7uQ2o4/Rs+jdGo0BAA/iPYVcoO+Sme4Sn3xKz1vltS7ymfdzmPmRRUX0GRq7siv/TIHtjPuIE09Z+/8hZc8Ps0Db09D31fm9mndOSxCrE8hEWEq6+bkCvV41T0MhJcTXOI40Ssf6AAmdbh2Sx4WLAl8c9Nu2Z4SGvkysDT/aoC2SQQdlcmreahWk8taVxG8v8b8YAi54MaLHrOwOrXkz0dBZXC1nhgMaXWrYdPYj/6XXiazfUaYCa0ISW6x5AGT1ne+GKmAuELSPglu9d2xFOAwl1ePg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5UxPOQiVJR/HWBwh5Sd0/+0qMvdtDoJfeX3ELQur9KbRVPwMJqZscQtgnlwm0lbHaJ15657pxgVz/jSuzk4mDZlTr92SaE1dlXe/ULapKpXgERnbkVIzBI94lmEGe4x8Az5r+f4Q6IIll4eQPyOUh2y2ECd5DD7cISyFwbfnW/EDC0HM4+Y1XWhhFWxj0VxBv63a5pCtYo2wtf6rC8BY2H5GJwGG2QW/of8KTQTs7UZFP83HNENiT9FyNUDD4kdntb/Rwk3SBJISaqvN8UiYKNYC+TrlvjkRyN5M3NpCFL+xW1yZ0mIObAXWYnlKQ5HIYshkUZGKUlNH/sa0o7gp2+e1V09NSJM+XzThvpN7TTykqQvGWfncazQYYrT8wRHYOs+5BiL6Lgvn6PI0Ypsp/z1XeRiejXSOldRbL8Ks0q00BYK6bIRok6TJG9BM6idU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:17.7354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c32ade-fb86-4dfa-e013-08df026096b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8864
Received-SPF: permerror client-ip=40.107.208.15;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 24, 2026 at 08:58:53AM -0400, Peter Xu wrote:
> On Sun, Aug 23, 2026 at 10:33:36AM -0500, Michael Roth wrote:
> > It seemed like the guest_memfd support for directmap removal[1] might be
> > a good test for how this all look like once new features start coming
> > along for confidential vs. non-confidential so I've been trying to get
> > that up and running to see.
> > 
> > If we keep everything in memory-backend-memfd, there's a little bit
> > of awkwardness, but the following schema should cover discoverability of
> > QEMU support at least, and then libvirt/management can branch into whatever
> > routine is needed for probing actual kernel support:
> 
> Isn't that secretmem for generic memfd case? I'm not sure if it'll ever
> need to be supported by QEMU at all, but it sounds like exactly that for
> normal memfds..

Hmm, I did intend to leave open the option of using this for other
use-cases that came along, but I didn't realize secretmem already does
kernel directmap removal. That's an interesting thing to consider...

We couldn't just flip memfd_secret on under the covers since it has
other side-effects, so you'd likely need something like secret-memfd=on
which starts to look a lot like guest-memfd=on.

So the schema would be something like:

     { 'struct': 'MemoryBackendMemfdProperties',
       'data': { '*hugetlb': 'bool',
                 '*hugetlbsize': 'size',
                 '*seal': 'bool',
                 '*guest-memfd': 'bool',
                 '*no-directmap': 'bool' },
       'features': ['no-directmap-for-guest-memfd',
                    'no-directmap-for-secret-memfd'] }

with nearly identifical wording except s/guest/secret/. Not sure how
pretty that all is, but hopefully that's some indication that this is
a reasonable design choice at least.

> 
> > 
> >   diff --git a/qapi/qom.json b/qapi/qom.json
> >   index ee981fc44c..4777f09ad1 100644
> >   --- a/qapi/qom.json
> >   +++ b/qapi/qom.json
> >   @@ -774,6 +774,19 @@
> >    # @guest-memfd: if true, use guest-memfd to back the memory region.
> >    #     (default: false, since: 11.2)
> >    #
> >   +# @no-directmap: if true, enable support for unmapping backend memory
> >   +#                from the kernel directmap to better isolate it from
> >   +#                host activity.  This option is only available if a
> >   +#                corresponding Features value advertises support for
> >   +#                the intended use-case.
> >   +#                (default: false, since: 11.2)
> 
> Shall we name the property to avoid "no-" prefixes ("kernel-map=on/off",
> default on)?  I used "kernel" instead of "direct" because any mmap() from
> user can also be described, more or less.. to be direct.

Makes sense, I guess we don't need to reach a consensus on this detail
here, but kernel-map or maybe kernel-isolation seem like reasonable
choices.

> 
> >   +#
> >   +# Features:
> >   +#
> >   +# @no-directmap-for-guest-memfd: If present (and if the hypervisor
> >   +# supports the feature), the corresponding option is available if
> >   +# @guest-memfd is true.  (since 11.2)
> >   +#
> >    # Since: 2.12
> >    ##
> >    { 'struct': 'MemoryBackendMemfdProperties',
> >   @@ -781,8 +794,10 @@
> >      'data': { '*hugetlb': 'bool',
> >                '*hugetlbsize': 'size',
> >                '*seal': 'bool',
> >   -            '*guest-memfd': 'bool' },
> >   -  'if': 'CONFIG_LINUX' }
> >   +            '*guest-memfd': 'bool',
> >   +           '*no-directmap': 'bool' },
> >   +  'if': 'CONFIG_LINUX',
> 
> Nitpic: we could drop CONFIG_LINUX IMHO in QAPI if it'll fail properly on
> non-linux in impl anyway.

That was already the case before this series so I guess I'd leave that
up to others to decide. One point on this though:

On the introspection side, if we don't actually support anything beyond
linux, it probaby doesn't hurt to continue to gate on CONFIG_LINUX just
in case some funky business needs to happen to switch it on for another
OS (e.g. if certain options become inapplicable to that use-case/etc. and
dropping 'CONFIG_LINUX' involves adding it back in more granularly on
a per-option basis).

> 
> >   +  'features': ['no-directmap-for-guest-memfd'] }
> > 
> > One notable thing there is the current code only enables it for
> > non-confidential VM types, so that's where the KVM_CAP_* checks would
> > need to come into play to distinguish between what's supported for
> > specific VM types.
> > 
> > 
> > On a side note:
> > 
> > Ideally we'd be able to do something like the below so we can have one
> > 'supported-for-guest-memfd' features that could be associated with
> > multiple options, e.g.:
> > 
> >   +# Features:
> >   +#
> >   +# @supported-for-guest-memfd: If present (and if the hypervisor
> >   +# supports the feature), the corresponding option is available if
> >   +# @guest-memfd is true.  (since 11.2)
> >   +#
> >    # Since: 2.12
> >    ##
> >    { 'struct': 'MemoryBackendMemfdProperties',
> >   @@ -781,7 +794,9 @@
> >      'data': { '*hugetlb': 'bool',
> >                '*hugetlbsize': 'size',
> >                '*seal': 'bool',
> >   -            '*guest-memfd': 'bool' },
> >   +            '*guest-memfd': 'bool',
> >   +            { 'name': 'no-directmap',
> >   +              'features': ['supported-for-guest-memfd'] } },
> > 
> > But it doesn't seem like QAPI is wired up for that. I guess we could add
> > that as part of enabling directmap support if it seems useful enough but
> > the above should work as well.
> 
> Maybe we can still just fail it for normal memfds for now, considering
> secretmem or anything like that might still be supported someday.  In
> general, for any memfd property (guest-memfd or memfd), if it conceptrally
> apply to all (my bet is here..) then IMHO we can keep them around at least
> from the interface level, and just fail them when we don't have support for
> one of the two.

It would already fail for non-guest-memfd, but it doesn't seem like a
bad idea to keep the option documented/introspected as guest-memfd-only
until someone explicitly adds a Feature to advertise support for
additional use-cases.

I think it could also be done how you propose though and still have all
the introspection support in place. We would just document 'no-directmap'
(or 'kernel-map'/etc) as if it was generally available, but update the
Feature to be 'supported-for-guest-memfd-only' and turn it into a quirk.
If we do one day generally enable the option, then we drop the
'supported-for-guest-memfd-only' Feature/quirk and everything is nice and
clean from that point forward.

The downside is maybe your bet doesn't pan out and the feature doesn't get
generally enabled, but instead only additionally gets enabled for, say,
secretmem use-cases, and now we have both 'supported-for-guest-memfd-only'
and 'supported-for-secret-mem-only' and the wording/semantics of the 2
becomes awkward. And maybe that secretmem functionality isn't something we
can switch on automatically because of too many side-effects (as speculated
above), so it becomes another one of these options that depends on another
option being set in order to actually work. In that case it might make
sense to detail these additional requirements via a new feature flag
instead of needing to sort of redefine things a bit.

That's why I basically documented it to be 'don't introspect this option
based on it's existence, introspect based on specific Features that
indicate support for using it in conjunction with that use-case'. It's
a bit more awkward upfront, but seems to avoid some potential quagmires.

But I think we'd survive with either approach, so happy to take whatever
direction we end up going once that series comes around. It's nice to
know that either option is available/workable though.

Thanks!

-Mike

> 
> Thanks,
> 
> -- 
> Peter Xu
> 

