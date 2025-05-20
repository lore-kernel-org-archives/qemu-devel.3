Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498D8C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHO1p-0002HG-99; Tue, 20 May 2025 10:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHO1m-0002H7-Le
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHO1k-0004V9-CX
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747751587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7tFvhY4kOLUkmNyk55vH1TkbyZlK7bdQvR0R383uuuI=;
 b=VkoLWxw6PcHLtlQvShpEDGaWf0HGUbD7e5BfmuwQTWkCuDrWURIr+NvzDycLG+x/nW5Ze6
 T8Zw8jswe+4JT2NY9JkHerjtMECG54YiZsKA7VLZKo4/gZbqx+ASMA4dFPkbOtqCZjuqsV
 af6JAr9skTlrvu/noj5pGjNonqfdV+Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-oHdQzhqCPum7H90OY-EXeA-1; Tue, 20 May 2025 10:33:06 -0400
X-MC-Unique: oHdQzhqCPum7H90OY-EXeA-1
X-Mimecast-MFC-AGG-ID: oHdQzhqCPum7H90OY-EXeA_1747751585
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-601f87bb9c8so1495072a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747751585; x=1748356385;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7tFvhY4kOLUkmNyk55vH1TkbyZlK7bdQvR0R383uuuI=;
 b=sjnyFdLwYOM7X5vWo0UCkWa9FNTM/7hxAnek9URp4xDmHQdioIbud89HWFXPUzx+uH
 BGTR2b/xso9ajV6TYFzUL19jW1NVegYmIQ0l86t7Jbkek6jz6tjZOXytSb2ym0FC9/dI
 grsP/RYy+cV9G/rsXc9I3xTtCa5qeqk2GKSGlP8MNbNNDIBx3qy9sQH7GswDKtZpYSOC
 6J188E7VulwgG9pyYmYVBPVZbKMUi2GxVOznYWckOiF5yu9Bi0igG6+nIBix7QqHKDSm
 QV3LXUT+rF9Y/z4wgT4qtDhiR7h7Lor8hiU8RK0KD1GKMW/HKYcrfeJV0oGsxQFuhJhr
 iqLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKI8VGeToobXy+8ePInKhiG1HCt3Y8WeokqYtIeM/iwxsz/n/qN+SkEv4I5FDK0iQjEl4x8/ZfCVS7@nongnu.org
X-Gm-Message-State: AOJu0YziIm8YtdpTsq3rXbi4GSxwH0lgav5wzB5nq0238f7YcfR0qP0G
 rT7cZYT+oJYIx82e4mupvo3pWef9vO7pMc0xwkL1uNeEweuBkmADhxtwNmz28qvpvigrJYNlPAy
 Ou3WmBuM6NmrX2OLOBPtJjpQ15oV2Z317Tscec1uTB18HJ2nw2BNSKmDa
X-Gm-Gg: ASbGncun43Cva961q9NgCmrIjIp7lUazND6JPTZYu2JGtLlHEUjGadmaMhecSaHSkCT
 3Cj8kBc28OkqOY+fjaQhR4awFyuEtQB+/R+vqhtYgZVpBGyectP/CWlsuB9ElApb3GkN7tSSuhg
 syfNAFcpYp5h0LFLzm760wyxjuWU0EQmvBXn5Yks96JbE0CJ1Oy82U6Y5PbRpnLiZ20XwN0B223
 U0Bv3aECHfqsGS6lbvug1/GxXZCe7KCCI3QAL3GGIbt6BRdBnd3Aci8fB+vGMWf/fS3fMwaklWQ
 epqlPi/Y2mb+IA==
X-Received: by 2002:a05:6402:4307:b0:602:a0:1f0f with SMTP id
 4fb4d7f45d1cf-60200a02d9dmr4451513a12.18.1747751585047; 
 Tue, 20 May 2025 07:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3/ihK7rOR4bGhf50pjc8+NRO8Wu7G2hDHTCo3K0LBjSBjHQQqT+77QIocmOPvX/y1JirpMw==
X-Received: by 2002:a05:6402:4307:b0:602:a0:1f0f with SMTP id
 4fb4d7f45d1cf-60200a02d9dmr4451474a12.18.1747751584612; 
 Tue, 20 May 2025 07:33:04 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d502ec0sm7292443a12.31.2025.05.20.07.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:33:04 -0700 (PDT)
Message-ID: <a4be2749-ef7e-467a-a775-822222a06b99@redhat.com>
Date: Tue, 20 May 2025 16:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/25] target/i386/mshv: Implement
 mshv_arch_put_registers()
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
 <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
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
> Write CPU register state to MSHV vCPUs. Various mapping functions to
> prepare the payload for the HV call have been implemented.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>   include/system/mshv.h       |  41 ++++++
>   target/i386/mshv/mshv-cpu.c | 249 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 290 insertions(+)
> 
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index 055489a6f3..76a3b0010e 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -99,6 +99,46 @@ typedef struct MshvMsiControl {
>   #define EFER_LMA   ((uint64_t)0x400)
>   #define EFER_LME   ((uint64_t)0x100)
>   
> +/* CR0 bits */
> +#define CR0_PE     ((uint64_t)0x1)
> +#define CR0_PG     ((uint64_t)0x80000000)
> +
> +/* CR4 bits */
> +#define CR4_PAE    ((uint64_t)0x20)
> +#define CR4_LA57   ((uint64_t)0x1000)
> +
> +/* rflags bits (shift values) */
> +#define CF_SHIFT   0
> +#define PF_SHIFT   2
> +#define AF_SHIFT   4
> +#define ZF_SHIFT   6
> +#define SF_SHIFT   7
> +#define DF_SHIFT   10
> +#define OF_SHIFT   11
> +
> +/* rflags bits (bit masks) */
> +#define CF         ((uint64_t)1 << CF_SHIFT)
> +#define PF         ((uint64_t)1 << PF_SHIFT)
> +#define AF         ((uint64_t)1 << AF_SHIFT)
> +#define ZF         ((uint64_t)1 << ZF_SHIFT)
> +#define SF         ((uint64_t)1 << SF_SHIFT)
> +#define DF         ((uint64_t)1 << DF_SHIFT)
> +#define OF         ((uint64_t)1 << OF_SHIFT)

All of these are either duplicate or unused.

Paolo


