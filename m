Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47652E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtp6-0003iA-Ib; Thu, 09 Jan 2025 09:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hank.knox@mcgill.ca>)
 id 1tVthO-0000Na-J1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:39:50 -0500
Received: from mail-canadaeastazon11020084.outbound.protection.outlook.com
 ([52.101.191.84] helo=YQZPR01CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hank.knox@mcgill.ca>)
 id 1tVthL-0006pe-K2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:39:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+f5jdiHp89cCqIfUZUiHwX8lMvTrLcc1pEr5gV3gp84+Yz7QJkwDhnLob8v9Oa0YL85O09bTng95rTv3vSAnyaDk/WSL4x+UQA856uMdxjrIChA52+jsBE/NXRF48syS8CmgEc4e0vzMQbdXJ/7qotyTIuwZGLvVU290p8FCDeZekm1fyna+rSuhSxVVZtaZyFIOVjMnwRGNhuxg029XZg+VFg/OSJEfP3SsXfMjzcBiYWAuSnO7q2ok7JuqieEtEFSY4AabL0FifJ6JC3eDPnbsvPOCi+ueWIsjjc9d2ikjR+J9OWttZt6ervbPyz/3zkntD8KxqFomFl27+Bn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHWuoT7kx0GaLRfttVvZGdArjA0CQlZUCSqGiQYJ1Y0=;
 b=AB8yK3oACiJfDcDZ2e/M2/iaBUfTr92Kc62tKuYVRhEYTwN53eGKicrH+Niym1UIi4IRInsH5jEcntoy+X075Yt+CYVn9ouxld4TihSJMKNKLWeJENRLVFy5A83AMz2+sJLnHnHCW30NCdGsH0MrvkkCGL5pOVwaqO+letmcNPcOC89xkY0vOGJMU0/SPKvUz0mU08ysyb/SadHYrB1+TgXM0bvDJsC1phXLyqERQTDXS70/fkPPHMwntkADtcaCTK5lio9DcMn8rf06ryH3wXKWA9SHvlVvj/86g299b/K6hwT98AefoFMVTW1mi99jjOVIBUFQLAhv3pmS6nHi7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mcgill.ca; dmarc=pass action=none header.from=mcgill.ca;
 dkim=pass header.d=mcgill.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mcgill.ca; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHWuoT7kx0GaLRfttVvZGdArjA0CQlZUCSqGiQYJ1Y0=;
 b=ap4Hw84dm8zAoPJDVKZqB3AYaXpQppc7w9zdr2NUeLgz3F6mMUnQGYvWJHwMQgKLyfvyw4rNv3rbldta2+dTP9TYmweUZj37RmySH3WoN62fMB/vE3mGMAHM0YZclNt5IX4SA2WBTHn/38mrQPWSx+GmY2+HgHTQe9MVSPCxoSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mcgill.ca;
Received: from YQXPR01MB6431.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::6)
 by YT2PR01MB9970.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 14:34:43 +0000
Received: from YQXPR01MB6431.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bfdd:bc1b:f934:842a]) by YQXPR01MB6431.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bfdd:bc1b:f934:842a%3]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 14:34:43 +0000
Message-ID: <5a5917ef-2003-46e2-b89f-23a259231f3c@mcgill.ca>
Date: Thu, 9 Jan 2025 09:34:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 11/13] ui/console: Remove dpy_cursor_define_supported()
To: Michael Weiser <michael@weiser.dinsnail.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240716180941.40211-1-philmd@linaro.org>
 <20240716180941.40211-12-philmd@linaro.org>
 <f0b1df5e-4eee-4a56-a8a0-5426cdf2b3d5@tls.msk.ru>
 <CAAibmn1FQgHwt4LapR1gJzyue4bf7Uhbua0sxGg+PxaEjR0Row@mail.gmail.com>
 <Z3_WHQI3GMepJkxp@weiser.dinsnail.net>
