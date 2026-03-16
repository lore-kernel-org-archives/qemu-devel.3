Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4832F013CA
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w23Jv-0004FV-Ln; Mon, 16 Mar 2026 04:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w23Jr-0004EL-FC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 04:29:00 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w23Jo-0007XJ-9I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 04:28:58 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-35ba749f441so196307a91.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 01:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1773649733; x=1774254533; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=81PX9L6+p6bBFOLOB++BP+0LWzFNWhC3Hhk/EHVLyhE=;
 b=lSNpzEBeQcAnmgUcSThRAmiNHtumzhSukhCr62LQFVagMEjNzCZqV5ZEf4vcVeGd22
 ptM7URJy9erB0z5wCmvm1QMJnwAKxitjcIEWx5RNewFhhoEY3t6xQefPGPztnfGnl9EB
 juPJ4rsZ3TYLHtLHLLeB1YnPFZibaNy5REhJ+WybAv2nMj+gMRuhHNv9X/PEmzG57yNG
 9bocVBHw6C5ypmDyMp9zXS73R+nyx/D4W5l9oVyhmSZB8A9tzV9kJS4OAd+JFpO7TtBU
 guh4MfqMckKOj3vkJNiL+y8pLGt2rYQXycCTk8oKfNWNraApZqDvh2tdw+Q9HB1XGYdK
 pdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773649733; x=1774254533;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=81PX9L6+p6bBFOLOB++BP+0LWzFNWhC3Hhk/EHVLyhE=;
 b=q2ybPAY5eprYQIFe11ynw7ZwsjVcPok2oWThKdIgYVvGL4C2jeHBDZ1B6+vgXHPHdm
 FngB9L8Dj/3qf10kr70dBfMsqdC8hCWLlGIFVbnbQGxpbNYT8kpvFbclD3f+Pmw4kPkN
 0iU3rZn8DGDRAN7D+ItVR7XbF4QXuWCx1OaMgZmVo8ES7lCYu2BWBZ/MBItEo5eTYmDJ
 3FzFYgKCbbOPShT92rpbuIlCdRDwwWP3PBWipXRLNkaynzW6Fy8jSaaspSk+GX0qpDdX
 V5+vdgSXioNWcmH1svo+9xioygAvcsQgsik4Z1gIPqPSFP9W5nLvdM+5LP+shDVTo8Sg
 pdfg==
X-Gm-Message-State: AOJu0YzikZcIJQ7Z6xhokMhS8CcTv/XraOnnnPTiTlFRAH4ou0/Xv1xj
 KOlvAMGM/Ahy4Tz1VIB+Skbm0CT6ysO3zSdF4ZvLcLCHu0+kcsjbulMvlw/G9bvf8H9K5iS34ya
 1pAr8awlD5Q==
X-Gm-Gg: ATEYQzyBEMwP/ZWSvIsKs+QykNovpJFapo5O/wPxPK6jJ3T89FFwFYeQYoggmplnY0s
 Qm0dyNPU2I4xEPFCrY/2XyZRFYdeyh7yhMfF7vOQpekIPbQkQfaCy33NEUZcMZO2dTqmZU7pxFG
 +Mgt7rj1vWxCvhVvUNBFADUukG2EVrfyY8L1dl1aDXQBcM42nQHE+cOCufRb/dcL8Abrva4kYU7
 uWBWdzVn88z80gmKvtUyPhRRt7f37sLjzSaKEdZy8kbg0gaxYALOQfDUdGRDOtTtxnU7UGQY0BD
 e/du98js0DpprBcUtqn3sIeQpt400SVrZSkqq7yIcnBOQJAZqVH/Gbpi2KxnfgmaWPTyQTG/KFO
 Ho7oWPegHvwIKGChZ5hLhsGUk9oRoRB86iTxgubR7QYaIvt5d5AWlvOMCmeCfsiOiTr96++xgQ9
 8+8u/VfSjDF+afz6UU8pP/Xexgi4tU+KXQKg+c2GMFKRIMOYcrjrhEIqPN+dAuejLS
X-Received: by 2002:a17:90b:3b46:b0:353:5595:3247 with SMTP id
 98e67ed59e1d1-35a21eb6138mr11859464a91.12.1773649733547; 
 Mon, 16 Mar 2026 01:28:53 -0700 (PDT)
Received: from sifive.com ([136.226.240.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35b9604ae41sm3774465a91.0.2026.03.16.01.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 01:28:53 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:28:50 +0800
From: Max Chou <max.chou@sifive.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
Message-ID: <abe80eiIC4gXUHxk@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
 <abKfuTO7zg5d67E8@sifive.com>
 <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102b.google.com
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

On 2026-03-13 11:09, Alistair Francis wrote:
> The problem here is that there is no version control. If we merge this
> series and the PR changes then suddenly we are out of sync there is no
> way to track which version of the draft spec we support.
> 
> We need clear versions, like we previously have. For example version
> 0.7 and then 0.8. Draft versions are ok, but we need a stable target
> to develop against.
> 
> >
> > PR #2743 is currently open, meaning ratification is pending but not
> > yet complete. Under the new workflow, merge into main of
> > riscv-isa-manual is the signal that ratification is finalized. If you
> > prefer to wait until that merge happens before applying this patchset,
> > I completely understand. Alternatively, if you are comfortable
> > accepting it as ratification-pending, I am happy to address any
> > remaining technical comments.
> 
> In this case we will have to wait as there is no stable version of the
> spec to point to.
> 
> Alistair
> 

Hi Alistair,

Thank you for your feedback on the version control and stability of the
Zvfbfa specification. I understand your concern about developing against
a moving target.

To address the lack of a stable target as you mentioned, I’d like to
help bridge this gap. Since this patchset was prepared based on the
Zvfbfa version v0.1 and this version has passed the ARC review, I
propose we coordinate with the Zvfbfa isa designer to check the
specific tag/commit ID of the Zvfbfa v0.1.
If we could create a tag or release for v0.1 (e.g., v0.1/v0.1-draft)
within the Zvfbfa repository that explicitly marks the current state of
the Zvfbfa spec, would that provide the necessary versioning baseline
for you to accept this patchset?

My goal is to ensure QEMU supports a traceable version of the draft spec
while respecting the current RVIA development process for this ISA
implementation patchset and the followings in the future.

rnax

