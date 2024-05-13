Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57142C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Vz7-0001Mc-QA; Mon, 13 May 2024 09:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vyz-0001LO-KT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:44:51 -0400
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s6Vyw-0000wc-Vm
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCNkZuMQVcKKDNE10D5rM8QvjUY0g9O249gmmeKUUIQmfMO0xxj3iV8aUj1dSalQd63dZIFV8p/vIPHDSQ3r1WEjXcak3gzTQgcEMOPY7oa67vrlt0fhppq0vbTfLzhXaMajIFVwxRAk3oeB9DB0xHVmM+3MtTKuwz/8S3axIz0AVre3bY5I8fY+DYJllnrRtsb/gFto9f5VouW0vdi4eaUFoRLTgphFbZxTOq6hE7V9FQQihiuXt3szalmiUqf7mpdQOf4e1fbYSaYogXFvUaJkojnkgYc9J1/Gb1zXxgME8ej9gk7cE+lCLHee75QkZyAh/635I+FNXJb6arG1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mScpxhvsgPQARJaWO+ficSTRxc7mghsQVNbQhvRspuk=;
 b=QBMOvUIC4g2piwmjj1PbHPOjoRp/grWjz0yZPMMedK0y8xvZgVr8QCTpvvq7lNpaj7oFvhktzuO2gtASniSbaQt4gIP9dJWRxgV3WsIlefGS4dxv1UhG4VGcNQ3irlu2Qxp0JzCB2Ev9Uh1VC386XogVPL/Lm4Ak7tkog+Sp0scrpMnyN8ga0KnCHzqBBRXAIP19CtcqikhJ4EAMlps+GwMrHykXEMKRz+k9wTLZEtV3kOqtY3yoq7Pzw6hf8/ZhCsMx/5jm5q7jP84ePf5UrYiGuCj+mfFFnRqORvQUz8hsRGh+lUGAuDyaXuHQITwyEvho+3idA9bNQx6Hj0A39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mScpxhvsgPQARJaWO+ficSTRxc7mghsQVNbQhvRspuk=;
 b=K17Fd8/uJLpMb+MVb+Zigygw32gRuQT4w7ZmPZpL30tT1mkcBWfk4z14JMGXmw48m42jBSgiuEQyf/Tdwnzey8XMB7fL240oAhQqYGUwlDqXIYZTYWKPWhXEN2NgiBD1zKnnMnlAi/Gu2BlWLZs9ECO6+hqzrxhDqnJHpxupJkOIBJBqaDRn0H9m/uYfMrFjMiq0yKIdBbGTnLkikALMQC1+8Nt5Zi+6gqsHE7MwjNCz2czx0C7aEeJl8pfDyGGx6fq3XCLqO15awqirhlyBb54G7zyAVjOauxXcfhqyL4UuEgMN8iUA4Ti98Y9DNq8mWXA4sT//VcVh0/nAdO7pKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH0PR12MB8823.namprd12.prod.outlook.com (2603:10b6:510:28e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 13:44:39 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::d830:10ba:ec9e:7b80%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 13:44:39 +0000