Content-Language: en-US
From: Hank Knox <hank.knox@mcgill.ca>
Organization: McGill University
In-Reply-To: <Z3_WHQI3GMepJkxp@weiser.dinsnail.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::22) To YQXPR01MB6431.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:43::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB6431:EE_|YT2PR01MB9970:EE_
X-MS-Office365-Filtering-Correlation-Id: 216ae29a-723c-49e6-82fb-08dd30bac214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW8wNFFsWGRWWUdkUkgxVDNWOURDRDZwUGwxU3ZFOTBnZ09DMUpkYXp0VHVT?=
 =?utf-8?B?V0pwMUxCRHpmQjlaZWdaOWk1MlAvcS9xdUJkMzFpK0NUcksyYmJ3eTVhbUpw?=
 =?utf-8?B?S1hsV2NhUUlmcTRqTnVoZTBOOEVIRG9MSkgxdERrOWtEbkIyUm9VRGNKK0hC?=
 =?utf-8?B?dVRsMjN1T09sNDJJZUFJNE9rcHY2YVRLRGU4NlAydGZBTTAwdnFZZERFR0VH?=
 =?utf-8?B?NzBJcUtUejBZUVRjelQxakZXMkpuTzcxcXl4TlhBcnZGOFA4VllGNDRJTFpG?=
 =?utf-8?B?VWp5T3YxTEVyR0tFaWgwc2pjTG1tOGVPWFRkY1RTVnVOWnlKdUZmK3ZIUDlt?=
 =?utf-8?B?b3lWSVkxVlJNbjZqTnJwWDlaeWs3TFBPYVlWQThoa1J0cVNIV0ZYaVNqVG85?=
 =?utf-8?B?V3h6anIvUG1YVVRFTkZLV2ZoSXZLSzU4dzVrN1NxNlMwcUZxdTQ0MWVOVVVP?=
 =?utf-8?B?TFd6VENJSVM3ZXVPcUdNTUtMY1p6WTlnb3pVMkhrNmt2OHgyVTdzOW5pbTRE?=
 =?utf-8?B?RFNhSUVjR0xLTS9xMWE4VGxBUVJsNE91aDU5Q05BUy84L0pzZVpYUk92NlNv?=
 =?utf-8?B?dkRLcFFLL282SCswQmxpMDNoUnU3MWluUG1XRnB5MWlwSzlPTHcyUFVNUndy?=
 =?utf-8?B?S3BCWWlveE1rZmZxYUthRkpBclY2SW43YnJFa1VxdmJMSUlNRjhvWkdFVU9t?=
 =?utf-8?B?V2ZsaUtpa0g4V3ZiTnRUbFBqZWxuS0NiOFg1cXZmdGFRWkxQRXlZdm5SSGdt?=
 =?utf-8?B?akExb2JxT0JkdXF0Qmo4ZVdWU3lFVS9XT1d2Tk1RR3Izait2TlV1QmtZVG41?=
 =?utf-8?B?Q2xkbWNwb0hBWk1uVnBiUXh1VkdCbTVHUW4wQUNCRzhSOCtYMVZHaVhRTlhU?=
 =?utf-8?B?c3BFWkxwRDJic3k5QkEvYXYwRHNqa3ZZdjE3NFFRMXN2SzZXbk5obi9Lb1ZP?=
 =?utf-8?B?eGhZaXF3V3BJajFkR2d2YmwyelNlajZ5UFBrQm12RXVZcjlzQWlxdGVTNDla?=
 =?utf-8?B?YVBhVklpZWI3VTJxYlUzdXNvdEZodXVjYUFBZUprSm41R2dsRnFRVitxZFBv?=
 =?utf-8?B?cXpOZDJvamJ2Vm5VaUdyVm0zQWVBbk9wcEpEeGV0N3l6OUs0Mm0xdCtDOVNr?=
 =?utf-8?B?Y0IwK2U1bjBKSlkyWVg5Ym5mMzFSeU5XcTE5ZC9rb2Ztb3g1c3JQNFdEdFBi?=
 =?utf-8?B?NkdoZGgrUFBsanVudEhSVEpvK0hqMkRFNC82UDNoUEc1dkVCYVFqQzBZNHZL?=
 =?utf-8?B?S0QyaE1TRW5RSjBha1FXTkdjQjh1NlByODNUM3Voem9lcE41YVB3L05mNWNV?=
 =?utf-8?B?dGVWSTJvUDh3WGRWWjRoNTltdmdBUllMbG5STHJyNjFVVVIzNDAwejlvb3NO?=
 =?utf-8?B?ZjUvUHRjSUhNamFpK0VTNndIRlBzK0tVRTJiZ1B4b0NxSHZacHdLck80WEpC?=
 =?utf-8?B?M1o1Sm9NSzQyN0RyTW45OXpSVGMvYjBHOFRjZDFIMGdMWml3b0hVaUF5SHlN?=
 =?utf-8?B?MkJDeVRUTXBCay9VV3JCRzBkdU1uanJKV1ByS2NRc1R0ODhQL2FkY1NWUlNn?=
 =?utf-8?B?Z1RvRDVlUlNYTTlWNGVpOGwvZHZIalhKL0p1R0JqWXVZaHB5WWVXSkRXbEhx?=
 =?utf-8?B?ZFhZY0VvUnF2ZitObmxVWU1obG1hRmdrTDh1VW9nSzBlNXZ4VHpZdm05TFRU?=
 =?utf-8?B?Z1NXYmVsOXQ1Sk9NdXc4ZWRFcGFVNVR4SlB1NXhCRUJWNUh6a2ZlWkZOdGRL?=
 =?utf-8?Q?LiLy/yrdakyRflJI2RZlyXIXs10LjV/L+d39eGo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQXPR01MB6431.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUtpUGpuTlFTbTJoU2VlemVvZ3g5enBkNGdaSmVnWHpnODlhdC9rVVlhWGRi?=
 =?utf-8?B?NUh1bkMranRxdFJHaXJpNitqOElPZFZZWG9Ma21iTis0Sm5uMi85R1ZpOEhR?=
 =?utf-8?B?cHlwNk1MQTBUbVAzZWFDY1BuNjk5U2c5VFdPa3ljTVlHRzU2MVdMbjJrNVBp?=
 =?utf-8?B?ZWFyMk9DM0xPMkkrQnBuQlg5OVdEckFBWkJaSzRVRGp4d2hpSnh1WU5Zc3Q0?=
 =?utf-8?B?amVNV0VycjB6SmZOS0E4akNBMlRmMCtLV0lhdlB4SXZrN0pJQVVRb1NZZ3ZI?=
 =?utf-8?B?MDlad2VRMHdXOWUxSWIvT2EwTWg4WEpac1ZBd1JlMWNXTEg5bmhOUHN2MWV5?=
 =?utf-8?B?c2NTMVZCRStnNGZPVWVTTmhkMXR3QTM2aUN0a3ZEUGhVZXhuRlZUUmhFdzJi?=
 =?utf-8?B?L2hiTWZhby9FQ0luVWZERW52RXlPRWEweG4reXBTT2R2M1lKQmlJU0QrSFlB?=
 =?utf-8?B?aU1BcFZLMnF2YjBxVUlxZGZpM2sraXJZVWpDZ3dEU2pTOCtPSmV3Ni8xdmpl?=
 =?utf-8?B?VUtkd2J1RE5hTmVBbWUzbFhsU0ZRck9NNjhJM0xSMThBaEpHUjVzVittOFUv?=
 =?utf-8?B?N2NySW12TEkwaUlOZTBRRUlHNEk5MlhaN2ZsWUJvblJzUWNqYnFDTmY1Mmxz?=
 =?utf-8?B?NXVaSms2cGRMYmVXMGFIdmpFQzNqMkY5YTIrSDBjNGFweTFSSFVjZWM2VXpu?=
 =?utf-8?B?U1B1alBXN3ZGY20rVCtrUTVqb1JFN3lQcTNFcmVkbHJ3eHdmOEVyZ0g1eVJn?=
 =?utf-8?B?U3BSQTV4bko0OUwxNUZBQURCL3VnaEtKRE1LT2FLdUtybTNleFJ3d3kwNjl6?=
 =?utf-8?B?TlVyNTAyNWFCZWNIenE4N1BpclpVN0pvZ1N1akRKSVFvcHlHSkJ5eDZNQlRR?=
 =?utf-8?B?bEdxeXcwUzBCVVZ6V0J0WmtUdVJnTXlLVVdtNXJVZitOZC9mS3BpSW8zdkZ4?=
 =?utf-8?B?N2EwN2FndDVZdkJZZzNIWGdwZjZmSllzNjlac1B4ckMvTXhxK0hrd2hBV2ls?=
 =?utf-8?B?TU9KOG9YZTZ2RnZMbWlTWEVISi9sb2o1MUE4KzdMaVFiS3Q0M2JmOEJkanBx?=
 =?utf-8?B?QTJsVU42SnhMYlZzTE5CMlQ5TlhIUEpXcGxjejN6VkRQdjM3NklZZm1SRytU?=
 =?utf-8?B?OVhPUDU0SjBVS1pUZENyTE1KaFF3bzRGZ05iSDVDV20zdTYweDNQemJzcDFq?=
 =?utf-8?B?U3NlZndydDRuQlp3elNDdWJBVGtVTWVFZXNBcHoyS0lWQUdLSGsxS2tKSktW?=
 =?utf-8?B?Rk5aK3JyYVJpTE82OGgxSXV2TkpTZDdXTzVxQUc5WkFjSXZXVHJLUXJ0VXJI?=
 =?utf-8?B?QUpZVXVjL051aXJuY2hxL1FjdDVMQ2hrejQvTmRjN1c4cW1XT2Y2NHFwNUdC?=
 =?utf-8?B?ejJCTnBoNndQWDUvakVsRkRsc3BlZ0ZWUXQvaUhodzI0RlBJZ2FNOWlvT2Js?=
 =?utf-8?B?ZG1BRFc4WkVXSDJ3a0hRODRXOERoYmxoZmtUYnRTL21NTnJvamVEOUFza0U5?=
 =?utf-8?B?THdpcXBvSnBjZ1B5eld1TWkycUFsc28vanRDUklyWUNXR015dlpxekJtMGlv?=
 =?utf-8?B?Mi9MbzlYak9xQ0ZvVC9CYjVSMjhLVHBzSjVMQldTL2g3RDZSYmtRckFIdyt4?=
 =?utf-8?B?d1oxRlkzS1BndmhKRzF2YzAzV3AwUjJhN3pvMHViY2VPRUJsVXZwSTN3OWdG?=
 =?utf-8?B?bVJTSHZETGNRWGhOOHJqL2lVbHgrdElFQkhNNXN3VW9Ud0VrU3FkN2JrV3kr?=
 =?utf-8?B?eEE4VWlEcWhaZjgrL2w3STZJZE42a1BTVkNiWVp5bDhLZm5XRGVlNnlPNUpQ?=
 =?utf-8?B?elFUMHJnQkJRaHZSazVoemg5WENDSFNWVDMrK0ZraXpIdVh1eE5SWUNWaXZG?=
 =?utf-8?B?THZhYVdYa09MRzlaRktHam1jMUVYWDAweWNhS2xjZXhlT2VIbzJ1RWxjTGVn?=
 =?utf-8?B?aWJCUkkveU02anVKckNhb2x2cllPQWN4Ymk5VHRUOC9BSTZ5cTZSRnpVc08w?=
 =?utf-8?B?SDVhZG9qTys4UVRQcnFCT3RhS1JLZHlreEs4Y1VSTWJLMFNJK2ZueWxqcGN4?=
 =?utf-8?B?eGh5RDRJNXkvMmRoMHJaZzVxUUdIYXVrTXYveG9Ic2VoVDJHWklwM2w1ZEwx?=
 =?utf-8?Q?ar0DA/2vDvTUHMTaL7li8tmcD?=
