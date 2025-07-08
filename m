Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB205C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGI-0007XJ-70; Tue, 08 Jul 2025 16:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDwl-00050G-Sp
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uZDwh-0001r5-0F
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j3y43gfS3ULmLf8QclmoQykkewOEYqM7QnG/7g38g9Q=;
 b=F3TNbDzZVz+yUHeJOd66XNED0z/eb1wWnCN602p38c+KA7JSIhirhKAhSlAIf9V8zWnqK6
 9d6/AvVzafDkzR5OzD3fMB8SgydkBlt9r11nhKIFoSfsAg4ecaJIGMQ+PZXkynAYYC2bGA
 Mad0NJE6UEC8Q7VYMz0nAXs8bZzFEFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-4AyPNuFfPy6OWguAcaD93A-1; Tue, 08 Jul 2025 05:59:53 -0400
X-MC-Unique: 4AyPNuFfPy6OWguAcaD93A-1
X-Mimecast-MFC-AGG-ID: 4AyPNuFfPy6OWguAcaD93A_1751968792
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so2639934f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 02:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751968792; x=1752573592;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3y43gfS3ULmLf8QclmoQykkewOEYqM7QnG/7g38g9Q=;
 b=bXDeWectTTX/4Ec2dRERJojAEz/TSM/e8V7B2tDEaYp4KTvItbgkz/aiaTUMfJ77Po
 ohLlSthA4dFkTnaSFSEN3IqMb/Cs3wwJ9FIwin4ToW05ErEfv9fI+EgfpvWC4x6QSPIF
 Dh7NIyPm3CsmK7yHFPXRKhFDC1JWFTjSLiqj7XAYla04Uf1TD3WYCHT2uridVPWy+/tG
 NxtRk9zL7aOBKne/g+65+QeFqh0s3WOSa1FDUOfIR2Lbc7Nm1zQfBEWvgYnrKLlrPNrt
 ZP/SWXHkdoJ64hA0JNOMhBXQd4ml/K3nhFI3cCcbVy2GIMbs8foa3G7xlJzJ6cIBxN+t
 r+Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBzR08sFO1gAiKA38k1TxyaSVXZdKrIdc4VfoT3fOAiF48V2I86dXSZAKbuiI4OWClVkJmJ7QAQHkZ@nongnu.org
X-Gm-Message-State: AOJu0Ywmn8mXeG9O/72H1dLvK55crGNW2vcfeFQMcYMai7U3GnrlW/1K
 Y3K6/dgvsfr+VjH9ZkzOEFSsG2clJdvjATIipmhcQylLHP0QKCC3hPPAmTtfKs9pciifsOqNjdP
 1Xh3dGlCSG6ORLr6DDE1FxAVMGswbfdUC1gWmAw/tW2YOIz6trfzXx6Qb
X-Gm-Gg: ASbGncvcI+S8svlUlta3R5V/hri9j+o3HNvYoekBL/tjlM9hYLcYDaXRpDu9J39iZMN
 T0ZOdDAgH198aPhVWkxjneN+068w4Dn8XzIz51fEt5MdiXrk5hy90mRq0gR5jxwEs/UpTitkGR1
 DWH2gxL4H9h1/pSWzyUoNZMgiIkPV8iq9RLGTxIbEWtyPA1dh1Qz8HeeZoAkMon1chQ2U12pN9c
 vVZ/ZtT7SRgkKhJRLCsWdmtAEgTuBeEqiSPD5VwVoQnmwDDQhzszUzEIMqc2pB/tLdIZIGcWnxi
 Xnv9LuWL/mAg7uRNVvbSxaJmfWI=
X-Received: by 2002:a05:6000:41fa:b0:3a5:3062:793a with SMTP id
 ffacd0b85a97d-3b5ddea219fmr2294383f8f.33.1751968792027; 
 Tue, 08 Jul 2025 02:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzumgir7n2PYM032ITEV7KD5acBE+7RKmq/C8GwSLethiWbFgcils7v68Fr7EWBBZx6W38Mg==
X-Received: by 2002:a05:6000:41fa:b0:3a5:3062:793a with SMTP id
 ffacd0b85a97d-3b5ddea219fmr2294367f8f.33.1751968791634; 
 Tue, 08 Jul 2025 02:59:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.202.169])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b4709c6b2dsm12297121f8f.40.2025.07.08.02.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 02:59:51 -0700 (PDT)
Message-ID: <65f5b704-624c-4e8f-b778-b6f2075ea1a5@redhat.com>
Date: Tue, 8 Jul 2025 11:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: add Derive macro unit tests
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 7/4/25 12:26, Manos Pitsidianakis wrote:
> We don't currently test our proc macros and it'd be nice to do so.
> 
> Usually this would be done with something like
> https://crates.io/crates/trybuild which runs cargo and tries to compile
> a test input, and checks for success/failure. However we cannot use it
> with meson directly, plus it would drag in a lot of dependencies anyway.
> 
> Instead of compiling, we can easily just expand test input into token
> streams since we already split macro implementation into separate
> functions, allowing us to either get a TokenStream back or a compile
> error message.
> 
> You can run the added tests directly with this meson command:
> 
>    meson test rust-qemu-api-macros-tests
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Nice.  Adjusted for MacroError removal and applied, thanks.

Paolo


