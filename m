Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF346D11711
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQTMw-00076s-Br; Tue, 02 Dec 2025 11:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTMu-00072d-QK
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:36:48 -0500
Received: from mail-swedencentralazon11023122.outbound.protection.outlook.com
 ([52.101.83.122] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1vQTMt-0007YQ-0M
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:36:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNXwpYyFnt3NIZiD/65HhH0PFGsgDtK+qw2lJwr6qRSxHNJpddaK3T98wofL6n6HFAruNMrZgRu7OdHbWW+Nn6sUTuYtKK7IZrzBhZyxuMVeSFRs1wCUd70cbKbTXnBnq/tc/KWpEw21IeI2AawRMVuD/Fa6br4YKi9qfEU52Beyr0wel2+b3frkNqtGFdGb95mMapZQl9UjD1DFdJlnoLR4N5bYWv9CYtD1ZllkvNeW50KME/a8EFRd80CkzB8PtTsU9uW9Y+jOsQau7yKVX5FnBmQeLP1xYz2d/9Xa0yP3bJdVQP2VN/K+DLytWl2fBPVoMUvkD5tLL+RoxyUnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhCzGpu5+SLQvt1+dCdb6lv5Mb0WJvcUIgjxfwwKtQ8=;
 b=k5YnDYNlp+fWwqISwLO/nRQbnLBXgf4xvIpUbxXGISsnQ2yCT8TByqg3pIgyG5Wa1fqkGZJeNGWMbMRewgBO1lc3g7MT15Lbar2yQ+MmRSqrIqvRdBm0bpnK+Qo8YzAT75TpWcWs/In66fOneyqHeKJ07Yfd3yT2uXv6HsMONf3twexICmGbqPdQzLyUKLavwqmWVctMsHifXnOb9w3uv+VWASknKEFo0N5flfKEykQa0RsfbrdGc/uif9Q18+iCyfC7CludDtNvlHp1+/WAEn2djkZicDLZwswxWH5KTGmUV11LzUrufJ8Be4HZSq1ERHvPOYSQglTNzdx8aDSAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhCzGpu5+SLQvt1+dCdb6lv5Mb0WJvcUIgjxfwwKtQ8=;
 b=Qjn5+byteMM6LE78clJ7kAO2mXBkIBDjWhl5xo0biOvbCDjKRqE/SwLrBTHLBU6vp5cDU93lJY0pIAPd7yzIKx0WweDt581zq6GzUUtFOANZyXe8kXVsVYoeNcHlFw3GajkAwWpDZp0MKuv5+mzVCebJ9VirzZLzNs+342dplFeOgtTaxjjEOx5X8FhKbJ07yPdcBPjl+WGPRvni1lmV94LTr1D+Ro8H+4PGt3fpjzf9oEjfLEEe4HEkZEgNYmzu+A0IpLMfD5tj8BQeK8tQvYHz+asXy/FMglu0vATbd/D3fzZV4aTgyz8jKwf75fpxKPbHNDMFuaRKvb/Vy8LHGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GV1PR08MB11051.eurprd08.prod.outlook.com
 (2603:10a6:150:1ef::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 16:31:36 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%3]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 16:31:34 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peterx@redhat.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH v2 0/4] Fixes and improvements for scripts/qemugdb commands
