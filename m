Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC6DC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKma-00065A-67; Tue, 20 May 2025 07:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHKmX-00064k-4P
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uHKmU-0002ul-Ho
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso43421175e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747739109; x=1748343909; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dDq82RdfwMhP+iN8rACbDsggP5fzF2rU/xjSz+p9R1c=;
 b=lOahLILEULm6eRn+Y98u4rYtf2w3qmMo/zDUEt9tOipSJo0aO5t6lMViAAZ9EWeoGn
 0Ky+P7PS9fQifpYXEfM0/goKVptVUYesFIhfYHBZ3tsBlGrNtX6dp4iu9Khx5GCOplH/
 KS63W+IYDGhDDzJSAFvJW+Yvxd4v6OpwmMVtsG7J7pZ/pSP5QJArOuF7avsyCfvuDnBR
 xpNxQksAh7MAuaLBmKpagJVgGCszniuDAnNtGnfVeZnE0FfQvPDkntuQQDL4fYQ71KEY
 i/ir+24rpSxghe7ba+DSQs9CirkvVd7srsjaxUE9uUkEJKvr9aTTN+dJFw4IH6cgpgcQ
 AcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739109; x=1748343909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDq82RdfwMhP+iN8rACbDsggP5fzF2rU/xjSz+p9R1c=;
 b=IVkdXZJlsg1dVS1rNbwJ1FKaVjtH9ZKpvRONPz3m9C+18o2sZ1hf45ncreulAGG2Ft
 0NrYAuZdO5G6swxxud4S4QeqwqTFpm9xSI9iUNZ5dRFhtrqgFPhU+/eDmcHEAzNrCSDq
 ZG35p7Mebr/Ffq8e0MmHj5xUU7op4kv5C5BT1HPJkrjjjJZBAk9K1OHVV3+N4pDUYHWH
 k8OtFbez8RO4VmpRR3dtQYjuQCbKyxldkzB4z7GABjreCSAXLHBzVg1ANIYDr30Ix/OW
 DSa8Cyvg+A54Hx/O1nkNm2u2C/0BYXvQZuTLJfRDm3R+2C2Nujz/WdKCYgsOSsK9SWtV
 kjTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7KMlY0vFWruRP3QovtD+rDWUPjG/In2tpxN7ZB1YYGNhfA7l2ZaALnihnf3WJmtJ2PYQP/FOAc6ML@nongnu.org
X-Gm-Message-State: AOJu0YydoB3U43Bf3cYRgglDjb3zutRnvKKpjyoqdqztgomxnW6CpFOa
 h5yH+tYaveBzcMJkwztEB31drnQ2Ut5lk4SzY146Vsjw9b3A6XNU5v2hV51JaJ0HvaI=
X-Gm-Gg: ASbGncvmCMNIYAnLjHsa++HICsiWQYzK0eD2nzTq9uZ7vlf184UwNWKZ84+iSa0bfg4
 ppKJ+QFhflCjX/h9T3mBYsmOx50AZOHZIkwx5nm+Vq+9wI6gLc76lA+0C9BO6Vwk+V/tYeNXirz
 2ZmpFh9xyOR7W8fXTJUa//ABfLmEKMDFRJESxpcOksdFaT6feE/EFoCQCaNcShVAbhKzNRJyKdg
 fya4UuQCSciQDIICRG/jJcTrkDLfJNPBnmGqz5FHocb2ywidwPFT0KnIpG+3larCNgY8Kcsa/2Q
 APHzCCtCeUyoX2p4tM0HBzEQMPRYzwfMk11UOlY=
X-Google-Smtp-Source: AGHT+IFXF1YWWYt7gi4tgU5t01XkxhFCdzCWXpR5uTiaSMkHK8dFavN1IcoD6yu2GgBhjKKh8/53ow==
X-Received: by 2002:a05:600c:1d8c:b0:43c:fe15:41dd with SMTP id
 5b1f17b1804b1-4479ef772e5mr32505225e9.6.1747739108523; 
 Tue, 20 May 2025 04:05:08 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::ce80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-448ba3d8facsm1239135e9.6.2025.05.20.04.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:07 -0700 (PDT)
Date: Tue, 20 May 2025 13:05:07 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
Message-ID: <20250520-9e464f5ce4b78fca34247804@orel>
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
 <e86af5b2-7d8a-4503-8a5c-5ee2147aa850@ventanamicro.com>
 <20250519-a153c03e434d1bf31498eb01@orel>
 <c1368421-4441-4058-b78c-317d1d21d580@ventanamicro.com>
 <20250520-c62c9918435e564c09f1042a@orel>
 <39ce5a78-8789-4d32-9fff-aa82b7505529@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ce5a78-8789-4d32-9fff-aa82b7505529@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32b.google.com
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

