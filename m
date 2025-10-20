Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB790CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzV8-0000ks-5e; Mon, 20 Oct 2025 19:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzV5-0000eY-6z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:41:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzV3-0001rV-Bi
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:41:14 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3327f8ed081so5934390a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003671; x=1761608471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GS7O0192Qv9N26NRgo68O6LAlrZ/Oq8n4C75eLBK7D4=;
 b=ZXQjpD5QddXlQ6pf6SgZIl4fUdQ54fnnCgm6ydmeCsAxChimWCiofoCffJMJvCRWdH
 i51hHnYkRgxtInoxakwDcHdGKz/AjPWpgNUcXtrnNvU2dkl+6n+gyP2Vz+ZRZtd7JeTy
 80f2hZ1K7q349P4qudoNCIT4XXOcJ7gXVf7nYXplf6hXyGYclLFIuj3m2LG4zAHvFJRK
 OYOCbWSRKwVlsc6bLU+lLYxS1h3nUpKyB3Hm+a9mOJfn5IBOyye1FKsqNftzbA0vOebh
 0P1T2j1OBCZAftkQSOfvhnfLgkpCe+RcDvUGze5Brb5Gc3xAS7MNXtCKYbt2yPkJEEAw
 aVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003671; x=1761608471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GS7O0192Qv9N26NRgo68O6LAlrZ/Oq8n4C75eLBK7D4=;
 b=edSW9NGJb4Lh5lPWMFevcFFgRcd5bdTaeke1GK6P0k0h+h5q6CG06MTA0TuApxXBoN
 jMTh6jBhuTfxnS/fHK1WzOr3cW4r36PRrg412Rss+OYL4l8g3S5pG1ZnjkDngfeVgJWa
 yUyMfVJIyFu4mKBCCMIRYVxJIzCFqSS9Q43W6qAj3Q888PANkfXQJKg1qweMnf8s0YbM
 jLODmqnJ1Cqte6kJMVYFXwuBIuKdGfP1jEp3LgS0ZcM2Vim0oKR1anhPqaoGSEkADND+
 m5vjgyW3i2u1Ojn5RlspSPq0vFV1FOtCgUp/8M4bUFI6gGfSctoCB/mur4c26SsXhO8N
 SguA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiR6+hgfeAj84dpa9qXHNh/dlGHDuXsYUfAuh6uJNYg8gT3qXmxZFO/DUBO4J6g1t1GRlaglvGa3gF@nongnu.org
X-Gm-Message-State: AOJu0YxmSUJhKxgbfa0WADb4kVJ1sWQcyF6lRX4z/twDTy8PxAx5ms2k
 xLxdLE4Bufm0pTtCD4vkKPf5h8O/fLNqAiQatWMT1ctwXSf2oK4RpAaF/h6hfAkfnEE=
X-Gm-Gg: ASbGncvBAebXuOFzGU4kWleTq5HS9zqPKBqrQUEI0GDQnAYq+5pzu/sRn06ig9Ufl0e
 NWAZEC6UJrYtAoWoNbMkci+nfT5HQQHPzR9iPgusmi6UGk/cOx6cs1ekMl/C4Up+p22jv7EWNRX
 MJYGVq46+IkgaNOU2ReBrgGyJE7VnlvLE7zpj3WIbeBPG97BetArDkCYOVfuZVFuvKP4u88mT25
 jWZKxmZ8+wT1TC9t6eULM1bP8v72lxgyboXgMClJ8ZHBKr9Kk77Djx2UFrVZHSx207BLUzT/iQ4
 UK1btyR7l3nlRlY5mcHpM4fWdcoRcQ2FuYgRRMLOjB5SkJd9cln+DbJOIozNEbLKGWZA+5Hsvoz
 1VcmWpxGQbuhtqCHqtH0otplsVtGnv5qCfjrq6aFCOSz7WyiL/KyiPG44qCCrHw1yZQxcGALul8
 X2mlvY/lrEIl13ww==
X-Google-Smtp-Source: AGHT+IF2W4qJudZCHIa8GBLubG7VEnFsja11/z0exAmRjTHm0UoyvZGZQ0QmD5S9OWCUIjJU5O1FtA==
X-Received: by 2002:a17:90b:4f:b0:335:28ee:eeaf with SMTP id
 98e67ed59e1d1-33bcf8faabcmr18264409a91.29.1761003671449; 
 Mon, 20 Oct 2025 16:41:11 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5ddf086bsm9144050a91.2.2025.10.20.16.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:41:11 -0700 (PDT)
Message-ID: <d314c9ef-7c17-484c-8e17-88453d9705b2@linaro.org>
Date: Mon, 20 Oct 2025 16:41:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/30] hw/arm/meson: Move Xen files to arm_common_ss[]
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020222010.68708-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020222010.68708-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

On 2025-10-20 15:20, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


