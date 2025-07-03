Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37685C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 15:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXLmH-0002Vj-8G; Thu, 03 Jul 2025 11:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXLmF-0002VH-OA; Thu, 03 Jul 2025 11:23:07 -0400
Received: from mail-co1nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f403:2416::615]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uXLmC-0008TQ-Pi; Thu, 03 Jul 2025 11:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi3nwuxjgAeRt1vfc0PQGbwH5zWg0aH/uOjW/SuVL9McaxsarKs+w2ZAPMdd8AsCFmLyjZV4yflpljcx28STjUiD6XqC5/coAsd+vc+yxP68QiMEHz7O9Bp3e/o9MgWY+Q9t0Xii/+L2DgOQQR9rHBW7+mZwjh411QPorzkgWxAVxltZ4ePjDZyv7YP6JmDxHU+iASzKxo2YPMBgXYlW+GsDrYeD5Ks5snlI0LrL0Ouqt0I++Ul8Z6+x4nzaQgivQN0Djk9xQRZCAkWWkTlrJ180/Bv7A/cMtWwhKXc/cqDV1n/cdqhE2Iz6g1pqsfD7SvKUWUPTasTEXTbDbO8+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iiqlNcMwMk5SbJxqVA5M9vOwD/GiZnPS8IsbF/CJTw=;
 b=aSgTJwG6l2UpThO2jGgdE9ujaGnhPLC/nXwGU3M4fP6EDO+vUgQZsT4q7/kEA6sK4O8+WqEk4M025LtRz+dJFUyhIxLlB6ydLyZHZtMKXHZwQAqqDSFlrtL2jR3zPGKNxOrAG8hdWBvK4MNyJfUFswwtsnXweicSJ7z5s737NokyGVDUjSGfgix+emnwFMJ3bSz7OHuLosigiQ5E0KhECYLtDB1G3W/AtpUT4/5UxkYHEkZ38uR9F439M8TxoZuVF4NQ5AzG3KjyY294aIJHAnWiR3qmoKXMrLkAROl18iBHqUREv5QR642RbmRgSO5nlOgfiaU2SVdfQv7zOuzBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iiqlNcMwMk5SbJxqVA5M9vOwD/GiZnPS8IsbF/CJTw=;
 b=qeT/R+oBs8fdAvZw6HXzi5OPHd1T8E2DV92hogaaDXe4K4ErG6t3+q07Yuu6R+rVVNBZ7GaZH3tRvyL00i8GLMRx5jkRsZJ8396cFSMOotFju/Zpt7mvAjEYGaPLCuQTdnBZwdLlNDB3E3kWIDJGoIPNXUM1usR9rKR0hzFEipD+7dt+whgTGw8t5ZcmR7cya/YzdZa6JVuiMsHtRsZ+vsEvCwqfkvDsDX94Hgv41CNwdo2MS2XYPyY+5SQKvHHWP1wLRNUXrLFrbhlAVDgKK0SK396e+YUos7JnlWvE0bRiuSso7kcVisylC4t2cTfblOsia63Vb1gZRTuOOaY0QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Thu, 3 Jul
 2025 15:22:59 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 15:22:59 +0000
