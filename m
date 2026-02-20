Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861F0C5AD48
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 18:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtUqP-0005yq-CD; Fri, 20 Feb 2026 13:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUqN-0005yN-GZ
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vtUqL-0008MM-MH
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 13:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771610588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8BqyhamLPG1wqiRxSKi+hMjMvS/VOx1f4OgQrMdvdw0=;
 b=baJ8QgNtdY4Ihg/JVY22lhYzLdC4mQhjCO8kAu9gPw++1dushaJ/XgD7ao7oC2CJmwT3Rf
 4r8eph2R4s+IkK48x3j56NV8Rw389XYFxhVCVgMRN96CZTzKrtH/kG4KOi28pyQ954PAUE
 nT5c7G/sOsFyewy1+XUufDqh0QVX3II=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-NIXJXjISOb2-FTN8hSPo9Q-1; Fri, 20 Feb 2026 13:03:07 -0500
X-MC-Unique: NIXJXjISOb2-FTN8hSPo9Q-1
X-Mimecast-MFC-AGG-ID: NIXJXjISOb2-FTN8hSPo9Q_1771610586
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4376761037bso2371327f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 10:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771610586; x=1772215386; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8BqyhamLPG1wqiRxSKi+hMjMvS/VOx1f4OgQrMdvdw0=;
 b=k00wyawjPC75egslJMrsN48EDk5i+/blJUfQ7N8mZEtunE7JYNpFCb23w5Byvvns+T
 A6DwIofdvNAf8BxHRGkQv8P9U1d/nb2ONouX95bOsJguzuPhjiNmlHcIkees/ydqVnuv
 q1bfo3i4XszsqRvLtyRUzbUBStQhpoZJzVR26uEaaFA/5DnfHJAC/jvjQLg5+vq4ZZt/
 opTxi6mtEgHKviAxyncvfSAekdOHHnjpB5wPXolK/Zjd+WMkxFfhfbgfgGeSxu8Zyskg
 kzGjBPI+ZjwCEuD4P6TM9KaNjFWBM50KaKoUxcT0e8PJtuSyb2lFCuSmUqAbxsuWKRbH
 7NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771610586; x=1772215386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BqyhamLPG1wqiRxSKi+hMjMvS/VOx1f4OgQrMdvdw0=;
 b=mBXe9Enc1+EL+iGIE525QZIoXww15n28j/kA2h/rW3ah161/F/ojuy/uKATuXkchG1
 bP05D32qAJtICEN3oMmdZ0uTgpTwy10YHhDUYAEKCmZxtVxzGULPPgugwrgP+nyMNcCu
 reQIg7p4zmoKplb9E3z6QwNknSZxgHrKm42gZQuektHQuW2NlwCNLYunMm25NfoNikvZ
 tmm49iNmncIrpg5nprXFNgit+r6YhYUxMI2IebV9I5TM8D3lFuDbZzFgnc+ldCVRSwXu
 iNEPgtTbg5d0JOYQgpE87VgZrEsT/JikkbRpv8jeN/8Iuonl8p8Kms9iGVSPsDiVt313
 B3Xw==
X-Gm-Message-State: AOJu0Ywhuw4xMtO6EoVGA6xuxngHgrUcJ0Xz7cLQRiGrYpq9IRXkZn/6
 ZFqWyxguHSRWUZ505cfeSs2KSbdKKuIA5cEGuN3dvtKiumzkXxrcgnP/CzgFa8+fCrWIMbSP4qT
 AWUgl44S3etLk4aXrBd2XR6c+a0asTkMvVFeiYdovtdqAs3yaAiOnj0j7MDiUZMpM
X-Gm-Gg: AZuq6aJJecWrlTDNoM8z7di4bonohB4A0/tSu++I+lbbFs/yl1WBUD6+zdOGddqmk/e
 QnnhiCYUqBLq7QPM3yqiINmaQ7RXvac0SVmE4ZHvS4WJn8E3e3s/IeqMMg6Rry1IjoHoQ8H9aqa
 Vs/jsy9Osbbwc9oI5ekh5Hpdj66wHHe86nqIrEMRZcu50LYX69fe1ctMlGFYgsN7l2lJtpLoGJw
 yMK4tYMa4pNk7vNYihAMSVTGDbgWfTMpKQ8StdpR8PeRsfgEsA5IV+zp1xtAoRY0hxbmWrVcfCT
 qntllXZ3g7gFaWUM2KT9JGbs5qPVi/vzFNbZsPAKnCTWNTLEkUbHL6kMr5sWjtcq0YaTzWLv+iL
 2PWFtIMkYp1lwSKZymksADAGOA3uDVbk44qMQrkEra2E14g==
