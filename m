Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6B1FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITI6-0001gy-QC; Thu, 30 Apr 2026 11:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wITI4-0001gY-4e
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wITI2-0007Ej-8z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777562817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfuLjk0ckcITtpdP7fbvc86SvFMubnat1hWAe5rmLlc=;
 b=EiNomSH4OwX4DNvuPhDj579cFb/I5oI2QUJ5W6BgPEAiTdxgiH6JXIBy7tIuo5Qk09x+RY
 4hci+V4aNz8JbZrt6q7NjVm2VlvevoZFTNYJsGCsxn1x+ct8tEIy3tKaAfhi93nmOeKNA+
 741rsU8cfM7I14Yj0+RUWj6Qk2ktOWU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-FyP3obB9O0-EOdfrIIF7LA-1; Thu, 30 Apr 2026 11:26:55 -0400
X-MC-Unique: FyP3obB9O0-EOdfrIIF7LA-1
X-Mimecast-MFC-AGG-ID: FyP3obB9O0-EOdfrIIF7LA_1777562815
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a8ea3f1becso33834806d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777562815; x=1778167615; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AfuLjk0ckcITtpdP7fbvc86SvFMubnat1hWAe5rmLlc=;
 b=LuR56PsvUEFHXvrOKLMvfhdp9qqDLBqG+iy9NW7zDKnSfTwTi+jj9XShjDraffyYbi
 ZLWPyBhSp+iByiXwhEfdzfSPgUVd1XUnLdbxTgqgn/WS4BDebILrpsOIMTELARmXcJjB
 HWPHv8RZfwiJum12n9p7G7tf1jgz6Wk3fF2t2dd2QmhFUrybE49MhPYRwCkIx3HT+pcl
 djsLNWl7MY4St9ChPXbmccbNWRxhx6WY9UeKtoa20nxUDrhPLyjLi0vbBpkdHyQirsDS
 OcZGXJxJTwm+v/8ckc/eeWCY+HYxlnby1ZG2iRUOGUQHktUhmF8qwlV7PaVUqfnwkLre
 1aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777562815; x=1778167615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AfuLjk0ckcITtpdP7fbvc86SvFMubnat1hWAe5rmLlc=;
 b=jSoiihtSMZxvsQcNGeTw5fShRAHBdeaUtMq8sDYwip7QfVtMuYEGV3URp+5rKUrsMo
 YmxuOaFfdGk4DTwP9UuCs/x0GqgrAew6FYlNPqNNpt1qiRxVe2FT3MKHwDWvoiWBK8GR
 gN2zNK00NCydbjd1BYTYdyXmgajYbQEB5muZYMJwwmc0RJKQjAG/vxuOdyEMcRwCdYBj
 p8GbI+oJ4OU/x6Z4xUPiWrRvkIbi5kSrbGV/CSxcgeTVzetQwYN+HZdvzqjfTLj9m4If
 QcZ+fVEMBSZQkOoBJ79qx46TAQStoQ2/6A/+blgzI7ET242U+RMeRH+Y75zCtqMmrNC9
 rVQQ==
X-Gm-Message-State: AOJu0Yx2PvZYsAnuLmYaN39A77Fl7/ZRoRf4aEKubS82ZfJo4PdXjGOg
 dzrgqrYB/GMSTezSzYcSoYuZUgEVwPwQlqIZ1ox514bVg6myUmpHrz351T08IBpbS1Wxfkdpx+e
 1+MtVp1Ho+XoRPuzCYteYKbxOLfBxJY4V4DG3bunozRhX9ZmbPlbZLGyK
X-Gm-Gg: AeBDiesuCDekIC39YiRcuFmNTlJiIR24bqqvGsqWuhhW7qGhNiKDyrnin2fxPFWUVfX
 zClmHdtwUUsP8Ba02NKcWFha8jbm1Cuwa1Gv+pWSLdRhkqyLp9j3xR36YKjnJfS282hHheLJ4ks
 JHoMRJ2qmja/o71vSSsy0tQ/EZolouG/hi8bTAtTdXODlbPZ7yfsUdLSqIzrgjnz7T4WaWVXEhz
 NfUbqbcmE/eDtiGvE/rTfBrR+Pitjh7jFgIIzoBJPKdUaLJi2FfdM0YdGBF4zr+Pbn+gQk8UZTW
 6FBBVbMIWkkSzNvRzKNznZhQZbyLMRJvGACOPEESW8GtzhyHGA3+Qx9+Fxz6An8O106sGctePVj
 p22N3gAFB6fBYoS48gZ1s7ZOmYGcCG8aiYqW+AEQtz4GmDM1k2dFJyJ89JA==
X-Received: by 2002:a0c:e005:0:b0:8b0:2fbd:8e28 with SMTP id
 6a1803df08f44-8b3fe77eaeemr42081696d6.5.1777562814923; 
 Thu, 30 Apr 2026 08:26:54 -0700 (PDT)
X-Received: by 2002:a0c:e005:0:b0:8b0:2fbd:8e28 with SMTP id
 6a1803df08f44-8b3fe77eaeemr42081176d6.5.1777562814358; 
 Thu, 30 Apr 2026 08:26:54 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff057fb7sm21033286d6.0.2026.04.30.08.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 08:26:53 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:26:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/4] MemoryRegionOps .impl cleanups
Message-ID: <afN0vAmIwRXnOz_Q@x1.local>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260428093339.2087081-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 28, 2026 at 10:33:35AM +0100, Peter Maydell wrote:
> This patchset is some fixes to MemoryRegionOps that were
> accidentally setting odd .impl values, plus an extra assert
> that we can now add that a MemoryRegionOps doesn't set
> .impl.unaligned true but .valid.unaligned false. They're
> originally from the CJ Chen / Tomoyuki Hirose patchset that
> aims to support proper synthesis of unaligned accesses in
> the memory system core. I still want to get that patchset
> upstream, but for the moment this is a set of simple
> cleanups:
> 
>  * riscv_iommu_trap_ops set .impl.unaligned but not
>    .valid.unaligned
>  * npcm7xx_fiu_flash_ops failed to set any .impl at all
>  * xtensa_mx_pic_ops failed to set any .impl, and was
>    less strict than it could be about .valid
> 
> Patches 1 and 4 have been reviewed.
> 
> thanks
> -- PMM
> 
> CJ Chen (2):
>   hw/riscv: iommu-trap: remove .impl.unaligned = true
>   system/memory: assert on invalid MemoryRegionOps .unaligned combo
> 
> Peter Maydell (2):
>   hw/npcm7xx_fiu: Specify .impl for npcm7xx_fiu_flash_ops
>   hw/xtensa/mx_pic: Specify xtensa_mx_pic_ops .impl settings

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


