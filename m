Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CF9C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn0v-00010e-2d; Mon, 24 Mar 2025 14:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twn0t-0000zL-Jd
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twn0r-0001Ph-Mh
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:07 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22580c9ee0aso94124485ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842744; x=1743447544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6A9tZGFvYV3NXyn06TpAAAij2vmgaDHJ1vSkBE9Ezjc=;
 b=DNKeFxi6RoheTIshfZQdodhKt0MT++Wqq6qpGQIwN9fFWEVser0Kwhit4cyHKt49m3
 qpOCooS6LXFqC8sf3bux/fBkZTUoSrw0yi2A3KBCPrd+YDocZckABnHiXk8BJJb86GVb
 y+V5mSgrcgHzkJuKRFbOKIjpBxemdtKqGKstyN3Yhw1xy/SLRDsuoBh1Fi/+dFGWPEp3
 p3/d7pqCV7Bj5HXdbDu74OgVMlgBVzuEEoff07WOT9i+lJhALzCjTJLE/alXoQqj7NnA
 ukb4TZKOrFPH99fKnWjx5RT6Ch66q98+Rkapsx2cyE6HCoTTOYHHHuvg2H41tezQUcZ/
 fkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842744; x=1743447544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6A9tZGFvYV3NXyn06TpAAAij2vmgaDHJ1vSkBE9Ezjc=;
 b=YA0GcQ5GdXV2/HvkWf0//wz2LKPEsgX2x1OWcOF9IlviTbOFX8Vt9txVPVeWZcofRA
 ITiaZRgXKTjlCHdYLiK5vAJpaTKXAJe5VLINCbI3EdW5Fck+DBP46GVmQ6VYx8lTARb3
 gBiaftO8b9LqHHOYKLhue1EBpFnVRm63Dn7U4aakuUuqZV4V07ptKJycu1wT+dWtCntK
 FPBnkmBfgOIIY4TCufcfGLONN0aMmCxsPFwXhfCTtosKqg7j/f3pf5vtztCLmFnUTgoX
 wWnp5wIBDtYn/+vM7jSlC7zi2ZBcsvM9EuGmQdEDyNLBjvBvJcQ46s823LopYOBefbcH
 hs4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9O4tFmHhe+fmCakspw1s5t5VnDkxegvkb2ei/eSHtJJX0YQFfALNSrXjfB0WZ/lw60U6SRQQG62Yn@nongnu.org
X-Gm-Message-State: AOJu0YyEoXY8OVIRAEd/15eLrueG4I8EauCGDIpeS0rcrIkvnYwrkVBA
 XxZhcMEn7xEhzDBTdLyYXSCNCTCjsvREzJ/yCtZMcLb4ZIT5JvtHZL2MEArATLs=
X-Gm-Gg: ASbGncuOgWSPe5HcnLhxEFKshnVeRhD8drXueIjlMwGuX0wPSPYLn8413D+NiW/VtHC
 MMq/mdrgbISzPlGxb3Q4gkdmbj1MwXEKaNF6MJCmlljMeGwByfauMZsWtZaA1a+RtpDxhyNE/GD
 daz1nM7FMcAu+PGPW/TnB1uVNRms0TcZG2L+0dm0wjFZlx1+yZK2yxQ8jed946ZVq9fNFgodXtz
 9N7HZphISGHYnIW1Rwmej+rX711drq76hh8PHEH/WfJt1YRzYbk5QlEpnK8HQ/5eP/b1SKOQXOC
 Gi3leHQ/Nv23BbzNlDENPunKu4xKO1SgH4DrB/zxcyX5IXJSG0M6kxtwTiTAVxzUP9k5BGq3PqH
 J8pNFYNN7Pp0ApOvw0Rk=
X-Google-Smtp-Source: AGHT+IFYhEy4gWiu2yVbFi9Yds9Oqa/kAwCtHywEMTG1DOk+VeTFa7Wwrkmq+UylfkIYl/HjZMbVMA==
X-Received: by 2002:a17:902:ce82:b0:227:ac2a:1dd6 with SMTP id
 d9443c01a7336-227ac2a24efmr122930035ad.24.1742842743967; 
 Mon, 24 Mar 2025 11:59:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4acddsm74538265ad.56.2025.03.24.11.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 11:59:03 -0700 (PDT)
Message-ID: <b9471399-d6ee-4c51-9cf3-e4f7692c67b7@linaro.org>
Date: Mon, 24 Mar 2025 11:59:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
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
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> Philippe Mathieu-Daudé (7):
>    cpus: IntroduceCPUClass::list_cpus() callback
>    target/i386: RegisterCPUClass:list_cpus
>    target/ppc: RegisterCPUClass:list_cpus
>    target/sparc: RegisterCPUClass:list_cpus
>    target/s390x: Declare s390_set_qemu_cpu_model/cpu_list in cpu_models.h
>    target/s390x: RegisterCPUClass:list_cpus
>    cpus: Remove #ifdef check on cpu_list definition

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

