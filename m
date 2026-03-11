Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18311104BED5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GlO-0001zg-7G; Wed, 11 Mar 2026 06:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1w0GlM-0001zN-Kq; Wed, 11 Mar 2026 06:26:00 -0400
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1w0Gl9-0001kT-Mt; Wed, 11 Mar 2026 06:25:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3ngu9aZUNhJ3f8bEVfUyp977f2SF8exkYUcdksSW1rWTDaEN5CAujQVkNq4fPueWutxO+HPA0NeOMIi9qyByCVAivbHey1Y5h+o48S6ZnmhzrKuSmvZbrNup3qT0y6pVzj3VAmknN3U33D3IfYNUC5SlyKfe6v0AIrPAIjLTaQ8q0m7G28L7oZhfWBc/2zdvktzPQZc5bw9QKJxBri68HuCFfrtYpZRbFSyrAsnbTzMh+PADWlEN3obOJ7xLMkGbr3L3YpfC2WBC42+2MQX+jOz486MmEFYTVYycmGGg8NkS/Ix7y8Jn/Kzay2xwOJ5VXgWwN/7RMllA6mEx0gcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6eOLGf2viDmKzpD1zjAnoOZAxsnBHbNT1CE0K0LCmg=;
 b=Vzth30dTngYK145s3zAVgbkp8B9QdnS9+Jrqw+002cSfWbF4K1w0m7osgzH/N9K0zNyOekuXzO75yud7hoNXRmXSK7DiHhjN2jynIerTQSHzr8PNl35GiLm6bq8oUqBezeacNK8B0UgKdjsUH4yOE0dLJn1Na6ZxWqbUytbjiwNlGj0loHQAeF1xB6YJPPbM8he+Nrhs/juFPSa55WCu2aG3U907FlxcWJG/WTcvCWRLcwkzCWFLteDZe3AUS63K7CqC9PvRkhdvR7vZNT0SsD6R7EF7h+ZOaQta7tHhecYlSKLsqhmr3Uro6AuZ2iIaKlSOvg2tPDt1g7SfXxuh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6eOLGf2viDmKzpD1zjAnoOZAxsnBHbNT1CE0K0LCmg=;
 b=hSTY04Ge/49BPihALliGYQOqUJx6BAn5BsgA1zpZv8rA1/uVB+EA34nnqzrrqQShbYdAFeBUdG6L4Wqrpg8NsYkrqND+ZWq6LQiPqmy1Zoa38i8YTAU94WZJ4P0DB9PXQ0KKHTetAh09BdG940HDrrjQt+T2JBKyUZ+5JDGfeQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZRH2PF1C244E4FC.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::208) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 10:25:43 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%8]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 10:25:43 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-trivial@nongnu.org,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org
Subject: [PATCH trivial v3] plugins: add missing docstrings to qemu-plugin.h
Date: Wed, 11 Mar 2026 11:25:23 +0100
Message-ID: <20260311-add-missing-plugin-docs-v3-1-d68b9135e397@epfl.ch>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260309-add-missing-plugin-docs-159d7ff315f9
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8098;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=j15sELknbe1AFy+NwvFBdbN8gGr1UgYX8AF3monQvYE=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpsULfQIqc6F6AHR9V8pg+vc2fzGViaceijcsod
 bOK6jsHx0iJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCabFC3wAKCRCW6ye6MV/H
 fIqlD/4iE1ItOgs3N0PUmRa7uosV8G4oYJMB4FXvzyDltF82VQFKIKCbONLaxJfFG3GJjSNq+Am
 v6bM9wUZd97I6QjnJ2PMN1PzP+8ZzrMttgO+06zTyW+jOBk4uEDDotNNMkwSY8hm3hvcXNcZyJI
 hLC5hYWmUWbtqD71bneJR4W6+kR55w97k9sH283L+PKUwRFlDluhGDJ8831+SKMZBAKwQMPfT96
 onew6Pmlqy0KKVX2iVxMwZLcT4Zfb4IEC5j57DLNCh0yI27UD3/qlkkMtKVfp0vhp9pDSicDB9h
 z5uh3hNCz1T2ZBKRwUQ31rIHGr5JI4Xt5w4t+AkewBBGHfel4APOsa+r6goqnGJa8j5lY398+wg
 fRI2YP4DFCe9XFSC5Iw9Yq2MsupPgAcEluiZhMHtaLCrqIZWnc/NjgWt7XLyIyITxWByEphFowT
 bO6wiZVWuzz2LbyP3Svad+uZgrKRLe/1jyPj4MYfPCFaRAkDfz8+EevTB/cwmJRgT0izfslopxv
 pZcggkZRclXGAQcsuAQID8gpP44uT4PxSlPhRaSr4Ckxjtc8LbLMBrACanSgFl9wYkfQ8Y8l62o
 mDcGtNZBGt8OXloIvHLtzuf5n0D42Oguh8LPuobOePWQR8r8mD+yoq0E9nTai1zNXD/m5xMUo6K
 9gaZDTd4dEEKrMA==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: GVAP278CA0007.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::17) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZRH2PF1C244E4FC:EE_
