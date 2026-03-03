Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4E1EC143A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPVP-0007cf-5c; Tue, 03 Mar 2026 08:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPVE-0007Ud-8D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:37 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vxPV9-0000OD-L0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7A6fjH3gdGQ6p+KRdHn0YRZhgCvB7zqKWJk7DYdFuRoiOWshcjDlksoPHN3hEdDlVjnvkkde1YiKq5aTUOuO+MPTeIfMsxJP/sxsJoPt7cfiT6/HQr8+Rp95MUd+AtOZB4n6JttCe4oJBVoDzV7zUgJCbyenNxpESYCETkiJv1+FW5fFyn/f7YSKh3SczulrkSFNC0eOfsr7ZoRtNMub3LBvlKw/qtLF/FtlVW7o8lgPN4FZdr722Ybwv6nNUWRYL79XNfTi6IcypFa3E3VEmmZXZxFznJjYVfehgiQ/dc4XDUabBE4RcUIqLYdnnQY6ENgTYE2nu7+WBdGeoCdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1vwXZ9hFVcJT0K9OL3rLvJFqkjHRaZcLn/tcHEc7oo=;
 b=g7pisbzSnSX47FF4OnEYD5mVXPeGzEFD/G8EI8e4EzSUb1NqwVgavs9tBNpCb1j+bNqZq3OQkHxjEkYF+7M/QzRKBWjrVKe7G0gaWzL458Ua3f+PlrOTf3VyF4Bch6VLEUeNQTvycXjwugbuNEYXWwZ25rNHwdWI2MAeiOteBXwfS0V+Ih+AeXi+oJNXPmzwbpkzrKNHZe1SeluxuWdcYC5Qo2ov/lfVM7kcbjPL1I26bzO53wlhCeRVpdLqmN0CftypLz9Ma5rFOQwCJZyZjL8mGIwYvr3QsW+DFilZXzHgdmyniCVSDW9GSpmv8pWtCIRE9QISUielz9KiaB1yHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1vwXZ9hFVcJT0K9OL3rLvJFqkjHRaZcLn/tcHEc7oo=;
 b=mTkfuiFCsgMn4Hpxa+7bdNt8h08gMqrw/ujj7RoISqwGV4gLHPxO0Qnh/zKd3Oqv+ffq7DD6x8w7UHMUPlNpfAPVP1/cC/PsUkikMz7wRZHcVd3MJ8xM6m3r9pGSqRgajbtid5vw+pXJtZDZzeDYqz/umqFMe/aS9I+C8eWtMbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB0984.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:08:44 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6830:19f2:4a5b:749e%2]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:08:44 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, berrange@redhat.com,
 richard.henderson@linaro.org, imp@bsdimp.com
Subject: [PATCH v6 2/7] linux-user: make syscall emulation interruptible
Date: Tue,  3 Mar 2026 14:07:28 +0100
Message-ID: <20260303-setpc-v5-v6-2-15c77cfe184e@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
References: <20260303-setpc-v5-v6-0-15c77cfe184e@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14808;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=0zN94RKNMfqTrsNhvTmcSTkaX36dEL1iEvxYUsSMkRg=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBppr1hpeZQOx9zZQuFAnfPUg0fDrb0GJyMPwTRa
 o2QA+EZbRCJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaaa9YQAKCRCW6ye6MV/H
 fIH+EACUembojo6QGpykSSulOKtpo1PN+1pXDZ4ne6m3JYu5h6GRoVXS/pgQmqyZbM4kmduMEcI
 +VvkyBfsV9zf5fn03qie/C5t4C7/ClDvTWFTCuhkELxfG7OxLt0dRw2eMs+mSTx1CeGw7m33li1
 Rjk+ObWnBFgpYK+ENpTvsHoCynNBjpI8oYwDzSJJm/Y3mjamCdw+b7/D6SkzNHKLoUYoGzjag+F
 omDMxBb2E2b2CR/zre+3YTu7g4QPtNYa5Pq367+5s//EvIG++4cFqq+qKE6GIibkdHs1LfgUCSA
 OWxCjpiVa3b4G/7bUzkswYxKB6nn7OBt364TQzI9zW0LM9eDoHhYxGllgTvcBh5pjbq2u6y218K
 pMdqa+9uQBHwgJTXCHXheKIBDaa3yx1Fu4NH56/UP/Yu09jAsnoTtFi2yz7GnoTlRb3BAMJ34ey
 6EL6oJnOpY6NxcUjzFn+ZPqyUtN7zGHmoaMc9lTxns4svZ6ZEQTc8qNQpXVR9NZaS1NBsrj6kd4
 GQBHucikWan43w2/IuPVkE7elkzoV8qKqOlEfp2LZoOySZ2mA1zsee7qohD6kVEpjpR3Tazcy1U
 jx7GBP3Q+yb0DWvfE7BRf0YXHPPTTp34rp5mbeDoC+MaLvXyJYA92AWBA0iOtz51wEFFtcusnLW
 FHUs3FarsVxCrEg==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: a01c0114-db9d-40ff-cc99-08de7925ff94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|1800799024|19092799006|366016; 
