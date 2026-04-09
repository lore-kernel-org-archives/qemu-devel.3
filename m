Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E953CEA3C59
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoh9-000111-HV; Thu, 09 Apr 2026 08:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAoh1-00010P-NF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:41:09 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAogy-0001kn-Qo
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:41:06 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64937edbc9eso766476d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 05:41:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775738461; cv=none;
 d=google.com; s=arc-20240605;
 b=QkbC9s9xK5XD6tjTkxXAku0JG/lJy8YfzplINv7i8cPNwslFZ0qBOM4pz8ZLwYU8UN
 n29YBDorBgKAVeXBMt1fQttrtY2ej61S2aY97KRmM/g3D2OHIOGicUOw0TOkU6b/eKK5
 jIIrZIHLpg7Do9Rv/PmvQGWTJniwt20aC34GGcsZbbRILyf3eoR8NrR5eDFrlskES+8V
 I6rn0dWbk5oOmimoQ5SjZCEOjw2JE2x+cuE8pn7X2nib3l6QnmTuOCv1sJgX3pU8L/Io
 cYmd2idIT/F9xWsnaseMbtqx6dMpEXETtL8qslsVTlb8NWqZ3LT+/2Bq5WNwxuwCN4j1
 VdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eUptSgV8Ish7bZ12PrthyWlod2roFlHWVdsxpwFUN9w=;
 fh=eEp4WB/kZwBcsSf9BZsq/ZyQEiWfBp8t4EgfoHdr1yI=;
 b=InO+JxjZTSQdXyUMoMaZLqi9eLeQshtLwQ6Rxlct1yFUwCDFslUSltHqHu8Xps3xaY
 oAGnMR/VtoMBGdA+CE+gYn3CNkNqnfnEN0DpPZ/QQXvvvZDYcueLVay+ufehmeRbIMuk
 1GEGp5/zSLNtnlPEa0tK9epb73EX7pQry7mwD05NbKGhqu6nFAxfSSAJxalAgF4ILruH
 46JUbLnRE29TnsSJC4D4S8FEmKsjVKX9YXnt4GrCYgtWLUz6xQiC3i1SsUP0RNZx5gdl
 aVBmGTzIc+qYhDWMTBGPElJgCvqeGMr3nB8XU4zK+3lF7/SULebF9EholX7J4Mi+E+7O
 Gl3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775738461; x=1776343261; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eUptSgV8Ish7bZ12PrthyWlod2roFlHWVdsxpwFUN9w=;
 b=iN7rHHu4mthp6JktZh9JXo22IP0vsgGOkM76+IruMbhje++/ZClEzRVO52afM6av72
 fZQB9azc9zgDy+njs4/qnGy6xCSigsZAMYstNZia7sRQEaF3jJlnLbruC6KIfwRgspqq
 Mvz9pMJDlfOV9MCIaDHQam5sxWQfP2fnzKKxd48YhuAKMHA/FmQdeM6B6BeB2n9F9IOO
 MIzVAZBt7o2ubq+mmA0KW8Mxl2Zl7KZDdHymfhuECU8KaFXt6uEAIWVIQyQfrG0tfuCK
 RK0LMILUHkVvojCu5sd9ui1jMAcq3K+gxLX6PZ7xTFlDRtxSLTaJ8nJtFQiK7VwhWJIR
 qBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775738461; x=1776343261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUptSgV8Ish7bZ12PrthyWlod2roFlHWVdsxpwFUN9w=;
 b=ZZWhAFtm+YYMXPtCjxK1x56T/HseiIdZabRnaNd9bTQpWTJrO6vpvVDrQtPO/AfyE2
 HfPXP1GftKVox4tRmoG1wiFycJs2yS0pL35m5gunU5itvYs/2C7SYn9987HwRpU4nvou
 QKnkmoTbn0q/2J28KgRAooy6rZx4Bfs2VY7B3JSYSR8LEBnIoqVeMQZDqs8aLjUzrYuA
 4OcQ5V/lDqy6SDpaimvhKkrEthUv0LcmfLHTtt3YvLN+TGyDPDGQM1XAVg5Pf8O7Dru5
 Vi7Ecv4gNHnObTF2suslIzYYljXA+AUlIevZ4ENBLKSh7dO8ws+VwFwtm5Sef5H/8Q1J
 R+Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIf3ZhkdUdSZg1FsQFzcExIxLX1HhV0hzpZICP5H6UI5B8n4rpqj0H5FvRppFTri/lv70LHl0fP8Ek@nongnu.org
