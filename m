Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CBBF30922
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bg-00045a-TL; Thu, 05 Mar 2026 05:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5ba-000448-1J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:55 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bU-0007ST-Os
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbEtiipKmE2nAs6btnpkwMlSIhEcOc2+0BnI7kl4avHKOoFiKpbEVDLJlZ79VWuq/W94O+mh1jgGPvR2gA640ycQturXxv2TABrFstu4oV9vbhvg9RD68pyv/WEyR82d1bGg5cORYw6WSmr5O79KELuQWyzvaQrsTTrDrkd/c2Nzp3XvOH1iThfinyOBd1GMYmZF4jXBc+ebMx7xnafYlXaFtmUTPAwYqsjfqFySQTLn4Ne4XEkLjN/SgF/CqIgGQvFrfuSy1cHBLg4nBwJMfwS71gb4adT6KZ2IPVlqrkloiXLYy1dyXQi3x+HBQSs4OEuTe7mc0vuKtTteqGMUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoJAVc+SEbuDFDCZR8AVP92jkW7jVoh2jwm3Yl74018=;
 b=d82lUdlnumkNiRJfNLeZOXjY9tg7IH3NoQarA3UAFK+Y7IUmzt4bDoxso7UoBNEBU7qwI/M6gsn1EbVtCVe+HZvL4m+BPnovQEAGwXk8YRamH4LBPyqvG0Y7oRHA56oApOSCJAHu3HKXuGHLEcYXDFG1vDwnEiYRnAqUqO37wBjJu5LJTv4CCH0L7KX2k9sMXI5h7UDfdmST6lSLOAu8WOBp5gGvfDvlfJAWqP9uOPtC892D+ZH0IDt3zshhHReqrweX662kyzG6k5izWDLOuQJRjD7vMHgtsoAEVLFsef/hloukVN8YVlcIau7flu9D+4n7BYoNKPmNGe5mKTRdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoJAVc+SEbuDFDCZR8AVP92jkW7jVoh2jwm3Yl74018=;
 b=e9GoOQnlSlc/4zr5WUG2qeDotSclKan6v4zXFxqc73SjiQoO56+wWWGuqzMhqB9QJhwaw0TvSS7GwBINpQl4zPhsckwVCrP9afflvEpfWT+TKErJ1iS783yV7d3HqVU3xYbiz5QOtzdFZqa/rCw8uQWgfVV2Ed5HFLcvMB+X2Rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB2042.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:43 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:43 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v7 0/8] Enable PC diversion via the plugin API
