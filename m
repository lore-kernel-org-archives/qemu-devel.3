Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scOVz-0003Sr-4V; Fri, 09 Aug 2024 08:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1scOVr-0003Rn-A4
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:14:32 -0400
Received: from mail-db8eur05on20706.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::706]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1scOVo-0007hv-0U
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjqU3zOaCMeGnjlSUsYyBEFXIDVM5F8qmevTrovcIPa2b58CTAJJVi8wQD7uaQvtHghuc3lHQr5ZrAxeRfsm4cfq7C9UHonWjj4AACf4M38WfObf12urCy9L/aGpZHSFn60O6tTnRMOLbUC5WNkLhTlglkXjjPVs9bjmtuwCTrZNihNsmCSIB7Z2DQPMRVX/jrEpWbPSnLPHOl0N/4ORewRERkXDr7N0P1a35tCQ5MrLob0TsY2B5oIVo0nAgdDgKWKA+4V1/eilanftC8MKfEmmOMhYaiULnG575IfGncI22FkZxK6n/tlf4cZDYdRc5p4C5xYo7VeARSGaxcIfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++TggdeEOvU/lUX7aRLVwIU8cM4EZEeTYp5CMJWRZQs=;
 b=rv0duvv4pvG/2F1ZpkxBz2rb7GkDe1/z73anl8bG0h5v6ZvkTv78yTDTq0bV3OpvEkP+CIPeNiJJ8W3jJRWKr3msKqZnspTZVAdOytPMV+zfvpr+/AajAQ/oW1PJW5HmPID26EQsrmFK6U4aotoogCygdVnHZmvESmmLsRYynFke6YFfuvDwXn3AVdwSnrxuI0ddN+BUhAqLmEciCwZzIEVQt84PMC4C0Sbk4k3dyGG1r/Ks7MeQVXeWPX0oJlKVnW4qWjVNRmqeimPGWMPIJnOVSBh0BVhZeZZRVhxohfrWWQbatEsdrwvw0vku+QBrw/wMDQ+dwV9UHH5talhUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++TggdeEOvU/lUX7aRLVwIU8cM4EZEeTYp5CMJWRZQs=;
 b=zSeBOwyul6I0IsYj9OPDbNlthcFNDinoHHrCfrpnOsuAB4ayqV4yzPiOx858EZuV+5A6RfsaTkaOeFv2xWhhHGoUCd3Udfloy4hrJ7zE1SvOKQmgXZq0jL9wAVNyxAzl2J+17+nUsQ/nqqR5i/D5r+Zvarm+Tub2oYZyv4nU9AJlzKk91KPQu+nxrvHRTcJJAc7MiW/yGcbapTpaRm++U5CZR2k/6nQ0ldKtXHwv0wkEa581vdLpMrh9uH8OhN0oTr4Fxtxe0TPw1uXbffRA5rHEuAa7bgZQQr1GMVhPEzCGfBApnjnkMd8PLG1oNyMjIgJs7mcnQe+2PqGXQMbfIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS2PR08MB8718.eurprd08.prod.outlook.com
 (2603:10a6:20b:55e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Fri, 9 Aug
 2024 12:13:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%5]) with mapi id 15.20.7875.007; Fri, 9 Aug 2024
 12:13:48 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
Subject: [PATCH 1/1] module: Prevent crash by resetting local_err in
 module_load_qom_all()
