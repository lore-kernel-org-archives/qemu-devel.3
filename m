Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24506C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Pm-0002g1-2L; Tue, 07 Jul 2026 13:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9Pc-0002cx-9q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:16:51 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9Pa-0006dG-5S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:16:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so955858b3a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783444604; x=1784049404; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g7yuDgj/3g4/vpl+J5M+UfjVI0/6p6dT18g0UbjtQuQ=;
 b=sIEARYUD5CM976MUoiItvz8FXjucx3STjwD1HfpPKwCA6Cm6fYSlLUiTy5m3ZTXhko
 SctNG9EG07JLb57plIEZe+F45XTyN7LOLtXONCkLupA1JiE5EIPCD9TBKFfz5AyYO899
 x4WiEPx8/WvEwdKSMd8/MFR45pbNAx8w0oc9DIWZl7rN0tQAc53/iYfSrr8TVP36ngAM
 sg+UQ3x5l/qDIDTnSbUmuKTIBDkZRQ+U3ThnB6tUAFqnw5rl7Ykg8d02eH62UCmpm85i
 cfIODoBYOfqfyrYVRGDa4tMsaNRAR0prqBj0PMaJe7QMGhdehDnC8uBUbdGNdEmdt+Pc
 JQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783444604; x=1784049404;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g7yuDgj/3g4/vpl+J5M+UfjVI0/6p6dT18g0UbjtQuQ=;
 b=Y+aMRMfZ0IGLCLCq59o02zWHtEjZ+EM5SkW2SujKeOR6vLFVbrWACjCApety0N9yHd
 ca5/JvrcHokJmjEMHonzFsAGA7WWs18rVAG/gx6cTvoeLoIZa+MaIOBGnCV5FeYUIE8O
 rKqvkf9EhLNgRhUl7wQq329yx4msK3/b6cyYNV3rmgug/baYwnK8wOyZFy02Slt1Sb4H
 MQfSsIS2m+NWYBXaiE83JlNDc8mRq5Jubopg8MLGnS7ovPfB1DA9zjagprJf/zmo708h
 tUBXjLxTTGtc5ewcevmxLra4JJzXIpxxG3isWHa/2yN8OU8q8ODfDNhFo1srpOcIar0k
 X3lQ==
X-Gm-Message-State: AOJu0YxtP3sZw9vmUgl0qAv4izXU1zw5fUz2Yl2HQAd5Q7+73IW6cQ52
 ISC2DhlUIrYLuh6bpK57KKYuSyBiS/+i56LirDNya+wHl0QsFvG/JSKc557N46+jJlmHusTHBNW
 IMmPK
X-Gm-Gg: AfdE7ck3chYcWQXvp5259WsR7Yx9llvybSJ26LXZND+XRDvg9yBhmZhnWtSnhXPRE+E
 V8PQXKJGMVrTmDFJWtYSoJ6dEcN6hKzsocd/0eFwVPyae0D+JSqmDfsspIj17+oh+sHhnxNRtev
 R4br9TiI7Y1iAXW5w0UyEOy7Ylv036Ik8V/htJGEP+RPa+wfL+SvicCGXKAtzcZo8Dbh0TNULRt
 Ko+pFU5y/fVEs7rtXOM8BfYoAeeDSmaT1mvwe2hG4r+DPWy8H8mwd+i5PlsIyZ2C8Z6J6nHZ5dY
 7Yhb51IsA0aOjokmhA8kHfRrtZ/hzFTsNZlEkYLsJnvBtgl6rEXDoh5/dk5xlYzzO+l07S5l5y3
 4ekW5Mxd+0oeb3ZggetJRpUkMjJBnAe1yjsKPR0TrFjTuVExZmn74xDACOc208kFh35Gkwtvlq7
 nWnMLfijDvyQFSQ3MWgRsKFbxQsSnZRlJhSLWhpj+pkSuexGxVvnAmE3W3vH+RtAfMmA==
X-Received: by 2002:a05:6a00:a256:b0:848:2f74:d8d8 with SMTP id
 d2e1a72fcca58-8482f74dc4bmr3419535b3a.73.1783444603548; 
 Tue, 07 Jul 2026 10:16:43 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3b25204sm1328495a12.28.2026.07.07.10.16.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:16:43 -0700 (PDT)
Message-ID: <c7227be9-7294-4dc9-a4ba-94f5bd7fc648@linaro.org>
Date: Tue, 7 Jul 2026 10:16:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/sparc: remove unused helper_debug
To: qemu-devel@nongnu.org
References: <20260706105948.740881-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260706105948.740881-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 7/6/26 03:59, Alex Bennée wrote:
> A long time ago we used to check for breakpoints within the target
> loops. Since b5cf7428416 (accel/tcg: Remove
> TranslatorOps.breakpoint_check) this is not longer required. Remove
> the old helper.
> 
> Fixes: b5cf7428416 (accel/tcg: Remove TranslatorOps.breakpoint_check)
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/sparc/helper.h | 1 -
>   target/sparc/helper.c | 8 --------
>   2 files changed, 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

