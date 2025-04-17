Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB04CC369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T1Q-0005lQ-6H; Thu, 17 Apr 2025 13:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u5T1K-0005kW-1D
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:27:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u5T1H-0000SQ-Rt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744910841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VJtUGhrpuHY0ej2pL/8furpW/zCO848mc9PosCyQdXE=;
 b=VAabcynjxOBZz908230DuYVUlcKbeXFB2L2LxpZ/niVtCJZ0K4oWfEsHlWz2Ifbad5qv0Y
 44ztc07PFEWiwFGGbvlFfCrdEGycY+KRbOscoGiGtg+Iv5ABk1S3l23NDZMAtJc6yjIxw1
 omaHwFk/1xF2I6qoOAwvsOr/T40+iH4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-psvCFJaGMCGX2-2qyqw3OQ-1; Thu, 17 Apr 2025 13:27:19 -0400
X-MC-Unique: psvCFJaGMCGX2-2qyqw3OQ-1
X-Mimecast-MFC-AGG-ID: psvCFJaGMCGX2-2qyqw3OQ_1744910838
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eed325461so5844815e9.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744910838; x=1745515638;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJtUGhrpuHY0ej2pL/8furpW/zCO848mc9PosCyQdXE=;
 b=VDYjsbYiS2qmdJoRzOPxlUq0mUB+ssjWaP3FsPGAjHb9eCENXfmqcHk7LJ3H2mfzFx
 9NOY5pv8Ef5uiu8e0+Ql3cTiRyURfyBZCtKj9Hhm0gFPb4OdD0RvoPbrExYrmceIESgW
 S0l9mPDyPFRgBJy24b1IoKv9CFah9Z68ga9fcXkDyZu/7AMvPAENgYytpPUNU1N392nf
 m0yg3+718bJ6ebXT0oEKCYOiE2bl75u+SDOUajmb04qCHaPnNi3gcaNOPRriF2C/JxIH
 PYJFi/9HQa7JHBWEjxlJIXzCwN6sXYnYa19FNpqCwlJ+PbwTPR/kCnlHwL0YROqWrF+U
 X46A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmFPHXPEbkijkdE2f6Bva1mwkeH5DsNXLT9wLJNrcxFWVDsgY+cABi3+GLrkO2y0x/TnLXcNXMvbJP@nongnu.org
X-Gm-Message-State: AOJu0YzL5ashIMkK0E/3fus15RapKsBlGp/7WOEbYuKpw7pT6hoGwL26
 3pTYe4iQEq3BQzv9AD6IhKiUC89YktxBBCSTMebz3Gcq4KcsRiTP+5rFxOJx78GL3XMjUv12B+V
 PRHFDsd4kD7H9Eja4ngDSuR9K6FZpM+JpXmrdahTWhNmR0d3k9H2Z
X-Gm-Gg: ASbGncvBF9aKcMIFCLaY0fvOSdCCHk8pd898/213u54RBDPjcdfpo+38WpvWTFbyjUJ
 Z5NchNS8EqknwmOlQ6bP+ONs8RhNxXg9GAD6LojBN1Pg8Pol6L1cIOgRdsPeQBsE3Euuuw9RBA0
 7xonVct0FQ94cmudgI46FWDbh0PV2iZkJnGM9aSTX6TKey6/Gv9ZvnvQbgVgYr/DcJi+1qpJV0z
 Xu24UrjPC+m46QQTddukZIIBdOuONU/Qs6FgO76def0AJLSdcUioUPxkTTOwuXGmv68xZY3w5nD
 1G9jD3dNCop2rG+9
X-Received: by 2002:a05:600c:1e0d:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4405d5fcd26mr69987055e9.7.1744910837326; 
 Thu, 17 Apr 2025 10:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsJarTHVVxJv9SHOwTMu9rvqtMTI0W7TiHWrFCIsY4s5tSXGGk9ZbBsnaeN1ZDmdD/fAs6qg==
X-Received: by 2002:a05:600c:1e0d:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4405d5fcd26mr69986925e9.7.1744910837030; 
 Thu, 17 Apr 2025 10:27:17 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4405b4c817dsm62209245e9.4.2025.04.17.10.27.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:27:16 -0700 (PDT)
Message-ID: <68b6c799-6407-43cc-aebc-a0ef6b8b64fa@redhat.com>
Date: Thu, 17 Apr 2025 19:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 07/19] target/hppa: Replace TARGET_LONG_BITS
 -> target_long_bits()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-8-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250403234914.9154-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 4/4/25 01:49, Philippe Mathieu-Daudé wrote:
> @@ -101,7 +102,7 @@ static void hppa_flush_tlb_ent(CPUHPPAState *env, HPPATLBEntry *ent,
>   
>       tlb_flush_range_by_mmuidx(cs, ent->itree.start,
>                                 ent->itree.last - ent->itree.start + 1,
> -                              HPPA_MMU_FLUSH_MASK, TARGET_LONG_BITS);
> +                              HPPA_MMU_FLUSH_MASK, target_long_bits());

This ignores the fact that TCG is still using the target_long type, so 
there's no real hope at this point of differentiating TARGET_LONG_BITS 
this way.

I think that you really need to make sure that target_long/target_ulong 
are little more than a shortcut used by TCG backends to invoke *_tl 
functions.  Basically remove all uses outside target/ and tcg/ (a lot of 
uses in hw/ are for sPAPR devices and they can be replaced easily with 
uint64_t; there are actually not many).

Then let cpu.h define target_long/target_ulong so that you can remove 
the uses in tcg/ as well, and poison TARGET_LONG_BITS outside target/. 
This way TARGET_LONG_BITS does not need to be part of the TargetInfo.

On the other hand, if I'm missing something in your plan just tell me.

Paolo