X-Microsoft-Antispam-Message-Info: g9cbM9BbHB9/M5z598C3gjO5VhjyCUDtiHSaBDMR6belfafwvJYfc1slsZvMq5V/LinI6zEQdb35cHIAroc4sEi15wKr8HZkmjeebWpDo+ROBcJycskUeSORV8MuYY8Fs7O2yp60czFYm0VosyRtPGAuI1Hy49B6ax1Rthao0hDvk9vA5iSPnHChHdb8maVe94sy8ccZPiyU0+gC2JyW/gqDGtnTAAkOTOhlgSJtl3CgKyFcFxOmVcGVa6tRiOEvkYyOQlW47RHEYMU37dyMD/TvqrxR5xkbdeIgRoUGvjfUooxmiD7T176WT+O8EPVSU6ksaHKinHZ5jAPub301tgMNdhTm8M64a2pSmd1PeSx9Qc12LDtizFugqrJORRa6bAazFPF5/8Sm37CNPnkCMn7Sn/2YQozKgdOkhjKZ1CzIAYkxcgwTVzHPhvlwqeZU4Vsv8n7bo/MVg5Ho6Qy5TijW35LneQyPysw4T6qRaRrxS4HKjAnJtKYn+AH8F0Y1hB9qVnbzWGWRq7fdJAZAiRybwIP7bs/jTzPAdxvYr1s1TxiX0y4FjiH/BdW8RWc5Eb4NTYbQcX0lHQ8YbYE8jpFXHxnpYIe9KifxrA6+dUN0GzBcrCowhNNQqGNhXuGx9yOneTVd+RTlKBbY3XTMrQQ42fIDjGdqtp2ArTttHG5A8NritAvtLUKYE/SE8WKZMErVuPjHdGVHMe6jdd66cgOe1FTKv+wU6YKrZG5QgsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(1800799024)(19092799006)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWRkdFF3YkRNNUJuMTJoWEZBRXJYb1VVcGZOY1QwMlpySHc0TGQ1b1F5ajBU?=
 =?utf-8?B?RkViSE1scGRjRW5IWDk3SU8xeXpMbXVUcnFVbklhTTBIMTFKSkhiQWdmMkl0?=
 =?utf-8?B?Z0hFdnZRczRwYTlRZlZFQ2orUkFXcnNBUzdkVHN0eXdFTlVlc3dqRGdlVHZw?=
 =?utf-8?B?bVkyUUV2UnhTbnE2alpRT2NRWjQ4eURxcVd2RFpJNWF0dE1qVDRzRC9aa09X?=
 =?utf-8?B?UEx2TTN6bFlYUDBzWlJwS3VOdHlQZW1sYXBDSmlzYUc1L3pVY0YrRTFPN2NN?=
 =?utf-8?B?cW9WZ0ZWYW83Y3BlZWtBM0lQTUZ6L1BZZ1UzT3NCdkdOMWZTTXk3dmlCbERC?=
 =?utf-8?B?eDg3MldveDkwQ1YyZWdvaElwWUwrRFZnWW5BdTJqcVRqZzNWQThjK1NUSEZi?=
 =?utf-8?B?VlFYZG03ajExaVVOMkYwQXZObHVwRGptQTRUWTUyL1FKYWJ4dnlLZm9NdXRJ?=
 =?utf-8?B?SmFpT084ZTB5UnpOSTVUS1Y5MkVCaDRXMTRqSlJTZ0Y3N1FIYTE0QUR2UlZV?=
 =?utf-8?B?eVRITTY3bGhwdXkxUFB1dmlFZXpwYTc4NXRLMnAxdnR5OHNycnJLNU04Z045?=
 =?utf-8?B?dFlRRGxMYWZFTmdZSnYxZ1ZTY0M2bzZQY2tBRmExUzRGMFRUK1JOc0Z4eDd5?=
 =?utf-8?B?b1RUdDNKRFpzQStlb1NSLzdxbDBEVUpIMDJpcDZ1U0dzVkx5NFZZQkQwempT?=
 =?utf-8?B?MmtSSzNmYkJiSURlSE9UZGUyL1htNEJVZW5ySnhRRm1adWMyc2Z4bDNwQ0VB?=
 =?utf-8?B?dHdxSDU1RERCbDdzcTkySnFHcFNGajRIUG1uY2ZRZnNCcE84Z1d1bURKL3NF?=
 =?utf-8?B?Q01ETGpCZzA1dUdDWk9vdkFwQkMxVE9KaHBFY0ZkWHc2eVhFRXZiQjkwOXJh?=
 =?utf-8?B?Q28yM2IrNDVsM2NHNXFGaUN5cGJIVDZxeStGWHFFaDMyT3pmSXRjWFFpZk1L?=
 =?utf-8?B?b2p6aVNUOGpDN0JJS0FnS01oT1VaVmRKb01kMjdUWVAvY2tqL3dGejRUZzFN?=
 =?utf-8?B?VU8xQlh4aHJRVDdFbnEwRHJPUVc5VU5Ud3h5c285eWhEVXBWeC9CZTlUQjFD?=
 =?utf-8?B?TWgvQVc3LzZIU2lzb1k2UmdiK0ZmZnVnbGVwN1lVbXNrSVJnKzRTVlFzOUhu?=
 =?utf-8?B?UnF2UjBxU1RnZzNSZFVMQUM4YXlKcUdCL3JWNkVkblJpSnlNaXh1Z3MxM1Rp?=
 =?utf-8?B?Tm9qTDRFUlRaQ0F2VDRnUkZpY1Z3THdkNW8rU3pjT21CZ1BsYjJmOWdNUFpJ?=
 =?utf-8?B?aDdpeVpjTEIzRUNoK25idmhPQlNiNkNLbkpYYkJGVlkwK1dBdkw2TSt1cit0?=
 =?utf-8?B?ekQxUk15Wk1ValIySDBFSXlrNG90MEkrYWJ4NVFDYWU2V3VlSGppV3hQNzI2?=
 =?utf-8?B?S3hyMC8vVnZ1TTFJakVZcExoUDBQNUhCaXd4b0MyVEY0VWhmVWVqa2tTcHht?=
 =?utf-8?B?TzBYY3cyOEc5WFp4T3RYaDB4MzgvdHQ4dzhUMVRLRnhrU2V0ajlRQS9TUk1u?=
 =?utf-8?B?bDZ0bXlCRmtwbGU2TXFnZUJBMGluSGlhd1hOMTNtN2lnYXFxb3VtbEh0Q2tP?=
 =?utf-8?B?YkF1VWJJZ2lCM3BkWEU0ZFEzejRxUHRtdEZmeTFKeFFRckRVbDVaa0pJMjhn?=
 =?utf-8?B?TS85aDJkMGN1ZGNVKytsdm1GM2NQRlVDaVdoc0Rnc2N0YmFZRzhNcjkrb0k3?=
 =?utf-8?B?ZW9yVFphMnY4SitkVnEyYzZBRytvZW1KZDE0SEg0TFRlZUFjZEhnZVRUL2Nt?=
 =?utf-8?B?ZzlwL2MrVDNSSDdqeHBzU2s1L0tBbWgreTgvbHVtblQrWjRFQ3BmRXh3YSsv?=
 =?utf-8?B?S25yeEtqK2E5TEdzdFhIUklXM08reGRrQWljTENSNnpRaS9pc1YycTc3dmNo?=
 =?utf-8?B?N3Zzb28yZW81TE5vME83UTlkdDVtUU1KZm1vdnRjM0RQWHMvU0dKVmxDWkJt?=
 =?utf-8?B?a3l6UFlJdllIN2RIMy81bkdlYUxEZm52ZVM4Y3BFSUNSTURWTTk5VjBLQUpu?=
 =?utf-8?B?bVh5cVN2UmVSWHNnUVhUVmcrc1hRbWE5bFNlNmhTaXBtWjd3eUFnVnlSUTN5?=
 =?utf-8?B?RHFwWFhUQTI4V0dLWUIzWXQrTVpWZGtVWXdkclEzSlhDSVkvcVBsVWEzbGEz?=
 =?utf-8?B?SFlaT3dlNHJteTlKYi9jbWpGTTNiUVZobitjcVM2SGVnOVJwcCtNNnNxN21q?=
 =?utf-8?B?V2Q3NWV4OU9KVEVhbG9mY1BTbnd4OVFiSVk4YlJjeXdHZ2hubUhCQzdIajVl?=
 =?utf-8?B?TzhyZ3ZxR21kWm1rUVkyeVJtSHZEZWNFOUNGTXRubWlDWHI2dzFJSXBTd1k0?=
 =?utf-8?B?WUsyZGg2blBRWm1DbDA3Ums2ZG11WHNkbE90d20zUldyYlhoWVFNdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: a01c0114-db9d-40ff-cc99-08de7925ff94
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:08:44.3195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP+6j9bplRRp+2UcArqFbj+cfDItGNrq96Xef8XHgqIWMLKjFCGNIJ5erfq3efnGDnRnF4jFs9GgUjblPS0LpU2WU8LCxa7B8OxGa2wYyqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0984
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
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

