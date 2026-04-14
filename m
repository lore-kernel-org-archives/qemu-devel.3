Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A7F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRtE-0005U8-2l; Mon, 13 Apr 2026 20:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRtC-0005Tx-Lq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:44:26 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRtB-0006PY-0Z
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:44:26 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so2835115a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776127463; x=1776732263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wmoofveAbDQdeF6z/yO7K+u9gu5V1TkSVFTzJxC2V34=;
 b=iLKVD1Tuv7aXqUcZptEdA72QxSoKLiilWzuknbcaffK2u2lU57IP4ETq5KuOW3FNvw
 blZDlM506uWgtc+zc+pOTY/mUFT+8/mMGkzNq7BCSXguHPRQtLI/ss1B2chfsxKrEb48
 BYyHmVcig4KnOOWSbgypmGAZvxSoQ7wafv9yS0TM2GDORjXreHxTQE8jmfZGFt6e5n6w
 DyRcQXs7Cks1/X7XhDXgWl13zEY5LBgKTY4EqFfca5oqOyJxCapAciNVtXMxGaL4bkeC
 hIuYRmJCvu/taMBGWyepSmYX3l+RpF1ygbuC35WpMNjaxk8gE6wD8vH6vmFVNib8Ng0s
 FRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776127463; x=1776732263;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wmoofveAbDQdeF6z/yO7K+u9gu5V1TkSVFTzJxC2V34=;
 b=Wc2wFop4EE1dtNvFtchkpMkajF4o652CxYZUTdjZSH2TUlFjynTWEnVkJu7EhzQfqj
 VQfXheA6Ou1hgx4KMiHoKMISATaVgGZHS3Qmbz9MdWeQsmvTsAtgMi8sdJfX+iQjbRzg
 3yBs6iXyE/pM33373S5AjPfJGRy/tGSldCjv5xYpErDi6oWY8YD7RgA3fb1ONoFloXif
 RNyDvaYgUTW1XO/XmHm78I7PnpCSlDieI/oMsw3vED0KhNG5aieL3abe9nYPnPO9gr7/
 0AlfHf77rvgR8i0jzqIdfCqmm9lqGixGnjhpFNZ5E+Z3MgeHqAE6w5WGjHqWE4wvhNid
 Ab6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fnRQkUGnmOJno/mHS1eTzjcAp6MBKYxYfVtjmNJM4rh4xg20j0Yt/MP3k1ncoAmYubfPY6CeGhUDu@nongnu.org
X-Gm-Message-State: AOJu0Yw2JdqUq/TqzmP1jpWwA5QlHf7xNDB/C4kd08OiJFhghQ0LJTf6
 FimTlqN5nTXKl2o5iEaHFwES3OWpCI6d+Kcsbh6lD+v9hcz2eN0Vhimojo/J4CY/ED4=
X-Gm-Gg: AeBDievy2dZltIzkksZilha/58I1N2EO/42EFHLebRXh2989q8jYU8tLEeaF11RfgIm
 w99IYXYuj2v5NZqqRfbD41b1pMgUOeuP2liejvoVMcgIlpPcUdYAQBmYl0QCAjxHGvii2MskRSj
 xEhpOVR8Q0ygyQ3e/E7DTB1+ScFQgkYta7duTFQvKtqZ5vI6uoqhOG/1w0UBrN4dEtBX18apbub
 KDCwzER7zUl5XXGDbEuKFcAy0eQtewHvndydYqmUNkSOqeAbJtd26kYrKmSGD+GOO82zgLR3Xnh
 Tz/YtZCQxcxF0NfHpwtzmwHLB2JEienh8iPzI3q1KFRFcDgZv8W00jeNOXNQ2wwZVW7zrM4za24
 ORIYDPB9lvT02J2MJEESs6GglWNdhpIT5GnrHY1pARD+KTGNDQthvpzLqgJVDREGGyAEOPAdSbS
 /u1lTs1l3K9rn9gmGAFT+uPjr4mCXIMnwrn3hyKXdzKAU0rObu/bwybi9x5YAz3ao0AejcnjT9w
 UThPn9iNgKHuxnsoEl8qYXtT2rldpp7KlHRrAbVZA9BZ40HNwkvrQw=
X-Received: by 2002:a17:902:ced2:b0:2b0:afad:7aad with SMTP id
 d9443c01a7336-2b2d5a6e81amr149055015ad.45.1776127463394; 
 Mon, 13 Apr 2026 17:44:23 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 (bg30dhzrtpvfdxnnygb2.ip6.superloop.au.
 [2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f3b65asm131908845ad.76.2026.04.13.17.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 17:44:23 -0700 (PDT)
Message-ID: <84c8ccf7-408b-4f96-88a0-9a26c9d304b5@linaro.org>
Date: Tue, 14 Apr 2026 10:44:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/27] monitor/meson: Use SPICE with migration HMP
 commands
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414003001.97571-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/14/26 10:29, Philippe Mathieu-Daudé wrote:
> When moving code around in commit 27be86351ec ("migration: Move
> the QMP command from monitor/ to migration/") we forgot to update
> the meson rule about SPICE pkg-config flags.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   migration/meson.build | 2 +-
>   monitor/meson.build   | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

