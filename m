Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12089C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIslT-0007KI-1C; Sat, 24 May 2025 13:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIslQ-0007Jp-R8
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:34:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIslO-0000QF-5L
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:34:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso865397f8f.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748108064; x=1748712864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ooeFS6VLfKGQo3XE+nVcABc3JJ7IGKftw50r6c1yh/4=;
 b=NNu6NCBSO2wqE2dCGfmSqlbjCFo3yggnCihNMzvtgjgtgUswlmIMIW6NkIBjMBZxik
 IuwJWEMynYimJUuEOAoXEE+v9xB8CDwwuoQE9iqSTUIoxrmgVWkKrJnVd/raFc2nqMwt
 uBIeh1EtcIu5q/m/By9nGls/1NxmndWn6YdiDzq2fPjFi59XAIqAiFO9p/SRhzC/Fnj3
 y6hn5EXGClisJomojIlJVfMwfDZbN0ZEIUC0Qy5Ut3dPeFWF9REm9wQ+mG/Wy8lvtPX0
 5QxnQ9p6wre2FNeLyESwwLyue41IzFa745g/6qmJVhrr3Zw/OTH74Q4DF/oklPSt/CCN
 Kx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748108064; x=1748712864;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ooeFS6VLfKGQo3XE+nVcABc3JJ7IGKftw50r6c1yh/4=;
 b=JWmE12XKye6ywoq2VYxGsLl0RtYUTQvjCpx0ZC3r2EW4jfhtiQMRLKXsmy66k84nnl
 sUPRzrPpfJb+y4rEEfsFAIaY/jgUD/Zbu0L0EhpwUhQexl3pfgj0WEgy6eN7ug5elLu8
 D75coqq8tnNWAn9tMhwX2hqk7Ut2d+SYGnSHdq+rqquCYOiSj+zH/FIEl+GGHYqM6mFO
 QSxj03xeoUm0/v4DW902AFH4eEIQxw1HylAsdf7KJ5YX9HZKEKWBbuAKWtb7iDxsXm+y
 T80nY+CCAKkmBzWpkHNtezNjVsyxZk9HFWuzsb+krthMPhK5BSF0R+9dKYHY2RQ72npr
 NvPA==
X-Gm-Message-State: AOJu0YxXMqqsodUmT5QdSjy+44NUs+7liaSQd7z6dJkXekb7wYRAIQxf
 IF/gt7542EFAwrVCVKB9+0mQnydkin0bHx8zi/rDSzSzRbZgx2gf+KJ5ysLBMyG0OeFt6gZGHzE
 tNZfqg799gQ==
X-Gm-Gg: ASbGnctvA3NO06/EM1wi9LZjOLNnUsl4SXpsyw4ylZWKU2FIqiw/ziIxy91Appq8hvB
 ghAsrizIJCif1rQK15qBFLxVpkPyKTIkMs6hV1U8FsnJ6y7k4ItT3Xhkt/jH6VgV1jacZMigqSs
 0ETS9KqK5k4GXktw25pkX6DX/5t4/Kze+s4/cg+oPKmUU/GwtA5lwCkI8AjwALYxFsTXB6WNftT
 H3G4DTs9GwhL6ffSyFasML/YjBmYt2Wd60rELIO7PAQQmI0kXbOEJKvsaWy9nr4AwLS3vRLxJUu
 FrRN090EYUgW+4pvW4yrIfH6bl1wTtQ6GtKVUCzYUM8FOyF4AFiF4FfcyWPZDaViOA==
X-Google-Smtp-Source: AGHT+IFkfBUPckUrZ+2L++H99T4M/WRvjQQKPgQOMofuSyNXtXGaPjNlt9MuHjdjKfr7YGD/DbvsDQ==
X-Received: by 2002:a5d:64c3:0:b0:3a3:6e85:a529 with SMTP id
 ffacd0b85a97d-3a4cb49e78emr2952230f8f.51.1748108064493; 
 Sat, 24 May 2025 10:34:24 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cfa20c03sm1751172f8f.7.2025.05.24.10.34.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:34:23 -0700 (PDT)
Message-ID: <bd63bd25-162c-41d7-b868-b3ddf0598d43@linaro.org>
Date: Sat, 24 May 2025 18:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/25] target/rx: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <f82766b654488c9873de8f042c048ac6abc71f9f.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f82766b654488c9873de8f042c048ac6abc71f9f.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Renesas Xtreme targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/rx/helper.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

