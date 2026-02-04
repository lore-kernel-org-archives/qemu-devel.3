Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEADE7FDCF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 06:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVxV-0002BZ-SF; Wed, 04 Feb 2026 01:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVxN-0002BD-Co
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:01:44 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVxK-0003up-1g
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:01:39 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3540266d356so4094586a91.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 22:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770184896; x=1770789696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kbHVPFqpEIzOP2buskKbob/bk5LmZd0LVrMwps8yoLw=;
 b=jNzFErPzT4yZlisEGvtXdwwJP3KOcmBhsvdJG+kGMl5dxcIWOH3x6FHnTwqwnADJCf
 DSuagZHqS5K8lwflAgHztj3doflWhKbMrEcBstW+O+HaLZOErRrHoFmhQQRoVPLy7JzO
 tvjf3p9YvluhqY3JjZ6XFeafRPRf7DNmvLj20GECotMg2yV/gKhBpxj/O4cQ7hubJuXW
 b2aUfw727xeeNTPA3Ovs5Im42OUwxxtN+nBTZBsFK0JN/3vydwYyscRcK8cL8rUJQQjP
 mnzNJDXJVmj/m5hcS0T3YEuoAEv80VONdFn3gpk61czDCLynCEZmsKfK1/ayBOFUBbXj
 CB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770184896; x=1770789696;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kbHVPFqpEIzOP2buskKbob/bk5LmZd0LVrMwps8yoLw=;
 b=QdzIkQC0wjwv7WTEz2+f+YuCfg1DAbbF7lyAsVKk+Svg5qRkwg4kw1TqbtMZgkJfPO
 wJeC/GwCGmsOgk1UAQc8/FljTBkpdF9ZYNAhHUfXQYtVUEc+xXmIA+5f2DqUgf2E/x6b
 CS3q/60L4jzctSEcVLZ33mQes2hhPpSZUE8Q8MNj1spnhKC9mJ6kxvrKGH4XV1JMGlo5
 LftcYvWna57F0NlPcq+79JTwjnxykCrhU+WUiQwNQtbQbWscH/tLKd6nbjvMj9D0YuUb
 YUY0G7eygAT0/LmiYcAeG/51BIY1MbgJdGqGwgjD5qpcKaAiSm3KuimSEh5i5JuomfAh
 jZ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWusDcHa2t+ipEO+/p56UVNqB3dg92JxmYynC5THnVa8WiYHY54CoOb5WZTtwaKLXNEGT2JUGhs9KNG@nongnu.org
X-Gm-Message-State: AOJu0Yx3FeaTAK74RvoQTVQOSFQd6HyJfbfXV+9upxIZ1dFOmE/1D15X
 umITxzRTFEEjTmW40PGpHpizICg7l8/EqeNlY4ei+ommp99ZsDpAxD8GCQUKHKwS9fA=
X-Gm-Gg: AZuq6aKB0bmhHTAPyFTd4Y033afKjGj9JpMVRtaxO18HPgscUzJOAut6qY6tel9VQFa
 qeWtSb2yJhLNorSuJ9R1nZrbzKR+ooYmMnCyzLhMcm+usIgkVRqfOyXTfxnhbspTG7JglGkfNy6
 wVKFAseWvBZ68uFnq4bU57LX66KvuR0EpzTMGsPxfZBXEusrFmOjAOhINH2f1Orzb1Y4bKa0gOV
 Yp0aqSoCeb4jW+cQHfdi3oAjlBLeAAdHUHh55zMuKLBlkHS+jX7zdMSSwnt7twyzDrv16d9eBcC
 HhEQs0xQTH/nOxp5uhWvy2Lp3tcAzYLRNFwscisxuG4yfMkbSBQmnVmO/VEpc7kLBRkzSA6NMmz
 71uiI8dPlNlLXDqYr72IWgpCBtRlR/DDv3i5JSbMhfs4qI2xzg5WzkdbP4q4F3JaCrdE7EDl3IK
 Fbd7XJ7VCzH3+fblSIL1w0OMaZIaAjh8YeGPif5n8JTqbmAYwDXj0Vw/SxfN4/cFQTonubp26hI
 d+nzJqfGi1ShrHZBimhPZYlRSQKfCyEVd4a05HmoHKwzD8=
X-Received: by 2002:a17:90b:5870:b0:353:5595:3247 with SMTP id
 98e67ed59e1d1-354870dd823mr1675629a91.12.1770184896227; 
 Tue, 03 Feb 2026 22:01:36 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3548910d6ebsm498162a91.5.2026.02.03.22.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 22:01:35 -0800 (PST)
Message-ID: <cce058b7-040b-46d6-b432-db2e2a04e2ef@linaro.org>
Date: Wed, 4 Feb 2026 16:01:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] target/s390x: Implement DIVIDE TO INTEGER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260129190902.196262-1-iii@linux.ibm.com>
 <20260129190902.196262-5-iii@linux.ibm.com>
 <3ffcd87fad77fa09811ae8ea8dbac25f@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <3ffcd87fad77fa09811ae8ea8dbac25f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/30/26 09:28, Ilya Leoshkevich wrote:
> I think I can also use parts_round_to_int_normal(), because all the other cases are taken 
> care of above.

Yep.  I think I even mentioned that vs a previous version.

r~

