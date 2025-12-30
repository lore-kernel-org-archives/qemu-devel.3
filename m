Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104B6EE4990
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeUW-00073E-37; Tue, 30 Dec 2025 13:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaeUF-0006zP-Js; Tue, 30 Dec 2025 13:30:28 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vaeUB-0008IB-CU; Tue, 30 Dec 2025 13:30:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThtXCpc3qCFPp38sXWJ/79q2OoLXD7vlReCSv3LuyrjH+96rhsS0c5B13YidJNieNY0hd7FB9/zl5gRULK3Fo57fXJrkUiBevgCzjgeNG8OjCfF0uvwTeLrSgoegLPWR1IKyn4Sv+moXHHyS1FuJFFlyiwMRJPnO9BKQFRX4BXtzzoJWjqmSbINz5MTjgbQWMIiOSinnRseTq9tnz8Joi+kyMnEDhBzINqwzVp0fk0dFKmoipp+BLdiCYGqk/9ifhWDi7pHYQA85p8kLVZ38NvJ60VkFIoymgxqBEEmgZ1WsVxr9WSq64hlzfzoanSLU+brN6dcvHR8WMJuiMSZZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdrL4giJCxLK8Lb+Xkc0tMRPm/wNtgjitLoyL/VgzOM=;
 b=oHkpZ7iIn45SAB/BLCYPSwfmY1OnwNiUs+6MljZXxyntMyPRB7dI0F0HftBIE/yiyqrUZP2I7XhKMQ5EK5C7i4e86GxxjDLGGfv4s1LXhoJKb7vsdXhGf1kJOfKBzJDs/Od46LtGXovxTgV4e41QVBclNqxB42zKp1vxHLyAocYjXqDl+8Zg6F+aX+p/v7AHOfK8N4pupy/NUbBsFiKW2hVryy2P0cz4JvVGYruXKC+0iRk05CT6s5tqkkESKs7J/zS+ek9dom/vE9zSf7Of66mCzwMriqrxBxN+0DPHHKHrPQEdWcS3KWXd6J4sq4rduwxWxv9DBGJU+HRB3T1mKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdrL4giJCxLK8Lb+Xkc0tMRPm/wNtgjitLoyL/VgzOM=;
 b=f9LGoB5zbWoKkhcTuBUTKJT1NCTjdjU5wmBq+CjkT3aag4fbDoFGYh/CpmvhuQDF8pEs4Osdr3w8vElCrpYqef/SGH8Vsu+Sfk3HIxqbnHn/+TQpao4xBpdHTDDpAhpv0vAIuiQezeT7TKLLtNphCKyNk6OD4XsSOlFtNupvR+sb2BhyixL/Rv62gwdhBsca++zTnztSucldIQ8IOeXQMovqbtJX2Tcjy9XEWyAC0+iVhm/LS42jLp4UyLJRs8hkQFcENOGqn33dYlGAriu0dBJun8ykFkXoSmUuHnJfQkBwnZFadJuvn892InLD1WBmEV7tTFUPfT4NtZP1hfp4DQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 18:30:17 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 18:30:17 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Thread-Topic: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ object
Thread-Index: AQHcadqOqHtReOjPAEGmZGv5J3l5+rU5JMqAgADmALCAAIwPgIAAAvjggAAE5gCAAAGB8A==
Date: Tue, 30 Dec 2025 18:30:17 +0000
Message-ID: <CH3PR12MB75485CC0EA22CCEBF2D40A57ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-11-skolothumtho@nvidia.com>
 <aVLbS6g+Sd6vfaFc@Asurada-Nvidia>
 <CH3PR12MB754807EAC29B50A82B3B84E3ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aVQRuUkeBroWIAHU@Asurada-Nvidia>
 <CH3PR12MB754883CF90FB349D4CCD2126ABBCA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aVQYUgXv/ZzTEpaz@Asurada-Nvidia>
