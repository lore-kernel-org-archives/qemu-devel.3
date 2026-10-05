Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9458BCA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCl-0000Gt-S3; Mon, 05 Oct 2026 11:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCf-0008Vm-Pm
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:02:10 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCc-00058M-24
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:02:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbBBdccfbk+m0XAcl9YbcvMb54x/gPYY7DdLnyW//+vPdrUEIKXM3GEQj3GjK1kBT9TBRbzXLJtBnqrNK9MpEMe4cgSecXlmkuGdqkp+QwgOOBTFGY1/mAgaRGiwlbypdcIfNv4o1MlSL+5C07sWbWBf0a14yT0jWjgkKgaqaOy0PyPcBc88TfqmO8E8ifO1Kr9m5tE+hR3XN1PEridi04UdcCPCObJg9NVilNBKgsac6zQ9V0OeO0fAVC35bRCiNBJMr2Ye8xMaa19tzS4TJt68p+lVs2Gq82nptYnk4NnVfLhGMPgoNJCOYmYEjnlvO5CqR2KbZL1V6RR9v9iRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijsQfzlMublHxtw5OYdWKyl2kuIq9G99YGRQiXu6DOw=;
 b=TmqWHKw4iZ77c1XSTgauaR4dDMFmct1lQ5DVddwtB6goInL3N2eoClVJTbnuK0O/lknDZZZDuoyl30NO9jt/biHwkyJgGriC3nISHqAy+mAB4IliIHQhpxZMP9fZyT5IKw3/0MfjOqECLR8tSzue1XPjudUlextEfnahsbm5umh9CitQ+h9XznLnW3FwmMayqMe1hpkMXJtHyNYEbu1i+0yPGfeS0WZVbG7CmK4tk4G2tvvYMB6wsB53TAYgliMgF7rERcVxwaRo1zuineSfFW35fMuPKBbEdrMbYPcBBLDWsSLpNBV+RT8Hbkf8B+YG99FeN/moCi1gUKw2pe2t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijsQfzlMublHxtw5OYdWKyl2kuIq9G99YGRQiXu6DOw=;
 b=pu1edRQtmdySX9OEeKfZ72abT1U0po2ZIwEC1ecLa3bE+FHnlcllEKYk/BmCdYycxXGQJH2DoOYgr8oBeUq+CyHHLfIJDUa1h55cIVGcDH4Woz7kSfrV3CWp1dxAvogkucGdEe+v38QWM+WgfdUD7Kwi6iQVgDoYASDvDOWtl1uDGqphN22qyHNB3oIVyCrV9Ug5oDlFr34fBW63exxBxH8HdmMPw3ycjcPTLRGDHxAeQFIVkhC4I+5yUkahdvzaylvhBHMKjYbIx3/ohisSwVRSMMneSZdwVzmShbD8pWPxJRmLxA10gvLpx8BkMYBq5LDiljz1QS5FTc58oOwehg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:30 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:30 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:01:00 +0300
