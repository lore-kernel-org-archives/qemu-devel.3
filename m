Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4616DE65268
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 14:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmYGt-00031m-Cx; Sun, 01 Feb 2026 09:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYGs-000314-Bo
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:17:50 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYGq-0003Be-Hz
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:17:49 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-48068127f00so30378955e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769955466; x=1770560266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ByKVHzSQ9zHFazuT6oztAMja4HE91ec5VQ+otD7rQM=;
 b=HCCF+qD83Cp8ycUJaaxY5C9kaPCuCHVMIWXW52WpEio596Q9ka9oblaU0VR74Bmysv
 /qe9EA7uaO/K2LDpK+g7K3cfGAU2qt7DOuD113fcIzldiDFB8wuerdVKANLItq0YZdgc
 B9X0uHgg1IXphxPT+Rr6POS7+jj9daaoyEKpgThRDAZqohhbX92Q9quXb2YzbqLJTrKu
 yxPf2zkBiH/Dy0FMZGs3Y01poFmPzSEW8Ui0YMDmwvzXrD/Qb5dq98v09aVyRFpVdQ9g
 lco9s5T1/qt5ZEUkBVoBIlxsemBEzVTIHh/qUhjswaL+AEIeOKQA12W1p4ttq9RXISk+
 u0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769955466; x=1770560266;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ByKVHzSQ9zHFazuT6oztAMja4HE91ec5VQ+otD7rQM=;
 b=bmFN3eKXaM7WFoO8NTgH3e3sCg1AG9r7z5ac/n0MdPzzTc4J/L3orhCfNR52xzdMWi
 ZvP+bfqn5WB4a0dMD3iESzowaImtUpG2zz9uA/3cLw9mjJARzIRo+TdFAOygLijbpalF
 F9tEaUpCSFBXEIoHiJz2e8Npx+McY5RAfJlhPxVPZC0lLeIa3P+yzJT2akPkL7et6CAx
 jRn084fuYDx6VI+stOZamNDDQFPllZvKqca1XVBq+mB5jJhRGM2hZNB+1uDdfyOz53Xu
 AJqwUNp0mPb7NMjRQgk/i3p0Phr0gj4gENTmmXw1xFVIFB9EHRnM9XNwA9HwgUdPOPTK
 aznA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq+iMriQWJdG4OHw0ZuIiVskqjZoZTTvlEFgTP9+43mrGEt8Os4/KLDkd2jVdxcrHETrYPK4FKNr5u@nongnu.org
X-Gm-Message-State: AOJu0Yz+lW5UvL0RsLgXEnkBcr31lVx/I4LQJFr1SEln/il+cboMdmWu
 mo+LDfAcc8SAjnYqKTW4ruINzf1J9hPOjSZabfuzVqTkZXq7e0Rx/ffgVYTAAKwP9YM=
X-Gm-Gg: AZuq6aJU2/W+1nMTz9g5G5HBJbFCC67wo4DyFx2Hg5/ZZP9zprqRp8776oUgsVYWQ79
 oFbknTEwRBEjhmrobc+K5M60agWnilEr05PvFTMW3ZBLNmNrnmF4sEYbEOzIMPZquxyWl99lI6d
 W6+VfiQEIf+6JmJoMAy+rbNtLJuun75nOxWnPJe01II3YeghkekBdoxjO5Ug2bzfXB4JUr3VVz4
 WfC+AebUV5fdkydUWtMBh1t2JzbWnT+yJiD5HzcE36QSg4OrOAtffry44ioy0+hYfG9yHbTcndn
 ZzJHPcwauevBargnjn60471wIqMRJ70/h86Ytm6sqKeZiTSneaZpPkoxqV2jud1qfXXw2x0/rnC
 KoGKVMsvXApRmBkob5udFCnAvhmpnDmpahubewdV0p6KVaklAkyhuRow1K4K2GtHVFKSj0iVOo8
 ANaYbXdtd4w60+PosQ7+B9h2xjd9zuADCpmcQU1sqtZ87HNAelx7uhMg==
X-Received: by 2002:a05:600c:8b61:b0:477:a36f:1a57 with SMTP id
 5b1f17b1804b1-482db456a60mr114746505e9.3.1769955466056; 
 Sun, 01 Feb 2026 06:17:46 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm38253704f8f.27.2026.02.01.06.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 06:17:45 -0800 (PST)
Message-ID: <c2a851eb-1164-403f-a1b1-c03edb4cfc8f@linaro.org>
Date: Sun, 1 Feb 2026 15:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide, scsi-disk: Fix typo on the rotation_rate
 documentation
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260128102548.224237-1-berto@igalia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260128102548.224237-1-berto@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

On 28/1/26 11:25, Alberto Garcia wrote:
> Correct values according to the Medium Rotation Rate field from the
> Block Device Characteristics VPD page (B1h) of the SCSI specification.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>   hw/scsi/scsi-disk.c      | 2 +-
>   include/hw/ide/ide-dev.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

