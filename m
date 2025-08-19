Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DEDCA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 22:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUfq-0006wS-GG; Tue, 19 Aug 2025 18:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUfo-0006vG-6W
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:19:20 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUfl-0004sk-8h
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 18:19:19 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-32326de9cb4so4459980a91.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 15:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755641955; x=1756246755; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n5hxrXAjf61iNW1Ll31DQuEb03MvcLYfvlT+/iSK8KA=;
 b=P1mi+VzZoskqqC75cMoLluC+eHenRsN6Q0S5GISQRaZ3YRiPZIctOfI5d/TUkcWZfj
 KHODlvR+v86Z6RQtWASvZ05f1ROlO66pUsrDFYDy8HYRov2VJAB/5WEhOXdUfV7h4Qv0
 drb9lbbSAK2v6C1TVZuE/iusOEBq+K4DChuhznfT318G+noKSNwSjGqsissPbIR9I/vS
 8zNe1ZKYdYrujaV4Cpg+L6TnBBQuwSJDznYT9tSoDmA07RUt+3ylllSDayBVkQA2i5WB
 Za30tsYH08YVDSbP9LotFHQB0tAwOKAuFpbJFaDtf+Tf7+atFiZAGEt/mQDrMnASaPkG
 bVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755641955; x=1756246755;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n5hxrXAjf61iNW1Ll31DQuEb03MvcLYfvlT+/iSK8KA=;
 b=jUQWZc/8fFnXRUwacBKWtpn1XMN6Wl0b120Z5OMeHg2LfcZ9+ayd4G3C+iVSSszbvL
 faYASGywnsrAaLyR9baak6wAuihnLk0kiO95ZLjTXaQK/67VNOYjFd+hpGe8K90Mx7sB
 E2MO4tE0Jd0VtQVkqvjIp90GEGGBD902srhWc9oX1Yukwde+Gq/jUY96sBehtf0tYt1a
 EoyFWQfFv4KNBcph1iiA13ylWuLU0AYx4zCMS6fbhqpkEPWPV+8jrqarttzzgmHqJNNM
 qqOIoc8Yi1H7PKiFliDI5sKHKA7QDvDys9/gl1dNrkB6MecL6sVaolcq7vglpPcUZWVu
 os7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA1cDwzGZipV++hJqFU14w2w1v6cnHGx8eYORiB+yjYJFjNlqINclGFjQ0vxdH8b2dwVOBcaXe+MuS@nongnu.org
X-Gm-Message-State: AOJu0Ywe3mWhKW5/DHygV3Pvp85g561drJufJ5ybBRaFvUReJXMgwqWE
 X5aKZHrj1BnfvRUaqwL5oWFwTsjdBhpXNFZ/cqDN44bWuG0CrSI6JXUn+z2FPIOzNw8=
X-Gm-Gg: ASbGncvPCX9Zf8Qk8P57G5U4Bl7qTWrt27VYNC0crFmcnhpbJDyO8RDwoEKfizuq/KH
 Esq1JCogT+PcqEVLJSOiuDmOfkFzzIc8+H5nCHhSjgmFYS48iQDyVwWAvOFV2/oWoQOHlBW16Sk
 87Qpquml8MGsvH4u57+0P+Tp3aKKHwJ3TKj0KSBVJci6/xuI2/rbVQo5ZNQ4OOiG6bQV82BNTZp
 iMjT6apdCgbw5FcGfL/rHm7I9N6c8A3E6CuzhF3DldbHfO53BqjkjPh0Ne07eFc44YvuwgGbWMw
 lnMWOyuBGH0mjW35epvbpG7vcLKYB1U62TNo0LqP6JPw4RbKuAXMlOiI1CUZYeGQsohwqBNA04d
 MSPTIbBnjhkMWSkxNfTDkByLuVbdB9XAC+Q==
X-Google-Smtp-Source: AGHT+IEb8E1VqWUBJJgZFNZYPmcIhZjMlmLLtOvK9pLf8/m8D8vXmlH+qAFh+KFYh9lxoqwhbpkn9w==
X-Received: by 2002:a17:90b:51c1:b0:31e:beae:2934 with SMTP id
 98e67ed59e1d1-324e1423f88mr967743a91.18.1755641955176; 
 Tue, 19 Aug 2025 15:19:15 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-324e258cb88sm211008a91.28.2025.08.19.15.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 15:19:14 -0700 (PDT)
Message-ID: <fa2566d9-0102-4de0-aa33-18154c623d56@linaro.org>
Date: Wed, 20 Aug 2025 08:19:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/35] tcg: Fork TCI for wasm backend
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1755623521.git.ktokunaga.mail@gmail.com>
 <630c91852939acf3c7fdd95c37b363fa5d4e60fd.1755623521.git.ktokunaga.mail@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <630c91852939acf3c7fdd95c37b363fa5d4e60fd.1755623521.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/20/25 04:21, Kohei Tokunaga wrote:
> The Wasm backend is implemented based on the forked TCI backend with
> utilizing the TCI interpreter to execute TBs.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>

This is the wrong way to go about things.

Don't copy the tci backend and replace it piece by piece.
Start with a clean slate and add the pieces one at a time.


r~