Date: Thu, 3 Jul 2025 08:22:57 -0700
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/4] tests/functional: Add gb200 tests
Message-ID: <aGagUcRMDvrPTfPw@edtanousvm.nvidia.com>
References: <20250703144249.3348879-1-etanous@nvidia.com>
 <20250703144249.3348879-5-etanous@nvidia.com>
 <ea805ebc-877d-48b0-861c-ac9b5c855acf@kaod.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea805ebc-877d-48b0-861c-ac9b5c855acf@kaod.org>
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d16d7c7-7177-4986-8da8-08ddba457e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?XV0dFGavsdSeiQjkjLQEhT6SYAeAT2jU3P8EskjzsJrTWKvk+ywlnwCR97?=
 =?iso-8859-1?Q?64awFL4u2st1QzWmdBn/Q+IT/zqSC194ZoW1WnY8b6JkIFb0+uBbSAAFJ+?=
 =?iso-8859-1?Q?w4b14RUnuDG1BRCekrGZ4BRCGliF3XdkHWoblisTQI+n3G2i2yQaHAXVSh?=
 =?iso-8859-1?Q?xcPZoPpevCs/CjLgvZHWalC9vkg2BsUJcqSLYurffSkNLYC/mPIwhYsHi+?=
 =?iso-8859-1?Q?IHJPRYoEI9lHYv8CbUwiD5ox3GjF6RDO+SB045DOHL7cT+8L6ILN0TGv6f?=
 =?iso-8859-1?Q?rkbs673U+teKEOT2VLTz0HB0XAeHE+IpF0wGQRiGW+DNa5c2GrnKkJHgY7?=
 =?iso-8859-1?Q?YaYx/q+3cDI480dE9r6iZcZtRxptG5N8RrBFMpXiuWb+EBKTWko1WDkB2l?=
 =?iso-8859-1?Q?GmQzgEzk4vQDfYwyceajGwEDuHHTY00Os1jQ8mmWeUh2P6AjyDq7B8RWtc?=
 =?iso-8859-1?Q?hhnNNnuM54X3YO2kIMw6CEgZl2aZKk5uNx8wn52g3KYu378kMxtMD/Lyh+?=
 =?iso-8859-1?Q?dhLzkV1eK+ykzOVL+CakcsLaXO3BdB6240KelDRUgenywWvHz2vJy+6XlR?=
 =?iso-8859-1?Q?3nYLGJq061C2bg272AoM2fZ/lQIxYG19aGmmh7uS8wPL9lW/y+d1BfgdSe?=
 =?iso-8859-1?Q?ALfOZHSL1ZfIGsr/4cKRYTTbXTPnlUJHU/bCw4IjtU5q1cvBMF36HDX2gk?=
 =?iso-8859-1?Q?5s75ZYk8Qs9HGWd1UEMuX/3pqAMNq7H3ygPqEEEpBzX1NaeR4mFuRhKJwW?=
 =?iso-8859-1?Q?JcFops6naDJxgCzl2IcaiB1s4h9mV9RAD9BYnnPNhLZQDpgmga+7a1Zfof?=
 =?iso-8859-1?Q?tx3I6SRb3ideWQ7tFvg+rSQLsJf2rKv5Df5cwDYC9bsOXl/b3b32p8LTnD?=
 =?iso-8859-1?Q?xuvtkv4AvDGZZsk77QTeL50/fN8kfEA/yT0tEQBLIll/dMsaFGhG+oI74f?=
 =?iso-8859-1?Q?9ZnVsAbSMayRNd57uGGzwFpRrlO5OFqb/F79Kr+Yn82DUomsi019A3CUG5?=
 =?iso-8859-1?Q?DUIJhGuBg2vTFFh2DuDLoIbC5s8CVaGkHuReaUGbQY1cEdJ+fAAWHRVDbl?=
 =?iso-8859-1?Q?kbtgwvp1gm8dWV5M9ku9V6M1eu47H6+PrDiCxWMQwa2hs938PhNQka/8Ip?=
 =?iso-8859-1?Q?I1l8mquSQKmUmAPyAZoWZIb0U/qeBcVlRQgNLUHM8BuY9+2OH4+KtCs+gA?=
 =?iso-8859-1?Q?+7R+QGlUivkeVsd4qVppZsfGrudGMrPczZ8GZZ6XKq08KToHOkjJFxZT+N?=
 =?iso-8859-1?Q?g47A0I0Jhe0sHH2hGdVAinMuB7lSRU0m1E4DZJs5V2f52vuLTybnIq3Eyh?=
 =?iso-8859-1?Q?WMUv6l6qB8ZZCJndLjog/bZphXkd9kchjyrgQz2AWmOB2jUgzGPRYQbVjP?=
 =?iso-8859-1?Q?VIXoiaDkUnpV3ucLB0eFwU10v0jInC3ou6m0crQhxP+en/N7j+C545bRmO?=
 =?iso-8859-1?Q?s9ORk8jJ3laeTAfs3v/mUaHxMgzD98qu2nNHM3aiKGK2CbyszqnuWVx8C1?=
 =?iso-8859-1?Q?Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NWkO5O+gU8KpgoP4yxIZIUeUXUOk4+k7QClvfQnxYUW17319L69wBRPXad?=
 =?iso-8859-1?Q?DMXn/PjDuEg2tTtblKL4J5juMnfqe7Ew/Us07KgLTxDzKlNySDxukM+G4P?=
 =?iso-8859-1?Q?3QeK+RB55R4B9s9YLpnXnQj0we+SyFfJyAi0pGDKeWHXKWW+rcSnKS7nHG?=
 =?iso-8859-1?Q?TpkqKkvYwmCWP5OjyXtTMWYvQpd4n76zUWGqeEEDaZZafbXTSnZFhaiyhS?=
 =?iso-8859-1?Q?WK6NiQj4shPQf2ZqP5hPyPhMxzPJ/LxGPLlzR47MdI0pSNMX0fRBHZROxa?=
 =?iso-8859-1?Q?cu4+/2E7JbCiB5uaAkralDukQw4F5oO559qhPaPcsZ6UpOlGfD3QAttlp7?=
 =?iso-8859-1?Q?BKeKjOMJJQX2Mh+PgROVySWENVIfS0EnSDHtzUvIfopVbDjZn0TZ16tiTu?=
 =?iso-8859-1?Q?FhJqAj28BiiMf6fWrz6jDjRWXuoXdvFRT6kfh6cSCRvVQ/8j0FnBHDIU70?=
 =?iso-8859-1?Q?peov9LZ5JO1SrTeC5JyQxZdlP9g02+MA2k+RyYF/NeDAjXZX88s3hNs4Qe?=
 =?iso-8859-1?Q?5cHo6wawYGxwcSSym2JA+kQbbX+xCDeMiMQgY0XeTuDuGpGv0FT98BE8DO?=
 =?iso-8859-1?Q?9xjiZ0oBEJdsUOckFRXbXc/U08fy9NeuALT8fnSQdkYe/FOWiIvl0StNVb?=
 =?iso-8859-1?Q?+xwufFn3J1JBDJrirCAOppWMe/ZAfRVViykbCmXBFiQu5GIP8XYjLpo17X?=
 =?iso-8859-1?Q?B3wr3vvVrEjOhbyy/rD1xeo/OnxZ4rK1qtzd8ubbt3UyFIPdvuz8j3zoag?=
 =?iso-8859-1?Q?OFU9AW+l54XDdZAUu5ZeRVxcZyvLMyze7ljX9iG/x5BfDw4JVjCKiqKHVP?=
 =?iso-8859-1?Q?MKKR896+yXmBNa6QX5LrNKgkkhPcVmoK47fJq4wLLgUXBMRxA7PiVPkDte?=
 =?iso-8859-1?Q?w6kznaaRn4XhBG1uDDtB/kzDdEInu8dx/sUFor+DOti2BjfMnp1YG0SKZH?=
 =?iso-8859-1?Q?zNmSaPWmU9uPJyVGqI/lT5LRZS8QsxSodvdvLv01oVJIceqMkj8Be8RLCY?=
 =?iso-8859-1?Q?L/hJ4M03Kd6teuV+IJQo5Na/BcWqZt0Ka5N6jJ3u3jGdQoLtrJvT2gF725?=
 =?iso-8859-1?Q?81mRaxgl8vWg5H8klErbUaQJaC43RM2EAj7q2VKH/H3bhVYIQ0ziuObr1x?=
 =?iso-8859-1?Q?U3tHgxpu1XuSK6AhVPyvDqLzQSREIEc2UI+ByuQzPO/3h11+MxfZCDJmkO?=
 =?iso-8859-1?Q?nJpdcsI04Zzik3W8k9yc3v+qi0ygiqdaPcahah3cgHb+eGeL3XYhJBeM2r?=
 =?iso-8859-1?Q?ZXSy5A3vdpkwHYrr2mKGYYJfSbMKWRFC2C813o3Y/lYMu6AgJNK+owr+mK?=
 =?iso-8859-1?Q?sG4W6yq6cacMr8Mwm/czH8HPyf/uKRXPIElW46lnadsUlugwKxeex0gKOw?=
 =?iso-8859-1?Q?E0VLwiw4X6r0oJy5UPE+z0FP2mOArfRG7OdFxzH4akdqnTiX9wa+3QsR0v?=
 =?iso-8859-1?Q?J2i4muoZH8YKmci7zkDFrnNI1DlYNG4yC1F5twBCBPYjmbzfiVEweMfA9X?=
 =?iso-8859-1?Q?JWImJE0XXTSMa41lJnbbeoCYcsIyxl+zXfOe6VTH0o5LpqNylzGYxFOPzg?=
 =?iso-8859-1?Q?1iHEJf9UJ+YwVfdkfLzWOd7+AIl/W2YItl/UYZ7bNqBGHubTPGTE7zeZLQ?=
 =?iso-8859-1?Q?4xksHDiNPwpgkSv2jBTBS0fVszcYiGcP71?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d16d7c7-7177-4986-8da8-08ddba457e19
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 15:22:58.9703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQPNYL4ocOfarAKV9Pd3VL8bR+xbAI2lo39e9mkAzZTjefl5XsxIA3CMja4aIyFBvfs0eLrijs9bGyAecNwitQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
Received-SPF: permerror client-ip=2a01:111:f403:2416::615;
 envelope-from=etanous@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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