The syscall emulation code previously wasn't interruptible via
cpu_loop_exit(), as this construct relies on a longjmp target that is not
live anymore in the syscall handling code. Consequently, longjmp() would
operate on a (potentially overwritten) stale jump buffer. This patch adds an additional
setjmp and the necessary handling around it to make longjmp() (and by
proxy cpu_loop_exit() safe to call even within a syscall context.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 linux-user/aarch64/cpu_loop.c      |  2 +-
 linux-user/alpha/cpu_loop.c        |  2 +-
 linux-user/arm/cpu_loop.c          |  2 +-
 linux-user/hexagon/cpu_loop.c      |  2 +-
 linux-user/hppa/cpu_loop.c         |  1 +
 linux-user/i386/cpu_loop.c         |  8 +++++---
 linux-user/include/special-errno.h |  8 ++++++++
 linux-user/loongarch64/cpu_loop.c  |  5 +++--
 linux-user/m68k/cpu_loop.c         |  2 +-
 linux-user/microblaze/cpu_loop.c   |  2 +-
 linux-user/mips/cpu_loop.c         |  9 ++++++---
 linux-user/or1k/cpu_loop.c         |  2 +-
 linux-user/ppc/cpu_loop.c          | 10 +++++++---
 linux-user/riscv/cpu_loop.c        |  2 +-
 linux-user/s390x/cpu_loop.c        |  2 +-
 linux-user/sh4/cpu_loop.c          |  2 +-
 linux-user/sparc/cpu_loop.c        |  4 +++-
 linux-user/syscall.c               | 16 ++++++++++++++++
 linux-user/xtensa/cpu_loop.c       |  1 +
 19 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 7f66a879ea..e7f643d69d 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -181,7 +181,7 @@ void cpu_loop(CPUARMState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->xregs[0] = ret;
             }
             break;
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index f93597c400..bef196b1f5 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -82,7 +82,7 @@ void cpu_loop(CPUAlphaState *env)
                     env->pc -= 4;
                     break;
                 }
