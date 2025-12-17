Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5E6D66B87
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwRO-0007my-Em; Wed, 17 Dec 2025 13:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwRL-0007bM-O7
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:39:59 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwRH-0008Jo-0e
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:39:56 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so81014765ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765996793; x=1766601593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wwcBF4a8auq3KN58gShoxiES+zJFZ1fbyeMiF8lST1w=;
 b=PTGjrq9K3+QUoL/YQWUZvySGgbnfT95REwjHkw0GOt3W38dSEQw/QGgXAUTIhIOpyc
 ctMQq3/dF/zi2djFZCL76RDhdB6K49jOwn16sJKu3RgljCg66sJ14ioemsbSljRk5m3R
 tOMgpXsk9+ULlYOER2ZbV9BJF59gUcPHyor4VCjix7gS0sNth96ym5v/gHm/PTMPqt1A
 t66HijGiK1PYFxZlDbw6cmeKnzB1N/Th6tyThI8C/EYsiXyIc95bp5jtaGY9vX5stj8N
 3iby8/svjb2vm8UyL4R2ZsPxQ4dlzmgWO9+ItDK3MNkE+GrOL/YZPdj4v5RxXRqgQ8VF
 RH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996793; x=1766601593;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wwcBF4a8auq3KN58gShoxiES+zJFZ1fbyeMiF8lST1w=;
 b=QPz5G9XuSMb3LYoVDmMdB1q3asgyvssGE9PklAJUykI9+HnAkykA0nZSJyc8NV1xZt
 qmDnoIGq/tC9K7cssFeKbj4qQlIFLjffInJZ6xmvzSfdUBtfTkITpx4RWITpBg5kOGlA
 SJgxZoVBl6ap7kjY3APCE/+OnpWKDp6oMrObXBQiUsn0VPQrOR88SzGYNmpg60veoHbe
 e5pyPfU8VrULKy3iCtDeViwUtwnNla2tjO8Ro75eBA+ONeyZ1sMVtaWnXeW2eBGyx6w4
 q1p7q7EY9ZIqyn9BuXCPk+DEDabLeVXt4WAtc2LiaUsMZawy0AZ318KrmI3cSHPePGS6
 u7Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMsMpC8i4oj1xLq9/v4vrhPLd66VONCA2o3ozeX8W1s4CChmw06LdPRqZN8RhC4+x1fYh4mb00BmEp@nongnu.org
X-Gm-Message-State: AOJu0YxM1DRCVo9H2wVok+jbwR78iUGGI2n13GsEKsroGCkk+RSMOOEJ
 C0JsHaaKEL6wWhE5FK9Q60LlNMw54VvdNrYI7btNI+Y+9pvo3eQHC6KWkwtiAimRPgk=
X-Gm-Gg: AY/fxX7bgUjPPRBOmIcM4qb/6kLurUbIJ4HuJhBjGbVON0cuJIlg70LZAbSuDesuy5t
 oMuGt6eqfSmc3l2Oc2nSgwBlGbN94heOoJvI2yoA9S1iy5vtaJR6+dnplH8+noPTJp/RugPfc3h
 2t2W/qZWDMiCFHRedHd8sZ3boKivdeX94wNInuCGkGj7GdqvGGaoPOjQSb38QnjMDY409ow6Iga
 R3xWrsern/0B58MBLlPwAcz88yGJ0tJh3b/Ikqq8bMdfJVlwcc85PkqiGfVuXtHOQl+cDfr5hr8
 7adJePoP2R22thybmMzHqO/rIwG8AxNX8QujOlcAWDv3jkPy/4Tr3fox2rA5o/oXBOl9w76depB
 omMrFLp51PXfqzwYdAfeKe4T9YKY9p8dAHHTAHszduBSsjCEbnM8iwjxj2eDPEpxFbMbJwgVaZd
 Kto2lJIteTTDyY2GiktTThpqPPs4W4bPzsBk/1iQqDmWb4BzNjK8LFRd0S59d9DqrOng==
X-Google-Smtp-Source: AGHT+IE7cNMOMTLLH5UltTMHOmD/hQQJuUrpNuWs7hgkA9stEeViOSSa1WAehWXLK6heezLRg5+C8g==
X-Received: by 2002:a17:902:db08:b0:2a0:f0e5:9468 with SMTP id
 d9443c01a7336-2a0f0e597c9mr109720845ad.32.1765996793391; 
 Wed, 17 Dec 2025 10:39:53 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2d19269f0sm224795ad.79.2025.12.17.10.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:39:53 -0800 (PST)
Message-ID: <09edc52d-2027-41db-a981-c622ba30f5c1@linaro.org>
Date: Wed, 17 Dec 2025 10:39:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] system/memory: Remove address_space_stl_notdirty
 and stl_phys_notdirty
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217143150.94463-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/17/25 6:31 AM, Philippe Mathieu-Daudé wrote:
> stl_phys_notdirty() was added in commit 8df1cd076cc ("physical memory
> access functions") as a (premature?) optimisation for the CODE path.
> Meanwhile 20 years passed, we might never have understood / used it
> properly; the code evolved and now the recommended way to access the
> CODE path is via the cpu_ld/st_mmu*() API.
> 
> Remove both address_space_stl_notdirty() and stl_phys_notdirty()
> leftovers.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/memory.h        |  6 ------
>   include/exec/memory_ldst.h.inc |  2 --
>   system/memory_ldst.c.inc       | 39 ----------------------------------
>   3 files changed, 47 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


