Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C37D735EE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGkT-00048Z-1p; Sat, 30 Nov 2024 01:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGkH-00042h-Kr
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:14:24 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGkC-00028o-SU
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:14:18 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7f8b37edeb7so1698436a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947254; x=1733552054;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HlKfcc4cbagcfZTiyYPu766Il1CxRL+XljhzeDMsrTw=;
 b=3KJqirg2K6AOhkVFP6pYQvgn1JtrzgqWoy3Q6K3VPPWEJqoTuBS6IPu0wpb+4ZOPAu
 k6kpPxWJ+c5oD+IJCV021nUPxGENY0qDjuS8mMPRg6HTEAw4dus9N9vrqDZEpjjJaxES
 18C3MYqinwoN+puq65JmWKmovg75v05ighUPh9alO76CX2U3FJW7JR1ALwb9n1JUEfWD
 /yg2L2FEnlyK+e24EsvkJsb2E2Nb/z1HGuuIIYFyhObLlcaNN7x9kiz3NQbUZqhLVowQ
 nGbUXpKTaDZE9+dBhe9DdpLIARA3zVjF2/sN3KtRqKLIKBYMaTotJz+lcYlHUhhxq5eR
 rmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947254; x=1733552054;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HlKfcc4cbagcfZTiyYPu766Il1CxRL+XljhzeDMsrTw=;
 b=MKEVJ9IZxG82CUslCCQZZF7PVr1wE8Aa3FRFLY2e4BtkpbYL6AfVe0aGTIhrcbW8SF
 JY/h2j8uAQSeR+8r6CGoilbVqFrLgQkCPDWBaH/TpfCX0DUk76vKyxwF8uECxVveRsHw
 8ppJ/URUpxvZi6QUvxXlicTXCzyivOtKoXvu+YmjU7rmHapVcAdT3/EfW9IVlX5IpEa0
 2WjbpDEXnazGmR6vFEaU/WOmOdM5nSshfq2kkju7rkJrsDEGTMdotSZ+yvccLfzqUEdg
 k3RzG4M3O9K8WsYvc/Yjfc77g/eRVib1oj3NFDwzxxIEF2GNzQr2K+Md3f2aqtsd8ytw
 7d2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXkxmHPxARq7LxAiU+e9afrXlipQzD0bAp1/qj9vYdiN4VX4UC8TEI5lFozZtu5oc1aOyO2h/wUDzK@nongnu.org
X-Gm-Message-State: AOJu0YzV3oZZy6yW+W84+LS+3XMbirUuLvgtj9EQDB/8HS9BiC3N6LYa
 buMacemJJ1oIRJ9jc/8w0CkVs92Ac/4hOjk3KCaJXZSH9APaCYjyrRypPiZZtBg=
X-Gm-Gg: ASbGncs1wpJerD+vfgyWyoOOIiiYWEjdDztmlCma96yC7/9C/XnNtpt6uY3GLxhUcR5
 LF6IkZFpBUrsuPCEHgaqSqv9bTs6xnK7bPjO0RhgOgYRqUkyFPjwrV1gPrvlu9XRUFebC8VXQgG
 Nq82fsoau0Cas1jKEjCHln9EM1sz9UKLWP2aRPb5vv0h6UaDELNNIGD4iqmzWPouuJd1hG3JyV9
 8YTvRkHsblbHH59SBdOLl+64q1jkh2FXbLIKyuwdhub93e3q2RwSIxBOiIfmDI=
X-Google-Smtp-Source: AGHT+IEYIhg+UrmWSJuwEixDlrdpu1iVPERUjad/M6gcv6ANFMa4g5jtp60Ra2P7rN0WGAZ1mTyEmQ==
X-Received: by 2002:a05:6a21:e90:b0:1db:d738:f2ff with SMTP id
 adf61e73a8af0-1e0e0ac69demr23710101637.2.1732947253903; 
 Fri, 29 Nov 2024 22:14:13 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72541761523sm4487121b3a.1.2024.11.29.22.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:14:13 -0800 (PST)
Message-ID: <21f34858-0298-40d1-af75-c2d97cdd159e@daynix.com>
Date: Sat, 30 Nov 2024 15:14:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/15] hw/display/apple-gfx: Adds configurable mode
 list
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-5-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2024/11/30 0:24, Phil Dennis-Jordan wrote:
> This change adds a property 'display_modes' on the graphics device
> which permits specifying a list of display modes. (screen resolution
> and refresh rate)
> 
> The property is an array of a custom type to make the syntax slightly
> less awkward to use, for example:
> 
> -device '{"driver":"apple-gfx-pci", "display-modes":["1920x1080@60", "3840x2160@60"]}'
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

