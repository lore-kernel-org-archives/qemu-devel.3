Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D738DC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdQB-0002TY-CC; Mon, 10 Mar 2025 09:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdQ7-0002NA-MI
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:43:51 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trdQ4-0000v9-C7
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:43:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so3085934f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741614226; x=1742219026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MNR7wcPrwyvdBBuSvZmLG0ZR7REyKuHiEVhgbsBRi+w=;
 b=R0YLEd8kzYoh9zj0bFFqz8Z6+cGZxTRI1LI5JUN/GUtxiu5/zly3/+Sk3YUPxnV7eE
 9tPQJ67bD+rOGSL331SlX5KZcNv4yE4kgOxrC1gocmQs+gk8eIFQOfX7PbamvVytZXqv
 YSdgdCdOoK1WrhEYD6qIIUzhmFRcBGt3kgUlVLTWpb3R42AQgF1+i/qc8hYRcV2a/iYV
 r9ZaPYC7ROYuujJpQqoI+ayhm07QMowCD5a0/3+v1CTHl/9dTF7pKTUflB5Mef44WxWv
 koQ3GoefKInCoQTjXhXmjOfNCQEvK6JJS48+cWeJ4/IQpxRrYzbKCQtjAuIGY3PT3mwG
 mZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614226; x=1742219026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MNR7wcPrwyvdBBuSvZmLG0ZR7REyKuHiEVhgbsBRi+w=;
 b=OT20bGMUwo6zWDZwnRJCoRi8L/ks4KWU7q7DOGAy6HXNPvn6wz0/MPBOULyUqWYUYg
 SUV99efHw4Bhs9WQSrPByDascnkErapZSDtEsiL8yuMK9xYeitIHluHQiB0fMimPHU3C
 3PC+9uibIe65IRe1cSqlZIn08HzsQ9XdNpwBGgpKmqGViOtR8LMcNWc0zat2yAjj/Bi9
 G299MC04EbYNgnWajf2G0wnJ6VTv4MMyXPR6VH82hvi3113TdUi1HOEcN8+XoiqDyA6U
 fzMrmu/mZuVJfJjXHd0JOiBloZtpMqh4LodzCpKSi4LLf7nvkccpUfcLGyGHE1UBlbW6
 akgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQR922McYR2smvtQcxVCUnsixtKcYocTFhRk4RVzK1zO+xRw2eE4n9v4aXwaswBV27kyMPZ3ZHrjMd@nongnu.org
X-Gm-Message-State: AOJu0Yy82zuOk6dA9fa8WcnBvEt7W9xsjjJnuRGLfdGZTlmbY68tum0Y
 70ypTY56NF2+GqII5UTeHxlb814zHhHVgaUWQmP6STTjN7QaahY0JgPcUuMmJZQ=
X-Gm-Gg: ASbGncsoMs2bDMvIW5VJWYFPAKt3NLNyKsWLHn43BEBA1QDnmVBe9mB9/H3LIkE8Tdk
 sfBLj/RGWsHxt5ei5m3hwbRh62DtkKjSgvunxLLOiH1PnRAtJbDdsf7LN3gECJuqzhZqlMvCsPS
 buAevip0mAsIz625mcioC6L7kdKAs/O0j6WGRdh9Ifg3fUHUqdO0ZvpKjixp4ZtB6/Oq4WOeovu
 t/NLJdhOvOEV+wXmSuZjZlzDbPMPT3KckBHXq9REGEywofHRBY6zfwoATSLVhh180dLsvK10IZJ
 iNqe3C4fC8DGRfBVWJngyPBU3j+kUSm7BS3l4hI6bRucYlxnumhRRG8Q/bt4RueRrj49AymWU2j
 dofm2d0rLqnG7dkUQIC6NtYA=
X-Google-Smtp-Source: AGHT+IETxtWh9+nGuL2rdW3CBll9hDxY+TIi4rYLu6DazLOckmHQ14u6JozsOGGS/8bBsZmzIesPCA==
X-Received: by 2002:adf:a3cd:0:b0:391:46a6:f0db with SMTP id
 ffacd0b85a97d-39146a6f2ddmr2433098f8f.37.1741614226389; 
 Mon, 10 Mar 2025 06:43:46 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f10sm15089474f8f.65.2025.03.10.06.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:43:45 -0700 (PDT)
Message-ID: <7fc9e684-d677-4ae6-addb-9983f74166b3@linaro.org>
Date: Mon, 10 Mar 2025 14:43:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime
 using vfio_igd_builtin()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-13-philmd@linaro.org>
 <415339c1-8f83-4059-949e-63ef0c28b4b9@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <415339c1-8f83-4059-949e-63ef0c28b4b9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 10/3/25 08:37, Cédric Le Goater wrote:
> On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
>> Convert the compile time check on the CONFIG_VFIO_IGD definition
>> by a runtime one by calling vfio_igd_builtin(), which check
>> whether VFIO_IGD is built in a qemu-system binary.
>>
>> Add stubs to avoid when VFIO_IGD is not built in:
> 
> I thought we were trying to avoid stubs in QEMU build. Did that change ?

Hmm so you want remove the VFIO_IGD Kconfig symbol and have it always
builtin with VFIO. It might make sense for quirks, since vfio_realize()
already checks for the VFIO_FEATURE_ENABLE_IGD_OPREGION feature.

I'll see if there aren't other implications I missed.

Thanks,

Phil.

