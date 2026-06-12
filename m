Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81EFCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 07:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXw8Y-0004hr-M2; Fri, 12 Jun 2026 03:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXw8X-0004hb-P9
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wXw8W-0005WL-3R
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 03:17:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781248622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WyoQ4RSl77Ynnc0PvwAI3soqA4c5COnrQITWhBAoPi0=;
 b=AExPkReM0dk6X1tXGTWe/Jc/BJ4gz5le7EnSUARVTNO9pDP7fVVgpxw/fHs1lYntVFEkMB
 KfOvdDw2u7bzBJOMhcIy0HV/D15PGg0Tlb4jVelVMbyQHuHzhutCSx9N/XpPF3rn2EcG/u
 WeszPMpztlE59mRcvo6qWWi6Yazb4Eg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-B85lYZTOOdC4dGddKzQoHg-1; Fri, 12 Jun 2026 03:17:01 -0400
X-MC-Unique: B85lYZTOOdC4dGddKzQoHg-1
X-Mimecast-MFC-AGG-ID: B85lYZTOOdC4dGddKzQoHg_1781248620
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b61243easo6858475e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 00:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781248620; x=1781853420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WyoQ4RSl77Ynnc0PvwAI3soqA4c5COnrQITWhBAoPi0=;
 b=ROI6pwaXisN7Gh+tRjLMzxyfMRdgReMIhWpfDCnM+xDNv973AngxPHAG6Xd/VDVwy2
 qFkR4/k+v5myhnqNBJfBjZrK0X5dVxr1Zt5KucNGWpeXOLBqnQYBwyMgyBxsO1djAaS6
 DO3b7BfVafbCSuYlsRZ5Z9mENdu1WG5wdrFY3D46+kOIxgb0kpvsmGD2RwWpMQk7XZZA
 MaoRb6fEldAImRfRf1RJ0gEHMnLWejKe/GpI3HfBUKYlG3E53lQZ46ejrQ7BBHZ8tKou
 +gGLMeC41KFpYtxDn9Rq9I5Uje7ZNwkaw4CWJgUwmTlNiMtvx19AaAORLK5LCw4MxU8G
 5QjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781248620; x=1781853420;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyoQ4RSl77Ynnc0PvwAI3soqA4c5COnrQITWhBAoPi0=;
 b=DJN43/GZAKcudJ0cxNWFPBq0Q22+OXBdz5JiPcrFDeh3P0LQuO/VA+qzg7le2XFjYG
 AOKYZDrMO9UMwXgc+SO/qdSkGWq/e28CJU94JFQF0Q7EeblpMQYTbp5JKNY+werJWRxk
 FEzn2DGWGLgFh9TJLU66wupHFyC0mHS/r2dFO6C3NKFg/CKyvESW0OhPfL/Z4aGFAN/j
 lEQb5n+LSmVONPbLT5sgknSe8kP4j+QqqywAIbZwqTefyjW8NSJnQJ6OYVGqe9Ewlj85
 ZBsP8a3EDuTPof/5Z7hKA2VSXHJYWj4z31t2n8p5IwjGY6p2xZYRCDAY5khZe6V0qVfQ
 s7bQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qsvLCrCT05yFYwPSbtsZoGPt9B9W6X2bt4S6SCSc7e2NkmawqQLjKdXpPUDp50ejv9QOkEuyJirwE@nongnu.org
X-Gm-Message-State: AOJu0YzQJ5frD8R13fi4DeNKWCQnuHOwjF/dL0+ftTUq+WtUxrbl5Cla
 FFOQrcqJ29bQP2jFchueFtcaq1MbssbQl74tzSAgBhKBEbw2bGblzOVwSQjd05i8+EVIpi0mdNl
 DJh0k7KiEf5UTcVUcLcByjbbtBZ4nTnNq5jqPdH7t1ipCq78ugolle6kZ
X-Gm-Gg: Acq92OEd/QHnP6yBQSW2mPDuOaLvLua60se7AsD/q8UFVzG6VqJjXI10nKIx80nntOc
 myRFFWkB2qo5MvFms+VVPaTnBcxdRtC4i1i2BjARG8/+HPFmH6+3PhAtbz9FoeCepbQcCZrzHAa
 hRZFe5+SsgSFlF/WFOyFsC2IvFcUFF4pD3PISqizMkGsg/eIMfXCPU4qP3OjmyIWj3ON8TX/a70
 IW1LQ2uoJFCfUWSZfRG22WNz71BA0UPpgR7ZajDjgvpnY2ZAQy/POgqjLwNO7GSDL3dPEi+SlfS
 ruIj4YpDEOJ3/ErHkK1SevxOXPbxkekvPXBUc6NHKpRR5twrSvYJ9ktog7ATtIA/XjhY2rxGmFm
 m4AXQCy0XDrkdRYYT1+YBI+2OPl6FGbHag4RUUb4dIaTH8oPoh6hS1wnTbFG3
X-Received: by 2002:a05:600c:820c:b0:490:e104:7943 with SMTP id
 5b1f17b1804b1-490ec4e7569mr16959205e9.18.1781248619775; 
 Fri, 12 Jun 2026 00:16:59 -0700 (PDT)
