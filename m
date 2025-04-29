Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2AEC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 16:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9nR1-00009W-3J; Tue, 29 Apr 2025 12:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u9nQv-00008U-IS; Tue, 29 Apr 2025 12:03:45 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1u9nQr-0004WO-V0; Tue, 29 Apr 2025 12:03:45 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-54d98aa5981so7961567e87.0; 
 Tue, 29 Apr 2025 09:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745942620; x=1746547420; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRqdztSaugXWpGgKEE4JCSZlwe+ATiEFqYL+Pn7jKU8=;
 b=DrLjbEoGQ11wvqdBMSEztg7cEhqHFkZcyyMwMWN5GA1HT6fbVUT349yVSaQQMrgznH
 hsoXzMu8zkgZf4hVGcTydADwBGewgf4bjEzDDozwl30bew7T6UCyicOgWLeKmXPv6f/N
 ORegm3yvcxDYT34iSoFrrKSGeqjFfUueOX3GUzCfu7VfO9SOMPqk0fdd5ze9RQTu1rpx
 oQgzwARaFAiAuLZvhF1DsfaU7G/P4+Pgf383tfk/fxHoheay2LSbzgA5sVjqPWPi1ygH
 whwhDPSY/RUzXZXVDDpT9kNe5c1IY97YklH5z0J1i1bS9Q1U86VY+mz90gAB5KWVyvR8
 ChVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745942620; x=1746547420;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRqdztSaugXWpGgKEE4JCSZlwe+ATiEFqYL+Pn7jKU8=;
 b=wtlnAd5/jeLvqa5Hji3omDFOOgYqvjNgH2xsa0yHilhG7xAdmerEhQ9lFZCaPb7JNJ
 OZKXS2NIGpbTDVbnE214Y1Yx4UKAuC0Dm2B22cj8xUFtzoU4/qTi0lBgVFnvGfz4ua2y
 uYTQocAWb8uzyh6YDneTfL/EjZRw5O0UDbuCZWlH4bzL3SvM+3JdURwB5/IYXs/Qxgg7
 rSYgfokA2R78PIj5eAe1Ohh8b0gAXY0O3kN3IyBKh2VDLZfadtxCcFZF6t0EmlfwicQD
 590tiQVUyJSz1zFd4cyqniwprrQc8rqmtoQEqR0SJBPT/nAJyO1LF9Ve+KtLINNq5wSu
 Skmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnQwyqoyXaDmWi+C/XyZNuwIOVVjeikaBR6Kp6KP7qmprK+KBqNPyNHOywXuAcHWHam1/RK1ZXF6v6@nongnu.org
X-Gm-Message-State: AOJu0YwFrEynma2qw4klmrIUYin0RuermriCR+O8fNJlBPqqsvc9/iZd
 THS0UY/Sr4KDj/2QBVgTFmLuT3CU0gxHeOMFp8UKWNFyIBj0Ejrh
X-Gm-Gg: ASbGncuapd4gESXFI9K3xUVBkvP/GuZ3N8OdBa0IIu4cmywKbIvDh9QgX97YA1GKe4n
 T4f9MaNemIudhnFBo5KrYuUCGJXodgYg8ua+DoJGqxO7JBBnsxgzJMbCRZ7wsE+wcz6f0Om1Wqo
 uy1akNyeOZZHFQnhxIpT8RiugCar3LJn1Uuw+uDYrIa72CbLglInILPx3/RVjNSqiSk5pmPBfhd
 bRe10fWbx9j9I2n/knO+GwwQ8G6g/QcMAi0uIniVtGqGANCEJSdM34n9Liu0AmVaizENG1uCQkx
 F3lygTm0dOiQdW3pWIkVfyJq7JwKJBPadQ3JZKVqBIY+ylQvFKnmUChMRpOz0l3fVvSxrYsim41
 17vdndOJa+NsDG2SjKxvy4vk=
X-Google-Smtp-Source: AGHT+IEQMIgbAmGAD1QPGirA80oBEMSoH6BGYEswe58lFOlpinb+/Mdokzrn3ghlpDYwdS+wcjiovg==
X-Received: by 2002:a05:6512:3e0e:b0:54a:cc25:d55d with SMTP id
 2adb3069b0e04-54e9db145c8mr1520394e87.43.1745942619134; 
 Tue, 29 Apr 2025 09:03:39 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54e7ccb83b5sm1960579e87.245.2025.04.29.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 09:03:38 -0700 (PDT)
Date: Tue, 29 Apr 2025 18:03:38 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 3/7] hw/core/cpu-common: Don't init gdbstub until
 cpu_exec_realizefn()
Message-ID: <aBD4WuIP0MJ0OVpu@zapote>
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429132200.605611-4-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
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

On Tue, Apr 29, 2025 at 02:21:56PM +0100, Peter Maydell wrote:
> Currently we call gdb_init_cpu() in cpu_common_initfn(), which is
> very early in the CPU object's init->realize creation sequence.  In
> particular this happens before the architecture-specific subclass's
> init fn has even run.  This means that gdb_init_cpu() can only do
> things that depend strictly on the class, not on the object, because
> the CPUState* that it is passed is currently half-initialized.
> 
> In commit a1f728ecc90cf6c6 we accidentally broke this rule, by adding
> a call to the gdb_get_core_xml_file method which takes the CPUState.
> At the moment we get away with this because the only implementation
> doesn't actually look at the pointer it is passed.  However the whole
> reason we created that method was so that we could make the "which
> XML file?" decision based on a property of the CPU object, and we
> currently can't change the Arm implementation of the method to do
> what we want without causing wrong behaviour or a crash.
> 
> The ordering restrictions here are:
>  * we must call gdb_init_cpu before:
>    - any call to gdb_register_coprocessor()
>    - any use of the gdb_num_regs field (this is only used
>      in code that's about to call gdb_register_coprocessor()
>      and wants to know the first register number of the
>      set of registers it's about to add)
>  * we must call gdb_init_cpu after CPU properties have been
>    set, which is to say somewhere in realize
> 
> The function cpu_exec_realizefn() meets both of these requirements,
> as it is called by the architecture-specific CPU realize function
> early in realize, before any calls ot gdb_register_coprocessor().
> Move the gdb_init_cpu() call to there.

Sounds good to me:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/core/cpu-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 92c40b6bf83..39e674aca21 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -234,6 +234,8 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
>          return false;
>      }
>  
> +    gdb_init_cpu(cpu);
> +
>      /* Wait until cpu initialization complete before exposing cpu. */
>      cpu_list_add(cpu);
>  
> @@ -304,7 +306,6 @@ static void cpu_common_initfn(Object *obj)
>      /* cache the cpu class for the hotpath */
>      cpu->cc = CPU_GET_CLASS(cpu);
>  
> -    gdb_init_cpu(cpu);
>      cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>      cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
>      cpu->as = NULL;
> -- 
> 2.43.0
> 

