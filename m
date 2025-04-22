Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E11FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77Jd-0000RD-Fm; Tue, 22 Apr 2025 02:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77JX-0000PY-58
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77JU-0007mC-Te
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:41:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so34937095e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304058; x=1745908858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKJFeLlUbpZe7YuWGal+rk0qK1HvBE9EVeqOrPjomVI=;
 b=zaOXcXfJBAZ9s2tMQVfc/YCpTeuSyXPFfotEY5BFKVUIUm3Q7j4NkzqTylvIROko9r
 TaG29wiDfFf4KDsiWvoSmVwc8HY32ccN87zrGMwRGmWxMRCVp/ut3d61ojeqSFfU+Ngz
 XlKcHzP6cr1uruD2W2WnwIdBXTPgk2fPoTQG+W5VQIn7bIa4Ahcy2GP1arCOXKxUBC7p
 hkEYOpXDZ7hHkguOtPBTZfaH4+mfrlxNCYqcdq42tIAP8hAGKB3oRnprhismVWcXLLUW
 0nV8qi9xtrcOwtUDVm/v9jushzT3ndE4OGJ20WBHraTnhfbqlA48cpX22LKl5KDUHB4N
 B+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304058; x=1745908858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nKJFeLlUbpZe7YuWGal+rk0qK1HvBE9EVeqOrPjomVI=;
 b=gjMq5vL15wQ7C9n5qjXul7xcrZIq+Y8BYh5PDmOpwkXiE+aP3DKBmjSTJzQa0OsQv9
 KY0sOL5qobSZ8F2u9zj5Z0iusuIdel0A8RVRIjNJLntqtz31d/mKvAAnz5nwDcjUtZZ3
 1/Q0+9Vavyk/lzPiPNXJUyGIoNLfHuIF8Y71wIOLZqkWjNUr+ly0uhE0SKkUhgMcRR5E
 5Whrde7iQ+63PKGD5mZcXp5WUxMomfp0RVMYmbYPOsXXILAwnAuszUYKdHhJ8WICD2P5
 xcegZcMCN9y1PJGHOafa0pS0QR7HJWDZXIB28OWyLY4p5wkXJTPCJ+ydDHBuxrmESmFF
 1e1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1mCt1aTiuB7b+5zVHD/NTstAb38jXVOtzA8HS6sAT0v/9122Org4Lorw2pd3hoPOjuPGplTCHA9LC@nongnu.org
X-Gm-Message-State: AOJu0YwAp36D2oz3LHAYQvq19nsNceXDcg09iO7qNT7J+lQZJebqWMzR
 /R4L6BI364ecWGSdiIqr6PiwDdP5qEy7xqx8hgiZ95fVrSdD8evOkdhTqO+VoKA=
X-Gm-Gg: ASbGncsnEHFPPy8TpCtayBNiYWQi82hBvVL+oE4a/5PgBV9aqlU2C2QWzisZZxaw6um
 MdgSr9AKHf8UAY64XeEVAR+IVxm7/bAkkPH4ZUssZce2j1SuOYjJgNkwuUXBSuBaJAsohtf43Cf
 JVBMvqJSayKGow1hrscQAy5w1WN4cqhmYVjFiufC80gkkpa2qiiTMKkYtBM7t1I81zlLaEU4X+V
 n4TJUxQi+GYo7YI2TuYV/vRs2JOLgsJfSW8RbChWGlPQGE5Au7XQqhrSPC3bArGoDnH6QU6dVhD
 Ixvyv5xdgQQ7fmN6peJTKvssqTjMVD6O8kqoRBjJygtQqiOyIViTC6gXOZ4g1tSVJtU8lf7tL2w
 mtKLl6GnK
X-Google-Smtp-Source: AGHT+IHcsH8adNlZwrRlN7mr+Ppudxls9pRBnErGa7/Mp6qPgu/+F0y8fjs6Hnt0hcPXdfZIWPFqYA==
X-Received: by 2002:a05:600c:3acf:b0:43d:209:21fd with SMTP id
 5b1f17b1804b1-4406ac2040dmr126725005e9.30.1745304058402; 
 Mon, 21 Apr 2025 23:40:58 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acdd4sm159563065e9.14.2025.04.21.23.40.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:40:57 -0700 (PDT)
Message-ID: <370fdc99-1b95-41a3-bc41-3956f5b3040b@linaro.org>
Date: Tue, 22 Apr 2025 08:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] contrib/plugins: Fix type conflict of GLib
 function pointers
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
 <0fcddfca16ca8da2bdaa7b2c114476f5b73d032b.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0fcddfca16ca8da2bdaa7b2c114476f5b73d032b.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> On Emscripten, function pointer casts can result in runtime failures due to
> strict function signature checks. This affects the use of g_list_sort and
> g_slist_sort, which internally perform function pointer casts that are not
> supported by Emscripten. To avoid these issues, g_list_sort_with_data and
> g_slist_sort_with_data should be used instead, as they do not rely on
> function pointer casting.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   contrib/plugins/cache.c     | 12 ++++++------
>   contrib/plugins/cflow.c     | 10 +++++-----
>   contrib/plugins/hotblocks.c |  4 ++--
>   contrib/plugins/hotpages.c  |  4 ++--
>   contrib/plugins/howvec.c    |  4 ++--
>   contrib/plugins/hwprofile.c |  8 ++++----
>   tests/tcg/plugins/mem.c     |  4 ++--
>   tests/tcg/plugins/syscall.c |  4 ++--
>   8 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


