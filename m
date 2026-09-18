Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E4DC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Z0r-00084h-4m; Fri, 18 Sep 2026 09:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Z0p-00084J-Oj
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:52:23 -0400
Received: from mail-northeuropeazon11020095.outbound.protection.outlook.com
 ([52.101.84.95] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7Z0n-0003oM-Tg
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:52:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stwEEqx6/MYlQQJHdbB0WFSrds2RjatyflOk6IS5YJgn7HI+4Y+1KrNsbt9cQla/i5dfudY176pLl6riredfb/Y3pyHMtI78LMFoy3XLiXqsvVJyDYU+X7eAxIB6suAIdyzbUqMCQDJKiyKrubqAC0/8QQl8LbU2CAvpKb1jdCLV77/78/Li8AIVQM8zdTBrqHuCrKRi3kHxq8JcYlR6UGNGTQK2NFcLNxiTOzS8ybvDig0bGeqvRgAyFb2iRqC6odjB95TjHLIy1la9P100y62SRWfareZKSBzCdsspde9QsyVxgT6x/G2nO1sozXsCgHS6yiz0JCZa/YiFDNvfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gvf8yrmFFgtZdeMRE9xUuhf+b22ci/Fx/9wuqc3hK0A=;
 b=LPajsLfruRdONdVyw2KU0GUmeRAdtUQTUQ3/TrsrHWoiIb376QRkAtwHtVWq8PCxznmkBpIxnMzZ8Rc4B5YAKkerfkZBFc7N6wMI7KKSo4eSmDoGfaAjJTmKCz+WDgeVqe2QoTPU3H4VCerUUz/9vR72qSoPrmSzoCK46PtfcJaltL0sVGMRbdHCfBwfXr0xyIdX6EZqoHnVbijo5p/I+lsi+BOl8ZE0p8azncY5UZMx/wB0dKL+QpCyl+iExdE9Hy3PNX6p2JKrc9LF6WwaV2QRrGD7ZBQzIhvcMIr+k9oP9Kn428gW/1NPZaXa8xIaTYwtDYP5nIQCDTH/Qsovug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvf8yrmFFgtZdeMRE9xUuhf+b22ci/Fx/9wuqc3hK0A=;
 b=Vvy2fbmezRZx1aZJGolMUsoD42dDKfLnxZMZPKtxEzcw5kxqTLlP4DOl/eXoeX+iDGrcb07xd2m2tSES3cHWjkSALwBwHB2AFX+PPCdDNG457H7AVztMHtl53Q8tnejlWH38HP0zlEcf3poA4IKjrCDS5kaoYm9mvliy9x8QFDmKBdN+qg/GMZ8TEGJGpnUllcpB44P8xFoCinPs9ITzq1EnmxFEbt365JVRxkVxyuvRusy1IIyRuBEbrkaqyJucBqeT6LmIhj/4FKtCGOjqHc8+8xP6jKZNFDTmtsA8gAneHXZ9OUamf3q1BMl9pfN0+sqbY96DK5ZCx9ycqrQv0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMBPR08MB825636.eurprd08.prod.outlook.com
 (2603:10a6:20b:7b1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:16 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:15 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v7 00/16] migration/cpr: support vhost-vsock devices
Date: Fri, 18 Sep 2026 16:46:51 +0300
Message-Id: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMtArWoC/23NTQ7CIBQE4KsY1mKAFkpdeQ/jouXHorE0QIm26
 d2F6sKYJm8zybxvZuCVM8qD424GTkXjje1TqPY7ILqmvypoZMqAIMJQjTgcBxi9FXcYO+sDjBS
 KiuO2qDUWuAHpb3BKm+dqni+f7Mf2pkTIUG50xgfrXutopLn39XG54adDUOKqJAXltS75KRoXR
 jtN9iDsA+SNyH4VuqWwpJSywC2RgjVa/ivLsrwB/TQnWg4BAAA=
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMBPR08MB825636:EE_
X-MS-Office365-Filtering-Correlation-Id: 6678f618-35cc-4cfe-0548-08df158b5979
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|10067099003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: asW/n/28jjWzsLaH9NrYkw7Qn+l/XO7D638MIPDsrt6je8GjrPnJDuSHriBMGg3M/n/lPQeZh2Myc+88vbDF/qoz8VeFeuSU5SkcFYo73ScKlJX/b3hEN2lSabtnaO+YaZqO9Qze9jstpXkFjq5I/AacnmAmRtNPXJKjns4vW0jlZWi1FycsKP3aNre7eKgjsF5qnU7YEuAavK5+keSQy/E4q0Nd4liazCEBhpNcKg4uRF6ONpd56t6KBCJLdZ0IfwVvhxNw/uclRkxfUkZdSFcHuv8tuYi5MH6oCtW7QNk/LDsy4SYBzb0c87xklMhheMgMghTZctdp78sWceOx+/Z6ScfG1ctJOh8HO4z7VIdw246o3YceTiJXOguPBbiXXpCNNbqF9IOZKi6YnvJBtFVrBcQUzRPfjEQshnx+9MxMDozj8WwnWhvZrrc8QM0aUNP+fDeiiu/bKzYgQOCcxOI52ZqNv8ZcPsppzkC8pgnPps/+roc1Q+0iSQx3iLhtJC3hrnZueij8dva5nBbPFBJx0h+QHfEXfPQ042pYQRLWNI1cExHFc/tTzXTlFKddcQ3/0aBqm8Nftcninxlj7/XcGmkcAbzq7FO/HGFTkMN16pnW4J8Mdn0/GVqLUo6jVjnWAepBn5AFtyeE2gbAUfb6i6ERxLn+GJl6X+vsUbO5Xth8Cirtmn0U+FEKzgJefRGTD54psmRqVppo7JTsPLe/viQGc9OLgTJLEafLCRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elpRbUhPUUFHcUxqT3Z4dWhKYjJBU0xLc3MyWVZURkpxR3dYVHMxYmJrTDdp?=
 =?utf-8?B?a0dmcG0reU94aCtLMzFwVXFGK0RnZEVmdTNJNGc2YVRGL2dmWXVVWVA5aE1Q?=
 =?utf-8?B?eFlETkhKSXMweStNTWpFWE0yMUdNdmpydFNTR3c0cXR1VnpkRVZoRUhJTFAr?=
 =?utf-8?B?SFdoOVYyYThwVFFaekM3SjlhcGRjZk1KYkwwRnhjZDhNaFFDOU5BaEh4V0hB?=
 =?utf-8?B?K3VpcVpINnJ5Sk9BTXNWb1lkd2NtWGgreU4wZE0waXdaOC9qNmpyUHlsazNN?=
 =?utf-8?B?bUlyZnBoWDJ4dUNIQ0Y3elV5UkxlN24xS3ZsclZXNTNFWDFJdWl2Z1pZS3VD?=
 =?utf-8?B?RkVGQ1lGcWJ2VzFKMFJzQVN0NUhvdStSdk5IQ1hLWmFjbUhncWZaWUJlK1M2?=
 =?utf-8?B?N2ZMcmdRRm9hWmJjNHlXMjFHaHA2N2JqNGxUVWpGckxsa0dDVkxzSis3bGRW?=
 =?utf-8?B?SjVKam5RNGxHTEg4Wi95YzNCbHFXVVRNdG9qdE1jTnFRYktJdjRUaTcxclN6?=
 =?utf-8?B?YUhOV2ZwK094eWJlcnRmMkJHbHV5WkFWZWd6T09QWUhZbXVnbTJzRU1rQWls?=
 =?utf-8?B?NzAreko1dzhWUU9qOWdCK0RKZWFIbmFWNXJQeUUzNXpzQ1JHVnJtaGhDem9L?=
 =?utf-8?B?K0wwcWhaYlJiN21ZbmlKNTYwajhSOTZUQUtpelVFNFBDb2hmNXl4WUY2RTZT?=
 =?utf-8?B?dkd4UUczMDlwQVhwTDhMbDV4MWpHbXdLTWF5S1JBYjNpNEpmZUZvaXBXNG5p?=
 =?utf-8?B?aDB0cXNPdHluaEw4WjVaMFFSRlM3MU4rVy9pNkZTM1UzMzZkem02MTN6em8z?=
 =?utf-8?B?dlQ3bk52NDBvOFRndC90ZHhFa24wbjJOeEFTOVJtZjBNZjdFVWNuVHNuM1VL?=
 =?utf-8?B?RHFuWTE4NHlzTU9tOVJ2ODM2YlkxcXlvS08xcm5EbXRzT1V1OXYveVl1UDFu?=
 =?utf-8?B?ZjJXa3p2aFRlZXhTa1NnTG5jVTBxVjZ6My9PVFJhaStyQU9veDVFRXl0cUFP?=
 =?utf-8?B?V2ZvcVVtUU9MM1pwMHB2NDdLNXRsV2pRZlpYWmY2U2tZNUVzcGZ0WmFoWElV?=
 =?utf-8?B?WFhXYUZIWXdVZmx5cUdEaEVTc2l4M1VIeEJtR2NVczFwSVZXWjY2ODFpMnlo?=
 =?utf-8?B?SGxZS3drZlNZM2FNNHEwT1pWMXp3cUM2a0p0YUZYSGluNW04dGpyMDk3bWxZ?=
 =?utf-8?B?cFBYZ0pxWWQvYUFxcjZTSW9BNWdTY1FOMzBhc1JYVE5rcEp4MWFCdDJHOEZz?=
 =?utf-8?B?blc3S2pFMk1tQ21MQTF3QS8wRmdmaVlBUXNCS2M5aDVLaXQwRWhzNjRRd09n?=
 =?utf-8?B?RkVEUzdPcnRzVzc3UnR4NFFMMUFNbHFyYkF3dTlGMWlGcFhwYit1UENuU3Bo?=
 =?utf-8?B?K1Mrelk1SnlKeHRTRFdqazRqdm1PT05yZERpdHo2N1FtbnJVN1RjM3lFaE9R?=
 =?utf-8?B?ZkVpUGdBSjJZZ3hYMEc0cWg5RXlrM1QrMzRZcUZDSkZST0wrVW44RWNWZStY?=
 =?utf-8?B?enNWYUpwSGZJZTJiWmljQjZWMERieDdGRHI4RlRyOE9FK0VrQ3VQWHlJRnE2?=
 =?utf-8?B?SHNhOUNtZEdYWGd5N3pUS1ZMQjdKWmMwUXNUaFE3TWFQa2pyZ0pmVzdKTUFz?=
 =?utf-8?B?U3JqWDZ1NVVmWm9ETU93UWJiTnNuNnBSdkJMNk81ZTl1bzZ2dHhwdGFPNlNN?=
 =?utf-8?B?RHE1R1BYc2VvZEE0UUVBbU5jcUJNbzkvUWlDaXNvS09xY29FcE9QQy90WEJW?=
 =?utf-8?B?UG1ldVNGdGhKY2x0bUFHUzVPd24yMGtPbzFOWE51VnFqTUdORDgvaWo2c096?=
 =?utf-8?B?cVlDSmtCUTdNTkFyWDVSbEpuWHdDTExibUYwK3lsSXZBRVY1aVdLOHQyUW9R?=
 =?utf-8?B?bllJblo1RHh3blB6ek56ZjdkaTlndVlTbDVFTUlpOUs3ODlUUTVSQmhBaDg3?=
 =?utf-8?B?Q1g1L29CbWk0S0Z6Zm8vbURXcDhNRHJ6QVRVUVk3QVRWcXVncE83NWdDUVJD?=
 =?utf-8?B?Q2Y3MjRhdWZyR2FiZ3BLL3YvZU5qWVprVEIzcSt2UFZXa2hoUmt5Z2Q5Rjg0?=
 =?utf-8?B?Y01PcE5GbUE1cDBEUVNCSjhlMWw0Z0d4ZkFtU1U0UG15ZGhncjk0ZzZoYzZ1?=
 =?utf-8?B?QkNYVjRIT0t5SFdlVUx1dnF5UVREMjBjTnAvY29qVjV2RklYWXRtdTY5N3hN?=
 =?utf-8?B?a0JmUS9BS2VQTXFIbEkyQlF2akFWQU41SzdkczhweTY4Z0UvKzhQelBNczlI?=
 =?utf-8?B?MjJMNk1CY0M4dXFZVDFwMGViNHBLcGdhRHhCb2s1eFlpSkVScmQxRXp5WUd0?=
 =?utf-8?B?dXNlZE9DWHBnR3NaaGU0VHdQZkgrV2ZWU3ZuY3cvZFNBaWdRNCtGZ2hJTGpn?=
 =?utf-8?Q?awH2T0XEj9THRLV8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6678f618-35cc-4cfe-0548-08df158b5979
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:15.8551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DMW8faGAwzDceDa10KkYvAkOqvK+2XI+5XhYiCut4VTJ4JPXnEr1/av+1h1dZWmcV1W6a3nbdaySGIUvFZvOfB7HLAOyqLD1+rXCggGjEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB825636
Received-SPF: pass client-ip=52.101.84.95;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

v6 -> v7:

  * Patch 9:
    - cleanup closed vhostfd here rather than in #14;
    - add !cpr_incoming guard before saving CPR fd;

  * Patch 14:
    - remove closed vhostfd cleanup (moved to #9);
    - lift !cpr_incoming guard before saving CPR fd - not needed with an
      early return;

  * Patches 15-16 (NEW):
    - add qtests running cpr-transfer/cpr-exec with a vhost-vsock-pci
      device attached;
    - add functional test with a live guest doing host<->guest vsock
      transfers across a series of CPR migrations.

v6: https://lore.kernel.org/qemu-devel/20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (16):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      tests/qtest/migration: add test for snapshot rejection in CPR modes
      vhost-vsock: block CPR migration modes
      vhost: add vhost_reset_owner op
      vhost-vsock: don't reset connections during CPR
      vhost-vsock: fix FD leak in realize()
      vhost-vsock: preserve vhost FD during CPR
      vhost: factor out vhost_dev_init_backend()
      vhost: make vhost_dev_cleanup() safe on a partially initialized device
      vhost: add vhost_dev_set_owner() / vhost_dev_reset_owner() helpers
      vhost: add vhost_dev_is_initialized() helper
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |  17 +-
 hw/vfio/cpr-legacy.c                            |  10 +-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 +++++++++++++++++--
 hw/virtio/vhost.c                               |  57 ++++--
 include/hw/vfio/vfio-cpr.h                      |   6 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  61 ++++++
 include/migration/cpr.h                         |   2 +-
 migration/cpr.c                                 |  55 ++++--
 migration/options.c                             |   7 +
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 245 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 129 ++++++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 ++++++++++
 23 files changed, 846 insertions(+), 76 deletions(-)
---
base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


