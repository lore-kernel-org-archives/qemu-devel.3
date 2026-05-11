Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D20CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMOBg-0001Kf-0N; Mon, 11 May 2026 06:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMOBJ-0001Hj-2g
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:48:16 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMOBH-0002i0-43
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:48:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso34814775e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778496489; x=1779101289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wTP0Q0Rh9OQM75jdEF5bm3oW1JM9l6xDjkIOOVfOtUk=;
 b=hRsOJsUJCc2WuS/Qh3aqYGe+69lUBjEMKOqVUVSQ3WH/T0TyC4+9icn2QBl19w0FNh
 32p7nUV2pdaCKFOmT/5d/JlQa8qxDau7I/pAe+P+0ro4BsNKkhUSRfYbJ70ntSS8+16A
 OPupGL3Q91HcYx2heOfsm9RbuX14NMIs2a9a5HsAt0NVSNXzM6paj8QpXPXlm8U9uWiD
 BkEoHki3xkYcdKwfS2QfH1vKb6Jf3cUtkWWeaZ370MpjjQWMGUVI3c6li16yiM53EeV/
 RiEK2IYB9+G3ykdny2BVGfPqQWDCGAG2hFGj2/zILNbgSe3BRy8uyEaUN/N6SjqliUxb
 PYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778496489; x=1779101289;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wTP0Q0Rh9OQM75jdEF5bm3oW1JM9l6xDjkIOOVfOtUk=;
 b=jg/57Hr2ffsQnsdIG5cYYTDv8yXT56Kv6E56VslCbMDkhqnQSqMoSOC+ZHnTq+Vsit
 u0AyTWcuzPrHGgyqCXWLMuOvpmpg3XnPtPqOLi+BZYiit1dIcbwjEnMoLT713yMSFkhJ
 AUgAi8Bh3Pu/vYVfFssK9OdgMkFj57TuImLQBo+8gdjb1aToDTTNfSyYPS094yDqcQPK
 MHlFzc28Z94zAQVdg7UdWNggy2Wq/lQFkYkp4KZnBi9Tj4dnhHTSP7GBOPN4u+2UUn9O
 ydn4vZXCNocoibue7K1qoEnsEslB+G4rky9YFmMDg79hZs0oFkruEuZ6xGD1bpYAVjse
 x6EQ==
X-Gm-Message-State: AOJu0YyqJJiPjWexB/9dSxpZfafdFZppekB5X4zT1yC+2KcN++hQOzD5
 19NNS7Rdfg2zMCcWL9BnROJZx/3g6W1LIBYJCxO4At9MjnoqDvgBqyfqWec8nIVzXbA=
X-Gm-Gg: Acq92OG6YDAfhV6cIjM6Q1T7uT3bFeUp3aNoBd2ov8x3zXgsOCPdA4OwQX8cNJcaHpu
 GKtapZy6zhVGyRQVnPdbQ5er7dn7LnGKxAn0OXUKbxLWlHirUvMvxN0SpfUheewiwktOTHLv0us
 WAJHx9kV40YS23B2uPb0EW9ppFow+TkUoYxFNCbnovIC/ubtae9G0ftYR85YSc9X0BzUmaeEo1I
 siXTCmxOddS01kpthLlCkHYYarC2q3ykM5NX8tapvIRtM9QjrwzcUZKlAB3i0g8WMDUl37r3AnZ
 M2Fb154R6yBcAYPLc/MTsYDhLiMtK+A176P96Lkq/8TpoFGdkLZ5zNEca1+sA3yUL8IUDoHhOek
 QUbeW6FVdeKbkUssHYkKJd35BfNnxZpHl65XkiUCb6YzMH6vDgZ9TRCYLIYnjs+gnFfkRYlpC40
 Vu67RYIqsxcs1WMB21bSto4buA+AdZS2gQRBW36hbHbOkN/E4TpNu2vQ9NutzjAv8P7A==
X-Received: by 2002:a05:600c:811b:b0:48e:89f9:9408 with SMTP id
 5b1f17b1804b1-48e89f99431mr1636545e9.20.1778496488968; 
 Mon, 11 May 2026 03:48:08 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e0bf2sm310962755e9.4.2026.05.11.03.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:48:08 -0700 (PDT)
Message-ID: <8dd49a80-f0db-44f3-a9cb-19aa9f4b6791@linaro.org>
Date: Mon, 11 May 2026 12:48:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qom: improve use-after-free debugging
Content-Language: en-US
To: Roman Kiryanov <rkir@google.com>, pbonzini@redhat.com,
 alex.bennee@linaro.org, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org
References: <20260427154441.1918536-1-rkir@google.com>
 <20260428164545.2782523-1-rkir@google.com>
 <20260428164545.2782523-2-rkir@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428164545.2782523-2-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 28/4/26 18:45, Roman Kiryanov wrote:
> This patch invalidates dead objects so their usage will
> lead to more predictable results (crashes or asserts).
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> Changes in v2:
> - Updated clearing of obj->properties using g_clear_pointer.
> - Moved clearing of obj->class into object_deinit.
> - obj->class is checked to be NULL before obj->free(obj).
> 
>   qom/object.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

