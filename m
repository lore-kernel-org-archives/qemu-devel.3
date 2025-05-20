Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94915C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMr1-0001dT-CU; Tue, 20 May 2025 09:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMqp-0001co-1X
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:17:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMqh-0005qE-6Q
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747747056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=26L8WilLPl3ZjKX0lYZDQ90ErY/KlIDDD5Jjz0Q2+CI=;
 b=jUILb1yKMr2GBM1DZUFDXuDm6c7geEsRiPBQAD3zNMU5X0pTcjKzwU8sDFJ3O5M1+nfOX+
 x5D4Z3H1zn1xZ5reT//im9bV4RmldTLveENhJmcSOzVA6T2xtZIiIYQWEDA3dEk7XyA0MC
 xXld/KuCEaRLRioauoQ9mXghG09/or8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-U_BznM26PDGr97m07Vw7nw-1; Tue, 20 May 2025 09:17:34 -0400
X-MC-Unique: U_BznM26PDGr97m07Vw7nw-1
X-Mimecast-MFC-AGG-ID: U_BznM26PDGr97m07Vw7nw_1747747053
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-601df3b434cso2066908a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747747053; x=1748351853;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=26L8WilLPl3ZjKX0lYZDQ90ErY/KlIDDD5Jjz0Q2+CI=;
 b=HJE6aAjHsdesESzQFTiH12HaROkMszyHUSBAI1AzFdudcbGS2uCxYmzcP9vR4ZfmMw
 Uu8nOJfcDR6LKR2McWv/6Dua4nWPMT42AyZMghHiJiJyJv2n683OdYSSG4c32xv5xiN/
 KlCh0uhHTUPV/k3H66S181hxlAS0v2BYziUpvlheznr1Yk6VgF8cfDf4iNr2Wi/gq4y4
 zmF2MRTCHaxXi/iFt/Ea4OR0eGpoRpMavl+QQnxxBGdWQtpRBIgFJY79sChBNZK1uLAA
 iMA02kGpYQ+A8QsR+0RxtZTQsLgj9I90FP+wzi9JSYS6sjAoJWgItfnDflI2iQexJTm3
 yuGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCwvEt+D6/UGleURIVTz7RY94AW/fcEwNImsmDxayOrB+0tbPo0+XqCmGVFgR3szTXLhvWURlzTyNM@nongnu.org
X-Gm-Message-State: AOJu0YwXpcX+1OKXZBZssN5tGHvWHvTcoTj7cHz1UrrcdUGZk4faXGWQ
 TTU2Vwf7+DZmKs9526n59JAf3MvmQmHmIpFy1bUWyaNCCR3jkGWb9C6XMk9+NCxTqPlncozYTkw
 Lavs5DHU/SYPouumLBO1ZzNdVRxfc8zniZ+gB0CnnJ1jQqpcEIWGImsUk
X-Gm-Gg: ASbGnctHya/SuBcOGlIgqMgZplAt/frxmAqZvt1X1ibV48PLGgaGZx+Qex7JwqoJv/5
 rZKMCVRHQIETFzb5Qkbawqf763x/AVFw5g5fgAo5JCyq6JC1z77Iuorhq9tFyNgoZKaT6XI+nLl
 gSJsAdE0OEo1VE5E/CiUfikJnvZhrCvGXD5vJ+VE43qqHhrNAh8zzvL+Lg6VfboMTOBo42MuBOQ
 I3cCpo5Fr//wFYOpOBfpXQI2KnEmyatqsB2KI2u39NIbezKlHcsre6qedhHosnk5QFbt8zBS6Hp
 hrMvnSG6ok2K/w==
X-Received: by 2002:a05:6402:35ca:b0:601:f187:2eba with SMTP id
 4fb4d7f45d1cf-601f1873197mr5710159a12.16.1747747053359; 
 Tue, 20 May 2025 06:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnCy6eryN8Lmqkgitj1Cn2y+wJ+mRaWLSdLdWgLOX8Np55O9gX2SKa5eKfc+K5UoBIQWENTg==
X-Received: by 2002:a05:6402:35ca:b0:601:f187:2eba with SMTP id
 4fb4d7f45d1cf-601f1873197mr5710121a12.16.1747747052897; 
 Tue, 20 May 2025 06:17:32 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae39995sm7119019a12.72.2025.05.20.06.17.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:17:32 -0700 (PDT)
Message-ID: <f9db97c5-df7b-4c3b-9504-8f02073f8353@redhat.com>
Date: Tue, 20 May 2025 15:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/25] target/i386/mshv: Add x86 decoder/emu
 implementation
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
 <20250520113018.49569-4-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-4-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 5/20/25 13:29, Magnus Kulke wrote:
> +/* cpu */
> +/* EFER (technically not a register) bits */
> +#define EFER_LMA   ((uint64_t)0x400)
> +#define EFER_LME   ((uint64_t)0x100)

There's already MSR_EFER_LMA and MSR_EFER_LME, please use them.
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 4f8ed8868e..db6a37b271 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2101,7 +2101,7 @@ typedef struct CPUArchState {
>      QEMUTimer *xen_periodic_timer;
>      QemuMutex xen_timers_lock;
>  #endif
> -#if defined(CONFIG_HVF)
> +#if defined(CONFIG_HVF) || defined(CONFIG_MSHV)
>      X86LazyFlags lflags;
>      void *emu_mmio_buf;
>  #endif

Please rebase since the lflags member was removed.

> +bool x86_write_segment_descriptor(CPUState *cpu,
> +                                  struct x86_segment_descriptor *desc,
> +                                  x86_segment_selector sel)

There are a bunch of unused functions such as this one.

Paolo


