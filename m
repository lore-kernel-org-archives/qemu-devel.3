Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81466C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn2K-0002QC-JY; Mon, 24 Mar 2025 15:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twn25-0002AM-SG
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:00:24 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twn23-0001iT-RO
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:00:21 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff615a114bso8507238a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842818; x=1743447618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QyOBr9YjbmzOLwKeFu7wpFEtVg6dviWnm+AXyNYm/3g=;
 b=eMTd5GZ8pasmAGoM2CODaJxFGb1TQgh2vPArtmoKeQy4s5Bl/jOMl63l91ZbWaccPQ
 M8+j5c+jU2ZmxzAnEhLWJUXqUwDOX2s9ZwPh2s/y1qxJpXd5KO8iVqqy3gmR3aX1Xpp0
 GhHmZ65VpDl5NyemWnlp07vga3QT/QpD5eu0/hqtkGCAKLVLBX4kNqjb2cgQdmj6zAdi
 WcfsaKQqrYKdYe4trYr78cApPCCvyrh7apRCTOY92K1ygUghaiqJlshK9InbG1Lzv4Is
 5u1+Th1sWZif8GpRnHFDsYa0Me+/pLDHaWGP+AB4UAT8Sli9irCtyj67VHUNYKEsvLMK
 6guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842818; x=1743447618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QyOBr9YjbmzOLwKeFu7wpFEtVg6dviWnm+AXyNYm/3g=;
 b=sEDst388suyMfouND2qa8P2XIeBwxzu08yCmYh6YQF9CoNp+TqWyA7gArxMYwVnzgX
 wIkwqIRfufA7aqHAQnI3gSPXnPh1H6vXiPIHQTvt8YAd+lBlRAqyIJHV5G20RzR+FaaK
 5DOxGLjvSej4MoWwL0BP03tuW8dpvNouVy1IRl9OjqSsMciMqbCWRI4ud4kdDxDvpv++
 HDwpDl9od0GjJ/H9kMsh7EP2CF+/jum9bQxkPXDzPlUvIu0A8vfXbn+OKw7K+quZCMu8
 OozU/WHb93QJ8ECWjl+xGh20v91l0LS1Xvl5h0QfbCX5EK/UQt/9rJw9gvtnAxCeA9JJ
 iaEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEJ17eW/WE9kyLPZacUxVk1oATZLYbds3hvSkGLOrpmlLW4wdxcnLS9RWUaStHdsbsHzLFPcrLHocW@nongnu.org
X-Gm-Message-State: AOJu0YyI0yv4GxwRy4tLwpoIL1pNSP3Ux8+WBO7a6D9hcv4Ck0GdYrr7
 no+F2oZ7gLQOKJwWYI0RMPH7lBkMP636mZ1mKWGLYuZ3CQjSo8U+J9A6E+z02BY=
X-Gm-Gg: ASbGncsQOP/WaEdr4uTx1m7QAZsV5q90TOc12/4dByoztpQD59uT4BxRjHBEekU/UXc
 js3fv0+Z35iHfHFCWz44su8dd5Vv61mFUFkN5NPNQKduVAzzeeGDYnPQQlaT/2EtrYelvUv63Lp
 tcjBUk4qmg4GlXvTP/JdVVyHj47hOWoRZS72NMIXm/Tj2HZX4nBd+p8Z+ZTktFwwkGu4Ie0O3NX
 BzWV3wok1LDf++6aXMJFxYT++wOs091U+GA8csC7qaVnWW7x/Lx7mapxbeNT8TokUrauBoERT7d
 Kq1Lv7IqE2WkLGIbMRAujL/SDVk8Fz0S4IZmJiwsDaH8JJinBE9w/Ckbf+zV7TYY+s/Kfansbgd
 WxNEg6qJl
X-Google-Smtp-Source: AGHT+IFXY47Jgkb1SpWfL6drWicK3wFEXNEvDkV6WxAjU5B/KX9KKMVJPVn3E51oZ62AsNzVnEwiSQ==
X-Received: by 2002:a17:90b:1d48:b0:2ff:6e58:89f5 with SMTP id
 98e67ed59e1d1-3030ec2648cmr24036670a91.6.1742842818271; 
 Mon, 24 Mar 2025 12:00:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f7e9bbasm8499062a91.39.2025.03.24.12.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:00:17 -0700 (PDT)
Message-ID: <273b7663-e5d9-49f4-9746-e5f30ce7adb0@linaro.org>
Date: Mon, 24 Mar 2025 12:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 5/7] target/s390x: Declare
 s390_set_qemu_cpu_model/cpu_list in cpu_models.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250324184611.44031-1-philmd@linaro.org>
 <20250324184611.44031-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324184611.44031-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 3/24/25 11:46, Philippe Mathieu-Daudé wrote:
> Both s390_cpu_list() and s390_set_qemu_cpu_model() are
> defined in cpu_models.c, move their declarations in the
> related "cpu_models.h" header. Use full path to header
> in s390-virtio-ccw.c file.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/cpu.h         | 4 ----
>   target/s390x/cpu_models.h  | 3 +++
>   hw/s390x/s390-virtio-ccw.c | 2 +-
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 5b7992deda6..8dd1936e3e2 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -900,11 +900,7 @@ static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>   }
>   
>   
> -/* cpu_models.c */
> -void s390_cpu_list(void);

Are you really able to remove this here, without the next patch?


r~

