Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6A7C369C9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5gwm-0008Ky-PY; Fri, 18 Apr 2025 04:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u5gwi-0008Kb-Du
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:19:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u5gwe-0003Om-P4
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:19:36 -0400
Received: from loongson.cn (unknown [209.85.219.171])
 by gateway (Coremail) with SMTP id _____8AxCGoGCwJoDZrBAA--.58661S3;
 Fri, 18 Apr 2025 16:19:19 +0800 (CST)
Received: from mail-yb1-f171.google.com (unknown [209.85.219.171])
 by front1 (Coremail) with SMTP id qMiowMAxzxsDCwJoRyyJAA--.25896S3;
 Fri, 18 Apr 2025 16:19:17 +0800 (CST)
Received: by mail-yb1-f171.google.com with SMTP id
 3f1490d57ef6-e6405b5cd9bso1438001276.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 01:19:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWrzT5zo9XjKLadP55yF0hoNMf/oUpUQ1sMomCsIsY+Czm91DUXEfsAMglIGR4LE6T2Ge46xrJMbV1k@nongnu.org
X-Gm-Message-State: AOJu0Ywc8GYIrNjIDWEYntNEgcx20haxIQVo1BSFT+bVWkZyMbsqgRoN
 qvn4A8Srdgx+Uj8t6sTeZR621JCUsgtdSXOCmcxG7UPDtwKPupCNoFrZKjCFutTPPA1W1NIIy2I
 +x04QmUMET6CXi/ycr/R6WpTmCYt4kdqG5IZaOQ==
X-Google-Smtp-Source: AGHT+IGJnTOxJSHOL+POWk+dNQ8FJt6SgIuGe/Ps1RrtrqS2Si/0zg5LkJRmsj0epIbXTu8EgqiBSSFAlC8cfwzEb04=
X-Received: by 2002:a05:6902:6b0a:b0:e5b:4651:b5c6 with SMTP id
 3f1490d57ef6-e729872834amr1683860276.23.1744964354518; Fri, 18 Apr 2025
 01:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250418030702.445700-1-wangrui@loongson.cn>
 <4ddf9364-fe52-e2d9-3e80-b01f76201085@loongson.cn>
In-Reply-To: <4ddf9364-fe52-e2d9-3e80-b01f76201085@loongson.cn>
From: WANG Rui <wangrui@loongson.cn>
Date: Fri, 18 Apr 2025 16:19:03 +0800
X-Gmail-Original-Message-ID: <CAHirt9gCggrr1UNavJyUGXGDOEMYx_rZQJsKNe9pwsJ2Fn3gWA@mail.gmail.com>
X-Gm-Features: ATxdqUF7sTHNL7lYvM3mCM5OggCRckMwOp6d0PiMxeaW6sVZkCNF6Y0XyA0miUI
Message-ID: <CAHirt9gCggrr1UNavJyUGXGDOEMYx_rZQJsKNe9pwsJ2Fn3gWA@mail.gmail.com>
Subject: Re: [PATCH v3] target/loongarch: Restrict instruction execution based
 on CPU features
To: bibo mao <maobibo@loongson.cn>
Cc: Gao Song <gaosong@loongson.cn>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, qemu@hev.cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qMiowMAxzxsDCwJoRyyJAA--.25896S3
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
 BjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
 xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
 j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
 AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Bibo,

On Fri, Apr 18, 2025 at 2:08=E2=80=AFPM bibo mao <maobibo@loongson.cn> wrot=
e:
>
> Rui,
>
> Thanks for the patch.
> Overall it looks good to me.
>
> Could you split it into three small patches? such as crc/64/fp specified
> small patches.

Thank you for your feedback! I appreciate your suggestion. I'll gladly
split the patch into three smaller ones and resend them shortly.

Regards
Rui


