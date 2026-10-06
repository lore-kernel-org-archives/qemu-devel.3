Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C2CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN1t-00014J-UQ; Wed, 07 Oct 2026 04:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHhR-00061P-Uu
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:29 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHhI-00049B-NR
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:48:06 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rw9Pc1/V75ktJCfDIHuCMjs4C3hUb8GJatAUVbXPSD2y9AjV4hrXQzWzihplt44ayjvh9CswlUS6S+q0v7yjdirF96AMVPReg55jPGIiGU8KWU+eyvA+t4OoUNsni8UldEe6slphJS7bfHPo+PNviGwOsJn2vMHcLCF+sHB6V08Yol+axeI/IjrLxtGd16JCjIDix4KJEtp04+KzqT1/MRUvdd6kc7h4c3bJLj32R2V8bCuUP5dNdrpeOCyqhsV9twe78mAfv11tgwyYGBrnlKwSqW+Euo0UCawXhiudlWfD94giztqoVA/lXVeZf6sPsbbWfNyDql2dS9MJmCv+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=DvQOu5M2pcyEeRpsVafOYtQIiedqdJRvJUHJTCiciK7qi6pslyXOZkyKdAduoGZJ9IHA0jycluBPKG2iZVtdgu9MheHKaHfcKm41c1RRjpOmYB6BwzqNHMORvoEzWOqFlK44daOkZsQyQx3TI4Swg4SR0ueE5KqU2ON3hF+ijEL5JnUH7WgkEqN6OxKaOG8hYYbQzI1S+2PJyZJ2R4Vdh+Mkt3SeDqTyQlRZLH48eyXefWKhPfpoWkPzPs42sdXfs7FvLS1JJDDcEmT1yrdy9IOXRWV3HYIl4ZgWeZny5dEm4X2N8jJUiajICLpyHixAAMVcYulz34tQmiU7dz/TMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=S2kAG2M2qFf0tmsAZS5mc5rkRHl8XCSWrpVl8Iqy4lvxC3HZSNylmgVod+z1WF7lKwTtUL/n7q6HjPZkAmp4UdMXjJsF3zDCEgDLA8fJJkpkkzlXo9+U3rJeKr2r94nRoA/1EpMCRvwik5C1kbQoFHmMwQ40dj/3toyXJ4WnYOKkuEpW6RipgmuEHUK3V83vWTwYSuD+na2SxeC3pbJJaEU4elgZ/Fs6xMDcNmYyLUrqf5N4uNG/DZIkg7JbZEh/uhz4Z+YQveuwm/MgDXWPp7EsZ1dexKHvtFoYDrgczyzAXnNhb778ssK5n0wOjlAW1kkBcmSWkfcBGKqg1blD+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:59:01 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:59:01 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:42 +0300
Subject: [PATCH v13 19/22] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-19-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f171c5-41aa-4858-4e99-08df23b1f997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: KR9KmznQMkIoB1Udw2OBkYg5mXSbs9oXP7NECadhP3obdJ2bV9vXE4JUeIShRrLzWJV+m9psgrtx+3+a5jlWjrMBjOA4K6t+oRbvPeH5RwEskOAlIv2nWoTSuh7tD8kqam655BD579nfMT6MSuw6Gvbvn4SHnqllggTvSZSz+oPOGP7WkoyYprYD5yfG/wOJEBklFzN56+T8cZrDjkSETpmsn9EAaGrtrv+/QviEKWf2qINx8c7ltjat+/fVAXfn3IJkz7GZphXF3+DySjUEf9lXgrqQcYpJ3g5yB5lsuFBSbg9mIl8ZnavyC8v4vj6q2IzXwaC76m4+yAQwXrH8XFsbaOINJI6+iktEwJJqUFiigb+gPZXcP9WLKuw7Qfc2PbovYrP2DD0zcKdDityQOrlz7fkSVkXZvRYZtL0Ggllt4QAyeXlglSKtZPT9PgQch5UhA5nOLKn3Xms9Nyy9lYTEZVW2C7PzywhlvjPXFcX7eip3anbqeXUts/d507iCNsxtw0lX9lffpadzpB/bHW45ctwHbxvXPrb3EISnoAPT4FSPUiBZA6rtBcWsRXM1BwQHfegIeDf0H1dDIVpvfa6+h6iADF8aqf3GT40wmIgAo8mtlTCHDCcbGBr6CIz5gH9jVE9J7HmVIedgPrA0XDp+6C0shq/hpj2atjVXGmgL5VgZA5KcM+2Fs8hLQL7olwmfvKQrXuT5NYVzNbKOkiiYk/nYyKTSOeyilIAdxMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURtOWVIZmZJWlhINUJKU0ZTelVKSXVFa3drVGY0d1dhdmJ3VDNXcThrZ3JB?=
 =?utf-8?B?ZHdCTGJxS1pRVHh2bHRTZlZhaTJSTHVpWCtuQ0tXYmVOek5LK1dla3FxWm8v?=
 =?utf-8?B?ZE9VS3FEbzYzZElhcEpMblp1eEQvV2tqZkd4TTBwYmdUd1FYcHBadmlpSnF4?=
 =?utf-8?B?S0xVaGJNMnJZRXE4bzk4Vkdvc3haTTJaellROENVWlkvMEMwazJKNDE2VmdZ?=
 =?utf-8?B?Yll0eXZ4dzVLWGRzSzNibjFHSmZhOVlBMGVTRDNYTHU0VGNwTU13MXhHdVFR?=
 =?utf-8?B?SHVvc2RqNTlCaTZYQWVMdUtwS2djZUlFcElCSGZJY0RYU1M1OWF6V2tlZVM5?=
 =?utf-8?B?WC9QZEJycU9hbDBMVXVrRDRFZmluNm1BVHlJdlZZUWVqWlJXK2xLcTJEVjlK?=
 =?utf-8?B?MTFnWjUxOFMxM0xEOFpobStLWGNVVmU4UG1aM2hnYnlQd1d2UkhNdnI2UE80?=
 =?utf-8?B?a0dBTXFiR1pIRmFNNk45QlYvWkhXQmFOc3Q0UllQbFVLaVdIZEttMGJUb01a?=
 =?utf-8?B?SE5QRGhsRXJXNTN5cVBQdnFuY2lHNjhNcUJGTlU2aENaVHdPSG1RckovQzZN?=
 =?utf-8?B?bnc0c1k1Y2VTdjN3MG13elh1QjNJTlJPUHRXUjVUK3NrWTRwNlJjMGovQndI?=
 =?utf-8?B?OVYrSVNVVFp1djJZSEQzWkRoVXVkTVFOenozWThQZnRhd2xYUDd0UkRmWHF5?=
 =?utf-8?B?WWQvZ3NKWStkbmhwYzhidGo5bmlvWm1QSmZLbUZ3US9GMDlmdUVQcjM3OTFI?=
 =?utf-8?B?ZVpFQTgvKzdWbDRCQjZpR1hkSmNMdFNvdzBwRU5RVkZtRGFwT0NDaUNqWTBa?=
 =?utf-8?B?UkhUMFc4aExCZ2gwd1FicDNYa3hDZ2dsa2t6SVJRd3B1c2xQL00yRnJBSnVT?=
 =?utf-8?B?ZEh5c2QvdmY1clpLNzdENmJrNDhOM1RZQkFUTjZCS1NNelpUMUlBOFQ2U3RV?=
 =?utf-8?B?dmRnclMzekVYcVFNUE5NajJCMmxqa2VISEE5ZkdBUkhkd3NHRzh2OHg5aEZs?=
 =?utf-8?B?RVpoMXgwR2Y3U1lLbjhMYzBnSTdOczRQaFpuSC9ycXpWQk81cFdMOW8zcnNt?=
 =?utf-8?B?M2NHYVRJbkY4c1VhMXBLaGZTaFIvdWlTblMyMTVjYnkwSi9ObU9tbEJBeGI3?=
 =?utf-8?B?Z2pXVm0raDgzVEFjRWRYTFB1cHc0WlNvdTBvMGxmOVhmL1dFVEVkdncxMEFT?=
 =?utf-8?B?OHczTmVGQzlOMnV1RS8rdEp4RDJtdGZncm0zbFNuMUZUb1doWXlKejhqbm9n?=
 =?utf-8?B?Q2g1blRlTWk1WWhSZnM2VmVrd2JRcCtvOHBsdVJPOTU1R1dZUmRTb3FaZHZY?=
 =?utf-8?B?RjQ0bTg0T0U3THUyalhxQlRqK1JOWU9GV0xmNHBQd21mdWdOQ1hwRWFsMnlq?=
 =?utf-8?B?RDVUQ2F1N1ZDbGo2VEY3T1ozTVhxb3ROUytTbmJhVHlTRll3TDBOUGRtWCsz?=
 =?utf-8?B?YXZseFVIMDl6NlY3eUpRYndIWGJpdS9vOEd5cEsvMkg0dFVvLzlkWlFUNXRH?=
 =?utf-8?B?cVlUSFNYVFV2TUdreUpGSFl6Y204V2pxYnMwYng4NWcxWmU1aEFwb3hHZUcy?=
 =?utf-8?B?aDVkaEU3OVpnTUUwTGhseE1lN2NueENRZnhUTzBYR1g2WVdSMlJLbWVlT1pz?=
 =?utf-8?B?dm1MY2cwZlRZMzB2b0RSaWFhSlN2bmlRdlVrUEVOYVhJQ2xvYU5sWFJudzEv?=
 =?utf-8?B?eVFnRGE5djh3d0VZR1F0VVhKQU0yOGd4MG5rYlFnaGFBUGYxOW5SMUNLVzRL?=
 =?utf-8?B?MUtSNXFyZ0R3c3R0azJtQmNGaEJaTzBqTmRWK2Y1ZGQwaCtQOGNGbkZ1QlRu?=
 =?utf-8?B?eW02cW5yK2hTd1M2emdKTXQ5V0M0Mm1tMVpCMGNpU0FCZlFQMHVHZEswWE1s?=
 =?utf-8?B?TkZHclpQd1Fic2h1d2R1bHQxQWJkczd6bGR2TDJUUEZFYnVYbkZ6eS91TTBj?=
 =?utf-8?B?MEljbXhUV0czNWVXUGtVMVgzd2ExWTJGazQ5MkRTdU9kWmJGditXY0piVmtq?=
 =?utf-8?B?bzV2RmZJQzU0V2NUZkJjTy81cjBPSStHL3Vkd2U1dUJRMCs2ZmI1K0hvSGhq?=
 =?utf-8?B?eDZjRDBrbWZydlpUWEdvUnpFV3UyWmkvWmRDMkZBQkEzK2FWc2JqQS91UFpV?=
 =?utf-8?B?Qit5RkZ3anBZRmdVRmFaV2NpN1BtS0VZQUZvRjVacXczeUJhSm9uc1FlSzRn?=
 =?utf-8?B?NEhldUgraFp2bHlQKzEwaFBYZ1MxYjltVjRSSlZEYm45UVVLOCtQMDhkVnZO?=
 =?utf-8?B?NHpTYmFqQmRzTHhHbHFFVnNjTGZZVU83K0hNNjVMN01rb3B3S1FkNDIyY3Vw?=
 =?utf-8?B?cTFiNVBMYzhBaXhDZFgycEdVVUFoYWxEcnJ6TXNqRkREWVFxeE5nSVVBdFJi?=
 =?utf-8?Q?uCb+EqvWYEiJ8ns4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f171c5-41aa-4858-4e99-08df23b1f997
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:59:01.4980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4vzdM7j8+HXetcd/p+7bUi3iZR6Q7ayUsc8VXTIDMMXOXiBHTZGVV5GbCVupnVsHxjUilSGaAu5VPBzDWIyFej7xkD3fzhkq/oEu1q/v2zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

The previous patches reuse the source vhost FD on the destination,
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
@@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         if (cpr_incoming) {
             cpr_delete_fd(cpr_name, 0);
         }
-        goto err_blocker;
+        return;
     }
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* Register the fd for a future CPR after a fully successful realize */
-    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
         goto err_vhost_dev;
     }
 
@@ -247,22 +348,18 @@ err_vhost_dev:
     }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


