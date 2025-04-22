Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D044CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77MW-0004C4-5o; Tue, 22 Apr 2025 02:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77MR-00046z-Am
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:44:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77MO-0007yq-Gy
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:44:02 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso3462317f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304237; x=1745909037; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+9UB07EjzDEhXxVE2VMd7KxrceRog099DGJ5fspr6Kg=;
 b=xvnhPhHa7xhbQ+1q+EsyYhcfLOhdMDV3YWXFcwcaILG6P7w2Yga3WYUqu1L/Zhuofd
 9X0hBZvmLilwHhDKjG+FZa3tNWGJYK0NtMVuflPu1ENO0uJjYRYXJxXzN8Z2quvVOxV6
 iXyvqb3mL8yWQXA6mU5Z0N8MoidGSO8lXkR55G36tci9xqHM1EoFBIKc5YMfZC2JqUQS
 Yh2FFEfoMQe+s5MeMBJ2QjBsmNTGC1YzJ+uSDYwj3cf7oSnxNdJTeeIIDABgUa4iPY2m
 6q4P4gssJR/fceYAD+Y3iSDnHF9lQUStp973asMIkRfSU89rVNnC2m7sx7YF/tOMofLR
 rGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304237; x=1745909037;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+9UB07EjzDEhXxVE2VMd7KxrceRog099DGJ5fspr6Kg=;
 b=Xf3GAtaPtfMzsOkC+QUjVbNJo8qMN8tKyD1OVVRpvssdJL751IqeWEkOCMvhbkDKd2
 xGQyOfkETpt2SXpQhgxQfh8VmDrJMyX9ttbcdglOQ6gW6EnAvuBGujfqm/h15bGawFmK
 Yk5IsL2l64j/m9gU0H2Jsht1lqoZSs5iWgHh4GjJDtldR500aau9o8RsL7ULd7Yw3nuA
 nLqTIBbkhvqiPkgl/87Qqq6Sn/ABfAp8aIhKInGK110mV1B2WGRJEycf4BaLOfnXAtgS
 BW4R8FH5nJUl070edCUbGwGpE+5R1j5/AgX+u380J4yof6M1MyLQZwJjmpdMGx6JB3UB
 3UNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWES5joFk0XT9D5PNA3fNROEDYpRPqq6o+u3I05rT5suESkBw08zj1DjW9vgJdig76kNl+RDkl6sRvx@nongnu.org
X-Gm-Message-State: AOJu0Yw0DzyXKSeHpvbbYep9oiY0vaVyvZJptSSgGaTmTHfTZpt2Q/wI
 GO6YwnYWFqTdz0udAbeEN2P038571Tm8/bjYC2k7B02T8qMtKrnsIn49QKYVgXY=
X-Gm-Gg: ASbGncuwiTtraBWloln5AbvpEPvFHD4OphnXGvpNbe96SONfDEfCkmZaiv5DST69+7G
 QHAnmFtoz2G+y/Q7XnKqHHvEsWoPCYP1Q+s157JjGyTbUunJUYFPptaDZzLKMu4NZjIA1S0RO7P
 2TtUuZl+jcBXOxOFx9cC0fApqMoJm11Jn8dod9eRHpO+SzDRS8Y3heXXAL3x7M16EbsYkoDKHwo
 yObzMrz1n1Cx7v0L6rNCoUf2s5RbfzZQQ81j8PPKBohphfz+XhIslZlh/NRJ31qF4EFE3/DK+HQ
 lLY91ALDyTIG35u2pkEdvyt4Sp02B+avFGGCQPY0ctW5D0HgValuYvGl+g5WfdIlZDN0GqBKwru
 nhD6gU/sCtRXZXD0osZg=
X-Google-Smtp-Source: AGHT+IGicNEOGGWG9Ql2/GtKu2hXalYv3ESAo9JoC/qmXK6F5zqhCTj6Dxi2AfDm2j2sZt9xm6esSQ==
X-Received: by 2002:a5d:47cb:0:b0:39e:f89b:85dc with SMTP id
 ffacd0b85a97d-39efba52f5cmr10905880f8f.17.1745304237341; 
 Mon, 21 Apr 2025 23:43:57 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43be53sm13882739f8f.41.2025.04.21.23.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:43:56 -0700 (PDT)
Message-ID: <214e3bef-09cd-426b-aa7a-65ee540f7cab@linaro.org>
Date: Tue, 22 Apr 2025 08:43:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/20] block: Fix type confict of the copy_file_range
 stub
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <ce34a721a5283fce854f417baf7b1c8f5c48c028.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ce34a721a5283fce854f417baf7b1c8f5c48c028.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> Emscripten doesn't provide copy_file_range implementation but it declares
> this function in its headers. Meson correctly detects the missing
> implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined in
> file-posix.c causes a type conflict with the declaration from Emscripten
> during compilation.
> 
> To fix this error, this commit updates the stub implementation in
> file-posix.c to exactly match the declaration in Emscripten's headers. The
> manpage also aligns with this signature.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   block/file-posix.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