Date: Thu,  5 Mar 2026 11:05:58 +0100
Message-ID: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260303-setpc-v5-c1df30bad07f
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5371;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=c71fQ3DVM3P0c8MFUhiOmRKXfcMWlX/hb6i17k82Dz0=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVS/R2kTAdpGhCasqz5/AeA0OL78Dj6jMxpA+
 5pUJMTSgCiJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUvwAKCRCW6ye6MV/H
 fFchEAC9cyfuQ1tT8U+CJW+HZuBKjwokgYqQ+Ga7O4ePIrVsUg9sIuQNIbegI/FcLZBsXOatu2X
 XKZjU17RlmzcStVm5KYqiddib0Km4qSmQHhW6Ag4jIijQSxenTiJwf9P7WdVBuaz1B6bF8X3kSc
 6P7PJYRhhK3Pn0AIOcwotc/en5cTlM0sLNuVfvDXGtJDdhS4Z28oMeI6Fk73jNf3mqehqP7PZLi
 ObDczXc/N+kaYHa6L3Knl8wP7H1op1slk378WVlmhF2xGXxHeXGyt3mR2jV3vpQjZtho+tPXh6r
 qrplv4xlFkmc/LYM/vebC/slOOfxaSs3rKES3UFmwr+qYzWrQobQjqDXz6pLx8/fXAkibYSkAay
 p8/8ysLyerfmkOorPsCniVFFXNcXt9AyJqa4ebOXZ9nadXqGG4YHBNLFoELi/yKWUnKdkEpcYgO
 eRAayFblfNuKqNUPec6hnwsSGB738jBTkqAnh324NAPq3PB2/bKw4CTs+vugi9cGYMzUsUgF2te
 0/gJlFbxItOvU9yU/flBW8eig3F3/unBd0dqeIh3i+9spd0CQNlKgrr9WIhi3HTAxk4gk2RuwVg
 VZSeCQ4fMsJAgtk1HrgnedAAb6DTlOE7Dj8rgfmrzjumKZr1xKwQsRW8C/mBy7EKh3YfuerifOf
 RbeKX1r3uTr4AEw==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a8c077-20cb-4109-cd16-08de7a9ee6c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|366016|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: xE+vQ7nd22xVIw3tVN7JxXWIAhaWzn83zUT000TR/q52hp7bWN/qeXAmluqSnk+eGp/f4FdiQw2H7quSFQatFi8P7Ok12G0i48oWaIlrZwybmngKg3HErkrj/8/S/OpUtt5FQKLqhluQCBpHOTDp7NqYkaEG1CyC47VFrCyl0/9L7ixTpqqRkcCACP0qbmmAfseWEV0VA9YqTyaVhejwkT16OLY2v9yszUF3/bQ2p0BDeFjGhheDh5sVVn8H6Ko4I/ifRI9hnZ6iAqeyFIs8uYrGTeiVuy4dClJlQFBdF2FR1XEnaZK2l2ijQ8VkraDp3fJ4fF9UrMvKQm49gqxUliAsjLW+6sBbZI/Gz8g38lwHKZZEoNYhaiygz29Rj8RKlNXcvQxIzWEo8r6hocU2rYd9a8kGWc4se3K8RI+yz12KDEMLId5hqmH00m2Y8dNzkZQjhxAUN78myB9HXlvPGlv/Zioz40+Dsfcwoy/OacX2k4T/IfEKjo2uwt6R4oDmmfFtJCJ0WSAji8CJMhhaXIdVbbVNVC5vUpZEnD9LNz/F6Xr6ekv6aDjjCAz8OV2Bp18Uiod4mduBPlquphAcg+Z42PHJZNSuSIY4zSnzRnoOf8gL9IxidJfDQo3zRpqs11KzyzX+Nrh8QdLN8Gm1PFobYB4CX/+28NUceok3j//ehlfuMmQBU7VAkAE93zb4UOKjdPn04utE7MUREXCuuVwfcgUpDhkPJiyALS1j+Dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(366016)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pXNVRjblM2UWZPbUpuUU1YZkIvbTJYeUpIeUxvWWxMNzg3Uk9pdS9jY2Zq?=
 =?utf-8?B?eXpDajUvWXpvcUlDVmE0dll3TTBpUGlqRWl6UjA1K3FwUEp3bU5Ua3ZiOGh6?=
 =?utf-8?B?dFdKUlh3QVhqZzMxV3M1Y2ZxZHNJSEFYWnNXWm9tRWlHNVdaTUhnRFdyTllu?=
 =?utf-8?B?STdjVEx2RzhBNS93UG1DMld0a09mNWV2QXl1ZDdOdS9sbTAxMk5oZnVPbUNJ?=
 =?utf-8?B?aDB2OUJXWGFQNTNsRXVkbE15UlNXNktvcmV6NzJVU0tPaTJ2aXR2N1EwVmZK?=
 =?utf-8?B?OXdtcHE1S0M4djhIS204dFBBV2lWZDFIeVVqNy8zZHFCeEtHZHhsZ1pEVHZt?=
 =?utf-8?B?ZGVhOU5wL3ZqZGh1c2Q0Y1NzUWtaM2ZIZXBHWmhBeVZJeFlYNmJEdFdsM1My?=
 =?utf-8?B?ZWs0eklNR09pNjVWUnpMRWNDZWNRYmZTRnFmbmNxM3lpZWYrMmYxdG01S2ZB?=
 =?utf-8?B?NURIU3cxeENOeXJFSWMrTXZRRTRxb0hkaHhZMm5jZzBzakpsTTBPakRRWGxG?=
 =?utf-8?B?ekpNT1ZwZStDMTU1ZjlSK3ZDR09kQXFNcWxVUm13U1QyT2NZcnp4YytYbnpq?=
 =?utf-8?B?NUlXNE91Y3pYK0JKdUdjM2ptNWZiRjZHYURMcE1aY2dvUkRLRllEbW5KSHJM?=
 =?utf-8?B?NE1ZQjJ3SjkvT2VyMHVOUUwxZXpkWjI0bkRpU2VLRllHdXdpRldzRTg3R1hW?=
 =?utf-8?B?Zng4dG9RZnlXZG1Ua3YzZlhBOEVFK3VJN0ZabmVlOHJWb2p1MmxsVkVEZ25L?=
 =?utf-8?B?c255dHJqNDlKYWJPVEhkY0pzV0d5cXhuOWJCVVc5dHNvbE5OcGtUdXoxMXRK?=
 =?utf-8?B?OGxjMExESjVySWk4SVM1UFBNYlhGZVdLcEtQUU1SdXpJNWF1RVJURTVBTk5q?=
 =?utf-8?B?QW5hRUJzRG1jT1prdm1raVpDU3NmZStta096REY1alM1YVBIdm1SQTZRaWVG?=
 =?utf-8?B?R3E4dzl3dUM4NGVGMG9QWGlhd2F2NGFyUTluazIrVVVRV2RabGdzYTZqYy80?=
 =?utf-8?B?dGRkL1NIa1lEWWxRVkpwalpTZnMvckJWWVlKYkFQQzBvd0hKKzloTUcvc1hQ?=
 =?utf-8?B?TVR3VUczOTYyNFdVUTE2QU03RmZkV25RWnNRZUk5NTdLWStGNVRZVkk2b3hE?=
 =?utf-8?B?VFBMSDZEV1ROeXJWVjdhajFkeVUzNHZBNWpWdExoRSsrdEFlTWNFS0VYWmhl?=
 =?utf-8?B?TG43WlBaR1dXejByckYxZm9VV29nZC8zZ2lMNENjV2VQbWY0TGNCQ3JLQ0Vn?=
 =?utf-8?B?ZjJwSVhsRGZSZHhreng5OWI5NFhEQzNESmRWeDVaUDBYRkVuTWVLL1BYekI1?=
 =?utf-8?B?WjBjMFNCNEM3d1NDZ25ISzd0dDlIbUNjU3VzNDdUY2xLQWx2OFRjeUM3b2lp?=
 =?utf-8?B?YlhqaGhxelRFN0RXNlRlWFdUR2l3NXNkTnBhQjBKK2cvanV6ZXF4Uy9pQzE2?=
 =?utf-8?B?dzh4UU1rOGlVb00vemN5dENhSUNSeEg5TXErYmNMOGRNQkR0U1JONWFGRjhK?=
 =?utf-8?B?eUVqMERuTURNbFozTU9LdDRDcnNteU02ZmVBR01zRDNwdkxFZ2J1ejVsTXdi?=
 =?utf-8?B?VE81Uzl2SldEQ1RzQzZMcER2QnZoZnlvbnh3c1h1Vm00ZVVLcHp3MTNpZTkx?=
 =?utf-8?B?OE1zRHRJdmV0K3RLOXhzeWlRVHd6ais0UjR5R1M3eWt5ZWxwMDQveWNoOVd1?=
 =?utf-8?B?ZUtSTFFKVlRaZlo2UWMycWthOEU1YlF3bWhld2l6YktEc1lJSStmanVVZHM3?=
 =?utf-8?B?OEJiS2I5MXRPZEs3YXh0U3R3VXFGd0laKzVUdEh4RkJaZ082clcyb1BhdCtU?=
 =?utf-8?B?RndLb2JQRW1XYTRoYjk5bm9idG16S3RJaVNOblpEdERYaUl6cEQxVU9mRFA4?=
 =?utf-8?B?Q08wUENUT2IxUldnYXR2MXZQVUdNYlVQR0RQZnFnWXpJYXVmRmVhdGdMakl4?=
 =?utf-8?B?SERDa0FMMlFybTZ3S3ZIazhoRk5mQTlMZjZYdG9MMTFLQ2tvR3lDaUpNVVd6?=
 =?utf-8?B?TGVHbEhXdmdoM1dxalJ6SlhUaVVRd0VEUmxsRjNnOG9RbXNzUkwxalhmVkxl?=
 =?utf-8?B?eHNTeFg1ejFNWnhQbEZSUVJkQkZEZDNpd2VGQlpFYlhHTmpNR0lMTmIwYW9M?=
 =?utf-8?B?Skd2VFVlVUZzYU01WVU1aGVzMzZndkxraS9jblhUMUdLcXVPS0xma2RRdTZx?=
 =?utf-8?B?RjM1R1lod1B0Q2txVkcxR2RUaGdGaFhTOGk5THdLYUtDWUtEb2VqZ3FjRThz?=
 =?utf-8?B?ajVPRDhMNHMyb1UyUCs3MlFkV3UvbmtHZEFLc3MwRGxNVDFET0hKSmc2UWhp?=
 =?utf-8?B?UWRJR1kxSkJxSXdsdk1lRWIrNDZ2V0RzemlFam5ldm16amE2QnpoaUxUdm8w?=
 =?utf-8?Q?zxFXPp0vwXTe9T1w=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a8c077-20cb-4109-cd16-08de7a9ee6c3
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:43.0492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgYEXKl7uoRiV047ZIIK/kqQS3DDRkAIJWhKD2/TD3Lar4rrNZVadYTakFZtdnyBTy1iyhBkXeKs4VwWtgbZ4LvIVrN1hzkDzN5zhR1f+00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2042
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

