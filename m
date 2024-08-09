Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F105C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scOaA-00082I-3v; Fri, 09 Aug 2024 08:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1scOa8-00081d-S9
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:18:56 -0400
Received: from mail-am6eur05on2128.outbound.protection.outlook.com
 ([40.107.22.128] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1scOa6-0008Me-SU
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:18:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkOXaysX4xaOpF1CMMKi7GaTekdRcAkl1PT/J8J5anbhCmJfAVRVOORJ+ixuariQ0u+KBG4fYKsEHMbIzeeBfXsc4BjyEzmnjsKs6nzKBCyOr5Mv38752HXKdyl5XYwwLIdQEG8owA0PpU3kHfEz9hCNV51Tzjxe1V6wETIoiDfBS74Poy6rUS8WsqLUEHw9Bl/48ACfijvbsATD5RoW88kDcDXhGslAC4Dl0fE/vZXjFQfvhKMNkwUVd6U7Pl5xJ02wpgiVFIUAj0rl7HbrDJtl3loXB9+pMdbPPxpqsCeT+zW/I+GXTYRjps1LYLz01LZAPL1XKyXoSPoSo+kWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBAkb8A2xADg8i5JFRRJasMMVYkWPaPfc5VvDiCo3zA=;
 b=IQlu89leWm5kdpLtfAqUMIzYxQmT2TGSKUOCvo3lsGLU3IcpzDmOfQNfHVfTVEqmHATLpDmzc06og8jqZdij1m63IFzP3Famc3LHmQa5GokS5tuCF64vL3R3FjQwzz6X/NjuRwNqKozWQebDg6dxvdO+tk4ColFeQbgjLltqY2ITY5oFDNz4px1zwZ6OATE+0JcGcRf/rMUdqhCtDZr1jmQ0yyv+IP1YzHofAYIVGVYAvnJCBRskmZq0WJmKxbnQrATB4xCWduSsQ3Ugm6RYP8QiwusBZ/7n7SSptxl+qrlRwqmpdJOkGAuh+XhFo8qDVDIC80Zso7fUatEfwKoieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBAkb8A2xADg8i5JFRRJasMMVYkWPaPfc5VvDiCo3zA=;
 b=PjwaELJs4fP98+RAvjqJmhFizv+tGdZpoGtu0Yc0bOCAsIyT92x8Qr1cFIFbBW3qWMHr+5St0Z0E+8+UwWSeX2oGv+JXlS5CzDl8yrRGHz3f+x0mQ8PshVm7uzk1kh8cwBjOZyL9GfgLvpLpf/oBKAWYdF3SkHu9ObbkeAp3f27KWemb6UQqn148WSI7Zsz9wFe1lROj2a00GTPlfCYlFZcTxCwuHl5RXmCPId6AJSIzOGX2lUppIMcn+M//PgABqcUYrEW5cFOI7rp0B/4LELUVNNv5YuzWYN0uj8QPidavOU96Ge2/X33iIR04Nrg11ZbpjuYmtuH5bVMe6ODhnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS2PR08MB8718.eurprd08.prod.outlook.com
 (2603:10a6:20b:55e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Fri, 9 Aug
 2024 12:13:47 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%5]) with mapi id 15.20.7875.007; Fri, 9 Aug 2024
 12:13:47 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
Subject: [PATCH 0/1] module: Prevent crash by resetting local_err in
 module_load_qom_all()
