Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26932C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwQ-00038J-H9; Fri, 18 Sep 2026 09:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwO-00037M-9s
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:48 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwM-0003Df-Bt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBSgvfenjGFUGtq6KVIOKlnbQUtRjdy2XnWir3qkRZa01uzXWbwi2njsH83uMw3Xn1ytWoTj03py1ZiBpjTbCwbGKVfyVHiS+CAFRhKUoCfMUkhDPO9MnkLk/nzHITw+WsGJQEyjA/b6NyJ2dx4MZeyamJYfFBel5qmYgWGkuKkeiteHUfQr79q3EvU0YfC3X/K795klvuR4hxWUZQ8k4jOEY7WkdE8H/s45U9D+3mpJOkA7+2zZAjXhgKxN/kRRFvji0W8+W5faOCz/DH3KiZQpOY30ffz+XuTzwaYfixTR9bjDssy9A7Z1kq/l1Q8G+2wjsFVVwZaPTkyB28BBSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/btqmLLhLY5zLNFmM6XykIvIxv9nTvzD+HEmHnMwKc=;
 b=xM4P96bvmavYgDBb5dqkgJjMBk+apwr7EYR5O8HWuvKdMMXpXtNYGz5jlyCCGHOY+QQghRdzsrG2MguVjD/pk8XEe8p/Bx4s2HUsZ7+WAurVoEUWGwmHYSCBb5/vtKQR0bUNFSFedlYdiZMVtWXKa0ooNINSkqDDLuibJSTxPLT2fdXdf/8CdMORSJZIK6qKFWvsWuLQO8XKB5kKR0zyGbif8xkR1T5NpH/08sT+u9vKhOwDUgvWDWVWnLGZGtPEBr97lcIMj6s7XrJTjw7N3/01/vZqtNoQhFuzAJwhz3pER9PJF0R9ZKxxDok5p9hSOF7rcFH6KnHEV9u0CBuSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/btqmLLhLY5zLNFmM6XykIvIxv9nTvzD+HEmHnMwKc=;
 b=tASsbpps92CoP/5MZFPFyA12ynGMuyMebrPZjUkHLk60oi+8p1dAr37v3WJmamcwjoT58qXwAR7L3atMcijyEW4Ik5X4Y3hnniYiziwMWA0iuMsLM0nVlxFJLcumZkchIur6I8arJ1XeFumMBUNUsA0ywFEDnv9Tl6x/ZDJiwXQnK+Yo/T/K0R+284VxGCSJHd7UaISwDU1unKSk0ZXu8bpMFQpa9UVJhaPcrpfgjMUZ1ejb54u9X4MMLFMSnHiyUCRW+s4jaCsG4HZ+LLwm7FKaa5KYjbgicYSbZnu83sOOFntkYGUUfgpodRlp4WQGuyau1StaGYvakHQvIgQbqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:24 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:24 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:00 +0300
