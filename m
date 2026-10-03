Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8377CA5FE3
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCvOz-0006we-8D; Sat, 03 Oct 2026 04:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCvOx-0006v2-7P
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:47:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCvOv-00077k-3j
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:47:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so2788935e9.2
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791017243; x=1791622043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pQw2T1b5VZgHdECEdNhvkbIF/xE1inGZNVxsVxxLhVY=;
 b=y9WOoXvYrCg3fYdTE64uirXx6psx59isZxX+ykGSxHf1Je3sWlNvVJgtJee1oIkUPs
 f1Apzog2xSXKIl0sId5xUB42MPQ6ayRbpxtAi4UhANPkkUHSyhhttuHaC6yTE8ciVPos
 PebWL9lwAd1NJQp4ds7ueQuB0lB/xcQ8VqljzjAwkSkUnQGRKsv4gfCgRQUfpPjKXnDM
 qU9plu3zOuUftt32X6Xyrdhb152v6jaDDDNt3l5u6b/Ju9bwPMhNS5WDtBUMFII4s77I
 I/E4PNvKkqHxOPij7lwBs7VBxU+WD5du0+miyy8wMsXAM0B2/fWYrV0/BkVWtbwN/e1o
 OcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791017243; x=1791622043;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pQw2T1b5VZgHdECEdNhvkbIF/xE1inGZNVxsVxxLhVY=;
 b=yWXBMtTIdH9ayFoU6KmQ2Q4o4F4J7hLecUeQ6LBDNiPijWzH1IL78DAhpGUmzqw7rx
 MwQmtX4exOFp7Zi8S1n8tRX8p34Vrpkv8k3KTfqqlZdRnAfJGWYZzNO09LS6cfLONaEJ
 X6RcGrL6OsATtD+SXAESES2VyL7TiMdyxjJeLFrGPplFUWZpleXC6cjiRBEllaNlp2JR
 pfT8z2gddJE2k7tye8jBL4WRsttS4ybywiV43W4ZDltHVNYWSYPqrL6JcPGjL9fYPc1Q
 mjqeckpRMFOL4EsODo1pUi+pYtEjvpvV9tvLBXAe0iT0KF9v3peZu9xXEkb6wEGvpWY6
 wadQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX3QtkvjZUnaR18sajK6Ob1AosL7OuzrTQPWhb7Wp9IXrLe+ovmoNc+tLN/+jN8e67ceF47JbQ8sFl@nongnu.org
X-Gm-Message-State: AFuF++nmdf+CWzxc2LeuBImF0so9f1/wmNACH7QiMf8IBLY4JLTjEiwt
 edJfmexl7NbCEq1QnNJTmgzsW26sYDPbl2LTdz8YkMy9UlShPw3Ku7QM2JXzlRdp6rQ=
X-Gm-Gg: AYBFou3ZUI+di/0IEFJfZloh0CFhq2KCTUMyQbRAmFvpgi5p43nuHd5zLDTZGuchsIl
 adEQdGwqdAhiqXeUVQVVByx32b+yCsbABaIRReSHtDh0Hk3SiNX15D5Hp739dSLIOVRJNXFhnlL
 Q7+80JBN77aD0iwQu2gI0pwlan9RTzFaaOoINX9jJGDCX2aUqEUtFgu3+n59WY3Fkz7oea1L6Vx
 UH6oNV9326j3742Xf5/itK0KU1kQs4+YIhpA8/ZjmtfVEtp6IqgURc03+Z/5cE3RqCO2i3oARZe
 6MvkbiOVwzNDgsKO7kqGoSqH7OGu6PVCTYrFCfIYWZYIJgKvDcDQYQbWd+TRn9fALNC8bH8DIU0
 SExk3TMPhOq/zB11r7T9oR4V5HQsFz39z0yQRE0TBRzcmx95UOLGE/0FEFq29zOi5Bht4l+9kDh
 gmDwSVn8nmKzGsdirpR+4sxmt7mXyyjRGf9CyPA1Hc4p8LY+pYyHxGwm/3gKi5Qqdjz2u4pkKlk
 6ZUsNVpgx9LeTmz52RrU2J81Hf+qTfHQLL6UE3DiQ==
X-Received: by 2002:a05:600c:1f82:b0:4a1:6c79:fd31 with SMTP id
 5b1f17b1804b1-4a16c79fe9fmr1949215e9.12.1791017242945; 
 Sat, 03 Oct 2026 01:47:22 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02770e8f2sm133454075e9.6.2026.10.03.01.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 01:47:22 -0700 (PDT)
Message-ID: <36bfd058-d8cf-480f-b873-ba805aaa6ad7@linaro.org>
Date: Sat, 3 Oct 2026 10:47:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/27] tcg tests 20261001
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 stefanha@redhat.com
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/1/26 19:51, Pierrick Bouvier wrote:
> The following changes since commit f7ada39edacaa5c26b30e98b94017b0b2ccbcf94:
> 
>    Merge tag 's390x-20260930' ofhttps://gitlab.com/efarman/qemu into staging (2026-09-30 16:44:59 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/tcg_tests-20261001
> 
> for you to fetch changes up to 2df2d063080a654d7e32ece10efe38f60b7fc900:
> 
>    tests/tcg/multiarch: add missing test_pnew_jump_loads.c test (2026-10-01 17:51:07 +0000)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v3 00/24] tcg/tests: integrate rest of mips tests (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20260929212439.110454-1- 
> pierrick.bouvier@oss.qualcomm.com
> - [PATCH 0/3] tests/tcg: add missing tests after meson transition (Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>)
>    Link:https://lore.kernel.org/qemu-devel/20261001163751.172720-1- 
> pierrick.bouvier@oss.qualcomm.com

Applied, thanks.

r~

