Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B7AC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNMZ-0000F2-J9; Tue, 20 May 2025 09:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNMV-0000Eb-As
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNMS-00041V-J1
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ppmf0CHnohHyH3KNRnHX6RJ+nPhUZJANqMvN7jzJq5k=;
 b=BeOQ5fxYy5OfgRGLQ3nK7pTlF2naYBCzddBjzGgidyUaWa135F/rz/KG37L2UP7cKe1l09
 KYh4kRNYmFmOQPNttxbhw2ic87i5smL7UEWlK6AHoOAf5p/13F9Oth/ijjj7KnJk4Vu/hR
 utzY/30rXvlnaMxC/6t8Oncg4Zv4u6o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-8S09P5NIMyyXd7PEPahE3g-1; Tue, 20 May 2025 09:50:25 -0400
X-MC-Unique: 8S09P5NIMyyXd7PEPahE3g-1
X-Mimecast-MFC-AGG-ID: 8S09P5NIMyyXd7PEPahE3g_1747749024
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a360d01518so3340422f8f.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749024; x=1748353824;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppmf0CHnohHyH3KNRnHX6RJ+nPhUZJANqMvN7jzJq5k=;
 b=Id4Fy4fLNUnevAG18u+zG+N7Tougo0Qn9CmYXb1aDFcfqiBPjG+tFq7gLHpEXNRjMx
 v0pnnflZEDsC9qSUfjY3Jzk+eaRrzBSfoEDZhqAjntgXL+w89B0imQuw1hSW5MYUtSV3
 Pt52pK/wb1q+P+NHcy/cKmMcxS1rigQIzXOMgJcNnOr8aa2qx4OfE+9k5cWDw1ioyToo
 C6yUsnN3FqYS1JWeOzDvta7EOAu64I5f0ljcyL1sEzAvXWc7GlnQmZqncH/ktwdQOr/F
 xUPb5g2RWpKmaEq/xqDXvXJH0itYHqE1UpQ3XeRTbU5MDu7OXNn/iY46EBvGNHW7XG8E
 RU6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi3FXeZ1zG5DnVSfPOyAUSsxq9ML3pJs0/m9+9kdqCbI2CtpQyHHyICeu+SvFHcSMRdm6lop5T8DDY@nongnu.org
X-Gm-Message-State: AOJu0YxGVhXt9RG22a3/Ue1L6tSHDsY2peTVUe+vmW1/00ahZYVpoNME
 +9G6xFTqfX4S1iWTVkRXBxZXNuQ8+h39VQdrYlr5i1tMe7fGXueVi99bdFIdjBKtm1SKucXqhD1
 DIHRNg85+rrjA7bwoR6gvr2mH4KsaAMXYywXIUXvkoWTyPGAyYcG6x/Tb
X-Gm-Gg: ASbGncvPbL8/PZMrhUtn34kP7hlGf26Q1ZSy/FoVCpKPB9IObHaOOJlJ+UffnlieQY4
 6TUgpUHKAJTHtqZUeBZEk0Iw1OwUDtQhmfNEorGS+Ou3xPLeNQjewxqscI0z0IChA1Jm+GPWSVJ
 iMxLAJ0xP+MnyTC2qte1Qf9MZqXpUTihhtUTZnmElJnq00lqUHOyk5WnmQ5JSecTUyQkDOIr+Wl
 wj7wJtG9asFhtdyQCSnNUACmMLjxwtf9NePcXvLleCJCuypsB03zrDSQzNrWRBFVZJeQuFUEnaN
 h8GFxuF5cQvLng==
X-Received: by 2002:a05:6000:2284:b0:3a3:7769:4f8d with SMTP id
 ffacd0b85a97d-3a377695157mr4070270f8f.24.1747749023852; 
 Tue, 20 May 2025 06:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0wTe7M307jBrRPqOnG60uWaREPPmHiKLiUm2BYGxmWBcz8JK0mvtNX198dqxPt8nb1fRCdA==
X-Received: by 2002:a05:6000:2284:b0:3a3:7769:4f8d with SMTP id
 ffacd0b85a97d-3a377695157mr4070239f8f.24.1747749023462; 
 Tue, 20 May 2025 06:50:23 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a364d2636bsm13804686f8f.99.2025.05.20.06.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:50:22 -0700 (PDT)
Message-ID: <8b65b12c-ca3e-4528-9544-65784c862763@redhat.com>
Date: Tue, 20 May 2025 15:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/25] accel/mshv: Add vCPU creation and execution loop
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-13-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-13-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On 5/20/25 13:30, Magnus Kulke wrote:
> +    int ret;
> +    hv_message exit_msg = { 0 };

You probably don't want to fill 512 bytes on every vmentry.  Maybe pass 
&exit_msg up from mshv_cpu_exec()?

> +        /*
> +         * Read cpu->exit_request before KVM_RUN reads run->immediate_exit.
> +         * Matching barrier in kvm_eat_signals.
> +         */
> +        smp_rmb();

The comment is obviously wrong; unfortunately, the code is wrong too:

1) qemu_cpu_kick_self() is only needed for an old KVM API.  In that API 
the signal handler is blocked while QEMU runs.  In your case, 
qemu_cpu_kick_self() is an expensive way to do nothing.

2) Because of this, there's a race condition between delivering the 
signal and entering MSHV_RUN_VP

You need support in the hypervisor for this: KVM and HVF both have it.

There are two ways to do it, for both cases the hypervisor side for the 
latter can be something like this:

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 72df774e410a..627afece4046 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -530,7 +530,7 @@ static long mshv_run_vp_with_root_scheduler(
  		struct hv_output_dispatch_vp output;

  		ret = mshv_pre_guest_mode_work(vp);
-		if (ret)
+		if (ret || vp->run.flags.immediate_exit)
  			break;

  		if (vp->run.flags.intercept_suspend)
@@ -585,6 +585,7 @@
  		}
  	} while (!vp->run.flags.intercept_suspend);

+	vp->run.flags.immediate_exit = 0;
  	return ret;
  }


Instead of calling qemu_cpu_kick_self(), your signal handler would 
invoke a new MSHV ioctl that sets vp->run.flags.immediate_exit = 1.

And then you also don't need the barrier, by the way, because all 
inter-thread communication is mediated by the signal handler.

Paolo


