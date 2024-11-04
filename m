Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412E0D132C1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7x78-0002TO-TP; Mon, 04 Nov 2024 08:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7x6w-0002SW-V9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:27:16 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7x6v-0000Zk-7k
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:27:14 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so6180602a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 05:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730726831; x=1731331631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AkttCzgUV3BRt8IPVgGGCOwte4MCCFD2pradZxoj/H0=;
 b=MR6PydMsGMx6gwEkvNzi4XPJMQ+URjntmWUwZn9SNYzRtlMRIuzgwaZC7wzzeFm+3a
 OOIMCO5ulzbaxv35y5TSfCSADL0ml0z/kE3FEP/qRIrj+F/1Lbow16P9BNAzy+LQgtrY
 2TXJtcGzsXFVkR4lJluRWkO7b0abfwTgvfMDWUzHQC35UuO8+31LFITqeV8qc1v0l3c+
 hy0RvKizge952TAWYswFiuKLPPcvBOIjbraUyRNEZdrTNmJ7qzskbeEmXwa5dOiQnR51
 aHTsqd6BLeW0/4veud/EK1Rm0IL1d5cMTI45bMRiEejRDFpufkYNZ3GKJpCOnMAXBlXE
 p2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730726831; x=1731331631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AkttCzgUV3BRt8IPVgGGCOwte4MCCFD2pradZxoj/H0=;
 b=hlKZlDwrUzC5qP/Kkg+UAZuFdrsgw+O/05xATkzhd1kXYfd6ZwngF8mB89KfjBphZF
 A/5mDMiWcgUJrO2xdaDyuFMwyCnpumlYQMgNecViGiDMM/A1GOdaR6M9aUstT6+OfAjy
 xPKLoztlodfpd3H7Kh1wHXilk9YiS4m8OgKHgHXLej9GVB7cvLCS14ckqCkVGPT/hgMc
 tPEJW6+XuhCIS0R8iGQ+5AZF7JPaGbHH/j81N3uEtj1d7OIyixu5V5ovwpmXsgZczg5u
 LouhqL5wrNXRG4Nj/tIpCkpQa+9Am19GN2X18UBfDjUoeqbE831Xh6C7Eb+0Bl6A4D/5
 agYg==
X-Gm-Message-State: AOJu0YyIEQpktTrb0/YzXMcWac2Hn15JNZ2d6Tbdr3f6wKfkKsjrN3lt
 GqJ9BRplc7DZ59IEwi7zR3wTyQ9IcDUt/ZyYRZiju+Vl2shzuxpZGRsBvB5PSKfGP18JF3kgeKx
 yuWZ+h7Qp+NT7VYZJM4piz9kmLRL9sSjyGa4v7A==
X-Google-Smtp-Source: AGHT+IFXAkc6iIy34i7xg898djnsHLTDuDGjZ2mN0WPUbUdzvkLwwto8V/maKZsbdiwr0farIxVEE3qUUZn+/Syf25g=
X-Received: by 2002:a05:6402:2111:b0:5ce:dfbc:7fa5 with SMTP id
 4fb4d7f45d1cf-5cedfbc8197mr937401a12.25.1730726831066; Mon, 04 Nov 2024
 05:27:11 -0800 (PST)
MIME-Version: 1.0
References: <20241103152455.202462-1-salil.mehta@huawei.com>
In-Reply-To: <20241103152455.202462-1-salil.mehta@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 13:26:59 +0000
Message-ID: <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
Subject: Re: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
To: Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com, 
 richard.henderson@linaro.org, jonathan.cameron@huawei.com, 
 alex.bennee@linaro.org, imammedo@redhat.com, pbonzini@redhat.com, 
 gshan@redhat.com, maz@kernel.org, will@kernel.org, oliver.upton@linux.dev, 
 jean-philippe@linaro.org, lpieralisi@kernel.org, david@redhat.com, 
 philmd@linaro.org, andrew.jones@linux.dev, eric.auger@redhat.com, 
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk, 
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, 
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com, 
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com, 
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com, 
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com, 
 zhao1.liu@intel.com, linuxarm@huawei.com, gustavo.romero@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 3 Nov 2024 at 15:25, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Extract common GIC and CPU interrupt wiring code to improve code
> readability and modularity, supporting reuse in future patch sets. This
> refactor is benign and introduces *no* functional changes.
>
> Note: This patch has been isolated from a larger patch set to facilitate
> early merging and reduce the complexity of the original set, as it
> operates independently. All original tags and author contributions are
> retained.

I would prefer to see refactoring patches in the context of
the series that makes them necessary. As it stands, there
doesn't really seem to be much benefit to this change.

thanks
-- PMM

