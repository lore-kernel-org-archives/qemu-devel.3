Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 650C8C83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX37v-0003gP-1H; Wed, 02 Jul 2025 15:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX37c-0003fH-Dt; Wed, 02 Jul 2025 15:27:57 -0400
Received: from mail-dm6nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2413::610]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uX37V-0001NT-Fj; Wed, 02 Jul 2025 15:27:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF/Udpw9WVYGzIlGHWyidUiXQ/53gAUKo3bgnKg5t2zbmV4Rmn/o6mKtczsvcqvK+UBiDiC0YNfpOj5v23ZkZN36zVW6ec4q8Q17XCW57t+V3+Qn8C+j5aimDqNvgjijGjoftxsn/aYTLdfM/ld0CQpMQlRpSNbOTa/rul/AvacEsz7aWmIEreVhsTpIINGJ6XRNvIj3FLfYGtjfKnl9G1/5qcArh2aZDBndRIX0M9FoCcuCSomKumu8CgcdTsJ5wkZXnsc52U8AbzKt61g8oO7AzL3Jssm3aUXauJu4WZIxGQrWLgDqQYkJKRqHDc+4jPWd2SyVkKuh2H3j6WNJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ed25Iu1AhDnE18qGkoUoaXgZVHH4W11z07NymYyUWk=;
 b=I7I5gjOAD31RLPZWMoNXIZ296v1s/jdRU2yLwX9nG87A0u6L+zFUtFX4AqrnJrOPdc8wH1+lgah6oLOduHfANHPyQmbB0MLPPvKilSEHp5ucXWfWaY4Qsx4QyPcrZeTgkRmnJpWBuzJ4h4rMHJDA4yNdUb9H0k0azVf9Y5XVjCMCLZlsfhhZr7e0ic6IMjHkGhfrr7NQLT7RIJq1HRx208N4ZiJbIOiWu6wVXBrakihxfkXHrMIMOjIZ6tTu9HyXSGCItbTtEVayWIJrKAafWX7XvujxxBo+H6eWafvSTAIk0f/DgsgCgMeUsxRs1R7mwxnfL5+j6KmVlNcbBGXF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ed25Iu1AhDnE18qGkoUoaXgZVHH4W11z07NymYyUWk=;
 b=oky9uZ4UtBP1BkXpfu2fb1uC28ab4T3lHIGAEeUc92JcFze/+pnH2nayw2FbDXA3KljOOFQdkVUi3dImwxUrnvFfZGrME/x7JhEcttaGCuhbFDAxpL8j2TKO3RBUNk1IAgtwrYZKzqV/kSMPWTZr+PRJhWs3kXQ/VvdaKt2gxnPsJ3I2RHHgAkfg5UTxXaPJf3JPe8+mYieXYqq63CLRdslzww7W5onEbgDm9+dHsABdCnPIhMcTqtbdZuhiGqlXjbF/cVVTBXIzmaIQYCja54Dt9TavMkoSSxebrw1TyqPFgzhC+YBkoNiq8PsgaEt9wJ0IaZfsdSlbp8IQzeiwsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Wed, 2 Jul
 2025 19:27:33 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 19:27:33 +0000