X-MS-Office365-Filtering-Correlation-Id: a6cd2f48-8d0a-42b7-66d7-08de7f588d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|786006|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: u5oWyzs8eIO2Y072uex1maWA8pJk/lI5L30ZcHVwz7swBw35M4tREMwxhXucPkilpnLVqKb9S8j1v8hpRm/HlddzeS0jppHpB6GPx+eOMRBpq7qnS3epJcs/Uw0fejKRNFpyxkWlz03A8rvWp8WuXnxbKLlOcD6EXLZ6CF79pcw+beHts/r23CvfMc9stiKs6BnnkcRlip9Q54XYD4euEqvUyOyKxaZ5haqFJQcYF5j7k4GWkn9KApZM0y68m7mOM/Re27WjE78R8R3hBsmDsWHDAdEfu0mHISM39GfV6G6sXo2dWGSHsd9WO9+gqlJv45Uf82abM3ijZuv47glcW51p3VOvqbTbfMhDYwtsQzHIne8hn1rBL2BFfMKCDO7rRIE7tSkUNSjlaz+ZQXgsulZvDboMVSXjG2ITqhG2AK6qnhGqIXjCcacSGv93J/ScctuXfEWqJ8r/fcz+atOWVS0RcVUNFiZcuKf0yelQ2GmN92W0SNiOCqQ+pwcpqqQM7Aw3RP1hauXKmzl2MEyjA+BlKQ5DRvil448Ka/+oivuGPozanHGIMnHxfSQmJt1IaL2pw9nJmXef7ixS4mT3BDtaY/toJApFnsOYVDQZ3pVxl1aNkXKlwsfog1sltGJxUdERXFRxJ1y6eg48nBjfr90XKhBx8ONhZMAL+l66Kn4aUmAEnGy3HjT15L/Tx18m
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(786006)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1NudW54T0VtRnZkNzVTTXZ6eGhZOUViVjY5NkIzdnR3dC8rRVNxVnNINU84?=
 =?utf-8?B?T1B4UGhaU0hBTHdBQm5RSEhjVlU1YTRaU1UrSEdRU29IK01JKzRGUkh2bnhQ?=
 =?utf-8?B?S2I2MzZxL0xCQ0VRc0wvV3llQ2VHTFhMRmVBeHhlY2hQVG9JemNKYjFCV2NO?=
 =?utf-8?B?U3EwVTBBQTV3RmQ5OXZXcUZqbkk3bWtkNG1lWWU4czRrUG8zelpubFNlcjVM?=
 =?utf-8?B?akEyYkpIa0FwNkJibmxUbmpvdEJ4VlEzNTlEWXpzcVJmRlN4SHB5Vlo3WFpa?=
 =?utf-8?B?UCtQdGdJTTdnaHk3Q3VaeWRTclUyc2pOU05PQ0o5RkFwWk5uMkk0MzhPMnJC?=
 =?utf-8?B?eHFjQ2JRKzBWeUtHeVVaL2RKQTh6OU5LN2FzR0gwa1dHdXQyMHFYR0hLbGd5?=
 =?utf-8?B?aDdkS2d5Wmk2TXhFSjRaZnA4czBFOXNkREJQRk04dnZRMHhOS21YMC92dndG?=
 =?utf-8?B?Uk1sTVNodnc3MXQvSFMweERpSUxZOWhUc3A4WnpkQU5TWk83d1d2dStIL3Bj?=
 =?utf-8?B?NjZrQWZXVzNHZlJnYkdnSEpRWm9uNG45K0V2eGJzaEtVMlRLM2l1SW0zckgx?=
 =?utf-8?B?VnlRRFJ4RjVYYVp5ZW1pRWZxTHNJbVZOQjl4QWhpWUxJeVVxN2dBNnE0SVcz?=
 =?utf-8?B?Y1BvQVpKTlRXK0lhUy81WThXR2JtSXFpdDBpUDZ1Ni9OVGpZeGgyU2wvZ29Q?=
 =?utf-8?B?N242UWVQYlgrMU5kY3IwbWNYRnJJRC82UnZVSzNVOFh6YWFwS2I0OGpOc24y?=
 =?utf-8?B?OXFaNms4MlNWeVBxNTh2Zmx1L2ZIMEJvZURjWGdpeUVpRU42N2l3cVpnSDRB?=
 =?utf-8?B?dHdndTgraUtpM1FJWHpQOVpmWit1di9FZUtNVXVKd1RDN091YmdxdXZRY1Nu?=
 =?utf-8?B?R252MDE2ZGNNcTFzbG5jY29qU0gzMTkzc05GbDEyZGJwRkFoQjlaV3A2NXNN?=
 =?utf-8?B?Q3FaeDRlbW9wSlBtUlhJTHlOUFFGd0pXNkk2VWNOMDdISnd0ZGorbFVldlcv?=
 =?utf-8?B?V1B3TGhRY09kbkpZWERKeVY0bjNTQTlmUXppc3hhUEs5SXJzaWNVZkZ4NHBB?=
 =?utf-8?B?S21kRUp6MXdxMWRQQ29la21uTkpxMU5TSEtqeWJUOW1MTEdsT3AvQUlBbjQ1?=
 =?utf-8?B?TXp1UHZBckFoZXlDTVBDNWpxK0ZYZHJoTXZNeU5OZEJCR1JpZFFiWVF5MGg0?=
 =?utf-8?B?Qy9QdVBhaXJua0p4QWY3aWd3LzUvcVVEalZHK2hGdllYdXhNenFPVDZXRFNN?=
 =?utf-8?B?aHI5RmlmY09UZEplMFpiVGltdTAyaWh4T0pGTGR1Z1pSUFQxYjVYWU8rQlE1?=
 =?utf-8?B?cDNYRWVpeTY4M1FxNTc2R1Z5cXJncUhNZHhQVityK3dOZGxRRXRXOGs2ZWUz?=
 =?utf-8?B?UStBMklFTUZFMFVoTi9yZlJMZlJtSi9kRTh2alNSSGllSHdHL3M0VWpXWFMy?=
 =?utf-8?B?SXVSUjc0ZEZDeVplTWtWZVh6V0M3N0EreTVXVUJtRzV1Q1VManZZWmZmVkp3?=
 =?utf-8?B?d2Vsenpzckd1MDRPeXJ3VWRQU1gvaEpHQTFlK1pZdXFHT1FzQWwxaVhHR0RW?=
 =?utf-8?B?MHJpRVlpRFJzNUl5TjBxTUpqWFJhZllBbGpsUFJSVWZWRFVxRzczUTRYcVda?=
 =?utf-8?B?V3pickVHWDNRMWRBV1YwOGlYRko4MFZSZXNFUHZUZTRHMXROMjl2c0srdGVQ?=
 =?utf-8?B?ckNIeG9XdmV5WHVTem5vdFNwdmx1djUxZlRpRU11eXNzRHB6aWNURnJvYmJK?=
 =?utf-8?B?NUlqRGRIWWtUR2dzNjBIeExCNE5jWjVJc2RHajdnT1E2aXZiM0ZvQ2ViYzdl?=
 =?utf-8?B?blpzVkErOENyOTlsZkN6enFTNVZrTlZFS0YwZXFsbGpsUWpBeTZwN1dRaTFL?=
 =?utf-8?B?aExyOUFCS0RONVpzM3AzeHZBVzFEd2l4cmtMS0RBd0FDRGFNZVB2a2lxRTZN?=
 =?utf-8?B?a0d0cmJCS3YybGtJd1BnR1k3dDdIUFk3RGc4SG82elorejNVRkVPd2Yyb1du?=
 =?utf-8?B?Y3hpVjYwaUVrQUVzS015dk5SU3VCOGJuOGhmamRlcHFHYmpUYUMwYUpzVFdD?=
 =?utf-8?B?YW9nb2xQanp0dGpaZUdSTzBxcmdmSWZ5bDhZc1czNG9DeVVyd2t4YkFvdExK?=
 =?utf-8?B?eXlHdm9qWXd4L3h0dlJxUk9HeUNqei94NkNTQVhMQkJQREJ5d2hFd3JPOXc2?=
 =?utf-8?B?TjM3bkp6NjEyekNWY0pEK3NYUFpOS2gwNjF3UWR3TFFKYTVPODRxOVlhcVNj?=
 =?utf-8?B?VlhDakZ6UUp5b0tSeWtZcGM1TTU3UmN5MERUR25NeXpINjZ2UHBGNGpKditz?=
 =?utf-8?B?TldaNDJtdUVHQXUwQXdUWndkWWdSVStJSzhQSEtucGt2eG05bDRYVVJLQmdu?=
 =?utf-8?Q?itB8pOOFwbbiWe2U=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: a6cd2f48-8d0a-42b7-66d7-08de7f588d11
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:25:43.5553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cwwcHHz3E93Zm23+e8yZyNL8rIlW80VW7Cf1HNoy1lDY7vZtQZ5/IK641u5KIFELew0IsIW6Lm5HLlPmpfx2S6uWFwOVBnt+IvbdBLPF87w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRH2PF1C244E4FC
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This patch adds docstrings for typedefs and function declarations in=0D
include/plugins/qemu-plugin.h that were previously missing. This=0D
resolves inconsistencies in the docs, e.g., the description for=0D
qemu_plugin_read_register() referring to qemu_plugin_register_flush_cb()=0D
but code cache flush callbacks not being documented themselves.=0D
=0D
Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>=0D
---=0D
Hi,=0D
=0D
While working on a QEMU plugin and browsing the online docs at=0D
https://www.qemu.org/docs/master/devel/tcg-plugins.html, I noticed that=0D
some of the API functions were not actually documented.=0D
=0D
I went through the include/plugins/qemu-plugin.h header file and added=0D
docstrings where they were missing, hoping of course that I documented=0D
the correct functionality based on my understanding of the plugin=0D
internals.=0D
=0D
I hope that's useful and I didn't miss anything!=0D
=0D
Best regards,=0D
Florian=0D
=0D
Changes in v3:=0D
- Fix documentation build issue due to incorrect parameter name=0D
- Link to v2: https://lore.kernel.org/qemu-devel/20260310-add-missing-plugi=
n-docs-v2-1-e9a91cb6974a@epfl.ch=0D
Changes in v2:=0D
- Added semantics clarification to the qemu_plugin_register_flush_cb()=0D
  docstring (suggested by Pierrick)=0D
