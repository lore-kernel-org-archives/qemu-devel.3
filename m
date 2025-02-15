Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D754C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjNUu-0001JD-9v; Sat, 15 Feb 2025 14:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjNUo-0001J1-Tg
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:06:37 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjNUl-0006s3-76
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 14:06:33 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc0d44a876so4544159a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739646388; x=1740251188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E7+4lc7cPF+3BVMN/yhfVUQukqSRX9OOK4Kw0SKKvAU=;
 b=PQ4rCSf1zXIbOVZFnh14ogWPYU9ruPxufAwuF5iv7cZSMMzP0Wb9NeB7twDOfKaRuN
 KOq2Aw0eFPI4o2K5ehVKIJQUErahgYhyCW+EvLj1AIjYBgmi9S2smFfVhw6iVtEXt7DR
 15bhO2QEuD4eJe5NWU+w8qcvq6wOtP1wwjmU87WjNXasxAO49uWjTRo8bybwrCQBtpu+
 GBcLtzdHdVT1dMvp/im/fCZSwLk4MGH00y8QPKvDK51Q8tkDPPfEheQcxO76l6WI4FW5
 jYUycWMmIM0bOR20jAdNHlq8B16dt0lPCXrbI4ZutOT9tgMAQZ+BORKfjMf1UMmnevTd
 JEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646388; x=1740251188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7+4lc7cPF+3BVMN/yhfVUQukqSRX9OOK4Kw0SKKvAU=;
 b=gzhmPwftAxZhIqbkTHfbt0QR4UqaOiof5PeyViZ/NgpsEd03zM3msB8QcxsVR8se/o
 t670SjXQ0HK78BARDWrTIjyyUxS5jB9zSuKSeQVYe1zc+8kf5pDroirzcuSH2mjCbi/4
 +iImw7lUP8sbuylQDKSyO9/sXbbTWRdADktE4uLZI/fepJj97z+5p5yrXtmlCG9H/OcU
 pdIQYyL9nIiyFfMfHAW4+unGNPyQ+CS2UStimkyDdJErQ81l/+2jmKhM8lySGZQQEo+a
 R7qV7Jo1puXJO0CQyamj/s0Pjf8bBvEU7UVhAcZ16Ztqf8j5cBonmI9361I3Xa+S5Ye9
 o/4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqaXw/KzAMtzEtF96wRLwMQ30pbCpzqRUBPvnkSr/m/NlpuBMVsMzxZLE6EPaUOfL6yp2aACKt/eLp@nongnu.org
X-Gm-Message-State: AOJu0YxHDsguVDoZLaib8/38D4uWVcHJsP5aygwIJh4RLcvcPZeLfekx
 htdeajVOYNm+XQ71r5wnIgIzMt/ZHPpShY5j8eogYgRhtRsjBtAJJK8SHa8+f/c=
X-Gm-Gg: ASbGncsAMu/5JilaQpqJ4Zxt4JZXBqJEdcU66yn4b9AYNoUGIXD5S5bvDDULkIYm1Z+
 0nYuSXKPoM7/bJBxdBBSJs2sM4Z0lbNE2uVpk6jQvxABkzePVpTeeS523d5AXhN1b3MJv7L7Rp9
 fZtk/3fSiVcLCXvrVAJrhvGeFgKdeFxgenCtXsEQrANtZMOMZlWs7rQwFfWwG4zGfg/z8iufL3W
 JNY3RQnAQobpMpcdGQOnQBO9m5kpOEIx5c4O/jNGEdNGD226+SpsIvVyIQmWpvOG+Uz4EDagsUT
 vbdJ5SO7+jw2fvV6LlXptB0zJgcasQVWKgZFFDwgLgww3YEPS7XKI7U=
X-Google-Smtp-Source: AGHT+IHK5A6qN1WebfKuOoQSj0lRznem0ZO8WaI8n9ZDlrowamvSaURoj4GmSwGho5zQ2HQ4zHDnpQ==
X-Received: by 2002:a17:90b:1e09:b0:2f4:f7f8:fc8b with SMTP id
 98e67ed59e1d1-2fc410493edmr5681231a91.27.1739646387895; 
 Sat, 15 Feb 2025 11:06:27 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13b91588sm5224561a91.37.2025.02.15.11.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 11:06:27 -0800 (PST)
Message-ID: <92d268c0-ba67-454a-b22b-688122eccd7b@linaro.org>
Date: Sat, 15 Feb 2025 11:06:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] elfload: Fix alignment when unmapping excess
 reservation
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dario Faggioli <dfaggioli@suse.com>
References: <20250213143558.10504-1-farosas@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213143558.10504-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 2/13/25 06:35, Fabiano Rosas wrote:
> When complying with the alignment requested in the ELF and unmapping
> the excess reservation, having align_end not aligned to the guest page
> causes the unmap to be rejected by the alignment check at
> target_munmap and later brk adjustments hit an EEXIST.
> 
> Fix by aligning the start of region to be unmapped.
> 
> Fixes: c81d1fafa6 ("linux-user: Honor elf alignment when placing images")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1913
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> In the bug there was mention of the vdso landing in the wrong spot,
> but I don't see evidence of this in my testing. Looking at the
> addresses in the bug report, there seems to have been a mistake
> because I don't see an overlap there either.
> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index a2c152e5ad..05ee5e74fd 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3351,7 +3351,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
>   
>       if (align_size != reserve_size) {
>           abi_ulong align_addr = ROUND_UP(load_addr, align);
> -        abi_ulong align_end = align_addr + reserve_size;
> +        abi_ulong align_end = TARGET_PAGE_ALIGN(align_addr + reserve_size);
>           abi_ulong load_end = load_addr + align_size;

Both align_end and load_end must be aligned.

r~

