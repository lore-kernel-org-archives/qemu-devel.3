Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475FFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 11:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTJrt-00062S-2d; Mon, 15 Jul 2024 07:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sTJrq-00061X-H3; Mon, 15 Jul 2024 07:27:42 -0400
Received: from mail-westcentralusazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c112::] helo=CY4PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1sTJrc-0001Br-QZ; Mon, 15 Jul 2024 07:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8A0oaciG7mvNKBwKB84cYa/7xMS4IU6klv2UsCOq++1og0LtbIzB4jIO03Wss5T7mm2lU84GHlfmF8d7GIJJAcBfX291f21AnX3MgrxeyjqxTLiOXaAdBFfNm2tIgnq5wEFYTZY6EuUyRG3+pNz/aNEsylOQfN0XYnc+IE3SUM949EbBpjiduVTJYRoK7Z950ce6nKoMSW7SmVr+jPZiv+KkWjkooWDa5V9B8yCxWu6r3TPLu5m2hVjaCPEp8u+SorEOUn8UZC6K1N0SAiMd9yCF9o7K80ioz+NqyNKT3dJqIA2hHqgxsFRtZR3xwGJPp2EhWV64QQVFHsPY1DDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n06CeOzLU8y7qAnwKlKg4Copl4WgNLsWEnv7C38w3eU=;
 b=Jm7+D/6qSDg+qnpTY2/x3EzzwZWqEJPUF6ESaZ1EHxNls6/W44rA9W12I2VDmJicvrN6vKfigkrcr4twKPHpVWNhM7bItvHNZjvStoLZHUCcyS2OIctD0pNdENJbOo0/I9wpjJJUoSsli+9rUR3Z2dzgGsQCJsm97dkepl3nEwXt8U6iDHVVJuvyeIOSa+268PELSmfKFn0X86MpntbgRN6s/BTtoriVYJdzUzJ3wLAYuPPwO8WUv2bwQwUpU23sOTBvvxIkETqLoIrW5X7KY1cqJRl7PZk7AYNdZjL7OGkA/ol0GJ/wMkYdznxqbEafh/Xno80OKYzx6DEP6pAz5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n06CeOzLU8y7qAnwKlKg4Copl4WgNLsWEnv7C38w3eU=;
 b=TVURFzDJCUtiFPmynCPF3UnJH5rFXwTzKx6EOJv86ncjegMRoF6rrlOYV/aHhlbzQFKtX4GhYA3XBhhEjSCho63U5e5wnfVaMKTJW+RlRl7XHjucU2hnnnUiedlqtMDw4w9QV5YalEwaucP349FAlO++/88nfT48lhtIHugPfts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 LV8PR01MB8480.prod.exchangelabs.com (2603:10b6:408:18e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.27; Mon, 15 Jul 2024 11:27:19 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 11:27:19 +0000
Message-ID: <2b4bef01-5bcc-458c-9110-d2debe3f3620@os.amperecomputing.com>
Date: Mon, 15 Jul 2024 16:57:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: darren@os.amperecomputing.com, Cornelia Huck <cohuck@redhat.com>
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::8) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|LV8PR01MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca7104d-d889-4fc3-ddba-08dca4c11660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGpjQzN3MlJSQVlhdTJxT1Zkbnp5RjlNOEhWV0hVVFl5dFZDOUhicG9iNkVo?=
 =?utf-8?B?UndBd0lCdGF3NENicGc5dkNRSW50T0M0b2tjb3NQWTRWWWpmRk8vNkxKOSto?=
 =?utf-8?B?dFRSdm91T2xVdGROK3UxR3NaVHJkM0V4a3VBTDRBeitaL1h3amVVL2xqN1VH?=
 =?utf-8?B?eGtxMGEvZy9FblNVRmc2KzNwSDVYM0RHYzVTaUQ1YUw3aTN0N0xsaTdTSzdL?=
 =?utf-8?B?cURlMXhiNmROaHFoYzEwUm9uWDluZHFCQ0FwNjhWd21PakUyWlRCNjVLMGxr?=
 =?utf-8?B?dWt4VTJuemMxam4rRTdZbEJlcmdSZWxtSVRqWkxZdFNha1hYN1I1K3BQUGUz?=
 =?utf-8?B?SjJyd1FaUm40TVcwSGUySWZxWHpYbm9zRjB0aWNvbjJpUjhqQkMySjRIYUxW?=
 =?utf-8?B?dGRsS2RTZHNZNUVKS1g1VytrNjl0VkZUTVVQbWJPRCtObzZpYWh0Nm5EdWRY?=
 =?utf-8?B?eU5OalE2QjhXS0kzazlQdGJuNS9IUkt3d2lMNENwSjlidmlwUnFIUzlCRXhm?=
 =?utf-8?B?NG10dEpvOHd6QzhrQ3BlaHhSSkh3MHdrdFJtRi9UVGJ0ZGlBajdoMUJHUFdV?=
 =?utf-8?B?VWpjVXVXSG9JcXAwQ0E1bjI4U0ZQcmVyTFVSN3A2SjBsdlp2Tlg5RnBzS2lj?=
 =?utf-8?B?RmlocE1acktQMEZnT1l1V3dPOEU3VThNK2I3L2pKWEIxK0tpelpTRXFrdUdF?=
 =?utf-8?B?b3A2c0E5ckxHWEN6bmpSMnJPVE00dlZsNmd3bTBVcUh3V2lydms1bWtPT1lD?=
 =?utf-8?B?OFhUcVA2ZS9neDd3N2RVUFBrWXpQeUMyanFCSWpkK0tJeCt2VFB0bklmL20z?=
 =?utf-8?B?ak02MlVvb3BaUDYwQUNPeVFMVi8yUWpjWDg5SXYrZ1RWVDZaRDdVU01Gb05i?=
 =?utf-8?B?VFh4bDBMcDVrMTRNRE41TmM1cXI2elhBYlRIdG44eGlKZW4zR05ia2N3VG13?=
 =?utf-8?B?ems1QmcrTW9ZTjBxQVZvZDNsWmtTMmNSQ1ZzazEvemZHVzB5UzhTbnZnMTEx?=
 =?utf-8?B?SW5VZ2RtNXZVNDZhd2dybno3b1doOWEreFl3TmZBaThUcW9vOVE5ZjIyZ0d1?=
 =?utf-8?B?V1ZINEIvaFpGM01ROUhTbDB1NDJsb0JWQzU4L1hIa21LdWdvUDdQNWJnMXJJ?=
 =?utf-8?B?RmMzbURDeUxxZDYzRnJiTDVzekRudmZacHdtOW55MzkrdzBPNmtiQTRwWWJv?=
 =?utf-8?B?TTBKNDhuMVNaQTVhbzQ2QkxydnEzOFZqR3M2TGlhSW1RcEMxck5kVE81YVhr?=
 =?utf-8?B?dnUwNnF6Q1dLZThMN0xEVHVoNG5rM1h5bzNvWlpYSVVYVnhNWW51RlB1Nzkv?=
 =?utf-8?B?MVBReUJmTExJK1ZVYnhrVE9qSURTZW1GUDlxYkRIeXJvVk9oTUdDdkFESitX?=
 =?utf-8?B?RGF3OVN2cWdEVFN3UmxmWlFvRzV0a2RodFpFZ3I0OHhIZkdscjE1ZXFIZkR5?=
 =?utf-8?B?bkU5NWRNN1hrc1lGNDY5U1czd0dtekhJVnVWampaclpGciswblc2T01peDJJ?=
 =?utf-8?B?M3ViNW0yeGVTSWV3Mkc4YjloRk9iSXBZdUNTcnlqVHo0SXg0K0hzbmxGME5H?=
 =?utf-8?B?bXpnOGFQNFdCZCtKOFlGK1RzRVFxYnJFak4zYUZhUkwvRkZIVUQ5eENYMWtG?=
 =?utf-8?B?bk01Zm01WThpTUZkbTJzd1EzSUl4K011dW10MGJkSUlWd2dqM3VFS0I4Q2lj?=
 =?utf-8?B?ejlaTFV5NHdVWFhvNXVrZG5oTUpIKzZkVnd5YmtvYVo5RUlUbmhJTy9TbFN3?=
 =?utf-8?B?ZGdXQUNqT2dBZmF2WGJVUlZVSE16R01vT0RndHQwUzl5d2xZcUVPVWJaM1F2?=
 =?utf-8?B?MzQ4dllmR0pRYmFyTkd1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0NHSVNFdHY2NGdGRzNSam9pL0x3anRjWmQ2Wnhxa3NZUXErems2Qko2ZEZl?=
 =?utf-8?B?V3R2Y3B5RndOQm1NcDZEUWpzTmN6ZWVETCs2akZqNzBXaVdDRHU5cm9Ea0xV?=
 =?utf-8?B?Q1IwMFZ6RVZ5NnRKajNObkNuR1c0QmcwWlVacHV3SDVDdmtpUnlwdHlRaDhr?=
 =?utf-8?B?RG1jdGxQOWUvTWRDMDlCM1ZoUy8vZnhwck1XTUF2VUZtQ24rQXphK0FrbVg3?=
 =?utf-8?B?L05PM210cFhxQ2lTcHU3QmZMajVNbEMvYXNiOTl5SzFncUFweVV2bjFSaWNC?=
 =?utf-8?B?c3MyTjdkTEw4ZmFIbzZSb2dieE5iaXE3a1pFeXEvek9CZFJ2eGx2OHhQbEZu?=
 =?utf-8?B?Z3ZWK04yejd6aFNLaHpoMThlWVVOTkNCQU5DSk9tbG0zd2QwbENBZ1FMc2RH?=
 =?utf-8?B?N1FKVGd3WlNxb0lucGVmb0RzTmZNdi9YQ3BqMUhDLzRTU3U2aEJVNit2R3ZI?=
 =?utf-8?B?ZDFleEtOK3VNSWN6QW9TdTJ2ejVUbWtvenJVRTNhUjN5SEdDb2t6djh2UDFD?=
 =?utf-8?B?ZldZalR3ZGxmL09VTEFaRnNoUzZSVDBPQnFQYzIya2JsSHU4MVBKSHdwOWpF?=
 =?utf-8?B?SXBPR0RHUExmeXM3ajFyeEUwNHU3NXI2RjZrWWF6K1dHcUowV1hoNWpLRUZD?=
 =?utf-8?B?U2NDTGl6SGR4UmhxbHRZdHFiZGRFa0ZYVkViTlBZSFJMNjk0b3RsNHBybVgx?=
 =?utf-8?B?RXZwZFBMOWJGU3lxQWMvRzJyZ1NQWGpzUW9PUWh4R0Nzd1dYK1ZQUWZ0QlBN?=
 =?utf-8?B?K0lYd0lOeVJRSUM5NTFlVC80ZDIwVkdvYUsza0lRWnYxSFhGQWNQN2FPRnRZ?=
 =?utf-8?B?NmQ3RERKWVhNb21zZ1R5UnYycnNlL29nK2pmZEtrWTVXUy9kRk5zVDQ2bkI3?=
 =?utf-8?B?NFNKdlRBSTlJUStTUlUwcUhjZllaR0FtUjNBWWY1ckMyb1NDdlBvSmt4TFo3?=
 =?utf-8?B?SUo1MjZOMXFOSUpaNVUrZzE0ejROSmVLZ1VwZ0MxK1hGcFJha2FJbDQ2ZlVC?=
 =?utf-8?B?ZmlMajBCYlExbXBuMzE3cGdLaXRQNmt4UWFMNlltYUZUQWwzdXdJeDJUYmc0?=
 =?utf-8?B?MmxUaUh4dzRjc1VUZHhHSXJpalFPSkFCc1dLL3Zya0VQbWlieEpxMmZBZXRt?=
 =?utf-8?B?RmJTaDdKQXdORnZyTGNRNEZwaDdhVVhLZllIYkhjcVE4d2E1VnNOQzhWdlpK?=
 =?utf-8?B?YThJbXM0TktHOXBQV0ZYb2RFaGZRNkJpQjJKU1ZCY0pkMjhONTVYclNrSUMw?=
 =?utf-8?B?Y01hV3lURVNvRVREcnFGaFlGeVhadlpJSk5NdnlkYTZjUUROQzFNbzNHRUdv?=
 =?utf-8?B?aHdUVmJXZis4ZTA2T0twUGJEbFhxWXlnMHZYOEFIKzh2UWNpbmlqQWJJL0Iw?=
 =?utf-8?B?MnlSUzRxdjBnSktDek4wWjV2cVBsaVgxd0JaZFd0dkxBN1pZMis1bWZtdXda?=
 =?utf-8?B?VGh5ZUt6RHVMWGU0VTRvbzB5RDBBSGd1cmxxNGlkK3F0YnkxY2c1UFpkTDIz?=
 =?utf-8?B?NTRPSXN5U1Z3SGU0U25Dam05SjlPOVgxa3VRQVJqOFh3b2NtRGJaYjdienV1?=
 =?utf-8?B?TmEzWmdYR1BueUtZQ2JsNEJidGF3UXY5V2w5R1RRd1BmYWFlbXhyQTFmd3dm?=
 =?utf-8?B?ZFQ4SXB6aERNZk5vOVRrbG5GckhNeWJBeEVUV2Y5TUpudEJBRG4xQjhlTE53?=
 =?utf-8?B?S3B3VXJkQ0dCQTdsWUtuS0pzUStoNDdEa0JlY3pPWU5mR2c5VnFtdmVrZFZV?=
 =?utf-8?B?TTlZM3VmRmRMRVBuTWx5aEM3WkhrdFRSSE4ydmhqMUFnRk03M3hHUVNYV0I3?=
 =?utf-8?B?S05DRjNWMnVuTDk5ZlhtcEQyMnhWMXhLUXRUZjE4bnhGTHhLdWhnRHNJbE1M?=
 =?utf-8?B?WE82SUtlU0VFNjg5SGJXVTZYS0RKNTZXRmZEbTUyMVMzNGQrcXNlT0UrYUN0?=
 =?utf-8?B?MnROTzhXUGwwZG5KRDlwMm9nUzAvV0ZKQ2lldnFpZlQzNU5BM0RuWkxYQXJr?=
 =?utf-8?B?eTVoVVNrRFliclVTTExhakJuR3BRS1gzUlgrRnZoa2wyd1hncUdLT0t1QjJ0?=
 =?utf-8?B?cTk1K0ZtbUl3bkZMNUtGTW84dUdXUk5LV1MwQ3ZnbEtNbGNYUlhHYi8rMkVn?=
 =?utf-8?B?QW5oL2FvTUVMcUpWVTVnNXhFTHhjNXh5bVhIckg0QUl0a0wyOE9qZGVxdXRn?=
 =?utf-8?Q?g8ytULu1ZK0qVTSkMuwNwaM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca7104d-d889-4fc3-ddba-08dca4c11660
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:27:19.3951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlBkHsUBDD/4H753rZfPUYI6CxUBkn6megWWwrqrHEmzdlM2KMorcZtVCqQ4iXTbYBT5rcUazoUzYp9BjWIsN9EUunDlW3iUDNnjGPtun/guC1OQ7kAYVQfPhyMhL+C6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8480
Received-SPF: pass client-ip=2a01:111:f403:c112::;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=CY4PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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