- Link to v1: https://lore.kernel.org/qemu-devel/20260309-add-missing-plugi=
n-docs-v1-1-41dddcd177c8@epfl.ch=0D
---=0D
 include/plugins/qemu-plugin.h | 106 +++++++++++++++++++++++++++++++++++++-=
----=0D
 1 file changed, 94 insertions(+), 12 deletions(-)=0D
=0D
diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h=
=0D
index 827e8e1787..9e4e40acee 100644=0D
--- a/include/plugins/qemu-plugin.h=0D
+++ b/include/plugins/qemu-plugin.h=0D
@@ -339,12 +339,28 @@ enum qemu_plugin_cb_flags {=0D
     QEMU_PLUGIN_CB_RW_REGS_PC,=0D
 };=0D
 =0D
+/**=0D
+ * enum qemu_plugin_mem_rw - type of memory access=0D
+ *=0D
+ * @QEMU_PLUGIN_MEM_R: memory read access only=0D
+ * @QEMU_PLUGIN_MEM_W: memory write access only=0D
+ * @QEMU_PLUGIN_MEM_RW: memory read and write access=0D
+ */=0D
 enum qemu_plugin_mem_rw {=0D
     QEMU_PLUGIN_MEM_R =3D 1,=0D
     QEMU_PLUGIN_MEM_W,=0D
     QEMU_PLUGIN_MEM_RW,=0D
 };=0D
 =0D
