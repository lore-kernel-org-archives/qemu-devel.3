Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FADCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhfS-0002yD-Tk; Wed, 20 May 2026 10:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wPhfP-0002xc-7d
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wPhfN-0003lC-4P
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779286375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QJpy3Of6Ab7dIfz0nYpEYn3A/l+pskMm2rECtyHs6cM=;
 b=RchuDF3+d0xOPNfb30kLoAqbR1/MZdtraC+6yOwPI85BvKZxE9Z8r9eqdecQ1y11VVeJOP
 WnOjNPW12BIuc9CX7ZFV92fJuw+mtV9i8BRpfbeiAq56K6ShswRG8uoz8dYbFtf3akKPbS
 IYGqGd2YnmBpCvCQpKSoYvnkTc8NbzE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-duet3cQnMy6uIxUSTpxDzA-1; Wed, 20 May 2026 10:12:50 -0400
X-MC-Unique: duet3cQnMy6uIxUSTpxDzA-1
X-Mimecast-MFC-AGG-ID: duet3cQnMy6uIxUSTpxDzA_1779286369
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-bbfaa3ad205so509750066b.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779286369; x=1779891169; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QJpy3Of6Ab7dIfz0nYpEYn3A/l+pskMm2rECtyHs6cM=;
 b=QCe7lHSMxuyKfD/L0IqryqQTZeDvWSNIwq22moWtmHF956MoRFepy31pHvrhi1JFfd
 Fnbr0iNGCwGEbRWpD5WBmv+tN1fzfzFDA4zX//NO01lCOGV+22qZqauZHehfR0KJ3irL
 mCzxzu4mETY6ie3ULJTceyenNK9nvx9Axa306gfBnwNLCbiI/J2oMgCfOXQ65WokICKl
 jmSAHNDLj4tiQphhn6RXJtBTMOPh2XgVa0akQ3QPIzGsZBN/9BXTKcTj51S+/iD/P7aw
 k97K54CtBeV0aNFQq2fc3cvSQOEOCXKPp7efg/soCSndY8PyjBr4umllbYp7dpFS04xu
 5KAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286369; x=1779891169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJpy3Of6Ab7dIfz0nYpEYn3A/l+pskMm2rECtyHs6cM=;
 b=V6Pe7dcFhYYFEEtIYxMm2usgk3avt0Ou90IXHl/vc4hf84iL7Imwia9S7Nv5nljajM
 HhsMFJbeQAW5m8DKt6+Iby72Vb2gusV2iB4H/e+hhlTOG3+zk9pCvNNqIAx822Nia3Ii
 GuESAaNIdKHrWWArUE0swWh8MYI6hxhW6Ejs8asS1FEDkG/7IikfsVcc1O1A+69hHWlN
 v1+lI50d64UHH9U6SHimhfTT0BKPSg6nFwWASbAc/nW//Z+PWzM0K+yn9VrLUq34Jlkv
 vZYJ8bLrN8PyV18BVEraLXWYSeuORbsh0qV8+7EYGhIUwBwDRca63BaJLjohy3DN5UVr
 KzVQ==
X-Gm-Message-State: AOJu0Yz5pk9yRVAmVn0qIxxn6ua4mn7S/ExIYGBKpBPTmG5ZkzDNBcW9
 YSplhm5Wf9U7tWMs6dXEfOEounelo48Rdpq4ljsbT67aMgHCpAFknfuhddVuzI8BHDVGHOUL2zH
 OYYLOn92cBqZD2NPTQ/6/ueiZ295iVJ1XrH8aTBjkqVbsnCZQISgW85a6