Reply-to:  Ed Tanous <etanous@nvidia.com>
From:  Ed Tanous via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 03, 2025 at 05:17:31PM +0200, Cédric Le Goater wrote:
> On 7/3/25 16:42, Ed Tanous wrote:
> > To support the newly added gb200 machine, add appropriate tests.
> > 
> > Signed-off-by: Ed Tanous <etanous@nvidia.com>
> > ---
> >   tests/functional/aspeed.py                    |  9 +++++--
> >   tests/functional/meson.build                  |  2 ++
> >   .../test_arm_aspeed_gb200nvl_bmc.py           | 26 +++++++++++++++++++
> >   3 files changed, 35 insertions(+), 2 deletions(-)
> >   create mode 100755 tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> > 
> > diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
> > index 7a40d5dda7..b131703c52 100644
> > --- a/tests/functional/aspeed.py
> > +++ b/tests/functional/aspeed.py
> > @@ -8,8 +8,13 @@
> >   class AspeedTest(LinuxKernelTest):
> >       def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
> > -                                   cpu_id='0x0', soc='AST2500 rev A1'):
> > -        hostname = machine.removesuffix('-bmc')
> > +                                   cpu_id='0x0', soc='AST2500 rev A1',
> > +                                   image_hostname=None):
> > +        # Allow for the image hostname to not end in "-bmc"
> > +        if image_hostname is not None:
> > +            hostname = image_hostname
> > +        else:
> > +            hostname = machine.removesuffix('-bmc')
> 
> 
> This change belongs to another patch and it doesn't seem that
> this series needs it. Does it ?

