Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6674CFD2F6
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 23:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNJUe-0002eL-DS; Sun, 23 Nov 2025 18:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJUc-0002dd-R6
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:27:42 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNJUb-0001c3-8Z
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 18:27:42 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7aace33b75bso3430957b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Nov 2025 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763940460; x=1764545260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8zI1shdrNPZ2mDo6tAyq5NLl9uMdO3ANpdQk0bvDDbc=;
 b=nYYElL9RedjmkdJaOEz6X0jNOnNZZoHm6hzw7wokyqi2misdnESBJnIZduFcv4t9Om
 VgV0Co8FY//wJj/C1x8hodd+7WNV6PtOmOD6YlT8qx+Ux6r5nwo9246m2TMMJ/PcpBAi
 yMedvLRwx+Zu0QO8YbdPH4Pls+o8zuBx51QGlHrVVv8SnFJOkDubNTNnLUGxL2U/LYzv
 xR8h1sqHU92vTqNMqXn9tJmHYHFBHVcfAeTmpN0s67f9FUJHHcFNqHT3BPPH+2W1tlh7
 U320u8US9pH2/5o1Kg0NZ9rKDLfY8HKfeoqaNH3FLVbQUKLCy+ARMevE2Lv2kBZ4JNvs
 k0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763940460; x=1764545260;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8zI1shdrNPZ2mDo6tAyq5NLl9uMdO3ANpdQk0bvDDbc=;
 b=BmaKpgVlf2HrUUhRCgWm5Z+6i1x4DYoq+/AigLjosljK4ho37UHNkCjCHzLrxV2kgY
 5uc+Q2rYL0QN9sxum/axW4MSn4D72w74aRDjO7FyzvjdSfwkB73gatLgVcJVH3oCSc8d
 2FuTWIuJc3H2gBt7rXSi/hPzFRpwn1CzFVixg4W16vCdIbdIUjKLYxSlXWvZNUlrRaj0
 2VfpPhCGfWIACxBTN7PkKj+c2EBjdPw34m7a2+Rk27m31P/rCjeULrkZ4t0nmR9f8grv
 lytCb7WE+9so/zU3fNaYr9ppyBiS+tfR41crN9Xp1k8/KJUPyEVntHwBR7jn9TRXcOGs
 lIPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcHwJJYA51x32cXwXMruQRRpI/QOP5gaqJhn+O1tStZ8gGbCviflcdQQRX5AE7ca6XlFmh0j3KdlLs@nongnu.org
X-Gm-Message-State: AOJu0YyqB10lx+bIflaUdduXzUgt4Av50Co+BWH3xYux9fmAny3uTyX6
 SDIHIIyLB4gZoxrxcTFYfJr6xhSqhHEH31U2JBXRMuoirMowt1ICgUmzaNoFWNrENus=
X-Gm-Gg: ASbGncv8PVfMRTnROYhyKwZfcksGGUbg13NTYLi7qprRG99ZoxPFr/NmLVbJd/IVnez
 d5Zgm9QWAb/hCgqjWyJzC60HXXBUHS3grkQqBcaRhGug951x4RONN2umgg3MLj0pWyvSFtuQvrd
 YJGi/hSXu3Xl8qa/l0x94I23XW5FObPIOIGQHpobfTkQrM5QuPPqRFyE7Pz3CdNAIyI6LIYrF1/
 X3GNIFAMDZxnCPS2BmbjrS+sWJEjyahlhGw2lfokwxiRg58ph3SDa9h24jaZo+QFRaS2ynj9qdr
 kC+kpx21XsoxMBK+Xzqtz95I2htCO/IyDYHElUgDLdmzRFGIUEXMIT9bbX768ZpVi3stEiFp6Xi
 EbjiFsZ+OjnHJix5kRe5vB995rraXn6ZjN7B4haHHN9YN/Eq2tj2b1A+sq0W99BrKM77LeOtehl
 dguo8GiQ9ajVHEkitP+tAwsbt5FihI/h83lyAxFjkrgyP/NpLDgpj3cH0=
X-Google-Smtp-Source: AGHT+IEpSmnBUSuspMtR6v5iH+F1XHsO4eFWvcuxfobpXX14OLw3I3ssEzTYmcK72i8zlXxjeLdO4w==
X-Received: by 2002:a05:6a00:13a4:b0:7ab:8583:9cc7 with SMTP id
 d2e1a72fcca58-7c58db2cb6cmr9459523b3a.16.1763940459837; 
 Sun, 23 Nov 2025 15:27:39 -0800 (PST)
Received: from [192.168.0.4] (174-21-128-133.tukw.qwest.net. [174.21.128.133])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f024b4aesm12214618b3a.33.2025.11.23.15.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Nov 2025 15:27:39 -0800 (PST)
Message-ID: <ab26307d-2e65-40c3-b166-61605a56ba77@linaro.org>
Date: Sun, 23 Nov 2025 15:27:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Lost MAINTAINERS update
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: zhenwei.pi@linux.dev, fam@euphon.net, xieyongji@bytedance.com
References: <20251121123554.1255093-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251121123554.1255093-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 11/21/25 04:35, Markus Armbruster wrote:
> Zhenwei Pi posted this patch back in May, but it fell through the
> cracks somehow.  It is still valid (we talked).
> 
> The following changes since commit 5a5b06d2f6f71d7789719b97143fc5b543bec07a:
> 
>    Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-11-20 08:12:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-maintainers-2025-11-21
> 
> for you to fetch changes up to efbcf49ba06221241e3fed07ca4ac79f07b2bbbc:
> 
>    MAINTAINERS: update email of zhenwei pi (2025-11-21 13:31:55 +0100)
> 
> ----------------------------------------------------------------
> MAINTAINERS patches for 2025-11-21
> 
> ----------------------------------------------------------------
> Zhenwei Pi (1):
>        MAINTAINERS: update email of zhenwei pi
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

