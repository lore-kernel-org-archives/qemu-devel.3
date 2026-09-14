Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620A5C88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x631f-0007E4-6t; Mon, 14 Sep 2026 05:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x631O-00076C-Dx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:30:43 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x631I-0008SH-FD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:30:39 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 956f58d0204a3-66e4ab201ebso1365107d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378235; cv=none;
 d=google.com; s=arc-20260327;
 b=ANg+GhTotN/D76oWG1VPFlPhBSbC2v6PwXSP+Vm54/s3oqomB2v296B+Q7zm52l/cn
 mhZYEKLUoPjDoUB6qKih15gQ60+CMUppOPOOWfKMTSaMsBOI9XnYJxWRt4IA66rDz5Fv
 5F8zqa2j9v569aQFNqMQMyrP+FyKUZ0bA8fKkpO9MmEow7ZnM3hsYEtStULnqBt+HucK
 sSjX08Z7r1HoV5oXNV/vi2P7Ttl2m+GktPeJNnM8hfMLQ26U0hK0h46gnIuAGbP+yeMA
 bOkggjLW944W/onvu6kuB3pYWLX4DomWmT5jXX0puFMvs5ByQgNB0chAeTRdVNoGHcU8
 /lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ew9no8+Y7PRBFP2f9K+xoVfYPxAG+Y+oNU3+6I6EBOA=;
 fh=93HLbJa9iq6lTDR1rOyxngzxrh10DLOGyTGVfC4nHNg=;
 b=h5Pk3CGQjhtAXjXE2VL+0ZMxHpVB8xIjfcwSkT+RJYbcEVNf9Sa1J19xcZNKJqkTDr
 X7ytEhyYYYncCpOhT6GUs6ZWLogwcbkVl+lTK1YRnC7pzwWEfdtYZJIlb+jfvxcElxev
 q95vMQNl7wZgDkXvsyjHq5j18ACV4Hd9OclMKBH0D7pr8xEsbekKO/1PBagcq4aQYMJ4
 x+WmGqri/iOZUAOOb1aCLh8KTNUu5rkuSbL9v76p3Zhf9azUuHWv8flEVCAa8eIjAcqP
 ixhvTGspd9XTslKHkAVgwtNZk5vopHHmwk5t3+p9nQ2IjwFs6lSsGdBozfPF1Hmeke0t
 XrQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789378235; x=1789983035; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ew9no8+Y7PRBFP2f9K+xoVfYPxAG+Y+oNU3+6I6EBOA=;
 b=WMeYV9KVAYy8hX9lrTnS2tGCoq8Gkzievynjz/PyvNaX9oGEW1MutIX+TQvi0uJQAT
 NJT/mOJcnNGUaK32F32EIz7v0uucWtybofJc1Ry9qywELZOW8Z5VoUUPD7Cat5ur0+WX
 Rlup2ZWwGemHK1ShrA6ey+5Uxt18f43Nvum8TwqzLlozUGIX7jbIqMv6TKTB+nph47LW
 w77gQHCETMitr7hffVlc5eF7LxHgEC5vADJb0hMMsMrpiSz/x+1ip8yRkLANminFCS9e
 j7swmhizGzP61H3ulG8d9L50KcyBmIBNJGQtskJxOuWAbkmFR3kYfW/u17wYHxWHsq+r
 BBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789378235; x=1789983035;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ew9no8+Y7PRBFP2f9K+xoVfYPxAG+Y+oNU3+6I6EBOA=;
 b=Ei3Qy+CF/S9z14G2U/Rkgh2ZzsLxM2E/nlT66xAO0ORk+/gog1IWveIeMFplHTCIqI
 Hvr7Je1i8NkpmT2YrAt0N5UnmzE99GxNVWpZoDaBH7HSeq1K6mEBOst6hpz/Z1WTZqJi
 23GFzjXxOrxWMzAWfZTdSIlWXVjL88MFsAY+hby4Habd7sBbYdyeW+H6ztX7rYeRl+ra
 1wWsGQx8uCMT9w3d/ZtpAs9J/yoNSO1K7fewkgEv+o6uSHrzvHE4XmLP4L3nQyDB7GXB
 RYTMSS9diNZGiQgda5BX2FTG9IXAKZ8FtAEZWO3BdUNtQMFGn8YTUzyowi+L8rhTD1LQ
 V+AQ==