Subject: [PATCH v12 21/21] tests/functional: cover a failing cpr-transfer
 target with vhost-vsock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-21-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 710d064c-c414-4ba4-f4f0-08df22f189e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|6133799003|10067099003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YS7+WR131rxtA6eN77g3rU9qq4ONV0b1FzmrjcX+SSH+y25p4ZYBDzcqRHZ/Tcj/nkqQ2dNuVCVb6/0bI9yhgn/PCHnOTobopkGMmXutxURkUzGhY78NnOTtVuBOmFuviWOk2hK4wEz5QpvhGKk65xY0z2jXyxyvPqBo3k3rlwH8j5K9VxG8SnwA0FZ8smSNeO8T4jupVcanE3yi+DqIMJpjjKzWvQO8p/OeupZZZnk5j71GRYFEgNGeO2Y+bsHG6nNCe0EC0aDuom9cfKU1R6RFUDKLhIZa4eQQcqB44MgH8HRjBW6MkkdFYdq+n5EySxQlBxJYMKNcKd65FYRaVCquj2Jf10aEQ1uSV5M2PtatGjAFBDvkLYcmvhKV+tIFz2w+NWbAOWTPQdKYmoq7t8KqKSZk80YgPECfp0UKEcQKuno9WWD5C1Ti9sGXIl5z4LZDc62SpKVgzyR8gzsXrip25/4THwxTmhm5Gszkult7KWda6BPx1S30Khlcral5N+CVOFPtx2TYeRyvkNG/N+AUbUom4wOF5LLZsWT73qhk6HuR1gvGgkZ5p1+ZNEOpMABvYtNFeHXPSXX5emGMM4nyBBrgfRvPrOSRqw11n0wsRrgHgDUmK5iTUwvvbbIaJ+d/R4kSS20zTHJe3i9RHAbuByaROW7ulPqF1Pqin6An8rlhBvTZ3BTCa+IbJ0GZXgorpLZeKhqNAyREic8PeFtoyymrZRuzI+r2DiG3WEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(6133799003)(10067099003)(3023799007)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JWdlNzSVpKaWRKTEFjWmxkVHEvT0crbDQ5V2huVStWTDhmRDBKdGt1Y2NB?=
 =?utf-8?B?S1c1ZGo3RWh0aG53T2xDVmwrSEl5ZXNTeUxGdXpmSkxrQmhuTllIZURCd3hq?=
 =?utf-8?B?VU5wa093MGZDeFBaNTM2d3lhSkxpUlBBVVhQL1B5bE5zOE05aEJYUVI1RytR?=
 =?utf-8?B?RTlIN0MraVNmR3ZaVmpRMTQxS2VOV0tCZ3FHZzZ4SG8wYy9yTTVUeGdNellu?=
 =?utf-8?B?RGUyVTROb25KWFNqLzYyMmk3SHFvVmV0L0gwSnROUythT0J4aGV5QWlGdjZ0?=
 =?utf-8?B?T2lCRCtoUWF5VkJFc3VYdVlGaFpoN1JPR2xJZkF0UE5oT1laVHAxbDdVMkFR?=
 =?utf-8?B?T1hMT3VTcmFEMlYrZjNhcERvR2FzLzJKeHphVXpGb2FCTktsZmJob2xCdmph?=
 =?utf-8?B?TStKUjhEVndTNTJYMHJKeCtxMUIrY1JIci8vUXEyUUp5YUVZcmJqRFBscXRt?=
 =?utf-8?B?OTZBamJaa1FKSHNtak5RdmZIdStkSUpjZ09JNksyaE9rZ1ZBZFNBQWhITjV1?=
 =?utf-8?B?NUxYTlU1VFBjY2xJSUxlY0hoVUJOUko5NXRwQXlXYXBIdldnWDc2L0NRQXc5?=
 =?utf-8?B?allENFRqbEVNUG1OVzAzckhBYzNNcGZ6UEtKdDI0R1Z2WjFEQ0hmTnp6MzBl?=
 =?utf-8?B?U3VyTUNTODhNUW91cHhJMXBRVmIxQWxxWkpmWFZpVnpFUGUyMVFNYnBuaUVO?=
 =?utf-8?B?YXlnNW5QdDBTQkJ4eEdrZDBZbVJma01VdGpzNE8zcUlkQlp6ajBZVGttNEZN?=
 =?utf-8?B?S2tXbEp4c0pQU0ZKdU9Hd25qVE1xL3AyNzA4MHcxVm8wVmR4c0dQTnl4Lzh6?=
 =?utf-8?B?UU12cWc0K2NWbGc4aWVldW90MG1pUnlaR0hIK1RWbkNoZDV5ekErM21NUEF6?=
 =?utf-8?B?OGNsdHdOQlF2eGZSS0NpbFd1dkRONzh4by9oVkRnYkYyZ0ZGQjBGajluMlpv?=
 =?utf-8?B?Nk5rdWI3ZXlMdEQzUUs3WndLcktsOFA4dmVmYTcrUEtNcURURXl3Q2Z3ajlQ?=
 =?utf-8?B?NExzQ3EvNjV1WHVCMmhOREN2RHhWRzZzM2R2akYvRmNSUVYrSlJ0NkFLeEI1?=
 =?utf-8?B?OGwrUm5KR0pNQ1lNS01jWld0YXVWMUlidXJpMzc2NE5hOVdHWENvUFlGUDF2?=
 =?utf-8?B?aTVaQ0lYVXE4MTJBTExQa2pmN2M3bDdpYTJCUlgybWRCUllES1ZpbVNsckFl?=
 =?utf-8?B?dmxacktaSGVpclQzYk9ObUduMDl5Y3FuS0ErSVNlQXRvbUVjZnBycTZoUmUz?=
 =?utf-8?B?SHJ6SlBIbXBmVWxXWkMxZ21BaGdTdWJ4KzBJbDBwWEtFRzlJclJXL2x1TDR4?=
 =?utf-8?B?Mi84RmhZSWR2VVNMK3JZU0JPWk5mcVlYSEcwNHdaVjVDNWNXMGhzYmhHdFk4?=
 =?utf-8?B?MVgrVmZOaXRUOU1xVk5mRzJUQmQ2VjZsK3FKOVgrNHNXM2RiTjlCV291OS85?=
 =?utf-8?B?Z3d1aG00Ui9ReHRrdkpoUFFHc0x4VEdjOUpuNjZWa1htRlR1UkRjRGJVUDJx?=
 =?utf-8?B?dHYvMXZGN1ZTTEdIOHVZdlJWaUNHMHhSSUJ5OWlGK2p2YmNrcUlyTVRkdjlv?=
 =?utf-8?B?VXI2Rm9lR2NwMEp0WVhLM0liN0J5MFBuL1NsWFV4aUxZbWJiemxXcm5RdXMy?=
 =?utf-8?B?OHQ0RnA3cFBDR0ovZmVudGo1UDV4dzNqc09wZGowWU93Y0MrS2pYRHh2NklG?=
 =?utf-8?B?cCtsSXJFTTJuczFFZGVaUDc1NmpJVjE5VWxtZGl0NzVzZGhqMC85VDBYZXlU?=
 =?utf-8?B?enhQQ0FVd09KdXNVVHkycVFkUG5tL2FjRDNtcTlPNUFWZ3ZlMm5CR2Vnamh0?=
 =?utf-8?B?OCtNSlkrc3FxTURZbW5MRDdXM2RBUVY3TUh0TVRESHVkTzA2U0NPWG1YcTAx?=
 =?utf-8?B?cFpNUHljMTh5cFNTNnV6em9ONkwyZVRTVTBNZW5qSndMZU5oRlZuWm04cHkw?=
 =?utf-8?B?S1JqMjY5MDlFeXFBZVo0T1Y0dWJoQzdpQnd1Q3dlR3U5Yk9Obi9ZaEw1cXV4?=
 =?utf-8?B?WVBsMW5QSHhaUUpGN3ltZ3NsRktOSlFtc3pnSXFoTTJaaGNqQjYzNVRNQ3lK?=
 =?utf-8?B?WVBoK3pOY2N1SEhQVFlmRTYxa0JqK2F2NUZaZnBpbEo5UllYMXZyZWR4WHpZ?=
 =?utf-8?B?VkZTTTFjU3p1TzQxdHdRR1FTRzhlRFVWRkVEaU1WYnRHY3dPbWVJS1JqMXJ4?=
 =?utf-8?B?M1ZmdFBsdHdoZFBwREFIclFGTXlYdjJGZUZWVStNMVB5ZVJzalVHV3d1UFZX?=
 =?utf-8?B?dWpubTljMm4xNG9nREloVmoyQTlDVzZzelc5bmJWMksvWjViSXpkaHY3Z0Jm?=
 =?utf-8?B?ZDAwSjMxWnIycHJ1Z1FUdW9od3h4MUg4WHFXK3VEWldxV2YvSUZ6VlBPOVBY?=
 =?utf-8?Q?jHhBTzXXeSA7fMKc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710d064c-c414-4ba4-f4f0-08df22f189e0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:30.6608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15IrkVzUdCrNZ8TYUZA/QaFTSDAYuooI+AM0pcyr3YKPOqi7AC4of62NLF/k2CK6MHf+qnaTrD7rKKHxOGhAvqIh493tYq1jVzQ5GNIRDe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