Hi,=0D
=0D
This patch series builds on top of the discussion from the thread at=0D
https://lore.kernel.org/qemu-devel/e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epf=
l.ch/=0D
and adds a plugin API function to set the program counter of the guest,=0D
as just writing to it via qemu_plugin_write_register() has no direct=0D
effect.=0D
=0D
This version v7 of the patch series addresses the requested changes from=0D
the previous v6 submission (details below).=0D
=0D
Note: checkpatch.pl still reports a warning about line length violations=0D
in patch nr. 7/8 but I did not fix this, as the line was already > 80=0D
characters long previously, the change added only a single character,=0D
and I think the readability of the code is better as it is now. Please=0D
let me know if you disagree and would like me to fix this!=0D
=0D
@Pierrick: you already reviewed patch 3/7 (now 4/8) previously, but I=0D
had to change the regex in scripts/qemu-plugin-symbols.py to account for=0D
attributes, so please re-review!=0D
=0D
Best regards,=0D
Florian =0D
=0D
Changes:=0D
v7:=0D
- Add Pierrick's patch to clamp 32-bit registers to prevent accidental=0D
  sign extension=0D
- Fix documentation build by using __attribute__((__noreturn__)) instead=0D
  of G_NORETURN (required adjusting scripts/qemu-plugin-symbols.py).=0D