X-Gm-Gg: Acq92OFDtp7Fckv76LdCwgc9XZf2MmGNr8/zo4mkpiA65CajLYTbfigHhaz98tka1UB
 5LbqJ58FQIDdY3Prqr5/hUoKX9qpxWFqkMG9oemyRDvkO1Hu7qjztPVqic6UweXM5tZvlLxTWfh
 lEbodajbq+CPmFDooYMLFq/UzPSQwQxjfD7wgCD1Jzzl+LbmVNKcFFE6v9uDfV1BiJLw3LdkKjL
 ZqtSg0kwxOyL01dtkmTpbE5i9b72DE+fF380ueZqtFYu6xkHNEbYVBij4dEIZUetpOzKZ+xUC3U
 Rl7HlehIvluB2ed4AR0NjcnGuQWSl/y0MKmRv4at1Pg42Hn3KgsCSaSQ16hJX+PMuTQS0nMHr9D
 xbP5WiYt3V/LWLpPxFKy0PQ==
X-Received: by 2002:a17:907:8707:b0:bd5:7c2:7616 with SMTP id
 a640c23a62f3a-bd51553bee6mr924785166b.23.1779286368603; 
 Wed, 20 May 2026 07:12:48 -0700 (PDT)
X-Received: by 2002:a17:907:8707:b0:bd5:7c2:7616 with SMTP id
 a640c23a62f3a-bd51553bee6mr924783066b.23.1779286367990; 
 Wed, 20 May 2026 07:12:47 -0700 (PDT)
Received: from redhat.com ([31.187.78.37]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bd4f4eaef0asm864313866b.57.2026.05.20.07.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:12:47 -0700 (PDT)
Date: Wed, 20 May 2026 10:12:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v9 0/7] Add RISC-V big-endian target support
Message-ID: <20260520101034-mutt-send-email-mst@kernel.org>
References: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511083819.206216-1-djordje.todorovic@htecgroup.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, May 11, 2026 at 08:38:26AM +0000, Djordje Todorovic wrote:
> Rebase on top of master.

is Linux going to support this, ever? given this history:

https://lore.kernel.org/lkml/CAHk-%3DwgYcOiFvsJzFb%2BHfB4n6Wj6zM5H5EghUMfpXSCzyQVSfA@mail.gmail.com/t/#mce138059dc56014643bbda330810183031ef5c06

pls include a cover letter explaining why we should bother with this.


> Djordje Todorovic (7):
>   target/riscv: Define MSTATUS_SBE and MSTATUS_MBE bit masks
>   target/riscv: Add big-endian CPU configuration field and reset logic
>   target/riscv: Implement runtime data endianness via MSTATUS bits
>   hw/riscv: Make boot code endianness-aware at runtime
>   target/riscv: Fix page table walk endianness for big-endian harts
>   target/riscv: Expose big-endian CPU property and add documentation
>   target/riscv: Add endianness test for RISC-V BE
> 
>  docs/system/target-riscv.rst                  | 24 ++++++
>  hw/riscv/boot.c                               | 81 ++++++++++++++++---
>  include/hw/riscv/boot.h                       |  1 +
>  target/riscv/cpu.c                            | 11 +--
>  target/riscv/cpu.h                            | 23 ++++++
>  target/riscv/cpu_bits.h                       |  2 +
>  target/riscv/cpu_cfg_fields.h.inc             |  1 +
>  target/riscv/cpu_helper.c                     | 28 +++++--
>  target/riscv/insn_trans/trans_rva.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvd.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvf.c.inc       |  4 +-
>  target/riscv/insn_trans/trans_rvi.c.inc       |  8 +-
>  target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 +-
>  target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 +-
>  target/riscv/insn_trans/trans_rvzce.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 +-
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 +-
>  target/riscv/insn_trans/trans_xmips.c.inc     |  8 +-
>  target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++--
>  target/riscv/insn_trans/trans_zilsd.c.inc     |  4 +-
>  target/riscv/internals.h                      |  9 +--
>  target/riscv/tcg/tcg-cpu.c                    |  3 +
>  target/riscv/translate.c                      | 22 ++---
>  tests/functional/riscv64/meson.build          |  1 +
>  tests/functional/riscv64/test_endianness.py   | 57 +++++++++++++
>  25 files changed, 251 insertions(+), 80 deletions(-)
>  create mode 100644 tests/functional/riscv64/test_endianness.py
> 
> -- 
> 2.34.1