X-Received: by 2002:a05:6000:288e:b0:439:5fe4:421a with SMTP id
 ffacd0b85a97d-4396274faefmr12550231f8f.30.1771610585801; 
 Fri, 20 Feb 2026 10:03:05 -0800 (PST)
X-Received: by 2002:a05:6000:288e:b0:439:5fe4:421a with SMTP id
 ffacd0b85a97d-4396274faefmr12550139f8f.30.1771610585117; 
 Fri, 20 Feb 2026 10:03:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm59141047f8f.31.2026.02.20.10.03.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 10:03:04 -0800 (PST)
Date: Fri, 20 Feb 2026 13:03:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 00/13] Add more commands to scripts/ghes_inject.py
Message-ID: <20260220130241-mutt-send-email-mst@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 23, 2026 at 02:35:14PM +0100, Mauro Carvalho Chehab wrote:
> Now that we have the basic stuff merged on QEMU, add more
> commands to scripts/ghes_inject.py. After this patch, this
> tool will support the following commands:
> 
>     arm                 Inject an ARM processor error CPER, compatible with
>                         UEFI 2.9A Errata.
>     pcie-bus            Inject a PCIe bus error CPER
>     fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
>     raw-error (raw)     Inject CPER records from previously recorded ones.
> 
> Where arm is a pre-existing one.
> 
> The pcie-bus command injects a PCIe bus error - currently not supported
> on Linux (GUID: c5753963-3b84-4095-bf78-eddad3f9c9dd).
> 
> The fuzzy-test command allows injecting one or more CPER records
> for all GUID types supported on UEFI 2.11, with its contents being
> either zero or random, and with the payload size that can also be
> random.
> 
> The raw-error command allow reproducing a CPER from a text file.
> It is helpful in conjunction with fuzzy-test to re-test the OSPM
> after some fixes.
> 
> Besides the commands, a new helper logic was added at
> scripts/ghes_decode.py: when the tool is called with the
> --debug command line argument, it will translate the injected
> record, allowing to compare what it was injected with what
> the OSPM/userspace tools would interpret.
> 
> The first 6 patches on this series improve the qmp_helper
> logic to support the new functionality.
> 
> The next 6 patches add the extra functionality to ghes_inject.
> 
> The final patch improves its help message when called without
> a command.


Pls run checkpatch on this and make sure the output is clean.
Thanks!

> ---
> 
> v2:
>   - the bus error injection is for PCI/PCI-X, not PCIe, so
>     the command was renamed;
>   - added notes that not all CXL types may occur in practice;
>   - removed a field from common_fields at DecodeGhesEntry
>     decode class and make it more robust;
>   - some cleanups at patch description.
> 
> Mauro Carvalho Chehab (13):
>   scripts/qmp_helper: add a return code to send_cper
>   scripts/qmp_helper: add missing CXL UEFI GUID
>   scripts/qmp_helper: add support for FRU Memory Poison
>   scripts/qmp_helper: make send_cper() more generic
>   scripts/qmp_helper: fix raw_data logic
>   scripts/qmp_helper: add support for a timeout logic
>   scripts/ghes_inject: add a logic to decode CPER
>   scripts/ghes_inject: exit 1 if command was not sent
>   scripts/ghes_inject: add a handler for PCI/PCI-X bus error
>   scripts/ghes_inject: add support for fuzzy logic testing
>   scripts/ghes_inject: add a raw error inject command
>   scripts/ghes_inject: print help if no command specified
>   scripts/ghes_inject: improve help message
> 
>  MAINTAINERS                    |    4 +
>  scripts/arm_processor_error.py |    8 +-
>  scripts/fuzzy_error.py         |  208 ++++++
>  scripts/ghes_decode.py         | 1158 ++++++++++++++++++++++++++++++++
>  scripts/ghes_inject.py         |   30 +-
>  scripts/pci_bus_error.py       |  148 ++++
>  scripts/qmp_helper.py          |  164 ++++-
>  scripts/raw_error.py           |  175 +++++
>  8 files changed, 1857 insertions(+), 38 deletions(-)
>  create mode 100644 scripts/fuzzy_error.py
>  create mode 100644 scripts/ghes_decode.py
>  create mode 100644 scripts/pci_bus_error.py
>  create mode 100644 scripts/raw_error.py
> 
> -- 
> 2.52.0