-                if (sysret == -QEMU_ESIGRETURN) {
+                if (sysret == -QEMU_ESIGRETURN || sysret == -QEMU_ESETPC) {
                     break;
                 }
                 /* Syscall writes 0 to V0 to bypass error check, similar
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 40aefc4c1d..19874f4c72 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -399,7 +399,7 @@ void cpu_loop(CPUARMState *env)
                                      0, 0);
                     if (ret == -QEMU_ERESTARTSYS) {
                         env->regs[15] -= env->thumb ? 2 : 4;
-                    } else if (ret != -QEMU_ESIGRETURN) {
+                    } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                         env->regs[0] = ret;
                     }
                 }
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index 5711055aff..9464246e9e 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -56,7 +56,7 @@ void cpu_loop(CPUHexagonState *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->gpr[HEX_REG_PC] -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[0] = ret;
             }
             break;
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 972e85c487..4b4b663052 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -124,6 +124,7 @@ void cpu_loop(CPUHPPAState *env)
                 break;
             case -QEMU_ERESTARTSYS:
             case -QEMU_ESIGRETURN:
+            case -QEMU_ESETPC:
                 break;
             }
             break;
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index f3f58576af..fe922fceb5 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -181,7 +181,9 @@ static void emulate_vsyscall(CPUX86State *env)
     if (ret == -TARGET_EFAULT) {
         goto sigsegv;
     }
-    env->regs[R_EAX] = ret;
+    if (ret != -QEMU_ESETPC) {
+        env->regs[R_EAX] = ret;
+    }
 
     /* Emulate a ret instruction to leave the vsyscall page.  */
     env->eip = caller;
@@ -234,7 +236,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
@@ -253,7 +255,7 @@ void cpu_loop(CPUX86State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->eip -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[R_EAX] = ret;
             }
             break;
diff --git a/linux-user/include/special-errno.h b/linux-user/include/special-errno.h
index 4120455baa..1db757241a 100644
--- a/linux-user/include/special-errno.h
+++ b/linux-user/include/special-errno.h
@@ -29,4 +29,12 @@
  */
 #define QEMU_ESIGRETURN   513
 
+/*
+ * This is returned after a plugin has used the qemu_plugin_set_pc API, to
+ * indicate that the plugin deliberately changed the PC and potentially
+ * modified the register values. The main loop should not touch the guest
+ * registers for this reason.
+ */
+#define QEMU_ESETPC       514
+
 #endif /* SPECIAL_ERRNO_H */
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 26a5ce3a93..603fcc39c7 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -44,9 +44,10 @@ void cpu_loop(CPULoongArchState *env)
                 env->pc -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
                 /*
-                 * Returning from a successful sigreturn syscall.
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
                  * Avoid clobbering register state.
                  */
                 break;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 2c9f628241..b98ca8ff7b 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -66,7 +66,7 @@ void cpu_loop(CPUM68KState *env)
                                  0, 0);
                 if (ret == -QEMU_ERESTARTSYS) {
                     env->pc -= 2;
-                } else if (ret != -QEMU_ESIGRETURN) {
+                } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                     env->dregs[0] = ret;
                 }
             }
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 78506ab23d..06d92c0b90 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -54,7 +54,7 @@ void cpu_loop(CPUMBState *env)
             if (ret == -QEMU_ERESTARTSYS) {
                 /* Wind back to before the syscall. */
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[3] = ret;
             }
             /* All syscall exits result in guest r14 being equal to the
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 2365de1de1..fa264b27ec 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -140,9 +140,12 @@ done_syscall:
                 env->active_tc.PC -= 4;
                 break;
             }
-            if (ret == -QEMU_ESIGRETURN) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid clobbering register state.  */
+            if (ret == -QEMU_ESIGRETURN || ret == -QEMU_ESETPC) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid clobbering register state.
+                 */
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)-1133) {
diff --git a/linux-user/or1k/cpu_loop.c b/linux-user/or1k/cpu_loop.c
index 2167d880d5..e7e9929e6f 100644
--- a/linux-user/or1k/cpu_loop.c
+++ b/linux-user/or1k/cpu_loop.c
@@ -48,7 +48,7 @@ void cpu_loop(CPUOpenRISCState *env)
                              cpu_get_gpr(env, 8), 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 cpu_set_gpr(env, 11, ret);
             }
             break;
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index b0b0cb14b4..1f9ee20bd0 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -340,9 +340,13 @@ void cpu_loop(CPUPPCState *env)
                 env->nip -= 4;
                 break;
             }
