Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBBBC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 01:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcZ3G-0008AJ-Jt; Sun, 04 Jan 2026 20:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcZ3D-00089q-1u
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:06:27 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcZ3A-0003j6-EQ
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 20:06:26 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so13262636b3a.3
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 17:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767575182; x=1768179982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+4Qiz2g9bIsA6O03nJ4aKq9QGXmBiIt7OgrTE6UyBJY=;
 b=yTfHeSJ7dRIZyCrFSxwW2xgIR5GzwpHk8+A4SVj5uWSobEOF1UxeFVu2+LwSv2lCWa
 gWsmNx/8eiluiiKGhUtmjYbU6EcXX0QXOqubWW5I8w61tlEezas9f7tX1oQAQDRQ0i3K
 9DZZbuLQtLeiNfDdQT7Nq4BqE1RBXcLVw4uvLZmwixSDMt26fpR9oPEjt5M18xk2zxbR
 A4MDcypoUYz0Ry4tSDaGdyxm4jGWh5t5XMGn9beHym3bvvo6yAesI+4CopyytJHf1Pg0
 x9a9GU6EtqOORMN7lWOjmIfby4fwYI+3q7sRYvCSu1LSx2lhQGxYx2RY89jcg57UIjrr
 KGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767575182; x=1768179982;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+4Qiz2g9bIsA6O03nJ4aKq9QGXmBiIt7OgrTE6UyBJY=;
 b=u6RzUZC8y7UBkkiakI08ib/cmiagxSarld4auw+LLTpjdHOwc7oR7shMfhRTe0Vuqg
 cWYZdR7JV/Yg8ghsELkVXks/6dHCRiOK3ZqOeM1YucDpJZRYLH5QGGUaSFxATesj/ukV
 y8G5JcIWHJv52AWZRqXJy2fZlAKjTOdicm9BSCvanFIHa0PCcGofC33nfzXjL2SuJK0n
 annL0a7VfqrzlCpHmjT4dO1fa3be4wVbdRKaqHk5uiS6q3hnS/USaIe651eJ0emZ1wFI
 5OI0Gvr3a0C4rM1gpKbR1y60zmC0IJ40vcA2s9sKVA18nyROmIPFTOZ0HSFoQv2iih7u
 sbTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsQvDFCmGeOu+EBi+p+CAIdbHhpawxHilxZc4Q5/tYcSO/YxRmtbWvk5J/krJSYx8ng6IgR217fLYx@nongnu.org
X-Gm-Message-State: AOJu0YxxUxEUtX9S+NjsCMNiaGHZmQl6NMGzAkEmY7tT7rarvH1tW19D
 PlvqO5kDKjIhHjU9T3IeCuolgZ+mKQoVTJ6i9iEqYxcQkky8jwubbL2tKlXMCrB9nSc=
X-Gm-Gg: AY/fxX5Okqc/AnpN1EuAz/pq/8nAOJ6GbHWC0DgcDWzMue53uJY7UPdHo9BAvFcCo55
 FyTAYnNbdKUWUaHsXF0CYmu7de5lczJW0j4W7E8Y1sa6a7sPiClFo8Vg5/KHN6JhFJBF/C27zwA
 Je7dpn8jVD+VnoPaiQlmgHqr0dxGMVpEThQM5klZpd4RtgCTVXCmQLMhkD2JriiESvOy31B0qeg
 2WLGy+9oCfvTpvlLckntHOwDZRylgMh5AA6DuIn3kdYShvpG77y2EWk3Z25Z1iu9GW+wYs0tWIY
 BOR/7hZal88k7ohb5nGHT3eyi9wzQOTLC8f4laAOlabFz1UrTFazlH1YZSoT0CdqNYiEZvWVNXV
 3S3EVBqm4M9/N2NIaSBjT9SQukND092nCZFkGuLYI3VhRb1pS2+7BUCzXmlQQsMVSw+ef6kkpFb
 nn6L8P+kEh/MW6AId12pc5g6p2xpf6RQ==
X-Google-Smtp-Source: AGHT+IHUVXFQSC57SOYhVcjXUszymUDfMorBYe4W7mZu1seLOQH5ZEH5p9o5gLWj7YAgjOGklWAI3A==
X-Received: by 2002:a05:6a00:6009:b0:7e8:4398:b367 with SMTP id
 d2e1a72fcca58-7ff66672842mr25310158b3a.58.1767575182265; 
 Sun, 04 Jan 2026 17:06:22 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7dfab841sm46297400b3a.35.2026.01.04.17.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 17:06:21 -0800 (PST)
Message-ID: <67536efe-24d6-401d-921d-c2bf4e43baf6@linaro.org>
Date: Mon, 5 Jan 2026 12:06:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] target/s390x: Use explicit big-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20251224162036.90404-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 12/25/25 03:20, Philippe Mathieu-Daudé wrote:
> S390x is big-endian. Use the explicit 'big'
> endianness instead of the 'native' one.
> Forbid further uses of legacy APIs.
> 
> tag:https://gitlab.com/philmd/qemu/-/tags/endian_s390x-v1
> CI:https://gitlab.com/philmd/qemu/-/pipelines/2231223066
> 
> Philippe Mathieu-Daudé (8):
>    hw/s390x: Use explicit big-endian LD/ST API
>    target/s390x: Use explicit big-endian LD/ST API
>    target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
>    target/s390x: Replace MO_TE -> MO_BE
>    target/s390x: Inline cpu_ld{uw,l}_code() calls in EX opcode helper
>    target/s390x: Use big-endian variant of cpu_ld/st_data*()
>    target/s390x: Inline translator_lduw() and translator_ldl()
>    configs/targets: Forbid S390x to use legacy native endianness APIs

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

