Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82EDC28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqg8H-0000Lm-Dr; Fri, 07 Mar 2025 17:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqg86-0000Ix-7c
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:25:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqg84-0002OI-Np
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:25:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-390d98ae34dso1767863f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741386315; x=1741991115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRC7TXcNY3iZUKceOw/KL3MRlQT/aiJ+WJL3TuGKc6w=;
 b=pSEzNQRTc3cHxsnJ/otYgYQU3LfuGrubi5LyLwibPh8B926jx9QQrIYzNgcUE1nfUa
 jFv6PlqzZbPAo2KTydOWdq1B+yV2GJIzjYXQnnzdSaNjXCb8EM5UgA7rdpZj1wyG/CwY
 lOLRfD4CKm5K+nX5lZqkN0RBFqz2p8RKDjterbYYXmrIlhd9P8OT3pNTaejSPVDls+zx
 qr5ku78yC2Mhf5QQmdIFr/p/RzrjHdnL9cnhcXV6VKpgi+MjLP40Q0J4NUaXIRKfuxbu
 6qbdSCza7Uu+lZJDGlUq0943s+6jKCsESVEmhPiecF+I0rs1AH0R7absN9myBqjfFRF8
 Jvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741386315; x=1741991115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRC7TXcNY3iZUKceOw/KL3MRlQT/aiJ+WJL3TuGKc6w=;
 b=Ci+Hpb8usUfiyVrnlxSCCpVhrBpfvi9+BSJJ4iH1zQYZPUCe3m9n2S0+E5ojZLh4Th
 62vfigV315LNBYt8zRgpJUY/AXjC0VSNZIX45F5EKCr7/sBle3F4CXLJpLk47ndIwYfe
 okWBVANXXTY0kMLEK/4tmSWC50HCmbrLkp4HsKykiHYKTXKVR4qSRYnLKPjh3DvRAVkW
 +f4PeZ6oeMZVKs2QwG1jHhzJBO46Uftz6PMNiLMKjKhW+KZAAEMFqxMxBrTDK3hf3l2O
 XLIlOHx2/zJlzjd/uGJz1ALGt8tp8SFLDESIJLAkimQWOE+rmh6OIZHni4KHV9ddTe7a
 mvAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFqadOEuXoRTQhXvrnu7RhmghwWNrMD/pQjBRkDMyjMVnAHnuDz6WVYaNA50KJTMbyiY3GP0MTTCLW@nongnu.org
X-Gm-Message-State: AOJu0YzJ0CVYSDXLpEmHsyhqBMkJSqLED+PIhUCI1gIJC5a0R+xk88DF
 Ctnd/oZfKSbymj4QiStL/AQiTAbmt9exrhVivMfPC9buWImLffis09FRhMO3NGc=
X-Gm-Gg: ASbGncswW/sG1ulfeT2Dcku3Uh84H1G2BNdAdkb3InxhPsmHKIiDL/m8i7GoxWZZl85
 rDiRCZhW6cElr91SMbe0Si3hRQYWSMCJ1M8tPffnJO9PpBYBl0P03qsWCzIlWZ07Hooymk0o/bl
 M5SLu+X4OZRbhYEAwDoizSrm0gwxoN26WQVwun5rCyquo3K0qXurPKISV4DpZIXgBLZyTqx7er2
 hbExqbkur4o/D3ce+qXFktTpG+ewJCrCDxjl+BPu5cVbgLsDqQOU+Ly/R+LN+OeFz87uaBopgjt
 nqxW21JqmqoW26jsFJERn04w5sbtomNIGG7mNDlv2zaxOLHDWDj96TViraKe7i6vJL2/RSy4Uex
 QGCAtx67L7I4h
X-Google-Smtp-Source: AGHT+IHKZVGym/fOrROxYCJZQ2letPzSG0LPSvK62neBJgbnoPem+/02emxaWNx+wZuHc96RPLciuA==
X-Received: by 2002:a05:6000:1842:b0:38a:8ec6:f46f with SMTP id
 ffacd0b85a97d-39132dc4335mr3399845f8f.53.1741386314711; 
 Fri, 07 Mar 2025 14:25:14 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4352ed7sm94111965e9.26.2025.03.07.14.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 14:25:14 -0800 (PST)
Message-ID: <8c511d16-05d6-4852-86fc-a3be993557c7@linaro.org>
Date: Fri, 7 Mar 2025 23:25:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Maciej,

On 7/3/25 22:56, Pierrick Bouvier wrote:
> Work towards having a single binary, by removing duplicated object files.

> Pierrick Bouvier (7):
>    hw/hyperv/hv-balloon-stub: common compilation unit
>    hw/hyperv/hyperv.h: header cleanup
>    hw/hyperv/vmbus: common compilation unit
>    hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>    hw/hyperv/syndbg: common compilation unit
>    hw/hyperv/balloon: common balloon compilation units
>    hw/hyperv/hyperv_testdev: common compilation unit

If you are happy with this series and provide your Ack-by tag,
I can take it in my next hw-misc pull request if that helps.

Regards,

Phil.

