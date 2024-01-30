Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C40CC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 12:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnQ7-0007IG-GN; Tue, 30 Jan 2024 07:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUnQ6-0007Hr-KQ
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:40:54 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rUnQ1-0003OD-BW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 07:40:54 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a357cba4a32so319446266b.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 04:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1706618447; x=1707223247; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3xiuxMFz3OfQObhMihP2i/a0ELom1I9/fTE2cX0G9Pg=;
 b=m1QtG3qNdFPhQOBhSddb9ASJ7YjoGuzntECDZLSA+BUaNs38yir1Suh9gbTL+x6LW7
 pgqs9C0wtXoea/SbX2qRJwAljWH8qk+wSnY5ocspPDoYaZFTFg6GzccZ2lgjf3rAVJ0h
 IMUF7BNA5QZ2ChqcFpXLL5ng4m0jKq/TbHHp+D4PyqSzyj+h0WBUcvbN9wreDYBdC97d
 Ld0Syzs/wKBr0yVxIemr5O8Jf12biRJ7pWrEIHjA0odQiez7lgWFKgYf635gIKku2s+v
 9A4Q2sXe5kWPRmiOXUmCQeTJPLfY02TTZsjNF8feob8MogBneCgOaZc7brSB9Que2NnT
 LBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706618447; x=1707223247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xiuxMFz3OfQObhMihP2i/a0ELom1I9/fTE2cX0G9Pg=;
 b=w5nvfyUg5m30RZQMY8042/iuiSq925jsLDPy+M4+i409yArJLKRrM+Je1n/dcvL6Xv
 N9vMjD92zMGfmfQEobFbzSgze+RU5JeZ3NQGwCes/7ms324nGinC1feXLvPCKmxR+ehz
 duQUFPgZF6qpBZmLn9UyX0NcRKvW2do1PDIc552Ck+YW1UJSYj0110Lsn67kDSxr0Xbx
 XSaVJJqh23abS7o8oGZcKZrLsJ0fs/U1jAeEX9NhuWTnq5lg0IDnqrZFp9VmQrtX7A73
 lb/tG642jcUreUQbn5Y2yOZ+Mt1vSt1189yaWppaWEaARmhaV2kcsQzGvsIY416aGxUR
 Nf2Q==
X-Gm-Message-State: AOJu0Yw6ggT/69VWy0p1HrwSoe4n9FSCUNHZ8ymfPpJx+Fyo0xCT6p0/
 ex9jJG3Jg5WAaLV5MQfo2vobxMHqQuKA3SuPIuqABXhvLDwx3iaNTev8Nn6Jb3A=
X-Google-Smtp-Source: AGHT+IEyLXQQbYCZ84Z0Vnoej/iQ4ZAXl+PAUrd9OMGCV4+P/yE1YCXVPBP5Ap86hk+6ISGmIp/oUw==
X-Received: by 2002:a17:906:d146:b0:a23:493a:d355 with SMTP id
 br6-20020a170906d14600b00a23493ad355mr6629044ejb.27.1706618447457; 
 Tue, 30 Jan 2024 04:40:47 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 vu3-20020a170907a64300b00a360ba43173sm947594ejc.99.2024.01.30.04.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 04:40:47 -0800 (PST)
Date: Tue, 30 Jan 2024 13:40:46 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, 
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "alistair.francis@wdc.com" <alistair.francis@wdc.com>, 
 "bin.meng@windriver.com" <bin.meng@windriver.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: RE: [RESEND v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR
 creation to common location
Message-ID: <20240130-e230d950bf57b58d52188b64@orel>
References: <20240129021440.17640-1-jeeheng.sia@starfivetech.com>
 <20240129021440.17640-2-jeeheng.sia@starfivetech.com>
 <Zbczy87+E0gJEzgw@sunil-laptop>
 <BJSPR01MB0561C2196A51F2AE79DA67C29C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BJSPR01MB0561C2196A51F2AE79DA67C29C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 30, 2024 at 03:16:34AM +0000, JeeHeng Sia wrote:
...
> > I think either there should be a comment that this supports only v2 of
> > SPCR spec or it should be able to create SPCR of any version. IMO, I
> > think it is better to add support till v4 (latest). Since consumers like
> > Linux probably doesn't support v4 yet, ARM/RISC-V can continue to create
> > v2 itself for the time being but the generic build_spcr() should be able
> > to create v4 also if the arch requires it.
> A v4 table depends on the updated acpica. I am not aware if there is a
> request from ARM to update to v4. Anyway, RISC-V BRS Spec did mentioned
> on poll-based sbi console. I can check with acpica community if updating
> table to v4 is the go otherwise I would suggest we cont stick to v2 because
> there is no compatible ACPI guest to test the code.
> > 

Generally we want to produce the oldest version which meets the
requirements in order to support the widest set of consumers.

Thanks,
drew

