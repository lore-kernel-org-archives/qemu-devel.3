Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F34E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 12:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLiO9-0005Fe-8D; Thu, 12 Dec 2024 07:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLiO6-0005Cp-M5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:33:50 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLiO3-00064i-0O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 07:33:50 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so391832f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 04:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734006825; x=1734611625; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7eeuuOc5XxSSLvHMeYaqYK9dMU712B99KopMX99Lnvg=;
 b=oBql6ZXqCwRlMTQD1PY81PFJgu674LoRKnnTQVYK+1w9cptAs9fPx/dVFnkGafV/R0
 p7lsnifuJ7zQm0QBLYyhZSG50ZQIInUz3H3IEeNIaQaAL/O3X1T6uxEG+GSDGZqBkFYG
 V8ZvMGE0USsSGnZbWbfLR+75yvY8iyR6chVqVd8HTREzyrufshkiVhmfw8AWnfNM1Iy2
 13+n6ybvuI7+DqmPDaN5xshvAa5RcFwoDe9P7fiyGlUfsodZgPnfhE0F/I1+HH3kLnSG
 obBqeq+5Zop86Z6M/zZgpGyCZpaT1qbOGmtmN5oDBovSEmOH0rywOoWwB9CoEKklRbgl
 PQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734006825; x=1734611625;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7eeuuOc5XxSSLvHMeYaqYK9dMU712B99KopMX99Lnvg=;
 b=DIdwaTNXmGD3KjeNSpZ+ew719LwwLGtWHuwduVfzfr9rjc33mUFImowNrO5CaWjmo+
 4Tl8D1wgt4vmphPczPR6ps/s7uzFWxZNI1K7ywiNyS1sKmgVeqLC7E3V/RjwQH4vUnFf
 D/MFDtfinJ23iKTYKp5Lh4uE2GCSuHiC8tgMTIs6i/E1WpUvmCpcsrFV3h9XJUhEnkMa
 ft9mSyunZGdfw1vHRYS+H03CoVytADA85N0TmNsBURf0hPjhVOSvmJLIZERaSUjiBrew
 jr3ZG80lqcCbcGzF5KtIEGunuAYLUu/leIdnUQUhEH5WvmPb35LarAUipKyPK0OFQ3JL
 MYxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy3m1XpSOEk06mIuerjTgc1ZOCmoOLvMWm/YJac/EMhL0V7AtYY4A9xNGQCe2kQXlMpt84lQnjrrSZ@nongnu.org
X-Gm-Message-State: AOJu0Yw/4Jw/LB6PJILcckKWi1dZMcjoyZf3OOMxFuQ6bFjd04yYwurI
 EiTcdi8LqMHP3gs9PR/v5KoCOn7kVx3dT/P+pytXeiplHikdy1qvWfg7dWWjHNo=
X-Gm-Gg: ASbGncuxrzG4j1F5fX8PdGa+JsmyC5IaySZeKAOve4rUqAIoY380KlD7R5NRVoeb2D+
 wT5Awr+OcKhpZSw3XN8NKzgwSrqQxZuhx9buGdoLvmuhzudjdU8VZqVZdU7RO25K5u6fxQdNDJd
 +FSA04k6AHucVbjelbjpUTsp/5zvUNhhbxVdR8u2SYjM6xEFjmNS5F72de1fcSV8OAyA1qZDIRJ
 /36gacWo+zGnQF+DZ16uK0cWcXdmNMR4aARbkGmPuu1oCaoKVcAan0lwemgnYpyjexbVFafo0jI
 BG9eJKCLv14pQ3sN/oUWzJ3wAQ2MQg==
X-Google-Smtp-Source: AGHT+IEjaoVmXpC1/Zhgt54jBSsLGXV3PbbCX9pb0MUh7NMj/Q+bwzkQGs3AYLHWo08e8zp+GD9vrw==
X-Received: by 2002:a05:6000:1541:b0:385:e5d8:3ec2 with SMTP id
 ffacd0b85a97d-38787697206mr2702886f8f.28.1734006824971; 
 Thu, 12 Dec 2024 04:33:44 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a5005sm3911697f8f.41.2024.12.12.04.33.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 04:33:44 -0800 (PST)
Message-ID: <882b4bb9-1e03-42bf-a455-89bb2dacd4df@linaro.org>
Date: Thu, 12 Dec 2024 13:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vpc: Read images exported from Azure correctly
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
References: <20241212122512.1974242-1-vkuznets@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212122512.1974242-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Vitaly,

