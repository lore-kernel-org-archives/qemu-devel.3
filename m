Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4D6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcr5D-0007iy-L1; Tue, 28 Jan 2025 14:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcr57-0007hJ-3q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:17:09 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcr54-0002vX-Jr
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:17:04 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216401de828so112051845ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091820; x=1738696620; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IG2j7EWP/IPx0gykLsKRN5NQI2DBkwL4S4k7lWilSXc=;
 b=pyoPVwxwa1zFE6Bi5oL6WLledLrwNs6TNMjTMu6m2zc3SSqy36+k2L/Bfk7NJCMVmH
 uDYwcx6kcRKz0IEUdimQmF/aq1Q/8imp969egArHl3VG9lBkSoBTY6lvoqA2+jb/+W89
 yxBxlfqniAOblRkg68Ob9T70PlSyF/OUKYziVknQ4lTmUkX/0gFt/Fp+shY3VAQYeNP4
 wvvKk+nGWGdW/k2lh1iGlcEtRqiXUd896yxEzyRY6UaG5usH9tUNu74QFh3TqDiOeHkk
 cDs5txVOc8tSKrxUjRPaLQMDtmqXYcaAK7o4Co2utzjaIDuF8HeSVZihK0R96dxbDSOI
 1Yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091820; x=1738696620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IG2j7EWP/IPx0gykLsKRN5NQI2DBkwL4S4k7lWilSXc=;
 b=peeEtf03ZNoZEa0rjebumt3iRIvVcp1acZHm3di86dxLKRGFcxro2jKXU7PpV5iH8t
 4Bx7MYEHlH4E1h+RLTldMd4IWOtHSlnl+SnPEw7T70fhgSiTeEwBPkGZsdOiMP74160A
 UYAiN/SikdFb/VB1YwQlthju7drmb5jY/5h3AHVxZCP1BKl32vt0ONGt61NJCoMAt58h
 0yZiAOYs96rpkgdAIGsvHJW8Kceae1Zy2LzFC1k0ugkyf2CXrYIZsGI4BTNtFJTL7Pzi
 JA+BMKelL8Cg5Szx/aOA7xzpDokMB+rn82sCLQf1L5ifz3EfP7gr3F8Lax4km+FSp7Bn
 nSqA==
X-Gm-Message-State: AOJu0Yxjf8dxbjezeaeeb05J1A4baOcgSAFUL9cGQZYVVoTzRXPuy66e
 iFT6A0HKQ//9b0QfGnuHfOFks+ttREcXlm8JLHGg4O97AkSso5fxuqAUj/7f5J97C4bzWwd3oUj
 x
X-Gm-Gg: ASbGncta5ptIVHXFumOPAkRmsKPgr38JQWrR/x51vePl6CpQM0DuJFmfrRWPEPGa0G+
 XL5Od+sr2VXmfTMhtPNLks6m7bsU4D9+hS4bC3OPkYNCioC6pV5C1frhK5fyMx9nrZNhyo7P92d
 muocbBnuhAiDpDozsGvwn3RJ9nbxu9dbsklyi3DFjNzstBG6VN9VTO8RbtPi0URc8Lc+7/BugDZ
 k2aitHTQqkIZgsx7+k9RCH3XzGPkv67OCV729wfK4Wa/A5ULiydEk9MlSURgXWs10l8jAoYf/yz
 T+6IGoIQCH6F6ZJUhGBU1vR8v402XUBeXDAkRwYyCpEb+KgALe/h2K78dA==
X-Google-Smtp-Source: AGHT+IH71NptUzKUtdng2NMeJOCG1FqUhnaj0HlgeSajpgdlq9vvx+UEaq9EFPhMmDZ4JSebGSgPQw==
X-Received: by 2002:a17:903:110c:b0:216:1ad2:1d5 with SMTP id
 d9443c01a7336-21dd7deebd1mr3452745ad.41.1738091820524; 
 Tue, 28 Jan 2025 11:17:00 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea3adesm85085765ad.74.2025.01.28.11.17.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:17:00 -0800 (PST)
Message-ID: <c4f24d7e-54e8-4264-8164-9fc0449540a9@linaro.org>
Date: Tue, 28 Jan 2025 11:16:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] migration/dirtyrate: Do not unlock cpu_list lock twice
To: qemu-devel@nongnu.org
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128135429.8500-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 05:54, Philippe Mathieu-Daudé wrote:
> &qemu_cpu_list_lock is locked within the WITH_QEMU_LOCK_GUARD()
> context, then unlocked. No need to manually unlock it.
> 
> Fixes: 370ed600296 ("cpu: expose qemu_cpu_list_lock for lock-guard use")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   migration/dirtyrate.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