Subject: [PATCH v7 09/16] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-9-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0c6d15-f127-45cb-2798-08df158b5e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: yfQmWeBSAS2OnXY7ZyNvMaCzOtSRHuEu6IiuSG3aAlPNZFAFDIiEOvYC6r5Xx0qyr2vhlUJOymYUZD+RK9DwRn16yDcIDfstEAJctw669veNFowMel14vdWsvC2j63hyfVxpymFFqGKsWnEioFHPtv3UmtCZURpaTc6QvA6+S5G9zCygU1iWwcd0sTR0MAxFg1xBteNbm90/KvjNfuoeiNTsC3UQa5wIaMhdiXNb757lZEPZnSQzdMqyzD1LIBbM5uWR+Upog7ADhxYQ67bqmWN3j4zN8mdkLf0IfWSp+R5WPxnhBUQde6UVwP01y/IgoXitdg5Ao8l2a4Di3CnIEPgmHGGBTvYjmOGr7IF0u+e+C2mwEPQWsByMr4yCXSIGFbf7PERPjGEB7IwsfNIgM5qwEoZn8TZGFat+OgtHegdJkb+C1Wi4Anqkj2vNaR8R+E7r4qYpYS2WLs08bwlU73MPQr5O+0JoQU/0MzD9/Xd3xg7wpetUrdG4SHA6cVxkr1t2kchzHNTwe90tlYagYJfdu80tmh8PHN5GpBK6f6XRWT08JcIon+IhSOJQHbW3IwiJW7UBjFCWngWPzgcd6eEri9wcOkLiWXhpXULoCQYZiGgwQutc4BxxXcxJtlnqlEbZ4jbzg81SF7vDs6yOAiMBVKaa81TkKj9ruPRcaRmJ/B5wcMUcSs6Egl1px2rlGC8+or2b+WqXw+Uzm24y3amKJPF2lZoPv/jeSp1ojzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFpHVlFvekN0SUFTUEk1bmRveVlnODBCN2YrTFBxc0hndFBmeFpBZlVrVU1h?=
 =?utf-8?B?czF5OWdoM0kwQ05TVXhhcU1PS1UxWnhsL1grQ092ODQ4dmN5MFArU3RGNVRt?=
 =?utf-8?B?Z3Fmd2JZWDNxRWVGTnp3S3drV2JaR0EvN1VWUU1EOTl4Q05JdWphamkyTVIr?=
 =?utf-8?B?cFRmWWFub1FkQ2hISjV2Y3ZkZUxFWVJkM2NMc2k2WFE2bmp6czZneTI4SUs2?=
 =?utf-8?B?VXdXNVkwWEhza2V3SGhUU214QVY1V005THp0VCtJRVNYRDd4dmRxeGlOelJF?=
 =?utf-8?B?ZVliVkpOWEowcjVXRW1JeHJwMDFDVmtER0xGMm1lSThCN1lxZFpVanRXTVVW?=
 =?utf-8?B?NkpHTjVNd3dieFdWMFdCdVVtNlM2N0VYZG52ZVdWaGsvNGlOam1URWJmcC9l?=
 =?utf-8?B?RjhlRHcwcUJHcnNyVVpnZDBlbWlSOU04YlJrSUhLZHhkb0sybWc4MDVOaXVP?=
 =?utf-8?B?TGFDdXI5OG1pdTRPTHR1RHAwbXlJUEczaWpjejFlTVlkWFMxSE91TXpPMnNN?=
 =?utf-8?B?b2h2Y3BWcUZjL3FxeE9MTlVpUHpIdlladFFZLzhvVS9ZOWQ1ZmErR1psK0dV?=
 =?utf-8?B?VHpMR2xFbFA5TFdMUWNybHZ6R2czSm9YMy9IWU01N2JZNWh0aEtVTDFVUVRG?=
 =?utf-8?B?cEZGakQrZkhud3FYbHdBckxmOUdoTnU2bFpGM1hLQ3BpWnVVWVJBYVU3ZGZI?=
 =?utf-8?B?L1BwazNkWXFuNVpTVnAwRm9mZHlqSHM3dXBmVGFNVnBUMWtwSFF0bVRYblJ4?=
 =?utf-8?B?TlJta0Y5bDZETjNpY3RSRXF1MTdaampjbS9FRCsvcUt1dEYyVWgyaWlxRlY2?=
 =?utf-8?B?NkJ0R0FjVFhOMVRzMmZaaFVmbFBlY0xKcWMzU0RxQWM0dmZvT1o4dk1GSXEx?=
 =?utf-8?B?aXNsN0tOdVpPaXF0R2FJSWJzYStTZkZzUnpaMkY1N2ZTK2VTMHJKQXZ0VVhv?=
 =?utf-8?B?WFA5cjRlVmZQRWJ4VDJuMU91L3hRVWNjY3hseFl1N3BGK1hhNTRGN2Z3WXo1?=
 =?utf-8?B?TW1YamdaYktrQ3NJMXBsYnNpWmNBNUhpTy9nVklRTWg2ZUdLWTdhakRqMVZP?=
 =?utf-8?B?Nlh5aDVVc094cmUreWMyeEQrYmJyUWtRVVFSaytXNk5LSU1PMnBWQkJqRks0?=
 =?utf-8?B?Wm1DL091Zit3K1crKzNhN3F6VVcxZGhYMWJuL1JWVXlNSFArQktyaGFjYXJB?=
 =?utf-8?B?L1o5cFAwb1RGQ1dvZXlTNWNLQ3JVa1hzVnFWRXg3OVlUYlRna0Y0QzB2U2sr?=
 =?utf-8?B?azZxNWxQVU5tVy9sQkpSQ1FlVG1oY0xSMlh0Z2ZnQnRocG5LS20wMHhhMmJX?=
 =?utf-8?B?bXl5OGJydDNCdVM3Q3BnbnNwc1VINkdKZCtWV2M0VGdsTmMzUm04RDFUZnYv?=
 =?utf-8?B?dmxyUGV1UEVyVHlra3lyWEpYQTRGdmhmdS9zaW9OTDQ4MHJJaHltcmx1TjFi?=
 =?utf-8?B?b2RiWUhGYkZlMFNqK1o5ZHFXT2xLYk9vL0NZVWFRUi9oQWo3M0NYQlNDZDZs?=
 =?utf-8?B?S2NCWVR2dDNFUTl4Yk95Z2RIczJiSFE4RGFxcGtOTzR2VkE3SmZKSmEvWjd6?=
 =?utf-8?B?YktuY1JUZG1zaitFWGhTK3VtdjNDWXFETlVpMytxUGliNUpHdWU4VXh1a3pa?=
 =?utf-8?B?YXQ1b3NsUnZvaysyVm9xNXV2SWlaQzhxR2FzNUZPZ1dmNWo5TzJVTEhac2Y2?=
 =?utf-8?B?WlVmaHp3REIzTzB6UnVWRnRsUWRuWTBxZzdueUZlRDBQN0ZUOTFKOHdBUUI3?=
 =?utf-8?B?MnozMFp0NG8vNzN0MExWZlYvVXJGL1ZCWXpvM1dFRVRlZmVGekdZamorRjZB?=
 =?utf-8?B?WlVhUk1XYk5Icm9vUzM4U0kxOEQ5ZTFmdFF1OTNvZVpLUkt5Qm8reHIxQ0Rj?=
 =?utf-8?B?elR3SjdoTFNFcyt3ZkNMa1ZTNEhJS25rU2pZTmxKditaNGVTT3RzTFQ5Mi9j?=
 =?utf-8?B?MzZKT0ZqSWE0ZEFhSU1YL0ZmQnJzaUJ0d0p6ZGU4MGVVZVoxRlZJQkUyWUpx?=
 =?utf-8?B?ZmF4TUVkbVFrMzNpV0M4RXdJUm53bGJSTWoxZXRPZG45cXVlTFpiYXVKbDg4?=
 =?utf-8?B?Qk8rTHRuTlVKbldqaFpuVVlCaXBydTRMZmlhTGVpdFAxZVZYKzljc1lwTDBi?=
 =?utf-8?B?RXV1T05ud1g5ZkpJdFRXOTlRNG50TEVQdnpibzVvdm9qd3ZHM24rVVQ4WjB2?=
 =?utf-8?B?NmowS0tjWDhtMnR0KzNqMnp1VEZrYnVEbU1Kb1FJNG1rSmZtTFhPNXlZWlNT?=
 =?utf-8?B?MXEzdnVCZ2MvZUVWZnIxdmx3YVB1RzZHcy95ZGpxdzFNTkN1cGwzVUFIKzFH?=
 =?utf-8?B?ZDNvYm0vV3h0eHhoVFFaclRIbzYvU1pTYmJ5b2lYM0pUNFF5V3NWT0RPQVJi?=
 =?utf-8?Q?i2hLWHFNm7LRJIyY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0c6d15-f127-45cb-2798-08df158b5e32
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:23.7119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCxJREDAUJ0s8UG9PuMGQcA9q6RCXxKzp5HfERZ3XphMSvUEA1SsRU25JnlYvrcQbgPMKPrKQU/BHWXuPY3yIPtYnib30b5bsXtRI7iN7q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..6e89007b2ce 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


