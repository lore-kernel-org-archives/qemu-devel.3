Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD965CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 23:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMwta-0001IE-RQ; Tue, 12 May 2026 19:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMwtW-0001Ek-UM
 for qemu-devel@nongnu.org; Tue, 12 May 2026 19:52:10 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wMwtV-0002oh-22
 for qemu-devel@nongnu.org; Tue, 12 May 2026 19:52:10 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bccd251d622so555474866b.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778629926; cv=none;
 d=google.com; s=arc-20240605;
 b=beDWL7h3BkafCa/9cb5o8nhzGQ9sH5CRLAKynptCfeblXKWojjyuNtO+y5pNBa9I+G
 n+fVfsocdt/kyawiA6+GQ2NviOpMc8BOSIegIGeRSjRaQl5yMr7C7MCj3Z62BUSmSvAp
 ANGtpmHeeyE5TTEbwj1Y6T2r4T1kV7GckP2Dp9lXNYY9eJXYXR9eFtC2RMVGU5tuuh6/
 N2IXxFQN8BOxI1HDCHjLszoNdAM2344K+iPlxjZH8yTjCrbGSTqcPaGQpk0UNloHiKzM
 1OciErIPMDAQYGQNevqMgzfPyfQwiAV5SBGVKHJG2zAwTUPnBFFbWPvehRTFmaGaI4x3
 TxEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=G7mlqk1hfN+LgT4A5/nqphJIHm0Cs/3v9DJq+e4AeaY=;
 fh=V7okm/7Dq6rQogCwb8FDHB8o3ukpKEBrodBHJnH7MrM=;
 b=jaqMSBxYeNDypXmQ/KDmxlh6c1I5/3iDctC9rFmpPcvrEa+QLmLSE03pSE3Iq1XfDJ
 uwgx9NzICP1QfG63qC5HDcL3pK9xjTyajgy7WKQbpvYtOCP+Epp9lVmptklO7zUJu2sZ
 o8A1tQ5xVR7kfh7gWpgAbQHyphLUFF9qpzJwPKiayFZQlwmd29JHBial9xGqDokZtsKC
 NoiUm8QZELw8Z7ybOC4lM1//qNJmAQ+8+FfcqpUR3i4mjR1aUgfSzZhFYi50L3DwTYlh
 0lKiM4UWvvNIhtaYU9MruUo6hupnnk54Th5iFgRYO3ihAp8ew7vKH9OxaDQNG4Ud0kj9
 96yA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778629926; x=1779234726; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7mlqk1hfN+LgT4A5/nqphJIHm0Cs/3v9DJq+e4AeaY=;
 b=iIdUuabNi+b64o2YtXVN9NquN//iRA3O2OU9mnSzyoenJ7xeXsf+pctLa4vbz4TPMh
 KEreiCXDcdDjOsxnL66GLmZQ0joBh16uAfqWa3tqWoKCq4TuooqJHcL///7r6AlpTe4C
 tpp3R16N0iZC51zh0JXiBRIcQRL4iMidlEjCWkmuqGggg5uu/7teGl/siGGnE8ax/896
 u0lIWtKk3Th44HlPEoFyzsAQymuYF1JcnfpWjItQEVzs42NkJ0PqlEoFQKeIlin0rykA
 jcRnjJqHLhMr/w9LwO1xBkzl7kbdIIl4AQP36+2g1HfhXK5AYe3/85STLznEj1fIcodW
 9iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629926; x=1779234726;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G7mlqk1hfN+LgT4A5/nqphJIHm0Cs/3v9DJq+e4AeaY=;
 b=UwdQza8LzhLGMsDy/ZNvV7yM6X4JM3Ynl3BpkiSyGwGZ9mrPIXM8H1eyquV+ktQ51f
 cTJLV0uATJfHNMgBVB6vU1980s9yZkuLdkQ8asbl0mCG2/4WEYZbNQabAlKq+SgJk2s5
 S14UjIHHu6Hbp+MHs4mFoHpsVpeSjIHrC+5XKAMq3TGxxcNJ97QJLnhlzSDZTM8x3Ynh
 oycjuXyi/+967QCKKM3r84NvMTlr68uBAyoaNp/zcibMR5vCAY2LobjHpdQG84kpymKe
 YVNH6YM42bsjUll08n4Iz5V5BBQFPsu7GeurXyNZrmCTU9rseb5QRiq5Uvc1sI79ZFmn
 DXNA==
X-Gm-Message-State: AOJu0YxlSg5aUy315uQX94OerT1NjdPo6yTWVBsHDdsW11EY28xitRZ8
 pmNE38bQ3Ub/8+H1nlpYxUZXwj8JsZ5BdcUGiVOSxFl/xB4p9sz3HsMPJSZjeMzFKaqqq1vQlJq
 16bHmJXo7/zNq/RrmZA95AGcP7jvxnqw=
X-Gm-Gg: Acq92OG2nRA7OJyUEBBDMKH7daXtUm2f4k6iov3m+5pF/s1SHwAvxh+P+6/wLHC7bkH
 mdqNlKNm1BekD56TfjJg0Dhx8V1nEEoOxWmIIotN33oOFdfOo6Jmxe7GBQAnAvL4Lp75C9AVwJl
 lwfb99n+Wn8UDFGXICBRNE4ykYXi+2//NIrR9wEt38PqbQD2fEqJjRon8NSyl69+Tii+h3NEdlj
 NuLaZZ2oBQH86baQ14cnqY2+MvYGmqpf7rHaE18QixFIhrOe1RI0xkyZM8N7NvLCVSEMzZdU9mp
 nomhPWjL51iJYcLnSFnjprXrlQxMpvXrdR8e+hmWj9XlFrRp
X-Received: by 2002:a17:907:c0e:b0:b9d:8697:73b8 with SMTP id
 a640c23a62f3a-bd3c0ed840emr48663266b.22.1778629925940; Tue, 12 May 2026
 16:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 13 May 2026 09:51:39 +1000
X-Gm-Features: AVHnY4Lk8ekERgMMoSnKvxrDDeXdcDL5ZewrtTbAEkmXtHWlf3lDzk3gncpKesY
Message-ID: <CAKmqyKOOa9ZF4YGiTtLSS5sMj25zWkezK8JUCYXYVPkv7WpsKA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com, 
 chao.liu.zevorn@gmail.com, liwei1518@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, May 11, 2026 at 10:48=E2=80=AFPM LIU Zhiwei
<zhiwei_liu@linux.alibaba.com> wrote:
>
> This patch set introduces support for the RISC-V Smmpt (Supervisor
> Memory-tracking and Protection Table) extension
> v0.3.4(https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).

Thanks.

As this is a draft extension we need to support the latest version as
described here [1].

So this will need to support version 0.49

1: https://wiki.qemu.org/Documentation/Platforms/RISCV#RISC-V_Foundation_Ex=
tensions

Alistair

