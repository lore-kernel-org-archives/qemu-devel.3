Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD2CC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twlmD-00071z-HA; Mon, 24 Mar 2025 13:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlm7-0006wF-Du
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:39:47 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlm1-000058-Jf
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:39:43 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22548a28d0cso91174655ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742837980; x=1743442780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H43yI9IHhRzM5/JIECZmk2z56+LmKwxWdeivbsQ6qQs=;
 b=FFs3M6dbv6/XE4oi/kWBwS/mKCORgH86osHXqDHocsk0CvSEOs3rzt1mj7qKairM36
 1F6qgwiJrWww1xw4boCmyAAo6ca0tMymXyqFdjOCzVBTrCfSvK/1Pod5098HQsAKt1bT
 2+W1r4FEljwXIwVNtd4MZIv92IwpzCjN4XEBIA8Ul5v3ld6QPpLHhHJFSUrEUJK4Cz4q
 cSp4eQcTSyzaYdxp1+culxNtDxppeA/7KxLHHeOD+2JcxU5RqqUuOrDMymckhfGPA8nV
 x7ipJgl0r8bQN2rGHsFCVqzBdj9DIMMcJii7bxPQMnvvQR9LQWRYgS4HvijI/fECOyYg
 Hi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742837980; x=1743442780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H43yI9IHhRzM5/JIECZmk2z56+LmKwxWdeivbsQ6qQs=;
 b=FSPUxD/ku4KMM3L5Q6YBgqXGc9a5Ce2HnYyn1fBmNMly4yFHCxgBZG/pQnMXUA193R
 /FOk0qVAFzn/FqgJKeRi2QUpjzBT8NaCcs03HI+U/g51leoAIcXdnCivqCHPUKYmQZB5
 6qALGS3dC5rAd6VyNXBC8mp7tHPRUKAOq0c1phOWfm62Pn59pEK53TXZ1S3GkVevvGTO
 8mN9fKRr0ny2wO3MkT/s8oqSOFJcUYK7yvT1TfrVBlCo65YNOXMomfoCMH56ZeM7WF7K
 CmRCrplI8n1H96S1wxHghmeMEggHiHhQGI1pYWDU13tJqb0Wm7BK9BsIRW76MggDJe9A
 Ccww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUag3/rFuNX6YULD9kG2QToJ/+BqB9YYTLM9A4mNzWCLZdbesfBCWxhMiOzYr1Exeaa8J2KinI6XATF@nongnu.org
X-Gm-Message-State: AOJu0YzvHr73VBtuVNSDZDTCBpGwUJTc4xAWGnArDcn7GrpnM3QbMFXF
 aIY8Q23RhqX7rJzgr+XywXE0+vIKuU4709S4QGVV+guucDe/gXeJDoMk21/+K38=
X-Gm-Gg: ASbGnctFRP/yHLYKMkdHZG2iHiONd6As9ciXdOdoFBuvAUojKEwzPI193rlkgPwXytN
 uTubbEDmjUmGMGiz2svrbLbwHpnIUR3n4WYdxE/3i4oshCvRz+iL8v4FFH6HrqrsTp4Jo64jtpd
 VEpYYuOLO8U50fCKS/GkEzoitpQVRvQXDuIA5h0Aw/MTaO+f/Rg00CWUd8UkKHD8pyoNF28AwaH
 19FITBm7cWMweMmJ501Sn2UsQj4ZT3hp38Hg0q/b42qxXRs3LTCpwTpiC5CgAPWzs49YO1jxQGi
 XNwHyw0MmDD2eru1h+GvI7JdR5fe5q5RB2azulL0luxTKJ5EZPC1MBfglV5mDUfXzg6Ksn3fBT0
 kZcFrWH23
X-Google-Smtp-Source: AGHT+IH8lAKoVdlOynhDu7hqnflXSip281umj4ONmUseLhuiajVc4y9nG1IVEf1R+iCMHJMGZW+15w==
X-Received: by 2002:a17:902:d58b:b0:215:6e01:ad07 with SMTP id
 d9443c01a7336-22780c551d0mr196360325ad.6.1742837979623; 
 Mon, 24 Mar 2025 10:39:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811baf19sm74400125ad.149.2025.03.24.10.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:39:39 -0700 (PDT)
Message-ID: <c99b4b18-2222-4868-9e2d-78305e530663@linaro.org>
Date: Mon, 24 Mar 2025 10:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] target/ppc: convert gdbstub to new helpers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-10-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324102142.67022-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/24/25 03:21, Alex Bennée wrote:
> +    #ifdef TARGET_BIG_ENDIAN
> +    MemOp end = MO_BE;
> +    #else
> +    MemOp end = MO_LE;
> +    #endif
> +#endif

That's what MO_TE is for.

> +/*
> + * Helpers copied from helpers.h just for handling target_ulong values
> + * from gdbstub's GByteArray based on what the build config is. This
> + * will need fixing for single-binary.
> + */
> +
> +#if TARGET_LONG_BITS == 64
> +#define ldtul_p(addr) ldq_p(addr)
> +#define gdb_get_regl_value(m, b, v) gdb_get_reg64_value(m, b, v)
> +#else
> +#define ldtul_p(addr) ldl_p(addr)
> +#define gdb_get_regl_value(m, b, v) gdb_get_reg32_value(m, b, v)
> +#endif

Surely you're not intending to replicate this in any target that can have multiple sizes? 
This is not an improvement.


r~