-            if (ret == (target_ulong)(-QEMU_ESIGRETURN)) {
-                /* Returning from a successful sigreturn syscall.
-                   Avoid corrupting register state.  */
+            if (ret == (target_ulong)(-QEMU_ESIGRETURN) ||
+                ret == (target_ulong)(-QEMU_ESETPC)) {
+                /*
+                 * Returning from a successful sigreturn syscall or from
+                 * control flow diversion in a plugin callback.
+                 * Avoid corrupting register state.
+                 */
                 break;
             }
             if (ret > (target_ulong)(-515)) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index ce542540c2..eecc8d1517 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -65,7 +65,7 @@ void cpu_loop(CPURISCVState *env)
             }
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 4;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gpr[xA0] = ret;
             }
             if (cs->singlestep_enabled) {
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 4929b32e1f..67d2a803fb 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -83,7 +83,7 @@ void cpu_loop(CPUS390XState *env)
                              env->regs[6], env->regs[7], 0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->psw.addr -= env->int_svc_ilen;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->regs[2] = ret;
             }
 
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index 0c9d7e9c46..ee2958d0d9 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -50,7 +50,7 @@ void cpu_loop(CPUSH4State *env)
                              0, 0);
             if (ret == -QEMU_ERESTARTSYS) {
                 env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
+            } else if (ret != -QEMU_ESIGRETURN && ret != -QEMU_ESETPC) {
                 env->gregs[0] = ret;
             }
             break;
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7391e2add8..ab633eeae3 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -229,7 +229,9 @@ void cpu_loop (CPUSPARCState *env)
                               env->regwptr[2], env->regwptr[3],
                               env->regwptr[4], env->regwptr[5],
                               0, 0);
