Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB63E9B245
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 09:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vup3W-0007ts-10; Tue, 24 Feb 2026 04:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vup3E-0007ge-B1
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:50:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vup3C-0001gW-Qo
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 04:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771926594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uhxTsbAesUA1nm5SPUbyvobRkjU0nYscevHqbN6i+jM=;
 b=ff56ztKHGRw+MwGwkoapyPp0wPOggHSGQuq0wokQ01N1LmPDMwUOxxAc/k7ns9PiVXZ8Vv
 LLQfFT8624pDonzqvIz2pLdRWmgecXpYMZZp+NUYumraNSqSkX/ICwC5IbiFXVmne5OKB0
 Uecihvl3hOI3QH8dKfXgRpHB01Qkyhs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-YBC4xmSTNqSGBYWRNt5x1Q-1; Tue, 24 Feb 2026 04:49:50 -0500
X-MC-Unique: YBC4xmSTNqSGBYWRNt5x1Q-1
X-Mimecast-MFC-AGG-ID: YBC4xmSTNqSGBYWRNt5x1Q_1771926590
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-437700715ddso3221177f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 01:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771926590; x=1772531390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uhxTsbAesUA1nm5SPUbyvobRkjU0nYscevHqbN6i+jM=;
 b=q+NY+wwX3PFVxUaLA3+uvPq3F0Lo9gi6moOh5HiAwnbTtIwspzIzKF71PqC6/y2GOA
 tfjWbuc6G/g3xBNoDRZub39oYrBL0GMMjwVv+isgis+jsG3jmRDbL5fpDDdjO70SqGFc
 LiGTHRLmXGFsrNjS8CbSUvXXl9ckSgzdvtuEF4vnX6+GQwPJs+yfwqYDFBrsWon82eSo
 /vIFK1vuddF+cmQRNeC/Y7unu8l9Kg4KizKhG3fuDyM1TyjIo2sVRyKyj1UUrWLisOZI
 98O/EPsIlZtRkBJSxZwdi8ZP+pzKNdZj0gge1KdXrKYIZ5joRm6p/PQyIz7YIck3Mlkz
 klwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771926590; x=1772531390;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uhxTsbAesUA1nm5SPUbyvobRkjU0nYscevHqbN6i+jM=;
 b=BCb4UButxhgBmTSpRr2dh5I/LiYVjmkZctqMhzyLFCVduItEkmf0NzpBogc/6ZO1VF
 hrcsoBs8oyJoRAarvwl8VyC6+8y8Tb6+VRmxQMPAc6EdnGTVO/yu1NIQ18a0A/P39Q4I
 1H1PLwKfhSdLOvBpQPWwCwovzJi7f4AGzfHp5ShiLJ2l+/dyoQ+d1xayAl57tRvwYKBg
 714p1e14T2LeuEbrAU7TRyjIGjxEOZ1Q3sy9FxBoLCkXxjSfqAGDwp1pHKavYJC3bSdZ
 meuSsqz8yS/NXsPDGX/x1YHAgKy78KQKcO28Ce/at8GMvqBKci+RjJ3xTqiICj2dpn1z
 d1Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQwzxK71TU5H5IGD3mbasP1SLxVS5GuxVZ9pLX3u/2bPYmC1Oxdx0znxwxwFPVOxe3jBDnqELRYnwU@nongnu.org
X-Gm-Message-State: AOJu0YypQZk4QOdKROslUtQMiRokj/eV+V2dYuwRs+RFaJA+4x7tlRFN
 db6j/FDA+Sl3RzZ6QMBhW9h67CuRAJu7/Dh/paiFCFSjSeIgV32GtbhLjlGutlkkDS5UmTkQ8IH
 OCI7af1lzfa16WpLKWgPYO049QZUHo1nO1GnfnyvUhqh+HSyx8xQTcIw9
X-Gm-Gg: ATEYQzzIpBGfuGrWTSb4lrsUuEDfqc4KTsxiwtj1sRIjOL0v6Ghtd0Cv+FK5WNwhfxF
 SmzqZkByvwkfZj5WuIsQvjMb0muTzGuiWV21vS7z7Wed05o0G6v/xfOH+bO6nlaoma/4x9DNODI
 SmqjzHtRdEp21BxCAgdpl07kvDqSPkRyg6uSqxzOWojqgjkErlJZFBCtdxzsLfYito42QNw6LJn
 Lz7RfrCV3W80i+5zM7XjsZUcJ+F/nfjl5cl9vIUW5kqF+371Cf2LEaMfRLDibHYPy2oFpuF/tVm
 buQsQPJft1+dyrrjZGwUHxyI45BZ4pHfVSm++qaKgDX7kaFEs4h/WEASBOLcfw9l/Yo7JzGyPan
 ukivooks3mKzl3XVmkiqP/xTId69PWO8CEpJmpQl+ZY4b2ZXWrw3vykkab5uFOdmqYS+MpnQelF
 qHVxSL9ruyisyqGPhB86FTCV/2RnY=
X-Received: by 2002:a5d:53d1:0:b0:439:879f:f8d7 with SMTP id
 ffacd0b85a97d-439879ffbb8mr1507206f8f.9.1771926589610; 
 Tue, 24 Feb 2026 01:49:49 -0800 (PST)
X-Received: by 2002:a5d:53d1:0:b0:439:879f:f8d7 with SMTP id
 ffacd0b85a97d-439879ffbb8mr1507174f8f.9.1771926589108; 
 Tue, 24 Feb 2026 01:49:49 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-4398a292babsm1690416f8f.37.2026.02.24.01.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 01:49:48 -0800 (PST)
Message-ID: <b0297c7a-70d1-458c-8ae4-39a6583f6a41@redhat.com>
Date: Tue, 24 Feb 2026 10:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/28] whpx: i386: inject exceptions
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
 <20260223233950.96076-26-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260223233950.96076-26-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 00:39, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/i386/whpx/whpx-all.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 561a48206c..0259782a82 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -1506,6 +1506,26 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
>       }
>   }
>   
> +static void whpx_inject_exceptions(CPUState* cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
> +    if (env->exception_injected) {
> +        env->exception_injected = 0;
> +        WHV_REGISTER_VALUE reg = {};
> +        reg.ExceptionEvent.EventPending = 1;
> +        reg.ExceptionEvent.EventType = WHvX64PendingEventException;
> +        reg.ExceptionEvent.DeliverErrorCode = 1;

I can't find very good documentation of the WHPX API, but does this need 
to be limited to: 1) #DF/#TS/#NP/#SS/#GP/#PF/#AC vectors; 2) CR0.PE=1?

Thanks,

Paolo


