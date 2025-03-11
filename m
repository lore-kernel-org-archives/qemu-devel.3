Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1565C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3eD-0006Zy-CO; Tue, 11 Mar 2025 13:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3e1-0006I7-6v
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:43:57 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts3dr-0008NC-LW
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:43:55 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fecba90cc3so11226524a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 10:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741715024; x=1742319824; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z4zPp4GSZ4Wx3O7yXUJ/bzWCT7T7ILy6438xxHvH6Fg=;
 b=ga9YncXS3LXLIG5S3wxKLqh3dsdooDEl3wtysBVDwnYGCzy0DGARfwQ0TS2f5QPGb3
 tbnMk7+4sLsgfHxnrYQpEG4HFELXIFR2inE64mE6gjms/k/v/MXGKrI+icI+coRhDTn1
 bvOK+adSKVO6HI4Cn32cHW+NGqoRN1qRKHC/gDpnRcauTDaBbpRCV9skyVKqR3gvvspH
 uLbZD1EDp2aVGUaPuQhX9b9XwnXcgsUhQM2RwXfxfM448kW1R7loCIDfW/fwqcl8wOZh
 9i8CCcO+VJOZw+l1FQbvl090PWhT17JkrATejUjvcbZw9gCi9jOHau5S+dzyU3wZFi9O
 bL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715024; x=1742319824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4zPp4GSZ4Wx3O7yXUJ/bzWCT7T7ILy6438xxHvH6Fg=;
 b=DnpBhc1L6azN74xUg1+GLTHcTgEgrkDYAGo0kCz7OfQGbn4TpWx7XVMDKE9Qzu9li6
 z1JTV8C3YkH+uK52zm3ivkiJwdXfhbgJjbJvkDM2J9Kocjsb1nPDrG/xB54VqpNKBygY
 pwQzmd9TBzf/3ox+Vjd/nRafLMaxayV0EF6c8Km8RLIO7HtEizDLCdBwY/kxF4yTfpf/
 CV8LTo6AHhLHnwh0RkRd2O74H06K3Ka2stBrFSdkHQN7nyh20i6l4tOTMZyskzudWdMj
 gMehFtbgGw0ldaAfeB6/meG/KUBU6m5T5P3Bb141uODEfBYUQG6q/ncfaQjKnDGycexw
 eR0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtWoWPqsPCIvoBAP2IKCJuuVJR/aI45BKP6TZp9lyq0Hb6SSodpdcoK4Ze+RtbQPVGZ/5KEETFS1l@nongnu.org
X-Gm-Message-State: AOJu0YwPsVN+wO/RC1nv0mJafnkb2b3WKImzhua8nj3RKj5A85kTngEr
 bHO0ptUle+vQTlVnRWCkRuatwaKiM57J5AAFjRXcDfM1+wu9jJUB6D2l3Vgay3U=
X-Gm-Gg: ASbGncsez3jObYWuDVCkC7XC2YKrovdw6JZhCw2XOzCJULwqHhPKM7A5d4fawz/80pi
 6kHFFQM6LWdp7obkyXKSGbk+jDoFEYGIQ55Rxf+ShMP7rDpUL5IAOIe0latQS38MnX2a/7Dxce2
 mCYbfJhoZF06y1wjWO78Nt2BifaaPfzKf+1rZ4Cynr6VCgPg1r25yMyuR0bvBTv2O5O+oq4fmwh
 SwJZ6efP7OpqVTCfHC3VNIPbD5BfkF3Qd+kPe7vn7Bai5j6ko5dcXC3MXkzj3F+6kEGKkSm7sar
 NAVKkiug8Mcf/ect9o6n8HVDgz3S0wjvbzACJXc6aekw2767C+oA3AXvsHd/xMS3SXbbXkF0tOY
 LbxzyVy5I
X-Google-Smtp-Source: AGHT+IHZnXu67FslSz3ubL7rrCtYW8mmG28MtVTgtbfjyYGIdUt5JxyrdNXuAYxi2D1OIDvF+acrhQ==
X-Received: by 2002:a05:6a20:4499:b0:1f5:6b36:f56c with SMTP id
 adf61e73a8af0-1f56b36f8a5mr16243530637.39.1741715024521; 
 Tue, 11 Mar 2025 10:43:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c78389d7sm6088696b3a.4.2025.03.11.10.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 10:43:44 -0700 (PDT)
Message-ID: <e3c271d3-3088-4254-9739-c2ac6cc78e2e@linaro.org>
Date: Tue, 11 Mar 2025 10:43:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] arm/cpu: Store aa64mmfr0-3 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-7-cohuck@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250311162824.199721-7-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 3/11/25 09:28, Cornelia Huck wrote:
> From: Eric Auger<eric.auger@redhat.com>
> 
> Signed-off-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> ---
>   target/arm/cpu-features.h | 74 +++++++++++++++++++--------------------
>   target/arm/cpu.h          |  4 ---
>   target/arm/cpu64.c        |  8 ++---
>   target/arm/helper.c       |  8 ++---
>   target/arm/hvf/hvf.c      | 21 ++++++-----
>   target/arm/kvm.c          | 12 +++----
>   target/arm/ptw.c          |  6 ++--
>   target/arm/tcg/cpu64.c    | 64 ++++++++++++++++-----------------
>   8 files changed, 95 insertions(+), 102 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

