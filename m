Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01B2D44D59
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 13:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8fgH-0003bO-1o; Wed, 06 Nov 2024 08:02:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8fev-0003OL-G5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:01:35 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8fei-0008LX-RF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 08:01:10 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9e8522c10bso138570566b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 05:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730898055; x=1731502855; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jhFk8sXF0+0vMDlC/wtmfmSOJXSyyl3ZNW10dFJvH8s=;
 b=smMpfaLT3X+xZtJp4dba41BDLRVtuTXbjRRdIYT7G4kXNCT4n4IPnAwsb78Q9aEyIb
 WpK37+1hneSMJZl4AylYqkGkaHM+LwJMEcQ3rowZFIAUux9H07i0t2SlhZSl9uwNI0v5
 JifMAULGwJv//3NQat8VUxAw4lDfpHxMnvj+lLSRaBxfah7IYbAmrPCqYzVxub1+0rNK
 8JoDp1yonKToSwR1a8/YOPsb+HHE4CInH6eh5Y7zqgO9weWdohuH3hskp+RWvrhDsPGP
 do66hiPEl+LOGiVPLzzC8n8ucXUw0bkbUrTXjN4YTy0VgwgTVhxqWfGrMsrjessMRBgI
 4njw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730898055; x=1731502855;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jhFk8sXF0+0vMDlC/wtmfmSOJXSyyl3ZNW10dFJvH8s=;
 b=lBCAm7YP0NepWEG2NbtIfDNaZ2otqESwZFCYTnwLlSc6qtJqLEXwZp+VmGlYCPW1/o
 V8YHSooPoJA5EkDPFTJEfk0tYvZrJPv617mBijTN6mgQH/6mGYW5HpQt5cXiTkkpJaf7
 y8WnWo38Dy3wR3gX81MmlWXECNDmjko8Nb110nH+2SbVN7k+VUUXyTSXhglngfYwY4wE
 Ke8O5m3zrsF0LJTyAz/MuTjInsa+rqt6F4fmUQuRgSNIiLbHF2/MA6F3ebzY9kfh/D4O
 YJ6/O8vN4hcvLfgROEMp+eG/mz7Odnb3MsIUoYZT5WAqxKb1g3LvKyo2Wk7L5q2rKGYM
 o3ZQ==
X-Gm-Message-State: AOJu0Yy8zfeoEjE1yZYwygEnrdTF/wz/NjqFj5dyLWWyX9/2qSReFoFz
 3un0Yhi20ux5im4RYCVval2wIrpB+pS5aN4a47Air8F/dV0wz6sqMxasUJZ7R646EFWEmSoIgqO
 kEGICqc3/7F7pZCJ1Wj6o4K576MWy7ZnV0WvjPg==
X-Google-Smtp-Source: AGHT+IEIbv26AHpMeik7ogNJXmmv7jlx0fvLwc8iofMhChEjjQZWYkmy4g3sNHHoo06SCHcsU5ueSbiN9951z8EOu/s=
X-Received: by 2002:a17:907:9805:b0:a9d:e1cf:b9d3 with SMTP id
 a640c23a62f3a-a9ec66049bfmr283588166b.12.1730898054735; Wed, 06 Nov 2024
 05:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20241103152455.202462-1-salil.mehta@huawei.com>
 <CAFEAcA91DoU4dAHYy6OOeMjEQ+0LGZX8KM-rKsCh89UnFS4yTQ@mail.gmail.com>
 <7d27ceab963441dc8355d06e6bc4b88d@huawei.com>
In-Reply-To: <7d27ceab963441dc8355d06e6bc4b88d@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 13:00:43 +0000
Message-ID: <CAFEAcA9Jhz9a-X0B_bW++3kUePzTENJfq520A0CEst1o+QES4Q@mail.gmail.com>
Subject: Re: [PATCH] arm/virt: Extract common code to wire GICC<->vCPU IRQs
 for reuse
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, 
 "maz@kernel.org" <maz@kernel.org>, "will@kernel.org" <will@kernel.org>, 
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, 
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
 "shahuang@redhat.com" <shahuang@redhat.com>, 
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, Linuxarm <linuxarm@huawei.com>, 
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Tue, 5 Nov 2024 at 22:20, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> HI Peter,
>
> >  From: Peter Maydell <peter.maydell@linaro.org>
> >  Sent: Monday, November 4, 2024 1:27 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >
> >  On Sun, 3 Nov 2024 at 15:25, Salil Mehta <salil.mehta@huawei.com> wrote:
> >  >
> >  > Extract common GIC and CPU interrupt wiring code to improve code
> >  > readability and modularity, supporting reuse in future patch sets.
> >  > This refactor is benign and introduces *no* functional changes.
> >  >
> >  > Note: This patch has been isolated from a larger patch set to
> >  > facilitate early merging and reduce the complexity of the original
> >  > set, as it operates independently. All original tags and author
> >  > contributions are retained.
> >
> >  I would prefer to see refactoring patches in the context of the series that
> >  makes them necessary. As it stands, there doesn't really seem to be much
> >  benefit to this change.
>
>
> Ok no issues. Just to confirm, your above comment is just specific to this patch
> or all the 3 individual patches I had sent for review?

It applies to all of them (and as a general principle).

thanks
-- PMM