+/**=0D
+ * enum qemu_plugin_mem_value_type - size of memory value=0D
+ *=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U8: unsigned 8-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U16: unsigned 16-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U32: unsigned 32-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U64: unsigned 64-bit value=0D
+ * @QEMU_PLUGIN_MEM_VALUE_U128: unsigned 128-bit value=0D
+ */=0D
 enum qemu_plugin_mem_value_type {=0D
     QEMU_PLUGIN_MEM_VALUE_U8,=0D
     QEMU_PLUGIN_MEM_VALUE_U16,=0D
@@ -353,7 +369,13 @@ enum qemu_plugin_mem_value_type {=0D
     QEMU_PLUGIN_MEM_VALUE_U128,=0D
 };=0D
 =0D
-/* typedef qemu_plugin_mem_value - value accessed during a load/store */=
=0D
+/**=0D
+ * typedef qemu_plugin_mem_value - value accessed during a load/store=0D
+ *=0D
+ * @type: the memory access size=0D
+ * @data: the value accessed during the memory operation (value after=0D
+ *        read/write)=0D
+ */=0D
 typedef struct {=0D
     enum qemu_plugin_mem_value_type type;=0D
     union {=0D
@@ -462,7 +484,6 @@ void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct q=
emu_plugin_tb *tb,=0D
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t=0D
  * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t=0D
  */=0D
-=0D
 enum qemu_plugin_op {=0D
     QEMU_PLUGIN_INLINE_ADD_U64,=0D
     QEMU_PLUGIN_INLINE_STORE_U64,=0D
@@ -803,6 +824,20 @@ const void *qemu_plugin_request_time_control(void);=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_update_ns(const void *handle, int64_t time);=0D
 =0D
+/**=0D
+ * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function =
type=0D
+ * @id: plugin id=0D
+ * @vcpu_index: the executing vCPU=0D
+ * @num: the syscall number=0D
+ * @a1: the 1st syscall argument=0D
+ * @a2: the 2nd syscall argument=0D
+ * @a3: the 3rd syscall argument=0D
+ * @a4: the 4th syscall argument=0D
+ * @a5: the 5th syscall argument=0D
+ * @a6: the 6th syscall argument=0D
+ * @a7: the 7th syscall argument=0D
+ * @a8: the 8th syscall argument=0D
+ */=0D
 typedef void=0D
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_in=
dex,=0D
                                  int64_t num, uint64_t a1, uint64_t a2,=0D
@@ -836,24 +871,62 @@ typedef bool=0D
                                         uint64_t a6, uint64_t a7, uint64_t=
 a8,=0D
                                         uint64_t *sysret);=0D
 =0D
+/**=0D
+ * typedef qemu_plugin_vcpu_syscall_ret_cb_t - vCPU syscall return callbac=
k=0D
+ * function type=0D
+ * @id: plugin id=0D
+ * @vcpu_index: the executing vCPU=0D
+ * @num: the syscall number=0D
+ * @ret: the syscall return value=0D
+ */=0D
+typedef void=0D
+(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,=0D
+                                     unsigned int vcpu_index,=0D
+                                     int64_t num, int64_t ret);=0D
+=0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_cb() - register a syscall entry callb=
ack=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed before a syscall is handled by the host.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,=0D
                                           qemu_plugin_vcpu_syscall_cb_t cb=
);=0D
 =0D
-typedef void=0D
-(*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcp=
u_idx,=0D
-                                     int64_t num, int64_t ret);=0D
-=0D
-QEMU_PLUGIN_API=0D
-void=0D
-qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,=0D
-                                         qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);=0D
-=0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_filter_cb() - register a syscall filt=
er=0D
+ * callback=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_filter_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed before a syscall is handled by the host. If the=0D
+ * callback returns true, the syscall is filtered and will not be executed=
 by=0D
+ * the host. The callback must then set the syscall return value via the=
=0D
+ * corresponding pointer passed to it.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void=0D
 qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,=0D
                                             qemu_plugin_vcpu_syscall_filte=
r_cb_t cb);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_vcpu_syscall_ret_cb() - register a syscall entry=
=0D
+ * callback=0D
+ * @id: plugin id=0D
+ * @cb: callback of type qemu_plugin_vcpu_syscall_ret_cb_t=0D
+ *=0D
+ * This registers a callback for every syscall executed by the guest. The =
@cb=0D
+ * function is executed upon return from the host syscall before execution=
 is=0D
