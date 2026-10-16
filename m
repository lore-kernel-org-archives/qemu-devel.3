Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59507CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 10:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHf3Z-00048S-NN; Fri, 16 Oct 2026 06:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHf3X-00047h-VC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 06:20:56 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHf3V-0002rs-8C
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 06:20:55 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ad98c3fb15so53145317b3.2
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 03:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792146051; cv=none;
 d=google.com; s=arc-20260327;
 b=X7xhUlgd7RwCWDMX6uMDnLcfiqLAL40FPohA5PJrn7EnEwzjPBk2x+4KQO3JHCbijc
 eoY+MlpFFAdVXebFZjDaP8kQnH9lDw3gtYp36U484CzV84pI45bD35tWW3buAbKVT9NA
 vTiBnWuju5GR33RIXaZSllCD/Pc5lK7dh1W0UcyKh1PdasUZ+dmRDtPwe2zxEr8Sr6N1
 cE8hP8YTZee1zoe8NIDBs5gD3W0k1ozaRry44fkn7bi0hu6zSxZoIfqgHARyGQTjeoBj
 tUuN6pkajiTLAq60ZbatyRUkchUZM2BHNNgGwirLTj7ZDKcrXV9oL9gmdhEvCJhPpUwJ
 W0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+lR+yCq7Sj2LV7d8680iILAoFQX7r0VH1tOrFRtbZ7g=;
 fh=VCK6kK/ffHwyx1hgstXUggCNBAgfH55deGh+EG/9DGQ=;
 b=enm0wQlm5cnsx5I9gBKwfzUF2n6r9jJwprQVoqKW29ncO8LsgmNcoqkbYR6JT2A3Gq
 pB6QNucD41aqnlzrhk8TwReLqdHnKBiRur3/QhNzvVroUYYF7yVse69JF9pIiQsL1KKK
 u4C2JagmC6t2OrdjLgO82JN4vbXTTDAXr4j8OaNw6k92R0RdiyMqNCpDaQOD6/Yp33QK
 ern35Xz9NSr7vN62h7ziRkwd05B3mbzs2pQ+IAV3ypqSc0lZQNaiXSew13Gb2jbKYg45
 jaXIYV9sTkau93md2hqDlfGsJmTBopHGCV8d4Dal7zBhrxJTpmAs9CwnW4/Bu15AJGpL
 1tcA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792146051; x=1792750851; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+lR+yCq7Sj2LV7d8680iILAoFQX7r0VH1tOrFRtbZ7g=;
 b=rnl2EoNq34uDqmATu80EhNE0EkgAfyvuZPc0cK9q6s52yYOZ4hy6TfsNhq4xos54SJ
 r/1+G091HWsihX8ztnglawe1XRWyagkGHbglBtZWWjUFQrYKnvSPoHdO/01U1J8FMAjQ
 S2LS157V84f/fwNAVygKBSjt+SP7kzXoAgee71wUTvIRsfVSBvO7+JYBNgR9dYogc9Ti
 Go+cU1sAXclloK9kYsnaKr2j6tomikstNA3hU99AZKGPtqjO5oYtznTXQuAfrCR9yOhA
 YgW0dTXbApBLBNvua6qMFIkxMqGF/vGdj4ibYU6NkNl4a5C+IguGmM73kbbktQn/WnVF
 ZpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792146051; x=1792750851;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+lR+yCq7Sj2LV7d8680iILAoFQX7r0VH1tOrFRtbZ7g=;
 b=tmpUGvAcdZgjPn7rT5J3CWYMGp5xoIfWkTZ/673FXJ9Tww5FFVPg6JYJDBdMTCdOiH
 jpy1Gm4F/cnmypgZXZElNGYbZFVIgsZWNPUmVJMFMr1hSNhA4qS3PsChJMTkWnab2d/D
 2RFU9RhnkTLVlTPTL0g/8ege1xqS6k//KYtORfADjwy1Vu/nApXdHZ7c4h/ZdTAvnG3w
 FHQeWaQgOCGlgmP9P1RVUPAoA62PMnBFODWXxoDmQ4krXbPsNvj2nVwP47RtKx0l1M2l
 FYisdX257j5/bdLS+4DPMvZaA1pKVFG3VRaum0O42BJLe7BGD68pHbSPFNhOWITESI4i
 splw==
