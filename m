Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C13D735EE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHGoF-0000Rv-KB; Sat, 30 Nov 2024 01:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGnu-00008g-2R
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:18:07 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHGns-0003cC-EK
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:18:05 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ea49a1b4c8so1816087a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732947483; x=1733552283;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YUXcUixf2IPKMzLsXv/zPStAWQGsFjBbEFSJ51IeB38=;
 b=iGh9pM3lcHqb5lnBE2FEsLWPlD8u7CwW0jWbTDJE30iG0z6JumPSSRhjhhSYsW9tgt
 SvvtBszu26dIiHcouKqk0MebBjSGLIMuUWFx2Jt5ZXHHcQ7zD6bWS6QA4xDuZchKtRMl
 Nos1/AxhWqmdW6IEm32WRIG05Ogb6Rx7R1k+SN73/ApqGBT60kH6VI57Dk54DA1EQKV0
 xWr2lWe+lOFfcf2Hn4BZtIYrq/rIpbvtRhHJHZRzIdMf6qMpLxJHQ8HVBe3eb5qtU+BM
 rcpW2j3b/CHApeTFgS/vOYSKm8MaiCi6g2To4PEboKvZQBJzYGVPU6/lv220lRr9UvPX
 4Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947483; x=1733552283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YUXcUixf2IPKMzLsXv/zPStAWQGsFjBbEFSJ51IeB38=;
 b=Zp7QefaaQZfZ5E/6o4cwX+snrGwI/PvTFx7icw2phvvLCRryN38AmEt/8ia+dqtoWb
 MjDFJBYSNEZCkLIwb3gtu8Wy+oF9DW5Rcco0/6sh66gvS1qEeVlhD/eD5PL/HQu5ucmH
 +gMWDG+ABKihD7SDVrEwePU9mSmf2KeYBG82cmKUR3Vhb3sAfmkxj3S9Jbp4J/6P1Q0Y
 5tJL8RmfoLdj63oWRmJUJACN+ALaz/g+fPfgKy4JHkSTVvuaD8oDj0spGIbdIVMQd6Ih
 MYF0DZwa/WNY203LdnUBBhFImpVDEmFxd8iFK0XM/wNtdxkABKAfp+7YW1XFVQLbvVfK
 ifOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUaKX9a6Kf6I2qUlaho6+WeME8gyD3hdB1r8bRpfu8p7QDOBrIvzCOE+FPRR6pelISBTKQCvYKAse3@nongnu.org
X-Gm-Message-State: AOJu0Yye0qlWaXGiC21zORguyknJuiqnEPeO84dQApEpWFK3kEtKH1qu
 m8uqcbSAMkqLfdtiCyLztFsL7FoeaSa5JnrCO8pH9K39qG3DIK6xF3j2k4187EM=
X-Gm-Gg: ASbGnctf5W8b6fBYXneBOknoHSU3CDE2dACO8hziI2+SAFCrqqRsqPaRtm7LCtUDuCa
 QsQupFpte2C507raQGj/VfH5AbM8TfYL447GXEyf4/zZ53PgUidrjL8HqTJf+IN+SRIMzrStRjO
 ld3AxuNl9x+nmg7hFy5zZNGlH8Wj4Qa2KOnT8i548uEvG3iZEe2xHpkFqAlDYpSJoklFoVsQ/8V
 nneE6EjSiSqE/EHt8PJX9IQGEVdZVwmto8ZvI76WxXP61+nzCtvokWsyutgttk=
X-Google-Smtp-Source: AGHT+IGsIW2KZ+Vgb5stT/Iw+LFiVKdVWN3EGjroQXdpKvhv+l+jt/uswXZAoRooOTJtM0wzDSkfoQ==
X-Received: by 2002:a17:90b:2641:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2ee693ef273mr5987043a91.35.1732947482916; 
 Fri, 29 Nov 2024 22:18:02 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee488af41dsm3077984a91.28.2024.11.29.22.17.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:18:02 -0800 (PST)
Message-ID: <cadde1f6-57a1-4aa4-9b80-635bc86db159@daynix.com>
Date: Sat, 30 Nov 2024 15:17:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/15] hw/vmapple/cfg: Introduce vmapple cfg region
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
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, balaton@eik.bme.hu,
 Alexander Graf <graf@amazon.com>
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-13-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-13-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/30 0:25, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Instead of device tree or other more standardized means, VMApple passes
> platform configuration to the first stage boot loader in a binary encoded
> format that resides at a dedicated RAM region in physical address space.
> 
> This patch models this configuration space as a qdev device which we can
> then map at the fixed location in the address space. That way, we can
> influence and annotate all configuration fields easily.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

