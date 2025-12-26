Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C8EE8FDA7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 11:48:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ6If-0001DX-4P; Fri, 26 Dec 2025 06:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ6Ib-0001C8-OE
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:48:02 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZ6Ia-0003mc-7v
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 06:48:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso38773255e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Dec 2025 03:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766749678; x=1767354478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtdfXwk5kXFbkQLaceJc4STJ1mH7lvzD81FD6jqc4SE=;
 b=BLmqnCb/Ze07sDsC37lOJhw0Kdgf15g6v8nDlMIjYmKs7qW7cunD1gn/f7U766od+s
 rKL9eyo98wOJ8L9kaEMSfEZmNYYCUbuaP8EG+wDhWS7LqU5T+w+8hQduGX7bwmY0y4PJ
 Vnr26CRyonWdMJFWXwUtKp8zbFY6Cxrvb/qaZHp5UX3+dSxhMbE4o2tEj7h9UJPuKFoL
 JyrhvYnydoXXD70MrRki7iz+qvMKTdR+KAhxjcNuR8CY5RHYeT2QpJiVRTmUr+iYSDGg
 47PLcUoxx3WyUChfb3GFlBrZtWw4FDr+1vQiKg/oFH7uIYCh0jozXl7itJ0jXEO4TqIx
 3cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766749678; x=1767354478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qtdfXwk5kXFbkQLaceJc4STJ1mH7lvzD81FD6jqc4SE=;
 b=lEiXgZxKtstifEOCvDKn1vL0V6jkyDTi6laCksmM6SUtxOhL1XwNZ5CG+H8amiGxDG
 6VNKMcwyvcboAAM0sMyAsSE65WJkCWGM+J+wBReU6o0mTi+qzlKHr2/D8SMW8Tf1sSi8
 qZlD6diHXshjGk9SDNJRdz9lM8CeUW6XJsoqvk783our0ariwNaqmqx1EUpnLy5Aj3Tn
 NSBkz2aWEZjTfzte+xhe3kmckZm+/UzJBCyHTO8IFufA1Js4L6V9XDKk4okFyrxSZMT8
 XA8GR8/28bMF/8bm0piZ6TzOSmtJMpCf710HBKIsOg+qUnDZOnBU0MauUXg+ZfPtFiwq
 kXAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeEKUEB14Us1bTmIOC+E8e7MqVNSJS4iGV4xxlUxNuBBnxtdvybjZjUSf2n1ZjBvwLnz98tdTDPe4S@nongnu.org
X-Gm-Message-State: AOJu0YwvakF7Y758bmrhNrRwmiol3iAoH+Ic5bpSxYiWV/yTdo48KgMM
 hF99I1FPKpRx8Y7np7BhF1ciKzqZbLtBWZs0ZsSoG/IylFp0CW/jU3xmcnfaqcknQ6ZgCe9M0n6
 RYLHR
X-Gm-Gg: AY/fxX6mkfA32PYpHsznV7WMQm4PwkqMm6GrxqptZ3yEH/BRtTjAKGkmnrZb42OgRpb
 vjlIF4sPl8gynb7X6Yvs/56YMzUx3MDVi0SgixlAwWzAA/6gvJ/ftohlwH/g+DaYQMZ5wKjkYKZ
 IQcOo6msFjKGD0zPF2gT4p0StPu1pSP1UuXDlxWJXadOMdBV99Y8KSELcpKyup5E0snpoGt4MFk
 XS51suWgFaT9lHHB2uL+C4ai0JVd8uKvbKn+EZh0sl9+VQG9DBNnQ93pG6uYvS+o7hhSAxi+bE1
 x1gIamB6X5MJZqF/ktR9NvD+w2YZwBr3wao7aDUD4bhX5+yuG8A0RB3kv2t/zairpzafukTV7Dy
 83NeubfYLWG85fYlAZ+p/GniteoPeGHL3sUDHgSNZ4EhhiZ2qD2GNxCEBh3+bbp3bAcLIWSTFUq
 sBEFp2t3fUMBEeaMO7GT50atPJUMODktGJVWGs1GdgUVIHOvZg5SQXd2YxodbsBw==
X-Google-Smtp-Source: AGHT+IHYIfLVfgf3dbJNpc0Jg+sZXO4k8bjA8ckfpv1DRTeIQZ/sPs9VhJhGhMUAHs0UWLFTPZzwJg==
X-Received: by 2002:a05:600c:46cf:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-47d18b833a6mr252180935e9.2.1766749678317; 
 Fri, 26 Dec 2025 03:47:58 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272eaf8sm437917845e9.5.2025.12.26.03.47.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Dec 2025 03:47:57 -0800 (PST)
Message-ID: <a387daeb-187a-4620-b607-a90edb8213a5@linaro.org>
Date: Fri, 26 Dec 2025 12:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: remove old email for Bandan Das
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>
References: <20251226083207.506850-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251226083207.506850-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 26/12/25 09:32, Stefan Hajnoczi wrote:
> Bandan recently left Red Hat and emails to his old address now result in
> bounce messages. I contacted Bandan and he asked me to remove his old
> address on his behalf.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)

Thank you Stefan.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


