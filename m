Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562D2CDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAz5-0004jx-EK; Fri, 27 Sep 2024 09:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9ew-0001cu-VR
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:01:22 -0400
Received: from mail-vi1eur03on2121.outbound.protection.outlook.com
 ([40.107.103.121] helo=EUR03-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1su9eu-00084m-2b
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 08:01:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv0k4Wchg4e9frlLeqmoCdCgP0fyJLa+ronv0XinqHkoX/ZwXNritYk9jp607NKm8FgfmK8CLgHeuSKGUkaAqjNZ0mq/v8MIBOzd/iu93GhM96O8hxDy2unOuKpDMFa3VWTyOqNcPVwgpxtmD7KjTs7K46wZH/VrtuiBeSeNPk87dXx1iiVNc32LLJAfOJds3c+7O84qEqBCi+q3ClA8v7XPsOKpoxusbOKies6hcLvAGSocVNqdOcGUG7BzRM9/mIkb55CiIX5G7tqiy1gDGd53OQuXWyMBsSHKcLiHFLqPmxReaPBBIH9BK00nGAoNvFI+/QnnXDMe1kA2DM9Qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lm03zBfvAiCdRLFJgni1FL/+iYm4bLa2ps93u1DUdFs=;
 b=DdiAulStScHkd7lQh5rH/kCTl9X7AKFF8HzdVtDUl8DgU6zwu5VCUKsZRLeTGZFNg38sxN9n5FwC3eNlaJRXtO1C5ekjBuiZpWUqY3KjOqySmj7Y/Lg4TAy/OEj2v8H8sBLgMBrDIQeeimmDt5/J/KxrNMLKrB8js+g412Qq80sd42vvDmrBWZE0hoLPY3qm0GLTtifhXk2MCnrc+f4bwwVIgvRAzfTkioZ57pSUpRDUNQ2IPXRmHqoRAevgHajZHIljq1HwgP/NptAtT7A3eZQNT0swmqQXnJILd6udoqbcW59yNKTyfSAXbqObPWoCt5G3gT5aiDALqIO8P+2TkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm03zBfvAiCdRLFJgni1FL/+iYm4bLa2ps93u1DUdFs=;
 b=Zd1U9VBiJKPWxtw89SB5GiFr9fhtOO+/2yzOwLng9SjphWe14+LeBstzy+aORImo/e+XOtxOGbO4iOt2FUjVprtsJLPE5MHh09h5djmdpdTbSIbarrjWM7jfQkkvBIpeNXEhqY57l1XTywqEH+PJlOodoWADmv5+rozU13dd3e/POPf8PcqFjXhf2BOdylejNBig9wnYLo8xhJkP5ZUgulbFrJjq4HiVBcjRdzPKrptpVkaWPJqKdEFtKjzYFJFH71Pf63Up2oGckv2k6J7TA9R7PpQ1cbp7ce/k7RSsruhaMU/+9zMYazyemfzvDGWrm2bXrwThQWdFWLNI+00aYw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by AS2PR09MB6630.eurprd09.prod.outlook.com (2603:10a6:20b:59e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 27 Sep
 2024 11:55:56 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%7]) with mapi id 15.20.8005.021; Fri, 27 Sep 2024
 11:55:56 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Djordje Todorovic <djordje.todorovic@htecgroup.com>, "cfu@mips.com"
 <cfu@mips.com>