- Rework test-plugin-set-pc test to get rid of volatile guard and make=0D
  control flow more linear=0D
- Link to v6: https://lore.kernel.org/qemu-devel/20260303-setpc-v5-v6-0-15c=
77cfe184e@epfl.ch=0D
v6:=0D
- update commit message for patch 4/7=0D
v5:=0D
- make QEMU abort via asserts instead of just returning an error from=0D
  the plugin API if preconditions are violated=0D
- extend tests for qemu_plugin_set_pc() to different contexts=0D
- fix issues highlighted by checkpatch.pl=0D
v4:=0D
- switch strcmp out in favor of g_strcmp0 =0D
- split the patch introducing the qemu_plugin_set_pc() API into three=0D
  patches, two for preparing the plugin infrastructure and the syscall=0D
  handling code and a third introducing the actual plugin API=0D
v3:=0D
- make PC registers read-only across architectures=0D
- add tests for read-only registers=0D
- adjust test structure for qemu_plugin_set_pc() by moving=0D
   architecture-specific tests into corresponding directories=0D
v2:=0D
- add setjmp() in syscall handling path to allow PC redirection from=0D
   syscall callbacks (via longjmp(), the cpu_loop()'s setjmp() for=0D
   exiting a TB would not be live anymore in syscall handlers)=0D
