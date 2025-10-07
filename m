Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6962FCCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62xn-0003ny-5y; Tue, 07 Oct 2025 04:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62xj-0003lK-P2
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62xi-0002oP-4M
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:22:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so60147595e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825340; x=1760430140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SLfgLH9oO7iYYFVhEMRutxNRggTC9UpVUq6WZkF8Vmw=;
 b=i1iQAGIv0r97nyn1AQcr/e1xe6pc+/5z/ASxim8vlyAy8O/Mn4lpNrsvkDaEzn2NId
 kYI2LTlNpBBaR3gXVJaPKR0UPc/EfhsuSVjyoEMrVik5mYHR7kt51IzLc5KqQ7aJwKrW
 2VdPfwp7me3tXfwjjX+qGLJt7upSc0eceey8W5U4ItMhgve/igHyt49ONRDU3J6ouqaP
 j/uwP3iUZf46ONEYO6kgZUSj0DYAUEA8GL6LjLiH0uuSbm2ikO02GJm3D092xztICl9w
 hrng8mpsOeyQBDHnUsdQvIpi/n6sNxdf8Cde/+s9KuLJq3Xob05R4e4271m20qnBr3BE
 3Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825340; x=1760430140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SLfgLH9oO7iYYFVhEMRutxNRggTC9UpVUq6WZkF8Vmw=;
 b=BcMITrxxBRRt0NVYptB9hSvALtfs+2mYz2d+2atH7qcb9aA4T4WVo/T8oN02f2a6sr
 s2qMx1DMU1UFBwgaBuqtBcgpf5ZiQOIhYbj6dmYcPmF8jzrISBkZCB0InUkVjtO/BGYE
 Sw5BfaHW0G6ZvPmBiSPf/ApM2i3wNhmCrOkfbf0jP8+gLjuG25HpUdEVl4Ratwubr8JO
 r76G4AnQQB2jKbni61WmRSAHu2udOD910o6NlBA9Nig2Ya6p67fN8VUB9rkdi+NJH4wX
 jmUjs6NHSfDfbFb0qz1rAdLeILHpHuPS1F3RfZLC14oK8sbYJ5uEIpa209U57J1v9ehF
 IShA==
X-Gm-Message-State: AOJu0YxXG1nkajAy2szP4Vf9Nkftk+4vlg75tWvOV/Tud6n1FznEcfxx
 /0MOrc6RiKswf+czT+iHtHb7S+qCbnmdogJyKa/LjEZKx95SkWCM375dpz1B4gxoGLhndhgfyNn
 FP8YPEr1lSQ==
X-Gm-Gg: ASbGncte4jOhHOAuj1seI1QDVZylk6bkF6nU2Y0k7++QSzl5ATjwx74y4J4OOAl02qn
 bXkxSq6HspcuOo+AmTGcnyDBMbUAgQJEFJjUm2dXxXoxL+ELMngNzd6ALNlW0uu5K+XVO0mGOWK
 vzzAy1jMGrz4MlzVYO3Q2jo4+avOBECuGhZwkFRZcaCv9W3UN57BH7xfy+nk4t2yKUMxyJ+pq8e
 kLmSiZ92einBGXIkj24okfMwU/fkZPerj86cUMGwvgqwG07bu3LoY8hw++5yq03NZsMPMZ9GvoD
 FuW2hkIY2NtgIa/QOi9hQzdjXu3Xx3rlLM8+ntDYGvaefsag4sGJQJ8hPQJUpVVr3mtJcSXTliS
 ITTneS4usVEJVnvv1E3dDOap0409lckQUnPMl4Uq1RZ1bm808sKWQel7Ss5x7+1s87qzuMUFrLr
 9cSDgMGp5eiTlGu+JnmUJWy3/G/+bt
X-Google-Smtp-Source: AGHT+IEgBuFFu8AfGxWKyvhZgbvRuhIJOrnScvpquCWmH3/TE6BgJLczQC98O0WXrqQgaIfR4yQiRA==
X-Received: by 2002:a05:600c:354a:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-46e7114e9admr100153875e9.29.1759825339948; 
 Tue, 07 Oct 2025 01:22:19 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234e5fdsm196411595e9.6.2025.10.07.01.22.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:22:19 -0700 (PDT)
Message-ID: <82ab9812-9ec8-4c51-8d80-ba147cb9c323@linaro.org>
Date: Tue, 7 Oct 2025 10:22:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/loongarch: Replace VMSTATE_UINTTL() ->
 VMSTATE_UINT64()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250925004327.58764-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925004327.58764-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/9/25 02:43, Philippe Mathieu-Daudé wrote:
> All LoongArchCPU::pc and LoongArchCPU::gpr[] fields are of
> uint64_t type. Use the appropriate VMSTATE_UINT64() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the LoongArch targets are only built as 64-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/loongarch64*
>    configs/targets/loongarch64-linux-user.mak:7:TARGET_LONG_BITS=64
>    configs/targets/loongarch64-softmmu.mak:7:TARGET_LONG_BITS=64
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/machine.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Patch queued, thanks.

