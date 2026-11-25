Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0A60A2604
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aDEFJV8B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWB4a-0004M2-Fv; Wed, 25 Nov 2026 06:22:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWB4X-0004KG-Qx
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:21:58 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWB4V-0006ov-UP
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:21:57 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67daffde88dso3315864d50.2
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:21:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795605713; cv=none;
 d=google.com; s=arc-20260327;
 b=cHmAxMEVXVV+7qDNTKB50BjWheKusTVhi6R8Zo7zkFQ3P/p/1D3JEbzYr1nwy0v33k
 IQQjbfwuNQGbIBf7AF70sFyh7mogywnHSsO9w7CT9ulyhm97Y4BEBs9AWTs6pdRHRV/0
 /LlCw0gdbqAI9/c9DhIXTsXrwb9YaQrLGWSWOTdT9RSNtpsaE2Z2L1Fmu3qeXH6eCRdh
 ajXFUwvRTd/S3UsghYvOtaIcymxvNHJDEHwbg3nuZbHXUxQW7OUdBYRja7QNUSRyfrHq
 CO/lV+OfLrLew/mwvN0njqEL0vGZunWezw2qTGsosgVAVLb0kFuJvi+CwYkr9aplq3fw
 yg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cUM8uitpr15Uzqwb4irgdb0pVfnb+G6u6KZPdPZlqE4=;
 fh=6CE8jxAqEF526HSqlaLPR86Lv+HXvioeH5JzMC05K3U=;
 b=anNXpPPNCYRSA9N0n8Pv9VBXXTveehEque0qF8HCyRoKScXbU3IHC96EkRlW/qghAO
 wqgyvgEo5HKR0Mh0oHF1PWifBjr3iCqUsmz161hWx58ZpPQdoTJqjcQy2dUX3caBZ8Zc
 LuRHHwA3/UWVA8W9UFimeS46XBxQ/R1GpQiN2ReIsTscsFQTdwmQQfDR8AQYJl9dVMVI
 xDaIGeTaID4TqAuPTUbN8PKtr7KurmWSlcxOmqoRrxYspqQygKUViVW4sj5yH+7++q6G
 +WTAepkRtNyANSTQVOyUil4XQPHHHFLpGtTkOfe50AfPTSqyfZd2xvhN71rAbpstxL1r
 pgFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795605713; x=1796210513; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cUM8uitpr15Uzqwb4irgdb0pVfnb+G6u6KZPdPZlqE4=;
 b=aDEFJV8B0NJpb/JDj0KZzcC0Q3aBCU0wV00WzNe33iI6tFaqiB69ppsndczoQsb6i2
 Q2nJTPxolLFiewajLpLTHpy9yxORt12TSv1+Ve+SHptlPl+/pV+APtPPkKYP8mYW60G5
 uVLaHbAV09Kj+eaoI1Lss2qjwgAhnbh1ZnUytVUEUa7Uk6aJHovdHR8+avVstykU2jGa
 pIuSJ1fC63mqtFQNVnySR0UnELOys6VZK06HX8W4Abp4vOoQcmdaLwurTEWrKbVN6VBH
 mgoRZpZo4qDzVMNwOqoJUyD9Hy2aoOmR8a6JH0IQBNjW1X1ViXlchcu6fC4l1IkUJLSQ
 7xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605713; x=1796210513;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cUM8uitpr15Uzqwb4irgdb0pVfnb+G6u6KZPdPZlqE4=;
 b=f89mmYFNbJOE2SVQ/dfelNWac07riHkYkk2OsPfhTIdDQFHQrOJTv0gvnt9K7jEXEE
 X7JOIYZyRTRwfyZf15Rt3twHoJWujUv9N1t9lSA4VMF8kpuiP5+MX+Iv2zOD7AMsmFQg
 A5Ntq6i4xGCBS3qt/95zAmNaSLEPQkfrDs7pEunYnkoivYZswj0vmNRNrhDsJDvnaLCL
 uxhJXaYqSx9MNL8oiy+b0ymo7AKhNjE2r4O2bN3XVbG/c6q1YKcvvTHGtytSF7hSd7XL
 rPTvyIQnRUm80mnWkY6XXTr3x8upNOVjuQfS+qBvqvCneEtJBK/Wd9w/RkLS+fHWluye
 mGRA==
