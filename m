Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2503AC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKauH-00085b-KM; Fri, 21 Jun 2024 05:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sKauE-00084k-E4; Fri, 21 Jun 2024 05:50:06 -0400
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::61a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sKauB-0001wv-O3; Fri, 21 Jun 2024 05:50:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gtm4L16U+edFL/59hlvpvR7MKxtrdJ5wchKXI8Z1oWTdur4SW5wkPzRkMlFcr4Ob3geUCP4tfoC/PQfKusirM+pIQzaTaqItYX4kbLVGrc17dJVLa5e2vqBaFw6czZP2m9Y0qE2x0yj+ztKPERijl7xNgo7PO5g+c+d4uDEaQRULiwd4xnBTX5bjhJCYD3hF5jrrOCD/gRlJYkEeX0I59IIHNbzZu7OSdlSyrO43rAujq8O7TH6/7Q2nwuH99J81v9+jJ9pxwkeQn8nYW8v7SSUdbCWdH/SW/9RSyFwX6UQcjm1yMOTMyX3kGHEqXe5Mq1H2ZiIJfecPTvJR0ERrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us6p6FPPifYtjo4p3jv1rSm02tN2mkuomQhW+R+Az/M=;
 b=j9NLrnhEgCldvmv1DzpVRJMqD9by1kJv0W0hkoC2Bnku342b7v4ItpNOLUwjjpUzoaT77kc7s5mDWiEJcOueN58WUhzI2vvY1do5UbY97fpYzPgz4C+elEug6wdcdeijTZ6zttPWkyLmpqtyuSXAAOA4J58GZnA6FHX0Mu/QwVWX9QpVHpXEnlDl8S1w7YpXRFi0Wb8uO+uILbH9A5FjulaMb2XkaH3+npUaOKtGAm5/odoz49qmoNX3jXsNkDbYp8qrjKXSGo4+LC0tZpYhgpAfN7YdMLzo5psygTQt8nNzp35xbNXjKLVxgZbZRMYeSipuOZjRMRvr2vZxAb444g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us6p6FPPifYtjo4p3jv1rSm02tN2mkuomQhW+R+Az/M=;
 b=cy0v+KmUMriu2JWr9dlmdtgyAEcXFXRYwfF8chTh8mKC+aPX8ODgWHtpUX9Mh61XuznTPhzQS5aCzvVgjYnsWlsD7l5V7t9bHpQRCgk1Gr1Q1ALZJpQVSkdVec+s+h5nXRLGYlaZbFvg9c8sTySa/NXp8LRT5ti6OLl/I5ADmIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 09:49:55 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 09:49:55 +0000
Date: Fri, 21 Jun 2024 11:49:41 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 "'Edgar E . Iglesias'" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v3 2/3] hw/arm/xilinx_zynq: Add boot-mode property
Message-ID: <ZnVMtVcrygtlGd2f@xse-figlesia-l2.amd.com>
References: <20240620104139.217908-1-sai.pavan.boddu@amd.com>
 <20240620104139.217908-3-sai.pavan.boddu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620104139.217908-3-sai.pavan.boddu@amd.com>
