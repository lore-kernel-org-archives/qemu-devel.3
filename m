Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEDEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9ltB-0000SK-FU; Tue, 29 Apr 2025 10:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9lt7-0000SA-W8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1u9lt4-00011C-RR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745936681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHCY6WdVEU3LtFWBoTmA3wMJ6DSlEtLNxVMBM885Tf8=;
 b=etsRumgBwtvGvR6Pf4sI4g0bQ7+XzOJzBAt2HL27UhDe9wHkeORyEjRBg16gQ8Ru4c5SDE
 yMsxCdqsluE9RlTW2BtWzkqCswZcJYaZRm2SzCLYCRQzt33MZbb76XEUnwKB2IU1iGFCzj
 SoitOhvYB3lTFzsmDwaMUBETHOQ6FEc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-RzXBW__ZPR2G1aPfBrSQKw-1; Tue, 29 Apr 2025 10:24:39 -0400
X-MC-Unique: RzXBW__ZPR2G1aPfBrSQKw-1
X-Mimecast-MFC-AGG-ID: RzXBW__ZPR2G1aPfBrSQKw_1745936679
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ed0526b507so103723016d6.0
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936679; x=1746541479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHCY6WdVEU3LtFWBoTmA3wMJ6DSlEtLNxVMBM885Tf8=;
 b=MydKzR+VCuxF8h96UuX8BrslX5ylvPky7AESu/xcEmWPjVMPD41253CR1cFaPVLmRc
 sivwLCPiRDaVuL7aEQgqG8AYBwBpvAX+qPlS3menhrtXmWTdMkHHMubxct7RlzxDgr+5
 USHe0UbJAyVfZB8HOTHjJaF4vwBe21OXxpGxfKehIpWsp8qpOlK0bP3pDZ6g25O+x1jr
 GwiY8/klPNjHPAZDnNn8Vuq32FHrrCInlV0dkQupIBaxDr1n8LrYgH7v4EO28uL2vqQ1
 Ud0r7CfsuFjiT3k66w1AuHfS8pteHOKT1X+TONc6T/B9Me5uic69nUKBgMfFemzo2e7d
 rJhw==
X-Gm-Message-State: AOJu0Yw8jY/FIJqqZk1h1S7fkVXQ9STSzB7WgsDzaG47oB0ndpYF7qfx
 JQYyobn6YXz/5DcUbNl4YYq2F2bGM51/F6Eq0F/HtD3WzrK5kDc0zS+LxkuY8aySnil0mYUC57v
 5KaVCeSypAJzDZtm1gIN1Biqh5UY7hajMz4FlmGYEwO2u0AnlHF/G
X-Gm-Gg: ASbGncuMcDD/STRY/5cQbDtZw/7CX/sfrIIDR0W7SdRdkGCea/eMJrFAcbZoX9b22Ll
 ZH2KXyp4DgrjJUjHZg3BSC5t+JTVH10bOu/Y8V+3I799J5AWnMxZ2oaibkChgAMq0NDkD8ZTbiW
 vlg53DeVC4B5BKl2FigzbFzPKZGCqp0I8+EDLT3KSa8bUS3tiPoVimnhYt6ZT6Z5UHocRkZp5QN
 kNdgsR5CowcbQjI6s13/fhPe4GER9q4C+RMJam4PXB0sBYM6+ljEI1Szi5Xv0D7uoRH9FQEV0rM
 VGA=
X-Received: by 2002:ad4:5e85:0:b0:6d4:1bad:740c with SMTP id
 6a1803df08f44-6f4f052eae5mr65961966d6.4.1745936679239; 
 Tue, 29 Apr 2025 07:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHde9/dC4TIhlJ/cB0hUyCymXQTIypEYoHGGijtf+9rV4ZQVKR96ETIdKycWrL27W7aIFl6lQ==
X-Received: by 2002:ad4:5e85:0:b0:6d4:1bad:740c with SMTP id
 6a1803df08f44-6f4f052eae5mr65961426d6.4.1745936678855; 
 Tue, 29 Apr 2025 07:24:38 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f4c0933f01sm73610106d6.28.2025.04.29.07.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 07:24:38 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:24:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Helge Deller <deller@gmx.de>, Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] target/migration: Inline VMSTATE_CPU()
Message-ID: <aBDhI1_frQQGVfV3@x1.local>
References: <20250429085148.11876-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250429085148.11876-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 29, 2025 at 10:51:48AM +0200, Philippe Mathieu-Daudé wrote:
> VMSTATE_CPU() is only used in 4 places and doesn't provide
> much, directly inline it using VMSTATE_STRUCT().
> 
> This removes the last COMPILING_PER_TARGET in "hw/core/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/hw/core/cpu.h       | 12 ------------
>  target/alpha/machine.c      |  2 +-
>  target/hppa/machine.c       |  2 +-
>  target/microblaze/machine.c |  2 +-
>  target/openrisc/machine.c   |  2 +-
>  5 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 12b2ff1f7d2..1e87f7d393e 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1121,20 +1121,8 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
>  void cpu_exec_unrealizefn(CPUState *cpu);
>  void cpu_exec_reset_hold(CPUState *cpu);
>  
> -#ifdef COMPILING_PER_TARGET
> -
>  extern const VMStateDescription vmstate_cpu_common;
>  
> -#define VMSTATE_CPU() {                                                     \
> -    .name = "parent_obj",                                                   \
> -    .size = sizeof(CPUState),                                               \
> -    .vmsd = &vmstate_cpu_common,                                            \
> -    .flags = VMS_STRUCT,                                                    \
> -    .offset = 0,                                                            \
> -}

Before looking at this I didn't notice there're a bunch of vmsds that are
with version_id=0.. but looks like it's working all fine..

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


