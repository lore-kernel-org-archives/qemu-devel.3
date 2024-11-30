Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D028D735F4
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2024 06:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHH2y-0005vV-AU; Sat, 30 Nov 2024 01:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHH2w-0005uj-2o
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:33:38 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tHH2s-0008Ob-O0
 for qemu-devel@nongnu.org; Sat, 30 Nov 2024 01:33:37 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21263dbbbc4so24093865ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 22:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732948413; x=1733553213;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pM8dkH9Xm9NMSKkBjI7FXIWEGQ74p/jYqNbXEgV8iyA=;
 b=21EkloIh1a9CV2bfPQs4hU0o8DLSAYjSAZr/LUeQCqpu/WQpGANO5UW4rOvjdDgf9V
 Ix1ii6PyCt2ViMeXW92rmm1+5cbUspKPaDJD1sZygGh2qCudqHM5WTsDRu0T2Ih5gJPg
 ovT3rMvwn75fzuiFjom/l/zRpDyBigs0078pIJBBHL3pN0Way0lgZ+LJwCpPo3C1qoGj
 fnbHXrOplAhVKpLHouBFvwsAJ9srCazspE9mQ4kb8AYZMK5fspK0lQdvdkduaePQ5Tf3
 0YE2d9trIT237ETk8e7YxmFeglr1GFOUVdn4wS11hEHxhJ2w6hVsuOj3alzkFm2DLtPN
 qPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732948413; x=1733553213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pM8dkH9Xm9NMSKkBjI7FXIWEGQ74p/jYqNbXEgV8iyA=;
 b=v3QqiVlIH1S9nCAGVAe3zj7s1ra4hsUKyXqXDcY9GMxb8HEJ3BfbGJNjKJP0R2uhQZ
 FUEoe+/Dzr8U01rJ0A2NiR94D78GXgZnE/Samjz2/qet0FfNIpAvfnW5YMka1uEXr9KC
 6WCf7uENzmJgMvwqlY/T38pJiHa6opuyxTEJ6vP7V7ukV/66xOAqT1OSxjpMcSHXb67i
 wWzEylj2vftErnt3px0Yecp15s9zqOppDu1t+wtSIT6RMiiPpZqYFe53fVruwfan2csa
 LMnNXeRv0m38ZjVnbKoAFACpDk+jZKMKIWcKDkFtP9K38qW3/Y32edbKwCJomgKW/JiJ
 cTVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPHrE19ByOsw4wzyAXZCDfnfk4rOHqwKjfo8ZC+JEAoShpyNkSl7KDw50qVPShTNu4GU8EotrgcWf5@nongnu.org
X-Gm-Message-State: AOJu0YzCDtuYZYq56HRN828SJhZ/Jrr8i7mTUjLM8IS6WByfBd+4y+QJ
 2WtVUA02DkMeHFCQos1syTyavxsgJp6mO1RBB9ohvtGgtVOhMFWXzo98BzDA22o=
X-Gm-Gg: ASbGnctMB3THYyPXCXAxYhqudemxCVvCS5KnCPnDqR/SM4hfh6cyb5et2nXKu2YqLST
 l0uK5iv23FmMsODwqrrah8lFpcPFRiWeZKtOpaLFezUwYD2PNAIbLnzoMTjwHNIbs5UKgZamzUZ
 WhA5lKBeZn2vKkVIFSlv0z/6qHBE4ne+EDgA+N2MBbqGMklYOGmPZftlHICuQmVk9EVWeVWoQ+j
 Oweq3V+EdiJ5ieJfHlxeErusnJnzJRw35JYL+iNMC1WTs4LLNdPwipD4DL/0kM=
X-Google-Smtp-Source: AGHT+IGDPbPn6E96TxLsFpD/U4jswqByjhvj3E+Mnsni2vPCFZ6BsAu2rg+ehYQYEcb6HvRY36Qc8g==
X-Received: by 2002:a17:902:e811:b0:211:f81f:8949 with SMTP id
 d9443c01a7336-21500fdd6aemr194269255ad.0.1732948413121; 
 Fri, 29 Nov 2024 22:33:33 -0800 (PST)
Received: from [157.82.207.167] ([157.82.207.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2152f06a4f5sm34566795ad.86.2024.11.29.22.33.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 22:33:32 -0800 (PST)
Message-ID: <aa724c83-df51-48a4-a697-586b90ed3f0e@daynix.com>
Date: Sat, 30 Nov 2024 15:33:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 15/15] hw/vmapple/vmapple: Add vmapple machine type
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
 <20241129152506.59390-16-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241129152506.59390-16-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2024/11/30 0:25, Phil Dennis-Jordan wrote:
> From: Alexander Graf <graf@amazon.com>
> 
> Apple defines a new "vmapple" machine type as part of its proprietary
> macOS Virtualization.Framework vmm. This machine type is similar to the
> virt one, but with subtle differences in base devices, a few special
> vmapple device additions and a vastly different boot chain.
> 
> This patch reimplements this machine type in QEMU. To use it, you
> have to have a readily installed version of macOS for VMApple,
> run on macOS with -accel hvf, pass the Virtualization.Framework
> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> and pass aux and root volume as virtio drives. In addition, you also
> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
> 
> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>      -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>      -drive file=aux,if=pflash,format=raw \
>      -drive file=root,if=pflash,format=raw \
>      -drive file=aux,if=none,id=aux,format=raw \
>      -device vmapple-virtio-aux,drive=aux \
>      -drive file=root,if=none,id=root,format=raw \
>      -device vmapple-virtio-root,drive=root
> 
> With all these in place, you should be able to see macOS booting
> successfully.
> 
> Known issues:
>   - Keyboard and mouse/tablet input is laggy. The reason for this is
>     either that macOS's XHCI driver is broken when the device/platform
>     does not support MSI/MSI-X, or there's some unfortunate interplay
>     with Qemu's XHCI implementation in this scenario.
>   - Currently only macOS 12 guests are supported. The boot process for
>     13+ will need further investigation and adjustment.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Finally I confirmed macOS 12 boots on M2 MacBook Air. Thank you for 
keeping working on this series!

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>

