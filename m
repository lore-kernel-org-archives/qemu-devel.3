Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D759C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQs9-00041T-0H; Mon, 12 Aug 2024 04:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sdQs4-0003eS-8g
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:57:44 -0400
Received: from mail-vi1eur03on20713.outbound.protection.outlook.com
 ([2a01:111:f403:260c::713]
 helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sdQs2-0007iH-Lz
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:57:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iC/YXE+Hik7luJczzJf93QjjzNEDGPJE7maRWzjWH/3QLdXzM91jrgdM77wn7ZxJOQ75dgMArtPJcLwa3AmnZdj3hVDfdo3teINTGESAlTupW2FWz3oxgQQezB6FhIEsKYz3AcseZFeC7k2cJbh9Lv0QE43t2fbUcWmrUPMY9Da/XboUC6fGbYLnCbaZQJvYA1rEQxANVlSn2u4cjO5q4NRqxY6yxahVfOB91Wvtsg/baXHiFm3pIdsA4LOkQ3vvH/P+7Tul4FHXpG8ltQS57ZljVZdsZ3BmO5UobpTJG4sGL0ItgpE24T32epUVv+UN1/LEVXQgc8Brd6nAttXqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiLYr6cKt7luk7O1NOvwQRLUNRsuZS5iXUa0Hy/Bh9g=;
 b=MeQaJf9zJrHYNmrSjMUDZS2rFEnIL/EfXv+pdcS7S4ALT3SwvEdRYGR24C2xaqnoiOvi/teeI1jDdY9uJhmUtAe0cqn2mYXCO+CnsA4Fdmsxwdan40Ozqo0SlfSEFyqR3mFEXWb1HFml4kKtvYwv1IRKGRUFlre3v0TLp1Dhs3d5MErkHOE70p4NgvxpaNPAb9DxGzeuI3P5NZ6y4ZbmHxvkGSzQhI9KnxS6JPBSXKYyjIM7unDklT+zx/8OCzuZ/yN1gw6T+ijxHRazvcB+YFZ8rECHdj7ULNDh8No9agmpqaozPe+8AL918G/QpGiA0j/N6hznZelx/rgJVRUU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiLYr6cKt7luk7O1NOvwQRLUNRsuZS5iXUa0Hy/Bh9g=;
 b=eRWZwsALpHw89b9HzojLQPsl3dXo28Oi20kSgFcobpWbiAEj+8IEsc4KIb5lUSRjSeEJzqvc4mEAhZZvXOsJMliM5WKxSI33TeYCASrBelDhG/R85XEZ1pEEVdxfsDxV6iLyZYIgOxdUf5LF0eZFjhlm2Xqm9bB3NnWXuh2Xy1m0TTB6Y76MoE1i4/apXmMy1FRMjpoBNQn1U5gM6l225amo5Jo0qn7DqUOBNylb9d04La7aefJTvoelhOC3RhBCXdqesNxPAO+D+lYfZVnhBLG8NscAo0Q37JW0VSYCYavKVpA954uar1hXSMkuZTcFlPd04tNPEEmv73La2wwtlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB5PR08MB10253.eurprd08.prod.outlook.com
 (2603:10a6:10:4a9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 08:57:33 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%5]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 08:57:33 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
Subject: [PATCH v2 0/1] module: Move local_err initialization to the loop in
 module_load_qom_all()
Date: Mon, 12 Aug 2024 10:57:24 +0200
Message-ID: <20240812085725.1093540-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::6) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB5PR08MB10253:EE_
X-MS-Office365-Filtering-Correlation-Id: 66feff55-348e-413d-3328-08dcbaaccdcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UTvpTVmYE17PUv65Qe7tFSd2ZWqFO0mh142mk6FSmZFOTXF7vueUmgi+ciDr?=
 =?us-ascii?Q?oFcwTqEmPxUe3dWtikgXxiB/+Ge85Toi5H6BGnI1EPY9WP8ldgyquqxrva+J?=
 =?us-ascii?Q?ywq3rkNz5Lsu3SASe7/fDVFNDniwYPE8PH1gELkYHqqO8YgAOjME6uoKZkKE?=
 =?us-ascii?Q?PL02+GjMJArEdCJ0CzmLThyQDCqrZnMCTDDs88KDd1tg6TOKnR2KAjzo09Oe?=
 =?us-ascii?Q?ynov/l5rxo/NkEpvzWfuTH+F2meDOFGawMKGexq5lhxldEmAH8tZxjbLu2Sb?=
 =?us-ascii?Q?P16nAn6eHhYCT7GBR/GyAg2l/bGfiDwTcGwNCYxIq3ikJZP/F2r8VU1Mcwne?=
 =?us-ascii?Q?93usbZibkC2qF3Sz5ILJtnhTccBuzUutgdU7/JziD7wuENi5SmahGtyGI2lN?=
 =?us-ascii?Q?wiF+HRx7SSBGK2Ox24DGtfPwa4Z6Ufv4Tx+0dvXyYea/Au91vCRxHgifgME0?=
 =?us-ascii?Q?EcgpeeWHGQNTv+KLAxx7E1Hu0CZ/9qojdooJ/Gjj0ffr7Vl1hUI3xsYxjVoD?=
 =?us-ascii?Q?caJ7ZwKEy+p6dBsgizEtEMI+FxoBI7uLl6pmkBzkg3g7YKOC8tQTHF9pXna4?=
 =?us-ascii?Q?RO0TZGoFE85HsZ9oJWizOF7cGI0QzpqKQrmy5Jd1JgayBK/MNIq5twnJdtap?=
 =?us-ascii?Q?ATerOqFL8KF1BAUGMG4viuKKG726B1idaIjjPljiD5aHNZQ024crdv+3IlRP?=
 =?us-ascii?Q?EHhILKjXsfpyo8EgDzk+Ogv81/BN1BDy9iVpuG5j1RF++/t21xcolQfVp0o5?=
 =?us-ascii?Q?48cWctyD3vVRTdJYpQ7nfTijU9EJBVw7U07KDVnJqx3OC9pnhSzHzzsak9zT?=
 =?us-ascii?Q?tdH/O0diy3112sVIFciOAo/RUZTbd2iN6KdZZXDT9BCo83FxE5uOHu+Do26V?=
 =?us-ascii?Q?+kkyVinVOEiRNdJ73YSNWuFxJjW5HcY1Y0VOViU/5RMDUtt2Qcrgex91fODu?=
 =?us-ascii?Q?0jzvVQGmyIhunvuauZnGiJkxOwFpN1N1lraWjrsI4GBZYwnGNHQcCSjGJ5rs?=
 =?us-ascii?Q?OYQ4WhF5x8/CIz6rF17Nw//3Eqm5a36AS0LlIfUxS9gzeCmPB4q0FrQiGtUb?=
 =?us-ascii?Q?uxtaHtDUwjiqQ6urc17ZHQMA7StqYqZuDVF3xreImszv3SlqyqEOTO64EZO8?=
 =?us-ascii?Q?vbxIDRySCAaE485l11qe2AtcsBFwACVAiG5erBVVPfFlAgZZLQFL0K5B/ORi?=
 =?us-ascii?Q?uDnPk6DVndOQIbrMJQu6gI/BbUfv3sTN/J78Nr/0pPQ/3fS76O6bcA2FKY8C?=
 =?us-ascii?Q?o1+XfBA6GBfIlRtKYNwreHlYCRhaSsz/wDHhM5ro6xBIsGM3sRdc194M+Nfq?=
 =?us-ascii?Q?IUwDgigBjaeaxPQr7+FrWpaREhpawjPH6044M+j2GjN0inT7e4ucyKb5Y1bU?=
 =?us-ascii?Q?JfdrZLVru+tvofBglcm35Yqb/Ff+S10SkLXwtzIVDI89WlVfGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxPmZvAlPwQUP+WEms3hAUh7ivQ3i184dOxtkWRrhtpy84blHAxHfKR7DsK/?=
 =?us-ascii?Q?Yz3jiIkKJWrXD4wYC7OCqxyoV1x6aZUKwcac+Ybtf5xSkoF3U0pSxS+aQCQn?=
 =?us-ascii?Q?4wHbT9LrFZIPljMLGj9ZQymP8UPEVg+vkEyRdD5Mv5V+qgeKsgq+ims/mLXx?=
 =?us-ascii?Q?he6iUqKohlIk8GitGbWCHQi8tjRaso2lWC1HK64DdYAzGA0RjPj2HxeIGWZR?=
 =?us-ascii?Q?vGPhzlRGmO353BVhWoXNQ0EML0jkM7yPM3HhHFJUTdpvZOCkoWp9Fm6WDKI5?=
 =?us-ascii?Q?PI1YcQiNobRhVSAFNALrTE8mqlFyhefriHx+AAzsrC1RAjlvG31CKRGCBPRe?=
 =?us-ascii?Q?M04DAp5aKwPDadlLBL3YWOzsTUUJ2O/WK5cAbn0D/ZLQvqBBY49usZKk+52o?=
 =?us-ascii?Q?sf38l/SLVB1jyT8Rx8m8wO9Lq7KnihpX6gZtN6FJtBnnm3N3Ii4UAw129rW1?=
 =?us-ascii?Q?6b4vkn50kUb76fO1CiR170pnaSkH9gyteKYRt+0yPkOMphaI3fbMTkL2etM0?=
 =?us-ascii?Q?2h0lzpIUO2AzE0jt0nb1oRErrq9zJLRoOeTnzj+7TtquMZKv+XkL7ncKpSoH?=
 =?us-ascii?Q?JJVI0Ntp4q8SnTOQ839YSfn4DU/BSbJPRL6Rs6pArkDj1hKRzGRZblOoYo9l?=
 =?us-ascii?Q?PrRqRS0GRwfTIfxSty32P7GBOZvziuXrZUNizipdC1Kp/6J2HKKBRT+J+5WQ?=
 =?us-ascii?Q?eoRsR8Fcs3cr5/T1xy1/Keb+mxYBYn45YNezQKMCfQ33aeg1v9sCj/dzBYDP?=
 =?us-ascii?Q?bLYzS2pwYz09gkXTCPOL1OkhAPLiZvkXq78Q6ONGys3WCdQ7vuSvrlhXtN+J?=
 =?us-ascii?Q?X5IQX2+SOXQDBwQcM2s8WN5iRCXT0cMDDN9Z9yZ9KOhvDMHze2JctXynwVd2?=
 =?us-ascii?Q?iNyNVR0S0aA33Kye0uGVfQ4y4KEAOEJQdwm7gKLw0a1reKob+LMpnQBqtfRZ?=
 =?us-ascii?Q?ZmlmeZp6w6p5ro/RZ6AnnLTTPFEsSOIHlDGUN/kXS2Au8fiHTYVmHVlO0+Lf?=
 =?us-ascii?Q?XhIJkkAXDp7Y+Y2IhES/cno8OmplpZLa2OBIWgJ7VC22XdhQaq9PUdee1H7H?=
 =?us-ascii?Q?sHpBlQZYTQSg9jDyDOU0VdM5I8kSSwfTmzGixLjpGfv4KsvywXGlIaMmFnNe?=
 =?us-ascii?Q?7wzqydbKUlgUJeTHgq65FoGnn3yeGLYnayMZ4PeMg7dfbYOA1v0Yr9Be8kAk?=
 =?us-ascii?Q?O0umkOnhWmwK5zNbU7I9WacDNiBxCNMX0HoybXo4rxZW289pSyQB7Pfp2zhw?=
 =?us-ascii?Q?L7rQebUrn6EMsKmEhcBLUmFXXjjo0OT1Z8g9keqZN5aIuO0N58BmWuVyEn7x?=
 =?us-ascii?Q?dvo74SJ0Fv3H1PvLXf/7N73w0gHTr9lXJ2SaEv2z/bPO5EVef9LkI6nNoTNo?=
 =?us-ascii?Q?2roGmWGNOmn30SnG5mc1Os9RblAa8OmB5m8obVz01qs4g1xZ5R9qiC0mdK1Q?=
 =?us-ascii?Q?LS8OemUSbVE4SLnbC5aJZrlfmbVqduxWEyESmjgI/6aPBOViiYqX8yBnNEmj?=
 =?us-ascii?Q?D7138FM/8feBQeFZr9wHQggVvoSqyDT0q1jU9/aN0r/BJOghApP72931zdRQ?=
 =?us-ascii?Q?04DQOvKpdVmUr5oxQqfHK7lsqymZ7HRDP+MsP7v3rB1szIAxsA/opbS52ZVN?=
 =?us-ascii?Q?qdhOmjk7AugnTLL3VzZ7vPE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66feff55-348e-413d-3328-08dcbaaccdcd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 08:57:33.2463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HUXme2GFdRN+9HthXWqdmY65Dq0JUwAiF69cuA8wdCK9UKyS3U8Qwi4NxP0BdvAxPzK45ie7UVmrAq7J90Ij43p6PSUPk1O0teYdx6FH7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10253
Received-SPF: pass client-ip=2a01:111:f403:260c::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

After updating QEMU modules previously executed QEMU processes crash
on module loading. It happens because error_setg() calls with a not NULL
errp argument.

There is a discussion - https://issues.redhat.com/browse/RHEL-29848

Note: The commit subject was changed. Previously it was called "module:
Prevent crash by resetting local_err in  module_load_qom_all()"

v2: Move local_err initialization inside the loop.

Alexander Ivanov (1):
  module: Move local_err initialization to the loop in
    module_load_qom_all()

 util/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


