Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FACC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5f4-0000TJ-RS; Wed, 29 Jan 2025 05:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5f3-0000TA-EI
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5f1-0000AX-Pr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738147867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v1FE+aS/lv3LgR381FhpWA+pypiPloNkBTblbf7OS/g=;
 b=RZUY6pUSQsne0LAzWnGMu7vP3Vv+NgP8CGhaZZdSy7nqW/h4kfiOVbWyXC6lB2DSZHNlGM
 VQOrwpPMsnJ3WFctvDSd4P/S96G8khrHevJfqHHEuqlzrNhml5zVOSEB/ux5INC++h3K75
 FsVLHBVf0/b/AqLzyMBg7WLOfqxpKKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-qRiQmC3JON2blqQTsiA_rA-1; Wed, 29 Jan 2025 05:51:05 -0500
X-MC-Unique: qRiQmC3JON2blqQTsiA_rA-1
X-Mimecast-MFC-AGG-ID: qRiQmC3JON2blqQTsiA_rA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38bf4913659so5011782f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738147864; x=1738752664;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1FE+aS/lv3LgR381FhpWA+pypiPloNkBTblbf7OS/g=;
 b=i2SH55sm0tOV3IIrfjTAZZC87R1E6QVJf2Senws5UOVwZqedLDzRO6C+OC0oYTDZRV
 Wj9TffrMW/oO3g3vCx1qQGFKREPtDQvcgFWp8x4FcFiA4IH1Ssfz3AqUOjq5IjMESgrG
 GcPC4rWL4fRw8TGVI76l7XPjLz19c6NLryF6teScVdxCn+9HOkigwFeBtjF8rIJ/kilU
 hRRdt4grbA+UEgAapDDyObkcv9hAxk4Wce4SWoOx2EKnXNDRfDHvTN71xeD8Xjc+du4+
 t5Kb8eqhPAFnpL+XpU1IdecF84cjDa6s9WEhWZUL8TFGyZWiApMOiXAOQZz/Iel71kkp
 E+eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU34a2MZeCUb2GyCAGZQCZ11BsBSrUK4+U6MGv9KvIlqQwhRum4CD1BbKkwU29QFSjpQJzXFg7DIq+i@nongnu.org
X-Gm-Message-State: AOJu0Yxgj84+2j7eOJx8FzcsmRYhMJ9VBPRvAB8Qe/fwKp4uwmwdAzgN
 W+IhyIdupG3ANkQXOPwzXtcJ/EEv30GlnnjtZnyv2GexdlgvTpHSYcBN7qfAzbb9KxW2i2CRRzo
 JF6FUR2Sf9BW88rzmOO1uKfOpsNB7iKmSV0YLpATeFy4EkB29vCpO
X-Gm-Gg: ASbGnctpmizNsvTR75JPOo/EUgfXFyHIo7/er8mcjeY6IKjCK7mhoJ3TofBW/HBc3Gm
 ckwbYMULA5kyUPz2Gs6CSbRLX1cPwXb8+lxM04hb43rpk03s8uIEnS1q062p/A99153vV24YXIw
 6hRtdgxD5mxYUo7tXRtpwDkNlA6/3JCfwnenC5mk3joxP7ziwO1aNzmnTn/bs5Q1obASfHECfwh
 vGoOrB3NIMZJ45s+FcvtnHo0UyRL928ZGO6M+nN+hBu96JQhQjnE+HJLfeUGcBYx6DMMiKSPGnu
 7P2yZA==
X-Received: by 2002:adf:fb4d:0:b0:38a:88d0:18d6 with SMTP id
 ffacd0b85a97d-38c520972e2mr1640902f8f.42.1738147864380; 
 Wed, 29 Jan 2025 02:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IER06IpBFCKaFU1EwXDNqmy2ODc5VaavSqHOsQM0rKn1xAjPPbyp895q7xsGv0HyFIPBvbA2g==
X-Received: by 2002:adf:fb4d:0:b0:38a:88d0:18d6 with SMTP id
 ffacd0b85a97d-38c520972e2mr1640884f8f.42.1738147863930; 
 Wed, 29 Jan 2025 02:51:03 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-438dcc33e3bsm18138365e9.30.2025.01.29.02.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 02:51:03 -0800 (PST)
Message-ID: <17907481-89d6-457c-bcd3-66a444b1325d@redhat.com>
Date: Wed, 29 Jan 2025 11:51:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 03/10] rust/irq: Add a helper to convert [InterruptSource]
 to [*mut IRQState]
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-4-zhao1.liu@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250125125137.1223277-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RAZOR2_CF_RANGE_51_100=1.886, RAZOR2_CHECK=0.922, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
>
> This is useful to hanlde InterruptSource slice and pass it to C
> bindings.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

This may be a bad suggestion, after all. clippy complains that you're
casting &[*mut IRQState] to mutable (https://rust-lang.github.io/rust-
clippy/master/#as_ptr_cast_mut).

I can think of two solutions:

1) add #[allow(clippy::as_ptr_cast_mut)] and explain with a comment

     // Casting to *mut *mut IRQState is valid, because
     // the source slice `pins` uses interior mutability.

2) drop as_slice_of_qemu_irq() and replace it with something like

     pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
         slice[0].as_ptr()
     }

You choose.

Paolo


