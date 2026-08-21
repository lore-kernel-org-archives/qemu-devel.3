Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256EAC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 10:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxMBe-0000I3-TS; Fri, 21 Aug 2026 06:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxMBd-0000Gw-HB
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:09:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wxMBb-0007zu-Ul
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 06:09:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so514324f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787306958; x=1787911758; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g/gdBmzu33681/PYHYRHRIGnDaHKhvM1Or/mJzAjaYk=;
 b=VRyE7Uufl8o4ZtrWEEZ92+Or8Wc367Vm6VBMzjeFxlPeLtvqD7kkm8vHykDWPXtXFi
 JD0dRm2hjbhaUt63jlD/FX8Vr2jRhAS/bL4RsLg++3+Qu82D98Czn3lsqSVo1P6j14xE
 3jclJg5pOPm/7UvY/1xXH6kqBvB4RSaccfkEuydmkUtYTDk26Scp2wX2vvnzp7aERDqW
 14fTPe089L9lo+go8P+c9q0z6I2OZw41/M9oSHIMNS+lvBgYlS6fGqmBpb/zF0WvyOSb
 MYuGNmKnb5yEEowWW/9j6bkpRB8jklu4bmr54QJcxK4wdRrIDAKd0zKfTo24SDUxCjld
 kuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787306958; x=1787911758;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/gdBmzu33681/PYHYRHRIGnDaHKhvM1Or/mJzAjaYk=;
 b=ouok0l8I5Zgyz0Y5n5hGvhNSUfT4EWEjeAR124FvMHjOwJjcol+TsHYEk729Hife4v
 ul2KesdPlVfLLy9qOEAY7X1mKkG1NetuoQu1XKTTg2rBaiVdi7QlF+agqN7Uh6YZuITh
 WSqPiU2fpmSd6Nm+0hSUclV2TV31rv9t+o4+RqU8jK7byhf3y5GPDNKhrwdgUOdTucrq
 jPgZpZhP7pxbI9Zhb71xGp1f+9YovYwMgQ4nrQd/t98Jvybbg6vwY/gGQb4/VJKB/HaQ
 t9EUXXplzpzpDgHCB3eFbDf/2exnXWDdj48Dch4PnQidpmHIHvNNbIHq6JRxsNbS00dy
 k3XQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzlxId0sVieKZzrFPWcB8sHVUXeB7r5xuVmy7ArxH3Wi8nnXSTsaL/tKtlg2tsWl+FWN/I9o2JkU4o@nongnu.org
X-Gm-Message-State: AOJu0Yw+bqmive6mPc6zsZKBwT4t47bVvEwgPbJQ/NjYXUvk1SLMCnpy
 oVXiLsf8M42Oy6DZ78u6mmZhT6k/ZF8htAsyxHLU8RL9MH/qBu8I71b+p+BuCk8KAS0=
X-Gm-Gg: AR+sD10svm3AqQEoYi6cP99CJH8+kAVlY5GKTUav83fQvlJygITE7H3SWb63kGjh88+
 aJaaXrLJsRAtU+8ESzcoUdD4l9EgoBh+qYC2EmmFNePLuTKegbNyjulPlE5EZ6A68Rxx4vLfm0/
 nCjT44tulBr39npxR8EWVYrisvf77D4H8cuuO6RKCLgBViMAlLchSqhoDFVaA1p1JEBLAxqAQRj
 y/qkq4dBIMT3FQOdrja51ap2TmL0NJKnzswzO63m/KKoBPWt5Ff8btOudF7n/4CoKwRb2cy8BBX
 fQvHIsOb+Eq4sjzF8QQOiRs1hdeqnNhtWnRC9sPd2xcn4yQasd1ZBCxg+sgihT2fdpV3ZzVYwio
 UKMKzpwR1bPuHfOxX7iKmWWEyU0ctLiZX9lRx0FA/LlgE/yEfZwNfRzLHaCYvpi/jdn9LUsK3DW
 HhKcHnAiygxlPH3l2oE5aMtBWvlTZ5h3Cj3yxirZuQmoZA3k0lWPmuHBfuHgLPvag=
X-Received: by 2002:a05:600c:6089:b0:499:a6ae:20a1 with SMTP id
 5b1f17b1804b1-499b8474fdfmr83945115e9.14.1787306958006; 
 Fri, 21 Aug 2026 03:09:18 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fa47:b339:78a1:d4c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90d297esm22206405e9.2.2026.08.21.03.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 03:09:17 -0700 (PDT)
Date: Fri, 21 Aug 2026 11:09:15 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC v5 03/28] hw/arm/smmuv3: Thread SEC_SID through helper APIs
Message-ID: <aogjywAovIWoiiVO@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162410.2805113-3-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813162410.2805113-3-tangtao1634@phytium.com.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 14, 2026 at 12:24:08AM +0800, Tao Tang wrote:
> Extend the register and queue helper routines to accept an explicit
> SEC_SID argument instead of hard-coding the non-secure bank.
> 
> All existing callers are updated to pass SMMU_SEC_SID_NS, so the
> behavior remains identical. This prepares the code for handling
> additional security state banks in the future. So Non-secure state
> is the only state bank supported for now.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/3097d58e-3793-4434-8beb-2e4f4c52f772@redhat.com/
> ---
>  hw/arm/smmuv3-accel.c    |  5 +++--
>  hw/arm/smmuv3-internal.h | 21 +++++++++------------
>  hw/arm/smmuv3.c          | 15 ++++++++-------
>  3 files changed, 20 insertions(+), 21 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


