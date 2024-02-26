Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D8E3C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1regkQ-0007lN-LC; Mon, 26 Feb 2024 14:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1regkO-0007kh-Ow
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:34:44 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1regkL-0001NO-Ui
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:34:44 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41QB4cSw011197; Mon, 26 Feb 2024 11:34:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=GtxFGZWuaQ/U
 bWCK1V30C5klivP190PteHyjjx6+zfo=; b=q75aYHaiMnHqqoTOdAGKUsbpfRI5
 g+Vt9PViVU8fTcq9jfCv69IbgI8HsZ0A5yaYtnOAN7S2VamxiIDvrXp5zV3xClUc
 tzfEJwO1j1H0CsdpCbnoUar01XPV/Q0TGOzSEgf4iRAHuBKFU1fBwfGNUsQWr8oa
 kEXbhX6sgo0r3aeFfwwo8rvB6jIqG36Mu0MhO6uYDHdfGiMqnKC092Kc9V2GMHfG
 yk5V9aR4xMuNtc6xpvyyQzTJFCTdf0L4rh4Cv5OwskEiAWIUI1+o2W2fkMqEUabP
 8iqLT03eyC+mD1yJllT4PK/4WXFoz0nZcxUzummo54AS9b+7YzJzKhg2yQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wfgw0m80t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 11:34:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+8H743IcOraJLYidahVva6cpDGhRIJhtlwQBKDuvKIOV9+YsTrEjl1Sw0l1J5J7m7x5wM59GbYbHVCUJ1zRVL/3fN2AMobJRfUZgXBPIWsxqp0KnDBgtLXOUTd2U9AT0EAGSDh6J87yATabJHFDPagYrKkNUEwtT6gTITBMn2jQbOQWJONXdWALA/NapwDH4gyyX8mGUrEUbSLLfJZ5s8g9L7TohOPkqjWcdnXKihPTz/WWso1F4JPKea9EeUNFP5v/XlSuy7sy1biN8UcINnOW0KCLeV7iTQpTc5ZtmwQWWagkb7dIH6ffwKpo2szRVGiakx5uwsiZOcSMfqojiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtxFGZWuaQ/UbWCK1V30C5klivP190PteHyjjx6+zfo=;
 b=cHb8JFMhLyi9SzqofpXw496U/S7n39Wks1NZ4/C6Xd66iY+ivERpvc3em7QlWtdp/bLINMxc3+7q5do0ktQKagcuRgOVR6sQzQ7jjq+VE6jfA0IEnxDQvTIlbz/s9XQP1Pm0kGVwTtZTnv/+2vecdM7f6grYxQ0kDtT7J+9l9l2ALaeMB/6+8POeoKZPc26UM6H5aJ4fei/8GGZzMnYvvFV+6Vtge7E+Sad8HsUS0CZiJnUqY/sGGhgn78UtxE2vYefjVu5cR1CvjycbcJMTB9WDVLE4ypx9wx78kVdWI5E7UfE4c5zlSzC4S8wNqA7qL5Zfeq1DshJ5Krfr58bNIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtxFGZWuaQ/UbWCK1V30C5klivP190PteHyjjx6+zfo=;
 b=xc6M2YpJ3wxx8wesJQJ2mxvbSFehDwshT+dDnEtH+TlTZACaeCzdRtTuFu/9n/Xsyz7VqzuFm2PoABuYjUK1xVcLYMdHvNMOfedCotuh5qsB/qHFbk46BER9XBdPN46FuZ6KnkU8axES/ypmWKbWoZ0Tvd6wc9i5erX8C7wf6Dw8qRyWGVax5ndu/5ynT5e4bA75VXocL+JUMVflD9r0FLuLZJOX1lZKoeTZgNRRMO1MfAQQp4x4a9zBtx5UEfSgbBu3W1Of4HJWsG/L5KgcAtELlA9Y6i13Lja2tUU9N1jepsWq1zriMrkddLcY46hTtInxYAulhK+Gpghpv1rfPw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB7975.namprd02.prod.outlook.com (2603:10b6:8:14::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 19:34:32 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 19:34:32 +0000
Content-Type: multipart/alternative;
 boundary="------------Ccq0GNTyHaBNFQ0t7wihFWuu"
Message-ID: <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
Date: Tue, 27 Feb 2024 01:04:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com> <87bk83bcqj.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87bk83bcqj.fsf@suse.de>
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad26707-2381-4312-9a08-08dc3701f455
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HN37xijnw9wEjRN+oqR6t+kSofFyrcosdWy2hKMKIZcmSuXG1l9OqN+bEARM7diP0nXXLl/cYdD9V12Wt1Ws+fWkynm7DHXVsfBIllgV3wVtuUVWUnPcTdVQj2RutCgKWZo1wmTgJYCOcKARSLblH1e4R9vyn4u7OLuop5cxRijA5GF8cl6+aV/Cc/jzKrNbybdicoNKwjUYHI6EOMFEEFg4GIePfrB7YP7Aq1MLNNNgt4KkNI7TEqVatdy1tMcLdWXWuLi2mIZ3ukoWCdqgPJLSkCLeKrfai6Ogdcp7CBiwmi9F9fQxo7cBdLhDUN1WV9vWcJIDAErXMDaDQzEy0bHlLSZW2Kq0vUzRFe2Bqw6JB5hhkOi5imDNejYrHxTz+GQHFbBEcgSq7IcIWPmb3qT5wm/zmY0/MlnnV1Wxm2Ic1DygqagjQTAlOiRIPJKf0n/ENF5fYOaf9doLaObJFhqNsEutEH5sRnw4YNpuLv472/HVnBxJrnq6Rqc+nMyGKKFSiyMkVZJa5+3Ka8AOR6hgAJEAzTLy1+NhCV+lZw8z9xo0tnB2aYp3A33kZ+4qNhwKXrxg54MwjfhAqLvbAGezip2LGA4JmNtm0aBhwNgSqxwxRsMuvL++U0U2ANp0olSurMkkel4rmjGLKKHKeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUd4WElxUVIyaVN2ek1MOFFBOGtVS1hEMHBCTVpPQ09YR3FFWDIrdXlyeFMx?=
 =?utf-8?B?ZWkvMWlCTVROcVcrT0N0aHRRc2dvKzJVenZYcldHa0dJMkdMK0pKMERSVGs5?=
 =?utf-8?B?NFBjaVdzWWJOdFRReEJHY3hRSHQwR2tCVENYU3IxbFdGbVhVemF6YjI5ZzlQ?=
 =?utf-8?B?WXViU1E1NHRVZ0tIbDBubmxaOFpkUUw2Ly8xWjgrWHR2RDlFbEVkZnEyVlYr?=
 =?utf-8?B?eW9pK0FLZE84Y3crOWZFVmxQOUxkbVNTY3R1K3Z3SGRuekpnbitib1ZGQ3ZD?=
 =?utf-8?B?S0htSTcwTHVVSVFtc2FmUFBRcHVHRVNMQ3BHQ1MyQm1aZzhUcEF3SmN1bWpB?=
 =?utf-8?B?TCtOQVFpZ2gzMUJwUWh6MmEyNlpUMWFrVU0wYlI4djM2Y0NQQSs5aVVUOGxQ?=
 =?utf-8?B?dkFya3BrMUl0QmlxL2luRmxTLzhvMGg3K3M5S3dJc2VtZzZyMlZqdzhJK1Y0?=
 =?utf-8?B?d1RaM2M3YzNtSlVCR21ZTG12Y2VIMkJYcWxFR0dUanVTSWxWVWYralNiV3J4?=
 =?utf-8?B?SmJjNjhHK2VtTFUzOHNFMFcrdHA5V2tCOEdHeHRhOEdZckYwcU5WNk1RQ3Nz?=
 =?utf-8?B?YTYrVDM1N0NwbGRVNzdSaDY5UXYzdEZXcmtzbmMyR0JLempUOGFzRzNGZk1x?=
 =?utf-8?B?SHJPbzRXWDRPZTM1RWlibTdnU3I3QmR3RjdqWGN6RjNTTHl2dmJuQ2VwWkJv?=
 =?utf-8?B?MFozNHNjdm1HWDVmakhQd3psMk83N3RvdDdRT1dvWis2aURHRjN4RzhYY1Y5?=
 =?utf-8?B?dFlNbEg4SjQ0dDBBcDVRUUxzTUU1VE5tVUdQa2JCeEhkNm5UQjFxMy9sQnk3?=
 =?utf-8?B?L3g4b3ozVEV0N1JnNDhUU3ZTRG1raHc0ZmIzQXpabi8zNWJEMlJBZENWRjNQ?=
 =?utf-8?B?LzlLL2pDMG1objZYcG9IZ3hKR2Zzb2k4TnVVamlZN3B3NUp2dHJGcVA3VU5B?=
 =?utf-8?B?a3JwcW1ieVgzZFBodFlkdmhDQ2IyVlRSWDBsL0l5Wmt5ZVZiTng0VmF5SE55?=
 =?utf-8?B?RUdlSTJEcllFMlN2N1BwczV4eCtkRVlGc0F3MW9uYXNTcUxCbCtiZ3N2Znp1?=
 =?utf-8?B?am9VVU51WktZWXBsaGZkT0xjU1RJUUJ2MWdCZTBNWlFvbzhIU0dNcXZLQTln?=
 =?utf-8?B?SU93TjBxMVZySTJKSlA2d1JOZGVxNUZja3FaMC9VMkJCYnZqZzh0cnpMSTNF?=
 =?utf-8?B?Y0hNV2xGT0Q0V3J5K1VRRC9qK2xvZlhGYTdkZnhVNW5aZmJtUkY3OUFEOFNa?=
 =?utf-8?B?akJ0ejM2aFB1QUkweDhnTnNweVpOK3lkOERMZVdaRWV5K2Z2NXRJTC9leHU4?=
 =?utf-8?B?WnIzZjA0dnNzdHV0emZJNlFuZmJIdmEzaksydkFUUEZJbFdJRnJ3VCt2STUv?=
 =?utf-8?B?VjlwbVJqNy9QRVpnYWhoOFRhSE1QNkxvMk9MUWp4ZjJXZ0VUNElhNWo3TGhQ?=
 =?utf-8?B?NFdjSkFWbUtDUDk5NDZyRkVCWDB2d0pqa3V0TjVHL3V2NlJ5RzIwSHJPL2Zy?=
 =?utf-8?B?UFgwZnFGTmY2QzNyTndRcWF5RDRlc1dyVzUyZ1MvQTRKd01mR094VWdKSmJh?=
 =?utf-8?B?K25UMFhxM3duUXkyb2lNb2MwK0ZIOFY5UTVaRHBEMjNPM01FeVZDK3VJN3cw?=
 =?utf-8?B?VnBMQ0NOaURKdE9nTGUyaXdHbm9OUml0cWo4QmhYYVZXNGRORDl4WnZCbW1L?=
 =?utf-8?B?OG5Ma1JuK0NEQWI0K0VNMXJJRkZackg0RWhXdXpOSnVSbU1Fd0JtQUZVemtm?=
 =?utf-8?B?YlhlQVZQeGR1cEVYdU16Z0IrdGd4ZEZzVk1mZURrZlZQSGcrSC9sMTNseHFM?=
 =?utf-8?B?L3VHN3E1VjRzSDdUWEdUaHBKNFJKUGpadUg2YXk1cG9iNVo2VmZWRFNNQS9q?=
 =?utf-8?B?bm51dEdOTGxRNUxpWVhrQk8xVDNHSHcyTXlOSGhUNk1pRUExbEtsdGVWeHZu?=
 =?utf-8?B?SW1WM3dCVHNMd0hnRExYVXd6bmxVNEZvQTdvZFFGdjN6WHkrdGZsb0FxS2Vn?=
 =?utf-8?B?OG1odkVWZU9uWTFzazJjUm1zOXF1WXJUeEo4Rkl3NTlGcU1nclM4cUNqOTRI?=
 =?utf-8?B?a0pOdDB4VEp2dXRRQko2ZFRMN01mUHo1NVRnSVpoemNOLy9pU1FDTGZQemtm?=
 =?utf-8?Q?g8OeNTeGYPwrsph/IAwWbZYmw?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad26707-2381-4312-9a08-08dc3701f455
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:34:31.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTznEf+LBL8w+S3dO1ROPEAnJBH7WceSGR/cLbT15/lIr3SK3n6re6wvpq9TomsEnFsNQC9Nlb3elJX4Y35PKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7975
X-Proofpoint-ORIG-GUID: kt1ugwpAxkrsSnD90kr5LYmGAb502U9f
X-Proofpoint-GUID: kt1ugwpAxkrsSnD90kr5LYmGAb502U9f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--------------Ccq0GNTyHaBNFQ0t7wihFWuu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 26/02/24 6:31 pm, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>> this was the same first approach that I attempted. It won't work because
>>
>> The final 'migrate' QAPI with channels string would look like
>>
>> { "execute": "migrate", "arguments": { "channels": "[ { "channel-type":
>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }
>>
>> instead of
>>
>> { "execute": "migrate", "arguments": { "channels": [ { "channel-type":
>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>>
>> It would complain, that channels should be an *array* and not a string.
>>
>> So, that's the reason parsing was required in qtest too.
>>
>> I would be glad to hear if there are any ideas to convert /string ->
>> json object -> add it inside qdict along with uri/ ?
>>
> Isn't this what the various qobject_from_json do? How does it work with
> the existing tests?
>
>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>                               "  'arguments': { "
>                               "      'channels': [ { 'channel-type': 'main',"
>                               "      'addr': { 'transport': 'socket',"
>                               "                'type': 'inet',"
>                               "                'host': '127.0.0.1',"
>                               "                'port': '0' } } ] } }");
>
> We can pass this^ string successfully to QMP somehow...

I think, here in qtest_qmp_assert_success, we actually can pass the 
whole QMP command, and it just asserts that return key is present in the 
response, though I am not very much familiar with qtest codebase to 
verify how swiftly we can convert string into an actual QObject.

[...]

>>>     static void do_test_validate_uri_channel(MigrateCommon *args)
>>>     {
>>>         QTestState *from, *to;
>>>         g_autofree char *connect_uri = NULL;
>>>     
>>>         if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>>             return;
>>>         }
>>>
>>>
>>>
>>> Regards,
>>>
>>> Het Gala

Regards,

Het Gala

--------------Ccq0GNTyHaBNFQ0t7wihFWuu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 26/02/24 6:31 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87bk83bcqj.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 24/02/24 1:42 am, Fabiano Rosas wrote:
</pre>
        <span style="white-space: pre-wrap">
</span>
        <pre class="moz-quote-pre" wrap="">this was the same first approach that I attempted. It won't work because

The final 'migrate' QAPI with channels string would look like

{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: &quot;[ { &quot;channel-type&quot;: 
&quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: 
&quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ]&quot; } }

instead of

{ &quot;execute&quot;: &quot;migrate&quot;, &quot;arguments&quot;: { &quot;channels&quot;: [ { &quot;channel-type&quot;: 
&quot;main&quot;, &quot;addr&quot;: { &quot;transport&quot;: &quot;socket&quot;, &quot;type&quot;: &quot;inet&quot;, &quot;host&quot;: 
&quot;10.117.29.84&quot;, &quot;port&quot;: &quot;4000&quot; }, &quot;multifd-channels&quot;: 2 } ] } }

It would complain, that channels should be an *array* and not a string.

So, that's the reason parsing was required in qtest too.

I would be glad to hear if there are any ideas to convert /string -&gt; 
json object -&gt; add it inside qdict along with uri/ ?

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Isn't this what the various qobject_from_json do? How does it work with
the existing tests?

    qtest_qmp_assert_success(to, &quot;{ 'execute': 'migrate-incoming',&quot;
                             &quot;  'arguments': { &quot;
                             &quot;      'channels': [ { 'channel-type': 'main',&quot;
                             &quot;      'addr': { 'transport': 'socket',&quot;
                             &quot;                'type': 'inet',&quot;
                             &quot;                'host': '127.0.0.1',&quot;
                             &quot;                'port': '0' } } ] } }&quot;);

We can pass this^ string successfully to QMP somehow...</pre>
    </blockquote>
    <p><font face="monospace">I think, here in </font><span style="white-space: pre-wrap"><font face="monospace">qtest_qmp_assert_success, we actually can pass the whole QMP command, and it just asserts that return key is present in the response, though I am not very much familiar with qtest codebase to verify how swiftly we can convert string into an actual QObject.</font></span></p>
    <p><span style="white-space: pre-wrap"><font face="monospace">[...]
</font><span style="white-space: normal"></span></span></p>
    <blockquote type="cite" cite="mid:87bk83bcqj.fsf@suse.de">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">   static void do_test_validate_uri_channel(MigrateCommon *args)
   {
       QTestState *from, *to;
       g_autofree char *connect_uri = NULL;
   
       if (test_migrate_start(&amp;from, &amp;to, args-&gt;listen_uri, &amp;args-&gt;start)) {
           return;
       }



Regards,

Het Gala
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Het Gala</font><br>
    </p>
  </body>
</html>

--------------Ccq0GNTyHaBNFQ0t7wihFWuu--