Date: Wed, 2 Jul 2025 12:27:31 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 2/4] hw/arm/aspeed: Add second SPI chip to Aspeed model
Message-ID: <aGWII78ihmhn_-q6@edtanousvm.nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
 <20250701203400.71677-3-etanous@nvidia.com>
 <a0dfcbf7-cc09-4fb8-bc3b-3d4060fce5e9@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0dfcbf7-cc09-4fb8-bc3b-3d4060fce5e9@kaod.org>
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|LV2PR12MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: fa77f332-fc17-4507-ba08-08ddb99e7e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?RaSd07AVbFE2eUrq/3yzA70PmX6+M3iiEPHm20KTRy+9aumYIX16tIr2Nw?=
 =?iso-8859-1?Q?F1Zp3bmIAONPWrdglQCXCxNOQG8m7qa6Fu/D7vzJhwDHxSSmRJ9nii7XqE?=
 =?iso-8859-1?Q?D/xmwS0zmdbPuXA1P0i8o8voiCLo5Yl8kem6p8wNfoU50dzrJYQsMuQG1H?=
 =?iso-8859-1?Q?4aBTivDT3aWRUuM6N3Bp7r7fj0KpRdZD6uXNvtvFyMVb50hIx4KdHBckAs?=
 =?iso-8859-1?Q?L0//8IvHddlPqL1d5kWa2119OZBaEZLu4Y7AgUKXUV1jdhUe35am3u+Hyl?=
 =?iso-8859-1?Q?Mb5kIZdIUiJLNjxCBkOhzn3gLqacLyyr41F0Bh9VA2JNZ6aYXf4augxtdG?=
 =?iso-8859-1?Q?34CjPy7nV55+yM0ZQovGqy/m5mElp8ltBp2UktyfVV3EpvYmEuatwDUhX8?=
 =?iso-8859-1?Q?USkJOvBQMSzClX70vBslmIa9rJh+L2UM90Sb4Dfo+JfvdVEWteMQYv/w8f?=
 =?iso-8859-1?Q?0o9LjKZyb3jvC7sVLeCC0QdRp/LT3XwLaOk5iECh6xNZ2xNR9o32Zo9dBf?=
 =?iso-8859-1?Q?qBwG3WOOHKC3rZDElGx2CdREwZmDGU8CgPE3qwr14UKEvcKogtEeY4hlLm?=
 =?iso-8859-1?Q?3qPtSvfb0FT81n7T/RIAloQCFXJ2MjfG7jLLSN2ZPOKz5eSXMoIDZqabEF?=
 =?iso-8859-1?Q?t54y9U5JoXrZMNVK+FxrVKn2KxCGkAL7i/xo+1OTH5PgXxR4RBdEUiloIM?=
 =?iso-8859-1?Q?Y+92x3DbKrbJqtQd9HIKzssSb3gMzlUQ/I91vy0ffwEVripwHqWPCEVIi+?=
 =?iso-8859-1?Q?2b6BpaGt+utH4Wsq2HSQLdhX6dyB4SXsK4NrTmwtHRGnPj0tB2agBHcbkq?=
 =?iso-8859-1?Q?fyc6otvhVsaGuwaff90tRi+uslC6j80e90NZWedwxaujCcmI+W+vHky3KC?=
 =?iso-8859-1?Q?RQYlDlMpdcyxgyox65QKe48MqaL/O3XRwUI6lZFFXKG+6K2ZD9mrtYNv/l?=
 =?iso-8859-1?Q?a6PHuInu52jt1N8giZ2GWOCKLkOLlxqSkAeCu+U3ntlX46/T/zMjzPrZEZ?=
 =?iso-8859-1?Q?QPcUm3uIpVTSIlayw+78BgAQsWAUUR2QsYpXJRDk/xheiAKF3GsB4MbQXW?=
 =?iso-8859-1?Q?Zo8cWkLUBMewLO5Ty6qJCLjYSBeLx3eUHZGHcAC37EJwcOjHc7bX37aAvx?=
 =?iso-8859-1?Q?qNAca+ZuYV7+toqqHxHGCzEI0nE309PcvfejyqS+dAojvaupwEhLU3IRSl?=
 =?iso-8859-1?Q?ln0Kddkb6M01oWDhlJJhU0GMqBPBgBvB5/fQL4oCLtx3JvnHDJTFrYHOeJ?=
 =?iso-8859-1?Q?p/xWEWEmddb+yOCw9I2wz/eJS4wBQyF+od/twD8I3kyf7sGlEP3gRMu7XR?=
 =?iso-8859-1?Q?arlBkpjOTPacw2zT6GvpukGtd9CqyDKuFpLpZrMpk8BoWF81hzZ/pzkKWm?=
 =?iso-8859-1?Q?91gYW1wNIdv6OV1hHQP/gKf8jGykJmGupc6xNEKhLYRHHhGZDsqu2SBhGh?=
 =?iso-8859-1?Q?+QhbgrHazv88gpkZPszgnemQGmTHPmgjgzW5AKcEokwEizqQPOAzt+gWA0?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?pUrAkj3lErxJR805cakkb7vEDiGibS7CsRauXGBfPRlTTTCYCI7fQuICFD?=
 =?iso-8859-1?Q?fuWDPGSDQWCBMOAqaAouZzd1CLfXH/bSJYzvF94wAXn+h/yjSJz18BF+Uk?=
 =?iso-8859-1?Q?eeqMCeeT4ikIiCcWFbvF0V99xyc4Etbfwf+Zhx6RTwLJnOFwP2BeoK9jmS?=
 =?iso-8859-1?Q?bLyKLpVXx987Co8nkSPVC1h2lxFYxn8dBijO+SpoLJ8oM3reZh8iUA3pIl?=
 =?iso-8859-1?Q?sU4rrzO6rwnFb/xbr/AYSRmXz1c6T/eW3uRQdb4kDziCG3hedczyiL5lkv?=
 =?iso-8859-1?Q?OeivYdqBQCVx9IgDrFRoYDo3gh+Kfa+JgogDP5NeJXQI+jumIPrsUms50r?=
 =?iso-8859-1?Q?PcwqDin3/t1grHFKJNzFO6m7rvK/mxyByBUwX2Zy+5XfO31V+ZsElv61M1?=
 =?iso-8859-1?Q?Hgkt0+XKFOcvY4r4BiyDOlLVdHeBd9MssGxtXJPNm7Sjx8eJGy0N6zDRjm?=
 =?iso-8859-1?Q?NVCWKTQGGCcq/6ZTpfWpJKUfUJ1fyHlu7VvwevjHtQvmPKdYKqI7o+mpJb?=
 =?iso-8859-1?Q?Xe43iUswTT+i5v3ynJebMXxKNKn9250TeYG4h1YfzL7gdj+MrbYrbMOTxu?=
 =?iso-8859-1?Q?PW8wmJx2bGr7HkbjLbUy53V9UbbuZpbGjOREgQ/yYvn6ZbfofFPGVq0hXp?=
 =?iso-8859-1?Q?nHd0fE5YLjpGT9lUGOfecQTCoZ8uufW0wp7u07YzUa1ygCHS1KvQFQA/QT?=
 =?iso-8859-1?Q?5qUic39zTG+lqDjj3cc0j6Jfmtpght++5eIhqxSVC4qZr4C31sH6R4hmyd?=
 =?iso-8859-1?Q?3XJddYVHHWW+8J5t0NOPo6xyhqLiPsWEK5OKmOCqDVwKsm20xJzvo/i+OX?=
 =?iso-8859-1?Q?iCy2m3/D4ysZrfG8oO4b5UpMnAAHGfWYTYN+ZX1ctRMidY8pYYqSjYF/wk?=
 =?iso-8859-1?Q?N9ch+7HN/6XEvI0CXlDflGV+XUFuFMm5AvuLdJj6uWSoeNqsbnXoS+KTqo?=
 =?iso-8859-1?Q?rCnTsizeR21b1egTbhwyeDTCGPPmapivB1nEtDt6dcnmDsPsoNEtPXrI93?=
 =?iso-8859-1?Q?RowA+WuNlUIAveCk7nwhLQjZCw6OZRd4AgobbIxSfelmlyMTDDPsO+2XcW?=
 =?iso-8859-1?Q?4g/WalteNA5apb3E+Svg98c5A/E5LNYlBDWxJB20VJ6r88OWiR1vzNYI75?=
 =?iso-8859-1?Q?aWib7v89q8vfT3bvs3Y1fKgpCUzUqVu9IdveVW1nDGkOGVjhRl+1Sh2hRu?=
 =?iso-8859-1?Q?m3FF1ELUtqO2boSOMElGa8ERvgIrJISHw+XbooHf0SYkDOv2rdSG2jYtBK?=
 =?iso-8859-1?Q?MsieDkAcvq0Mw/up4gFs50Qyi/M5joQdzONeT9WB/B1XmPFZ5P9qThhW+A?=
 =?iso-8859-1?Q?JpdarcgYR2ABaiISE7U/EPWT92kEfSfHka574ZFZ0V3RjQwlvBgi73ip6V?=
 =?iso-8859-1?Q?AF5ap0jps/3wuxNjYRvMizMTe6tkw3xU29/Tp/6GeSUSg1POAK0GgRZrLO?=
 =?iso-8859-1?Q?vMBHUZ53CUzvBrrzC6gjXkHjA36vjLRG9JJhgtT9aAoxsEudoD8ypLmAlX?=
 =?iso-8859-1?Q?+vSdQVxJfKZlqDC4533CjTZ0pI5Jae06XwZnBR6jS2bAp9Pjr/Amwqb+65?=
 =?iso-8859-1?Q?gjuboQDGGQDFSKbU5LrHkKEw4DSegRRNvnaKFZ1Mo4GOBKHhmrg3OJUzTK?=
 =?iso-8859-1?Q?j+eqHPdKacsoC1x/tGg6LLXV7ZSkD+zO4O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa77f332-fc17-4507-ba08-08ddb99e7e57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 19:27:33.3667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV6VtsXoTzNJISCNUoUKim7rz4vXFkfdzEJVy+tbn4x1NwLbKR/FVpjur+9gBj2DeJSo8OSWj0Sj5gQin17ngg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
