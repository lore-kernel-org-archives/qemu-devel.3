Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C58CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 16:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxqmy-0001aM-4H; Mon, 07 Oct 2024 12:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sxqmv-0001a3-Ks
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:40:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sxqmt-00017r-F8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 12:40:48 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e0a950e2f2so3845896a91.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728319244; x=1728924044; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Go9kT9K6V0+anP/fIKC1C4x8XpHlZ5fz1/9qPzGjb4E=;
 b=fn+UxvTfUk8DVTGhNRkO2itJlpqpa+e44D0K/lv+wfJqNf6DKyM1kLu+G++9KU0OLi
 3jnXddpTUquIVHaNQpEueJENViyssdZMQvCdhdZpWZPyY+4qQ13jtkLLApVVArsBa+6k
 97gFzsiOf8F9dgjatkDTF2A5UFHeeaLvQb9+8U6kU5rJT+UU1X+46soFaHGy68llwfcn
 ZfOuJVoOV9p1XNzMSjiEZZVgJMCm2DupwRuEuD6V8+w3Hkk3v48DLptMjBWKVd81qZBa
 KKU4H15HIkefksT2reH7mTxFe/OxcuYx27vpALjNyeu/tCB8yMWee7majMwsq/cj84dr
 wJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728319244; x=1728924044;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Go9kT9K6V0+anP/fIKC1C4x8XpHlZ5fz1/9qPzGjb4E=;
 b=mvRgCgpEY3ssToAjNmuv0NsVcQy7Cu7TPVbYIpD8nzOCzjK36/1OglJG5EOiZ1NI20
 ymqyTfMkfZKnZZ5lE4BY9AxBStBJF79eKNNoPpwSMMjR5+DN+z+4o8tyiXO72OF1umzu
 U0BBoLRMsUZx1MRZGidFkqKYNPIA77ldf/pVE0rGrytsAXYbNUxRuBB7XUH1JWtY6G3S
 27jGnzMYaLPHlB7JimiyJgx/1T+lzMAIMlqsv7mVcF/jGCrlp72FSoeK/6GMj9zvceYh
 r9pHJmHlqn0eDC0FUB8GOxub0MPmRJhv6mYUmgQ4QPBqthx29xO1HG+fHJiulloh8eM3
 8hkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMvRRtGPzsF5lcWRsaPtEBGbhxuO7Ro8jhI+aN/dOjSICzUbud5Pwm2iby8bQ3RewZf/zJgb3gJNJY@nongnu.org
X-Gm-Message-State: AOJu0YxGApyXyAb7R16v3MNNz9ZRrAUmWAG+FRAsPvRoFsw3S7mD81Pd
 aH6Y2ZQqcCC6B/pDoQMMEtBKH0UUbgx/sPFvcp/zj5x5n441aCDGkrTRoe4VE2M=
X-Google-Smtp-Source: AGHT+IFTNIzuOLTVjc5IJo9xkHbW/ZN7GVHCjz2YaPm1hznlFqcWxr7QqzUMDvrGyquvN5/BmKY3cQ==
X-Received: by 2002:a17:90a:7085:b0:2e0:a931:cb11 with SMTP id
 98e67ed59e1d1-2e1e6213282mr14455687a91.4.1728319244658; 
 Mon, 07 Oct 2024 09:40:44 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e85d959dsm7352255a91.26.2024.10.07.09.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 09:40:44 -0700 (PDT)
Message-ID: <1d30632d-e045-4335-84e6-091a0c387cdf@linaro.org>
Date: Mon, 7 Oct 2024 09:40:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] meson: ensure we enable CMPXCHG128 on x86_64
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, alex.bennee@linaro.org
References: <20241007084342.1264048-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241007084342.1264048-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 10/7/24 01:43, Paolo Bonzini wrote:
> 
> Alex discovered that CMPXCHG128 was not enabled when building for
> x86_64, resulting in slow execution for wide atomic instructions,
> creating a huge contention when combined with a high number of cpus
> (found while booting android aarch64 guest on x86_64 host).
> 
> The problem is that even though we enable -mcx16 option for x86_64, this
> is not used when testing for CMPXCHG128. Thus, we silently turn it off.
> 
> x86_64 is the only architecture adding machine flags for now, so the
> problem is limited to this host architecture.  However, the problem
> is generic, so define a new variable for all the -m options, so that
> they can be used for other such tests in the future.
> 
> Based-on: <20241004223715.1275428-1-pierrick.bouvier@linaro.org>
> Supersedes: <20241004220123.978938-1-pierrick.bouvier@linaro.org>
> 
> Paolo Bonzini (2):
>    meson: define qemu_isa_flags
>    meson: ensure -mcx16 is passed when detecting ATOMIC128
> 
>   meson.build | 33 ++++++++++++++++++++-------------
>   1 file changed, 20 insertions(+), 13 deletions(-)
> 

Hi Paolo,

Thanks for fixing this.

Series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

I was wondering why we have a specific flags path for x64.
People who are interested in getting machine specific binaries can 
always play with CFLAGS, so what was the original intent here?

Thanks,
Pierrick

