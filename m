Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C1ECD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 18:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZCGv-0003xF-6U; Mon, 15 Jun 2026 14:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCGt-0003x4-MI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:42:55 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZCGs-0003OT-8P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 14:42:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8423f236418so2026676b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781548973; x=1782153773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3aqCd9ztd0y0RyLa6Oh+4nuizkD2/OOvsZNFoiENeew=;
 b=Fse7V1UTz3pp0LQ/r/o5Olrf3eHf+A135QTApjO5WejTLZ1zySeUuO8R9zCpv/N1jC
 b/p12bwZJtRgRgERnu0wUxEwjN0miYFo6WR5zBVXxE3jCJdCM+uMKT6odr7hJywVS58P
 fr555S2q5CtbxWCZOHUId6PAc8QS/gHyfyiMoiFbMt37B5kVCVc2hA3ooNhRBJim9iCL
 kEcFG5n4JhT7XsF/OHDTRH2zhjm0uhBLsBX4ToaOt15yG1LMuXvS8V4C3w2z+fbM6gL0
 ovT+jBIcoCFqgXtQxwwYRfJGtPJgkn/PQ8oFyQhGILNHta+9M+bBNIEHcGycDYWokDuf
 7XrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781548973; x=1782153773;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3aqCd9ztd0y0RyLa6Oh+4nuizkD2/OOvsZNFoiENeew=;
 b=R6DRuV8njfDT+xo2fVskcP4MVWy7fc930JUNtnhSFBhOG7e2a4HBSsaEBXHjg//w31
 7sHQ5Gr7cLmfldNbygrI+W0no49ppLFCEKc2EJJ0uYvtYrkfOIrmqQbCjJhFaKGByWVN
 vJJQh5bTU7ycpFN86dJNNglxr3J5g87qBgc6rDCnw/3hfO+PxxOixcXT9D6Q2slK2sUE
 i0r1P0NpXB+A3GLekZcyHZkF4kZfFYMCku2tifIYx/PFDjbcMk7Y74zLAomOEWiH+YtR
 KyXfXQ8CbgcKnot7TyyPyRKNMWrpsqKfI3P53dj/pyKle8oOvW02t1e3g71ymfCVnGwF
 xr3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z8dMjFyMEYwLMyvJVpeSe8B/8JMgGDM3XPKzlm/Rj7A5HQnbf/entSh3eOSoKEqP1QekhMn19dISo@nongnu.org
X-Gm-Message-State: AOJu0YwnCMg073Rxv9caXZQqcarWM+GnIDHlBpFySoxws9t68oyTDo4U
 dlhcVrz/MrWFXybSdpD5KqIoaPIkIuMdJWN0c5b5mJUAqxoBBkyZkdbQUhqtaLrHmKU=
X-Gm-Gg: Acq92OEW9opJlufPjQLMi/cIqg8ik2Czlb832IwBDSZbJiSdihEXXABs7BAqaxNCWyJ
 O57pMKVAvIT8naMOAmBGuGd3JabJ1XQk/fOMErXoayowXlDEo8sdHpQNIJa1fWa6h2GZCGt+Zks
 bpsJRQToE4QQg82xRRNsEI9SX2IM4etL3pDE5FG+dBfRYke9rRcDAOKuIlg56zdMoS1KcnzEHjH
 kTaQWuXty3YyrVKr9e23qLP/HJzN4JPW2RSyNgonaF4LUFT5sUpL0C/0+x041nvXA75Hhki9kIO
 Ws5QcwzAWPFtaU9m5I5jL9RNtay/wpnSlznz/dK00I3eLZMS8Aqci+0RFr20er1qbyhyoo0BccO
 pvYSedEOI1KHgYkaktgL/EccrLJfR8hyC87dNuEWWaTTKsIkLxJtc8XR72go82acEZ4gn6oAbIk
 V/ma6T8NIvop2rDSL2/aKB63Z2Z9sLrMwHQAkz2yoRTKqP6OXf8Ttksg2a9rsYi5pjQUHuAvjHR
 7fGXdo=
X-Received: by 2002:a05:6a00:2da7:b0:842:5bf3:c53c with SMTP id
 d2e1a72fcca58-845152ae344mr147445b3a.2.1781548972680; 
 Mon, 15 Jun 2026 11:42:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9cfebsm9866332b3a.9.2026.06.15.11.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 11:42:52 -0700 (PDT)
Message-ID: <60d01c8b-bc07-4c09-bbf1-b1b0c77083a2@linaro.org>
Date: Mon, 15 Jun 2026 11:42:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] gdbstub/system: Replace legacy
 cpu_physical_memory_read/write() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
References: <20260611180320.30320-1-philmd@oss.qualcomm.com>
 <20260611180320.30320-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260611180320.30320-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/11/26 11:03, Philippe Mathieu-Daudé wrote:
> cpu_physical_memory_read() and cpu_physical_memory_write() are
> legacy (see commit b7ecba0f6f6), replace the two calls by a single
> one to address_space_rw(). So far there is no logical change, but
> stop ignoring these functions returned value and propagate it,
> respecting the *memory_rw_debug() family error path. Thus this is
> effectively a logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Cc: "Alex Bennée"<alex.bennee@linaro.org>
> ---
>   gdbstub/system.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

