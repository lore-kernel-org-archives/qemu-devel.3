Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A7CA0FE8
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 22:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usqiZ-0001vg-W0; Sun, 31 Aug 2025 18:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usqiU-0001ue-Hf
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 18:40:09 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usqiS-0003eH-N6
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 18:40:05 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3298961169bso575655a91.2
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756680002; x=1757284802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbUtwePrKyoHMrSs9BsdltIBoYZDapMC2fR/AHE/pkI=;
 b=tyyKfOxQHuO7hfCCUoT4JpbHg58yJwD8uChrAR8aYveWpwKr+RgEr+s6ERmsCC8qWn
 of/pjj8Ih1e8X/IlWzuH71jhQvXfBdUsOtsIp0GGeKc+pGjx2nXSC1yoHHnWMTq4mQdF
 8f8H6rWBkR0iZzP2ccimQWrTNOMGL5sYXLwzQ190zaKTSXlDmQtv/67yqCcg+v1sPPeV
 w0/Oivvb6q2JBXzywG1JEdBt5kJwrhfyeHBn7IAZeoyxDTb99a25Y8LQEUHKuSU6O6ni
 bFl8jxvVGy7pYXiFpJqGGXFC9uRGtMzzTIFYC7Vj7nFhqS9+RY+C3SgJtoFbZU4ZLn9m
 vSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756680002; x=1757284802;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbUtwePrKyoHMrSs9BsdltIBoYZDapMC2fR/AHE/pkI=;
 b=XG23VZrLgYACI1YhN0CcY5fbHSkL7+hUuqjsj/qj2XzvVJ2yGC2FqIYqPRTlEy6bSf
 OoO9zc71XC4fo2xgsFYTZYBfjVNkJ1V2oehcIC9S/WRcU2jQDtKTgC4ItbvPejFWkw4v
 6CJ8If1HGY0estywYJyKelTPhJ4J1yILZ9x9KqQ/BSYnGmMLIajeP2weiPiMX8CkCd0f
 oR5WGnW8cAES54DkI3+sOpghsc7/nwTpva097RF1C1v+KUa3HUiGA4cxWmDcxBoy9jox
 3RxPM+3evqvOu1t+4uVD3enqG7U7oD+Awzbrc0Fk4rerrKWkU+mPkO+S8wkBPgFjRGgc
 wjXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHmriNjizoZ/XjnYLePS0zkiRN0kBtNg6VIbclNyKbc2/4+MHE+g63FAlNU/EptG5bRqid6A/2VsQ1@nongnu.org
X-Gm-Message-State: AOJu0YwqReLj9QR13kTLwWpsER9umOxQA7dn4xTkaaXktcOYGWNy+TvA
 ycdGHuc7N0BKSHaOlj6u/el4ZQ9psOGaJDR95twrZ+SfHfY3Gxb6/LoNtqiWsJ+iALs=
X-Gm-Gg: ASbGncuFAHcaxlEfGRZ7IFPROg9rKdzaHtdK5EMFVSbMSzMB6pDjO55EIMBxhnifh6h
 gXLIni2L3G9PbzyBgvnYLbwtNXdVwVaY6PW+3orNw4KOydAxJG/j+KNfW51W61kesC6485vpUZc
 OO088Ft/HbLDREJgy8jh/ZkobT+Fu5aK1NSHFlQXWOoh+lE4KaSIPN6aTxMFDXUmVdF6Rv5V4/z
 jc/wCxhn42tFmQYYBP1bhs20flvZbjftUzWKzKHN347G87i7HPx6cyOEwe8EoXOoYRZm1ED4S+I
 GJaXEIVasJ2r0qxQk6+X7AGB1JN089iJcZFkbc3PYKqAp1wcEymlyCm9jkM9kbVj45PtY2VbEpj
 /UvptCed91Xiix5Nzup/CWTA66tdfBJqIernp01GZzfqPhkSPFJmX5VS0EA0oJeDE+TWmwH/FNJ
 kBgjux
X-Google-Smtp-Source: AGHT+IG8qlQ572Ap52TE0Ryy3zfIvcsBlPxP0gXW4y6Eox58sU33oQHtKbNjj3n6iCy8pb0TJUPtUQ==
X-Received: by 2002:a17:90b:4a87:b0:327:83e1:5bf with SMTP id
 98e67ed59e1d1-328156cd26cmr6231229a91.28.1756680002385; 
 Sun, 31 Aug 2025 15:40:02 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-12.dyn.ip.vocus.au.
 [122.150.204.12]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3274572be3bsm9585886a91.2.2025.08.31.15.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 15:40:01 -0700 (PDT)
Message-ID: <93e542af-63a2-4236-9b58-b95eeb6b9185@linaro.org>
Date: Mon, 1 Sep 2025 08:39:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: honor $TMPDIR in create_tmp_file()
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>
References: <20250831114818.4136358-1-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250831114818.4136358-1-mjt@tls.msk.ru>
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

On 8/31/25 21:48, Michael Tokarev wrote:
>       /*
>        * See commit 69bef79 ("block: use /var/tmp instead of /tmp for -snapshot")
>        *
> @@ -862,7 +860,12 @@ char *create_tmp_file(Error **errp)
>        * so the files can become very large. /tmp is often a tmpfs where as
>        * /var/tmp is usually on a disk, so more appropriate for disk images.
>        */

This is going to cause other failures, per the tmpfs reason given in the comment.

r~