X-Forwarded-Encrypted: i=1;
 AKwUvByvoWCcwpeNCBmE/VY82dt7ftBpSsNYa9zbtITbgPZYqncv6aCC7EcolqKRUWWJNG8LRzIOdJDUCjRT@nongnu.org
X-Gm-Message-State: AFq9FYJtYHhimApVFZ/W5Xcho3bBQHRyAUWdPkU0Dy+2aqZlz1bGVbHd
 xDXd2D0eeo+8UAVdZ+1jWWnVNNwmFjBcu2Gs7irF6q5Hx7F+oPa7V/ZohNeuKvSan68Usovj8l8
 Vw00aSUHLcDdarsEtNsQ2Pa1UsBQEh8O4xC1HsxUs+g==
X-Gm-Gg: AYBFou2Vk2H2yu2FaBTJ4u3FpbOs+tiTwek9FP0JyATVfco0aKlK4/qna/S6g08kLA9
 OcFhSeMYx9HHghyxTLCxzuEEdp0wbskZ38spN+p5rQwF4t2RsMC65hJ6OyuORU4yy5vCPqp+GVP
 EjhOKkxE4b0E3HkFQ50iR5H3+jsZsuarVsGfBb+CcXEjfEsCA5ILr/3tMH9ykFY8X0BpnJsSNwU
 0tyUte6eDRi0uO/I1SG8hFDFoAQqC4G3TfJkjw+BRYvXwFMrlwFWt6fJSSgFMmGeF8zhyhfYbay
 IJlbPfksbGEY4/hEzYz3rWVH6GTB+e607qiSlTfOUoWFq4+GBOQTdv5gPycLn1TDq59kojolVqU
 rJtjmOGAGAaqiD4c7hhcnOGZrgDPY03QjD1ufnUA=
X-Received: by 2002:a05:690c:6e87:b0:8b0:76e5:ecf0 with SMTP id
 00721157ae682-8b07eca01c7mr85352197b3.4.1792146051284; Fri, 16 Oct 2026
 03:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
In-Reply-To: <tencent_22E95650AA60C6E59860452C0D61A21F1105@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 11:20:39 +0100
X-Gm-Features: AclHuK8ndLRSRJrGsRvAby9xi6rLxv6SVuahyYs5pcQX4zLAV6e0Eey50G4DPd4
Message-ID: <CAFEAcA8MyrqWC7=A5Bw0G5G-2J64iTLmfY33dNDLm0jvmRb+Eg@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add Arm MPAM emulation
To: Jinjie Ruan <2118537295@qq.com>
Cc: anisinha@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 imammedo@redhat.com, michael.roth@amd.com, mst@redhat.com, 
 pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 ruanjinjie@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Fri, 16 Oct 2026 at 10:47, Jinjie Ruan <2118537295@qq.com> wrote:
>
> From: Jinjie Ruan <ruanjinjie@huawei.com>
>
> MPAM (Memory System Resource Partitioning and Monitoring) is Arm's
> architecture for partitioning and monitoring system memory resources
> - Cache portions
> - Capacity limits
> - Memory bandwidth and priority
>
> And MPAM is the Arm counterpart of x86 RDT, which Linux exposes to user
> space via resctrl.
>
> QEMU so far has no MPAM support at all: the CPU-side system registers
> are missing (a guest kernel that probes FEAT_MPAM takes an UNDEFINED
> exception), and there are no Memory System Components (MSCs), so a virt
> guest cannot exercise resctrl on Arm.
>
> This series adds MPAM 1.1 emulation for the virt machine,
> and the structure is as below:

> With this, a Linux guest booted with -M virt,mpam=on (plus NUMA nodes)
> mounts resctrl with the full schemata set (L2/L3 CAT, capacity, MBA,
> priority), and MBM bandwidth and L2/L3 occupancy counters track the
> configured controls.

I guess my question here is "how much is this actually doing,
and how much is it 'we provide enough software-facing interface
to keep the guest happy'" ? My (rather shallow) understanding of
MPAM is that it's essentially adding tags to memory transactions
and then accounting how much bandwidth each tag is using. That
seems obviously infeasible for emulation, but on the other hand
this looks like it's rather larger than a minimal "we provide
the register interface but it does nothing", so what are we doing?

thanks
-- PMM