Hi Peter/Richard,

On 09-07-2024 11:34 am, Ganapatrao Kulkarni wrote:
> Extend the 'mte' property for the virt machine to cover KVM as
> well. For KVM, we don't allocate tag memory, but instead enable
> the capability.
> 
> If MTE has been enabled, we need to disable migration, as we do not
> yet have a way to migrate the tags as well. Therefore, MTE will stay
> off with KVM unless requested explicitly.
> 
> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
> which broke TCG since it made the TCG -cpu max
> report the presence of MTE to the guest even if the board hadn't
> enabled MTE by wiring up the tag RAM. This meant that if the guest
> then tried to use MTE QEMU would segfault accessing the
> non-existent tag RAM.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
> 
> This patch is boot tested on ARM64 with KVM and on X86 with TCG for mte=on
> and default case(no mte).

Any comments on this patch?
Can this patch be merged in this merge cycle/window?

> 
>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>   target/arm/cpu.h     |  1 +
>   target/arm/kvm.c     | 40 ++++++++++++++++++++++++
>   target/arm/kvm_arm.h | 19 ++++++++++++
>   4 files changed, 102 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index b0c68d66a3..cc9db79ec3 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2206,7 +2206,7 @@ static void machvirt_init(MachineState *machine)
>           exit(1);
>       }
>   
> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
> +    if (vms->mte && hvf_enabled()) {
>           error_report("mach-virt: %s does not support providing "
>                        "MTE to the guest CPU",
>                        current_accel_name());
> @@ -2276,39 +2276,51 @@ static void machvirt_init(MachineState *machine)
>           }
>   
>           if (vms->mte) {
> -            /* Create the memory region only once, but link to all cpus. */
> -            if (!tag_sysmem) {
> -                /*
> -                 * The property exists only if MemTag is supported.
> -                 * If it is, we must allocate the ram to back that up.
> -                 */
> -                if (!object_property_find(cpuobj, "tag-memory")) {
> -                    error_report("MTE requested, but not supported "
> -                                 "by the guest CPU");
> -                    exit(1);
> +            if (tcg_enabled()) {
> +                /* Create the memory region only once, but link to all cpus. */
> +                if (!tag_sysmem) {
> +                    /*
> +                     * The property exists only if MemTag is supported.
> +                     * If it is, we must allocate the ram to back that up.
> +                     */
> +                    if (!object_property_find(cpuobj, "tag-memory")) {
> +                        error_report("MTE requested, but not supported "
> +                                     "by the guest CPU");
> +                        exit(1);
> +                    }
> +
> +                    tag_sysmem = g_new(MemoryRegion, 1);
> +                    memory_region_init(tag_sysmem, OBJECT(machine),
> +                                       "tag-memory", UINT64_MAX / 32);
> +
> +                    if (vms->secure) {
> +                        secure_tag_sysmem = g_new(MemoryRegion, 1);
> +                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
> +                                           "secure-tag-memory",
> +                                           UINT64_MAX / 32);
> +
> +                        /* As with ram, secure-tag takes precedence over tag. */
> +                        memory_region_add_subregion_overlap(secure_tag_sysmem,
> +                                                            0, tag_sysmem, -1);
> +                    }
>                   }
>   
> -                tag_sysmem = g_new(MemoryRegion, 1);
> -                memory_region_init(tag_sysmem, OBJECT(machine),
> -                                   "tag-memory", UINT64_MAX / 32);
> -
> +                object_property_set_link(cpuobj, "tag-memory",
> +                                         OBJECT(tag_sysmem), &error_abort);
>                   if (vms->secure) {
> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
> -                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
> -                                       "secure-tag-memory", UINT64_MAX / 32);
> -
> -                    /* As with ram, secure-tag takes precedence over tag.  */
> -                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
> -                                                        tag_sysmem, -1);
> +                    object_property_set_link(cpuobj, "secure-tag-memory",
> +                                             OBJECT(secure_tag_sysmem),
> +                                             &error_abort);
>                   }
> -            }
> -
> -            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
> -                                     &error_abort);
> -            if (vms->secure) {
> -                object_property_set_link(cpuobj, "secure-tag-memory",
> -                                         OBJECT(secure_tag_sysmem),
> -                                         &error_abort);
> +            } else if (kvm_enabled()) {
> +                if (!kvm_arm_mte_supported()) {
> +                    error_report("MTE requested, but not supported by KVM");
> +                    exit(1);
> +                }
> +                kvm_arm_enable_mte(cpuobj, &error_abort);
> +            } else {
> +                    error_report("MTE requested, but not supported ");
> +                    exit(1);
>               }
>           }
>   
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index d8eb986a04..661d35d8d8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1054,6 +1054,7 @@ struct ArchCPU {
>       bool prop_pauth_impdef;
>       bool prop_pauth_qarma3;
>       bool prop_lpa2;
> +    OnOffAuto prop_mte;
>   
>       /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
>       uint8_t dcz_blocksize;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 70f79eda33..0267a013e4 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -39,6 +39,7 @@
>   #include "hw/acpi/acpi.h"
>   #include "hw/acpi/ghes.h"
>   #include "target/arm/gtimer.h"
> +#include "migration/blocker.h"
>   
>   const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
> @@ -1793,6 +1794,11 @@ bool kvm_arm_sve_supported(void)
>       return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>   }
>   
> +bool kvm_arm_mte_supported(void)
> +{
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
> +}
> +
>   QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
>   
>   uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
> @@ -2422,3 +2428,37 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
>       }
>       return 0;
>   }
> +
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    static bool tried_to_enable;
> +    static bool succeeded_to_enable;
> +    Error *mte_migration_blocker = NULL;
> +    int ret;
> +
> +    if (!tried_to_enable) {
> +        /*
> +         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
> +         * sense), and we only want a single migration blocker as well.
> +         */
> +        tried_to_enable = true;
> +
> +        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
> +            return;
> +        }
> +
> +        /* TODO: Migration is not supported with MTE enabled */
> +        error_setg(&mte_migration_blocker,
> +                   "Live migration disabled due to MTE enabled");
> +        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
> +            error_free(mte_migration_blocker);
> +            return;
> +        }
> +        succeeded_to_enable = true;
> +    }
> +    if (succeeded_to_enable) {
> +        object_property_set_bool(cpuobj, "has_mte", true, NULL);
> +    }
> +}
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index cfaa0d9bc7..4d293618a7 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -188,6 +188,13 @@ bool kvm_arm_pmu_supported(void);
>    */
>   bool kvm_arm_sve_supported(void);
>   
> +/**
> + * kvm_arm_mte_supported:
> + *
> + * Returns: true if KVM can enable MTE, and false otherwise.
> + */
> +bool kvm_arm_mte_supported(void);
> +
>   /**
>    * kvm_arm_get_max_vm_ipa_size:
>    * @ms: Machine state handle
> @@ -214,6 +221,8 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
>   
>   int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>   
> +void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
> +
>   #else
>   
>   /*
> @@ -235,6 +244,11 @@ static inline bool kvm_arm_sve_supported(void)
>       return false;
>   }
>   
> +static inline bool kvm_arm_mte_supported(void)
> +{
> +    return false;
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> @@ -283,6 +297,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
>       g_assert_not_reached();
>   }
>   
> +static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
> +{
> +    g_assert_not_reached();
> +}
> +
>   #endif
>   
>   #endif

Thanks,
Ganapat