A cpr-transfer target takes the vsock device over in post_load().  Make
sure the source gets it back when the target fails to load the state
afterwards.  The target is made to fail by lacking a device the source
has.  Two cases:

  - the target exits on the failure (default exit-on-error); the source
    is stopped beforehand, so it stays paused until we 'cont' it once
    the target is gone;

  - the target stays alive (exit-on-error=false) and the source resumes
    on its own (return-path capability).

In both cases a host<->guest transfer must then work on the source.

The transfer helpers get a payload size parameter, since the plain
checks don't need the 512M of the stress cases, and the target start
code is moved into a helper shared with the existing cpr-transfer test.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 142 +++++++++++++++++-------
 1 file changed, 104 insertions(+), 38 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
index 035307fc82f..892f33c1971 100755
--- a/tests/functional/x86_64/test_vhost_vsock_cpr.py
+++ b/tests/functional/x86_64/test_vhost_vsock_cpr.py
@@ -24,6 +24,7 @@
 VSOCK_PORT = 5000
 
 TRANSFER_SIZE = 512 * 1024 * 1024    # file size for host<->guest transfer
+CHECK_SIZE = 16 * 1024 * 1024        # enough to just check that vsock works
 CPR_INTERVAL = 0.2                   # interval between CPR ops
 
 VHOST_SET_OWNER = 0xAF01      # _IO(VHOST_VIRTIO, 0x01)