X-ClientProxiedBy: FR0P281CA0210.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::14) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dd99dc-dfbc-47c6-b3fa-08dc91d7816d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnFzUFBmTWU5Wk1ZY1JkTklOempGVk5GVERkTDNNbXVUajJBRGV1Y2g1WjZx?=
 =?utf-8?B?dU52YTlvYTU2aUxmYno1dW9sdURUSno4U1J0RjM3bDFISVNrNlR2ZHYxOEd5?=
 =?utf-8?B?S3FoaUZ0VnZKcGtOZFI1Y3F3dTYzWkRvZjVvNC9idHJNeVR6TnZla1pXcGpw?=
 =?utf-8?B?cjAxMHgvaFFwR25ZZ2FlMGZOMndoZHNINEU4c2kxK3UwSnpxam53OVpnUVdi?=
 =?utf-8?B?RUNPb3hsVnBXa3FRSjVUVGV2VjM3UXFBN2JUai9SWUd4WlZOd1Mxckl5OENM?=
 =?utf-8?B?cEZzWUw0QVZsaWxYRkt2bXF6ZFJ3bWJOckVsQmRHRVBTbGtNYjcvOHFkZVJr?=
 =?utf-8?B?Yk5hNnVhZ05NckYvWDR6c29qYUF4ZEFGSEJYNWtpNGwyaGJyaTJ5eGZUbmZo?=
 =?utf-8?B?MWhKRDZhSjc5SWVIS0YxdUo1bTU5ZHlFQ3E5UkFyYTlQWUJLQ0lSbjRzT0Z3?=
 =?utf-8?B?YkszQjdIMVdXWWY3Q2tQV2JjbkhHTHY2Zk1jZFpVeVNyTFQ4Nzh2ZmVIbjlD?=
 =?utf-8?B?QWU5TCtPbTZ2dm5DaVZNYVdWd2cxb00zVllxc2ZEeUNQVThxOUVlUXZtNVZ0?=
 =?utf-8?B?UFRtOVhYdUZUWjJFMEpaYlhWTmhOWU44KzA5SGhySmFnN243RjhFSFFqNnZH?=
 =?utf-8?B?K1BpeWR3dHR0Qk5QQmY3T3VsQWpZN1pHaEdzeS9qVWR2VWNIcWlOWXhUU09B?=
 =?utf-8?B?SHBhQzI1cytJV3ZieHR5VGRFRkRRRDJFZkUwc3YwK3NJOVIzVTFuc0cyb3ln?=
 =?utf-8?B?dnAzY2NqVytVZFRDdVBWM3FBV2h6MGJBNkZnYXVoK1E2S1d0QTVhREdCSXVV?=
 =?utf-8?B?TlRiRjZINGhaT1o0czNCdjhWM1pYRUNpRDR4bXFFMlNURmc4OU5SdWJ4UU5h?=
 =?utf-8?B?MXhoZmxrTDVtU1c0aDNMMjJ1elhWbG0yaVNsOHhxalNzS3hiWWcvbFZIVVdo?=
 =?utf-8?B?QzBUWnlJTFRlcVNmQW5WeGtWSWYwQ3BVK0hhcG51V1dqNG41SHZTMDFuQkM2?=
 =?utf-8?B?M3JWUS9MZnpsWTBBeU5GNjJDMjc3YmtuSGhiMERUeFVCUmowb2hueHBHS1ZJ?=
 =?utf-8?B?YlJKQXpRWllkOWI0Q0RORTZmM2MxQlhLOE1tUisvZEM4MnVBZTB4M3RRNlZu?=
 =?utf-8?B?L05hejRWL1pvamtSTEF6eDU4QlJ4QjhzRlZrU216NDNGVjdFSmJPWW1PREp2?=
 =?utf-8?B?eWNPQW5OMjRoK0RyNWhBamp5UlVyY2diOHRKckhhU3RLck9hSE8vcU5qRHFK?=
 =?utf-8?B?ZHFtMnJncWRSTWZpQ25IaHhwdTI4dTFtSVRBMFViZWVZb2gvSTN6M2hMOCtP?=
 =?utf-8?B?Ky9YQ2ExOHpPOXdTSUZWdW11M3FBNjBKczJEaHhCZ1FGaDhzSzJHZXZaZ2dx?=
 =?utf-8?B?V21aWmE5ZDZ0bFdBd2pRdzZJOS9XWThnOXhJWkp0ZTRZcVN0cTNhWTNWK0FD?=
 =?utf-8?B?TGxjU0NiNCtGWmhNOHN2YnNZRnJIRDA2SnJUbGttM3pqcjUySUVwZXM3Y2Q4?=
 =?utf-8?B?N2R0TnJveHBWKzZoVG5RNkRSZHpsMWtUUjdlaVpRVzVIbjUvV0hIb3N2VWha?=
 =?utf-8?B?Zm9PZ2dEVmZPUXUzSHpMUUU0ZDFuRys0em1sNVJrdUY2dEx0eU8wN1VZQ1do?=
 =?utf-8?B?bjdVeVZGS3lOdG1SdTMrNVQ4TTYxeCthTk5XVWZ0djdxMmNETjh0YklRWkw1?=
 =?utf-8?B?VDgzcWlKNFpXK0owczQ5V3lyNzhPY2c5eFowUFp3SWFwakdEN2NMYm10Umo2?=
 =?utf-8?Q?WsAgl4q8Yfe3lci3dwj2uyO5JiYtTq4kYtJ1F45?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjE2TXErNDIvZDloZUIyS0RaUm5xQ1I3RE85ZXRPdEJtcElibWJaVHNBd1Ro?=
 =?utf-8?B?ZGZBTlBjRjhHemxpbGNZeGpYbDZuNnpYMHpTdHY2SjVFZ0YrZFdRdXpXN1Fo?=
 =?utf-8?B?L1dISEZVQStSeHAxL1NhRm16bjJ5MnN0ZWtEREh6S3p2M2daUERGM3ZSeFBF?=
 =?utf-8?B?b2E5aFM5T1JYczBOOTZxVU5NeG44c05KbyswOHRucDNMREpzTnNIT1VxL3Zn?=
 =?utf-8?B?OS91UWlUN2doVWdJa3RSeTJvNW1taWFMcFd5djNqYVlBOVZzNmlCYXdTZTJY?=
 =?utf-8?B?TjNIb0VZZkFGVzdoUTlJazg0dHQ5TmVEQldFSmtYK1ZLQitKYThUbVZjb1hw?=
 =?utf-8?B?cjBzVWNYQ2dBV3lKRWp3UUg3bzAxK00yVTZuQzRxTU10bGxzZTFmYUpjYW5t?=
 =?utf-8?B?eTk5QmxVMUVOdFExSURlRTZTcW9SYXlPZ2VpS1N0MU1oMEF5cWptWnBwZm5x?=
 =?utf-8?B?RUtlNVVQc2l2Tm9kWjRhMmV1eHFKWnRwOWRpb1dQRTA2RHpweEFsdC82MFBR?=
 =?utf-8?B?aUhCQ3VnanRjMC9lQ3RmZWNuZWp1ejRMRDh3eXRQcEZyam8rYUN5LzB0Sm8z?=
 =?utf-8?B?U1ltaGgrdDJaVWgvQXNRWE5kcWNBVjZjeFlVaThtYkNxcTJDUWkzbkNYbXdN?=
 =?utf-8?B?VllJWTdBWk5MTHJnM21IQ295MFRGR2c4OFhKUG1QNEJTWHAwdk9pYjlyOFdo?=
 =?utf-8?B?ZnhrcFg0dDZHSGovUTZWd2hRSWhna3NUR2JONVgvazgxSHdGRUEzM1crNDdw?=
 =?utf-8?B?TlRrZ09kMjJYNFMxN3BTUFBxSWxXNFJrcTVTRktTbHFCa0RSWEhIT2hqaEZJ?=
 =?utf-8?B?VTBvaXRjL3p6bVo0cnptSVYwSDB2MzlJeThCTlI4UHZSUU5RYktuUWlvbDEr?=
 =?utf-8?B?UERhQldFYnF4Y1RZMEpjS0VVOTlSZzN4eURoaS94WWFvUHNxazVSd1U1VmRu?=
 =?utf-8?B?ZkFSQWs4SDVveGJJMjZrSlVhdVRCQTlwWmk3NTZmbWZyWDBKU0tubWx0V1E3?=
 =?utf-8?B?czRaODlhb0ZuV2N4VEx4SmdqNmZMWU5pZzhBUzJ6a0lFNDNucTU2aDJtekpN?=
 =?utf-8?B?UGluV29RZWlUSEFHL3RobDBqTS9Ba1d6aTQ2NWJyWUhMcFc5ekRjMGNmZHlp?=
 =?utf-8?B?STBzeW1lcVc1NXpKSlRVRXV1UWsyTkRMUHViZEtvejF5ZzZQaEMydlpwYzc5?=
 =?utf-8?B?ZCsvZlMvTldYcVlkMUMxZy9aRjFhZXRXMFY0VmVXOXlLQk4xTmp0dm9aaEF4?=
 =?utf-8?B?T1U3SW9sZExmOS9wNk9RdVA3b1diVXNIK1FMWHN6ekNQUUNWMGZxK1AyMHJZ?=
 =?utf-8?B?SmdTMldpWVdxRk1wL2pEOHBiSExuSkhtZGVkaFVOaENRbTl5SjFnQ2NIaXdx?=
 =?utf-8?B?ZmM0WnY4UXZBd1JJWkVFdEhhSmVQR2Vvc0FBWmxaNkhVdC9qeTQ3R1I0SVkw?=
 =?utf-8?B?c0FrN2tDMVpwWGdLdUtXZlpkaXZyaTlVcVNxaU1qR2lXZ1FieThKUE04cEFx?=
 =?utf-8?B?SlkwSjNEMndFWVpnR2VIQWJlYzl3YmdnR2NuZWNBWjMrUEJraEUraHJ4REFl?=
 =?utf-8?B?dG92cnd6dU9INlU0T3VaaVk3eXVZUkppZmpqSS8xcjM4TVk4dE9hOHhOTVNz?=
 =?utf-8?B?NVhIVlNsS2hqdGc1UHN6TVBoSlZMZzIwdkhocHZwSkI1L1B3QnhpZmFMeURH?=
 =?utf-8?B?cVR3WncvODE0UXV1SkpCSXpWSVM3R1gwazBmbGIxdWNYM0pIWVl0R3ptR1lk?=
 =?utf-8?B?bUY0M01lMnZPaDIvdzdtRUI0MVFmTXYyRzhQUXhQV2pPUnFxN1NiNzBKaUsw?=
 =?utf-8?B?blJwUm9meFFTYW9rK29BMCtTUzRDeHo0Wm9HSE5USmU3QUttRTVvUXdaa2xC?=
 =?utf-8?B?NG1sR20vaTVrK2FubnhYZ0VGQ1gwVjVkanBJTDJRc2ozU3BWN2pnbUpoSHZv?=
 =?utf-8?B?OUROamFhMlFXU08zdUZTOXdVR2VsMDFRbElhQk5iT0cySjBpQVlJOFNxaUFT?=
 =?utf-8?B?bktRaGt1MHdzZ3ZRZWVsRlhCM2k0QzJONld1NVRvekUyVThLMzNoWjdFaENq?=
 =?utf-8?B?OW85WGhKVUR5KzV3N0N5Q0dPVVc2bHg3MVk1WC9HWU1FZDZoTzJLYjFETnpi?=
 =?utf-8?Q?NozUz+BIQ3AJ38zlw5tdiyzQX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dd99dc-dfbc-47c6-b3fa-08dc91d7816d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 09:49:55.6669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mszuN3WntoKb34alA7ulL6rAd+Ednvg2wEAo/Tc6H9hs/9UMLrB4zcYstc+j1oXuPleHU+CQVR2uHWL3+yieZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