On 12/12/24 13:25, Vitaly Kuznetsov wrote:
> It was found that 'qemu-nbd' is not able to work with some disk images
> exported from Azure. Looking at the 512b footer (which contains VPC
> metadata):
> 
> 00000000  63 6f 6e 65 63 74 69 78  00 00 00 02 00 01 00 00  |conectix........|
> 00000010  ff ff ff ff ff ff ff ff  2e c7 9b 96 77 61 00 00  |............wa..|
> 00000020  00 07 00 00 57 69 32 6b  00 00 00 01 40 00 00 00  |....Wi2k....@...|
> 00000030  00 00 00 01 40 00 00 00  28 a2 10 3f 00 00 00 02  |....@...(..?....|
> 00000040  ff ff e7 47 8c 54 df 94  bd 35 71 4c 94 5f e5 44  |...G.T...5qL._.D|
> 00000050  44 53 92 1a 00 00 00 00  00 00 00 00 00 00 00 00  |DS..............|
> 00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 
> we can see that Azure uses a different 'Creator application' --
> 'wa\0\0' (offset 0x1c, likely reads as 'Windows Azure') and QEMU uses this
> field to determine how it can get image size. Apparently, Azure uses 'new'
> method, just like Hyper-V.
> 
> Overall, it seems that only VPC and old QEMUs need to be ignored as all new
> creator apps seem to have reliable current_size. Invert the logic and make
> 'current_size' method the default to avoid adding every new creator app to
> the list.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> Changes since v1/v2: invert the logic and make 'vpc' and 'qemu' use CHS
> while defaulting to current_size.
> ---
>   block/vpc.c | 65 ++++++++++++++++++++++++++++-------------------------
>   1 file changed, 35 insertions(+), 30 deletions(-)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index d95a204612b7..e22d4bfe3fc1 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -216,6 +216,39 @@ static void vpc_parse_options(BlockDriverState *bs, QemuOpts *opts,
>       }
>   }
>   
> +/*
> + * Microsoft Virtual PC and Microsoft Hyper-V produce and read
> + * VHD image sizes differently.  VPC will rely on CHS geometry,
> + * while Hyper-V and disk2vhd use the size specified in the footer.
> + *
> + * We use a couple of approaches to try and determine the correct method:
> + * look at the Creator App field, and look for images that have CHS
> + * geometry that is the maximum value.
> + *
> + * If the CHS geometry is the maximum CHS geometry, then we assume that
> + * the size is the footer->current_size to avoid truncation.  Otherwise,
> + * we follow the table based on footer->creator_app:
> + *
> + *  Currently known creator apps:
> + *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
> + *      'qemu'  :  CHS              QEMU (uses disk geometry)
> + *      'qem2'  :  current_size     QEMU (uses current_size)
> + *      'win '  :  current_size     Hyper-V
> + *      'd2v '  :  current_size     Disk2vhd
> + *      'tap\0' :  current_size     XenServer
> + *      'CTXS'  :  current_size     XenConverter
> + *      'wa\0\0':  current_size     Azure
> + *
> + *  The user can override the table values via drive options, however
> + *  even with an override we will still use current_size for images
> + *  that have CHS geometry of the maximum size.
> + */
> +static bool vpc_ignore_current_size(VHDFooter *footer)
> +{
> +    return !strncmp(footer->creator_app, "vpc ", 4) ||
> +        !strncmp(footer->creator_app, "qemu", 4);
> +}
> +
>   static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>                       Error **errp)
>   {
> @@ -304,36 +337,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       bs->total_sectors = (int64_t)
>           be16_to_cpu(footer->cyls) * footer->heads * footer->secs_per_cyl;
>   
> -    /* Microsoft Virtual PC and Microsoft Hyper-V produce and read
> -     * VHD image sizes differently.  VPC will rely on CHS geometry,
> -     * while Hyper-V and disk2vhd use the size specified in the footer.
> -     *
> -     * We use a couple of approaches to try and determine the correct method:
> -     * look at the Creator App field, and look for images that have CHS
> -     * geometry that is the maximum value.
> -     *
> -     * If the CHS geometry is the maximum CHS geometry, then we assume that
> -     * the size is the footer->current_size to avoid truncation.  Otherwise,
> -     * we follow the table based on footer->creator_app:
> -     *
> -     *  Known creator apps:
> -     *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
> -     *      'qemu'  :  CHS              QEMU (uses disk geometry)
> -     *      'qem2'  :  current_size     QEMU (uses current_size)
> -     *      'win '  :  current_size     Hyper-V
> -     *      'd2v '  :  current_size     Disk2vhd
> -     *      'tap\0' :  current_size     XenServer
> -     *      'CTXS'  :  current_size     XenConverter
> -     *
> -     *  The user can override the table values via drive options, however
> -     *  even with an override we will still use current_size for images
> -     *  that have CHS geometry of the maximum size.
> -     */
> -    use_chs = (!!strncmp(footer->creator_app, "win ", 4) &&
> -               !!strncmp(footer->creator_app, "qem2", 4) &&
> -               !!strncmp(footer->creator_app, "d2v ", 4) &&
> -               !!strncmp(footer->creator_app, "CTXS", 4) &&
> -               !!memcmp(footer->creator_app, "tap", 4)) || s->force_use_chs;
> +    /* Use CHS or current_size to determine the image size */
> +    use_chs = vpc_ignore_current_size(footer) || s->force_use_chs;
>   
>       if (!use_chs || bs->total_sectors == VHD_MAX_GEOMETRY || s->force_use_sz) {
>           bs->total_sectors = be64_to_cpu(footer->current_size) /

Easier to review in 2 commits.

1/ Extract vpc_ignore_current_size(), no logical change.

-- >8 --
diff --git a/block/vpc.c b/block/vpc.c
index d95a204612b..7ee31aaa810 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -218,2 +218,37 @@ static void vpc_parse_options(BlockDriverState *bs, 
QemuOpts *opts,

+/*
+ * Microsoft Virtual PC and Microsoft Hyper-V produce and read
+ * VHD image sizes differently.  VPC will rely on CHS geometry,
+ * while Hyper-V and disk2vhd use the size specified in the footer.
+ *
+ * We use a couple of approaches to try and determine the correct method:
+ * look at the Creator App field, and look for images that have CHS
+ * geometry that is the maximum value.
+ *
+ * If the CHS geometry is the maximum CHS geometry, then we assume that
+ * the size is the footer->current_size to avoid truncation.  Otherwise,
+ * we follow the table based on footer->creator_app:
+ *
+ *  Currently known creator apps:
+ *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
+ *      'qemu'  :  CHS              QEMU (uses disk geometry)
+ *      'qem2'  :  current_size     QEMU (uses current_size)
+ *      'win '  :  current_size     Hyper-V
+ *      'd2v '  :  current_size     Disk2vhd
+ *      'tap\0' :  current_size     XenServer
+ *      'CTXS'  :  current_size     XenConverter
+ *
+ *  The user can override the table values via drive options, however
+ *  even with an override we will still use current_size for images
+ *  that have CHS geometry of the maximum size.
+ */
+static bool vpc_ignore_current_size(VHDFooter *footer)
+{
+    return !!strncmp(footer->creator_app, "win ", 4) &&
+           !!strncmp(footer->creator_app, "qem2", 4) &&
+           !!strncmp(footer->creator_app, "d2v ", 4) &&
+           !!strncmp(footer->creator_app, "CTXS", 4) &&
+           !!memcmp(footer->creator_app, "tap", 4);
+}
+
  static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
@@ -306,32 +341,4 @@ static int vpc_open(BlockDriverState *bs, QDict 
*options, int flags,

-    /* Microsoft Virtual PC and Microsoft Hyper-V produce and read
-     * VHD image sizes differently.  VPC will rely on CHS geometry,
-     * while Hyper-V and disk2vhd use the size specified in the footer.
-     *
-     * We use a couple of approaches to try and determine the correct 
method:
-     * look at the Creator App field, and look for images that have CHS
-     * geometry that is the maximum value.
-     *
-     * If the CHS geometry is the maximum CHS geometry, then we assume that
-     * the size is the footer->current_size to avoid truncation. 
Otherwise,
-     * we follow the table based on footer->creator_app:
-     *
-     *  Known creator apps:
-     *      'vpc '  :  CHS              Virtual PC (uses disk geometry)
-     *      'qemu'  :  CHS              QEMU (uses disk geometry)
-     *      'qem2'  :  current_size     QEMU (uses current_size)
-     *      'win '  :  current_size     Hyper-V
-     *      'd2v '  :  current_size     Disk2vhd
-     *      'tap\0' :  current_size     XenServer
-     *      'CTXS'  :  current_size     XenConverter
-     *
-     *  The user can override the table values via drive options, however
-     *  even with an override we will still use current_size for images
-     *  that have CHS geometry of the maximum size.
-     */
-    use_chs = (!!strncmp(footer->creator_app, "win ", 4) &&
-               !!strncmp(footer->creator_app, "qem2", 4) &&
-               !!strncmp(footer->creator_app, "d2v ", 4) &&
-               !!strncmp(footer->creator_app, "CTXS", 4) &&
-               !!memcmp(footer->creator_app, "tap", 4)) || 
s->force_use_chs;
+    /* Use CHS or current_size to determine the image size */
+    use_chs = vpc_ignore_current_size(footer) || s->force_use_chs;

---

2/ Support Azure.

-- >8 --
diff --git a/block/vpc.c b/block/vpc.c
index 7ee31aaa810..febf7061491 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -239,2 +239,3 @@ static void vpc_parse_options(BlockDriverState *bs, 
QemuOpts *opts,
   *      'CTXS'  :  current_size     XenConverter
+ *      'wa\0\0':  current_size     Azure
   *
@@ -246,7 +247,4 @@ static bool vpc_ignore_current_size(VHDFooter *footer)
  {
-    return !!strncmp(footer->creator_app, "win ", 4) &&
-           !!strncmp(footer->creator_app, "qem2", 4) &&
-           !!strncmp(footer->creator_app, "d2v ", 4) &&
-           !!strncmp(footer->creator_app, "CTXS", 4) &&
-           !!memcmp(footer->creator_app, "tap", 4);
+    return !strncmp(footer->creator_app, "vpc ", 4)
+        || !strncmp(footer->creator_app, "qemu", 4);
  }
---

