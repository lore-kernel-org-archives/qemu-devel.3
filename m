Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9378910ED656
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w64Pa-0007mr-1x; Fri, 27 Mar 2026 06:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w64PX-0007lq-6j
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:27:27 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <GuoQing.Zhang@amd.com>)
 id 1w64PU-0003og-QE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 06:27:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHN7LsD0Dsgv6ECB2dzl+HqmxqC7Q1juSLexV1yhv+Z6JwiQkjHE7v4nqIE0Us3N79bJDkpN8x7H/tkmQbJO4319YjIV1r1ptoABOskVLiAtaBaaix73dhgg0gR0PdnIv6c4tTJISuAJ+mIN95JwoebACcHaZ10G/wrFgRq7PFsBouzdfCJTFaoVnxgM07V1PuzCAGWh7xaE0wyiFnfEIhf4eDW8335g71xhAoYy93lPVweDwXyf7UPfGyxpUIYqmIWBprWkssMy+iW8FdXiLCP7O1DYXk8UnYeVxlkZitEiDiD4MRPwmJPnu9REwYKXcaCdGD1zv3mllcTQZ6vDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc10uN5jsNBH8vZFMVg3/UVWWAlEiLR+ludMn+a/jy8=;
 b=x3H8B43ROFRmDVndfFB2GgHVBJNeJ/YfygSmkZjgiuJhYFIkKucfTuMjTzeOOWoOOB5WrFIr+VYSMLyKJ44/XnILGO+Mj0dtceTiMiexUVGZzA/0phEaeuGm9J399vO2Lfbd2CnUyjsCEG10WgBBMiwZhVGNhkyF7WY9j1xdkcA2TcptIWhX0MQbKv842c0FLc3r0XbxKY2Y1EGw3SJlpuUw4nBnk1f9WALPkp+hdtIX+xzOK79YxMlGTOog9EBKNujt/ahgud/bJ4FNOpVnOYTTMDerQqCCCGRyueUh7wbLUh7DoxDPHhz9jBnByjBZa8p0OI6qbK+FH8PwWTyxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc10uN5jsNBH8vZFMVg3/UVWWAlEiLR+ludMn+a/jy8=;
 b=YmtROfr2+NbuRCUk73yUDy0Pa6u9Evobckp+iTQ2uvREuLqD7DguLgkkNvIzzz80rJsleraemsUmbMJaEuUuZlhYYHJ3p7n3rsfoCcOSucrZkN6lJtregsK00eTBM6pX6h9xIJUxVGhXjs/iRnEVZjPpNiyybFgly9KU6DfNpSI=
Received: from PH7P221CA0033.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::25)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 10:27:17 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::d2) by PH7P221CA0033.outlook.office365.com
 (2603:10b6:510:33c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.24 via Frontend Transport; Fri,
 27 Mar 2026 10:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 10:27:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 05:27:16 -0500
Received: from [10.67.184.128] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 05:27:13 -0500
Message-ID: <9b6b3d6a-4f48-4e90-b2fc-7cfcc6c8651d@amd.com>
Date: Fri, 27 Mar 2026 18:27:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] migration/rdma: add x-rdma-chunk-size parameter
To: Markus Armbruster <armbru@redhat.com>, Samuel Zhang <guoqing.zhang@amd.com>
CC: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>,
 <lizhijian@fujitsu.com>, <eblake@redhat.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <PengJu.Zhou@amd.com>, <Qing.Ma@amd.com>
References: <20260327065006.2567463-1-guoqing.zhang@amd.com>
 <87h5q17gh8.fsf@pond.sub.org>
Content-Language: en-US
From: "Zhang, GuoQing (Sam)" <guoqzhan@amd.com>
In-Reply-To: <87h5q17gh8.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: cf567e85-efb6-4166-f260-08de8beb6b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r8BGaBOLc1hY1AzrJS72o8BYBNIJ4jZfFAIrhgAu1Ta7w6ogt6qr1U/9IrtM4Ra0n0N9i9uhczqwfvFTK34MZZUzEamO26FwejUXe2Dwf3/vVMB+997BsvQrWktpZa1EIV1IwikTt1GpCrdg8fAxAS0zMe7PVcFmW8+aZtnK952wapQVWfiJ44IttRftPcQeAncJw3OfoFHEB0CjC8nIMx+yYKnf2DHt/FtqiIQjsnvruZRnKEZc0cryLgXH8naMpnXIE+0pKoC1W+CcrMVML+n0cvKyBT6qhFmtQaLpypqvb2Gq91eNEnuXvOzaAo7TgsOVSfFSRnixHKZFknkR0r4ejOZvuZybwlj/Uu3rFYRK+8XfAqP4CMWhkMdZqn0jGEXa8bh+pZyU2BIFWtRV6HzyskcnUhpepAebi5D7Az458Bvk3MNI3otmy6N8+5Y5vcpcKb2gDBpraRdPEIjSaUHpkOyXrsG9Hd4rjo0PnWCHTSXNhGWmTJ7OdwY4D7YM3dgA8mbbyAmwAynalLkasnJntkpD/MFGhrHQHhgrmQH3gu1/HbzvqZwQgWHrqUybiSddAZe71Gd/tqVYhgYUnt7W11CjGQRoT9mhm4NbnCIh33xwhdkrhbIRe41sbKUvNHQItaVbcn3poYrAF4O8N78K2KuKZUndATThB4hHA/JxFemlye9OEsdPBVoj/JsTuG13ZESQU/OffUEmKSJ+QmA6NIDIPu1RCEABv0rqMPgFcgcERG3xpR42DL2mYKm5m7QzKijyizwNnkhnL7A+uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M7WvvR7q9aWIsyRMidyz0etsVXxg0P8qmudrPa/TLN8L6PAoQnIelaYdGZ9zgVMtVOHlWq6M2IyhHAAez0AePCdb63jOhBPleb6P4pG0W2TxEkCMS1wYnwy1MWyy8tM/Lsea0Lk2wl1HZI8iTBnthkv+3eyFvqBn7W8bTboKp7r1rLlwJ1TED38bxTj8exBMnhylrRTE0W6n0UpTNbOrShHySiLOxwhKyPzS08+yLoNOzJ6v3+775Z8BP2Tbk/IS4ZIMlS9rlmdpb/FRrcfOipHDXSEHKjfMKtL2af+rVl4PYSWEx0D+D+7g0tZNcX/bcntCWNBPTS3fCV0hUeMQng1+p5V4rhWO7lKoti7eSozN41c7KFyNWR/nzIfOZBznDn4v84bZ851L49j4A1NToVYSpyLp2kf/HltI+CNnUIOzxchSTZ3HU/sx1LP92RjI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:27:16.5201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf567e85-efb6-4166-f260-08de8beb6b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=GuoQing.Zhang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


