Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596B2C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNb9-0008Mr-Kw; Tue, 20 May 2025 10:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNb2-0008Kx-4D
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNas-0007Ni-K9
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fxqtkyAKvkPArALw3BBIARbfvNMzKsXW6FXXpRy10BU=;
 b=hJz8wVzW8yb758Md5Dt9gTwTs1WXJ8x8YDGZaVNOQ91dhmV5rVGo2O/4JsIDNt2ce4HzuZ
 nAXNzV/tEkhrUlWxMtXVI3YDMuFzIGvS/GgZ1Lqex5Bl/RWqtaY8WX4IibGWfrhYeiS1R1
 DqbnS+z8RYoTDQkORGR6G3o+A7VI7k8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-AP2_6SQqPOmzgshwVuC7-g-1; Tue, 20 May 2025 10:05:19 -0400
X-MC-Unique: AP2_6SQqPOmzgshwVuC7-g-1
X-Mimecast-MFC-AGG-ID: AP2_6SQqPOmzgshwVuC7-g_1747749918
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-acb23361d73so679353766b.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749918; x=1748354718;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fxqtkyAKvkPArALw3BBIARbfvNMzKsXW6FXXpRy10BU=;
 b=EQi8KbKUCtkqlNNwG/NVTjMqplxk6e1uaEB8m7cPNSNRvl/pyocNbntojTJ8+ynhrW
 lzl1Cxwm/bWXIuOeZAXmCGUjStspYsu7U4ZWUt2hn/HUU3K3GmoFSfHE8f216UTabOof
 guf1dtHOdr14nY7IRDVh9L0s8qG8Uz83K37fuXAcBU5xKUI2M+EEEvOu6ERJAJQ2f7+s
 ADlmTfr6d0xD2B456CiiA6ralQdSoqZGjb+UoGdFffvv6R9hJEap1X16n4IB5uuAG1sW
 7WVE+r9802KsoNrSyJxvf8DwsNPQn6qCAM0XdQy7lgG6UXLZ8s0U5eJNbpGYbQLShUs1
 Qvwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS9Y4nn3/Fdx8RyEqZvqjQrXI5TQITWuuKTAWCGdbeKzOfASw4lZhTNeXh0p2ZRMhJreQT4KCJRAoe@nongnu.org
X-Gm-Message-State: AOJu0YzUiMgxzCeTs9a/rkGzYvd0FiwRZKLIaFYmjyCG23DIIMwFT2Hi
 l1s1Ei5wWiTGEYOM4bSWM7jlRFjY5qLY8vSd4cTQ9Az092fHqgzIya8Gue3vgKhQ4saNz6Fib7j
 qc8cqCaex9fd2uBUMGFsVKFNiZ4D7GCAQHl7Kszfu9zO68YTVjen/2SwD
X-Gm-Gg: ASbGnctwxTfsLTtCT1aTstLi0DJz86qL97wTHO5L8MyA4WLDSKp+3Fsr0uAOwm9iSI7
 XuwKcoDQeXIS5euSKl9Y+iXhLqfe9wF3uEpwNfrRusZUMwjWx1Fl3IpogphkiuYF238RWZAaFEU
 CY+Eo0GdG0FR7y2GVXIg7NQDqkfc0PlOCSw/7IctWTqroCqhE9oRYijjNr6Q3x4MlTaPdWvNyxM
 I96opU5yM9oknmoRYtxLPnP4yyJWle+TrE5pg7AgHkMV6wprEXhwtFszmPuqxLC/lRTXK2Yg01n
 1H3XmKaXLgwOjA==
X-Received: by 2002:a17:907:c21:b0:ad5:1b14:15f4 with SMTP id
 a640c23a62f3a-ad52fbfa34fmr1300433866b.25.1747749917983; 
 Tue, 20 May 2025 07:05:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeo6sqH5xsI04L4oFQ4Y+YduwHOjZVGoda+NPMu1n5pHQiQovqhzyertbN12BkrIM6Ri3kkw==
X-Received: by 2002:a17:907:c21:b0:ad5:1b14:15f4 with SMTP id
 a640c23a62f3a-ad52fbfa34fmr1300426366b.25.1747749917342; 
 Tue, 20 May 2025 07:05:17 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca5c5sm732734966b.162.2025.05.20.07.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:05:16 -0700 (PDT)
Message-ID: <cd1e4151-0f2f-493b-a333-7bcfdcad8dba@redhat.com>
Date: Tue, 20 May 2025 16:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 17/25] target/i386/mshv: Implement
 mshv_get_special_regs()
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
 <20250520113018.49569-18-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-18-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 5/20/25 13:30, Magnus Kulke wrote:
> +static void populate_special_regs(const hv_register_assoc *assocs,
> +                                  X86CPU *x86cpu)
> +{
> +    CPUX86State *env = &x86cpu->env;
> +
> +    populate_segment_reg(&assocs[0].value.segment, &env->segs[R_CS]);
> +    populate_segment_reg(&assocs[1].value.segment, &env->segs[R_DS]);
> +    populate_segment_reg(&assocs[2].value.segment, &env->segs[R_ES]);
> +    populate_segment_reg(&assocs[3].value.segment, &env->segs[R_FS]);
> +    populate_segment_reg(&assocs[4].value.segment, &env->segs[R_GS]);
> +    populate_segment_reg(&assocs[5].value.segment, &env->segs[R_SS]);
> +
> +    /* TODO: should we set TR + LDT? */
> +    /* populate_segment_reg(&assocs[6].value.segment, &regs->tr); */
> +    /* populate_segment_reg(&assocs[7].value.segment, &regs->ldt); */

Yes :)

Paolo