X-Gm-Message-State: AFuF++l2Gd/valT/RQ7LbCSdYn8aAJ5F94wsaEVGSAnk2bhOgN+XUd7i
 pH7x854q+oSz0MCupcUo+CgcuciNjGeWNpu36XR3ELsQW6Glh0lS23NLm876apYXpbwipWbEb1k
 TDz7vyCs8Lktvfp+qMSkFGokWlHqat+rIVIV5i8vY6Q==
X-Gm-Gg: AYBFou02NtgS0Nf8ksIruFwpXHRmFrJmoJRO3+5JeWfl3x4jaRmnnA4vDJp1vBt1GMp
 xYHt1EvoT0wtpbgTX8+sOfIfwu/K7YLEG5e+CUFPXfniK2QPUVE7sXHN0+zBsEGqre7W0ihnGC2
 l7upPVhw14lPK7UIgYLzXYTm/ZBiyj/MCTVrI/7ubAUgFjp7M7VJ64+O4xl5c5fCadKS9CCr1a/
 iJ/3udrr0ewFKng+kLqenx7nywSGrmvgbkfWkehdUV4uU43jmW94gRRIa9o+3i/XOHERkgt23mA
 9ZZBqNbNbjl8Tw5Fo3jq9Hy6sOsSweIZG3HniUpWglnwlhjdSgptZkilMpN7z7mo+wdGMYQUHiP
 c6Y1TNdOUZIfKOTFbpI18L7uk+XHtLTFMSiOAZco=
X-Received: by 2002:a05:690e:ec7:b0:66f:c1bc:880c with SMTP id
 956f58d0204a3-6714e1c88admr182974d50.101.1789378234982; Mon, 14 Sep 2026
 02:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260910175001.76278-1-thuth@redhat.com>
In-Reply-To: <20260910175001.76278-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 10:30:22 +0100
X-Gm-Features: AcwNN1VlWzPMcYhngrbB8b6xtasH5I6EofU4KQjbsMaO3dyz_T-W4ZytMkEFy0k
Message-ID: <CAFEAcA-dkLYr5GmqScLcuk+iErdKCMYrPJmEPXo7=+uV+Oe6GQ@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/bcm2835_powermgt: Free timer during finalize to
 avoid memory leak
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Thu, 10 Sept 2026 at 18:50, Thomas Huth <thuth@redhat.com> wrote:
>
> When running e.g. the device-introspect-test with valgrind, there are
> reports that the code in bcm2835_powermgt.c leaks memory like this:
>
>   48 bytes in 1 blocks are definitely lost in loss record 2,090 of 4,315
>      at 0x6B4B62B: calloc (vg_replace_malloc.c:1616)
>      by 0x7AFF6E1: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.8800.3)
>      by 0x42B1E48: timer_new_full (timer.h:520)
>      by 0x42B1E48: timer_new (timer.h:543)
>      by 0x42B1E48: timer_new_ns (timer.h:563)
>      by 0x42B1E48: bcm2835_powermgt_init (bcm2835_powermgt.c:151)
>      by 0x48632E3: object_init_with_type (object.c:426)
>      by 0x48632E3: object_initialize_with_type (object.c:508)
>      by 0x48636BE: object_new_with_type (object.c:706)
>      by 0x4962FF1: qmp_device_list_properties (qom-qmp-cmds.c:206)
>      by 0x44ACB90: qdev_device_help (qdev-monitor.c:315)
>      by 0x44AE14E: hmp_device_add (qdev-monitor.c:1018)
>
> Free the timer during finalize() to avoid this problem.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