X-Gm-Message-State: AOJu0YzB/VpizWjaq9+7ZE3pvRG+HJPxc87rbWxq7ZsavsIKTZXuaGov
 NYnZCVw9HGYklJMLu2izm+8H8CaQt6dSgzUIfGa0Gsvm1kgh58rW3gPXJ1TsWdkCwJEnUUzbCSB
 Gd6tebkqoMA0unpdlMXy9SHIrMooq6uK+ZJLm+0W+lw==
X-Gm-Gg: AeBDiev/62OLCF2Jvc3ab932eALgs6UDpe3beuxPXIfHiBiHtre8eG2opXd3/uOalC2
 EoRWHf9PLk4LyAjthfrejOyVmvwxopmwjUiDUVzbeTGKNLHyxhrNMyfesjQOmV3tMyUUujEIcTS
 OjxZHuU81wNt2JGYUJNaFMPIgjBebCim8brNAGAUETEYFYshcBPIGpUc7eqiTgB4EBTwknzhsOT
 vhtyZRb1Wwd5t9V2J961hg/0n7Axs4DQWxNvRWkoWxDfva/as+XblIOXR4gOAi3xWNWvwjtCNmO
 32Lb0ovZwsCJqrT2ItrKFBvznvGBScYhyfr31Qcp8KEhNdXtbe7rRvEPlMqz5vTiFMM=
X-Received: by 2002:a05:690e:1549:20b0:650:5316:1739 with SMTP id
 956f58d0204a3-6518775226bmr2364724d50.35.1775738461245; Thu, 09 Apr 2026
 05:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260311160609.358-1-alireza.sanaee@huawei.com>
 <23634eb9-95a9-494e-92c8-60615213f349@linaro.org>
In-Reply-To: <23634eb9-95a9-494e-92c8-60615213f349@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 13:40:49 +0100
X-Gm-Features: AQROBzDw2fcZJzWhmFHm8ddxbwuounVHkfkZaLpQRnkEXjCkCrsjmk2vma_-iP4
Message-ID: <CAFEAcA_T7_xuMmw4h11dcsKBzVSFT=wEWMXipE4+PObtMJqbAQ@mail.gmail.com>
Subject: Re: [PATCH v19 0/8] Specifying cache topology on ARM
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 anisinha@redhat.com, 
 armbru@redhat.com, berrange@redhat.com, dapeng1.mi@linux.intel.com, 
 eric.auger@redhat.com, farman@linux.ibm.com, imammedo@redhat.com, 
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, linuxarm@huawei.com, 
 maobibo@loongson.cn, mtosatti@redhat.com, philmd@linaro.org, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org, shannon.zhaosl@gmail.com, 
 zhao1.liu@intel.com, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Tue, 31 Mar 2026 at 03:47, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi,
>
> On 3/11/26 13:06, Alireza Sanaee wrote:
> > Specifying the cache layout in virtual machines is useful for applications and
> > operating systems to fetch accurate information about the cache structure and
> > make appropriate adjustments. Enforcing correct sharing information can lead to
> > better optimizations. Patches that allow for an interface to express caches was
> > landed in the prior cycles. This patchset uses the interface as a foundation.
> > Thus, the device tree and ACPI/PPTT table, and device tree are populated based
> > on user-provided information and CPU topology.

> Alireza, thanks for addressing my last comments in v18.
>
> Peter, I have no further comments on this series. All looks good to me,
> so feel free to take a look and pick it up when the tree reopens.

Thanks (and thanks also to the other reviewers). I've picked this
series up into what will become my target-arm queue for once we
re-open git for 11.1 development.

-- PMM