Message-ID: <608bf953-3a75-4edf-8b82-3fa53f7f2dbb@nvidia.com>
Date: Mon, 13 May 2024 16:44:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] memory: Add Error** argument to
 memory_get_xlat_addr()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
 <20240506092053.388578-8-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240506092053.388578-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0188.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH0PR12MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a971e6e-61dc-4855-da95-08dc7352d5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TThjOUY2YTRodVJpUFQzbGt4UHF1TUN6bWN0cUxOQmRFbHltckN6OVRBT3Zj?=
 =?utf-8?B?bTZuTHl3bmNLeHd6WTlJZE5MZmdEcnFPcDF6UWNMZGtPRk1lb2lmKytjYlhJ?=
 =?utf-8?B?ZkpjbVFZZ1hpT3BzVllTNDA2aENsTTlvL3FFdTRKRm5QN0lDcTI0MWRxN1JX?=
 =?utf-8?B?bFNqM3c2VTB6NG0rL1pEOWY5R1EzRlc1eXUyTFgxaW5aZGNtUFdDTytkVEFW?=
 =?utf-8?B?Y0EzbkRydkhWOTVHbkJRc3o5SUFEVFA4d1VsZTFIT0lpd0tYQlo5NGliSUJa?=
 =?utf-8?B?K1FXamFVbHNpWUVXR3lqc0dZU1RraVBLcVE1UHJrZVhjekRVQ2x1SjAzUmVD?=
 =?utf-8?B?dFZ5cWt1MlphMDVKZmIvUFpFK2o2ZS9JN05yRHJQbmpjalZYN0NaUjdlMjZN?=
 =?utf-8?B?TEMvcERJbUsrUEJtT0dZQlZvWlNHSmhaWW9ib3FnaDZwMGprWXZtQU1tYnl1?=
 =?utf-8?B?dnZUVjQ1OTMrb2NOL0lhTnhLMUwyWXY5OXZzSGxQS0d6dEFSLzc2eE83RCsr?=
 =?utf-8?B?eSswS001UGthZWdxbWl0TlFXMFROYVI2aXltUTVOcWdGZ1RwWWkyRkw3d0wz?=
 =?utf-8?B?ais5RFU3TDJDMjluNGU5eHZPWURUYm4zUlNaYlU0eVNyQUxtb2pQaWNLSDhK?=
 =?utf-8?B?VmlLT1RoZW5mcTVMc0JaVjM1ZHNoYUZSRm41OXllQzY5a2o5cFpkanNwdXZj?=
 =?utf-8?B?eWFrL3E2YVVrWjhHa2ZWSjhQRUs4TGp4T0lEbGF0Z2JRdkkrYitCdUtSOVFx?=
 =?utf-8?B?djRLL1lueS83a0ZFQUhReHZCbDAzaTVuUy84NUV3VjBoNk8xUm5SckZqZm5z?=
 =?utf-8?B?TU5DaGxyS0h2RnNub3JMcXpEMlI2TWtHdi90VVJja2lIdHliRUJ2bkZOM1Ns?=
 =?utf-8?B?VU1sUGFBck81RVRIbTgvbW1yZ25JMVRFamR0VmFiY0tEVHk1MVRwZ0dQQi9N?=
 =?utf-8?B?elVWRFdoRWxYemtWbFFRZm5zNWdBYmJIdW0yVjRvQ2ZTUm9Hb2pwT0ZVNERJ?=
 =?utf-8?B?L1lhOWFrT3Vpd3BoSkNyVXZpelBDbVZXUFA5bGorM1h2cWxPT0oza0lvMkdU?=
 =?utf-8?B?K3IyZGFkMXVYQ0xiSjRidFRSNXpLSnBwTmM4MWdacWdNa0ZwWmxMalJiVlBS?=
 =?utf-8?B?MXpqU1JHeFhPdTNNTkw2RDdWQWM4QzhQc0ZLUjE1YUNRQTRtamJLTWlwQVdw?=
 =?utf-8?B?VFkxRXNyeGZiMFNrQ0RBQnpIYVM1YTZNYW8wNEF0T0c5U3A4MG5ad0pPNTNi?=
 =?utf-8?B?eTJMamdwdndNdmQ0UGpEby9FejFHVGZ4OWVRdVJTN2EvMHpWTUU4NmdZZGx2?=
 =?utf-8?B?N3NCbDFVaUN2MGlFdnprbFByS2gxclBkQ2Q0VXQ3ejhIZmtUL21OOXVGVkx3?=
 =?utf-8?B?VWk5cTFDZVZ1UzVuWHlpWUl1YUJhdTFZQ2lhTVZRcjh5ZkxJZUIvcy9ncXk1?=
 =?utf-8?B?VWxmenlXcnVtQkU1T1BDRlJidVBicUMyRWFrUi9QTUVoVHRGTVZkSEV3N0hm?=
 =?utf-8?B?WGdvc3RBMzgzUnFQcEYwK1BnTjVzc3E3UVMyR2dmOGFhZ01GUkhsZXRIWkls?=
 =?utf-8?B?WEUwMnVnTnZub3p5WTdoQVdocTFENGhHRTI4Rk55cDh5LzhlZ3AzblVYaGh6?=
 =?utf-8?B?UnB4Z2w2MHc3Y1ZSeENjVGJGRXNEbVo4VDg2UnV2emxvZWVaQ3FCVWpxRWZh?=
 =?utf-8?B?THU4T2V1U25ya0dUYzVrN3FhaXcxR0ZBSjV6bmwxc3loYWkybHBMa2tRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJOTmpnMEhqTjdYL0t2b3gvNHduQTlCZU9ESmlOMXpaa0wvODA0T2tBQ2pB?=
 =?utf-8?B?eno5bnUrVEpDeGxudlRlVTk5a3lqc2lJUFhyakcxUnI0eUY5RlNzUW1YSFhK?=
 =?utf-8?B?UCtRT0pvNzAzbDlxbGhrb2hhV2RBZ0FrQXBrd28yU3FxT2FHTG1aTVl1NFRH?=
 =?utf-8?B?U1VPaEFjQ3F5YzFoaXF6NVlQU1Qwc1hrSS9NMXFRUmxoRHVodHRMK2lyVnZk?=
 =?utf-8?B?MGgxVnRxazVaY3hKY280Wm1mZXdJcmxWNVVRZmpJdVJqeWZpR3RPRFhWYzRi?=
 =?utf-8?B?WjR6U2pWV3V1cysvWFZFRVRXQWhHUFJ4RmJvZnJ0Y3F0SGhXdGVrU1l2MmJu?=
 =?utf-8?B?djREUzZsRFp5LzVWMVhCRjZESVgxU3N2Ri9xbVJQQmlZakZyUzh2dUh6SnVO?=
 =?utf-8?B?WHRGQ2FTNldwcGFiNjVHMlZmbjgvYXQzZTJvZ3V2aGNGaE0zUkU4ZE8zSUpY?=
 =?utf-8?B?UUZRNkVtL2FtUk1pa1Y1eGcya2kvY0ZySmNOL1NvblAzdHMrSjNqaXJWODJa?=
 =?utf-8?B?RFZsVEV4NTlCWWpRSXFELzBvMmljaUxXRGRYSFJRb0I2S1RKbys5WVM3MzF0?=
 =?utf-8?B?eExKN3RQbGxRaEJBam50MTNicWpzY3JPc1dxQ3Y2dm1LWWdtdHhlMWEvL2hp?=
 =?utf-8?B?dU85ZDR4bUtNZmFHSWlZNllVM25nSjNpNytuUTdxeUswRm8vb085MERvM21z?=
 =?utf-8?B?WlVsMHE3UUhqVjBnY0ZvaXpRQ005RHR3cTh5bDY3NVJSd0J0MDYzTDNTM09K?=
 =?utf-8?B?WWt0MzVUU25reVZ0ZThoQm96aGtSTStTcjNyTGZtQ3daYzRJdU5FQVZ5SDJF?=
 =?utf-8?B?LzhGTm9jRFF2UThYYU5TejNBSHVCS0dVSlowRVE1MEJhWVVVR1dUSWU2UkdE?=
 =?utf-8?B?R21Cb05XSEhNdXNCQ0NZT0NtZnVqV1M2eXFVVVBoR0xoRHpkcWhteTErcGJS?=
 =?utf-8?B?bGc1S3F2VWJLOXN4THMvbGFBcldsV2RPMHNHWVJtM3hDdUVWUEdXdVlyWW1m?=
 =?utf-8?B?ejcvMjNWeFBMQlVCYSs2d3EvMk5lTm0rYWZlbkJQd0Y5TGtvNXZuUWpCUXZq?=
 =?utf-8?B?LzFENjFEQ3EyNGVLb01ueDgrV1QzZ2grd2xDZzRWYW43VmNON2p6bk9DZWtk?=
 =?utf-8?B?bXhqRzBaVHBLbGhuTkFtdXJ0MC9lSldXeW1rUE9vVkhOZWx3UkhHWFN5NThW?=
 =?utf-8?B?cXhmUXYwRTZyWjN2RUUrSW9NN2k3UlJjV0NqL0Ewd1VCMGdYQXo1b1lvWFU1?=
 =?utf-8?B?Ylk5WGtaU0ZBMEo3S1hGK0d6NWswR0Fmakk1em52cU1XOXpRRFpheFl6UnhG?=
 =?utf-8?B?NVYvamdMYkFCZkRyU1VuV1ladE84eFFNbFFGVy8wanQweDRzQ1MxUjErOWpS?=
 =?utf-8?B?YXpRVWlTMUVYL0s5N0l5OG5RbXl1WHdBMlF2VDZmTnNqdnM5ZEFpQnFYV05G?=
 =?utf-8?B?NC9TRkpWdlFSTDZZRVJvQW53OStEWlZibExyLzRMSkxnU3lGYjVrSFBFbk1q?=
 =?utf-8?B?RzIxL2puYXNla3g0TXh6elFxdmEwbWFjRG5nUUFCcSs2dW44WmIwZWVTVmF0?=
 =?utf-8?B?UEtTMmhNQis0TEZjTkNpOWFKU2JBelJERFNhZ3ZTVFZuQitQOHY3OFhPUElt?=
 =?utf-8?B?N29kcHNubU9EcUJuTlI0UEVJZzg1aTRqRjRaOEFNWWRvMTFQOHNhdWZFNHFq?=
 =?utf-8?B?MDFvaDJQdTFyRVp2TFhqOXNJZXh1ZjM4S0tSQ09BSHo1aXVQWHNsYUdpY0NV?=
 =?utf-8?B?U0t6U1orQ3N2UHpNMi9MRzlGdi9LTkxnbzVuTjdtdVpOdUxWWVllQzQrbFFI?=
 =?utf-8?B?SDJEVy9UQzVsUFErdXRLUFhsRlhUSzdYanVJTlUwdmUrZHdLTHVYanJEK0lV?=
 =?utf-8?B?dmlWZWdYcEUwRzdXRlNHaXZzRTFnMTFrdTlxUVk5S28wWHJjOFMzYlI3cmlj?=
 =?utf-8?B?cTc2YkYxRnorMmRENWp5aVRZYXh4aHRuVnpzcXlGaVUyQUFNN1p5dm1aQzQv?=
 =?utf-8?B?UTRoSnhMODBFcHFNRXU1eXM0cFd2Yk5tTHVQM0hldUxqM0I3alFSVENOZWl3?=
 =?utf-8?B?QWdISjZlTk9wVnZkSkE3STh0RUhVdmhLZDRSNWE1dXh5eTZqSTFMN3JQTlZP?=
 =?utf-8?Q?8fBhf6Qr5vt90mOF20dthvFuf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a971e6e-61dc-4855-da95-08dc7352d5e7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 13:44:39.4945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MimR6te/6psQDGBkNjB1Dcyp5PdkAn+S/06P/LmA1r0sC3ND/24xOSHloFTA0NkoktfBWaO3jlWUlqB+nhL2IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8823
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 06/05/2024 12:20, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Let the callers do the reporting. This will be useful in
> vfio_iommu_map_dirty_notify().
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/exec/memory.h  | 15 ++++++++++++++-
>   hw/vfio/common.c       | 13 +++++++++----
>   hw/virtio/vhost-vdpa.c |  5 ++++-
>   system/memory.c        | 10 +++++-----
>   4 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index dadb5cd65ab58b4868fcae06b4e301f0ecb0c1d2..2c45051b7b419c48b4e14c25f4d16a99ccd23996 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -774,9 +774,22 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
>   void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>                                                RamDiscardListener *rdl);
>
> +/**
> + * memory_get_xlat_addr: Extract addresses from a TLB entry
> + *
> + * @iotlb: pointer to an #IOMMUTLBEntry
> + * @vaddr: virtual addressf

Nit: s/addressf/address

Thanks.

> + * @ram_addr: RAM address
> + * @read_only: indicates if writes are allowed
> + * @mr_has_discard_manager: indicates memory is controlled by a
> + *                          RamDiscardManager
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Return: true on success, else false setting @errp with error.
> + */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager);
> +                          bool *mr_has_discard_manager, Error **errp);
>
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index b929bb0b7ac60dcef34c0d5a098d5d91f75501dd..da748563eb33843e93631a5240759964f33162f2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -253,12 +253,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>
>   /* Called with rcu_read_lock held.  */
>   static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only)
> +                               ram_addr_t *ram_addr, bool *read_only,
> +                               Error **errp)
>   {
>       bool ret, mr_has_discard_manager;
>
>       ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager);
> +                               &mr_has_discard_manager, errp);
>       if (ret && mr_has_discard_manager) {
>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -288,6 +289,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       void *vaddr;
>       int ret;
> +    Error *local_err = NULL;
>
>       trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>                                   iova, iova + iotlb->addr_mask);
> @@ -304,7 +306,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +            error_report_err(local_err);
>               goto out;
>           }
>           /*
> @@ -1213,6 +1216,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       ram_addr_t translated_addr;
> +    Error *local_err = NULL;
>       int ret = -EINVAL;
>
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
> @@ -1224,7 +1228,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +        error_report_err(local_err);
>           goto out_lock;
>       }
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index e827b9175fc61f1ef419e48d90a440b00449312a..ed99ab87457d8f31b98ace960713f48d47b27102 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -208,6 +208,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       void *vaddr;
>       int ret;
>       Int128 llend;
> +    Error *local_err = NULL;
>
>       if (iotlb->target_as != &address_space_memory) {
>           error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -227,7 +228,9 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +                                  &local_err)) {
> +            error_report_err(local_err);
>               return;
>           }
>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
> diff --git a/system/memory.c b/system/memory.c
> index 49f1cb2c3835f78f5f948531cbbf13adc706f1ad..e2b9f0aa9ea7326a5bedde28b8c777cf86bc253e 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2179,7 +2179,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   /* Called with rcu_read_lock held.  */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager)
> +                          bool *mr_has_discard_manager, Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
> @@ -2197,7 +2197,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>       mr = address_space_translate(&address_space_memory, iotlb->translated_addr,
>                                    &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
>       if (!memory_region_is_ram(mr)) {
> -        error_report("iommu map to non memory area %" HWADDR_PRIx "", xlat);
> +        error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
>           return false;
>       } else if (memory_region_has_ram_discard_manager(mr)) {
>           RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
> @@ -2216,8 +2216,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>            * were already restored before IOMMUs are restored.
>            */
>           if (!ram_discard_manager_is_populated(rdm, &tmp)) {
> -            error_report("iommu map to discarded memory (e.g., unplugged via"
> -                         " virtio-mem): %" HWADDR_PRIx "",
> +            error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
> +                         " via virtio-mem): %" HWADDR_PRIx "",
>                            iotlb->translated_addr);
>               return false;
>           }
> @@ -2228,7 +2228,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>        * check that it did not truncate too much.
>        */
>       if (len & iotlb->addr_mask) {
> -        error_report("iommu has granularity incompatible with target AS");
> +        error_setg(errp, "iommu has granularity incompatible with target AS");
>           return false;
>       }
>
> --
> 2.45.0
>

