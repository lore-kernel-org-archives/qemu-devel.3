Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0680CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 14:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSF7R-0008B1-UA; Wed, 27 May 2026 10:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSF7O-00087C-Ja
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wSF7L-0000nY-PU
 for qemu-devel@nongnu.org; Wed, 27 May 2026 10:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779891618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/CyR+hoe9vR314KuvqQ15RZNDTK8wLvlM1fSxzpZ7X4=;
 b=YhBD8bVF7tZ7cFhfwbQwTJ8dR2XggjjQcGMaVqJ2TGbJfGwWytLa/Hirkd8/9kapszP23r
 GazDsuervStSzGqEwuzoh0hX56r7ArKEPJXwf/tSN/tPWI4P7XZBLiGNf1xaeXdhbh1rOl
 v5f7qmScxFxoNxaLtgOR2lPCiCHVBik=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-sw6furokP-2rObkD-Unq0Q-1; Wed, 27 May 2026 10:20:05 -0400
X-MC-Unique: sw6furokP-2rObkD-Unq0Q-1
X-Mimecast-MFC-AGG-ID: sw6furokP-2rObkD-Unq0Q_1779891604
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48e79219704so81428385e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 07:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779891604; x=1780496404; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/CyR+hoe9vR314KuvqQ15RZNDTK8wLvlM1fSxzpZ7X4=;
 b=Y8Y8oUFoHRNRs4zeJVpu9PAAm9WdQCR5nk9oTApkQp/jKFJ1TXjwbOUNBK3t0hNU6G
 GGzn61eT+Zvcwa02x333OsVx9VYJYYgOkr25yzTMVgvzXxsY9QBrxzCj/CFg615a7br6
 yLvDS9yQ2b1fbfz+bbccj340Dlll0O/U34XshHb3jYvEBtvTbiFG377WCyJg2YLBFrtd
 ubqWzkQ06/VW4kbsiw1uynlUooDx4Dy3vsxJoJcnUOh+KvigKhWjUzmyd7BVaG50xwg3
 tFnJE32z4NLx5I68ZUdO8tnoJ8vfeOdaEKeQW6d7hlchcno7ELxUx3Um3sy0io1GmCli
 MzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779891604; x=1780496404;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CyR+hoe9vR314KuvqQ15RZNDTK8wLvlM1fSxzpZ7X4=;
 b=JSvgO9aB2OhyGVmFWFORFXBNJFmdVeKPdtaSlY0RGIDFWxv/RNmNvPrD8uEbiNHbcV
 GKhudlj0HakeZ75hGjbsqPlFae/MtgYfTuZEr7QXB8bNia4JHLT++5Os9ybpDqse09g4
 CLwgre3Iu7N28so02ypuJ/PwMd7/bkiwHwSBL0wlYg9TlHhmCeamlPJagFXiYb2CQdJD
 hVRGCY7fp6hGfYgu5QNxMpJ1dsjgnS3qG5gfulw36s1fMCMrTAf+AZkhZCJQQhm2oyf2
 HVJnfVvk25zvcN7zxF9CD8xk+raS7l3+mCwVoefnJxHWcOWUG6bjFyRjvHHck0G22fbD
 zIYQ==
X-Gm-Message-State: AOJu0Yyw1gzZovbX2owV8Tsb8w1rQIygTOLah8ePSgfcUAcRBD9qv4x7
 PEabE1layAuvKaMcX7h+JHTTOTYiZcP/YwdwjvfOYq5dcJPQWNUbloZEQ3l+bKqehb7Dd+t1r2z
 ZUTwMtPQyldZKb4Wv5INzyIM0U2HpQt7vRrPrh7x26WO80GozC8CeTWdP
X-Gm-Gg: Acq92OEyChCIMb0251AKwXpRztHxxOAya2BjeGwbhT6QkHulOpOXscSy0SzmEDo6Ico
 rAd9Xt1mArUBzihVPNORb9zNawcN/zcfrperXwo4dtbfmk5dSuOJoPmSvOPaLn7neBSM7rftaYA
 8JG1V2P961nMKyoOH3YNkfwsV8r1mzNJ0UxnZVdtai8g5WxGOq957vVVKupSUrmST9eWOYm5YdJ
 6A3I03W7lfUSqVMFyksqg+QeONGjt8WTQD8v3AW/OV31D8HYzFzumizF/opmhtUrvkBxeLVNkJN
 vFR1lYXvKtgizGMmtXcKEmfYZeJRsHdrmsP/4hvA39avizf3f2AXvRWVPH5l/AASUnXKseXRpuh
 XnuGcTILEeWa2DF7Is6eQFr4=
X-Received: by 2002:a7b:cb8b:0:b0:490:3fdd:d353 with SMTP id
 5b1f17b1804b1-490424ad5d3mr250614955e9.8.1779891604020; 
 Wed, 27 May 2026 07:20:04 -0700 (PDT)
X-Received: by 2002:a7b:cb8b:0:b0:490:3fdd:d353 with SMTP id
 5b1f17b1804b1-490424ad5d3mr250614495e9.8.1779891603605; 
 Wed, 27 May 2026 07:20:03 -0700 (PDT)
Received: from redhat.com ([31.187.78.155]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a7esm6395843f8f.20.2026.05.27.07.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 07:20:03 -0700 (PDT)
Date: Wed, 27 May 2026 10:20:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] hw/i386/pc: Add a proper owner for the ioport memory
 regions
Message-ID: <20260527101952-mutt-send-email-mst@kernel.org>
References: <20260217141827.534426-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217141827.534426-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Feb 17, 2026 at 03:18:27PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Without a proper owner, the memory regions show up in /machine/unattached
> in the QOM tree, which is something that should be avoided.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

queued, thanks!

> ---
>  hw/i386/pc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0dd3fd01d98..ee72dd47590 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1127,10 +1127,12 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>      MemoryRegion *ioportF0_io = g_new(MemoryRegion, 1);
>      X86MachineState *x86ms = X86_MACHINE(pcms);
>  
> -    memory_region_init_io(ioport80_io, NULL, &ioport80_io_ops, NULL, "ioport80", 1);
> +    memory_region_init_io(ioport80_io, OBJECT(pcms), &ioport80_io_ops, NULL,
> +                          "ioport80", 1);
>      memory_region_add_subregion(isa_bus->address_space_io, 0x80, ioport80_io);
>  
> -    memory_region_init_io(ioportF0_io, NULL, &ioportF0_io_ops, NULL, "ioportF0", 1);
> +    memory_region_init_io(ioportF0_io, OBJECT(pcms), &ioportF0_io_ops, NULL,
> +                          "ioportF0", 1);
>      memory_region_add_subregion(isa_bus->address_space_io, 0xf0, ioportF0_io);
>  
>      /*
> -- 
> 2.53.0


