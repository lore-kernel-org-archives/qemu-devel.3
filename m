Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F295E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuQd-00020X-59; Wed, 18 Dec 2024 08:49:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQU-0001kr-RI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:25 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQR-0007m6-WC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:22 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725c86bbae7so5632067b3a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529758; x=1735134558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2SdaykMuNL8rkKe7XBz1EiEigI+9gP/zUTgeIflN/n8=;
 b=ZtSGaizPQhxJr5Ugsr7k7zwytbqVOTvxTMJOIlNcqdgAxEo4OskWZsKhtO3TMGOp95
 x7/J0Yugasj3Q4Eq5RqJrstFK9PxF4u2JrwAs2ZFWyoxPEV5jpXQESP09fk+CrGa862d
 AqDxxQBVCOTkRHRQFJ0eoQAzq1LImFYEdKzcX63Qfsk1u4NOrFIwi3sSlQLElbNiSPvs
 t+6FwZsquPqQMyO7mJLE/jDlbSaJosaKtFdm6z2JcHuv3f2WoBG0keYpCmPMjoyKPtwD
 LJSeT6/W2rnmDS9TQV504AUTRq/cOLO8hdOJJMobB/E2mqkW2e/v7R13c7+sTySffSlZ
 E0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529758; x=1735134558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2SdaykMuNL8rkKe7XBz1EiEigI+9gP/zUTgeIflN/n8=;
 b=XDtz9arTfLVGx17XZzvWmzCaFVCRwQ06mhKPBTuYVtqpiS+zk3K3NNnH8lYzaWQAGd
 siTjQrPg7rSZldmXWCnCnW54aV9ZG532JgmFZoGZvJprixsFGB6+srN1XebpTHQ5BPLq
 o/LqLRzsgfZY+B/+CWy1l6DhVAdScG+z9uaZK7QFQcB6XAuQfQ136vYdK2LZqeLHe0iM
 O/BS2jt/3wrZo554zEvXD7a0rQPnsVeeqwuZcv5cR58Kvyzh1dGwjUMdDZ7Mx5vT8mAQ
 fSOcNn6hbdQn5raCKLJifRd7ag53Rwiu4aaY6Buf4O06TkFBYlTi0/4rZKnfs98QdR5W
 +J0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0ed5mhGaWrmRQRIxJtkLZ3+cEs5lUZHvG8cOVSXcWRcvq0HGEgQ25y0TIbjS+nXEzk+Ksfx2Dxq8s@nongnu.org
X-Gm-Message-State: AOJu0YzBu/ea6BWHhgz2q1HnQ5EpTDIKZvhJJRvWO0b5yh75imMRkpk2
 dGS7/iD2m5UVmklNlWirJd5Eq39Cle0sugjIqHw1jR6xKj5I7C5s1yeaDN/R23Q=
X-Gm-Gg: ASbGncsWg4J+N6z4UmPg5sraKScOFsy6qi5QHekRUhYueHvbwwCMTTwIQcL1Vlpf0Ui
 kAkjOP3D+VXc69ucagCLBxT4NYT9F0jhHWvrErBxjPRurlxKMBSAyiXhjPV0Y+fyuTSp8hfCEC8
 Pj8ND02S2LeMdyqRjLbcegT1/JXnXkVGflOaMwjMI7lAFGW+PPz60rCXYIJkxYPWFBNTaBfuY7s
 L0ZQnn99F0UK9nWoM1rdbSSZuPMyFe3qxeaNN41YOSJdYH9+GCTqg4Lkup2HzeLIACBzSbf
X-Google-Smtp-Source: AGHT+IERPAgvzBQHsgEshWKY+HttQQAyBGVv+6QQeFM7JpoYglZ+DkI6CrKzMi3alC8wRQOFYCaaUA==
X-Received: by 2002:a05:6a21:3987:b0:1e3:e77d:1431 with SMTP id
 adf61e73a8af0-1e5b482cc3emr4924385637.23.1734529758017; 
 Wed, 18 Dec 2024 05:49:18 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-729187601f0sm8518817b3a.0.2024.12.18.05.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:49:17 -0800 (PST)
Message-ID: <834173ad-0891-47df-b90d-44b65144c9ab@linaro.org>
Date: Wed, 18 Dec 2024 14:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/24] migration: Constify migration_properties
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x433.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   migration/options.h | 2 +-
>   migration/options.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


