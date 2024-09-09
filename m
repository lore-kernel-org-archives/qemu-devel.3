Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66ABECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 10:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snbH4-0004bV-OL; Mon, 09 Sep 2024 06:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1snbGu-0004YZ-Ff
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:05:26 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1snbGs-00088G-Pn
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 06:05:24 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so326990466b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725876320; x=1726481120; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UDW7Y/FkHlm7foc3nBKUG2Quqbrny0XbGq22zLlogVQ=;
 b=r64LMMAArInyrGT4P3In8+PQT5dUvYv4vBoP1bBvfLvnaSsfpqS49kxOmFoOVOidnx
 NBCfCuXaOzqNesbF05WhI5UfDEeg9TlP3T6zSdG89jioIuEMN06XUmyfzK5OXIoIQb/7
 cwzenLquzo7FpqFXqyBtx7mnMU61jtV8/p53Exgy3xjr9pkx8+tezcVChssdmPcFTY/k
 72wUBWuBRvVFKFm2OjIgK55UhUcTej2BqNBl0w92fkmjqItQsaY1HvjhB/e2PVeE4n+X
 NUK6IX0Xaq/7i8HiUYav77pdGLRmjY6z7iYXjgDAvqO8beSo/0fbEzUI4156WdAAZp4+
 ETVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725876320; x=1726481120;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDW7Y/FkHlm7foc3nBKUG2Quqbrny0XbGq22zLlogVQ=;
 b=fEDttgJvpkG1KMGnX23ih9Qnm9dI0zu+LqfLsEiOLRpOJNlhqcbseddTvucx+BSEGO
 h0QkAaSdPA7WyqkB7uFLFWPJ1xK348DHcJjX7C8tjv70g5TOotAyKNvdRwNF0MeG7N/n
 TQsMF0IklaEfa4gGyFhh0vbGYVNTHNt8G79MPMegl5aQG+ZRvqbX4Ef59Fcep4xc+sL9
 2gNbgqNmjIlFdPsqlEuJjswY4wavR2eLR0N1P6hu0T8/HeUZ59DH7iyASK1MAXWTb/Fg
 IDABePDuXLWji9FnB+gnDW/oxi+SG0pGS6Glm/Ohq6D0YBwAfeHGD1rwbJyXy7+t9uYt
 VP/Q==
X-Gm-Message-State: AOJu0Yy0WGizDKhHw3sTEES74/CIOaal1B/UF1+D7AttgIFhqHhuIksW
 529W9aKnlGUngV3GBnilH0hIJi+pApxJLOZ1IXGY/e/6EXr6Cxj3m4LIhqOgFpI=
X-Google-Smtp-Source: AGHT+IE6lyWp5zqxevMPsQzugYFaDvJXsjA+BJH/vPHmgVDm/0MzkLQWUx6FwpKR8cMYtv9YXiHHPg==
X-Received: by 2002:a17:907:801:b0:a77:b4e3:4fca with SMTP id
 a640c23a62f3a-a8a885bfbe1mr1131892566b.9.1725876319229; 
 Mon, 09 Sep 2024 03:05:19 -0700 (PDT)
Received: from [192.168.200.25] (83.11.24.101.ipv4.supernova.orange.pl.
 [83.11.24.101]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61258sm317749066b.116.2024.09.09.03.05.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 03:05:18 -0700 (PDT)
Message-ID: <e632758d-893f-4a44-b081-9fdd92c19548@linaro.org>
Date: Mon, 9 Sep 2024 12:05:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] hw/arm/sbsa-ref: Enable CXL Host Bridge by pxb-cxl
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, Jonathan.Cameron@Huawei.com, 
 quic_llindhol@quicinc.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn, shuyiqi@phytium.com.cn
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
 <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62d.google.com
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

On 30.08.2024 06:15, Yuquan Wang wrote:
> The memory layout places 1M space for 16 host bridge register regions
> in the sbsa-ref memmap. In addition, this creates a default pxb-cxl
> (bus_nr=0xfe) bridge with one cxl-rp on sbsa-ref.

With this patchset applied I no longer can add pcie devices to sbsa-ref.

-device nvme,serial=deadbeef,bus=root_port_for_nvme1,drive=hdd
-drive file=disks/full-debian.hddimg,format=raw,id=hdd,if=none

Normally this adds NVME as pcie device but now it probably ends on 
pxb-cxl bus instead.

Also please bump platform_version.minor and document adding CXL in 
docs/system/arm/sbsa.rst file.

