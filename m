Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BE8CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFbb-00071o-Tj; Tue, 21 Oct 2025 12:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBFbZ-00071A-Rv
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:53:02 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBFbX-00071G-VS
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:53:01 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-63e336b1ac4so134350d50.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761065578; x=1761670378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pgTpzs9Ty//WVqCQc/T6sSmnkj7CjHZDVjNQe40t2zc=;
 b=nrkP4T7ORUvr5sYVoFVr8HtitlgbdmvGVYsWal4fLvKtiKs+ejKYl4S3VFEvNVyJi1
 zCxxeNOuCe65bxiva6VtqoV3QJ5BR9XRBmBO18LLVPssP8oetSqc5jgQRv1mkRzqX0j+
 S6bX4CkulfWEcgwH9Ii6A+3Wt10lv9nDae66p6E22ozZrtmvNCtFfdjIUq78CPGRXG0P
 KCOVQQkheU4hnEf0E9omGjDDUZzAZAoOe3AnIhh4z+iE7/UsLDDfSnfMtrDs6HaJbgWK
 6n3clmcug3pvD6UxjFYs4jRPLcb6hlCS1IJc6qmMSg1Yeypm3R4dKBjS+wtM42LL4kjB
 FkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065578; x=1761670378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgTpzs9Ty//WVqCQc/T6sSmnkj7CjHZDVjNQe40t2zc=;
 b=uNBKvLpi8Dgcn/GT77Wl1uxJBIEaYTIhfAHd3PDUh/3QwxrhE+a2+mLsmCjO7UyjmM
 YNRIHxwqkYLMsgc7e0ady4LclbnUyPmrXaOD5U0e5ZQ8D3yhhyyO1MC4tbHMCtUbznYN
 Fll7IvSkHHJnWjFJtHixP8D6kgkIdeJc04D8i8O0zn4mTFzG0umElsbeLxV0MC9Agl/a
 hQU5MRI8osU0iMD4imA+E9wzK1IQc8Pr1864Gbvbi/rJhYZHHLT+tEdN92w0if3VYXkd
 cPlP4TVQg+4dtT960cFaTjAydGPjKzTm0W+x9qlkbKJeqjgHBJHVqnIxErN0/xmuxR03
 YYLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMUUkuiOBDI4Rc2jV4SoIEwk7PM5tqCSFdOvRIQi6nl2T75sHZFG/+fNHh1sQNtMzHbPmEMQiMuTV9@nongnu.org
X-Gm-Message-State: AOJu0YxcUpWIFBbGi5Xz/loOwMXZc1bhl+uOtagii6nQI42FTmj/6z/b
 XWXW87ektbcufVvC96Tj6O62YG0RWuNrDd0o2x7/E7day7memwEskkXeOg/KzB8oOZ47i1SuqJr
 OSDUxZwU=
X-Gm-Gg: ASbGncvR80E03u699BViBPmPg1IsKNJQHBOeiCRdQUdelW75QKOuMZsAWmSXYugmyO2
 uSx/2XO2VX5kRODUMGXRyJhtpGqmJsu1vQBoD9MJxFmewF74jX67eoOgNjjrTEb5fC6+vwTnn/j
 J4I8776PBsx+E+ff7/4r34kNMn7HXezblD8cQUS/UtkthtFSy6/7Tgz+06FsqhHv6J17sd4jKhS
 OWttfMaPgXD4nxsYW5H8GxbExgodQX5NpW0c/GxOt82NN+x3UOsp87MhGRLR5XnJYSY3zqRU9Yj
 mMLFakBoOf5e3X8mtagRFynSJZ7uzCc0gMeJOBZzExjBWN3rcZDaOgWyYli+wi3QCEAUACHl6au
 71SriezwNCKlZEREZQiBhgejAj9yIXb14927rWBB6BnRuv8s587ov0kB7X69fhuGDV5TCgeeytA
 /UQ4AqRWFwU5cw1V1Ro41AjLe6d4cZtOX1Fpe1Av+uOu39owkCxm/hGWJx66uNZ+ZI2kxp
X-Google-Smtp-Source: AGHT+IGmdY5c1fzAVgPUQqTEUgW/NMr+4EmEK+6hdvUjttCnmwcwr2hGTybFUNHSqbhENsQUn4k5Ow==
X-Received: by 2002:a53:acda:0:20b0:63d:24f9:5327 with SMTP id
 956f58d0204a3-63f27f40e3fmr271976d50.28.1761065578401; 
 Tue, 21 Oct 2025 09:52:58 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ef2:c582:739c:d109:1083:110?
 ([2607:fb90:5ef2:c582:739c:d109:1083:110])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-784673bb9e9sm30148057b3.15.2025.10.21.09.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:52:58 -0700 (PDT)
Message-ID: <7e6356e2-4877-4c92-86ee-d05efaefb9dc@linaro.org>
Date: Tue, 21 Oct 2025 11:52:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] s390x patches + gitlab-CI fix
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20251021135735.96145-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251021135735.96145-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12e.google.com
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

On 10/21/25 08:57, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 3a2d5612a7422732b648b46d4b934e2e54622fd6:
> 
>    .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity job (2025-10-19 11:49:36 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2025-10-21
> 
> for you to fetch changes up to 8a2b283efa007f705f12784fc10185435bd1852f:
> 
>    gitlab-ci: Decrease the size of the compiler cache (2025-10-21 15:47:45 +0200)
> 
> ----------------------------------------------------------------
> - Add a missing QAPI event + functional test for the CPI feature on s390x
> - Remove the obsolete s390-ccw-virtio-4.2 machine type
> - 2nd try to fix the slow cache up/download in the MSYS2 CI job

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

