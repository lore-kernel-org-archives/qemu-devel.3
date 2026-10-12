Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5A5CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDHk-0007zb-7s; Mon, 12 Oct 2026 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHJ-0007hW-2w
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:10 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xGDHF-0005Fy-6n
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:29:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnV5fFcz4Ncr5ghfAFdOosXlFwYCtjxaDWPrQ+Dq6p6fPyHDeRmbcOOPLdgFIp5EXnaTpucBWbwLQ0E4wLaxzkDjiyZY8mxLh92Z16tqIGqKoclHISlxxPXAM1xyRJOrcS2O/L7oG3K22ipR9CmBIzEZj/opAmCWM64V2gNcb9HqocBDyNwiR/luuBo/heMabIsKGK11wCVlzRdblIpJiOLQVGCUpvi1Kfn/hA0Ow/zJL5WyvzxhgIxF6tabsBx6Gk43vMH3BOYbC15YuJ1a5vfenVxchyD6y0H9oft3ylv9Iy1HO4gLV1n3bueurtOTY3r3fJIJGqOtqKG97i8KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=ARWIsIsJyctZjkpBajz2l+cs6BQC1T0vwhltGLOyaQFPioSzq6VMDYDYqe49FTZLMJpnkPEyv/Qisfm5cECoPr16ztEcDCbFJTnOkmVuDlbCz5+FLFBMr6CsQkKJMc7cWQPQpk24Vrz9QPdPL5gMRcY1Vaew937hEwYfjHdUDwkJ1pP6tVMr6Yh9h0kmodibf8SNRcXP+d2OXBbTLpfOu4MPHgjMl7rPfJbnKhn88U3YNPL7d2iG2hMmuZcLLtTSPWdktRDQbl1t2p/p6cDqtLXpKDW6yOddD16xp52v0yv4yfEciCQWIgTHN6JpgnhHscFJwMEbHuXKgmletM4Hlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9uyq7mQIpionRYH4TGd39qHDkvCHjkKh3DniesFcmA=;
 b=n3IkhehIfaC55ca/KsJgA4mOXMJb9HGkfo+oA0oUPUeJ/yUY23u8ZkaEbo19A5WmddfWkWXcGYMjpyVv0zWgdJsyLF9D++ODXbYGQDtcmMdjPEmjMcr70XgOMHclAvBHVCSqR5yWB6yEcW1KLQaGtxgAbCnuuxwsJ2qVRNxEoe2yZzyUCnLE3KPCiwrENTePP3LoV3VI3ARRxuphkoQeQp9lFxoaJNRr5XwI3fU8TUSXWItZdumYI0/uQiZg6mQCKKmlJdKtiR5YInnfVvKIRegiaQ0mW7/tRWsP3A6CI7lFEExRiBjMsSWpzJVgn/3cmfWesIO2SptWVonYu3f7Aw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB11921.eurprd08.prod.outlook.com
 (2603:10a6:10:614::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Mon, 12 Oct
 2026 10:28:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0522.008; Mon, 12 Oct 2026
 10:28:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 12 Oct 2026 13:28:30 +0300
Subject: [PATCH v16 22/22] tests/functional: cover a cpr-transfer target
 going away with vhost-vsock
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-up-vsock-vhost-v5-v16-22-36c38bd15ffc@virtuozzo.com>
References: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
In-Reply-To: <20261012-up-vsock-vhost-v5-v16-0-36c38bd15ffc@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, bchaney@akamai.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, sgarzare@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, clg@redhat.com, den@openvz.org, 
 dongli.zhang@oracle.com, farosas@suse.de, andrey.drobyshev@virtuozzo.com, 
 peterx@redhat.com, dwmw2@infradead.org, philmd@oss.qualcomm.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR03CA0043.eurprd03.prod.outlook.com
 (2603:10a6:803:50::14) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB11921:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f55ae85-abb6-4b65-7dd2-08df284b9aea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|7416014|52116014|366016|6133799003|18002099003|22082099003|261009223327099003|261009221727099003|261009221227099003|3023799007|10067099003|261009220027099003|38350700014|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: HgI8Q6MyPgEJ01VXfI8NgD3eeAc51mu3debUQBXQLcC3ccT8uy/bbLswv8jbHZ+jJJdL6y2/m/cNR6D+e6g1wlXKK6GmubYEfpFHdWBCeUMB9NKQY+kPn+pGHa5ScJSG4DHR6j/45ulKbgwalg0vReLGz2jfLMvPOSq6dcWKuwx7vq8DA3eXUw4xeng4H5LLcwGQc+9HcPnqINrRmTnpktOCriszA0vLwVyRrxvsLzbggRfvCbspeN05KSdqFsfzkXKuRC9N7hkP+nJXwpOMj/uarkY1LIFO0x26A4OfyLdvbQ81b1wsald+9m776XPjvhyPDjne4t0CQDvbKpU6ob1H3g8DC7QtvVmEvIHeJ6ndzkVRT6zJViOlqee6VcxfkvVGZTZ+uIrt2o+kbdkq9LumihoqYPx6QuthBspO9KDYz327I7+2MPgq1wMuux2G/bFGd9k41uNYMvnbm5OtcxEsPpYPXsLDV+yXH8pGT9CqR5WMt7UlEkMI/om8S1D68dJphDyHZlbXJpR2ebRYAdln/KD2E1U30bMpP03wvthFvBcgDo/Y9BafGVQpvRJgk1BeZ+Vy+fXRxQZ5oAFh4dNLF4zWfhuEencxZaprWwk4L5BUEv9n+3m+H/DBbwcfwdJN6phXMlyfdxdF9pm/szkr0Dxs5OIcVaNmKue6gvkgMB9Yh7winSfHG01Nnozy1j5aJCNu+Bz0puZbAzkfPfYVb8CWDVJosBaQDin72sQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(52116014)(366016)(6133799003)(18002099003)(22082099003)(261009223327099003)(261009221727099003)(261009221227099003)(3023799007)(10067099003)(261009220027099003)(38350700014)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnhJR09McDI5VHlmcVdyVnZiT0hUMVhCVnBwTFI5STB5WkljeG5WVGpxeG1X?=
 =?utf-8?B?NUY1ZVd2Qkw4Y3B6QUdGSHBWMzVVQlk0elJ0ZmdsZk15QWcwTm5idnl3MUwx?=
 =?utf-8?B?M2F6VkVLcDNvRnpjNWx0SXo2SGZteDN3bjV4elcvY3dQTUdtNUJsSUMzOFNr?=
 =?utf-8?B?VG42VGM4ZDVsekxsaDhnWFlFUWtKTGxUbTh3eXVuQTdMc0c5b3c2cjhRRGdX?=
 =?utf-8?B?MHlaWU1ZMFhCOVREUHpvSFR4N0RBeE1Ia2pXcUE3K3NHSXp1MHd5YXRXa1NS?=
 =?utf-8?B?a00yemZpZUNnRTlYRlNMR0p4VmRwZDYyRmhFV0xCNUVmYUxvaWgwSHdEMnZE?=
 =?utf-8?B?UGc3MTV6enpUOE91MmFXa2xSWW1jb29IaHVjb2ZiRlFwcU0wSHorbk1wUUoy?=
 =?utf-8?B?UVByY1NHMGF2UDFURG1EdFZ2S2tZZnRIY0VIRWVzRFBGdkF0K1h5dCszRy91?=
 =?utf-8?B?TDdYYmtodkpTWVhBclF4V0UwbXVXVTB4WkdEYXhveVNLWk9nelZxREFEOG5m?=
 =?utf-8?B?aS8wK1J0NnVxVndyZUJObmN5Z2FqK2Z0K2JlRDR0V2ZlVG5LUHVHYTgyaGcw?=
 =?utf-8?B?bllGTXJlVDE1bG9mSHFqSnUwNGJjYTEySXFDTzU0SnNhRXowNmoxeUdGMGNU?=
 =?utf-8?B?a1h1T3Voa0RpRUJodVN0Uk51VTluclUvbTVuRkdWb3A5SVNlTWc4dzN3THJm?=
 =?utf-8?B?VlAxOEtLMzhVek1RS2tDZTdkZVRPUUlvRm9rY0ZiUnRaM1czUU13SHp2TWRs?=
 =?utf-8?B?RGJibEhSbUQ0djVac2RBOWFpSTZacHd3czI4aE1zaE95UHZPaVdEOVNsOU8z?=
 =?utf-8?B?aVMrOVJsNVB3M0NRcU0raDUwQkpYanlRZkxJVGdSU1ArWVl5V0lTdHV1VDBH?=
 =?utf-8?B?Skt1ME81eXlUOHdUUnhlbThETDhMbzJNNDdBdWlIa2lSQTN5cVkrQ05xUGZG?=
 =?utf-8?B?T3B6NlZWekxRWTdXMW5vU3hDeDkwY1Z0SFNWV3Q3Rjg1NTg4WWd1bmMwcXhM?=
 =?utf-8?B?cnpjczZlOXRPbkRsdUZlNUNNK2VoTTQwMFVIeDJpZUlkYkRXQSs4UXhBSXBD?=
 =?utf-8?B?cm43SUNzNUdPYW1aV0N1OUMrQ0gxTzBFTWxjMlRpS1NYUXFrRXd2WDQxN09u?=
 =?utf-8?B?ZVE1OXRQSkFDUUtYbDBrcVRaNEpacHBqL3A0T005Ujk0dGFqVno3VTFyT2xj?=
 =?utf-8?B?Q2pieUpKRm5hekYrSGNOR1ZBMkExMFUxc0JXTTNKRkl0OUdXYk1xMjI1endi?=
 =?utf-8?B?N3M1MS9FYy95cmhSdG9UNHdvLys4Tlg3bW1oTlYyRHprOWJBOG1BbUszbDZK?=
 =?utf-8?B?QW45TWZ6WVgxS2ttREUvREQ1aHZPZWdiZ3cydTBoM3ZzKzI0NXJ4M0UybFhK?=
 =?utf-8?B?aG5rSkszVnhPRC9JRzBvcVQyUHVyU2JEcU53Wlk4TkoycXJjZWdkTE9TZkVW?=
 =?utf-8?B?ME9hV1oxWEVVa2Z2QndsQUdCemxUc05DQnF6eDRjL2o2Vi8vbDhWUzloY3NX?=
 =?utf-8?B?b2RqZGR3K3Vmd3VWdkgrNEx3WHpwUXd2ZWk4ZndhNXVpU0VoVGFkRWxzSGxp?=
 =?utf-8?B?ZkxJblVWY1FUSE81aTU4VUdXQ1VsVE84cWQrUzgxSmo4S0FPWFFrQnlYVHZo?=
 =?utf-8?B?VUgzYVgzalQwR2VwOEdOaml3T0hGVm94WkEyRldBZkNwVk5XR0hIZXVHZitB?=
 =?utf-8?B?dUVWSEl6SUNJaVRVU2FQSDJkSDQrQ3ZuVmFUSG01U3REUkdxSFNiSXRoK3Jk?=
 =?utf-8?B?YUhkK1oza0hBRXJQNHEyczROSHRUd1J4OTdOSGVFbmpXaTNSQXRIdndzZWxK?=
 =?utf-8?B?NkRXSmY2VnhqeWdVRHR0blArSTZmSHRKajY5alNYd2pzZTY3eE85KytJdlFo?=
 =?utf-8?B?WEl4djhPK2pVYUVXQ1lTaW5CMHYxMjJPWHVmUEdxRmFMbWxDUmt4a3F1cFJJ?=
 =?utf-8?B?amI1NVBVQ2JnTFRhUk9Gdm9ISXdJVDJiNm0weWxzVExRclVIQ2VXK3E5NFd1?=
 =?utf-8?B?UmN6NXhReVVLQnZPazFKVXl1RUpKWEo3MXQ1d0tNRGk2ejFMd1hpNUhrYkxa?=
 =?utf-8?B?VzVFT3ZQSFZ4bEZBWDByMVBmQ0lUSE42a3BNRDdIV2FoVDBRN2U3V2NiUVFr?=
 =?utf-8?B?N1diM2VhVDR4RlYrVlA5NHh4QW1DMS9jQ3I2Z0MydUFrQU5oSzlXbzlnaG1h?=
 =?utf-8?B?TVMxZVIvMU44M0lTMmtUUWI5VXdLQklxSTNSa1BBMTA4S0JEWFVqbTNYdDNh?=
 =?utf-8?B?dWI2czRRODJ0N1pVVFlZRis3a2lkS1k5MzVWdWVsd2tYYmpyM3hwQnFIWDhJ?=
 =?utf-8?B?cm4zZ2RpM1dQZzQyTklxcXNwcDcrcjZTZjJnTHdVRDdVZjJ3MkZlZTFyMTR6?=
 =?utf-8?Q?8yE+A8vlaztUB3LY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f55ae85-abb6-4b65-7dd2-08df284b9aea
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 10:28:49.7552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sb8AjoQ8iAIxI1KAEk7jNg9X99anTcDqkrmM1+eVzVqura+DK3JSq3bl8099gRveGQROOt6urM9dgL+Dh9R+dfsVF7FIPd8trKhtTbWfnUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11921
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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
sure the source gets it back when the target goes away afterwards.
Three cases, in the first two the target is made to fail the load by
lacking a device the source has:

  - the target exits on the failure (default exit-on-error); the source
    is stopped beforehand, so it stays paused until we 'cont' it once
    the target is gone;

  - the target stays alive (exit-on-error=false) and the source resumes
    on its own (return-path capability);

  - the target loads the state while the source is stopped, stays
    paused and is quit normally; the source is resumed instead.

In all cases a host<->guest transfer must then work on the source.

The transfer helpers get a payload size parameter, since the plain
checks don't need the 512M of the stress cases, and the target start
code is moved into a helper shared with the existing cpr-transfer test.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 178 +++++++++++++++++++-----
 1 file changed, 140 insertions(+), 38 deletions(-)

diff --git a/tests/functional/x86_64/test_vhost_vsock_cpr.py b/tests/functional/x86_64/test_vhost_vsock_cpr.py
index 035307fc82f..3ac0a80c5ed 100755
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
 
@@ -217,6 +228,97 @@ def cpr():
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
+    def test_cpr_transfer_target_quit(self):
+        """
+        A cpr-transfer target which has loaded the state but hasn't been
+        started yet may quit normally, and the source resume instead.
+        The target doesn't unrealize its devices on quit, so it must
+        release the vsock device on exit.
+        """
+        self.boot()
+        target, target_qmp_path, channels = self.start_target(
+            'target', main_incoming='defer')
+
+        with self.qmp_connect(self.qmp_path) as qmp:
+            qmp.cmd('stop')
+            qmp.cmd('migrate-set-parameters', mode='cpr-transfer')
+            qmp.cmd('migrate', channels=channels)
+
+            target_qmp = self.qmp_connect(target_qmp_path)
+            target_qmp.cmd('migrate-incoming', channels=channels[:1])
+            self.wait_migration(qmp)
+            self.wait_migration(target_qmp)
+            self.assertEqual(target_qmp.cmd('query-status')['status'],
+                             'paused')
+            try:
+                target_qmp.cmd('quit')
+                target_qmp.close()
+            except QMP_GONE:
+                pass
+
+            self.wait_for('the target to quit',
+                          lambda: not target.is_running())
+            self.assertEqual(target.exitcode(), 0, 'the target did not quit')
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


