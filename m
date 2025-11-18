Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F85CEE348
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQ8s-0006ZY-P1; Tue, 18 Nov 2025 13:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQ8r-0006ZM-AI
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:09:25 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQ8p-0006FT-Np
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:09:25 -0500
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so32550255e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763489362; x=1764094162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DcBkHyTiNVC4+9fAsiXflPff6Ryh+siQ2zf+8F39EBA=;
 b=ks00neJK19i8Z1dze4/coKAi8B+5PXsFrHelOnuNG/sG13xHMFShL34EOZShM1XoIf
 eDufzps0gHPOslKd9h7VfyS21FhZqc6IAXriR6E1HIWIdvGQq4Kmx9v+FCm1I/hFXPFg
 mz/GQKYIEd45fcqGw4h9sd5Xzo07T3+ethAjN1HuDGidVAI3bzfE9hidTp34r/J1lMtD
 uRP3XHs0FM2/VYoEt769e2IFMg4kiT+NmjNBp+PGYM47o3zrrBYg6q7d2vlun7Q6vGWW
 HuhQuhwCzndpYQbQx5ZmDSvSd6eYV4YqeL9dbWZAvqTWMH28WRvfwZyKa17AtGHGmMFn
 gi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489362; x=1764094162;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DcBkHyTiNVC4+9fAsiXflPff6Ryh+siQ2zf+8F39EBA=;
 b=R5i6z+2+tr2zHp57OuKShLx/PdWdI/DmBVC+Bexe/C0BKmXDc6ixll4YQBO3eA9g1b
 RAQpZrwC6AI0IKhj7HZemmNXBKGltyTDN1DvdQ5kj+8UBvXWZXBXpP8v0Wyz7z/l+UrR
 p/t82oBjhhd5xLC4nvFxU33hu6F3chpzTqdO4cf60nM5+4HLMC3yWR99dAyAK2nyt+7/
 7+UmB9qio/l7dDbMGQwir5amGEv1EpGC11Of5qdURD5Mr/jHbYoR+AjrE83DPxT7/cht
 iU9mvdMMpfQLS9uL8dfZ0ySf87EQPuB58sUj1sKqLBBVj6o1ZA1va/HPN0h9q5G4HDNb
 /AHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG0sydulm+qnaCU5sZjyTjG9ezxdGYom9wBAZ0JyCVEhizDAZw+oNmDaWocruFPOkQQv0BcfaYxwhQ@nongnu.org
X-Gm-Message-State: AOJu0YxjkO0HzJTQ6xhnfhIJu+a8GiVWFBD0hCTrSWUWp6qERPIB7uwV
 Fxu9Uyjh+PjdE3I3apnq23H1hZYGTf366dt4OKJox6r8J694iL6ktUyy23GqwUKgHFk=
X-Gm-Gg: ASbGncuoORGQeYZZUq+rGwvOc81dejrCDr441T8AHco1CKCNS6I0JrgQ09qJ+P4SIOa
 tvPa8pmMda+xNnMpqYAFEAkdZpUKYueyzSEwxqJ1eozXf2cI8Sb3FmLr+dBaAKJcncH4ETpw4lj
 stJVDjLtEzFFi7/vwGBoHQED5fYW6ivCmS6o2R2Qhg9mkvvsETZIrheRkuzW/+R7mHzQ0c4n+fH
 XhgQSzedkzItX5WPsvVopChkWUsSZ7iV+gkrGZ/Y8ngkAyRPJA2A/YE94u8CnBH+k9OKk3hOgPG
 yljIcU/s2omahnSr9xdhcLpMf6VWlHOY6BOodm15ZVbZRqRvIcz2A4vCMYRUUmJS31+kfy1mfWJ
 UcfrqloqKlRRKWTrlkdzUt6Nwb45oykpLoTPWDdh/CDYFwmWAU10svmdaJvblatKfG1pHfZ9czy
 8lQlsl3Uh24T3kJdZOSReKSmzr8Lgmt7701r0LlLjjEu4eL1LKcPtX8w==
X-Google-Smtp-Source: AGHT+IH95493gREtvMp4/e6nMVUxqd5OOxI8nG7JpZ/eY1BWxwXbkK1YSZQJcMajsAVUoNzwEPIrpw==
X-Received: by 2002:a05:600c:4d95:b0:477:952d:fc1c with SMTP id
 5b1f17b1804b1-477952dfcf5mr86737765e9.36.1763489361404; 
 Tue, 18 Nov 2025 10:09:21 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f0b622sm32646592f8f.29.2025.11.18.10.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:09:20 -0800 (PST)
Message-ID: <eff54689-b1a3-41f2-bcad-a62941aa9fc1@linaro.org>
Date: Tue, 18 Nov 2025 19:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update David Hildenbrand's email address
Content-Language: en-US
To: David Hildenbrand <david@kernel.org>, qemu-devel@nongnu.org
References: <20251103103947.384401-1-david@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251103103947.384401-1-david@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x342.google.com
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

On 3/11/25 11:39, David Hildenbrand wrote:
> From: "David Hildenbrand (Red Hat)" <david@kernel.org>
> 
> Switch to kernel.org email address as I will be leaving Red Hat. The
> old address will remain active until end of January 2026, so performing
> the change now should make sure that most mails will reach me.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---
>   .mailmap    |  1 +
>   MAINTAINERS | 18 +++++++++---------
>   2 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


