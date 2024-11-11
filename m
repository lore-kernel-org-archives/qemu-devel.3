Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E859D12D72
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 04:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAMRv-0002SU-TS; Sun, 10 Nov 2024 23:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMRq-0002RS-DR
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 23:54:48 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMRn-0006Cz-Tt
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 23:54:46 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20caccadbeeso44171145ad.2
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 20:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731300882; x=1731905682;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0yweXBd5sbwo/GvOeh4/3/Gq/Z0XExwXwiJcl/TYX4w=;
 b=v3AFvuf80K1dPlU9pBrJAMborlhOxKamh51HW6BgDVZpJdcTPEoSApT5ktyF+jEg7a
 eQgb2YLcjRhSA5lg/rhjzbpTlCj0/mPGP8RzmL4ld3Tc9bCbqgzDtOX1LJ++ZCsuzO5d
 ijIUI47cBzT2UOag58n8cUakN2IXc7c/nxbolBuDXepOz3/QDBBBIu8va80EHL9ZDw+c
 9wtQcTXN4L7xFm0I4aMSSJ9zpm3YSRvSk4B8vQyLIh1Ex1mikkz5oydeDlI98daSNO0T
 ++sG9boFEMBEdo3XhOLszhGkp8Tk3xrvD2qlZKjgdkMYk8ludG9S81zp9JoA6aV8xsUX
 pdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731300882; x=1731905682;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0yweXBd5sbwo/GvOeh4/3/Gq/Z0XExwXwiJcl/TYX4w=;
 b=j4EOXDd4wAxZD8PdFgZB3tnp2/YBlA1ZgIOJBGKs6afZSG/V7xwVOab6fkr/jOHc8Z
 MixGpjdvomK53eF6WuTpQpLP8UQdtenNnlvQWq9dG5iBF3MgAujUV3ifd+zB7iiv578e
 cE3Wtsew3PeO9daNfGVYQgPCFwjOIUXG0H2EiQ6Ud5VyCQPkeyp3olsykSSRD8D6VDLp
 tnMhf8h4erUQ2PKLrHGTmSB6uAeSafZymI7K+O+F7oHRgT6saszJMzh2qsJ4yBSbFnIU
 W3Moq8IWuVBvEtRbVi+7At+bEDiGZzrJ2z64jgGxUWnBe6vWEVeCknf+4G46xSxkodSz
 RH8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqsUlPbRS8d6G94gS8d+w5gU5BXsV79Hk1GQRsGCi1woxabCWHKFaTPuD+RJ/wqbRR5UvZk9T+8YBk@nongnu.org
X-Gm-Message-State: AOJu0YyRrjpyX7GpVd8qxTQoogcRfDBLxVIkaEk2a3RN0FO4aPyHZFGA
 fDi6fReA01DOidEEZ4XJ04t4UHtaCFIbaIAlGeun4MsXETdAK2lJVbSdripwKz0XXVctueGAxyb
 ENOY=
X-Google-Smtp-Source: AGHT+IFehdKJ+mOkWBFotsDN4mntlT4dZFZOKKMypfXAcyl0Q7havmKCN+Kd1yUZ4fBifIA75T11lQ==
X-Received: by 2002:a17:902:e891:b0:20c:7720:59b8 with SMTP id
 d9443c01a7336-211834dfbebmr151646825ad.6.1731300882225; 
 Sun, 10 Nov 2024 20:54:42 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e594c5sm65728615ad.200.2024.11.10.20.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 20:54:41 -0800 (PST)
Message-ID: <7f62a167-1ead-45a2-8946-7f4c0b982686@daynix.com>
Date: Mon, 11 Nov 2024 13:54:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] hw/display/apple-gfx: Adds configurable mode list
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
 qemu-block@nongnu.org, qemu-riscv@nongnu.org
References: <20241110215519.49150-1-phil@philjordan.eu>
 <20241110215519.49150-5-phil@philjordan.eu>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241110215519.49150-5-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

On 2024/11/11 6:55, Phil Dennis-Jordan wrote:
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

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