X-OriginatorOrg: mcgill.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 216ae29a-723c-49e6-82fb-08dd30bac214
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB6431.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 14:34:43.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cd319671-52e7-4a68-afa9-fcf8f89f09ea
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4jjSAzVilQjsLXGTQm+07BpcD3xzQWvcOUuVbKk/IaEEeVHk2Zz7LXnQg+g1epsc3gKyX9Vzb2RxXu5p8xdHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9970
Received-SPF: pass client-ip=52.101.191.84; envelope-from=hank.knox@mcgill.ca;
 helo=YQZPR01CU011.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Jan 2025 09:47:45 -0500
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

Dear Michael W et al,

Thank you for following up on this. While waiting for a fix, I have been 
using a build I made myself that applies the patch listed at the bottom 
of this email to the v9.2.0 branch of the code (which has  
dpy_cursor_define_supported() removed) and it has been working fine ever 
since. I also have the display scaled to 150%. I don't have any other 
insights or clues into causes or fixes.

Since I last responded to the bug report I filed on the Debian bug 
tracker (#1084199), I have read on the Debian User Forums (where I also 
went looking for help) that several other people are having trouble with 
this issue. They found, like you did, that reverting to 9.0.2 fixed the 
problem. You can find the thread at 
https://forums.debian.net/viewtopic.php?t=160631 but I don't see any new 
clues there.

