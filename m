Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCBEC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:13:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDQk-0006N7-5A; Tue, 06 May 2025 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDQh-0006Jn-Ub
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:13:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDQg-0002TX-AY
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:13:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5f6214f189bso10082084a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519208; x=1747124008; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PmGgjt0UaQb1TQiQ6KRUgCpfLXk3//KCWHnG+pGz6+I=;
 b=V9qWYQfNXUSQpTLBgHuhosXiVL3jOygkIIoKO9ESevRxv298LBjkgzwY+8iqaA9L7E
 tFVJyVZseDtR5NPlQoNt7Pa2ewnNgiLYFPpVb7CyzQabBlQ4KQ+rQbnC99AfZ8SST56j
 nfU3h4pVvyXeekARg33frsyh440TIAiDFmp8Ii+qHcx2alu7X4tMlhqcmsjxNa7LRfz0
 BbV54lJ9WuzbSmdLyqQIPbXz5Mozn37mrMxqjPf3Wa3KsuJbA7bDXofwtc3knfmoRHyu
 74dTLmImJitGd2yRGtBkPJSh9BUt15M1ZioXBWzPHLSYTW3ZSLq9DqffB/6fL9QymIRB
 r8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519208; x=1747124008;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmGgjt0UaQb1TQiQ6KRUgCpfLXk3//KCWHnG+pGz6+I=;
 b=ritdUgy/5dofp5t6BakVpWI+kP77vtmN8ji2Vsmgo8d4DPpp4R/3d3W69JsmXoT+Tr
 9WiyTeKdo60jp+vWNmTLRTewc9ct4mJ5bCTylJJ8WhKnwtbTbkPgmj+kNFOAMdnkn6Jv
 FHzm03+05lnXLHdkMdiE98mXUSIk83qDxkR9Vk77rlZcMQNbd4VpF8/+EAZcFAZfUk+v
 q86Qytnfaaaz5jn5pFPkirErd9/dxgO/N9pO5lB5+b4901Pdyo4x5TtOYhmo2Kmu3ShR
 EdDvD+gsZgeAxmQG2gBOzDtc9yXVbR27mrG+b1QmOzqTlee9h5/WWT2XmD+eKTJ1cjP9
 TqeA==
X-Gm-Message-State: AOJu0Yxfzi/D8QLU4ydCFszzUruAASGJDOL+JvDarP3+UT1CWYm6twN4
 sZfpRrC3pzsJIRjOYJrqQkCApSSH4d7pCyh+rV6DyTdku4pPJIGpKI8OtBX+Hvg=
X-Gm-Gg: ASbGncvqznU7xh7nkXiJNlGDPCyh+74hvB1t/hKEMd3QxEAv98nODetEXXxkI6jdM5y
 vGgPXQS5ZyrfYWhpztcpLErUnXh8ez70T5a4jyzQmQhNnlVltOX98V3YKWI3FQBS0hIAXwBXMYu
 u+clQdrQSB0MfuqgK72Z7+ToSOsA6jn+Ofb4zhOrr4zYGRxLZ/bFmQfPK1CFsuLMS4ROeZsD2+1
 5KZLe9PtOAUFI541IOhVcr5lpy/fl7R2DmVn2YII7mtxoJ/UtEALKuAlI6sw+mAybjGRo5aeZpY
 GFVePbly5o68sD8INaw6Wd9Ojpvoz6CsaoTtlxPkEf1s1gaeUUSlOUdKzvCeDqF1W0cfDpG2AXw
 hAlA=
X-Google-Smtp-Source: AGHT+IG0pv4p7W2OjYbI08zygnTVBhMGAFGT7fe2Y7bi1mJKKy/iwdJbrRfWuoIJoqxs7jPstmwNsA==
X-Received: by 2002:a05:6402:3481:b0:5f7:eaf0:8826 with SMTP id
 4fb4d7f45d1cf-5fa7805bb42mr12267617a12.16.1746519208191; 
 Tue, 06 May 2025 01:13:28 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5faa67c7e5fsm5813395a12.78.2025.05.06.01.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:13:27 -0700 (PDT)
Message-ID: <ec90061b-3133-496f-ab69-31e065ecc492@linaro.org>
Date: Tue, 6 May 2025 10:13:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] hw/s390x/s390-virtio-ccw: Remove the deprecated
 3.0 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-7-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-3.0 machine is older than 6 years, so according to
> our machine support policy, it can be removed now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


