Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C71C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wupK0-0001Dr-N9; Fri, 14 Aug 2026 06:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wupJy-0001DZ-PB
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:39:30 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wupJw-00055U-78
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 06:39:30 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so132029a91.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 03:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786703966; x=1787308766; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KkI20Wd6i+g6jIBnL48L4rzD5+qRhzeivRs8UHng65w=;
 b=EkDAvSJeJt/NLbed+nVujQp65yMAG0sfEXOR2xpeVYGmEUrrtWpwVxnhlG2LCvgem4
 VxFuONz1vo8ehHZ+qqs31EqYQLx5HJthrzVWhTdHM2FLGToqCYCeKY3y9EBJShVOeHkV
 vc46JiZan1qihL/3tB3wUGhM1hkXQCotkseOVnrQYx8NheVyKwrE7EZQYfkAVpNHrLTS
 gIniO7FFmIpFTJqzUXSM+axc6rcMegswG0i0f0AUIKwGIDhl0K+xDsaqehd1WJV2P9AX
 eX8Q1KbTM/3ZTARbteZFDWJjEA/QIoD/Nh1JilXaZtZ/+mZ2kCdgNLcQKt96fcSoj/R8
 t06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703966; x=1787308766;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KkI20Wd6i+g6jIBnL48L4rzD5+qRhzeivRs8UHng65w=;
 b=S8y+wju3opi72aNH8m+uwLmZbvnm1moVIbf45xQCnJgQPb3H738l+toU7I25PmL6A0
 mQoccN574CSy9H7t+S/mfhhZ+yqhW5kii5Yu1TYdvWTsBtg7LV0CO8/S70qMspv5/Pcw
 uboA3r5gGN+WxbKU2hIm/OwVcLUXhy2I+HFZQMcbLhnYU+nuSYGDN1pD51eCOZ7Q1XTd
 dDMFUasTtD9oBiYGbvmyG/AI4T6/AxjbxHYWp1q23aQ/me8/O6tRtekK1iqSvNDLpYIL
 auohas/C07w/hZOKdoIlB8MzGHbawoxkxLmpiznyRoMKtju2LgEoq6JbDRA4bXDNosu5
 vkkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEFisIVjBILkvsDAdaT/K72tjEAhZLsdPPXnoWvKWlnq5OYEtFEa6bteSGeZDaF7hjWJvvhsLOn5cm@nongnu.org
X-Gm-Message-State: AOJu0YyiuMefYFT2bVBpHhV7exCLaz4AlkwC+K2NEt/JoVveYPXMU5Ab
 9cYsPzSlo8zpLH6lx3R6iShU/71zXIcWnSubrvunqVA/hZhm08QjTDyS
X-Gm-Gg: AR+sD11fLNgjG6lMw9xE+l9SGHVPKJEsUUYnthBwFhdduKEGjpvf8YP8FIC68hyqwFL
 FJPwD0WVllhCiyXOlg4XrRcHMSe3mkRosmR6WhDBRo6yXTdJI7DDmRGdvLToeBfNV7cpugri6BD
 +ViQKZPpCTleNM0XWhkYsRk9XUkUilZLuRtMKXVjweDuBXd02ZI51KCe2kJahvvgkVHWJbM+ktF
 XIL8oTOS1CX32KreXHweIorjAfYcmfPhJEMlMR33qN0UWxxHKCyHNrqArbT1IeE1vqF/Th1Y4io
 eNrdd6ommq5pVTSe+YJBqYdX99u0c4eISQ4OvFuu+oRZ7rAOon3UP+CMlUPDF0qT8jxOYLviuyv
 fgim62AvmJNxkBCRalKnGmamvpap5HTPoasUtiYL9PhqLQSRfw0NmcOgWybPkgBzmABw/F2g1A7
 I0fkG1fofg+pTo9ti7OaQJXWfrCt1PbN9FB7vcPT0iY98+h7eTb/6+tW2kmb4=
X-Received: by 2002:a17:90b:1651:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-3933e6465ccmr3447163a91.3.1786703966448; 
 Fri, 14 Aug 2026 03:39:26 -0700 (PDT)
Received: from [127.0.0.1] ([38.34.7.236]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1413887e3e7sm7833627c88.9.2026.08.14.03.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:39:25 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] hw/gpio: add K230 GPIO controller model
From: Junze Cao <caojunze424@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Junze Cao <caojunze424@gmail.com>, 
 guochun wang <guochun.wang@foxmail.com>, qemu-devel@nongnu.org, 
 chao.liu@processmission.com, pbonzini@redhat.com, farosas@suse.de, 
 lvivier@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org
In-Reply-To: <CAEUhbmXMKug9v2x9PaJTXiwnF+o0HqQsiY+PtCL6eYtGZ8_ViA@mail.gmail.com>
References: <tencent_EF996EEB2215272639C89FAE1491CEF43908@qq.com>
 <be7afd5c-55dd-4af1-b828-9a2f401e3bfc@smtp-relay.sendinblue.com>
 <CAEUhbmWjR3cc4jkdBAqpXcmt9z3ExHWsPzCthX7d+G1wgqTbTQ@mail.gmail.com>
 <178669925995.92831.6332189576763663701.b4-reply@b4>
 <CAEUhbmXMKug9v2x9PaJTXiwnF+o0HqQsiY+PtCL6eYtGZ8_ViA@mail.gmail.com>
Date: Fri, 14 Aug 2026 18:39:19 +0800
Message-Id: <178670395948.644010.10747276999132854035.b4-reply@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=caojunze424@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On 2026-08-14 17:50:55+08:00, Bin Meng wrote:
> Hi Junze,
> 
> On Fri, Aug 14, 2026 at 5:21 PM Junze Cao <caojunze424@gmail.com> wrote:
> 
> > On 2026-08-14 15:26:41+08:00, Bin Meng wrote:
> >
> > Hi Bin Meng,
> >
> > Thanks for the detailed review.
> > Regarding the suggestion to abstract this into a generic Synopsys DesignWare APB GPIO model, I have a question: do you know of any other QEMU SoCs that use this IP and would benefit from a shared model?
> > If there is no immediate second user, I wonder whether it might be premature to generalize now, especially while we still need to complete the K230-specific behavior.
> 
> There is no other immediate second user as far as I know. But Synopsys
> DesignWare IP is not like others, and it's commonly seen on many SoCs.
> 
> For RISC-V, I can see Eswin EIC7700, Sophgo CV1800B (Milk-V Duo),
> Sophgo SG2042 / SG2044 and T-Head TH1520 (Lichee Pi 4A) all use the
> same Synopsys GPIO IP, and they are all good candidate of QEMU models
> in the future.
> 
> What K230-specific behavior are you concerned about?
> 
> Regards,
> Bin

Hi Bin,

Thank you for the clarification and for pointing out the other potential users of this IP.

After reconsidering the issue, I realize that my earlier concerns about K230-specific behavior were unfounded. 
I agree that abstracting this into a generic Synopsys DesignWare APB GPIO model would be a worthwhile approach, and I support moving forward in that direction.

Thank you again for your guidance.

Best regards,
Junze