On 2026/3/27 17:45, Markus Armbruster wrote:
> Samuel Zhang <guoqing.zhang@amd.com> writes:
>
>> The default 1MB RDMA chunk size causes slow live migration because
>> each chunk triggers a write_flush (ibv_post_send). For 8GB RAM,
>> 1MB chunk size produces ~15000 flushes vs ~3700 with 1024MB chunk size.
>>
>> Add x-rdma-chunk-size parameter to configure the RDMA chunk size for
>> faster migration.
>> Usage: `migrate_set_parameter x-rdma-chunk-size 1024M`
>>
>> Performance with RDMA live migration of 8GB RAM VM:
>>
>> | x-rdma-chunk-size (B) | time (s) | throughput (MB/s) |
>> |-----------------------|----------|-------------------|
>> | 1M (default)          | 37.915   |  1,007            |
>> | 32M                   | 17.880   |  2,260            |
>> | 1024M                 |  4.368   | 17,529            |
>>
>> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> [...]
>
>> diff --git a/migration/options.c b/migration/options.c
>> index f33b297929..bc61c8665d 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -13,6 +13,7 @@
>>   
>>   #include "qemu/osdep.h"
>>   #include "qemu/error-report.h"
>> +#include "qemu/units.h"
>>   #include "exec/target_page.h"
>>   #include "qapi/clone-visitor.h"
>>   #include "qapi/error.h"
>> @@ -90,6 +91,7 @@ const PropertyInfo qdev_prop_StrOrNull;
>>   
>>   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
>>   #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
>> +#define DEFAULT_MIGRATE_X_RDMA_CHUNK_SIZE           MiB     /* 1MB */
> The comment is now superfluous.
>
>>   
>>   const Property migration_properties[] = {
>>       DEFINE_PROP_BOOL("store-global-state", MigrationState,
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 7134d4ce47..292d96c95a 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -806,7 +806,7 @@
>>   #
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>>   #     @x-vcpu-dirty-limit-period are experimental.
>>   #
>>   # Since: 2.4
>> @@ -831,6 +831,7 @@
>>              'mode',
>>              'zero-page-detection',
>>              'direct-io',
>> +           { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
>>              'cpr-exec-command'] }
>>   
>>   ##
>> @@ -1007,9 +1008,14 @@
>>   #     is @cpr-exec.  The first list element is the program's filename,
>>   #     the remainder its arguments.  (Since 10.2)
>>   #
>> +# @x-rdma-chunk-size: RDMA memory registration chunk size in bytes.
>> +#     Default is 1MiB.  Must be a power of 2 in the range
>> +#     [1MiB, 1024MiB].  Only takes effect for RDMA migration.
> I believe it applies to channels whose migration address type is is
> "rdma".  In MigrationChannel syntax
>
>      {"channel-type": ..., "addr": {"transport": "rdma", ...}}
>
> Correct?


Correct! Is it OK to update the doc to the following one? Thank you!

`Only takes effect when migration address transport is "rdma".`


>
>> +#     (Since 11.1)
>> +#
>>   # Features:
>>   #
>> -# @unstable: Members @x-checkpoint-delay and
>> +# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
>>   #     @x-vcpu-dirty-limit-period are experimental.
>>   #
>>   # Since: 2.4
>> @@ -1046,6 +1052,8 @@
>>               '*mode': 'MigMode',
>>               '*zero-page-detection': 'ZeroPageDetection',
>>               '*direct-io': 'bool',
>> +            '*x-rdma-chunk-size': { 'type': 'uint64',
>> +                                    'features': [ 'unstable' ] },
>>               '*cpr-exec-command': [ 'str' ]} }
>>   
>>   ##

