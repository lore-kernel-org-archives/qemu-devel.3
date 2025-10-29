Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A4CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 16:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8eV-0003Iq-HE; Wed, 29 Oct 2025 12:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vE8e4-0002tC-3s
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 12:03:37 -0400
Received: from
 mail-switzerlandnorthazon11021094.outbound.protection.outlook.com
 ([40.107.167.94] helo=ZRZP278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vE8ds-0004yC-W4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 12:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F65rljjaGt/DeP4sfoTY6FcS5umHO3LNovliTu8sKZlRqy+hyRynMFy3vD9oVrrAmWlBEr/uOWxv6utp13O39oVGhsL9hzuVr5jSHdD8+/mgxw130JqDR5ZCdXqZv+Jy9LPk0JXAnnQGY2/EbQ/NVu36PplMhloKAEvjXh7gVeJPHMBeQzgaCJzsstMtVSoMlFEXSrTD579xPwBSy4zpD6rC4zvYdJIQpP1Tw5v5Hyj7GL0ISpmhW5okkSAA6MQfcoOVqQs7K+54xLOQsG0ttsm/iO/Cfvbt5YgxnR7dJzr/DMbLPRDXA9qukwBSlEaoXGyC4ikAnxSCZI1qwJyqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OC7BBQFtAmo0a9jZKRKeqi7ViBexwEQ3H5YGCck9gHs=;
 b=bJWrTjmLQ+Y6NFUkhMEUHSIbCjymW3iw0/H2Xm1j2N3hV5C71The2jd56MBeEXmHCz5TYQ2O5HZHQLCNL7Vm9NY4zArYjgwKHzO53dAzp4kG0L+Om9/GA5+9SjVMpH+YpCAqgfUx9GuizxmAukDPJdLIsQXXLki9I99ffVcM1KBSUcNjymX5Z6EbmR4OSA2/10EplGUTuGVrNFPxsXRxAByCloS198wECHTZgkiMN8aP7fRPhphMx038NFuLY7GObwlPu1KIeBg43Md9O9vj1rEmBoEZAM0qSZ9xnGpZks8tQ/0AJyuni6WM4u3MGGEhJCZ1tO0D3OcImtL6aewvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OC7BBQFtAmo0a9jZKRKeqi7ViBexwEQ3H5YGCck9gHs=;
 b=daAi5TOOE6nV94q1jb6rNn985i0Wib0CnU+JdAZXaGg1mSQcYnjOUGL2s3Et2EJ8R2tTH0yI+F5A30oaa9eT84z8gwwRv06RF5puf9ABYR0jY9MHqEH8O5/+P8hAGLvdM+qybZ8EPnBPKxkF0k0gepR3rzfeZSwJ+MQzenLanrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by ZR3P278MB1709.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:8f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:58:04 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ed7e:e338:8c3b:9a0d]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ed7e:e338:8c3b:9a0d%4]) with mapi id 15.20.9253.011; Wed, 29 Oct 2025
 15:58:04 +0000