Received-SPF: permerror client-ip=2a01:111:f403:2413::610;
 envelope-from=etanous@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
Reply-to:  etanous <etanous@nvidia.com>
From:  etanous via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 02, 2025 at 09:00:20AM +0200, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 7/1/25 22:33, Ed Tanous wrote:
> > Aspeed2600 has two spi lanes;  Add a new struct that can mount the
> > second SPI.
> > 
> > Signed-off-by: Ed Tanous <etanous@nvidia.com>
> > ---
> >   hw/arm/aspeed.c         | 2 ++
> >   include/hw/arm/aspeed.h | 2 ++
> >   2 files changed, 4 insertions(+)
> > 
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index d0b333646e..3ef7f6c5b2 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -465,6 +465,8 @@ static void aspeed_machine_init(MachineState *machine)
> >           aspeed_board_init_flashes(&bmc->soc->spi[0],
> >                                 bmc->spi_model ? bmc->spi_model : amc->spi_model,
> >                                 1, amc->num_cs);
> > +        aspeed_board_init_flashes(&bmc->soc->spi[1],
> > +                                  amc->spi2_model, 1, amc->num_cs2);
> >       }
> > 
> >       if (machine->kernel_filename && sc->num_cpus > 1) {
> > diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> > index 973277bea6..6c36455656 100644
> > --- a/include/hw/arm/aspeed.h
> > +++ b/include/hw/arm/aspeed.h
> > @@ -35,7 +35,9 @@ struct AspeedMachineClass {
> >       uint32_t hw_strap2;
> >       const char *fmc_model;
> >       const char *spi_model;
> > +    const char *spi2_model;
> >       uint32_t num_cs;
> > +    uint32_t num_cs2;
> >       uint32_t macs_mask;
> >       void (*i2c_init)(AspeedMachineState *bmc);
> >       uint32_t uart_default;
> 
> Another way specifying backends for all SPI devices is to use -blockdev :
> 
>   $ qemu-system-arm -M ast2600-evb \
>       -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img \
>       -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
>       -blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img \
>       -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
>       -blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
>       -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
>       -nographic -nodefaults
> 

I had attempted that at one point.  The second SPI flash is expected to
be empty on first boot, so building up an empty file with dd seemed like
a waste, and pushed more details on the user calling the machine to
know the machine configuration.  FWIW, yoctos 'runqemu' helper script is
also very useful, but getting it to spit out non-standard args and files
isn't the easiest.  If what's in this patch is ok, I'd like to stick
with it.  If not, I can dig deeper into trying to do this on command
line.

> See <LINK SCRUBBED>
> 
> Have you tried it ?
> 
> 
> Thanks,
> 
> C.
> 
> 