Subject: [PATCH 0/8] Introduce MIPS64r6 target
Thread-Topic: [PATCH 0/8] Introduce MIPS64r6 target
Thread-Index: AQHbENB8nQghGVn0p0mA8R6vs6k9jQ==
Date: Fri, 27 Sep 2024 11:55:56 +0000
Message-ID: <PA4PR09MB4864368D08108AB2F34C0A74846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|AS2PR09MB6630:EE_
x-ms-office365-filtering-correlation-id: 6a4b0516-1699-4d76-7a3a-08dcdeeb58b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9XKWyeP/e/SvyA7EHh98GVNULFH66qUjlejpstiPFQOXFafI+FEdNItrAL?=
 =?iso-8859-1?Q?33KWmcQQnl0w1QDd2Cu7bUuT1aRJ2l6+pm5hInW5eccvQgGsk0veQpyMUY?=
 =?iso-8859-1?Q?ZYzCSAD+Rdr3doeLs+gbFwuDn+cwF8DSHrVOH9tQcHX7NG+ogTT6Z7T7TG?=
 =?iso-8859-1?Q?zbffaLQPjLxpHT4kuRSIgkb7FsZlpft0451uA7k1Stpcli+Wj46ziQvGns?=
 =?iso-8859-1?Q?4P1g3RVf7FudvOAuXqpJdkAMnaYNUO/u6fuU9+PrKSMlqcQAKbywnDJPXP?=
 =?iso-8859-1?Q?AwrrEdoQdVJko4B6Rlq9p83oUGnTK/n+Iamz1HfjtrDxrsazG3oXj6FbIU?=
 =?iso-8859-1?Q?kGWmUgpQt5GLCi5aEz1sL/oQzHeDOt8AKtBvJjvns4H4PoEE7cwbMUz/lb?=
 =?iso-8859-1?Q?SIscUdFXNKf4jnJXL/7/K/6AEsXmDGWQqQs8kFqFHNzcx9NXWmayb+eZdV?=
 =?iso-8859-1?Q?zqBSf56TAVaPLHWX8Kp4gtktxh1qS0lY2zHqBrbkm1dzSlZ2HdiH+EhTob?=
 =?iso-8859-1?Q?PyTk9csWknf+IhbzaStbdAUkSSAPsnb5Nb5cWxVix++jdaysoCnfqu7Ryz?=
 =?iso-8859-1?Q?7dFMHGRew9jhsOMOrJJ3218PLTJJTZ3Yb8BFJFKHoI7uimoAhEuqMqMuge?=
 =?iso-8859-1?Q?7EdKK7CTNg9O/gctVva1Nwv1WKz3s7RMAvvhr5DeTCnkV2HzLQO671y0M1?=
 =?iso-8859-1?Q?i2csqqHizVknD5j6L0vaa3cgpRBjBiaca6ouExJa8sf3BECnKvwFviBhvb?=
 =?iso-8859-1?Q?/yL9GukUeOxogN6AOPTcMHhwsVCAJJ2LO7362UbSOcmTGI7TDVxyNaMey0?=
 =?iso-8859-1?Q?papit91x6Qf13VraBpDc1E9FfMp7AvcOqRLlrYl7g2ep9iQ4sq28LPVcr/?=
 =?iso-8859-1?Q?eB9HqWtmxlS5Xp++iLTYf963s2iXClmwxS8gf4dmHfx1JuQjs/P6VurQYp?=
 =?iso-8859-1?Q?aipXGOtrZfSkINdnWDLNbXQtgJFgJ7KurvnXwb7UyPdS/PkXDbc+uCOtfX?=
 =?iso-8859-1?Q?rU8HfuCQEiNiPeAuY9FaFkfCfP9YcJ3Z3m+ReKGzd9we7WH/myjJ5w2hlc?=
 =?iso-8859-1?Q?9LLvu8JQSo6QBIGsDLGciq/nS7Wmoylm9/ijeogPG+fFTQQ8CjdhK73pIv?=
 =?iso-8859-1?Q?Z4G7eqcmDajqeDwhcjl+IqnJyQU/OHfON96PD7hverli2bY0cuxDMMtWxF?=
 =?iso-8859-1?Q?UKnHPycUp2fFQekDb/AfQAsw5QU1cQBRi0N543Dpf2UoAFlEHa/gZ1zXc6?=
 =?iso-8859-1?Q?CjbdWVggNZze3HnjqE7t1QyGFPeH0qZTmd7kxVAZ+y8BRoWJuJ9AP5Ogri?=
 =?iso-8859-1?Q?/0GaILLx9QzNgeCX+0Urbebb0ff7b/y6kic11hXa+vCmGCSiOHh7bSa2BQ?=
 =?iso-8859-1?Q?/0IaLhV2ZHGk28jAM/Hk1AHWK4sDp/3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fIUVZXb/T9X6ZESaVuqVjUyvX3W2ZLWsJ+NBRzwsyTStzq7Wy/fYr9+NTH?=
 =?iso-8859-1?Q?W9HLiTtg1B3qScc64L529EwhE8zVKaGaGtRA+dwVU99Jj8zcF5mtxENerJ?=
 =?iso-8859-1?Q?RKA2vYFu00hDETeFK8haRHzZq07rqD1yNngaBWaCU32C/GfsbN4TNQiyxJ?=
 =?iso-8859-1?Q?ZCHJQIVMwkYxJZpdEOlq8hK5HxSvawbX0BCrdkEAWoF/hV06WGkQLz3avb?=
 =?iso-8859-1?Q?dPZOJYlhIxAiHEV41ku0irlp9mKhWaJBIoCS/nwlW9sKPH6NeCtu5pJCNJ?=
 =?iso-8859-1?Q?vehy5pscCiAX09mNuTui5qiUaiwKpT3hmC8djy0YtcKBtzPuvHxSXDgHHG?=
 =?iso-8859-1?Q?UFhD5eOy0BBrvf/Rs9Q0E2JxD2lFaDhGEWPiRgUg6A/7rqkrFIgAxMruYL?=
 =?iso-8859-1?Q?3mOFEOY+N9g+MPj0YG8b6ItB7pw4lcZjygYUbV+ljUC/RwtyxC7m7XZjgz?=
 =?iso-8859-1?Q?jUIie4o4xyF/Lh7SZq4FkvToXD+bILga0qzg1WOsftb+WRrw9Z6SaHN7cV?=
 =?iso-8859-1?Q?RaxqQT2WtmXets4pThC8GQIigUAzPNMP+xXOtLuNkcJNn1bSReR7po3IyV?=
 =?iso-8859-1?Q?rpGVkijDq2xOydcWdF5xZHpsiZx+rmj29t0+osV8oPDVwD9rHTxSiH3X8G?=
 =?iso-8859-1?Q?L+2UuwazGGcuuVSsHBGBl8rvr5AQhtbXdegOAfTo8mUkYqouGElWLskmee?=
 =?iso-8859-1?Q?+eXldmBs0V+DsZ5NG4M+ZIof2FBA+d11wEB2iFwQLG1oetLCHpgc8cuyNP?=
 =?iso-8859-1?Q?quFODDeaHTNrbl/S8HlbWhDnw1jvU6uNmybr2H/WslcNGDt63gvlQYuLym?=
 =?iso-8859-1?Q?5DU/TndszqgCwNYqgvZiPIvBzWJjdFnBuJs6KGhChEu1H15LjzzPr3PPHT?=
 =?iso-8859-1?Q?eWCVS7yu5WZzSB+e01pssmC+Ld44XDqynJIo807bgXatcqhWWNEJaam0Wt?=
 =?iso-8859-1?Q?746hC9BHg0V5uZS7qI287kOtLDge9SPHpbfat4CnkctlxaWtW9r0uc/kYB?=
 =?iso-8859-1?Q?06dxWUwXPIVYeIFxR2ogV21ZfeFLdJHJRikWtkB8kujNJ4BOq8OGPGKZRO?=
 =?iso-8859-1?Q?26kK10aZM3gysmqRXP5/lohfV/Z+Y+0uZJcD8ipUPljMqJlv/689QmY/Ct?=
 =?iso-8859-1?Q?ug4tTL+QjNtA4uGHBskqP7VfiRvZ2pp8FwyTUTdCIfLxx18Dfd3oH9USSD?=
 =?iso-8859-1?Q?HDE/BVijJhwQgGXVySnKwaZdZdR+/Eyd0mLFHYfX5KCO0Tdv1WbHyxUQMn?=
 =?iso-8859-1?Q?2RmifM9Swn3acTH395ZLENdxXrTDJYcYNHy94Jazlw5I3/OxHhf2aWCIZ4?=
 =?iso-8859-1?Q?gxfggJWe8SwBfdtOJ4FauDuGQ2bANQejdwsjIuhdISGFjzUG8jAA+1psrH?=
 =?iso-8859-1?Q?BkApx77ct/ZOm0dUxwy/fceN7MVP+uA/8PsY8h44eBsneKjk/2Y1RqXEGs?=
 =?iso-8859-1?Q?9JQuMdrRZLnbS2nhMEe1/i349e/KOPr5ulLW9lQ8dxWjsCWYtQyvomqsvq?=
 =?iso-8859-1?Q?h2DZWXabxweNmsJr0WRKAUD48rYt1bdNjkupigOxZEJxuw4sEq/PPfUTYK?=
 =?iso-8859-1?Q?FCEfHBfQ0agkci4RFp3EVqSpZpA7KM/e1CBVwil+IoRFMei3ZwPmhHrxyK?=
 =?iso-8859-1?Q?5kJleOvAIXRClJaKkT5jkHTh6iatU2seLav0Qq+egPMk97tOr6u8Lpgg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4b0516-1699-4d76-7a3a-08dcdeeb58b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 11:55:56.6786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +rcLQBs1yZStVrpOvs3DmOcRAO9bQBdlf1mNL7Yd1GcxKcFNHgeBpBizwKuVgysw3gf86tk0nXdtdXdv9YtBzfpCy0Vm7TdGwvRE3/pLnOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6630
Received-SPF: pass client-ip=40.107.103.121;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=EUR03-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.769, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Sep 2024 09:25:47 -0400
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

This patch series introduces support for the MIPS64r6 target in QEMU,=0A=
bringing the latest architecture features and improvements to the MIPS=0A=
target. In addition to the new target, this series also includes=0A=
several bug fixes that have been in use internally for years within=0A=
the MIPS ecosystem.=0A=
 =0A=
These patches are cherry-picked from the branch mips_rel/4_1_0/master on=0A=
the MIPS' repository: https://github.com/MIPS/gnutools-qemu/=0A=
Further details on individual changes are included in the respective=0A=
patches. An instance of a pipeline of QEMU CI jobs run with input=0A=
variable QEMU_CI=3D1 for this patch series is available here:=0A=
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1470628690=0A=
and for the master branch is available here:=0A=
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1462140373=