In-Reply-To: <aVQYUgXv/ZzTEpaz@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH0PR12MB8099:EE_
x-ms-office365-filtering-correlation-id: f1b0ed04-72a9-4cc2-eeed-08de47d17b11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Jvs65qtOuwE1rxj2gqT3jZF0KsCvH14RgejWRCq60NrknrBGYaAUKdZhD9Cs?=
 =?us-ascii?Q?NMwYizjOg8/uHqQH9e1WRV/D04DCieWBqvUJ9g113KPldAy+m1CBvWSpUSN1?=
 =?us-ascii?Q?Og80etDtV+8T741/nrJGnWUnZnY9IPW6pnTzXj07e325khN9g71b6bctMN31?=
 =?us-ascii?Q?3Or9W/EzQa8FLAa6f0Oe9Wq/oLFs29l54uXty5SqkQqmcRlHqm46IT29nzbg?=
 =?us-ascii?Q?U5SK9riz7Yyoa+zMM2VNGQoHZAoTbRwot17XblyXcUWY3uGPee4/76kLoJP+?=
 =?us-ascii?Q?HfN+s7LMIgzhKc2nlPnkEpAWOKY3WVv09HoUs02B4zcuvHHzrbR25LzTwEwH?=
 =?us-ascii?Q?+R2863UjtsYyCAUYXG2a6gGtKMHFYS0AHf+91P+3EazMI4Ds/J3yr61fxsXA?=
 =?us-ascii?Q?q77NbugVr/6wW3pQOEn6b/2rx7svpk50E9de498BleMhNcsXYh/KYO88p+pb?=
 =?us-ascii?Q?A2b+mzfHIaoqkYCw0nzW90t93dxJ3WvGvadTfKOWOnGecPP/VowJJsqP3AKt?=
 =?us-ascii?Q?/q/Jw/Jq1BpJMQkyLwIEaJ1DET5o/psHLToyKNU3MUv0b2gLjxp0eWpm7qOZ?=
 =?us-ascii?Q?14fGwQohnmo6FnBnos50FXaX/WKZRgXhrv516N7gbvVfOVkdxMO0FinfDCU1?=
 =?us-ascii?Q?k+LCjluoLdfM+kkCHGGy1QiifD4LgBgCAIeejpOYDx9iwYSqI4p0H9+t64VI?=
 =?us-ascii?Q?rxvY19Rzaga22lTyzeCFTgWuG3NblnXuF6Ft7bqAFbbpW5MstSXUCxSusZY9?=
 =?us-ascii?Q?Tr7dPDaeS4NOqWmLhie0gwO4SA0JSzXJ7ctPbjOSdnMSfU6jRy5XC4eUeTBX?=
 =?us-ascii?Q?QoAz4CAxPduuucBRwxq+4grHnJVZqOU6Au33PJKgvqYXWIlUt0oA9GDhKTtS?=
 =?us-ascii?Q?SXDRIOqeEkI+r6AG+QmLrqICDaGg+CxdOJBcOLkkRgxCmtjX73XpHLuAmy6W?=
 =?us-ascii?Q?3XZXP9oJt2HBs7R9e+k9U7lZxvC5qqv3jhXmA9nf9FTNMx96OM7nYKMWofUw?=
 =?us-ascii?Q?HVCZEudB/qu/7sOgFyZXON0OAqOIFbKHTrJMzL2qhce6UgOzws0tUTgjhw6Y?=
 =?us-ascii?Q?PczwQqb4WJ5LXO0RseVP9HGa74sTL3tg+ouKuVtVg4M6G4YpA7ET35UaA4ul?=
 =?us-ascii?Q?7yqqXXg9e2b2uyztVnNid/NS4zyvONXmjAlRhntQ4R4P5XhF8SWbFWAWjPii?=
 =?us-ascii?Q?iSudJ21eJH+5NLd18oqvbnFBZZ/AfSC680hqSW0YDEPZX9zNb7XRTFvHQdto?=
 =?us-ascii?Q?NVf1axgnJWuMk0UhMPbxcfo1nupc+LuvZM7ezM0IEGhtEXkAZidDDjPRD5eD?=
 =?us-ascii?Q?M8mWGRvrhbQZwC2hAVN4kx4A2QAlwjpXK627+LJlAqKRl/AJxvLSPOIfuhuI?=
 =?us-ascii?Q?uaADai/hbPh1YeKqcdiP7DFYftrPpUTiU0n6YcJZIxZXgohwxstau5Vvgo+J?=
 =?us-ascii?Q?VPsSMxRXSbhFCoPosKVAZJpzT0uPyqScZbsUtHU1bHOYnlix3agelw5ba1ua?=
 =?us-ascii?Q?DTLKuV7CaIDQLjrgWyGg4W87oL6mUWBHpIw8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GVLu37TYvuaCTR2QMhX2EhbqDookL715cB7TJ8EWE3ZduzvjP5nmhPT3GWZE?=
 =?us-ascii?Q?JhIgtGLGTOmzywzsGC/eOlvelAbhq4XmZE+3QRw/KZP67vJPo6z6o4U8Gn/h?=
 =?us-ascii?Q?SQZc2QsK234eO3LgYFISC8NOteY2PSBY27nxKICdS03qLWxm/WbIoX/usul1?=
 =?us-ascii?Q?PBRjjjFGShnTtMWSpvRCsmsZ04Zyv/36OccJe972Tzio/Oq90l5H6dn+HJRY?=
 =?us-ascii?Q?EyLrtomwGeuLrebyoH0focMSQBGWixMCk4CaSnUsm+cWt4iDBJ9AVGaxBhZq?=
 =?us-ascii?Q?pqVaNyZf3ZaaHT2M7Y0lAMvaYEoPS3ERIZXdRQyOyqjhCRD3iZTy7Mjnh/TK?=
 =?us-ascii?Q?F54GoOx5rY0XKkEmh12dnDqHe2dSUbE6UQcj8gM2MCGWJb16UBTXZz4iWSdg?=
 =?us-ascii?Q?UNcOdX2+XOk0h72V2xyk+fgdUIUu3F9BwokzMxx3yJdqsDB5fg2zo2jceTzw?=
 =?us-ascii?Q?coTHe9OVhP8AlzDm0R0vGXo+N2W8R3eGUlgRsIAPpwfBBCH3EnFKCd+V9X9w?=
 =?us-ascii?Q?SrGiA43IYxpn7IiUV6PFoK16SKW2rM/27YFsoAy0GaKcE6oLtWMVI45x3vHK?=
 =?us-ascii?Q?vFaelOXx8LEmMRk+I6aYI9aETNtXZS+KzWjkVEhVaC2JNX0S91QfXmLMZkL9?=
 =?us-ascii?Q?nJAt6SfeKJre2BjyHpAqGHNJXkjy9EEx/Q1wPH9LpaZRG01xQ5pDhu4ipcGo?=
 =?us-ascii?Q?bo2leRKkrgkzg7WESJ7Kq3zVYzIjW8/1olFezBtK5CAVH10QkU0Q8b8BSy8r?=
 =?us-ascii?Q?/klsU956wZ80Es0LrVrH5nQ58Tpyc7HPx2w8aePgcmt+KZnaC1IdlKpvy7vO?=
 =?us-ascii?Q?diibjrzMlJ1FfmM7Am8R/33unMtvLW4BLAt1ozqKiAMX5jCqJM2CBpJXFyKU?=
 =?us-ascii?Q?NQBeHL7TniaRmu7KtJaEJ5fR8i0xPgs5AN2cRX/JFkUOgmrtxTjv9q2SFagt?=
 =?us-ascii?Q?sGcueeIAMQwsWMT9FLKjepntVsiaInTMvQ0dxPalEytFg//uZhDuDAXAxeu3?=
 =?us-ascii?Q?5SFpOa8mYMVmlA9M95Sfhrm7+ApD7waslyuDY4ZFDm6+HzpgdzlcdBY1LhEF?=
 =?us-ascii?Q?avqd1lVOpooFvFxGG209abwcHI5Z0hl2+HPQPH6TBHqsDBm7FPKa2ZPSUVcH?=
 =?us-ascii?Q?vS3z+a9pJWCjfl1FFPv1KsDJ96aZUMkpB7V3zywc1KnYhWCNfIeAB0x8xeDG?=
 =?us-ascii?Q?FStBf+6AHjXgJMSafnW4QZVVwz+uWsJ9LyClYpp+6jbAqS20nqWPu+JwT4kp?=
 =?us-ascii?Q?nv1/KtCtsSUSRZOog5N9cal/JjtFlHBU4WWalhtlm0FhHOidjF13unQBFdTa?=
 =?us-ascii?Q?4nX9C0lCkZFSvk204LZwuXm0ycNsUqPE6ebaKrqI141mzpEmB3EVfKPgLNKu?=
 =?us-ascii?Q?F1Td+XZTTuHpg7JsBd8rHOGTPt/J0djGmUa5JgPp7LAUI7WGcbebBFt4FJm/?=
 =?us-ascii?Q?yyfXtFTMuGGPtTDrFM76Iwy1QBONHwdTTAqQo6ftQoDiPct3R14VtE6hdShA?=
 =?us-ascii?Q?x2oMD05fMkXA3RUcoBC/vPLyhXRhdLu+BV9lmrh4rvdtp9PZXTYZvwQwstH7?=
 =?us-ascii?Q?zYRSVUqudroBsJqWAs+mjh5yaxzeAhU7ofBHfuYknZeExmTCM8RRGp6OIz5G?=
 =?us-ascii?Q?EGwHbWnbxMBMl8hZohi333ahE4V2GpK+Jgh5fXDSPu9TA+natHLse6Gkddnz?=
 =?us-ascii?Q?W2TDJtXT18hYREXR3tJhA7qk8PpH6XS/SWg2FikvbbIbBHEvP6kowg3d+7pk?=
 =?us-ascii?Q?1LBlftZW+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b0ed04-72a9-4cc2-eeed-08de47d17b11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2025 18:30:17.1121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqL6EnTBIjMZ2tbYvlVFF60xzpHnd2mIBjyfzv5sQ4UOcH27ah/kvpQm6kMYx4TKy+n+lD+tJczd8GlZcXmktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 30 December 2025 18:22
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [RFC PATCH 10/16] hw/arm/tegra241-cmdqv: Allocate vEVENTQ
> object
>=20
> On Tue, Dec 30, 2025 at 10:10:48AM -0800, Shameer Kolothum wrote:
> > > > > On Wed, Dec 10, 2025 at 01:37:31PM +0000, Shameer Kolothum
> wrote:
> > > > > > @@ -259,11 +305,16 @@ static bool
> > > > > tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
> > > > > >          g_free(vcmdq);
> > > > > >      }
> > > > > >
> > > > > > +    if (!tegra241_cmdqv_alloc_veventq(cmdqv, errp)) {
> > > > > > +        return false;
> > > > > > +    }
> > > > > > +
> > > > >
> > > > > I think this should be called in tegra241_cmdqv_alloc_viommu().
> > > >
> > > > Should/Can we? _alloc_viommu() will happen before the Guest boot.
> > >
> > > I think we can. vEVENTQ only needs vIOMMU ID. It's per VINTF v.s.
> > > per VCMDQ (HW_QUEUE). So, it should follow vIOMMU.
> > >
> > > Basically, we can allocate vIOMMU (VINTF) and its vEVENTQ even if
> > > the VINTF doesn't contain any LVCMDQs, which are allocated/mapped
> > > to the VINTF later via HW_QUEUE allocations.
> >
> > But what happens when you receive an event from host during that time?
> > Should we just ignore it? Or is that not possible at all from a hoist d=
river
> > perspective? To me, it looks like the natural flow is setup vEVENTQ whe=
n
> > Guest is ready to receive the events.
>=20
> I don't think that will happen. The IRQ register for VINTF/vIOMMU
> is LVCMDQ_ERR_MAP. If there is no HW_QUEUE allocated to the VINTF,
> there shouldn't be a vEVENT. Otherwise, it would be a kernel bug,
> IMHO.

Ok. That is reassuring then. I will add that as a comment and move it.

> > > > Unlike the SMMUv3 vEVENTQ for accel case, we restrict the hotplug
> > > > use case when the tegra214-cmdqv is set. And as soon as Guest setup
> > > vCMDQ
> > > > the vEVENTQ is enabled here. Do you see any issues with this approa=
ch?
> > >
> > > Once guest OS is booting, !tegra241_cmdqv_alloc_veventq will fail
> > > tegra241_cmdqv_setup_vcmdq while it cannot break the guest OS any
> > > more. Then, the whole thing wouldn't work although guest OS runs?
> >
> > If vEVENTQ is mandatory we could exit the Guest with a proper msg in
> > case tegra241_cmdqv_alloc_veventq() fails, right?
>=20
> I don't know. But that doesn't sound right to me. In my mind, once
> the guest OS is booting, it could only stop with something like a
> blue screen..
>=20
> Maybe QEMU experts can shed some light here.

I think, generally it is a last resort option and should be avoided.

Thanks,
Shameer