- add flags to ensure the qemu_plugin_set_pc() API is only called from=0D
   contexts where the CPU is live=0D
- add test for qemu_plugin_set_pc() API=0D
v1:=0D
- initial version=0D
=0D
---=0D
Florian Hofhammer (7):=0D
      plugins: add flag to specify whether PC is rw=0D
      linux-user: make syscall emulation interruptible=0D
      plugins: add PC diversion API function=0D
      tests/tcg: add tests for qemu_plugin_set_pc API=0D
      plugins: add read-only property for registers=0D
      plugins: prohibit writing to read-only registers=0D
      tests/tcg/plugins: test register accesses=0D
=0D
Pierrick Bouvier (1):=0D
      plugins/core: clamp syscall arguments if target is 32-bit=0D
=0D
 MAINTAINERS                                        |   1 +=0D
 include/plugins/qemu-plugin.h                      |  19 +++=0D
 linux-user/aarch64/cpu_loop.c                      |   2 +-=0D
 linux-user/alpha/cpu_loop.c                        |   2 +-=0D
 linux-user/arm/cpu_loop.c                          |   2 +-=0D
 linux-user/hexagon/cpu_loop.c                      |   2 +-=0D
 linux-user/hppa/cpu_loop.c                         |   1 +=0D
 linux-user/i386/cpu_loop.c                         |   8 +-=0D
 linux-user/include/special-errno.h                 |   8 ++=0D
 linux-user/loongarch64/cpu_loop.c                  |   5 +-=0D
 linux-user/m68k/cpu_loop.c                         |   2 +-=0D
 linux-user/microblaze/cpu_loop.c                   |   2 +-=0D
 linux-user/mips/cpu_loop.c                         |   9 +-=0D
 linux-user/or1k/cpu_loop.c                         |   2 +-=0D
 linux-user/ppc/cpu_loop.c                          |  10 +-=0D
 linux-user/riscv/cpu_loop.c                        |   2 +-=0D
 linux-user/s390x/cpu_loop.c                        |   2 +-=0D
 linux-user/sh4/cpu_loop.c                          |   2 +-=0D
 linux-user/sparc/cpu_loop.c                        |   4 +-=0D
 linux-user/syscall.c                               |  16 +++=0D
 linux-user/xtensa/cpu_loop.c                       |   1 +=0D
 plugins/api.c                                      |  42 ++++++-=0D
 plugins/core.c                                     |  50 ++++++--=0D
 scripts/qemu-plugin-symbols.py                     |   9 +-=0D
 tests/tcg/arm/Makefile.target                      |   6 +=0D
 tests/tcg/hexagon/Makefile.target                  |   8 ++=0D
 tests/tcg/multiarch/Makefile.target                |  17 ++-=0D
 .../multiarch/{ =3D> plugin}/check-plugin-output.sh  |   0=0D
 .../{ =3D> plugin}/test-plugin-mem-access.c          |   0=0D
 tests/tcg/multiarch/plugin/test-plugin-set-pc.c    | 134 +++++++++++++++++=
++++=0D
 tests/tcg/plugins/meson.build                      |   2 +=0D
 tests/tcg/plugins/registers.c                      |  79 ++++++++++++=0D
 tests/tcg/plugins/setpc.c                          | 109 +++++++++++++++++=
=0D
 33 files changed, 514 insertions(+), 44 deletions(-)=0D
---=0D
base-commit: 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9=0D
change-id: 20260303-setpc-v5-c1df30bad07f=0D

