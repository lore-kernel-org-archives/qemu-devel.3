Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27812C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4koE-0001iL-FU; Thu, 10 Sep 2026 15:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kix-0000ah-Ec
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:46:33 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4kir-0000AV-1H
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:46:16 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b31b4281eso113675a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069563; x=1789674363; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qPjGqh7QnLkA+QIiyw56KkV6COKMVipXPRepfXjAIPM=;
 b=hUQyj9VFRsupFGX2l2j8gi53f3HLzTd8gHOEGv9os6F4EuEaV4MUmgOKRZj4KfL6Xn
 8U/SvDmA7nMKjrtZ8eFcGCnpVffN9ppbMUP0xZSIWJwnZI2zXOIavRga3PT0glV0QLuk
 p9OdWd1DBWbOxALiZVf4rFL4q86MyY6d9UE4bpwNQbdcggrs4smmL6iSqZtbsuoIfGZK
 m+Sf5ikeWLpQ2lc8ThYuLYB5YcgJOH+i412nB8/pr0szLudUAxP9ulWgQKbfeQlTrmdL
 OqHBtU0xUpeOFA+5UilXAmpTzFw9lHyzVcU8zrNtD8KXn0m0XgjtNIUC79arSlFx0Yv+
 yQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069563; x=1789674363;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qPjGqh7QnLkA+QIiyw56KkV6COKMVipXPRepfXjAIPM=;
 b=f3hX+W8LftBQuKFWDq2jjnaXIVuZT6XQb9waB5+XGbCD/glpH8z+bOXGggJqRSD1zU
 cwQneZ+asJN6zNiPDCubf5t96mOSAX7eyJr3NPRNHLQul3gsurlJG8f1C0zEPc4Uz3dJ
 AP5hoBOWiBrPwTSPJi9GLDCoeQAaKqUaWWR2N89EfqedBYK6+Z9oEdaS0LJiJQZHJAq2
 8JiNvS/najcfQe/PQzk4D/nkMg+3rZpQGjwUUeFpy4nO42MX54VH/MAINUtz3DqivSK+
 Pu+OkEqfSRTgstT5ooM+G5VliF2D5iKWUHf+ECrIanxEQ4i+KIch9n58YOHRss52ulce
 SdIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjahijVqmgPwMhjZ+6ZfYDGSiBKai9Z87mKhV9/LzZQPQpOyqJii55ALMaMFS4JQ/rzVg6Sup/inHt@nongnu.org
X-Gm-Message-State: AFuF++lz0Truh0dE5n49xjaCIYRAY70suY0uFr0Ain/YUy01mQKHhocu
 UEGHDGjD59HFzKkwjkPlp0s1BYqr2iS7Jsbe/20i4+GYsF4aRxdJEtfaU8FmEzN/du8=
X-Gm-Gg: AYBFou148tOaPSZfQ6Iv4bwZ2HMIHV1n0OaWXLmet3/TL5PmRp3ggwYbaj9cZxFJ+1d
 yUeQ1fjigTxsEzaBhmT9PD6ntyRCcxbc7zGHQ07ZH/lyxYBADmbVAmrTG55tmRj4GX5O3urle9w
 EmSzgvdoULxzQVIqxq5yx6flqFgiXsbTAxsXcAkoplNZrg8gvi7HLeQ3RiZPL8DDVovlXDztjyn
 lWejdm0+42A72631eTtAlpWK3rmPe/r8QH+NgiLpRl0Wthy9zRUZpNzkArpUjDwwptQFjHO+Fq4
 e5/p7T2bjgq5HNeFGfdZlqQfZxFIFGU188xyREj4E9yMuuNffmwqVlrhq/XVWiDe17OaigD0e2z
 RJtybSXC0VTHXjrF7idrdPbxRNtuIHyTtKJ/j932J8Gqy5cKJ5r2Fh1iVCoLNv0XIlvf+wUGPlp
 THYP369kc5bqqN97eu+G4z4elHxXoyBN9XnvDEyTCHkgwFfYRfDNUpJfDn9MtwfeEtWceoOAlmY
 m/dDMYuZGAaNSM=
X-Received: by 2002:a17:90b:3dcd:b0:399:ea1:5a82 with SMTP id
 98e67ed59e1d1-39d9bc66ab9mr546457a91.3.1789069562822; 
 Thu, 10 Sep 2026 12:46:02 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4ed295esm311367eec.15.2026.09.10.12.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:46:02 -0700 (PDT)
Message-ID: <4a0b16c5-862a-44d0-9ce9-248bd7eb1ffc@linaro.org>
Date: Thu, 10 Sep 2026 09:45:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/21] target/mips: Constify CPUMIPSState for various
 cpu_*() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-14-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901095229.72018-14-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 8/31/26 23:52, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to CPUMIPSState when
> the argument is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   target/mips/cpu.h      |  8 ++++----
>   target/mips/internal.h | 10 +++++-----
>   2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