@@ -71,11 +72,6 @@ def setUp(self):
                                'qcow2', '-b', self.ASSET_DISKIMAGE.fetch(),
                                '-F', 'qcow2', self.disk])
 
-        self.payload = self.scratch_file('payload')
-        with open(self.payload, 'wb') as f:
-            for _ in range(TRANSFER_SIZE >> 20):
-                f.write(os.urandom(1 << 20))
-
         self.sock_dir = self.socket_dir().name
         self.cpr_count = 0
 
@@ -121,12 +117,16 @@ def attempt():
                 return None
         return self.wait_for('QMP to come up', attempt)
 
-    def wait_migration(self, qmp):
-        def completed():
+    def wait_migration(self, qmp, expect='completed'):
+        def finished():
             status = qmp.cmd('query-migrate').get('status')
-            self.assertNotEqual(status, 'failed', 'migration failed')
-            return status == 'completed'
-        self.wait_for('migration completion', completed)
+            if status in ('completed', 'failed'):
+                if expect:
+                    self.assertEqual(status, expect,
+                                     'unexpected migration result')
+                return True
+            return False
+        self.wait_for('migration completion', finished)
 
     def wait_running(self, qmp_path):
         # Make sure we're dealing with the new QEMU after CPR
@@ -139,13 +139,37 @@ def wait_running(self, qmp_path):
             except QMP_GONE:
                 pass
 
-    def boot(self):
+    def boot(self, *extra_args):
         self.guest = self.vm
-        self.qmp_path = self.prepare_vm(self.guest, 'source')
+        self.qmp_path = self.prepare_vm(self.guest, 'source', *extra_args)
         self.guest.launch()
         self.wait_for_console_pattern('login:')
         exec_command_and_wait_for_pattern(self, 'root', 'root@localhost:~#')
 