X-Received: by 2002:a05:600c:820c:b0:490:e104:7943 with SMTP id
 5b1f17b1804b1-490ec4e7569mr16958755e9.18.1781248619293; 
 Fri, 12 Jun 2026 00:16:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm52846465e9.0.2026.06.12.00.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 00:16:58 -0700 (PDT)
Message-ID: <c3abad18-a3dc-4cf8-b552-18946b1dab64@redhat.com>
Date: Fri, 12 Jun 2026 09:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Remove Power8E and Power8NVL CPUs
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Miles Glenn <milesg@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-5-adityag@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260610090800.3672832-5-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 6/10/26 11:08, Aditya Gupta via Devel wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> With no use of 8E and 8NVL, in powernv chips or spapr cores, remove the
> CPU definitions for the cores
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/about/deprecated.rst | 9 ---------
>   target/ppc/cpu-models.c   | 6 ------
>   target/ppc/cpu-models.h   | 4 ----
>   target/ppc/cpu_init.c     | 6 ------
>   target/ppc/kvm.c          | 4 +---
>   5 files changed, 1 insertion(+), 28 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 97750f5edc91..3930ef08ed4b 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -215,15 +215,6 @@ embedded 405 for power management (OCC) and other internal tasks, it
>   is theoretically possible to use QEMU to model them. Let's keep the
>   CPU implementation for a while before removing all support.
>   
> -Power8E and Power8NVL CPUs and corresponding Pnv chips (since 10.1)
> -'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> -
> -The Power8E and Power8NVL variants of Power8 are not really useful anymore
> -in qemu, and are old and unmaintained now.
> -
> -The CPUs as well as corresponding Power8NVL and Power8E PnvChips will also
> -be considered deprecated.
> -

docs/about/removed-features.rst needs an update too.

C.


>   System emulator machines
>   ------------------------
>   
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index 26b6debcfc96..aa13654e83e8 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
> @@ -734,12 +734,8 @@
>                   "POWER7 v2.3")
>       POWERPC_DEF("power7p_v2.1",  CPU_POWERPC_POWER7P_v21,            POWER7,
>                   "POWER7+ v2.1")
> -    POWERPC_DEPRECATED_CPU("power8e_v2.1",  CPU_POWERPC_POWER8E_v21, POWER8,
> -                "POWER8E v2.1", "CPU is unmaintained.")
>       POWERPC_DEF("power8_v2.0",   CPU_POWERPC_POWER8_v20,             POWER8,
>                   "POWER8 v2.0")
> -    POWERPC_DEPRECATED_CPU("power8nvl_v1.0", CPU_POWERPC_POWER8NVL_v10, POWER8,
> -                "POWER8NVL v1.0", "CPU is unmaintained.")
>       POWERPC_DEF("power9_v2.0",   CPU_POWERPC_POWER9_DD20,            POWER9,
>                   "POWER9 v2.0")
>       POWERPC_DEF("power9_v2.2",   CPU_POWERPC_POWER9_DD22,            POWER9,
> @@ -918,9 +914,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
>       { "power7", "power7_v2.3" },
>       { "power7+", "power7p_v2.1" },
>       { "power7+_v2.1", "power7p_v2.1" },
> -    { "power8e", "power8e_v2.1" },
>       { "power8", "power8_v2.0" },
> -    { "power8nvl", "power8nvl_v1.0" },
>       { "power9", "power9_v2.2" },
>       { "power10", "power10_v2.0" },
>       { "power11", "power11_v2.0" },
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index a439eb37ee41..ef019cdb1f3c 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -341,12 +341,8 @@ enum {
>       CPU_POWERPC_POWER7_v23         = 0x003F0203,
>       CPU_POWERPC_POWER7P_BASE       = 0x004A0000,
>       CPU_POWERPC_POWER7P_v21        = 0x004A0201,
> -    CPU_POWERPC_POWER8E_BASE       = 0x004B0000,
> -    CPU_POWERPC_POWER8E_v21        = 0x004B0201,
>       CPU_POWERPC_POWER8_BASE        = 0x004D0000,
>       CPU_POWERPC_POWER8_v20         = 0x004D0200,
> -    CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
> -    CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
>       CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index d25f69f13ba5..87186ec32179 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6310,12 +6310,6 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr, bool best)
>           if (base == CPU_POWERPC_POWER8_BASE) {
>               return true;
>           }
> -        if (base == CPU_POWERPC_POWER8E_BASE) {
> -            return true;
> -        }
> -        if (base == CPU_POWERPC_POWER8NVL_BASE) {
> -            return true;
> -        }
>       }
>       if (base != pcc_base) {
>           return false;
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b94c2997a07f..78a1c4a8393e 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2437,9 +2437,7 @@ static bool kvmppc_power8_host(void)
>   #ifdef TARGET_PPC64
>       {
>           uint32_t base_pvr = CPU_POWERPC_POWER_SERVER_MASK & mfpvr();
> -        ret = (base_pvr == CPU_POWERPC_POWER8E_BASE) ||
> -              (base_pvr == CPU_POWERPC_POWER8NVL_BASE) ||
> -              (base_pvr == CPU_POWERPC_POWER8_BASE);
> +        ret = (base_pvr == CPU_POWERPC_POWER8_BASE);
>       }
>   #endif /* TARGET_PPC64 */
>       return ret;


