Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DC3C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 05:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3o5I-0001sC-16; Tue, 08 Sep 2026 01:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x3o5F-0001rj-Nn
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 01:09:25 -0400
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1x3o5E-0003F0-3e
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 01:09:25 -0400
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-398e10200a6so2217946a91.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 22:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788844162; x=1789448962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VYy8Tu/Hshu985z2qFyoip2I62SwqYXwvEahvMOkIUE=;
 b=RJ336z5pxnmi14UxcYf68Oaaf1ZY0uNu5mQ4qVa46leVC6wnrXFsb/8v2Otl70CXVC
 zYjcjtq9xWo+2Dhltxwp3aS9+A3jBKDNleWkhncp5ojVnSJcuuOToO8MIupSqEcv4FeV
 zSwXgdOKnXj/8ImaDYOmxbedMRHm/suCmirh6OlUkdxVCOf6AIO18eyWpNXb/2hopS9X
 39IjvcIX0g3SAv5VfJ7zIYahBWlK3ywEuOCTPRt8UJes5MkZvz0wE7IvtstD+v1uDrg9
 JV8Z8f9JkIk5Biyxkr/NMRimPTA282JBaRSeLatPKVSWIX0SJvP5Uhv+I/yk/oUCXJSM
 uXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788844162; x=1789448962;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VYy8Tu/Hshu985z2qFyoip2I62SwqYXwvEahvMOkIUE=;
 b=rwJxqZ5mRSplIaTjjpVEm0FOrj7jDOP4oDsu14F0ECIqdXONEPfsFZgDqKVuqxTW+2
 oqjEoELDaJn/nupY1dn7Yv8ArSSckQicjAHm16S+KM2iu5eFDDF9kZI2OnaAN/eE1odQ
 gfFHodffCVK2QM7oGLAZxPz89RjU3F3Dpd9kmkIDWT3re3+odnAU8JPvGLHN9J1QUvZv
 kHjioCCyGQqlOyvtw0fCP0bdLa/G/xIXks9hBMgsw5SeBgSVPOOjLZwrYA6E8JNFjSnn
 DBWILBrEDYhvk/vG6OJa+kD8oSQjra/fEHEZPr4sVzW5MNlDGR7o/b5IgvLoihrUKkmi
 ccnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoOnrwnaiyQbK3CwgYZKXxlGW7+O1Ng7BCDqyu0V2i8g7uhJrdPIbVlRhRRp4Sfnd827on4gftV3UN@nongnu.org
X-Gm-Message-State: AFuF++lRQaq6Ic5Z/PidurTEOFvrTtVJGQBTvDRKh2+7mDlpxIud5SWL
 T/suYtpOsZevTgJBm+2iAVBWscJ38bleWuw4RBzHNjmc/TUtUjmTrXg=
X-Gm-Gg: AYBFou0mIEuvmhXGPnx5jw41m2+KkY7kazkYOIYBbTP2mO7iJM8TaYEhs9cfo/T0OU/
 5vMKrnaH3SOdPbw443ALaAZ57fojlTiXJMcSN95EsbKWis0lM3JHHjDRJXm6deWbAjs0dKc/HiO
 sizTT/RXSWnZ5TEJuQSXt1Dx5ZODu/jodGcn0KXFBUi5Xciw9JXaQLofWlws6h0/Nh6hOfomHNW
 zNIRbaJKVlR9PathXFTiWoRgi45arQwVcO6H/eVI7gaC71NMjHzAHVsyeROEERJF3Zu6HPuIA07
 65RblZML8zyxlhPxGswWaFrTBA9iYaw35VVvjGFv6+gF6Xp9/w8bY4GmJ/eWg7Ucd3ikzNCC0Wo
 s11OOCXkww4zMA+OEYko+zW7mXpKoJwI5wzdzYpmzyC5YHpXyGyUphPvkm/8hwDjuxx5JxkEqD/
 Ao3UBEOuEJsjAu129loJD2wSf/hdrQIOUvVmmR2lLy5OkThGKyLqSVwn/XKQGyptFZztTcnZ7w8
 JJJ2pBFL4d4pVNk52ql1H60VuERbAk1YmBgk+VtUSm21kq/bX5Q
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id
 98e67ed59e1d1-39b2624f0ffmr39291094a91.23.1788844161719; 
 Mon, 07 Sep 2026 22:09:21 -0700 (PDT)
Received: from ?IPV6:2408:820c:8ffa:c0f0:25c7:53f7:86b3:955?
 ([2408:820c:8ffa:c0f0:25c7:53f7:86b3:955])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432423f99fsm29947541c88.1.2026.09.07.22.09.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 22:09:21 -0700 (PDT)
Message-ID: <c425dffd-ccc6-42b0-b083-51f06562237d@gmail.com>
Date: Tue, 8 Sep 2026 13:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com
References: <20260825090435.1492485-1-yuan1.wang@intel.com>
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20260825090435.1492485-1-yuan1.wang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::7;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x07.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Tomita Moeko <tomitamoeko@gmail.com>

Thank you for your contribution!

On 2026-08-25 17:04, Yuan Wang wrote:
> Currently, igd_gen() does not include the PCI device IDs for Meteor
> Lake and Arrow Lake platforms, causing it to return -1 for these GPUs.
> 
> As a result, QEMU calculates the stolen memory size as 0 and exposes a
> zero-sized 'etc/igd-bdsm-size' entry via fw_cfg. When OVMF boots,
> IgdAssignmentDxe fails validation on the zero BDSM size and aborts
> without programming the ASLS register. Consequently, the guest Intel
> GOP driver fails to locate and read the OpRegion (ASLS remains 0x0).
> 
> Add the device ID prefixes (0x7D00 and 0xB600) to igd_gen() as Gen 12
> so that stolen memory is correctly determined, allowing OVMF to properly
> initialize the OpRegion and BDSM for the Intel GOP driver.
> 
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
> v2:
> - Resending because the v1 patch was sent with an incorrect future 
>   system timestamp due to an unsynchronized local clock. No code
>   changes.
> ---
>  hw/vfio/igd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 413a49aae9..a0b6b34d81 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
>      case 0x4C00:    /* Rocket Lake */
>      case 0x4600:    /* Alder Lake */
>      case 0xA700:    /* Raptor Lake */
> +    case 0x7D00:    /* Meteor Lake / Arrow Lake */
> +    case 0xB600:    /* Arrow Lake */
>          return 12;
>      }
>  