+    def start_target(self, name, main_incoming=None):
+        """
+        Start a cpr-transfer target listening on the CPR channel.  Return
+        the VM, its QMP socket path and the channels for 'migrate'.
+        """
+        mig_sock = os.path.join(self.sock_dir, f'{name}-mig.sock')
+        cpr_sock = os.path.join(self.sock_dir, f'{name}-cpr.sock')
+        channels = [
+            {'channel-type': 'main',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': mig_sock}},
+            {'channel-type': 'cpr',
+             'addr': {'transport': 'socket', 'type': 'unix',
+                      'path': cpr_sock}}]
+
+        target = self.get_vm(name=name)
+        qmp_path = self.prepare_vm(
+            target, name, '-incoming', main_incoming or f'unix:{mig_sock}',
+            '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
+                         f'addr.path={cpr_sock}')
+        target.launch()
+        self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
+        return target, qmp_path, channels
+
     def transfer(self, guest_cmd, host_cmd, cpr):
         """
         Run a socat transfer between the guest and the host, and keep
@@ -160,21 +184,26 @@ def transfer(self, guest_cmd, host_cmd, cpr):
         exec_command_and_wait_for_pattern(self, 'wait %1; echo RC_$?',
                                           'RC_0', vm=self.guest)
 
-    def transfer_both_ways(self, cpr):
+    def transfer_both_ways(self, cpr, size=TRANSFER_SIZE):
         """
-        Send the payload to a file on the guest's disk, get it back into
-        another file on the host, then compare.
+        Send a random payload to a file on the guest's disk, get it back
+        into another file on the host, then compare.
         """
+        payload = self.scratch_file('payload')
+        with open(payload, 'wb') as f:
+            for _ in range(size >> 20):
+                f.write(os.urandom(1 << 20))
+
         echo = self.scratch_file('echo')
         connect = f'VSOCK-CONNECT:{GUEST_CID}:{VSOCK_PORT},retry=10'
 
         self.transfer(f'socat -u VSOCK-LISTEN:{VSOCK_PORT} CREATE:/root/data',
-                      ['socat', '-u', f'FILE:{self.payload}', connect], cpr)
+                      ['socat', '-u', f'FILE:{payload}', connect], cpr)
         self.transfer(f'socat -u FILE:/root/data VSOCK-LISTEN:{VSOCK_PORT}',
                       ['socat', '-u', connect, f'CREATE:{echo}'], cpr)
 
         self.log.info('%d CPR migrations performed', self.cpr_count)
-        self.assertTrue(filecmp.cmp(self.payload, echo, shallow=False),
+        self.assertTrue(filecmp.cmp(payload, echo, shallow=False),
                         'the data came back different')
 
     def test_cpr_transfer(self):
@@ -184,29 +213,11 @@ def test_cpr_transfer(self):
         it and shutting down the source
         """
         def cpr():
-            n = self.cpr_count
-            mig_sock = os.path.join(self.sock_dir, f'mig{n}.sock')
-            cpr_sock = os.path.join(self.sock_dir, f'cpr{n}.sock')
-            target = self.get_vm(name=f'target{n}')
-            target_qmp_path = self.prepare_vm(
-                target, f'target{n}',
-                '-incoming', f'unix:{mig_sock}',
-                '-incoming', 'cpr,addr.transport=socket,addr.type=unix,'
-                             f'addr.path={cpr_sock}')
-
-            # The target listens on the CPR channel: wait for it to be there
-            target.launch()
-            self.wait_for('the CPR socket', lambda: os.path.exists(cpr_sock))
-
+            target, target_qmp_path, channels = self.start_target(
+                f'target{self.cpr_count}')
             with self.qmp_connect(self.qmp_path) as qmp:
                 qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
-                qmp.cmd('migrate', channels=[
-                    {'channel-type': 'main',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': mig_sock}},
-                    {'channel-type': 'cpr',
-                     'addr': {'transport': 'socket', 'type': 'unix',
-                              'path': cpr_sock}}])
+                qmp.cmd('migrate', channels=channels)
                 self.wait_migration(qmp)
             self.wait_running(target_qmp_path)
 
@@ -217,6 +228,61 @@ def cpr():
         self.boot()
         self.transfer_both_ways(cpr)
 
+    def test_cpr_transfer_dead_target(self):
+        """
+        A cpr-transfer target which exits on a load error after having
+        taken the vsock device over must release it on exit, so that the
+        source can be resumed afterwards.  The target lacks a device the
+        source has.  The source is stopped beforehand, so it stays paused
+        on failure until we 'cont' it.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, _, channels = self.start_target('target')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+            self.wait_migration(qmp, expect=None)
+            self.wait_for('the target to exit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 1,
+                             'the target did not exit on the load error')
+            qmp.cmd('cont')
+
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+
+    def test_cpr_transfer_failed_target(self):
+        """
+        A cpr-transfer target which fails to load the state after having
+        taken the vsock device over must give it back to the source.
+        The target lacks a device the source has, stays alive on failure
+        (exit-on-error=false), and the source resumes on its own
+        (return-path).  Then vsock must still work on the source.
+        """
+        self.boot('-device', 'virtio-rng-pci')
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate-set-capabilities', capabilities=[
+                {'capability': 'return-path', 'state': True}])
+            qmp.cmd('migrate', channels=channels)
+
+            # The target opens its monitor once it has read the CPR state
+            with self.qmp_connect(target_qmp_path) as target_qmp:
+                target_qmp.cmd('migrate-incoming', channels=channels[:1],
+                               **{'exit-on-error': False})
+                self.wait_migration(qmp, expect='failed')
+                self.wait_migration(target_qmp, expect='failed')
+
+        # The source resumes by itself, and vsock must work on it
+        self.wait_running(self.qmp_path)
+        self.transfer_both_ways(lambda: None, size=CHECK_SIZE)
+        target.shutdown()
+
     def test_cpr_exec(self):
         """
         Perform consecutive cpr-exec migration during vsock file transfer,

-- 
2.47.1


