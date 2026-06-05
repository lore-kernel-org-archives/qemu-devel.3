Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A1CD6E7B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 21:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVbzj-0005Th-WD; Fri, 05 Jun 2026 17:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1wVbzh-0005T1-Mz
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 17:22:21 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1wVbzg-0004e2-1I
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 17:22:21 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8ce9de10985so26891706d6.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1780694538; x=1781299338; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+GeHPQCr0h5IeUy5JP7iplJYa1W8zdpKg/gZZV9XR4=;
 b=mTacl+wIg+8wYVnYdMGd57efGZStvND/FZ/qmMI9ZBpvcl8pw1A5o9a6iyn+LZLigg
 ItEFL2DI1bYNPjkBB6ZMW91ZG1W2v1WUFx2IvQBCZcRAaGfcwrcElO+E586YU4wjG/9F
 EQiqQqJ8b6aLAlrAmwCVwlW+QAUHyOugX7eR8bK0KQFGtw1hIzbbZ2CE9osyr8H8iQaa
 hkjaCKqXK+CdJybHuMx56THdPbTqLUd5HVhK+PWJMWePvUs/ASQVdsolmI+XOGyBkW+6
 BAVttlQvz+l2bIu3mHbPRHJuPRqkCQxx7pn2tsLebzXGdJhpxxFyKXytIFaryXSYmLtv
 dWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780694538; x=1781299338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+GeHPQCr0h5IeUy5JP7iplJYa1W8zdpKg/gZZV9XR4=;
 b=OzwQaCC9soSl3nf5U915Ry17ws2WE9C3wof9mO0oGD74exWCijK9gfsjScExpMXvev
 SiIjRvJ8lPSHko5VcNGvjb+fsSGmRSKnhuJNJC+eaGPfGFy6FDy+tzl+k8fHYaSWsnqy
 KlOCOJ/HGkyfWcoB9iKwqhA/4CNe3gIcEE2YtASLE/oZNL6diGZ8GQvwbUcTODMssoHX
 mFHSJ8dgsK6Ffk4i0w+ZKP9X8cdO4sxn+xR0i/mybqATnOnpyL/gH+u9FkDTSbfvuvcy
 3YznmiDY/T+bn6kkLwF3BplzGEqphlHmwNM8Qy7awpt9wBwOyrfj9jTbKQhrNgJLUH9Q
 Qd1g==
X-Gm-Message-State: AOJu0YwJboxmdTKPOBzw0ala6278LHKJh0/KPTrY07dCQsyDDmuBXzEU
 Hz0yQiuPHl5L9P+D6LoxJ0d3shC6wB0cBDQPoRZUoe6GsPUKp4gijCAfE+5l8sxPyZ4=
X-Gm-Gg: Acq92OEsQob3ASZjcW8Qose+TOg8fXq5DUVGy6quZod8Pltj31zbY9jXAFIMyTGetFQ
 +HvIRP3/mrGmtfeoUTOt4eqfibI4PCN4lHXY1OP8t8fWjFkB92lknOsn5tEcbzGa8ktw7U913+b
 O7Ute41sKOphdmUG0qpJ+LhcfB4lHeFm5bGfAd8ru6NVZsL9HZPk3qBfwlOZu0XURrvtzFPXC+B
 rSjoExaYP3cbpcJyGBVjxZSCsf2/XDGFQrIQvdhvSTR4Lj0xXs3Qoc/zmWuzCsg/kgy8u/7Lkum
 3OLlMP2X4amUVIFNkQQkxlQesMXjCXOf0tY8ggpjHsRhB+KMj6ir1K20nrWv6Y8+oWmf15GxepY
 GMBF2kfUEYPshXx5k50s3bchINeg5CNMJEAJO3NFLdJ/L1DwakDHAz4UX1aE+Sj5G/R1zm1a19C
 dLwG8MG/xa6ki0PtK6IRI479kRRs208qbu/IK5cjpt30cTdAugI8Y4V+6t54HH0yMcggOfVHTkZ
 C6IKKJZFolSfAeHRg==
X-Received: by 2002:a05:6214:5d06:b0:8ca:1e44:505d with SMTP id
 6a1803df08f44-8cee8c8f6f6mr73731406d6.17.1780694538178; 
 Fri, 05 Jun 2026 14:22:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd263003sm94185236d6.42.2026.06.05.14.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 14:22:17 -0700 (PDT)
Date: Fri, 5 Jun 2026 22:22:15 +0100
From: Gregory Price <gourry@gourry.net>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: qemu-devel@nongnu.org, david@kernel.org, imammedo@redhat.com,
 philmd@mailo.com, Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
Subject: Re: [PATCH v10 1/4] hw/mem: add sp-mem device for Specific Purpose
 Memory
Message-ID: <aiM-B6skkK5s2I4E@gourry-fedora-PF4VCD3F>
References: <20260605104609.1739911-1-FangSheng.Huang@amd.com>
 <20260605104609.1739911-2-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605104609.1739911-2-FangSheng.Huang@amd.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf29.google.com
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

On Fri, Jun 05, 2026 at 06:46:06PM +0800, fanhuang wrote:
> Introduce a TYPE_MEMORY_DEVICE subclass `sp-mem` for boot-time
> SOFT_RESERVED memory exposed to the guest with a per-device NUMA
> proximity domain.
> 
> The device targets accelerator memory (HBM and similar) that the
> firmware hands to the guest OS as SOFT_RESERVED memory, so a driver
> in the guest -- rather than the kernel's general allocator -- owns
> the range.
> 
> Usage:
> 
>     -object memory-backend-ram,id=spm0,size=$SIZE
>     -numa node,nodeid=$N
>     -device sp-mem,id=dev0,memdev=spm0,node=$N[,addr=$GPA]
> 
> The device is boot-time only (no hotplug).
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>