Date: Fri,  9 Aug 2024 14:13:40 +0200
Message-ID: <20240809121340.992049-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
References: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::9) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS2PR08MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 6678c0f0-79de-40fb-620b-08dcb86cb8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WadY4k3n1wxC2ZVC4PhI/QgrdO7ncLwgXtiK25UHOCZHYdgzW09EKFttFY9i?=
 =?us-ascii?Q?i0VT8ubFiPgD8WSDbX9j31TC7YRqw3kvQH46ZsMzd500rLV9D2olc7KFOBdX?=
 =?us-ascii?Q?ftu7zzYGflSoucP0E2LUYIlzlzw8Qv9esGynEvcqJk5BKo7wKG4guGvaNrC2?=
 =?us-ascii?Q?nzW1cV4uRy7pVl8BHcSBGcs2F+JZekVB1VOnfiXTlarxRX6k79XWuruZ5zIP?=
 =?us-ascii?Q?b4CeAw0dflkM58yobzzyYY64acruojKu3NaV+gBAEPMQIieE+7+FBO83WCAA?=
 =?us-ascii?Q?+wDEgPWv9ZUgvlUkyF9wCr5dw3EPyOftvAMop0Umt3FfHkO+HHfNIBlk/Xlg?=
 =?us-ascii?Q?BlkHnmtgBtVauAcDEsvRt+KM0LudII0/JkoC1d+81GDxlo1bFmSw9Ye+WYQS?=
 =?us-ascii?Q?irc3zA0BmjfSnQQWtQSxm/545xNYeXNbeb5vBC0dHCxM9Ca3jtyFXs1Rc5lO?=
 =?us-ascii?Q?+tD0FcrMD2GqYGYkjFQtsr5bWLfmMB6Ili4wfrJSYGg2Jk72m2VwgtSxPPr4?=
 =?us-ascii?Q?0NkTlBXUJq+Bt+qfRM79EMufph9yUKD8UsHZKxCEAxFRppdGH9IgfSecUX/Q?=
 =?us-ascii?Q?ecsIaLygA71cQaXl5p/7R0DXwd8VYSuZlHuRkiYHGYV5BdJVyGcF8f4vU4xr?=
 =?us-ascii?Q?CfVh8QFN4zt5NvIIw3T7y0jjk1Vwx56KjQRqc+JUGTqvqrXsdDQDQQLkjqTg?=
 =?us-ascii?Q?HfYEvZQ8tkGzYqW2tky3Bq8czoomthd+UGjhKm6WjAh1EnAcfNXJoym1V0vK?=
 =?us-ascii?Q?u6busnh/Gq0dNlJjR0cdL6/HaPoSjb5vDxPkozMiiFHNPVmIPE4zMbrCAVIv?=
 =?us-ascii?Q?eyUwfibflinH9AYKjA//6FyRRXZ+nmwPkvbZFPWqwBjyYt/vaoY6U1cQJsba?=
 =?us-ascii?Q?a67DFpiMMyzdbcL/hDrMrYpYaV1lgjMNX4y9SdZqexVfRr/WSxhhwcO6ktBC?=
 =?us-ascii?Q?Kvr+cKJiuF4ZijLVm8cWcqGKs7t+dYv4htvtFV8cFDwbjTDZjDiymdeOlrGg?=
 =?us-ascii?Q?S1DxUiVfCzr+BCEiWNeDa6wQ0G/NFpSDCev00f7MtswbvIQmDzl11+9aOgGb?=
 =?us-ascii?Q?lkAKI2LHnqhB6sbF9lkh2ub1X9fRAYq0HRoBvAuAWCwbn5an+dllMXd6U1SH?=
 =?us-ascii?Q?OV9BRe0EIz6JwREbWC90Q3cYIFeO7QXUCJ9SAglF8C8EF9Si7Z9nvFMSClRU?=
 =?us-ascii?Q?ADWYhfNZXYTgb3HAG6xOxEbbZSRpSz+MVTuQT6W/30KXBp7eHSW60BpAdx98?=
 =?us-ascii?Q?MIWf/1ghMu/01+zEPaaGqJeA3nzyMYBo5dFqRkCMfBHsUGxaHouNVl5zGVtr?=
 =?us-ascii?Q?dslrRSJGxjzKRA/dRZgAHLQZZatv/UTRfj4FsytizaYDDEPXIIe6+zIj3yAq?=
 =?us-ascii?Q?6neKVXbKUtAqKlx/+NLOVIBaydUJDEtO0z1R8rowZcgVMOrupw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?leR+rS4XGuFZTNKR3QWw77vflKHBtukynK/UepQsoZ9naKPjHP4t6SPywP5X?=
 =?us-ascii?Q?wwBrsiD4FRO7ojqTh7QGuQePYksArSONFayK6c+Ok2ZAw132gk8HB6V0BB7Q?=
 =?us-ascii?Q?I8A1SgMgFDUPs7f5/DOMvYYY/Iu0FSlb5Dc6vXYcO/RPbFyytYVunwnKXpil?=
 =?us-ascii?Q?p0gMfNfKgKrw1VKSYnRCUZDpRXcXT7aa0qBPrBRB6/xYmOT0ONBhc8ns/X9F?=
 =?us-ascii?Q?QWowHR378w+w/wmQ7CiiMudCWwStuq0SFLvCD6FTNz6eNNxqUbwBiC/cmQVl?=
 =?us-ascii?Q?2hpq0vBkXMe6CpuZSFw8D/HOJCxLrsAijmMB2CMCU6FrfNmV1liWQMeOExkJ?=
 =?us-ascii?Q?7SH6lQBJdIZuIkHnXbaPuZF7k4i8IBvnzwRsYDUu8MDLTBzhi7VDoRcV3rAq?=
 =?us-ascii?Q?HctHiAOLi47XDqBfhmFpqx6aqvkUJngYlovZP8lECldwv8Achcg6XCAi1pY6?=
 =?us-ascii?Q?XhlHPjyzWi16JptF78uAfASuhas9WlOfc/a8KJyIqi1vmWPi05U389x/d5qS?=
 =?us-ascii?Q?fRAsYSjkvxDs+a9uswK2kTqQ99PcD7bQJd13L6kxNBW9AwZUuQv6jp+Zx5Nd?=
 =?us-ascii?Q?phKxU5NyV3RJvERd2EV9D6b3ukTRJpaLAkKvVZFwdfn7fnIbJMlwk4koHb5W?=
 =?us-ascii?Q?Z2C2x99M9n5t3YEMC0t+eHWAzJJs6pQu59O5jGqODEC5COAIysLuAxHXbx73?=
 =?us-ascii?Q?GE/PNm7PVLttYbTrDW0a7bpI1eCxbYtV8ybDxI74ALza2lu+j2TYy53zWNgM?=
 =?us-ascii?Q?8R/YDueiAgucs1jNS5kUm3TO1BZyAE9ePjrxvnnJ+SCgf92y/znvtlvcHWrP?=
 =?us-ascii?Q?f/EQvzGbrEIWyn0soP8MgNjCx30UGgTGkOjiVXQqCwkoO1HdC7U3MqWPO9Tv?=
 =?us-ascii?Q?aQGhnvduhZqNMri6Qs/pMY2ySPGwcCkXfvn39CyjMU+vahYECGB4v5ea263c?=
 =?us-ascii?Q?J16lhppZchsfcKhGJtashKtZygcuWKRgVsNFA1BkGSLy2SKbw0JDeLnoyeD6?=
 =?us-ascii?Q?vtrdQ2JyVs1pTbwrpuWXH9QOhdWcFvGchIwXlXPx7QrZTmv/HCceN9LTE7nk?=
 =?us-ascii?Q?1kkh7Fusxnabsj8urlzhCOi0tNbBDvZd00cfK4Z0qeGz1y3Bk9y196l/gzao?=
 =?us-ascii?Q?taapzlmYbvKckbKBblj95fb1Pox0p2sY+afSaxGTYmIM8TBvkDurPpYRKM0y?=
 =?us-ascii?Q?rhqC6m9k51NTcC4w1/F8KjUthsmyKadF4Q3aY2g5qk5nYyXVftta01EogNj/?=
 =?us-ascii?Q?fVbKHmL4NCvksf52zUe6LeHQeeAsORycv5wpyLYJndkS+LhrOuTbMQr05JhV?=
 =?us-ascii?Q?4bjfCip4ggBtz5evdh8dW0CG3EEuBGgIhNW8B89jHWuDBrLzuRI5B8ZfAFXg?=
 =?us-ascii?Q?0cgWc3BOCzLZVHeAoHllgE9A8LQYdb3t8VYq7LitlEYa9OM2EojQdYohuJ6t?=
 =?us-ascii?Q?PIpRcm3fKnGm1BiJY27ZZ7U7bHzIeH5mEUE3bjD2lZqmuKagaHp+EjgWVWdE?=
 =?us-ascii?Q?Ap4IWswW4qMrrkX7jHLfi7zVxeILHBzsPDjIc79R/EmpPK3vAXWlW+CB7xgz?=
 =?us-ascii?Q?VpithFit7SIf96albk2F/jut7GMSqMmg13XBhablBALqIZruYj5yhIvcyOkJ?=
 =?us-ascii?Q?g0bqJmpTOc7owNadX51oPsI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6678c0f0-79de-40fb-620b-08dcb86cb8f9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:13:48.1005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhI632WTpb2Oq8JcHSEaPcquY/ExqveJjLxrA3v44N22moGSYYLw3iUuazosS+3WzOaDgWed6OPOX8+ElRNByudo1fa9+jAatln5ePYNztA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8718
Received-SPF: pass client-ip=2a01:111:f400:7e1a::706;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Set local_err to NULL after it has been freed in error_report_err(). This
avoids triggering assert(*errp == NULL) failure in error_setv() when
local_err is reused in the loop.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 util/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/module.c b/util/module.c
index 32e263163c..3ff4aee2ca 100644
--- a/util/module.c
+++ b/util/module.c
@@ -369,6 +369,7 @@ void module_load_qom_all(void)
         }
         if (module_load("", modinfo->name, &local_err) < 0) {
             error_report_err(local_err);
+            local_err = NULL;
         }
     }
     module_loaded_qom_all = true;
-- 
2.43.0


