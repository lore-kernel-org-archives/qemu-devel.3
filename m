Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8A1CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 04:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uteey-0001bh-QR; Tue, 02 Sep 2025 23:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uteex-0001ZV-Ee
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 23:59:47 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uteev-0002xo-W6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 23:59:47 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6188b6f501cso7211407a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 20:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756871984; x=1757476784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+TQ7bo7x+v5Ivaqet+E9gbc5tUBZxuS1TkLFQVwlr2g=;
 b=h/hg5OAJ4ANPJTYmd3AU6VtijTZ/AR6FzKesyANBiM8AILbZgqchRSKFNQqJB7ABrA
 40TmUHqfFq4RjGrWU9XnI5J79o7DUadXh7sOn3MRctapaxoux8UyXiue4GjSqeovAlB2
 3pMaBn8BN8879UjCe0JBpAtpXt1OdhIlf5q+uMwDK9I+Q7jQF87gChiwUlGxT60M5zUx
 hamO1/xzT49ZOEWuU/vqfBw5ZTx32BWrbt+RRPSEXM85kdpYd5XmMGX8/Huz9QLmRegm
 TvG51KIVPjGj+ZzOyFonrSYOq4eG+CMnNQvqLOTq23CtlZyDjNshRGUpOxSxkAxuTR+/
 HVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756871984; x=1757476784;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+TQ7bo7x+v5Ivaqet+E9gbc5tUBZxuS1TkLFQVwlr2g=;
 b=TUwPIDSjOZKljfrnErwToAZQ+s6AGrT5x0iwN4lUfizGJNGPsU5s9YBT+4VR6S8fYf
 2d8pYGzAyT7D+1p7gOz67prLqG5qtvMnVtEPJEBP4FeTiwrmgDQzXOHdztaYmUnDYYBh
 M8MjnuwBj76s/1mHN2bRgW5mdhp3VChfAi3izuskiZK2yB5WckH0TO419ZamkByB1ElM
 UwYtR9Ta1VXiNWVfmiVymdckpblcsk6ddnZnHV2ze5iWcnVGxjLBcc/nmxsSWTlJxpq7
 QA3sumZ2baHLUa3RSmA5LFAFvWkUsGUQcUC3uLkhMVG0VsJIHHGIpMG13BSbdpa7d9s5
 k5bA==
X-Gm-Message-State: AOJu0YzL1Zxsaofzrb4nL1uOJYAx8bG2WHTF86ok8Bj5kiNkkQZiKYCi
 3pKQQZzfhgr053UQZRNFpK9PMSpu/LFCR1QH0pexLQcc2RQ9iS14ZmEsi7FB+pICB5UALlYM63u
 wu90eOus=
X-Gm-Gg: ASbGnctX1z8god8HDKuGu6zzjizzcvHnWpGgdQHVB+RWVCdTrjel1j7qGeEcM040wqR
 sd3RsD8CX1c5gUWMpidAJXTZ+KpJ4qajvsIvvvMEhaTnvPFzUzquuFrCkPDPCtcpNPgyxmBZ8B+
 ehkri04VJRNeNy+Ks1xugIw0phvI7DVYjVlY3Y9PuE6IuGZvyqXcXm2i03FcU5Ck65jTRlLqLbg
 l8kdvocT+AHtGMyBfkP4NryNYty1DTOzE4aNG62hYTJKHEyGo7oDGp0561Tt2TbNVDGyw7gc2W3
 xA/rWazSp4ph6KopEeNS5pPK0QgVOr2fxDcKX7efJF+jqOY9VGT1WGAQQPK9FQxSSQBDcQkRlZo
 3E4re0H+vmS2Fm9q21wDEDejwsCxLIw6feWZep7A/OR64tsxcmPbrgTJafQa4uy/Uqko5nb5Pgw
 lgX6WPhA==
X-Google-Smtp-Source: AGHT+IH4qVbk5WD5SEknQjjfypMRnm6YzY/Y2xcMETRi0jaF1grS904K+M05w7pTh6aRqh9Hxs+ifQ==
X-Received: by 2002:a05:6402:13ca:b0:61d:107e:9c28 with SMTP id
 4fb4d7f45d1cf-61d2687249bmr10339960a12.1.1756871983958; 
 Tue, 02 Sep 2025 20:59:43 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bacsm11359099a12.16.2025.09.02.20.59.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 20:59:42 -0700 (PDT)
Message-ID: <68aeb2c8-9331-4e95-ac09-5f1fb0d7f7f3@linaro.org>
Date: Wed, 3 Sep 2025 05:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] hw/arm: use g_auto(GStrv) for node_path in
 arm_load_dtb
To: qemu-devel@nongnu.org
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250901125304.1047624-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

On 9/1/25 14:53, Alex Bennée wrote:
> This is potentially more of a bike-shed case as node_path will persist
> until the end of the function.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/arm/boot.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

I think you should add blocking with this.

   {
     g_auto(GStrv) node_path = qemu_fdt_node_unit_path(...)
     if (err) {
        ...
     }
     while (node_path[n]) {
        ...
     }
   }


r~

