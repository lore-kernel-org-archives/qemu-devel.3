Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEB2C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 23:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz0Gz-00011O-As; Tue, 25 Aug 2026 19:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wz0Gx-00010t-U9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 19:09:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wz0Gw-0006w8-Dm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 19:09:39 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc1c0b0ca99so30182a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 16:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787699377; x=1788304177; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LGpGWkrr+UvtG5G4M7bpanyGIs0Vf6SsX0a7xDso4IQ=;
 b=Gi0dEzRxVgCKC2LYTkHdyLmUi6QWxwZ8OipEnJZaVpEunMgXnWBkgmSDwDQfhiSIR7
 eQ2gjUgewiymCN0/Isbi1EAxmCaUqpzyRiQB7L43Vqi6IvG9WrgxeXdGAZPCSEXqiKCE
 AGnuRO40deOIXlsZB0yaW4c7fxvKBtTsiTjCZMg0AuXc0+7D0HVYHIVczqFzsvKngYbu
 yItXC7QGTZDX1O+ULuj4Hf8W4Wik0JRa5U28vK4cGUrtkh7sHnHuSUfEzUmcskcyTYYV
 ML5D94s3m2+hrvtbWT63WjB4T6HtK0F4b6bDJInG7NHdIIuTalhcPGRv/MFOGsFwO/m9
 IUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787699377; x=1788304177;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LGpGWkrr+UvtG5G4M7bpanyGIs0Vf6SsX0a7xDso4IQ=;
 b=pjQ7wBBdkidi/rEpSanVcPgTar0DV9DQP2JmQ6SDw+9A9UOZl3e7Hlfzs7Rk6q5/Ig
 RAbyDBv5J+WFUyc3dZ9BaWRb4ouGrwbQ7iakwP2QVQsIz5dQrvgfOQewuC+wH43lDsoR
 al0uaV+ykVNxXDeM2UCrTR+Fb9iMvsl9fvOKsxoO8mJ8mZwZpBe0gOG8GYsDKAVmxUy1
 C9necOjhJP9LkG/00mhHLBK/h3zrT5CdrtVKuz+3k6eScl4X87jwfTNIrngJqXp/9Gdx
 86FnMlWQVEE9VNzFpkXas2jDypkxedHzbTGeJVhTHKkh+qY5tCZldzSl+sMIZo+iBIEM
 Ag+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0MeBQjfxC/nTRVRDrl36UQZW80datTN/SajbisCYZ/qCeR/zGHdK7gicEFzMwvKww2rL30lSYXmgk@nongnu.org
X-Gm-Message-State: AFuF++nU8xbYwwevR4iNFuRgcLntcFuOikxDC6OwXkEW62JdYyGFbGSM
 tLbEtq9+f4CML1KOdkp8ioVxmGknYZVstZtqZtvf+Vp70dwQ9CHJVEOJqpaC38n/A98=
X-Gm-Gg: AR+sD10N6NXoXXBjGLKb5MUM85y8GVP5x3+B43yuvVTQEuLcY/jUtZ3iMxz5FwfLV7D
 P6gtPc+JewMH3TwGFe2GnBS3zcBXRbMQIozNuhvIU/3dFP0HXHLFnjB0e5h2vpiI0T3mDZ70o7f
 SGti3eMuR30yBtl6kyV1pH6I+kMDRC5pXJyddck1CKfFPlJiroE9BC8u6RYgDus0dzb1oJqo22L
 o47t9LG24H0bCeIfHgCIiqM46rK3PWNUkcyGZIXGLQ0qzppnz7+TD/RnIcO93FJq96VjVhJL8/G
 z9Aa0XbA2IMnrgYPncg5r5fxCoR35XrFy9piHHNEIjvEsOD5znDzu7EugK+MQiJ/FaOsCQtma42
 IjFmsHGS12oWH4Cq1ofImNsxk8NBSKBSoeOV3MpadqfdicZ74/4akYagbE+n2e8qkqqAkhK8JFy
 5bbnfgwny8ohQV+IWq0Q0TP+mMJoTZP9s487jdz/nJAdR2pqeP6VK9Eqf7DSsulsfb6PNquAxlN
 XZaCLwyd9XHn6L9P8+4N0jXbC0d
X-Received: by 2002:a05:6a20:a127:b0:3c3:b57b:6291 with SMTP id
 adf61e73a8af0-3cf85b7f957mr3191360637.18.1787699376693; 
 Tue, 25 Aug 2026 16:09:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1beb0f15dsm237931a12.9.2026.08.25.16.09.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 16:09:35 -0700 (PDT)
Message-ID: <ac062e71-4d09-48fa-b42f-b7d40487a1b2@linaro.org>
Date: Tue, 25 Aug 2026 16:09:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] target/i386/tcg: do not reuse cc_srcT
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260825122921.431739-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 8/25/26 05:29, Paolo Bonzini wrote:

> Use a different temporary for every instruction that uses it in the
> translation block.
>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c |  6 ++++--
>   target/i386/tcg/emit.c.inc  | 11 +++++++----
>   2 files changed, 11 insertions(+), 6 deletions(-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

