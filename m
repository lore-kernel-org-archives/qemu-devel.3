Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4209C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s28qA-0000Hb-Hv; Wed, 01 May 2024 08:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s28q8-0000HD-8P
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:13:36 -0400
Received: from mail-bn1nam02on2073.outbound.protection.outlook.com
 ([40.107.212.73] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s28q6-0005oO-2u
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxigxbLqNCnouhxI8zFvgaVxybb9/55YWTLw2/aK3cxjBnedqny0n+y0JzjZ0AakouT3HndITwL4wttvTmNO9FeRlrxoxH38d++qre7H/+oZ9otWmPUpj0xmZqBLBidkYxu+td9i0zTumOJscnxW0OYQ+mHjNQPz0d41emYwMkMoCeLyCB4ndzZgSOAIkzZTSSVlwW1kWCpihTX7yKys+4ADngs/KDsM06CPD/wITZ8xBzS/SgCyYBJSc8Llf+wlrIzGqwVMkTv599Q6k/u+vgtZ3HHeStXKHi63Npb509nfre9Fg7cGuUYOKJvq+q6n/68TfX2C2ltb2jc58YnMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1POZ5wR50R4ji8UolccacR1YamH4PAuI54dJwWYVHWA=;
 b=d3nHYK+TBEu9nf0z7or27OhXEfH+1mNxfwz8wnMiffH4X4aTM01iCnkXMKHKmiHIbfJbONQ1mE3XJ/Yx6JUqkvY9MGHg7zdYJ4FwcHavgMxQCHKPd4fwQo2x5HT1qxZfGc+j3IEBmzI6ZAruLuEPGxW7H79/7vB56904mzBiRHRuUEe6ta8De4HZTFWveZR8DkdQ3yclSPq9RAf7fOK2P5FvXvjBWU85PBcoIpxYfu6m61PFcOitFGJadbPNgSFa/ai47qiVykK4+/DNYrT+Ijz6wqpLq83GjL2w1wjuIPQEsro0GB2tzxGkAvMKekvmwdsL+Am8zP1yy2R7GEFttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1POZ5wR50R4ji8UolccacR1YamH4PAuI54dJwWYVHWA=;
 b=ttJ2BL2MQk5Fmlx13ggeJYiNtE4B6m6yh4R2iZZ7RAMxk3GsTBw5LHra301ousTeyvelvwrbjG1Auwt5rgm4LVrng/CQ+Uk313Qt46/jxH31cJTq6Hqgvw0Zu7WGw/pigfxd7JEF8SnvKMLlIiTyTYBoQHsk/E/2u2FRPiujgn6K09ruRqTYJ6zg4bIYd0cey1JNDSXwhlR44fngw3SQ5ADKbqFHMYiEg5e55esp77MLCx+bQCVlmYiZ09K1GjdjFP03CRw6CON3oziU7/PoPfZp1fCf+Tmo3wZF/Aww+FSGBhNp+H5cvXx+oIRxrQGCFR262M5OambZc8JSmYKCOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CY5PR12MB6033.namprd12.prod.outlook.com (2603:10b6:930:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 12:08:26 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 12:08:25 +0000
Message-ID: <703aab34-1704-4ede-8398-17c0137f6e17@nvidia.com>
Date: Wed, 1 May 2024 15:08:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] qapi/vfio: Add VFIO device migration state change
 QAPI event
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-2-avihaih@nvidia.com>
 <fd972eee-068e-489e-ab45-e1985115a128@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <fd972eee-068e-489e-ab45-e1985115a128@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CY5PR12MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: cb05002e-d245-4795-fd99-08dc69d7672b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1KeVUwL0w0cWtkeEZkbjJ2cE5OUVRReU1IbFFDOG5wdjliYWV4RlVJd2hn?=
 =?utf-8?B?V0tRM1IvMktDN0hxNHFEa0tDMkJmWmRidS9velJTL3FVZFpnTnBNOVYvTEJl?=
 =?utf-8?B?YjV5Ym5kaThWU1hHdFJqQlRWKzNMa2huSW9QMnVBTzJFMXVOaVdOZk1yWXZj?=
 =?utf-8?B?cGJFWUREVTkzanE5ai9QSHpLekVpd0tQelJlbTZtYStack5lU0JrOEJ5UEtP?=
 =?utf-8?B?MzBaQTR1QkZLdnJkajhmNG5jS3JiOUlFbElWNHNPb1VNQjc5clQvYXdYQkRj?=
 =?utf-8?B?YysxOWQ1SlRrTUo5cGVFWnNFeDlQUFVKa2puV0NjOWlPM2xzMUhiMXgxOGs3?=
 =?utf-8?B?T0xySU9Vd0ZOaFY4dGtIejFsOVNUM1JxQzRxVSswWjdKMGlYQzZUbkwvU2R4?=
 =?utf-8?B?dXA2ZUFYMjByRWlQdHQyVzlCNEN5ZEMrSHBmLzM0TmxpWC9vZ0dsbllFNDJo?=
 =?utf-8?B?SWtvR3dBaXUzZGdqRURELzJwZzAwODdkT1ZCbXcvcWcvRWJ1WmUzTm5MMkov?=
 =?utf-8?B?L2dkWktubWdac1dvQlBQSFRyWWI1bDZwZmFUYTkwS2FkT3RuSXRQQXJCTXcw?=
 =?utf-8?B?UkdRMVFhTndwWVV3NlpSRUpUOUI4UjBZOXBqZklLMVVRRnQ2eDZaOE9WdHFa?=
 =?utf-8?B?MFJWNUtHV0h1akZrakFrYlRLc2IySFh2ZWpSZzRKVWNtWThOQTk0R1M3MXp6?=
 =?utf-8?B?NVJ1dFc2Z0ZJVHFVK0VnUUZRUXZBZFltSEMxck9IekhYNTR0STkvVkMzZlFE?=
 =?utf-8?B?VmZva2lBVHhPTU1DQkp6dnZBVHJvb0FUK3g3MnJWWCtZVzlET29CejZoVlZj?=
 =?utf-8?B?azVHYVlONmhVL1diV3FuYVFveXpMbXU4ZHgxT2lMejIrT0t5RU94SGhNZG02?=
 =?utf-8?B?ajJOZ1JrbjcyODZ0UDhudFN5QnRjeklURkFlM1YxWmJPNTQwb3dlWkpMSktP?=
 =?utf-8?B?b2RKZmhMQ053QURMRDdRU0tnMFgxKzkxVlplUGM1OFFYaTVuNnhFMU5sVWly?=
 =?utf-8?B?OHNDRTE3Q01BSmNjSzhjL3VScldFOVVLTDhuMlNhQVdSSTY4U3Jrc0h1RCtn?=
 =?utf-8?B?amJPV2w0K0hrcGNSNk5CdEpXbE1xTFFWOVk5bWFxVTcwSW1Uam45S2hvMHc1?=
 =?utf-8?B?S01abkE4RjZpelQ3WFQyVkRKWDRtVkNhUk5nRVF4VDdIeW5hRHVIcjhxVjBI?=
 =?utf-8?B?RDhZS3REYUcwUDlvMzNSZ213dXBxeWczZGlvM1JHTW5ESEhKVnBNS2dwM2Mz?=
 =?utf-8?B?M1VWZlA5RmJ5RTlaN2ZDN1M3SUJqZ3l2enpUVS9oMTFVVHZMeFdZVDlCT0tZ?=
 =?utf-8?B?UlBjaVhieUxaWHJHV3NqR1I3bGRnSFQxUDJKQmN2L2NEeTZTRHN3UTlNSkpo?=
 =?utf-8?B?RVBkN2lnQW1wcTIycjRMUGEvYlNSdlFIdmw0SmJwRTVhR2k3YU0wNmliS0kv?=
 =?utf-8?B?dERYMUNFbUx6amVWR3lpN0c2Q3VVbmt3LzM5VUxTN2s1RVBrYVBNdlU3Qk9x?=
 =?utf-8?B?MjQyU0xhWFFXRGFxdkFjbTBQNTB2cjZDTjYzMGtGbTMyblRIN1VKc0wxNy9L?=
 =?utf-8?B?MHRUMmpzQnpCUjFLMCtGanMrMXdya3o1TVlBTjhqbkNTYnB6WnRUQnMxUWJV?=
 =?utf-8?B?VFRGd3lIOGEvZTNyemhZYXVDaWpVNU9yOTd5WEwyRlJlQUhrTEVuYUJIUEov?=
 =?utf-8?B?a1BvMXNWOE9HZnRzU3kvcVUwQ0VFbzFOd0RjU1dDWHBFbUxpVFhsT01RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEtZNXlIZGphV2RuNHM0VVhQUXg4eVFCUkp3RWVuSmEwWEg1ZmlZZ0tveFQ4?=
 =?utf-8?B?RmtCSGlmSW04WWl2d0R6SzcvK1ZFUGRYUnpXOFBwWGxQeGcvOW1BR3YwSUN4?=
 =?utf-8?B?SDBPcnVQNWZKcXBDdEhnUXRlNHcyYncvMWF3cW5JMzc5VUhSSFpDTG9aMDFR?=
 =?utf-8?B?dUNIdkI4aE9LR3pJTUE4aFlHVGFOcUtVV1hZRm9tZFVMbW1zM095aDdSRGNN?=
 =?utf-8?B?L2dLaXM5aWhqaTlnbnB6RkI3dnZ4WThRcDY4SVhrQytjcVBVaCtqWjJqdkV2?=
 =?utf-8?B?TndaQXRDWmVma253bmZVMzRLUHJkVER0OW9ERFpISW1JMnNDcm1rUjY4NHNV?=
 =?utf-8?B?eHc1blhJV0xUZGhBTHBqQmNralVoK1ZUQTY2VnIza2JTbXR3cUU3RmY1a0tO?=
 =?utf-8?B?RG83WTJtb3BoR3VUUFJaUC8xb0trSytzVzJKQXhQYjdIWjU4NnFNaEZlQWdr?=
 =?utf-8?B?dm9BWGxucWpCcVErTnRkUWFPVm1lWXJQaUpobjg3QWxhdmg3SzVhMGhZUFNO?=
 =?utf-8?B?Rmo1NC91TmV4SWIyMjQ1ODA0WWhUb2pCcGdqL2lzT1ZGc1JkZXVVUmx0SVNi?=
 =?utf-8?B?SzZjeTNHQzdoME96SmNCRWJjbDgvZmZieE1aRmt1Y2FZYm92VzFPSjBUMjJN?=
 =?utf-8?B?UnNQVnpyaDVuL2llZVZJRDNNL0dESTMydWFOcGFreXNtbXJxU00wdk1TdW1Y?=
 =?utf-8?B?SUxVU1dvQ2todWgxTEhQOHN3RzgxRDJEL2wreEFiOUc0RitpNWZpZE5UdWhC?=
 =?utf-8?B?cTBmWEJoWW5sb0s1RkNOTFBJOGZ5L08xTERKVVUzd1BUczdmUUdIYkt2S01H?=
 =?utf-8?B?cGViSnVCOG1HWitVVml2cFhUL2lhQVBBMkFIWnBFYzA2a0dIcEI2bnQvc2Z6?=
 =?utf-8?B?UlJad09XamhJb1BSYU80NTk3OXhBTms4YmNCTVJ3bENJOXM2ZEdMOGhTUFFq?=
 =?utf-8?B?cks4TzFkYVZvQWdqbHNQekZUYnY1R0hJb0hHMWtwK3pxYVlGVnpzclRDd2Fj?=
 =?utf-8?B?eWNpeCt0Y09Kanp6bWNqWDBqc0p0cm12THFvdnErUExQcDFkbmJGamo0Z3BJ?=
 =?utf-8?B?SThSLzVIeWVseU5FVjNPOVl3Q2JyeXg3SHpSaVF5VWpTZVlMdVJRa09OZytQ?=
 =?utf-8?B?N1hPSVZ3TGY1ZUg1dUROMUhFWnUyZWovMFZ6S3RMdlVBNTZTcHdOUEFoQytT?=
 =?utf-8?B?Q2ZYSHRqY3czOTdJR1BEbVV4Z0EvdlJjZkpVMFhsRTNyWHFhOEd2M0djVkp3?=
 =?utf-8?B?ZTUwS1gvdkJyeHVvVEphL3R3dWVaZzBpQmN2a3hxeWtWSnZoZGl5QUlqMzVR?=
 =?utf-8?B?Q2ZnclByaUdPT0pyY2RVRXRkenlCSWQ4SGpvNXM5VnBFb28rR1J2ZWJMM0RU?=
 =?utf-8?B?ZEtQUnJkZUxSc3RpTkV1MGxra2RNMTFqUm94QkxxWDIxS3UveFBkSkp2Yjgw?=
 =?utf-8?B?SjFRK2gwZjV4RzJUYjNwK3NhUU1RVnpnOUJvNGVFVzBtU2EvNUJzVVQvNTl2?=
 =?utf-8?B?UFFKUStEY25QUE9Kdm1LNFdNUFZ5WGJpVjZIQStWVWxmNnVIVE1ZdFgwc0tH?=
 =?utf-8?B?cDE3VjlVVk9pSzJiMjh0MlRNTk9JdzEzYXh2Rng4eHMzaXM4b1ZJdEIyaHJW?=
 =?utf-8?B?NzloNHdNVlpJdzNHNkV1Q0VwQS9aRUM2NW9uRjdXenpsSmdhY0tIOFBlbFIr?=
 =?utf-8?B?WXMwdU1kMFlMTHJmZjhOcTVQay9MZnl0SlV6ZWNKRXg1ZTJ1ME1kSElGRkFl?=
 =?utf-8?B?VnhkYVBtU29pTXpCN1BKbUJSV2VGYzkvckhrV21CRlFSMHNKR2F2NVFvQ0xl?=
 =?utf-8?B?cGdUWkdjZkEyTGV4RDBYZmR5bWNGakMyeTN0cEZNaVB5NWxUVTdUSnlhVFRi?=
 =?utf-8?B?OEpXZktKOW5tQ2FNMldFdW1QQVZ3cEJsNzQ3bkFGU0ZGYXZvY1VucGdsVSt0?=
 =?utf-8?B?UWFEUS85c0loeEY5K2NSejdTZWhhRjBHN0JZUXEydVBBZ3Q4YTNCZXZwNXJP?=
 =?utf-8?B?QTJVbnRiVHd0cXVKbG5aWkw3anZIcUU0SUQ3LzkzQXVNeHJOQmw2UW5aSndV?=
 =?utf-8?B?eWNWNlNGSWtWR0x6Y3pXUHRXaFB4bENFOGV2eHpLSjJIWmhjUXd4OEc3WHhi?=
 =?utf-8?Q?AW4Ie7O4mHWrFgscYApiZjkJ8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb05002e-d245-4795-fd99-08dc69d7672b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 12:08:25.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvHBOX/gSQWwfD+cmuebVXqsMwBEUp22eTsb9jCt15rUXkxcw+5YRx9Ik8IBRfnGSOq70rf6Si8JvK7ZDQsmcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6033
Received-SPF: softfail client-ip=40.107.212.73;
 envelope-from=avihaih@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 01/05/2024 14:50, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 30/04/2024 06:16, Avihai Horon wrote:
>> Add a new QAPI event for VFIO device migration state change. This event
>> will be emitted when a VFIO device changes its migration state, for
>> example, during migration or when stopping/starting the guest.
>>
>> This event can be used by management applications to get updates on the
>> current state of the VFIO device for their own purposes.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   MAINTAINERS           |  1 +
>>   qapi/qapi-schema.json |  1 +
>>   qapi/vfio.json        | 61 +++++++++++++++++++++++++++++++++++++++++++
>>   qapi/meson.build      |  1 +
>>   4 files changed, 64 insertions(+)
>>   create mode 100644 qapi/vfio.json
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 302b6fd00c..ef58a39d36 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2159,6 +2159,7 @@ F: hw/vfio/*
>>   F: include/hw/vfio/
>>   F: docs/igd-assign.txt
>>   F: docs/devel/migration/vfio.rst
>> +F: qapi/vfio.json
>>
>>   vfio-ccw
>>   M: Eric Farman <farman@linux.ibm.com>
>> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
>> index 5e33da7228..b1581988e4 100644
>> --- a/qapi/qapi-schema.json
>> +++ b/qapi/qapi-schema.json
>> @@ -78,5 +78,6 @@
>>   { 'include': 'pci.json' }
>>   { 'include': 'stats.json' }
>>   { 'include': 'virtio.json' }
>> +{ 'include': 'vfio.json' }
>>   { 'include': 'cryptodev.json' }
>>   { 'include': 'cxl.json' }
>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>> new file mode 100644
>> index 0000000000..a38f26bccd
>> --- /dev/null
>> +++ b/qapi/vfio.json
>> @@ -0,0 +1,61 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=python
>> +#
>> +
>> +##
>> +# = VFIO devices
>> +##
>> +
>> +##
>> +# @VFIODeviceMigState:
>> +#
>> +# An enumeration of the VFIO device migration states.
>> +#
>> +# @stop: The device is stopped.
>> +#
>> +# @running: The device is running.
>> +#
>> +# @stop-copy: The device is stopped and its internal state is available
>> +#     for reading.
>> +#
>> +# @resuming: The device is stopped and its internal state is available
>> +#     for writing.
>> +#
>> +# @running-p2p: The device is running in the P2P quiescent state.
>> +#
>> +# @pre-copy: The device is running, tracking its internal state and its
>> +#     internal state is available for reading.
>> +#
>> +# @pre-copy-p2p: The device is running in the P2P quiescent state,
>> +#     tracking its internal state and its internal state is available
>> +#     for reading.
>> +#
>> +# Since: 9.1
>> +##
>> +{ 'enum': 'VFIODeviceMigState',
>> +  'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>> +            'pre-copy', 'pre-copy-p2p' ],
>> +  'prefix': 'QAPI_VFIO_DEVICE_MIG_STATE' }
>> +
> Considering MIG can also be interpreted as Multi Instance GPU elsewhere
> unrelated to this shouldn't we be explicit here? i.e.
>
>          VFIO_DEVICE_MIGRATION_STATE
>
> ... to avoid ambiguiosity.

I used mig to avoid long names, but I don't mind changing it to 
migration if that's clearer.

Thanks.

>
>> +##
>> +# @VFIO_DEVICE_MIG_STATE_CHANGED:
>> +#
>> +# This event is emitted when a VFIO device migration state is changed.
>> +#
>> +# @device-id: The id of the VFIO device (final component of QOM path).
>> +#
>> +# @device-state: The new changed device migration state.
>> +#
>> +# Since: 9.1
>> +#
>> +# Example:
>> +#
>> +#     <- {"timestamp": {"seconds": 1713771323, "microseconds": 212268},
>> +#         "event": "VFIO_DEVICE_MIG_STATE_CHANGED",
>> +#         "data": {"device-id": "vfio_dev1", "device-state": "stop"} }
>> +##
>> +{ 'event': 'VFIO_DEVICE_MIG_STATE_CHANGED',
>> +  'data': {
>> +      'device-id': 'str',
>> +      'device-state': 'VFIODeviceMigState'
>> +  } }
>> diff --git a/qapi/meson.build b/qapi/meson.build
>> index c92af6e063..e7bc54e5d0 100644
>> --- a/qapi/meson.build
>> +++ b/qapi/meson.build
>> @@ -52,6 +52,7 @@ qapi_all_modules = [
>>     'stats',
>>     'trace',
>>     'transaction',
>> +  'vfio',
>>     'virtio',
>>     'yank',
>>   ]

