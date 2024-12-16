Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DD7E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBjg-0008V9-US; Mon, 16 Dec 2024 09:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBjY-0008Uj-Uu
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:06:07 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNBjW-00073l-Vw
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:06:04 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb972dd8e5so2040216b6e.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734357960; x=1734962760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kSWekSVktEYmf12kc9swILeOvBfo99CjqVpCRN5BqHM=;
 b=k6AIZZZbHvuTfBTqppul0TZ4J0s6gGu6w+zlZkhtx/GeFj73CRt/miCot45hmnMG+T
 1Mv+kpFk8q+XkNhe5+PKsdlxbGTgpdpK/MqppmrT/H2smGJbAVCr3noN3MGlkHfsOmQT
 ZqDAZ4g9AAAIbh6I8rGZsygBbcszJn4dtkAvRjplSadvG0vl5I82xSr3KVyeYiuziXlg
 7lQN+xIEwkHoiWklfBPhUR4HIp02oGVoXUEgW5RENBbLs7a9SSY0dviJ8PgDV3sDJ/vo
 JAOpVi7qQ6XIIyM5bSYyVohxQ6wGz9xpW64V2bMSBm8+hJmOO54wFjwzf52UVEkxYN4x
 QJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734357960; x=1734962760;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kSWekSVktEYmf12kc9swILeOvBfo99CjqVpCRN5BqHM=;
 b=NcAZKR+5APfSx5lOA8DXeZUJmL4Zu3bYL0re7Vg0FjUWTSjr/03eFGqcQRGt+ENfoW
 Txmz0t8zGzx9GuVbmRoT3suHjT0kGpdfmBvo9xslIIPl/JnOE2DZeXCtf07A4Jlq+hN7
 74C7q7JrH7i6eK6Rttz6NW2N+EMZyxZqkVIuyZC2JWDjcXd/QUE77OHLmW4TYsc8sgf5
 6dXODBVp/cgLDunBRdKMPyX9bL9G2W2Ta2hS+vLqCeBT7/zNelsO7hDID6VGKQYGwrIn
 KyAGfFST1faLD8DxvqZHHiMAMcH/333DauaUME/LpUXRfn4NjdJWvow6Z57bfbb5pY5m
 3G3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0wcYgnU6NtOWf6TYjUHcDHGzmNcOMfB/43AVe5NAvMMD9+eY0rx+PCjCk/LIclARr6/wOrvWWFrK1@nongnu.org
X-Gm-Message-State: AOJu0YzInvPYAr//z53duSmGaC2PoJ40y0pwJIYwjOuJtKQ8tsPLmMuN
 VPRz8LU0UqqfYFE7/nhXQwfsMjZTGW51KLyQKBqwsa93jYXfYmwH3FgzG5/2JEM=
X-Gm-Gg: ASbGncsaGNGcwOWznCGmFCZp1JAbpAQc2L7PxaanfQdmYuq2aPQ9iviEpdOMvqfSmCz
 WNzSqJaetfg8gcel0nWBF9nUe3D944HIYj6x7/msgATmMAg6hz07vMKDZa1bMu6Cw9BBnHFomoX
 l68Ozjgeqf1oiPX+YiQMFjbCOd+ab6P9yCHP2Jj//EXz60ZWuz8Vu7xcCYjYHe8zLicRxzZJJ1n
 nQIxlZZAGYiMbn7Rs+cM2wvfLq7Xybnc8Km8BAuT8EOWNoCil4PLmEl9RzrEQAiX3cn1NeajN+7
 aZD/q0l3BBskdPsWJ/VHPv2yqQwVUE+RyxU=
X-Google-Smtp-Source: AGHT+IEYZltRF3Xk2M2/eYQrbngda+UogA4Snbi+1SqsSAHFMIXRUkYBThrOo1fnHuEkK/CNGlSqJA==
X-Received: by 2002:a05:6808:bca:b0:3eb:428b:fa5f with SMTP id
 5614622812f47-3eba691e695mr5189702b6e.33.1734357960125; 
 Mon, 16 Dec 2024 06:06:00 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb492a328sm1552586b6e.44.2024.12.16.06.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 06:05:59 -0800 (PST)
Message-ID: <10d4be0d-1d50-415d-aed8-f71e81098604@linaro.org>
Date: Mon, 16 Dec 2024 08:05:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/71] hw/i386: Constify all Property
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
 <20241213190750.2513964-34-richard.henderson@linaro.org>
 <774bd939-8015-47c2-910d-f36c44bc0379@eviden.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <774bd939-8015-47c2-910d-f36c44bc0379@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

On 12/16/24 00:14, CLEMENT MATHIEU--DRIF wrote:
> Hi Rihard.
> 
> Good idea, LGTM.
> 
> Just out of curiosity, what was the motivation for such a patch?
> It it simply about cleaning the code or is it intended to solve a deeper
> problem.

Simply cleaning the code, prompted by a change to core QAPI code for Rust enablement.


r~