X-Gm-Message-State: APuU4Z9qJsJog3E6QLWL6ev1pw1uVzHVDQkwzA3wTp/5biJvqUppTGDv
 CO1FxmqTnvLqmG9wwRpIgB8HPYgE2YnPc1nuE4WohRbb1SdNmga4MjhxWO50YmDtjDyl7gDp4i/
 D/nS99AudXZozK9/aVGPS/25ogr6sTYUTj+qfPAZXbw==
X-Gm-Gg: AZFdTZe+dgf4zNyZGQbr/zr4Yu83bnlbeoRzrvcwDU6ik9t+CzHm5qu9E9njeAsZYBN
 RkbOxMzaw2WvXujauzO7SeGSiGHJaDX21ygpJYzhkV4UzZ+mcp6XxeAwXK9KwNrtCQr4+XLpywc
 oXHhLNLG9Vsi5buMrEVbVUuxYzlkcN2MUcwcACtsFiMuyHz6cH54bglHZHtsW6+UsNCRCZAyCDb
 jsIJ72IaxOKGlN+3IJogHiJIv9MMXLSKvOoUmzzvMrjVA3Deqew6Xad0qL10HF8cKDD4WE3xsxm
 gXsmwU+Fe6KUtbsCcDFy9ULRFAp66WPxY1xtaOqYuoqcifEempD+ZzVUrNUV/ZV5izt/l2yPJur
 DHBxrUMHPOt31mWHgIOO43iyBSjlMpCHHsOAYkJ/bNZ7BzCrcxvSALimLn3Xvbq3RUcO+lXrPX8
 4fwM+yBLpE2Hajjzg98vgu
X-Received: by 2002:a05:690e:130b:b0:67d:e97e:326b with SMTP id
 956f58d0204a3-67df450e151mr5342581d50.141.1795605712902; Wed, 25 Nov 2026
 03:21:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
In-Reply-To: <20261124-4729-out-of-bounds-rx-interrupt-idx-v2-0-cd18eec4f369@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Nov 2026 11:21:40 +0000
X-Gm-Features: Aa3M54oibanxCJ0y2HIbyk67mjs_Y_oWT34PYXjR0dDtYnJn9emKp5zwEsAu7R8
Message-ID: <CAFEAcA-XVU5gVxX+DFXLknRKfEus_Rxi2j2q-CKatOXz-XiymQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/net: handling 0 RX queues
To: Andrew Nguyen <xmphyr@gmail.com>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 at 04:35, Andrew Nguyen <xmphyr@gmail.com> wrote:
>
> This is a resolution for issue #4729:
> https://gitlab.com/qemu-project/qemu/-/work_items/4729. The issue is that
> a VMXNET3 configuration with 0 RX queues is loaded. When one of these RX
> queues is accessed anyway, say, rxq_descr[0], it could have an invalid
> interrupt index that was never validated in the first place.
>
> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
> ---
> From reading some support articles, I think that there has to be at least
> one of each queue. Unless receive side scaling (RSS) is enabled, then the
> minimum is the number of vCPUs. Not quite sure how to interpret this, so
> I went with always no RSS. Another note is that if RSS is enabled, 0 seems
> to be an acceptable number that gets interpretted as the number of vCPUs.
>
> https://knowledge.broadcom.com/external/article/322369/rss-and-multiqueue-support-in-linux-driv.html
> https://knowledge.broadcom.com/external/article?legacyId=2061598

These are talking about the guest driver, not about the underlying
hardware. If you look at for instance the Linux driver in the kernel
in drivers/net/vmxnet3/vmxnet3_drv.c you can see it implementing the
"set min to number of CPUs" logic:

#ifdef VMXNET3_RSS
        if (enable_mq)
                num_rx_queues = min(VMXNET3_DEVICE_MAX_RX_QUEUES,
                                    (int)num_online_cpus());
        else
#endif
                num_rx_queues = 1;

But the hardware doesn't care -- it just sees that the driver
sets its num_rx_queues value to whatever the driver calculated.
Similarly statements about "default 0 means pick based on number
of CPUs" mean that the driver software handles that as a special
case when deciding how many queues to ask for.

As far as I can see RSS is another way to say "the driver
asks for more than one receive queue".

thanks
-- PMM