-            if (ret == -QEMU_ERESTARTSYS || ret == -QEMU_ESIGRETURN) {
+            if (ret == -QEMU_ERESTARTSYS ||
+                ret == -QEMU_ESIGRETURN ||
+                ret == -QEMU_ESETPC) {
                 break;
             }
             if ((abi_ulong)ret >= (abi_ulong)(-515)) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d466d0e32f..99e1ed97d9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -43,6 +43,7 @@
 #include <linux/capability.h>
 #include <sched.h>
 #include <sys/timex.h>
+#include <setjmp.h>
 #include <sys/socket.h>
 #include <linux/sockios.h>
 #include <sys/un.h>
@@ -600,6 +601,9 @@ const char *target_strerror(int err)
     if (err == QEMU_ESIGRETURN) {
         return "Successful exit from sigreturn";
     }
+    if (err == QEMU_ESETPC) {
+        return "Successfully redirected control flow";
+    }
 
     return strerror(target_to_host_errno(err));
 }
@@ -14410,6 +14414,18 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         return -QEMU_ESIGRETURN;
     }
 
+    /*
+     * Set up a longjmp target here so that we can call cpu_loop_exit to
+     * redirect control flow back to the main loop even from within
+     * syscall-related plugin callbacks.
+     * For other types of callbacks or longjmp call sites, the longjmp target
+     * is set up in the cpu loop itself but in syscalls the target is not live
+     * anymore.
+     */
+    if (unlikely(sigsetjmp(cpu->jmp_env, 0) != 0)) {
+        return -QEMU_ESETPC;
+    }
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index a0ff10eff8..d2b4ccdfad 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -186,6 +186,7 @@ void cpu_loop(CPUXtensaState *env)
                     break;
 
                 case -QEMU_ESIGRETURN:
+                case -QEMU_ESETPC:
                     break;
                 }
                 break;

-- 
2.53.0