Date: Fri,  9 Aug 2024 14:13:39 +0200
Message-ID: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::9) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS2PR08MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d396cd4-5fa5-478a-6326-08dcb86cb87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WDqig/wcHuZoXLLpLikBDUBVnlXR2PwSu3uuMNIvWSRvaLz6c4wS5UhWMUkR?=
 =?us-ascii?Q?tPCLuqFmxtIMRGD4UhMaE8ro7Km1zxzFK28PPQ++TpTc6sHWL1ZPdk7qF0ln?=
 =?us-ascii?Q?of+gQqHZItUlMCSmuZpRslC6cRtlcy3KjOKr/JY04xwWAWs0zbKyxFfeNwag?=
 =?us-ascii?Q?fx0KcNmVGeClCt2jtlGB3JJxoMT5eJcJ1MVNow5plhzvu6ErCc4jZ/mK8Qvt?=
 =?us-ascii?Q?OsRmlOmdQGid32RPQBX9BlcA9kh6ij62U+LijiYgpPgtlGvgLYkiKB7AiLCc?=
 =?us-ascii?Q?MwfX/y6g5GqSoqayzxzxggqJv7WEeHXDiJJ9fMEMPqCObLiuw5UXylc8JtG3?=
 =?us-ascii?Q?xCgfmMzUceZB3v/Sor3cq612XGW2RpxLpd+59EIZixiMa44Us6oUYIxGTJKP?=
 =?us-ascii?Q?UdHf7cAh9m/G80z0H84nlUMnOLdKv+NVO6zDg7FmzsYHTJB9aKgYZSyo0i30?=
 =?us-ascii?Q?Ru6eRke16TmSSJD2W2mHDHrOclUPvbZbbvqS210IE8UUCoDvY0h2s3sY6s9Z?=
 =?us-ascii?Q?63vOID7RTjLLeLsn/DIk3YDUDfxsjp97ROBA4Pi/H3STS3wiflVjJsLEajnN?=
 =?us-ascii?Q?OWeSQ17mN5FeWc1Z7QJQEx0CHQhEgA0vtArJUf5MmXygR5IT3pTKpjIh72bt?=
 =?us-ascii?Q?CoJpQoLWx0C9eRtcIwN0n4jQNI88yupUcVMHF40y4GYPtmoKTq9pJH1yv/EJ?=
 =?us-ascii?Q?Uz9U2zWAJ7VipQeXNMb2h9qDn4maLQI9zCKRX0OA5QrRKLkQLG8f7gx8hzm1?=
 =?us-ascii?Q?NR2ZCktja5uM2TWOn0GwcJC7rD64HOuvYRavdHPDKeAUv4ks5YFFum2hSZhU?=
 =?us-ascii?Q?eC+XJYUJEr7mOhMCTJewCXP4rmZTjhJSLJ+BCYimbV8AhXUlfqZrdKNGbxZU?=
 =?us-ascii?Q?sP9X9BSH8uxTomCIxe657mVDsgGcL94Qp1b2Uv0xIRmmXPLR0Gnv9pEDZcnX?=
 =?us-ascii?Q?uYTc7OpeciYxPCnjX23Xl0jwlGt9i3ZFfWtjiFc8Dz3hBoAroodEWoLlVmUa?=
 =?us-ascii?Q?sWBD3j0+GQ3LJI46oqnBHU1ID1g1BtdXeaJb6cCgNT8kFP90m3/KPMEFDzDs?=
 =?us-ascii?Q?dWtifQ01mU90p0iWl8P7kD+Z82YVRJ9QnyaGQHzGTd2lDfwWKq//Xqaeo66Y?=
 =?us-ascii?Q?IasQXCZvMgWIQEbR2AswhD6KKnDFwVlhAomt92Ujm5W/beun5SMPOTop6ZrY?=
 =?us-ascii?Q?D0d+BHJeQDz4SJmLf993bGuBFkaHDulhLzt/26NCcoTsidHN7gzfSLYNPlZH?=
 =?us-ascii?Q?YiluC7xJ+8Dl6xXMhJV51eUZalRavOSlEosllzwd3yjeR1EBbCgxU2rmN9Qb?=
 =?us-ascii?Q?9W0v3bzNWVnNvEiFVDg1rnEU2uoGwJBvlHD2UQiqSG2mmKu+j7IRB7RRza89?=
 =?us-ascii?Q?Bt1zB3O7S2fAJkyQSs6Fs1sR8cAs6GqU7UyhuFEPXkTM7bVLXg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Vlg4sHtyifaSIKLOhdq5JmYPNF1VZmdZKSd4ZQpzDIjp1Je4HnJ+Ez5KMkX?=
 =?us-ascii?Q?R2n2AhRqn6SSPUxS30QBW56MUXlIcHmM7KhroM+cnr8WSQH9/ROCNFUe2jug?=
 =?us-ascii?Q?zqMXt+Zig06rYCdTeOiq6HeFwpB+GFiZXwSGy6uhtI7+WtM3foHOO9leapFW?=
 =?us-ascii?Q?aeRx9V8dYaFBrmtz803sncLJST85Rr/I14jRPbtXGND0vZmFHSpp59N2KNGe?=
 =?us-ascii?Q?31pdh/FoC08womBhLvlQr0hDxLB4Uu6k8QOseBVy8f1FJc3+jZzwNKlABNRH?=
 =?us-ascii?Q?nfp8xdopnDvlM6GGyuBhG77XClrjBuSkpVNBhrXZDuCUbHL0M99Vh6zU/Mk0?=
 =?us-ascii?Q?l42Eh6p7zl9XDupYczJl4y340sxmLw0eBiNcFJZPjoIVq7GBxdyW1LzLxELs?=
 =?us-ascii?Q?7v8Ez2u2Ov2JG2Qa1i0/ApFr+VqoESsKiCQ4W3AYaoq307fuEXQa5yUbXXYm?=
 =?us-ascii?Q?I+BoO1W3U01LDAMNrYfAeeAa8FTtHfoNlpx25uV7rqlhyxkxOIT/PzB23pTm?=
 =?us-ascii?Q?TwuHt7VsgcUgeiZQd6OvSOSsN4MBQOzO2wub15Ceq7mwayGzxQfaxhaIPWmN?=
 =?us-ascii?Q?BOCN/DxV+6hATFdgVG9mV7nS6TLC+KynrghnyHEnMkwiCEwVrDqyv0Gqsyfe?=
 =?us-ascii?Q?TtezHkNl2SCKomm0haU50xob9DSdWpe9Bim18ArwpcCpmIKs6TmfvgB3sKTS?=
 =?us-ascii?Q?+Rk7t4ZJlmpduyz8amXAaMMQG4HRdXDhbRqkWnzzIz7dydyi1jYIS4ByF5O3?=
 =?us-ascii?Q?UASspu/vccQedWTF0NoC1B4YjbIZkQ07ZmokKUpv13spd2JkkXMpVEey6l0P?=
 =?us-ascii?Q?/GLlwisyR2xdmcjw6qCwHeTorgjuFIKeE6Ca7ZHWMIPPATcaryFSjZk8ChhY?=
 =?us-ascii?Q?9jeQ9K567JBk8e564cp/HVOnefXYCy0iZOtLIEkjbRrAx0rA+ae88D5CFhsO?=
 =?us-ascii?Q?JhxAp2p4GzIzuJjMDF9YwHIZaCueeDmgwXdluhhWCrQ30xE0ZkuY5blQkOg6?=
 =?us-ascii?Q?oqnmw4BxC2GOIyo+ShqWInE7gpfIwYrPy5XVQm0XpYtX2PDlABPpjqRtZMB+?=
 =?us-ascii?Q?IVNbFmrhWXJBN1+TugO4f9vcRl8OLxnA5/NA4g+4DmBK5ZKRosuxfRa90CiG?=
 =?us-ascii?Q?JRWrOebzuc1wbBCsBCv/7I2cWktZEiosxNVm4F30r1OuDBmuTfFMQSA0Ik9G?=
 =?us-ascii?Q?I5toTLBeIXJw7qVE8bWpnEfaYIsHHACDZegeiHer+cd9a3v3ieOWohRTVCIx?=
 =?us-ascii?Q?9qnm939VNevA7NhMZVwoNW+YplEsZ+IcjYggFF1Dvzs/7MfGuCY+XapZ5zYp?=
 =?us-ascii?Q?p6nXxDiB6xG18wmdVD5bOxUrtLXL52zPIBUC/Z326NdbUX3xeJ3ZBWOC6sEP?=
 =?us-ascii?Q?k30UWYbSbPX13LPl5roc0uGhX27jqjkKcJeRut8sb05bTFHsHntOOpYtWH6/?=
 =?us-ascii?Q?oiJjlfgYi+6cnEg/TBV8rRcGaXBQ9HB//a+imbN2urt5rONvea6rztSNNX7H?=
 =?us-ascii?Q?96GqMhAcY7amAZy9wyFZqVq6IrPbB/B4aDip0yjVqjblSnJP6EivxxqGPUuv?=
 =?us-ascii?Q?Qi+Tpz/CtBuAaMpGZXO9gog9doBJbYT3JSU6zsK/hxEv3/q+WVuGPKq1LX2h?=
 =?us-ascii?Q?uwGkFIliwfHyZIl+SI9wA7E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d396cd4-5fa5-478a-6326-08dcb86cb87d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:13:47.3539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uSy3aBiL0E/1PaeTzND86DF0iD2rl38NP9aRVYDkbDy4vRnckfL6W480YB1FvaYE3WN41ozs3lT0+JCp1Tu+m/29UQp6EGdsMqn6yoS/54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8718
Received-SPF: pass client-ip=40.107.22.128;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

After updating QEMU modules previously executed QEMU processes crash
on module loading. It happens because error_setg() calls with a not NULL
errp argument.

There is a discussion - https://issues.redhat.com/browse/RHEL-29848

Alexander Ivanov (1):
  module: Prevent crash by resetting local_err in module_load_qom_all()

 util/module.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.43.0


