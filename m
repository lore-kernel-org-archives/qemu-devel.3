Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E79CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 09:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tU7-0005GL-6S; Wed, 01 Oct 2025 05:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTy-00055B-DX; Wed, 01 Oct 2025 05:50:46 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v3tTm-0004v0-6q; Wed, 01 Oct 2025 05:50:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb88pBHiDarrXuS2ikmUDnBMU5dcUY8e5wqfZiG59+kz7n5UjHsLBFwwzMVn07DaNolD/vOjOolSCh5y0LbnmYIS+r76MC2BWPudj2gObl/NnYPfMtSSBwmRUZxCrmDwsYKG6z/NlKzTipxRcmJm/8ktZaUXkuRCu4psUIG8xujgPsKxHdNt022hkZk9LnkWg3H/toDWkgAt0h4aTn6P4SaVUD9RyNeoze3HikiSrJRpzYXQkMuxeMf2pWai/wlu7eX+wyPIb7nwbwzuJhOszs3srf+JD8ViE1B3AS55RYqfr9uFC4+ceHiMtCWwHXTn74DPOqRS2w7FTsDsrYsOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sHYEWan1QgxF0QhBohtxABsBqLmwjQ1F9aK902ezO8=;
 b=X8FxFQiTh3Zzqxm0C9ngCyfjTNPMFPkEfn0ElJpJFzNZN3w10E+6uJg74tS6JfHpWwAx2u8V/VwjSK58K4o/GdDd/Tc/V0VAT5c6j4FecKWDUuGXUOqfLPuw9B/8q7TYp9kXXoVxvm4x+nXXPyRh11aKmJluexGgDIj4ZI9q/vBZLfxf8yxIV7WDmbJEmC4pFPA5rMKaL6NNM2n+wM+3IE8bNl1BTeVwSxAf6ZWJlqgw47KT8LeRcxTtDcOhAXMQSd8moi5PArcLI3Bb85agEOX45nJN3Yg2mYVv3E5avB3sgSFJ3judsefe8pfzmvx1k6p0e39Wn5UM9tr4xt6tFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sHYEWan1QgxF0QhBohtxABsBqLmwjQ1F9aK902ezO8=;
 b=nneP22U2U446EWw9VMFmFtBO9el2mahjGI/DoPaNYWiP4yXA6+hNh1rM/j+fZIBMdkG0L5usjER36zp4ysrjuR/W5MeuAQ5C/Mer52GsaeZdQ4XSG6Of3a1UhiUn5P4pL2FBQ5p2G13G5Y4YlwQ/iGS/4cBiPfgfw2sEghH8T0OGYMI0BBFGQpVbtXiUAOQsNCOTNePLbRiuaQ/CIC6KZLRvokJ3SldGXKSkfbfZKRp3P5Hz/dipMlhCDq5INeK1/PXkgYcBn+S/Sj1d0ElIFGoObr/FodcD/dwu3tzCo+4XGujqZm0PIv+FruGHlMN+47y2sxrrhJatW+x2R6llNA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA3PR09MB8279.eurprd09.prod.outlook.com (2603:10a6:102:4b9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 09:49:10 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 09:49:10 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>, Djordje
 Todorovic <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v9 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Topic: [PATCH v9 03/13] target/riscv: Add MIPS P8700 CPU
Thread-Index: AQHcMriiq4KH7+Ereke3w7t99I5hdQ==
Date: Wed, 1 Oct 2025 09:49:10 +0000
Message-ID: <20251001094859.2030290-4-djordje.todorovic@htecgroup.com>
References: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251001094859.2030290-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA3PR09MB8279:EE_
x-ms-office365-filtering-correlation-id: 35e24c8e-b1f2-408e-480f-08de00cfc57d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?XnV6pFad1CMSgNhTjQkYrhtiFryEpd7mgKJuxuEQHG3imcUitVHdcX32M1?=
 =?iso-8859-1?Q?ffWlwmWTLfB7Bj5R6lxdPfUV4u3IrY3aAM5Xlycw9zO9bd4E+1Onig7HQR?=
 =?iso-8859-1?Q?w4eMyyRHWoLCEjZGN3T9yYO9La0Ax9LSd28DHO0UdLvfVtH4O6i40rS1sf?=
 =?iso-8859-1?Q?JNbYtCcrLzCkd0vNZHFEWGT/azabJcJd/79nB3hKwtWEO7Ko8jFpw2ltll?=
 =?iso-8859-1?Q?vzzEdaJmXGSv4DHKhz3Ax44FLjyTZxKb/+jyVKTGvxzmNdyryUq+lxUKO0?=
 =?iso-8859-1?Q?MoZxPZAtTT15Z5lQJ09H3YbGar60VKpLpePpwEfBkkTbn2vydAAWOZdutA?=
 =?iso-8859-1?Q?7qpi4XZy34XY9s0aDagb+04PWUajonW+xGQTfPG4a6AZF2pD2FwE5N5Lgf?=
 =?iso-8859-1?Q?FjE8V2QblbgwpWw8nCcLGqLtdxNuGWGC6zv1hJCMPaNEcnDgP3vRYFkJRC?=
 =?iso-8859-1?Q?VBBl6qNE5Q1LqYE8OJOuvyH5OvkMUioL54pZRhLQkfP//5EKIhQukbTMoW?=
 =?iso-8859-1?Q?rkjg3xKcN+nDXqPNLGZhMYMBOuQEDlphudGv/guAkEukrN1JGD9UulH72m?=
 =?iso-8859-1?Q?9GFcBcURykqkAoxdiC9HR7IBQTIB0EDYAPLMdOdbWtPc9RKEXF47wJCSIg?=
 =?iso-8859-1?Q?8S7bMyNUySLzwOVIy5mTAPU85PCkBeuzfMicuw8ooql7smlclXfvVqBwQ9?=
 =?iso-8859-1?Q?9PP/c6XvH9ykJwzYnf9uqnihhfQhJ+VZDcyK29kRv1inWErzJBcDYgI26a?=
 =?iso-8859-1?Q?Dm3+6kHMJtun6JBiSmraY3YtB8EK4fNd65fuIQ7glWPnQ0DsScCHSv1jeY?=
 =?iso-8859-1?Q?vLmM77FE7Er08paFgsVm0TrUwdqfd3F3O65IZpn3xcLeum3f7ZWYQEXNCH?=
 =?iso-8859-1?Q?LxlJ0gOt/pghR7zhAcKsB3+2SpQKPmVvbZujDDpjY4umHKfwhOFFVp22Se?=
 =?iso-8859-1?Q?kYk7IiMqVgf/whxdx2MECnGA6j+2q9SAz5ZEY5Di9bqUXny05tQlztWzB1?=
 =?iso-8859-1?Q?49HIawNg8I6BgDrKe5AVNr9zK/5yLwybenn0fZXQxOX8+9eN6yUu51tOkf?=
 =?iso-8859-1?Q?QaCHsh2uku19D4uZpJ3eGD7ydUoGu5ZKDivKcfTGRPajYyAaYi9EmTcFzw?=
 =?iso-8859-1?Q?+f3b+TDW1G7TFcj2hiJNSwLJBfa77XVSoCwobb8iNeDQcrAtaiaZJPGXTb?=
 =?iso-8859-1?Q?BNWqkPhN+XbQQCHVZF1x4evfX24UjxCukQZifqdkeGU1hgFy2S3BPad/cG?=
 =?iso-8859-1?Q?DfaPY0WYeYnrhikHz+Rz3yjMa0HtT3EiCSWRqshZ3s+2IpGirh1xe4NeVl?=
 =?iso-8859-1?Q?SBRo1DbRny+Fq5ia067RsocsxxC4Tx1HVwUaUi6b5iAlbuCDkhOFEqe3TF?=
 =?iso-8859-1?Q?13hcaIhZls/XiuCZ3+Ax4h+fo9qo+8a5k1BGiOPiyRowjn7Eg57qagXBFO?=
 =?iso-8859-1?Q?pG0V8Yeq6UOZ61f8xYBCHDBRoX1u3pnsSRJOIf2hM7My3L9xkXIVDZ66Ph?=
 =?iso-8859-1?Q?BYxbwXuiKv3GOd0lZhbeQFfYPjCE451gm9VFztx9ihiA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bnXY+o8pJJTj5HwG9ctem8psVIh3ptTPHmG3RaoakOFFWNuNhA1CKFrvpM?=
 =?iso-8859-1?Q?ufoWUnebVAy4BewxlVq388Pbqj6sAtBydckJAcd4yFf/7GD4axY6gyAZl8?=
 =?iso-8859-1?Q?UDc8obRLAeyhfi3ygHlOxHpyeYvLliBcMdL/oUsWbwMTrNHE8mIbke0Rv3?=
 =?iso-8859-1?Q?J7xuL04yqePTg0H7Z/WPc0NA4nFO2FV/Z1NpsrMFMwc56VY+VlYV9xpnDd?=
 =?iso-8859-1?Q?FdXk6o4fxQoxMQUDbnUxIRHl4SMWqnMHIFOd3lC0tgriH8FTglWllKCgQU?=
 =?iso-8859-1?Q?gCx1MdREeR5RWwtKXCs0Y9rHOyiSW5q33HRRjUM2l+k0Dxfqegu1978G5W?=
 =?iso-8859-1?Q?c4kVEIr9kwpWQFIfNARBwJTBGy05xquNstEk7L9OWAd/+nlw943Wf5SHV/?=
 =?iso-8859-1?Q?G70mNO+pawXYDh60t5pQTW4Nsc2aek+CQDGfEnUVwU4buKlUxnGcyrzPRA?=
 =?iso-8859-1?Q?jUFqz4hZQU6FcMeczfQO1YWvwvdk17Mip+FfIh7feZlSwEnAFS/GAtRf5t?=
 =?iso-8859-1?Q?CbHlGLdZmgP+GE6IaNstRvR3egCRiSN6ERFpWOYdf1Pgs1en6V314TphGC?=
 =?iso-8859-1?Q?jL1O0XAR2RiACwovmOZBaxlj/pdlqv8CGbX1Et0o/djNVk1XEZYc6gHMwN?=
 =?iso-8859-1?Q?GcS+hbkqY8KofX7kjwsS9T57jXhjX+dsU8Q9/S6fgABGKj1NezBjw5StO1?=
 =?iso-8859-1?Q?SPsXGMi3P3N0HWV+dDI8D3hjXGYo0V6GgDsRpmKWbCx1CuMaJgzcA4hnEJ?=
 =?iso-8859-1?Q?SpqWrqJUMCWlaPcmpP9CGtdqrYt5G49PZqQi/uuPu/4SUa1F8l/FgCEjFM?=
 =?iso-8859-1?Q?8N5HRaq7MHRGWGP8n3fg8iRTZhwR4IWBYG0bKJsyxjJmjJS0zSl2DeJW4Y?=
 =?iso-8859-1?Q?nM8F0cHrWHC/dLM1PPJ0w9YGA0c+Cqaa2+eZCWnr8r9NJVMF7IbTfMvn5N?=
 =?iso-8859-1?Q?fzyYYuVPG/m9Yk39alKQwz8vNo8V3dMHDXGpH3lKtDgBqk5Zc6IPZPDtYz?=
 =?iso-8859-1?Q?YsI8/juzASxrqrcLaXiXTw7KziX6N6Ohq8NpaKbJtOJGqXgOQewI6SUBqr?=
 =?iso-8859-1?Q?QvasU9bLPWwNAXFxpZv9MiarDnTfpgNDaiJx1tDNi9OQydh2QXMGaJbbaA?=
 =?iso-8859-1?Q?zutBdOYGYW9QJ5Wlk4pXHMPQkKp1ykSGQkHU7JaZB+ZSMldShmnGU5E9h5?=
 =?iso-8859-1?Q?AUqOUINTDlMGUn4nWAqCVNI9MvH1804X2B77kCrG7/+Q+rKyyBn5JE4mKZ?=
 =?iso-8859-1?Q?Sl/BuXMeodwtk2TNQsWzVjTIpguHDeVtY2sXgcQrSnR9YXeuP/7Venh62A?=
 =?iso-8859-1?Q?xGzn69uqkuo/z9e9kW657Gh91WCEeIcoPcpz5j58SLMZuDieqQNeZZ1i8F?=
 =?iso-8859-1?Q?rrRxjPjjFgGkKQz9IJmBt1iRzqOqGTHkZjJTzAvPgYMrDTYgjNN7v9YrRt?=
 =?iso-8859-1?Q?2zhXXrIem98CDZer9Mx7cxu158GEACPvrW3K5W3MgLhidDrw+Z6t8ZkEsS?=
 =?iso-8859-1?Q?m+Eijm+9ya2QaEfoaJ9u56lFZWTZwyWU04PwCr2brU9xAddfAx9JHh0NSS?=
 =?iso-8859-1?Q?ABbhI1cjAmIb8ywQ6PWqNvHat2RXxB99rLqoIrdsXuju2Fdg8MSHYxVbfi?=
 =?iso-8859-1?Q?5V+bElf9qzp+kHQ8gAj4fcKNkXeozSwGSmkM9atHnLFh3bJOv15AsQxt7S?=
 =?iso-8859-1?Q?SSU7Alg09CvFduMuOEU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e24c8e-b1f2-408e-480f-08de00cfc57d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 09:49:10.4483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E9a4Aefd5c4xsVbyJSeAqiw1UJTxquY2DEvwZz1m9BKs0gpVTi1KTCYZOpyO6JMGkFCs8Qtsodr1cDRlKZZPe9JZzHQCFFRUu4F8cGemWZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8279
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce P8700 CPU by MIPS.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h      |  1 +
 target/riscv/cpu.c          | 16 ++++++++++++++++
 target/riscv/cpu_vendorid.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 75f4e43408..30dcdcfaae 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -56,6 +56,7 @@
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nan=
hu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kun=
minghu")
+#define TYPE_RISCV_CPU_MIPS_P8700       RISCV_CPU_TYPE_NAME("mips-p8700")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
=20
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 74728c5371..6e0bd6b798 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3281,6 +3281,22 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.max_satp_mode =3D VM_1_10_SV48,
     ),
=20
+    /* https://mips.com/products/hardware/p8700/ */
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MIPS_P8700, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max =3D MXL_RV64,
+        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec =3D PRIV_VERSION_1_12_0,
+        .cfg.max_satp_mode =3D VM_1_10_SV48,
+        .cfg.ext_zifencei =3D true,
+        .cfg.ext_zicsr =3D true,
+        .cfg.mmu =3D true,
+        .cfg.pmp =3D true,
+        .cfg.ext_zba =3D true,
+        .cfg.ext_zbb =3D true,
+        .cfg.marchid =3D 0x8000000000000201,
+        .cfg.mvendorid =3D MIPS_VENDOR_ID,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode =3D VM_1_10_SV57,
diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
index 96b6b9c2cb..28f0ce9370 100644
--- a/target/riscv/cpu_vendorid.h
+++ b/target/riscv/cpu_vendorid.h
@@ -2,6 +2,7 @@
 #define TARGET_RISCV_CPU_VENDORID_H
=20
 #define THEAD_VENDOR_ID         0x5b7
+#define MIPS_VENDOR_ID          0x722
=20
 #define VEYRON_V1_MARCHID       0x8000000000010000
 #define VEYRON_V1_MIMPID        0x111
--=20
2.34.1