Date: Tue,  2 Dec 2025 18:31:15 +0200
Message-ID: <20251202163119.363969-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GV1PR08MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 9629d66f-0322-4857-7380-08de31c041f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dejr8/YEknFffa6XmCTexxLgFcgzJyCRnaLFrUl9sZcb+K7QtmSUcNOkhjeu?=
 =?us-ascii?Q?m83x6U1q0N6TsCGsQ5Ybq5yByyWAP8kCeDrKPKbAqpvldvs200g0NMuJRGCT?=
 =?us-ascii?Q?IW6AQDiBU35RRzcQT2LdSFtUMQ8wtQEhvH0U2nexRY1a3nmtD3lRBm3SXolI?=
 =?us-ascii?Q?CPHotkC2xLYEeRI3KzC3iRGqUsqMx1ON0/dGGdndA/tkWF4/TI2U7EV9QpsD?=
 =?us-ascii?Q?mg5qKCljJzRcXoK0CmCet6i/7+67Fovy3h7rz4oYzdAbLn+hmVUGu29CXfc8?=
 =?us-ascii?Q?YZIlbagYZYnVuT2Xw0drbNX+FHmocSt7xRkGEd/2occn3prx7nmcnW1thOwZ?=
 =?us-ascii?Q?1RHvKZb2ExUWFtcZjXYCpe2dq0zlQR4h8Z1SvkCVFqvrIVxBjfZKPq2JCK+q?=
 =?us-ascii?Q?rNspU9azkoNQBvXByY6SiLYYVDYlFtlW0Oia0ePRvWysaCVpuMeg1GZ361le?=
 =?us-ascii?Q?6r7TWTt0KlgYpVHe/qg4qgEqba9KiDjseF5atZ4hlmBLnSzArvFVgQ82dyA5?=
 =?us-ascii?Q?FMO0y8yxcnVzxxUZQThXLK3fw/ztIcZ/1U/x0yiOnbM04kgi5LSdsfeqVw6t?=
 =?us-ascii?Q?CG9sjprXOTjQPsTyUlW7z2CqUqWCL0Dym/cgVOm4bCS0r5ObOw5QbMPyn1b1?=
 =?us-ascii?Q?BSI/0rVE40S9lXI0SvBDidJqa3SV13iQleT6C12kIbBtK0NKGTd75prlIhhY?=
 =?us-ascii?Q?EgYIu9MCJq2/E4aqrginS/cxWbjjtWzU/Z+xztWshk34Ba5u7JIarAtNS2UG?=
 =?us-ascii?Q?HJYwQoxFoJJ+nzCYnXJzuXjsth2YRhrj/T75unFFGxgoHRSsbp0wmV4+oiW6?=
 =?us-ascii?Q?XPuU0AmdGH//hY036qHlxyhNpZ2lClpqFqdetnzpEr9T3pALSa0LCf60/2/0?=
 =?us-ascii?Q?tzDFILvgbzhH9O/FrWjihN32/5WFTorRckmv7snkTCmNYbzr5kfmKDGz5Opz?=
 =?us-ascii?Q?w1o9dxoC0eZhKlUd81X2SLZ2ErdP95cIkl6xfY5gYlpjUXWzahGEHU3efNWh?=
 =?us-ascii?Q?ZtX8CmfYj2jAwCrnv+iY19IteCSYJfhVLPP1YkGyT41pQCPYuHQhs7EBTMvc?=
 =?us-ascii?Q?fhgTG+ZFj9BKrb4StL1WomJ0FtNSE6Q4ErUascNbE3Wtm2vOWwcrlJ8qwIj4?=
 =?us-ascii?Q?doK1irBhFCF2c5zRZUjhCBGMzmjTNiXDWeLzKGVcFmSy13GQkXmoSARma/g8?=
 =?us-ascii?Q?785jnu5Z86+3yFjv1tFE6QrGtzhphv8jhj100pjqVRtX0SKpvcZ943GMsEx5?=
 =?us-ascii?Q?J2JZs1CldFkp0XrcqfmV1AaG/fBlGx4bkb24yvxjIvQEfprMtlHf5uAyCqOI?=
 =?us-ascii?Q?C7eVVBAhs6ab+peX7fW4UyxT+sWBcLEYKO4d16kBXaog6yGkqVmybjhTdfDg?=
 =?us-ascii?Q?u/0iVh6HzZb+reJ2oIRaTwFMtcEHg7WBryd0i3+nBzyBFfhcAMRYQV3QW9Rr?=
 =?us-ascii?Q?2/BBnxaV+OAbk/bMz6nCi1PDG+fXYKQChu+m0rIr2HhbXyO5Es7NDumNO+Cp?=
 =?us-ascii?Q?moDZiG6GP4b2c8u7fAAHjzNrML8aIt8DM8un?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3O6azXFk8tzVsMhv7HuXXCJk39tNYicQsqPRYLNoWjtzpY8jJ3pPHNFpCL+0?=
 =?us-ascii?Q?6KH//U26Gso8t8G90EkGcvETM2A05QOv4iXrcI/8DZw3wXVAnAV9jsk35evK?=
 =?us-ascii?Q?DQJGAz0eUkc/aXKmugUX9mndM/VwB4SJ6iTf+e1So0BHaVTzEOMrxBHccPJ3?=
 =?us-ascii?Q?qjhdMjydtNM6yFaxQLN7U0TDqBnH/+zhI7WVGOTBUoKnezeXCYfDtkhOLEzY?=
 =?us-ascii?Q?LSkBnIxK1AyBcz2qtlyT9JhTs+RV6fgLzPOe+PJanDJW8/ATC36CuoWd0uC8?=
 =?us-ascii?Q?YUT3yUZ1B3rNzZ59Rn38tUCp4M5sm01tAuAj6PUSGFrqRzsgBxE/LpNjvl7M?=
 =?us-ascii?Q?16Eh+9nmFZrMtyBagKVTBcMmD2bjuYFPrCknMhrSAFx9RdD1PsxtySj/A8MG?=
 =?us-ascii?Q?5Ci8FfxkENk8HpStWRKBpuuA2cJ9/027kgbmmdO2/LOh1o9QSwts6qnstWPA?=
 =?us-ascii?Q?coh6ySaWMvZizLWDWnAo8+RtVsx8qBQGXnSzgKVQUAkab8Oie7a8ILwgmGoE?=
 =?us-ascii?Q?SJMbsHwAeYzL1PfsNc7aZRoriBuH3fBSC0XgYDP8BOcCg75qj5QFtAmI83pL?=
 =?us-ascii?Q?DtniavUQK4PCfR0UdPjWD14S4KcBE/WM9FhqT9BYD6z5EMr6RgkxBQTGRPx1?=
 =?us-ascii?Q?lxUUn4Q7+CvYI/EPRqhvdsuhHbIdp7QvSRLpnhXtGOsE507Hl+wZhI+S/lYn?=
 =?us-ascii?Q?q1N4k8busUSdBlxg42XwGEaB9FNa4FcG64+1DGltAVQcgKns0PKQuc9mchTJ?=
 =?us-ascii?Q?ejulY60M1zcOkC4hJBKdkcEJY51B6XiDa4LQD7hwFur61HEJ6uoCyxGDipN0?=
 =?us-ascii?Q?bSVw0ocb9x40jz91gCBmVjjIcwFiTGDnoXNfRMQbnuBVrwsPfBSwBEXx1MLd?=
 =?us-ascii?Q?S+9928T/zgLhspfUzMW3g540xM7/a9ZqNgfXhIdGB+uXoffzlZgnpu+KLVlL?=
 =?us-ascii?Q?tq2UAy7KJF6Cg1xg7P3p4L9Y2y6734UmOulB68DbcSA36nFWUYCkyye8TnQW?=
 =?us-ascii?Q?LwvAyNatm93frWCz6J08+mj90sC/g+/1T50Hhit6fsWMe4rwKfNTnT6metBG?=
 =?us-ascii?Q?JMCHYF9zfislw3KU5aiAoEL3qtNCkM4Unbcu94oEAlRlbf7iNSYQ4q/INWyn?=
 =?us-ascii?Q?ujw5hos8hYE95JnMYRXmTGgwj3jmOo6DpKQcB37yezZdK8QeHekDRQJyidfn?=
 =?us-ascii?Q?gwkX7rQgKxZ1t6hqihlIBgH6ceRUb+qeaiCdcP7x2DcL4f+7/gC1Tm4S32Ua?=
 =?us-ascii?Q?hUbBuLEVKBbCF8NIVx3ADeqkm041i7qCzfWvQZ8ilZo/D6rZxGhpKXDGRKUM?=
 =?us-ascii?Q?nhWEWLfG9tEPs6aQgWRCSsQnGE1R3zTLtynUHtHBR8wYtWVMfdJjrOfb58Ok?=
 =?us-ascii?Q?p4nraMiWcdIeJTf1Nf5Uh7Auf0vz9L7IyWJijD7dLsew5yWr7vf/wcDkB/tv?=
 =?us-ascii?Q?eYt/KixvMuzsXt7SRRTAz/van9IKMv12c0uslTlhaRdoSNxH3ypJQTk+WkWD?=
 =?us-ascii?Q?nmnNg62I2LDT1UMKQptPGcA+TtPGr+c4biVMeVB0Tz8asFgMDc4k9XMzArMQ?=
 =?us-ascii?Q?fztRV86j2ApHPCOvr5ybAb4MUFoMXkKp+z73C1Nze+XHyEj2JjpcYIBrk8+W?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9629d66f-0322-4857-7380-08de31c041f9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 16:31:34.7437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MB5oyYL/aWQ96UmLSmvgEP7STvXSwgF76ahGU+cQM5myX6ZuVqy4oIn/NSST84MM5wsyZr82u/iAZkgLTaezokAml0hiYD6TYABThLrN504=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB11051
Received-SPF: pass client-ip=52.101.83.122;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

v1 -> v2:

  * Use pty module instead of script(1) for producing colored output;
  * Patch coredump file in place instead of full copy;
  * Save and restore original pt_regs values in a separate file;
  * Wrap this logic in a separate class.

v1: https://lore.kernel.org/qemu-devel/20251125142105.448289-1-andrey.drobyshev@virtuozzo.com/

Andrey Drobyshev (4):
  scripts/qemugdb: mtree: Fix OverflowError in mtree with 128-bit
    addresses
  scripts/qemugdb: timers: Fix KeyError in 'qemu timers' command
  scripts/qemugdb: timers: Improve 'qemu timers' command readability
  scripts/qemugdb: coroutine: Add option for obtaining detailed trace in
    coredump

 scripts/qemugdb/coroutine.py | 243 +++++++++++++++++++++++++++++++++--
 scripts/qemugdb/mtree.py     |   2 +-
 scripts/qemugdb/timers.py    |  54 ++++++--
 3 files changed, 280 insertions(+), 19 deletions(-)

-- 
2.43.5


