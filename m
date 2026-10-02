Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A95BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 06:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCWuU-0000g1-WD; Fri, 02 Oct 2026 02:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCWuQ-0000fn-FR
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:38:18 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCWuO-0005c7-Tv
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 02:38:18 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48882c1f2baso2584773f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 23:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790923094; x=1791527894; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gtw8+5u0anRjjeaG+vf+hoDG4KDTZES/9+LPyr0KXLw=;
 b=DCTCCYnFR4yYjOpSqMnb3usPfIchNPAyhg7Y3p5f7N9V/JCWUnEP3wKe3nn6lRQMC2
 nQAj7qWbLAvhPIYrKe/36viwlRQMlBn/kkfIpe9ZPl0RciRiYHtp3V2nYS3RSULJMk5P
 K/gUOiudM8BLkpbUxamHUxMlSLG3FcvMzxnzIkfWpLndPUCVWN2xW/rXICSDBpGRaBaP
 ovHFkqkZ95wAuU5K16MiPI+8Lug8fqRn/e1MjovtNZvScMGbA/WShQdnICsdIfed9bMp
 bMalSbQcRZBpQUjL+X8iHRTJtVkAZzHBkOPeKWbQ+vlENcBlMS7nSQobjw1lchlCuliq
 5XFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790923094; x=1791527894;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gtw8+5u0anRjjeaG+vf+hoDG4KDTZES/9+LPyr0KXLw=;
 b=MBn0rAYo+CWQo+eE9r14k5EuogRdxA2GCgt5ZAGNYL+xr7IHSRZSWvn1qKnOxRz5NS
 gryzT0vA2sTlf4ed+9ebJ6xj9uXZfguAnTy8DxCEAJfVF7Zo483odOvTq/5sutTPUGKG
 +xz/p0YifU3hFrfVBW/H6kvwhUCFXSLyceeS55aoYeKwaLxnPi+f5XvXKi7QGBzqS3AB
 E1Q3Johew6j/PDHGCSFk1KkJM9essFpMedttDfPvzPP8g9Wp0w4+ySplidZsRjXhLpgI
 Ok9aDvxUo6Lc3fXgRwOF1+QJb4QCBCaKfqyEc9O+OmyZxAfEboV0dlHhIrQheaWo0zmt
 YmJQ==
X-Gm-Message-State: AFq9FYIVZ+L5KKmfBlIiS99HrGQmFRWP6XCAAHdthntcdP+TJBXbJcH9
 hI+cBARmjJdVDC+jKHSK/l/JP8mTYCIgT0d4cNpzy7l/z5pgeYtTEn4I2p2iWR+dlRAVwDgv+py
 Mtwm6LxHsvA==
X-Gm-Gg: AYBFou22uoJTE8EiN1ryUCNlCkRVRUbyK7JO5w18kfGWigtFSPEh28YqoS6VDu/vG5z
 D8we+HmpopPELubhkqVMq2zGq54Ze1TlfBHZ1HlMN6bkmkIYjAHi8GnchQnIFYZQmAViZs0BA0T
 R/9i6EnF68qJtDkH0LO5loYUpqJj73Ych1Ax5jlfO9S6vSnyAZynluOy/Fo6YT1A0HKrLwA0UHo
 YkMykOofXjkR8mJRtLi5Pm8zLAoNAYTd6v9BFn8BPzsJCzkrMxfBEmV6MGivliGfzhE7O8EN7mt
 sbtclvH+VAMnrpjL+AtL5v9giLaKcVXtu7r2ZA3nuSQsy6xyl63loIULLY8DUfoinhVNmDv0dwx
 KYOlR+OBfOiL1CQGXXg6J5dtbj19qI5Z02PHJOuh7pyqMncnnFibxUXzA5mOXva1I8df+WEeRWg
 z+YVP+owiPdPvudlrTsuqVgQtQ6qjGpTrEUw9jWG4FziVktPYJdZqNKzfKwNAzuKIKfWh0eioKV
 yRRxftIuuhAwk5q/CwXBEmz7WetJrfhVTTMNuEvPg==
X-Received: by 2002:a05:6000:178f:b0:488:8436:b343 with SMTP id
 ffacd0b85a97d-48b1271aa6fmr3032844f8f.37.1790923094547; 
 Thu, 01 Oct 2026 23:38:14 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b382f8c4asm3405605f8f.37.2026.10.01.23.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 23:38:14 -0700 (PDT)
Message-ID: <6482f36e-8f4e-49dc-aaac-09e91d433fd4@linaro.org>
Date: Fri, 2 Oct 2026 08:38:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 083/101] tcg: Generic expansion of tcg_gen_muls2_*
To: Matt Turner <mattst88@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-84-richard.henderson@linaro.org>
 <CAEdQ38E0yKH8bzDYmL2X29RXt4gmGLp_1e=ij5Z+FKBcp9FpaQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAEdQ38E0yKH8bzDYmL2X29RXt4gmGLp_1e=ij5Z+FKBcp9FpaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr2-x0f.google.com
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

On 9/30/26 01:42, Matt Turner wrote:
>> +void tcg_gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
>> +                   TCGTemp *src1, TCGTemp *src2)
>> +{
>> +    if (tcg_op_supported(INDEX_op_muls2, type, 0)) {
>> +        tcg_gen_op_tttt(INDEX_op_muls2, type, rl, rh, src1, src2);
>> +    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
>> +        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
>> +
>> +        tcg_gen_mul(type, t, src1, src2);
>> +        tcg_gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
>> +        tcg_gen_mov(type, rl, t);
>> +    } else if (type == TCG_TYPE_I32) {
>> +        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
>> +        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
> 
> ... and these need to be TCG_TYPE_I64 I think?

Good eyes.

While we still officially support hosts that require this path, I don't 
have one for testing.  :-/


r~