On Tue, May 20, 2025 at 07:50:15AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 5/20/25 4:50 AM, Andrew Jones wrote:
> > On Mon, May 19, 2025 at 02:15:05PM -0300, Daniel Henrique Barboza wrote:
> > > 
> > > 
> > > On 5/19/25 1:35 PM, Andrew Jones wrote:
> > > > On Mon, May 19, 2025 at 09:48:14AM -0300, Daniel Henrique Barboza wrote:
> > > > > 
> > > > > 
> > > > > On 5/16/25 9:23 AM, Alexandre Ghiti wrote:
> > > > > > The satp mode is set using the svXX properties, but that actually
> > > > > > restricts the satp mode to the minimum required by the profile and
> > > > > > prevents the use of higher satp modes.
> > > > > 
> > > > > For rva23s64, in "Optional Extensions" we'll find:
> > > > 
> > > > The keyword is "Optional". The profile should only set sv39 since that's
> > > > what rva23 (and rv22) have for the mandatory support. sv48 and sv57 are
> > > > both optional so, while the user should be allowed to turn them on, just
> > > > like other optional extensions, they shouldn't be on by default since we
> > > > don't set any optional extensions on by default.
> > > 
> > > What about satp validation for a profile? For both rva22 and rva23 the mandatory
> > > satp is sv39, but up to sv57 is also ok. Do we care if a sv64 CPU claims rva23
> > > support?
> > 
> > Is sv64 defined yet? I thought it's just a placeholder. Anyway, I'd expect
> > it to be like sv57 and sv48 in that each narrower width must be supported,
> > which means sv39 would also still be supported, and that means the cpu
> > could be rva23. If, OTOH, an sv64 cpu cannot support sv39, then the cpu
> > cannot have both, so it cannot be rva23. IOW, as long as sv39 is _also_
> > supported, then sv64 is OK to select and still be rva23.
> 
> We have sv64 defined in QEMU. Not sure if it's already a thing or not ....
> it seems to me that ppl cares to sv57 mostly, so perhaps my sv64 worry
> unjustified.
> 
> Just took a look in how we're validating satp for profiles and we're
> allowing a higher satp mode than the profile mandates, issuing warnings
> if the satp mode is set to a lower mode than the profile value.
> 
> 
> So I guess the way we would like people to use rva23s64 with sv57 would be:
> 
> -cpu rva23s64,sv57=on

yup

> 
> 
> > 
> > > 
> > > I am aware that sv64 also means sv57 support but I'm worried about migration
> > > compatibility. Let's say we migrate between two hosts A and B that claim
> > > to be rva23 compliant. A is running sv64, B is running sv57. If the software
> > > running in A is actually using satp sv64 we can't migrate A to B.
> > 
> > A and B are incompatible already if A is '-cpu rva23,sv64=on' and B is
> > '-cpu rva23,sv57=on', so the migration manager should already disallow
> > that.
> > 
> > > 
> > > > 
> > > > So we don't want this change, but fixing any bugs with the first hart vs.
> > > > the other harts is of course necessary.
> > > 
> > > I'm working on it. I'll decouple the QMP bits (all the profile validation business
> > > is a QMP problem in the end) from the core CPU finalize logic. I'll send patches
> > > soon.
> > 
> > Great, thanks!
> > 
> > Another comment I thought of later that I should have put in my original
> > reply is that we of course want 'max' to default to the widest QEMU
> > supports. Then, users that want to ensure they get sv57 or sv64 without
> > having to explicitly add it to their command lines can use 'max'.
> > Specifying '-cpu rva23' means you just want the mandatory base of the
> > given profile and if you want more than that then you need to append each
> > optional extension explicitly. If we don't have that documented somewhere,
> > then maybe we should, in order to help clarify the intent.
> > 
> 
> max CPU is using satp_mode = sv57. Since sv64 is mostly a placeholder then I
> believe it's all good. Perhaps we could add a satp_mode_latest value for these
> situations.

Sounds good.

Thanks,
drew

> 
> 
> Thanks,
> 
> Daniel
> 
> > Thanks,
> > drew
> > 
> > > 
> > > 
> > > Thanks,
> > > 
> > > Daniel
> > > 
> > > > 
> > > > Thanks,
> > > > drew
> > > > 
> > > > > 
> > > > > https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
> > > > > 
> > > > > - Sv48 Page-based 48-bit virtual-memory system.
> > > > > - Sv57 Page-based 57-bit virtual-memory system.
> > > > > 
> > > > > So in theory we could go up to sv57 for rva23s64 (and rva22s64, just checked).
> > > > > Changing satp_mode to the maximum allowed seems sensible.
> > > > > 
> > > > > But allowing all satp modes to go in a profile defeats the purpose, doesn't it?
> > > > > None of the existing profiles in QEMU claims supports sv64. Granted, I'm not a
> > > > > satp expert, but removing the satp restriction in profiles doesn't seem right.
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Daniel
> > > > > 
> > > > > 
> > > > > > 
> > > > > > Fix this by not setting any svXX property and allow all satp mode to be
> > > > > > supported.
> > > > > > 
> > > > > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > > ---
> > > > > >     target/riscv/tcg/tcg-cpu.c | 3 ---
> > > > > >     1 file changed, 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> > > > > > index 5aef9eef36..ca2d2950eb 100644
> > > > > > --- a/target/riscv/tcg/tcg-cpu.c
> > > > > > +++ b/target/riscv/tcg/tcg-cpu.c
> > > > > > @@ -1232,9 +1232,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
> > > > > >     #ifndef CONFIG_USER_ONLY
> > > > > >         if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
> > > > > >             object_property_set_bool(obj, "mmu", true, NULL);
> > > > > > -        const char *satp_prop = satp_mode_str(profile->satp_mode,
> > > > > > -                                              riscv_cpu_is_32bit(cpu));
> > > > > > -        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
> > > > > >         }
> > > > > >     #endif
> > > > > 
> > > > > 
> > > 
> 