I also am very happy to test any possible patches and to gather any 
other information, to the limits of my tech ability.

Best,

Hank


On 1/9/25 08:58, Michael Weiser wrote:
> Hello Hank, Michael, Phil,
>
>>>> Remove dpy_cursor_define_supported() as it brings no benefit today and
>>>> it has a few inherent problems.
> commit 4bba839808bb1c4f500a11462220a687b4d9ab25
> Author: Akihiko Odaki <akihiko.odaki@daynix.com>
> Date:   Mon Jul 15 14:25:45 2024 +0900
>
>      ui/console: Remove dpy_cursor_define_supported()
>
>>> Apparently this commit made windows10 guest to freeze.  There's a rather
>>> hairy bugreport at https://bugs.debian.org/1084199 .  Also there's an
>>> interesting bug filed against qemu,
>>> https://gitlab.com/qemu-project/qemu/-/issues/1628 ,
>>> which seems to be relevant.
> Thanks for looking into this! I am now also affected by this bug and
> highly motivated to resolve it. :)
>
> I recently updated my Gentoo Linux system which included an update of
> qemu from 9.0.2 to 9.2.0. After that I began to experience the issue
> reported by Hank with a Windows 10 VM in libvirt using QXL graphics with
> SPICE in virt-viewer. The Windows is fully updated and I've tried
> installing the most recent guest drivers to no avail
> (virtio-win-0.1.266.iso).
>
> I've reconfirmed the issue with a freshly installed Windows 11, fully
> updated and the same driver ISO.
>
> Downgrading to 9.0.4 makes it go away. Downgrading to 9.1.2 does not.
> Reverting above commit off of 9.2.0 as a custom patch to the Gentoo
> package makes it go away as well.
>
> At this point I grabbed the git repo and started another bisect between
> 9.0.0 and 9.1.0. During that I found a good "reproducer" to be to
> frantically click on all the application icons on my desktop as fast as
> possible (Firefox, Edge, LibreOffice, Chrome and PuTTY, FWIW). Apart
> from a lot of CPU load, disk I/O and memory pressure it also causes
> frequent cursor changes from pointer to spinning wheel to pointer with
> spinning wheel. If nothing else, it helps pass the time to the freeze.
> :)
>
> With that I ended up at exactly the same commit as Hank found above.
> Reverting that commit off of current devel HEAD makes the problem go
> away as well. With vanilla devel HEAD the freezes persist/come back.
>
> I can also confirm that the issue has to do with scaling of Windows UI
> elements. At 100% the freezes to not appear (or at least not so I can
> trigger them with my "reproducer"). At 150% or 200% scaling I can
> trigger them quite quickly (< 30s).
>
> Also, identically to Hank's findings, the VM continues to respond to
> ICMP requests (ping) as well as agent requests from virsh (e.g.
> guestinfo). A shutdown command however hangs/times out.
>
> On Tue, Oct 29, 2024 at 03:04:29PM +0100, Phil Dennis-Jordan wrote:
>
>> Can we get the user to set qxl->debug to a value > 1 and see if the freeze
>> coincides with logging from here? (Possibly tricky to intercept the fprintf
>> output from Qemu run via libvirt though.)
> How would I do that? On the source level or is there an environment
> variable/command line option?
>
>> Given that "The time before the freeze seems to be random, from a few
>> seconds to a couple of minutes." there is a possibility of a false
>> negative during the bisect. (i.e. commit marked GOOD that should be BAD
>> because it happened to not hit the freeze in the usual time)
> I went to the commit before this one and the issue disappeared. Also the
> positive effect of reverting it off of HEAD seems to suggest that if not
> the main culprit it at least makes the possibly underlying issue
> surface.
>
>> We could ask the user to check whether there's any connection with mouse
>> cursor changes, e.g. whether he can more easily provoke the issue by
>> perform actions that rapidly change the mouse cursor. (For example by
>> visiting https://developer.mozilla.org/en-US/docs/Web/CSS/cursor in the
>> guest and moving back and forth over the test area.)
> I've extracted the IFrame URL
> https://interactive-examples.mdn.mozilla.net/pages/css/cursor.html from
> this and played with it for some time.
>
> On an idling system the cursor changes do not seem to be enough to
> trigger the issue. Once I start to put load on the system by starting
> applications as per my "reproducer" I can no longer be sure if and how
> cursor changes play into it because lots of windows start popping up.
> All hangs I can remember have been showing the segmented spinning blue
> wheel animated cursor though.
>
>> Is there an easy way to take a sampling profile on Linux that will show us
>> stack traces of all the threads in the frozen Qemu process? On macOS this
>> is easy with the Activity Monitor GUI or iprofiler on the command line.
>> That ought to confirm whether it's a deadlock or indefinite wait in some
>> Qemu subsystem.
> The stuck qemu still does things at about 3% CPU load.
> I can attach to it with gdb and pull the thread list below.
> Do any of those look interesting to you?
>
> (gdb) info threads
>    Id   Target Id                                            Frame
> * 1    Thread 0x7f0eada740c0 (LWP 741887) "qemu-system-x86" 0x00007f0eaf73e656 in ppoll () from /usr/lib64/libc.so.6
>    2    Thread 0x7f0ccdffb6c0 (LWP 742004) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    3    Thread 0x7f0cceffd6c0 (LWP 742002) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    4    Thread 0x7f0ced7fa6c0 (LWP 741998) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    5    Thread 0x7f0cee7fc6c0 (LWP 741996) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    6    Thread 0x7f0ceffff6c0 (LWP 741993) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    7    Thread 0x7f0d0d7fa6c0 (LWP 741991) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    8    Thread 0x7f0d0e7fc6c0 (LWP 741989) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    9    Thread 0x7f0d0f7fe6c0 (LWP 741987) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    10   Thread 0x7f0d2d7fa6c0 (LWP 741984) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    11   Thread 0x7f0d2f7fe6c0 (LWP 741980) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    12   Thread 0x7f0d2ffff6c0 (LWP 741917) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    13   Thread 0x7f0d514f76c0 (LWP 741915) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    14   Thread 0x7f0d52cfa6c0 (LWP 741912) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    15   Thread 0x7f0d534fb6c0 (LWP 741911) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    16   Thread 0x7f0d53cfc6c0 (LWP 741910) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    17   Thread 0x7f0d591986c0 (LWP 741905) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    18   Thread 0x7f0d6531e6c0 (LWP 741902) "worker"          0x00007f0eaf6d785e in ?? () from /usr/lib64/libc.so.6
>    19   Thread 0x7f0d9afff6c0 (LWP 741900) "SPICE Worker"    0x00007f0eaf73e656 in ppoll () from /usr/lib64/libc.so.6
>    20   Thread 0x7f0ea89ff6c0 (LWP 741898) "CPU 1/KVM"       0x00007f0eaf74534f in ioctl () from /usr/lib64/libc.so.6
>    21   Thread 0x7f0ea95a96c0 (LWP 741897) "CPU 0/KVM"       0x00007f0eaf74534f in ioctl () from /usr/lib64/libc.so.6
>    22   Thread 0x7f0ea9daa6c0 (LWP 741896) "IO mon_iothread" 0x00007f0eaf73e656 in ppoll () from /usr/lib64/libc.so.6
>    23   Thread 0x7f0eada740c0 (LWP 741895) "vhost-741887"    0x0000000000000000 in ?? ()
>    24   Thread 0x7f0eada740c0 (LWP 741894) "kvm-nx-lpage-re" 0x0000000000000000 in ?? ()
>    25   Thread 0x7f0eab8356c0 (LWP 741892) "qemu-system-x86" 0x00007f0eaf74776d in syscall () from /usr/lib64/libc.so.6
>
> This is right after the display gets stuck. The workers die down over time.
>
>> Michael, what's the situation with the patch you suggested in your comment
>> on the Qemu bug:
>> https://gitlab.com/qemu-project/qemu/-/issues/1628#note_2144606625 ? Is
>> there any chance we can get the Debian user to try that?
> This patch on top of current devel HEAD (as well as directly on top of
> the commit in question) makes it worse: The freezes start happening
> immediately after the desktop shell is started. I think I've even seen it
> freeze when the boot logo and spinner were still showing, possibly when
> the (also scaled) login screen tries to initialise.
>
> I'm out of my depth further narrowing down the cause and standing by to
> try whatever you tell me.

-- 
Hank Knox, FRSC
Schulich School of Music of
McGill University (retired)
Montreal, QC