+ * handed back to the guest.=0D
+ */=0D
+QEMU_PLUGIN_API=0D
+void=0D
+qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,=0D
+                                         qemu_plugin_vcpu_syscall_ret_cb_t=
 cb);=0D
 =0D
 /**=0D
  * qemu_plugin_insn_disas() - return disassembly string for instruction=0D
@@ -861,7 +934,6 @@ qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin=
_id_t id,=0D
  *=0D
  * Returns an allocated string containing the disassembly=0D
  */=0D
-=0D
 QEMU_PLUGIN_API=0D
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);=0D
 =0D
@@ -888,6 +960,16 @@ QEMU_PLUGIN_API=0D
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,=0D
                                qemu_plugin_vcpu_simple_cb_t cb);=0D
 =0D
+/**=0D
+ * qemu_plugin_register_flush_cb() - register code cache flush callback=0D
+ * @id: plugin ID=0D
+ * @cb: callback=0D
+ *=0D
+ * The @cb function is called every time the code cache is flushed.=0D
+ * The callback can be used to free resources associated with existing=0D
+ * translated blocks in a plugin. @cb is guaranteed to run with all cpus b=
eing=0D
+ * stopped, thus no lock is required within it.=0D
+ */=0D
 QEMU_PLUGIN_API=0D
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,=0D
                                    qemu_plugin_simple_cb_t cb);=0D
=0D
---=0D
base-commit: 7608a95d2e0bd8c8d069ab77824d02586dd94648=0D
change-id: 20260309-add-missing-plugin-docs-159d7ff315f9=0D

