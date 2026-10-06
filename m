Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC401CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMxP-00064v-QF; Wed, 07 Oct 2026 04:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHlc-0006Ty-Re
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:50 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHlR-00054L-73
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:23 -0400
Received: from AM0PR08MB286923.eurprd08.prod.outlook.com
 (2603:10a6:20b:804::5) by GVXPR08MB10587.eurprd08.prod.outlook.com
 (2603:10a6:150:15c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abIccMP2SoiB8zmkmYvadblMkIJC4K+po7ZDriS8RgqQTy78UuSsh6SR425cJd+wGiuHaZyusUbGkfSZIaLvO8NPiZUw7nnxbARBidXxq5FofRnXlokRDNV9NmsXc8Z6o+MyTSlXCoDY4m7EAC3eBCdO5VYpvV6ScCHoiiW3tenHIaKY0WeryK/8U0+9Id5RzACK1ZS5hha4XjpLS5WidsHsfvYLzVqf/Wgwk+Wr7bt9jtauQfMcwwvgjvCcFkNsb5Yw8NhoFFkdkNgqZfO1awD0ReziWqfJtJUzWNMjcRVI0/u510A8Eiy0AEVwE+0T0rKS2vmLFVLBvslHxRi58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSYvis4evdcYzcKJQUyoAUjH/0QlDPOzhF2pDwJHL2g=;
 b=k0XIr90lP/OWyWQFV4CvW1TBML+WjKdx/AZklLqTpbWnmDGxi68TgtYQ1A6JhmKIB9CwUlH+GqHmCOurnQRwuA4EmIexKpoV3QbhdbfJZG0BGOFGa4Zrin3a6tINlZ04jTA+bnQKy5Sy85HwxyCdx0Lu01eLsdnVp2eD9XkSovfX20jVgaXzWreaBe48E6X4DrTW6orysJMTymxkqq3kk3pqLIYidantEP6SPpGpQgl/HRbiyBPizG9hxk6IUTSQH8Bj5zmRIXDGAbvXA6DPRHBo3JSdHZvWA0KFXbP4554swqyrjsmAMUPY60N3KPAp1nn0mgKNDA6jyi1bdprWWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSYvis4evdcYzcKJQUyoAUjH/0QlDPOzhF2pDwJHL2g=;
 b=Pb6FXI6zedWQr+CIhVfnTFEp9/dKurhtred3F3idLEqlRbkSBK4fVzvyzO80iRchaMb0Y1X5W5DlatC/t7Zm62tkiBpagIZIqLSw9MH7utFZJ9rROablAt4ZJGOZ2dcyhlJENVenKO6sp1PtklF2cAVh5AdHX0anMmoJqhqepjqu2PGzz45OpY18JexB6AygnRZWuiIoFdMvZ4yK89oD3lJMOPK9GV44LdjF96LBBB0OKrqJiK1/moJg4L1mFNDZ9G4WUzT3YnD+ZINXTuQ6HezGfm4ItyDFdEu/o83AW0UtaBzBV3QCttVJEc8tkHtm/Zh5opH3hWX+/C0F28Mijw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB286923.eurprd08.prod.outlook.com
 (2603:10a6:20b:804::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v13 00/22] migration/cpr: support vhost-vsock devices
Date: Tue, 06 Oct 2026 16:58:23 +0300
Message-Id: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH/+xGoC/23RwW7DIAwA0F+pOI/JBgK4p/3HtENCYM2mlSqka
 GvVfx/ppinSLHExsp9l+ypKnKdYxH53FXOsU5nysQWoH3YiHPrja5TT2D6EAmWBwMvzSdaSw7u
 sh1wWWTsZnMdBU8KAvWh1pzmm6fOOPr/8xOU8vMWwrNCacZjKkueve9farXm/PhrGbw/kiM4o3
 XlKxj/VaV7O+XLJjyF/iLVHtVul4xTbFDNqHNQYbJ9GTnFbhZu1uqbYmCgm0DrojlP8RlHEKb4
 pqIbQdgaDNz2n0EbRwCnUlEhANllFzgGnIPwxCIAcg9AcH4CMNzqSH1gHt45iHVyn8qkHGr1ym
 t0wqq3DHgrVeilAqzRBsP7fdm632zc8yZiluQIAAA==
X-Change-ID: 20260908-up-vsock-vhost-v5-c781b39f1c1a
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB286923:EE_|GVXPR08MB10587:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf5b490-3947-4253-6b42-08df23b1f1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|10067099003|56012099006|6133799003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: OoA5CXnMHzNe8DOPk+93Q+zePowuTAFmjbYjY6rwbEnPAim/G62D0nHwN4wtqpHBv71bnqFpR3XkZO82BYrWQ9sn4FX2nP9sGd74qZdXWcLrluVzFhh9tPWWnHLOAvrT9j+x6wxxWHMzB2yNv08HPWwndkHe3+lD3wZzUPjE69k5PPgWA2A6YS10r6oIKCut93m71+pHdn55bhng2wTOS3aAkzWXXb/s0KsN/3f9TLwSk3BHUpnS8NP7z6svXcvdcX1bIA9wLF2IXXo3r+DFfvM9YV/3GOaHOKWgB05OTG0gbbBMkyYj1Gh/trbeDjuS1g8AtIXEjRAmrGhgB731esaQedahQriCtymgJ/nmPcq3zDGp3LSa6uPAlSGAvjBClf6nnwqyAiB9/Pb7/tjYQg+mMOzVrz2LJiLokFAbz5fD0lSb2IEBYQyLlW2dqXyxqqIWBdY9vd+8tV7z9odSUHSvv/YNdVQpshZwysjEe/lV4MmLn74Wr1o0Ru+lLFIwtfwJ3MydXpMEjcS/LAUskjxqmIwbziv+Oxzkc9lr52TBKBDhe0qR2dPaBuPtsA/8Bf1iR19Wwa4sGM+6AAWBFlvqCHDReKGqCuZlEia8sOr+BfVX88RLvV5TJncxHemDYr06VQ6QXZ6g4YPA0IHtRweVsN41H7VV34hz7L6h/C0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0NiSXhrTmZRWFgzSGhHTGIrR3ZhT2IxL2tLdWV2UGxSbXFEMGxGRkllaXVR?=
 =?utf-8?B?Qlo4cjBZUGFrME1ROUo1VjdMemdjZjhmL2FrMlJSZnptTVpkT2M0SHdVbHNS?=
 =?utf-8?B?YU9EU2owdHVIMVB3S1RHKytteWtBNyt1bU8xSWh2eTJ1V1FHMFZ0TWVyeTJa?=
 =?utf-8?B?SjNWSDZnV1VMM1c2MXZyWStidW11TmJLWlBwem1yNE9NTitlbjRnNG5wU25N?=
 =?utf-8?B?OVlWU1QwWTByU1lFczJuMkdPSFVIMUNuTm4ydEk4UmZjcDY1ekNBeTFCVHFv?=
 =?utf-8?B?aHh3cFhjci9oSUY2VWVUOURUNGpITXVhTVlURjFTSmVRR0R5V3JBMklCYWFR?=
 =?utf-8?B?cHo5aHpleUZyM0hlcU95aXFYUFV6YXZuYUVacmpsU0Fvc3JIQnlFU0ZYamVF?=
 =?utf-8?B?USs0VmlQOUIrMHJCeGlvTUhOL3Iyck93OXhEMzcxcFY2bUs3b2RmWnMyREFr?=
 =?utf-8?B?WWtZYXpJdmc3bFhJYnZXV24vS2Urc2lVbHJwckJJQ0QyTDlsMUJUdUJRd2Qv?=
 =?utf-8?B?QjdLYi8rKzVURVg3d1R3ZFIrVnRyWkhtOTFvMVFvYWp4OFpsYWFVY0R0U292?=
 =?utf-8?B?MUZtUExnYVJCT2tCNStWYTJTTGNkUmJNU01YeSs1UjJudDh4SlFOZmlrUW1t?=
 =?utf-8?B?RlV4dFlQbjZJUDh0RUFvbGJadk5QL3ZRWC9lZGsxUGFRTjF4bGJwS01QaE1m?=
 =?utf-8?B?RTlpZWFrOG4zdVBvZVdvc294NjlaaEJKVnJNaGMvM2JmY01hamVSTXRqSkRZ?=
 =?utf-8?B?eGpGOCt3QUo1OWhXbnRqZjBQTnpKbS9meVNaVFRoTFVtdzZQVzdEakVETVBm?=
 =?utf-8?B?U2d2S0dTOWsyN0E2d01jckV1WSt3V1lMR0JSQ1FHZy9oc1h3TGdyT0hKZVNX?=
 =?utf-8?B?WnJWN1JyeCtjeDVSdUdkMkZvZ3BpTEdzSEFuSmNwSFdsczcvdUVYSStuOHJL?=
 =?utf-8?B?L0J5RFlNTStnVVdLQzFRbm13RDNwOUd5dE5xRHFZOTc5dFd3eklEd2pxNkdI?=
 =?utf-8?B?VXlHczRnM0dGU3RaalRrb3RmYzVaRTBGUWowQ3g0cGFsSWNrMGZDKzhuQjlY?=
 =?utf-8?B?Wldxc3UwckluVDc1ck5PNC8wU2F4QS9mbE1MTDlYcHBDQzIvbTZFdFBqNDY1?=
 =?utf-8?B?djdOOGJpZXpodjBZMEF5eG1SN1dFdytyaURKSjQ4SWZGdDhvcFNrQ1N2Qms1?=
 =?utf-8?B?bkN6ZTZ3bGZBV0NpVzhlNVIvUTRVUWVMbG5RbTlVNmdHSDFHYkdXRlRsdGNI?=
 =?utf-8?B?M2Y2bHRpWDRqWWtFK0F4V2d6UnlxQ3l2cDNNaTZXa2ZGdDFoWTVlSVltTHZT?=
 =?utf-8?B?dExRSGZuajF0blV3cXplSWs4TkJpQzNPd2pGY3NKc2pzdW1vS3pwbFpNbTNj?=
 =?utf-8?B?Qmt5emRRZ2NER29BS1RZYytLbnc5OCtISVovZ1dSQ2U2ZkZ0TlYwb1VGU204?=
 =?utf-8?B?TG5rWGMwUFpoVWdtODhQMVhHOG8wc2pXVUExTTArS2U4NVIxSzJEMEkxWFdU?=
 =?utf-8?B?UHZLbzIwSVJPTXVUV1lVcVlNanF0cjV5R0JNNWJpZUhhS2JmMmJPWnEyWmtH?=
 =?utf-8?B?T25VZjkrVWF3emwxaVl6akFsOG00eUhYS2k3UHR4L1p1Vm9WYTlPc05YZUVt?=
 =?utf-8?B?eGdNSmxZSFc1eFp5a2FINUR0ank0TU5DUTkvUjFhbFo3RnhYNE02aEhUdllY?=
 =?utf-8?B?K1VnaFVIMVRaWUVuRU5iRTJsZm9TTVlCVUtzY25ZMk51SjVjRmUvNjN4Rm1K?=
 =?utf-8?B?cTc5U1pMMVZhak4xZWlZOHZveUdwbHN3RmF3MWtBTWdDd29PZ3ZVZFlGU1Jt?=
 =?utf-8?B?bGZqeDhVZTBwUStiVStuM2lyeHI5R1FvL0lLd0FTODgrV3ZwejNEWCtubTR0?=
 =?utf-8?B?QmRSUTk2Q2VzeGRPWHpPVEVSaXBTVWZSRHBleFUrVFhsNUxLQ1VEek04VjFo?=
 =?utf-8?B?anl3NEhad0RWSjM0eDc5d0d1K1NFTEtNUmR3eHZGdVMzYnJqbjVZdzZhUnox?=
 =?utf-8?B?eEJDazRFZFZpOEFXZ052NTVoK0NUWGJpZXJJekYvcVdMUGNLWE53VUM2Nk1W?=
 =?utf-8?B?eWppTUlEMWNYeENic2pKd1lrNGVVOTdiaFBDT3ZMQ2o4dy9VR0tXNWtKTXJw?=
 =?utf-8?B?ZFRYNzgrUkV0NHV5MDE3K1Q5WEFaV1VhUUJ1NjhSOGlZY0syTzk3VE1YY24w?=
 =?utf-8?B?Rlc1dnFEdy9tQ3RXSDdoNWphV3JBejZjcExFZTNzcnVDc1grWlRPc01uOEY2?=
 =?utf-8?B?ZkszcU5XUWt2QjdGdytxTjJxY25weXczOUMreHVlNXE4QVZ1L3hKRmVKNzU3?=
 =?utf-8?B?VTlhbG1LSU15UEZUR2hCdy9sZjlsL3V6WUszNzlWeFE5OFJuQ1N2alQvSERw?=
 =?utf-8?Q?9RKyPwqlyQN7CNA4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf5b490-3947-4253-6b42-08df23b1f1b1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:48.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhngA/83OsoXvhPOallO1EWG+8fDuxyiaH9Pz4HP2WMBP4gkSFJADTkiELpz7XIKSh8BzF1ILmSaPx7n3d95QZXriSYBfvhO/xqSMVdrJvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB286923
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

v12 -> v13:

Fixes for ownership issues reported by Akihiko.

  * Patch 16:
    - call the failure notifiers before the FAILED state is set, so that
      the ownership is released before the MIGRATION event is emitted as
      well;

  * Patch 18 (NEW):
    - bring back the exit notifier from v11: a target which has loaded
      the state but hasn't been started quit normally, with the source
      resumed instea.  Then devices aren't unrealized on quit, so the
      ownership has to be released on exit;

  * Patch 22:
    - add a test case for the above -S / qmp_quit case.

v12: https://lore.kernel.org/qemu-devel/20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
Andrey Drobyshev (22):
      migration/cpr: forbid saving duplicate CprFds into hash table
      tests/unit: add test for duplicate keys in CPR FD table
      migration: forbid snapshots in CPR migration modes
      migration: forbid snapshots under Xen
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
      vhost: release ownership in vhost_dev_cleanup()
      migration: add incoming migration failure notifiers
      vhost: release ownership when the incoming migration fails
      vhost: release ownership on exit
      vhost-vsock: hand off device ownership across CPR
      tests/qtest/migration: add vhost-vsock tests for cpr-transfer and cpr-exec
      tests/functional: add vhost-vsock CPR test with a live guest
      tests/functional: cover a cpr-transfer target going away with vhost-vsock

 backends/hostmem-memfd.c                        |   5 +-
 backends/hostmem-shm.c                          |   5 +-
 backends/iommufd.c                              |   4 +-
 hw/vfio/container-legacy.c                      |   7 +-
 hw/vfio/cpr-legacy.c                            |  29 +-
 hw/vfio/cpr.c                                   |   6 +-
 hw/vfio/pci.c                                   |   5 +-
 hw/virtio/vhost-kernel.c                        |   6 +
 hw/virtio/vhost-vsock.c                         | 193 ++++++++++++-
 hw/virtio/vhost.c                               | 122 ++++++++-
 include/hw/vfio/vfio-cpr.h                      |   7 +-
 include/hw/virtio/vhost-backend.h               |   2 +
 include/hw/virtio/vhost-vsock.h                 |   1 +
 include/hw/virtio/vhost.h                       |  74 +++++
 include/migration/cpr.h                         |   2 +-
 include/migration/misc.h                        |   7 +
 migration/cpr.c                                 |  64 +++--
 migration/migration.c                           |  22 ++
 migration/options.c                             |  13 +
 system/physmem.c                                |   5 +-
 tests/functional/x86_64/meson.build             |   2 +
 tests/functional/x86_64/test_vhost_vsock_cpr.py | 347 ++++++++++++++++++++++++
 tests/qtest/migration/cpr-tests.c               | 133 ++++++++-
 tests/unit/meson.build                          |   1 +
 tests/unit/test-cpr.c                           |  98 +++++++
 25 files changed, 1079 insertions(+), 81 deletions(-)
---
base-commit: f7ada39edacaa5c26b30e98b94017b0b2ccbcf94
change-id: 20260908-up-vsock-vhost-v5-c781b39f1c1a

Best regards,
--  
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


