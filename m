Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32542CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpfh-0000YJ-2z; Fri, 31 Oct 2025 10:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpff-0000X5-6i
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:00:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpfS-0003Hm-QR
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:00:02 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4710683a644so20054385e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761919184; x=1762523984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNw2EJaIg1eeQojFyH4I7yV2pKjy0BZpWHP33NwKPN0=;
 b=zDtQqfDeM42EHv7/zFbdN5BNZ+zc1cmACXqyT2U46dA3vffLDgPjpmvVBjLgJmCVOy
 14J7zfk2mQHiTI+IgfOBX3Pr7pcVsTSe0ZV0dnBtAeBAX5MiCHghf5BNtjeKfBoKM4x3
 L+SiP+J8tn7P1Sj5dwXNJzphxmMyeMuHdBvvHkSrh50BEFjctaNz7MQObDePpuZ7vZUg
 pzdYo4a5BAz1Mym+9IIGXp8bxeRy0wSPEt7oQh93AnSz7aA+INhvMqnhQIRMRQWYWAyk
 xhRTDBjQAEf0ZljJIUhkp9qUCF/qa4KIw+WiopiNGjTmUDijBw5+/9AazZKO3GxXdJZN
 o0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919184; x=1762523984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNw2EJaIg1eeQojFyH4I7yV2pKjy0BZpWHP33NwKPN0=;
 b=vXvFbXcSD83CE6UJFFVLMxMIfH/3EbM4o/taRereHR/ie5I/kzNX2BhQhmlgWgBfo7
 jpYKWvb84VtESy4rsTfpHRc/OxnSdWoaNXQTNG9v1vz+xYhZyQZ8g7d/lOopzwpr4uXQ
 115X3jrCUrcoKZlDi3mmW3InM4lfCC8dzKtWgE30kHlwuuXPrrQ5fXEZVvq1behhq/eB
 QHiXCjCxKi9BybZLSR6r/KGd2iAx9Qi7/2HMAOlGP7FfXlQSi9g+jw7jCXX0MGpKFpmH
 Rxi1wt6ar79VHB8ibK/Kixay8mNeeIKeiZ/18OJawfia+tbhXeCq3nrBEbUdfO/fTIvK
 lQSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUClYRrl0mJo0sW+yknpdfjbxDKdy4T6ic3SsCELQWalcEb4ZFkVX9bVkBcksnhmIQUA3rm5jT53nS3@nongnu.org
X-Gm-Message-State: AOJu0YyaPe+ddCMKkORhPeAxgX7gih7rkIp3jx/psBMDOf3XGAXm4+TM
 NwdWFCteWLfV37812PNJ6pIIkPE+pB+FlnvbmtuPgUykVLSxHeFo+I5CkoYH0ld13XE=
X-Gm-Gg: ASbGncs0nZuWFJEBL/gz4B300mj32FBujyL+6/rJvNfBxTBCjx3p/ge6l7PhGmhuHcm
 TWJDpBOMdDFJWBs5Bzb6Z+MY0Gk+rLG14V+JFaWJCObG/q4L96qyQ6RB/cY0vaGHxEkF8rlxJU5
 z9FYUDqU4vMI4CENjAzjpnNxIiOMFyYftQBLa0R0lTjuXk0SaV0JdpLK3o9Zccq6OQalU3mzhSK
 v8lUUZKmfLHlOBpUMoRedHtSEsqr9liXjpu2yQsdEfTa5Jq2503qloF2BVwADC50721aFl+nkwB
 LLf4+OsKKfVh/8ny8xgZJkUKaDvwfxcxEvlRTeEOZpUXU0TQUoHqR9fdEyQG1klRJNRTcceeUAZ
 GBLTZX3nK0QJ9fSYOoqCkzaYw9B1sfZh3FNkKREe/244bXHRxwCWidCvl7XWXMvcZzzlfwmbl7P
 iWPlkMG4mhAfbLICpybgif1bMDgS9YYuWuM+mOSz72rTYHEUxVFhvDCTSkgv8EiWDf2g==
X-Google-Smtp-Source: AGHT+IFRWDJoq+RlGMV4sXxM8D8V8yCyKFzquz5/FhXXy8uewJF7PXqUTZ1C7CcMYVxP/RZPLDfhUQ==
X-Received: by 2002:a05:600c:530f:b0:46f:a8fd:c0dc with SMTP id
 5b1f17b1804b1-47730068201mr40491725e9.3.1761919184232; 
 Fri, 31 Oct 2025 06:59:44 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732ff7fdbsm33970095e9.16.2025.10.31.06.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 06:59:43 -0700 (PDT)
Message-ID: <50852162-42b3-4702-87bc-6be2e7950441@linaro.org>
Date: Fri, 31 Oct 2025 14:59:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] crypto: use g_autofree when loading x509 credentials
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-7-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030144927.2241109-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/10/25 15:49, Daniel P. Berrangé wrote:
> This allows removal of goto jumps during loading of the credentials
> and will simplify the diff in following commits.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlscredsx509.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


