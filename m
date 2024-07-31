Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0614CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7g6-00050j-VP; Wed, 31 Jul 2024 07:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ7g5-0004vu-0a
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:39:33 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sZ7g2-0002L1-Mh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:39:32 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ab2baf13d9so8068524a12.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722425967; x=1723030767; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9aiq++bdNk44vu8pBxgjGzZR8HEkDbz3gF4BkYmxTlQ=;
 b=B3GXc1QHwzxHap9lcAPiy15nwTcrAZbbh5zqLGQQM2AjOCy5fqBU5wi2UJuPfsg311
 xHoeZd/csmhFwsh/mvCUomAQBe0Wc4QMQYLvY51vpRP4wBARerxDVqup8U+yKa07SxsB
 Lq12+vokn9nWnGrVr0XpiUj/KuKjLKaj9yIJfvx2D1FrFTDxjHgR6nvu8q4y+H8k+S5K
 zXjF74hNf8BaXBOCkBHDHmxvOpr9hW8AF0CXFjiyQvO3cldC7E00nXfJxv7XQ/jU4H3a
 4n0kytVAgS2fKzPvTtLs59ud6wOJLgLy/YqtMduiQma0XL3Iv9FMvR8jlMybcd1DYmnD
 LPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722425967; x=1723030767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9aiq++bdNk44vu8pBxgjGzZR8HEkDbz3gF4BkYmxTlQ=;
 b=DvymTbvdExgfvXikA+/6QspveLlxuTpr+OX77PAKntyVx9VSNIMEeEWAvgWgtLDBFb
 yw4o5blAC/OPPYfH0HC/+QXkCaGcoAagMz7e/KNaXpDmZsOGW0O1fS47YET9CKWaVjJv
 nkVPXphVcfAWt0V2OxThRTIS4YkXQnj6uCTonqY47mzPGQqh8iJR91tLYIyIJ+yca3y8
 U/XtCnifDEydxlChJmYbCZJ2y/Qj5GKsENz/7nfPLdyo2+Wtm+iGuh+rN3dYSM0GSfuv
 oIGNtwA5fuw7SrpQHsOSJf3FFOzccZBrNFMW/vrtMPIMz1o8CH00W+v28xRA55+IR0Y/
 cOpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo8RAXRTWHu5eXueBTBuANx77UMuDBwpc9IXI8MZjxX2IMKobkMBNJY+3Sk2Irk4IT9MV51hRW2QAACaR9er9MtL3QE/g=
X-Gm-Message-State: AOJu0YzHJ+asTEIeHhvLRykcqRKbddtH4kyg8OzZYcw7DPBu3GUmwUPb
 pBKJu+km/uQLFK2kEiGCWtKQks0aa+qcLbIl2tVJUtbF1PJWjFNH2sjqUs+HHBmOfdVkCk8jgDX
 x6kztCXIQrh2tQc2S42bl/G9FsA2aU/VQ1T1ChA==
X-Google-Smtp-Source: AGHT+IEhk2KY9TqI5RY6PcdaXLOZvwu1zuWW3/ZTj9B6nsvrnnlDIrMnFYwUw3MYrxvmYUzHFBSKil8jAhJhJ+c524c=
X-Received: by 2002:a50:9e6b:0:b0:5a3:b866:eaef with SMTP id
 4fb4d7f45d1cf-5b0223da231mr7630727a12.31.1722425967297; Wed, 31 Jul 2024
 04:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240725145132.99355-1-salil.mehta@huawei.com>
 <20240726113355.731e61fe@imammedo.users.ipa.redhat.com>
 <ae5fa879bb7d416b92face2dcf9045fd@huawei.com>
In-Reply-To: <ae5fa879bb7d416b92face2dcf9045fd@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jul 2024 12:39:16 +0100
Message-ID: <CAFEAcA-MrfFiJcrKabz2MYiu6VHju6+yUAeeLB7MBrT-0tAWCw@mail.gmail.com>
Subject: Re: [PATCH] accel/kvm/kvm-all: Fixes the missing break in vCPU unpark
 logic
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mtsirkin@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, 
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "will@kernel.org" <will@kernel.org>, "gshan@redhat.com" <gshan@redhat.com>, 
 "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, 
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>, 
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>, 
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>, 
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>, 
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, 
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, 
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, Linuxarm <linuxarm@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 31 Jul 2024 at 09:49, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hello,
>
> A quick check and a gentle reminder, has this patch been accepted?

Thanks for the ping. I'm doing a target-arm pullreq tomorrow
so I'll take it via my queue.

-- PMM

