Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8011FD4F06
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzxV-0008Ez-6l; Tue, 10 Mar 2026 12:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzzx5-0007yj-1Q
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:29:06 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzzx2-0001I0-N5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:28:58 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9431300833so646119866b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773160134; cv=none;
 d=google.com; s=arc-20240605;
 b=Ruo1silKBxEVhvx5l3Zit7xvAZFvlPZxBFXR7HaiteSmQFxLNQof157qo9QgA2IEBg
 4SpNt9EuQwcvk9e1we183WBBDiZB9W0gLgS6d+vgyWO/nr59/iZ3yRD9qn8AxYoUulJv
 rmQkgjPoxwDLthhBfyXauryYlO/1oM3oq/69Xe7LrKIZTR1AkaYncNFWF72smK8498kr
 khq5IwJz4pEfq0YpfYUHJfSxR9PqmiZE3soZFYDFddYyCOjeSEgYsWyPTfvKOBlIESrR
 HvX+XNki3QyoYA90Zc1FhJY7xgBuaQQzGYHUihJIIbRTjEd+bQ+DlfusmX5njAg9YGhD
 WQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rDOJzRJgvRnoQMTn0/1EDuwrWmtMMjQYCv/kYueYCb0=;
 fh=szxFNaSoOpcJnTpCN/AiwkbHrrkv2h/jodafTNo92Dc=;
 b=f9P/pkoCIWzL+HxKDfqD7ZQTsGq1EDCXN6/8W1UAb78Kh6fWlNF26gdNg8Xx7sAV0w
 H1Rlu/RzK1NxKtGwC++c/R76uq5smqs9Na6qbULZHsHwxIUObuD2vwJrw78OJT+kQkvY
 Y+d0MRO/EQOfOla8vRYckQFuaNfG2tyc8hrAEaV9VPE4R8+u22WSPPB10e2R7qwSwXZq
 W3fK82S3tH9AD0W6PFm3M8yLEUB9WrJqvaxxV1I//jlXj87LsSHF0DQZC7Y4eOJ6rnfs
 wOLFiQoWU7138U4cHi9Qy3RFc4ZyLkgeiTx1Jb6LL3KYfPOUTa2RCWmanqZPKR5wMVwF
 t8NQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773160134; x=1773764934; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rDOJzRJgvRnoQMTn0/1EDuwrWmtMMjQYCv/kYueYCb0=;
 b=WllsYZfLeiQxi1Ie1RlNylPNF2UQw3Ovl206qAO4o0ZDzTcIdElXPXI41/NybgSrb1
 uxFgVpWLRF1B0/1nAPGv1w3A7aR7H9URID0txWB8sXlSRaNIbxilZDqZe54Ns2FvLV+2
 /+Fuy4DvH8bCCbtEfc6CkzrhtbndD+nGn5WjrQLwYBIibC1RUQLsL7J/EsImVbovcX2t
 Qp68WWiMLpS4+RT5OShtoUUcKFu2j65RXxHBRIlyKdrY1TAx3fzK0231FGbokdjIhL2Q
 FD9q0yjD+hFP6AVY7th2fDT0+dADmNJqCnM6YSkxoe21c4j/R+HkLAjAgES4e1l+EOwR
 ZMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773160134; x=1773764934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDOJzRJgvRnoQMTn0/1EDuwrWmtMMjQYCv/kYueYCb0=;
 b=tdOBj4WOvoX5GK9o7OLhNWMW+AbcFKtTqT8QuvWERJIB7RxaG0stCJrrmZlOj+iTI6
 sBwNfShpBr8XGIZJhHVOg+PiwjM8/+B2v1rL3bHfTDh5otoVmtxB+zUCjunMqw0syDUz
 aRwlyYvNFLOge9+Y5DGVSw56ProqsWspnKsdPQc8ABx+zDpYa24aEfPu2usVGGAPm4pT
 xAZg/JekU7z79uEaiPW9xknZpUGbMbuTQsQBxQ03gA9vqBXfCgXbbXv5ZS00+Pzebk1r
 CGoXiSeQoOV2pPXQMNYPWyH60POnAlOCLhCfQ/uC9v4H6M5FTwPIajabX5+5MLpLRLcL
 F9dQ==
X-Gm-Message-State: AOJu0YxDw56osOwvikKA0YCqv6UcwUnCNtCOdSlwDL4jpS9aXFNljI20
 KmPI4lhvavXS2TlG7GTNY+4LwWhxDHc6nLIikbTpRKPj/lycjrpIYqxUX3Ly2ceQILZCc2vwjN0
 Dyn0dP5QACe0V1LqFIyPXAb9PTKfSVJfy4vWkhA8onQ==
X-Gm-Gg: ATEYQzxQcp6tO3+ZIIgVZbuEPzHe3q/8yaL2JltnmfTFXexA2j+l9iZ6V5xBzuSlv55
 bZM9WoT+s1S0/CKAroy7nkG29Rg9UZxvi9pQMzhfuTyn5crauWuZR89+/zzhj4i4GAUDWtG3tCl
 sTfBTb7jImVprFkP310I3asM5TKWgsU6GE/OMFS07NHqfxuAyUfIRtxAgSfHE2s11u0A2nbPVlk
 igrOMhdKdWGMlyivE5R3OMqVUUdGa3eVocH/aA8QVkRZYuWuo8HwdMAkDvqFxuTPZALUkrO5tln
 xAarK3kIzU0EOxVZOHSp++sp8JytXfsHDZJjHhRdVqrVuKpZKSryFdcxatutE9BPqU4=
X-Received: by 2002:a17:907:7f94:b0:b96:2fc8:9c10 with SMTP id
 a640c23a62f3a-b962fc8cc0cmr642521866b.23.1773160133612; Tue, 10 Mar 2026
 09:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
 <CAFEAcA9FjtvJanmbvpAXMjY0zURZch9PruHUsXEXOtPiVJgarg@mail.gmail.com>
 <1389084e-3ed8-4a5c-aac5-bfee420b0916@linux.ibm.com>
In-Reply-To: <1389084e-3ed8-4a5c-aac5-bfee420b0916@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 16:28:35 +0000
X-Gm-Features: AaiRm52h4SQIT2TUvWSKPJnTwZOAbranEWs0xCZkrGNbktZ97s0iEEC6nOeWn7g
Message-ID: <CAFEAcA-vrKxh3f4ZUuXA3WShbNVMoi-L_vDPiWWSVMiY2s78UQ@mail.gmail.com>
Subject: Re: [PULL 00/10] PPC PR for 11.0 soft-freeze
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, adityag@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 10 Mar 2026 at 16:14, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> + Aditya
>
> Hi Peter,
>
> Is there a way to trigger aarch64-macos-build and x64-freebsd-14-build
> from Qemu gitlab CI? I had run the CI pipeline with below job and I do
> not see those tests getting listed/executed:
>
> https://gitlab.com/harshpb/qemu/-/pipelines/2375854439

Yeah, some of the CI jobs are not run under user pipelines
because they use external/project resources. I think the
macos and freebsd ones run via Cirrus.

-- PMM