Received-SPF: permerror client-ip=2a01:111:f403:200a::61a;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Sai,

Some optional suggestions below and minor indentation correction. 

On Thu, Jun 20, 2024 at 04:11:38PM +0530, Sai Pavan Boddu wrote:
> Read boot-mode value as machine property and propagate that to
> SLCR.BOOT_MODE register.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>  hw/arm/xilinx_zynq.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 7f7a3d23fbe..39f07e6dfd8 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -38,6 +38,7 @@
>  #include "qom/object.h"
>  #include "exec/tswap.h"
>  #include "target/arm/cpu-qom.h"
> +#include "qapi/visitor.h"
>  
>  #define TYPE_ZYNQ_MACHINE MACHINE_TYPE_NAME("xilinx-zynq-a9")
>  OBJECT_DECLARE_SIMPLE_TYPE(ZynqMachineState, ZYNQ_MACHINE)
> @@ -90,6 +91,7 @@ struct ZynqMachineState {
>      MachineState parent;
>      Clock *ps_clk;
>      ARMCPU *cpu[ZYNQ_MAX_CPUS];
> +    uint8_t boot_mode;
>  };
>  
>  static void zynq_write_board_setup(ARMCPU *cpu,
> @@ -176,6 +178,27 @@ static inline int zynq_init_spi_flashes(uint32_t base_addr, qemu_irq irq,
>      return unit;
>  }
>  
> +static void zynq_set_boot_mode(Object *obj, const char *str,
> +                                               Error **errp)
> +{
> +    ZynqMachineState *m = ZYNQ_MACHINE(obj);
> +    uint8_t mode = 0;
> +
> +    if (!strcasecmp(str, "QSPI")) {
> +        mode = 1;
> +    } else if (!strcasecmp(str, "SD")) {
> +        mode = 5;
> +    } else if (!strcasecmp(str, "NOR")) {
> +        mode = 2;
> +    } else if (!strcasecmp(str, "JTAG")) {

Suggestion 1 is to use strncasecmp above.

> +        mode = 0;
> +    } else {
> +        error_setg(errp, "bootmode %s not supported", str);

Suggestion 2 is to do s/bootmode/boot mode/ above (for matching the error
message in patch 1).

> +        return;
> +    }
> +    m->boot_mode = mode;
> +}
> +
>  static void zynq_init(MachineState *machine)
>  {
>      ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
> @@ -241,6 +264,7 @@ static void zynq_init(MachineState *machine)
>      /* Create slcr, keep a pointer to connect clocks */
>      slcr = qdev_new("xilinx-zynq_slcr");
>      qdev_connect_clock_in(slcr, "ps_clk", zynq_machine->ps_clk);
> +    qdev_prop_set_uint8(slcr, "boot-mode", zynq_machine->boot_mode);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(slcr), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
>  
> @@ -372,6 +396,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
>          NULL
>      };
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    ObjectProperty *prop;
>      mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
>      mc->init = zynq_init;
>      mc->max_cpus = ZYNQ_MAX_CPUS;
> @@ -379,6 +404,12 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
>      mc->ignore_memory_transaction_failures = true;
>      mc->valid_cpu_types = valid_cpu_types;
>      mc->default_ram_id = "zynq.ext_ram";
> +    prop = object_class_property_add_str(oc, "boot-mode", NULL,
> +                              zynq_set_boot_mode);

Indentation on above line needs be corrected.

With above corrected:

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>


> +    object_class_property_set_description(oc, "boot-mode",
> +                                          "Supported boot modes:"
> +                                          " JTAG QSPI SD NOR");

Suggestion 3 use lower case on above to match patch 3.

> +    object_property_set_default_str(prop, "QSPI");
>  }
>  
>  static const TypeInfo zynq_machine_type = {
> -- 
> 2.34.1
> 

