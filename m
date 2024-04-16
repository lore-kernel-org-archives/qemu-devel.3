Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D49FC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 09:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rweqD-0006XI-De; Tue, 16 Apr 2024 05:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rweqC-0006T4-BQ
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:11:00 -0400
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rweq4-0006JH-Ou
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 05:11:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NK7vT3K2giatfHUeiqyco+q2ifL7B5vqjTn8ug6ejpgUJi5VSD6MSzUgE9iZhncyCWnyfrwb/QOujQd2RqDUEUxxsrJpjs2TdMhg76fpTvXTJP1rT9p0UABGmsFAayW9+fI0+2ARFO3+IQjYnS/ZhURlmIXUE57cGKUhAuVfxaMnO/qJeo+cGaGFA7ZEGVC4T7H2SIO5UEF3h3SFk8qcCVLzG7mbqrhOJ4k04LuSvNAp/PEzDa7D+YdfYUZWg3roGLYEECBWjZsp5Dk5v/qaaXgnVCIfLUUuwOHlT33L9MGwUIKXjSUlFo4Ddu6lv542KfVLffJoUkiG84oROcL8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fx5k+KWvQqSY0MhFuh3ohXbkQpIxinY9RKwC99b94o=;
 b=R4OwpRCbiJ80DEAfarkL+zTeYkjAdPDzvRnWp8AhaKS0kppgjU6cehTdyESPzb+JJNulwjB7M3Cy2dpDEH9C+6fOzOgYZ+osbIiz7voFCfVYLbNDyitAaQLjoWXDnAoyNPaZmRdbRhJTISqEnOPg0dlAWaLwai6HpF66ke7ZCGw7uH4czN8fC92PATPAg6C3ry2c5oovnyEPNhDeVMz7tNA3e2PI+cLdyeo+HBfVvDf9kIKNNw2PzUN5LVgMS5nyc9AovmN00LNWiWjrdgQXMQcJ6oXDQDb+MKZhN68uVc4aEgkqC1ZjfOQU7i/wusJxOxWIwCLzoHSVhLovXHcgzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fx5k+KWvQqSY0MhFuh3ohXbkQpIxinY9RKwC99b94o=;
 b=2axVXhtMc5Qqh/skW8HDJ+J/qCRZELpSv6mwDGFycab17RiYBE8OgCmMgAtFK16EgUIzkLcqqpxkKwEYBQdCc0xyQzjrs4G7kBt4gCfCsygo8bqqjk/bpht/S9aFgrpi22RACtWSlRyQR3FzSIy0JgZD7hkM0t6C3ZUXkckrwF4=
Received: from BL0PR02CA0023.namprd02.prod.outlook.com (2603:10b6:207:3c::36)
 by DS0PR12MB8017.namprd12.prod.outlook.com (2603:10b6:8:146::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 09:10:48 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::e9) by BL0PR02CA0023.outlook.office365.com
 (2603:10b6:207:3c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Tue, 16 Apr 2024 09:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 09:10:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 04:10:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 02:10:47 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 16 Apr 2024 04:10:47 -0500
Date: Tue, 16 Apr 2024 11:10:39 +0200
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 5/6] docs/devel/reset: Update to new API for hold and
 exit phase methods
Message-ID: <Zh5Aj3gKtTI4ixzf@XFR-LUMICHEL-L2.amd.com>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-6-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412160809.1260625-6-peter.maydell@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cc8d0bd-d831-4348-758e-08dc5df51af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lkIiMo6BJXlBWyu+quCY5763o/cflNv1KWBhhD/aB8Zmxkyy8UssCpndjL+auW+bHVwgDJX568xpFuKM51bIErlxn9ickf8cIHvmP/hFdM7rRTBDgD3ZaZ4gnObcv1H7k+iLtVcZXacfcOqBD9jJ7aNaBzBU4yQVRwLL9uG1ziS9BvH5koRJIBVJ/tPimUXEPi399Ici+B+yJofDfdA5gWgjfs+cKFZ5BDHDoXvFTbQ5E5AIKcBg1Qz6vTsH+Yx3AwffSIrPsy/Ck1h+NHjyiKUnzooq6oVr1mGEBKdUXvwHM0TIiElX5LIQN2truukzh2n+FZFpjxc1WR3T7ksT1FuwdXGacLVMZMqzY3awbJK6NKN1jPbUSQa2L4SwJu9UxMdN29PA5Dbu5Jmu20LkpNUB8nptco7nZP60k+cfA1l/Ab+CrUc/jtA89+slJfUt6KBuaQIMZILvo4DF/fCbhwTVPk+iDbS9eStG1UuAn0q+pg7hMJZYH8q5jk1BiBhA+UmqzgNPvzkhZ3yPIyUI/Ef9zm3t20uvYv7pA1zrpRHqjdBU4wpdh105YDqRXN9v0H3yjx/vQYsN5+mg8BDsebjmAMRddON3MR5BEIfyHBDO7PsQAEE9cltmj9ddWHPsssvrxG8KjALg0/KZCWsy3iUEEm4haZcK5mZSlz6z30KUbv6Lt/rOx1c+GQoq57owqAouAR01fVw4JQ/Ni3s3y3lQgfBlDbXDaOafMvC0qQ9E9Bd4VTlXC4JtXpBTrfL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 09:10:48.0160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc8d0bd-d831-4348-758e-08dc5df51af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8017
Received-SPF: permerror client-ip=2a01:111:f403:2009::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 17:08 Fri 12 Apr     , Peter Maydell wrote:
> Update the reset documentation's example code to match the new API
> for the hold and exit phase method APIs where they take a ResetType
> argument.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
>  docs/devel/reset.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
> index 2ea85e7779b..49baa1ea271 100644
> --- a/docs/devel/reset.rst
> +++ b/docs/devel/reset.rst
> @@ -150,25 +150,25 @@ in reset.
>          mydev->var = 0;
>      }
> 
> -    static void mydev_reset_hold(Object *obj)
> +    static void mydev_reset_hold(Object *obj, ResetType type)
>      {
>          MyDevClass *myclass = MYDEV_GET_CLASS(obj);
>          MyDevState *mydev = MYDEV(obj);
>          /* call parent class hold phase */
>          if (myclass->parent_phases.hold) {
> -            myclass->parent_phases.hold(obj);
> +            myclass->parent_phases.hold(obj, type);
>          }
>          /* set an IO */
>          qemu_set_irq(mydev->irq, 1);
>      }
> 
> -    static void mydev_reset_exit(Object *obj)
> +    static void mydev_reset_exit(Object *obj, ResetType type)
>      {
>          MyDevClass *myclass = MYDEV_GET_CLASS(obj);
>          MyDevState *mydev = MYDEV(obj);
>          /* call parent class exit phase */
>          if (myclass->parent_phases.exit) {
> -            myclass->parent_phases.exit(obj);
> +            myclass->parent_phases.exit(obj, type);
>          }
>          /* clear an IO */
>          qemu_set_irq(mydev->irq, 0);
> --
> 2.34.1
> 
> 

-- 