Message-ID: <f06e2059-9d86-4a5c-acff-84cbeabcfb06@epfl.ch>
Date: Wed, 29 Oct 2025 16:57:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] Enable PC diversion via the plugin API
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <e9bcd7c7-2d67-469e-b2f3-d1a68e456b2b@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::10) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|ZR3P278MB1709:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfe3db7-e10d-4d43-f4a6-08de1703f1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFpNS2NpZHJVUnM0YlFFT29HRFM5d3VkZiswejdhVzdveVBBMkt1RmtocERV?=
 =?utf-8?B?TU9rcFYra3hTTE0zam5obHMyUFY1cHBUZlVsNDJ3Y2xpU2U0a0N0QkdSSVh0?=
 =?utf-8?B?aGYyM3RiOEVyNDVuVnowL0FPMG92ckZSR21RYzdDYTUxYnQxc3VET1JKbmh2?=
 =?utf-8?B?QS9ZZ0Q2amxGb1h6TFFhTDE2YnBteGRqM0Y1MExXc0NPbHJJbG5OUTRNT3I4?=
 =?utf-8?B?V0kvMkNSSnloS2R5TG5FcElJenJ2UmR4cFQ0WDBoMUFIOXg4ME0xWGZ6Mncy?=
 =?utf-8?B?NkNwOTIyYWM3UXQwaTJBdVJqVFNBM1JXY1BXcjFwMytCRk1yZnFsREM1VGo2?=
 =?utf-8?B?RXJ2SDZJT25VRytObFpFMmp2RkZoNW9WaUw5NjFhYUJ1WE03cmJjdy9yTU96?=
 =?utf-8?B?ajFabW5CbHZZZnlqS0RFcHJ1c3Z1ZGthUUYxTmZVMmg4c2JnOE5pT1hBZWxi?=
 =?utf-8?B?ckNQSnFMeHoySXdPUElvdk4wK1RCUkhXSlIrQWorNTdTUmJtV2lydnRZL2R1?=
 =?utf-8?B?VElJcXhDdCt5ajMrV1RwdERsbjh1Y2d6WkVSdFJnam15aXFXcVhmc2JTRVhB?=
 =?utf-8?B?Z0xFMDhTQ2E1Z3ZCSC9pRmNoSHNESTk0eWhYRlJHR0xlc3E2M04zblZzdDhp?=
 =?utf-8?B?bFFvelZoUlA4Nk42UWZsRVZoVlZaMnZQUjI2djNIallva2xXNnFUVE1EVEdh?=
 =?utf-8?B?RUtVY0FoS3hGOVJaNThYTjhxZHMvZkpoZlJhZUpuNTZ2MkVRSzRNNDZkdkpi?=
 =?utf-8?B?OUd4TGpIL0U1b2RPQm9BVGV5UkF4aHF3TnU1NHNOL2FVNlRidExGYlJIaGJL?=
 =?utf-8?B?RHpqS1BSSk1pSlduMVRDMCtEWGlYck0xeGxudkhUVXhjVDBKQTdOM091Yzdn?=
 =?utf-8?B?MnRMRFN5ZkhUMnAxL0hXMjFmV0NNU1ltTnRRMnVjZEcwUjJMQVMvOHdONjZK?=
 =?utf-8?B?R1g5UUU4c2IzQjR0UGlMZ1F5NmZjM0l6NVlMVEJjdmxMUnhPbkFqT0luc01p?=
 =?utf-8?B?Si9UYVVPQmhnTkoxTXBqcW8rRGFYTno1SkQ4aTVYQ1N3RzNyYkJQdnBJYkh6?=
 =?utf-8?B?NEplYjUyQTBSa0hTcGFkTXBDZkJlUVpVYXdZOXNRcmhvS0h6UnZUc2kybWE5?=
 =?utf-8?B?bjg4TnJHVFZDUUpoUzBRZjdxWWtTZ0VxQ0Qvdm1DRjAwNnhFb29PSVdkQzJK?=
 =?utf-8?B?UU1OUTZnSkVIMlo0Tmt1d3F5Rm4vZ3BkMzZkNjVxUTVoUzZXSkNkVjdkYXo1?=
 =?utf-8?B?b3pOSndUQ05TWVdEWWhScDVCV01LclBxTnRrTDVUTTBManJKd3FVUXZpbi9I?=
 =?utf-8?B?b0kxVlc1Q1MzbFl2bjJiUjBpYmVGWFAwVjNhY1FjRFlGMEJxMFpZTW40M0tM?=
 =?utf-8?B?dEYxeUtXTEs5RnkrSXdJSVNiMjkrS1kxdHdqY1E4TTRSaU4rdW9SRHhOZUFP?=
 =?utf-8?B?YjRnMkdPMHE3cVRwWlVvcG1xaGdSMGxxOFhtUFBBRXZNSzQxOW0xWEJWdmtZ?=
 =?utf-8?B?eFVPa0k4ekhiVU9yb2ZNekJwbXJweW5NRXhQdVc5Z0VORWptcVJjVnROWjZL?=
 =?utf-8?B?Q0pvVmkvS2J4KzB5VzkvVkthTTZhSVgyRzNVRXIrSWZaV1MxOUtqTlN1bEtH?=
 =?utf-8?B?TEhrallZK213SERCVHk0aWxSYzgxUDBVOW1jM1FLcnAveVJDR1pIUzlDeXVJ?=
 =?utf-8?B?RmVqcEpvanVyRnN3US84dnBZbE5HNGpYc0QvTytaYXBKV2daUy9RbzNBdkhn?=
 =?utf-8?B?c1BVSmZvWG43SWc3VjFIT3BNcVlFbEw5MDVScHBiaWJEb2MveTFGWld4WWp2?=
 =?utf-8?B?Z0ZpbGFuVG04cHVzTnlQVkZkSHNaN25adkVUSFJCanhyTENucHl1dlNpdlR6?=
 =?utf-8?B?N09sUHNpbGFvNTNWK3Y1SWVGNCsxY1FhQWdSNW9qaCtxdUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tiYUczaVo4Z0Y4RzI2cjgwZnkrQnNqUWhvN0tMOUdDOU9Wd1V0SnRaNFAy?=
 =?utf-8?B?TXpNRm1IdVdZTVJmUFZKKzU4NVRpVTJnd3BONGMvOFE5cWUzSURxWmhrcjVO?=
 =?utf-8?B?em01Q255K2hZTnlua200TlVqWDVFcERDRHdYU0hSTGZxYlByL0Z6bXFtYXBP?=
 =?utf-8?B?Mjh4MEhTSnhINEFBTGRVeDJ3bnZnWnlsN09uVHRqN0VrWCs5S0dNZnZBYUFy?=
 =?utf-8?B?TkJra1VZNFNUQ05FMEtZbjFlOWpBSlE5L0ZlK2F2eGczUllZajdORC9yZUVC?=
 =?utf-8?B?eFZ0Z3RENXhOWEFScFFPQ01TRnM1Qm1jYWhETEd0dUNPYUtRRmpHM3YwbWF0?=
 =?utf-8?B?ZUhmSmErMVRIbE1HSlVzZzBlaE9oUHJHalJLY1hRZWlaY3dJN3dyOHlNZXM2?=
 =?utf-8?B?ZlEzYWpML2p4U2U4QUNGS1BSTE44Y2xEaCtETnAvL1RUOGZVNlZBZEdUK2lm?=
 =?utf-8?B?MjRyY1R5RXF6a05DbHg0WlNJQW1kUTU2a3JMNHIwcndqSmFBNEFjbTk4UzRi?=
 =?utf-8?B?SVpVYWZJUko2Y2FDVFp3M095ZXRNMnlJdllkbGN6YmRuays1ZE1GNy9aOGpE?=
 =?utf-8?B?WE43SVhCU2o4RnExWndocGErcnhCcHdEWXViaDNkU2ZmMkRIQWxuQkZMcGJr?=
 =?utf-8?B?akZwb3NLb3lvb3NrdnJ6dzkzY0FmeWRmcDBBWmFkMTFjZHZMaVR3QzQ1b3N4?=
 =?utf-8?B?VnlNZS9MSHZjWkVGeVdNR00rL2R5ODFwa0UrdlB5a0pMaVduelgwbjlnTitj?=
 =?utf-8?B?QnArazZGcmZCRzlHRHkyeDR1eXZDVldwZTlwS2FBdkVEMnBRbGNodTVSczNE?=
 =?utf-8?B?ODNMSGk0UEZ4dU90ZVhuL1BxUkNwS1FpVFlLem1ZRkVNWFp3RDhGNUJBY0d0?=
 =?utf-8?B?NFhESDJUM1B3R0YvaXV0ejJOa1pxekI2d2d4N3dUdGRxODdrOTNhRHVna2Yz?=
 =?utf-8?B?V1FMSEc3NkR2ZmM5bzZHSDRMRW51dk1ocmVSMSs5ZXdrclQ5R2JYd0FvOWRs?=
 =?utf-8?B?ZnF5N2lMbUtMZkJURlJtNlJlcmlVRWk1MDNYRDk5cmp5blBIVU5KdG9OWFAv?=
 =?utf-8?B?SjVnampMZHJqMHhvUm5DUTVGTzk2TkV0MDBjODNLaUU2TGNXc1ZyeWJhNDBQ?=
 =?utf-8?B?Nm0zL0lWK3haOURGS0NicnU3dUZKRnRGMkkyQVg4MlBHUWV0MHgwcFFyRXc3?=
 =?utf-8?B?eHhXWDhJUUkyOHczdlF2Y0FnRWFMVGVrbmFzM0ExVnBSU3IzOWppMVhsVUcr?=
 =?utf-8?B?N1ZaUmxodnk4OVV0OVJZN0Zab1NHdTh2SUp2RSt3WFhtSWc0b2tTVC9ENmph?=
 =?utf-8?B?amNhaW56SHU5VGdWMEsvNlp0VE1VRTZXenllRkc0cnl2LytabnpQMTRxT0Ja?=
 =?utf-8?B?RFlyTFkzZUdDYzRzbTBtNWdyQ1RsTFRyL1RpL2RlcWNTQUhqQ1JIaTlCNmhV?=
 =?utf-8?B?YzM4UW1CSFhVdmZNNGQ5cFc0Ynlpd3l2NzV0cTJxQkJQK1JkWndNWnVOYm4z?=
 =?utf-8?B?NHcvcGhzN1dEc2lhTWNEdTZyQklKQ1NrYnhQM3FBMkQvSCtGVDlQQW8zT1dE?=
 =?utf-8?B?VzYxSjBTa1ZZN2taZnJHQ0toTGg2UmJJVUY4K0xDdFJRUzQ5YzQ3UHk4YjhP?=
 =?utf-8?B?UjhmZzdDTjl1M2QyWEp0M3kzemFzL2FPOG55ZjJPV1FOZzJxTEpZOHZ5SFZ0?=
 =?utf-8?B?YllIR1RlblpJejJmL0U0bFJOR0taRUVnSWYrWFdXOXdPN3dQR09qb1g3YTlp?=
 =?utf-8?B?NjJRbHpCa1YwdGFrRTFkallKdjJnaElqNVlQVk0rUXYyZElqSTc4SGM2TXNV?=
 =?utf-8?B?Q210dWNjU3k5WjJGUkM0cngxTXJ0aDh1RUlQaGl6eGNOK0EzM29rTkJqNGR5?=
 =?utf-8?B?bmlENkVBRktOWWREZ2UzTStWVGZqUjU1TmRNY01LWkxZakxlUFozcldVRWw4?=
 =?utf-8?B?ZnRBVkErbk13WVA0QU40YXNkOE5rZHVST2N4RnZUMHkzei9hNGNURTZkcnNz?=
 =?utf-8?B?LzN4RnZCazk4TnpqdU1Fbzkza3VrZTdvbzRDS3NaLytPakZCRXRPWGZBSnVS?=
 =?utf-8?B?UGtOSFFZN3EvK05YS29LUjRZemRnaEhHZitzb08yOGNDSW51aExMOXFKTVJB?=
 =?utf-8?B?aW41VEdVY1M1VWhQU292RmtrbzNqa3dmY0J1Rk13aGxxT1pwWWNsU0RFQVFp?=
 =?utf-8?B?Q0NCUnNrMXhFK1BkR3dETXdkYnZVV05rK3IwdHdpbnR6YnhzdFNLVUYrc0JY?=
 =?utf-8?B?Y1dKbDZHcDdzWDRLMEV0SGYzTmhRPT0=?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfe3db7-e10d-4d43-f4a6-08de1703f1fa
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:58:04.7207 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Ge4bd/+h0GDJvjqP44yFjudw16Djf/L40+pt2FnqFgUx75zLM1oN4ULwqdfF2Jb3e/wWtgUbqsvvx5nEBp7eL3oI9tFbeyB+Bs9DlLST4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1709
Received-SPF: pass client-ip=40.107.167.94;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRZP278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Sorry for necrobumping this thread. I just wanted to follow up on this
and ask if there is still interest in this plugin API extension or if it
is going to be dropped in favor of the Lorelei patches (which would also
fulfill my original use case).

