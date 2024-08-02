Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6255AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzz0-0003Z5-1o; Fri, 02 Aug 2024 17:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzyx-0003Wi-Mw
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:38:39 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzyw-0006aI-4r
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:38:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7d26c2297eso1083087566b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722634716; x=1723239516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DrMy0r6qtp0ap9X+3XwWcJzzskVnRzE9X486ESn9B64=;
 b=mXCfSPDoqNy72z1FvLn5X2NTr1xys+Da9fMRVkGa3qAhvztXuND/Z3Qd+6A1u4MSAM
 FyLTlO8VvkvmG6xqAW1wWo8hbZHJtyVWt5xElO+80a0s24QGjD/bOrTrMhWZQJkr1xNW
 xZuu7X6oXieKq4PhMisYXAWgwYV+kLR/XNy+taEV4bJ7avqxHflPZxyUYIpc6AP8iDEc
 awQcyI1cCozK7DrBaiNPs8eI+XHjRP05gB/ni6IoXU2D2aJxG3MZ3gdGTmHcN8IzC8al
 uhxuRj5WCJ77gCJ8562z5FEV2oNu8JROn365iJVI7pEhu2UTZKFe4E5/1l/urDkJcos/
 lldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722634716; x=1723239516;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DrMy0r6qtp0ap9X+3XwWcJzzskVnRzE9X486ESn9B64=;
 b=XMFEqyjXxgOd0RG4fD9SNlbfjDUcuHpoD275hKhhlHi5dM87/7FG+tYj/yLrwB240h
 yxJbtjUwaDUpAuZuPN8wO1CNQcHElVmSEixRQSJ/RfpcPkC7pkpc1ZeNeSa3/XQg6r+R
 Dp+KMatncgv0MVnxayk0eq3o+IAKPJw6F3y1cT71G3v9Szws/fDaDGgB/mUc/B+LPSYC
 GJecotiv0zRATvgjXVndcZKw+E4f6XVs+zgF32WGSVNIJySjd+aYzBQNAKfKaa0i2gdR
 4V1m6NhSu8M6jtPTJAWuaaA1DMrwr9/mfTKRtD4sWIFFghc4a7M1Z88u4TtlXFaBpwuo
 dzQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVSxNa2BKA5G28kXqIg5CcKxA2U0CFAjy9APN6HFZsXaFcfpgnAYZSMK726H56z1lnyhhBnoctJWsEoIotl8F7o2q6grg=
X-Gm-Message-State: AOJu0YwvYiX9wROqx6xWI4OTgJqjqlGksOy7SrQRSXCCYbWsDzeMte4p
 2zl6Ar2rEp9J6uNX6mKAW3ZIZxytW9UkkEL+J07UFohuBEWpBYL5AHHFOJAXq9k=
X-Google-Smtp-Source: AGHT+IGb5vUO59oRaIm9psCWcmZxzQ67NAg0sT5kJMWkNwKGpg7Rz58sktsg97dIBF7S5GKliqMKAA==
X-Received: by 2002:a17:906:c115:b0:a7a:97ca:3056 with SMTP id
 a640c23a62f3a-a7dc4e56bffmr346101466b.16.1722634716155; 
 Fri, 02 Aug 2024 14:38:36 -0700 (PDT)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bc4219sm139530366b.30.2024.08.02.14.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 14:38:35 -0700 (PDT)
Message-ID: <571a2dd5-16f0-4fcf-aa3f-aa758bef3c45@linaro.org>
Date: Fri, 2 Aug 2024 23:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util: Refactor json-writer's string sanitizer to be
 public
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, rjones@redhat.com,
 Markus Armbruster <armbru@redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-5-eblake@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240802194156.2131519-5-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

On 2/8/24 21:26, Eric Blake wrote:
> My next patch needs to convert text from an untrusted input into an
> output representation that is suitable for display on a terminal is
> useful to more than just the json-writer; the text should normally be
> UTF-8, but blindly allowing all Unicode code points (including ASCII
> ESC) through to a terminal risks remote-code-execution attacks on some
> terminals.  Extract the existing body of json-writer's quoted_strinto
> a new helper routine mod_utf8_sanitize, and generalize it to also work
> on data that is length-limited rather than NUL-terminated.  [I was
> actually surprised that glib does not have such a sanitizer already -
> Google turns up lots of examples of rolling your own string
> sanitizer.]
> 
> If desired in the future, we may want to tweak whether the output is
> guaranteed to be ASCII (using lots of \u escape sequences, including
> surrogate pairs for code points outside the BMP) or if we are okay
> passing printable Unicode through (we still need to escape control
> characters).  But for now, I went for minimal code churn, including
> the fact that the resulting function allows a non-UTF-8 2-byte synonym
> for U+0000.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   include/qemu/unicode.h |  3 ++
>   qobject/json-writer.c  | 47 +----------------------
>   util/unicode.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 88 insertions(+), 46 deletions(-)

Preferably moving the docstring help to the header,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