I Should've been made more clear in the commit message, but yes, this is
required because the hostname of this system is gb200nvl-obmc, so
removing the postfix of -bmc fails, and the test fails because of it.
This code allows adding an opt-in param to handle the different string.
I can break it out into its own commit if that's an issue.

> 
> 
> Thanks,
> 
> C.
> 
> 
> 
> >           self.set_machine(machine)
> >           self.vm.set_console()
> > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > index 85158562a2..d2864543a5 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -32,6 +32,7 @@ test_timeouts = {
> >     'arm_aspeed_ast2500' : 720,
> >     'arm_aspeed_ast2600' : 1200,
> >     'arm_aspeed_bletchley' : 480,
> > +  'arm_aspeed_gb200nvl_bmc' : 480,
> >     'arm_aspeed_rainier' : 480,
> >     'arm_bpim2u' : 500,
> >     'arm_collie' : 180,
> > @@ -126,6 +127,7 @@ tests_arm_system_thorough = [
> >     'arm_aspeed_ast2500',
> >     'arm_aspeed_ast2600',
> >     'arm_aspeed_bletchley',
> > +  'arm_aspeed_gb200nvl_bmc',
> >     'arm_aspeed_rainier',
> >     'arm_bpim2u',
> >     'arm_canona1100',
> > diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> > new file mode 100755
> > index 0000000000..8e8e3f05c1
> > --- /dev/null
> > +++ b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
> > @@ -0,0 +1,26 @@
> > +#!/usr/bin/env python3
> > +#
> > +# Functional test that boots the ASPEED machines
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +from qemu_test import Asset
> > +from aspeed import AspeedTest
> > +
> > +
> > +class GB200Machine(AspeedTest):
> > +
> > +    ASSET_GB200_FLASH = Asset(
> > +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
> > +        'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
> > +
> > +    def test_arm_aspeed_gb200_openbmc(self):
> > +        image_path = self.uncompress(self.ASSET_GB200_FLASH)
> > +
> > +        self.do_test_arm_aspeed_openbmc('gb200nvl-bmc', image=image_path,
> > +                                        uboot='2019.04', cpu_id='0xf00',
> > +                                        soc='AST2600 rev A3',
> > +                                        image_hostname='gb200nvl-obmc')
> > +
> > +if __name__ == '__main__':
> > +    AspeedTest.main()
> 