Thanks for your time,
Florian

On 06/10/2025 15:21, Florian Hofhammer wrote:
> Hi,
> 
> As originally discussed in the thread at
> https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
> and later proposed in a patch at
> https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg02218.html,
> I am sending an updated version of my patch based on the previous
> feedback.
> 
> Notable changes to v1:
> - Added a setjmp() in the syscall handling path to allow redirecting
>   the PC via cpu_loop_exit() also in syscall callbacks. The previous
>   version would only work in instruction execution / memory access
>   callback contexts, as the setjmp() corresponding to the longjmp() in
>   cpu_loop_exit() was only live in those contexts.
> - Added a flag to make sure the new API function is only called in
>   contexts where it makes sense, i.e., during execution of guest code.
> - Added a test that checks the new functionality by skipping a
>   non-existent sentinel syscall.
> 
> I made it an RFC patch this time as I am not entirely sure if my
> setting/handling of the new flag makes sense the way it is. I briefly
> looked into making the QEMU_PLUGIN_CB_* flags actual flags via a
> bitfield instead of enum values, but that would have required touching
> a lot of code all over the place, so I'm not sure this is the way to go.
> 
> Happy to get feedback and your thoughts on the patches!
> 
> Thanks,
> Florian
> 
> 
> Florian Hofhammer (2):
>   plugins: Add PC diversion API function
>   tests/tcg: add test for qemu_plugin_set_pc API
> 
>  include/qemu/qemu-plugin.h                    | 15 +++++++
>  linux-user/aarch64/cpu_loop.c                 |  2 +-
>  linux-user/alpha/cpu_loop.c                   |  2 +-
>  linux-user/arm/cpu_loop.c                     |  2 +-
>  linux-user/hexagon/cpu_loop.c                 |  2 +-
>  linux-user/hppa/cpu_loop.c                    |  4 ++
>  linux-user/i386/cpu_loop.c                    |  8 ++--
>  linux-user/include/special-errno.h            |  8 ++++
>  linux-user/loongarch64/cpu_loop.c             |  5 ++-
>  linux-user/m68k/cpu_loop.c                    |  2 +-
>  linux-user/microblaze/cpu_loop.c              |  2 +-
>  linux-user/mips/cpu_loop.c                    |  5 ++-
>  linux-user/openrisc/cpu_loop.c                |  2 +-
>  linux-user/ppc/cpu_loop.c                     |  6 ++-
>  linux-user/riscv/cpu_loop.c                   |  2 +-
>  linux-user/s390x/cpu_loop.c                   |  2 +-
>  linux-user/sh4/cpu_loop.c                     |  2 +-
>  linux-user/sparc/cpu_loop.c                   |  4 +-
>  linux-user/syscall.c                          |  8 ++++
>  linux-user/xtensa/cpu_loop.c                  |  3 ++
>  plugins/api.c                                 | 17 +++++++-
>  plugins/core.c                                | 25 ++++++-----
>  tests/tcg/multiarch/Makefile.target           | 42 +++++++++++++++++++
>  .../tcg/multiarch/test-plugin-skip-syscalls.c | 26 ++++++++++++
>  tests/tcg/plugins/syscall.c                   |  6 +++
>  25 files changed, 170 insertions(+), 32 deletions(-)
>  create mode 100644 tests/tcg/multiarch/test-plugin-skip-syscalls.c
> 

