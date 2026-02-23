Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A156DEA4FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 15:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuXWW-00026T-Er; Mon, 23 Feb 2026 10:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuXWU-000266-Ne
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:06:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuXWN-00080b-PV
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 10:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771859206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xY/wcur34uQA1AvHGkhB/JcgrRWsHx7BxLZBZEOFWao=;
 b=XHpz6xYq03fzbFRKNVkTHYUse33tQ9XPh4Z8XGWFgR3CBfEC6xHPOWJk+4opP+x3L9kq1m
 hSHqURdEdNIXKs1d0EbqyLfsmcvnIIdQbug8vP1dcksFx1gu0G2fSOpLxYQNM0/apcBzDM
 LAdlWsWlPZx5zzkudrPhF3a4EnvBaGo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-W8WznhduOfaPNnZ2oBa_bg-1; Mon, 23 Feb 2026 10:06:44 -0500
X-MC-Unique: W8WznhduOfaPNnZ2oBa_bg-1
X-Mimecast-MFC-AGG-ID: W8WznhduOfaPNnZ2oBa_bg_1771859203
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48071615686so43169745e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771859203; x=1772464003; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xY/wcur34uQA1AvHGkhB/JcgrRWsHx7BxLZBZEOFWao=;
 b=m/3IM4L4wygIYwtmcY8xVoo20ydQRZ+8XiOJCrkRmUS3/MWvvmNE/FaOTqibJPO6xJ
 hnI8NCya/5la19kr77vdJP/NGiZFznMZq9YLniqXfOhcWNZ1ivOQet7966INavsGe4Ji
 /iPe2ptLxs642O6dElCISkxRBjaZ6/rELHvVm+faL4rKyLI14xlXcoMYdEufoBhfT1tD
 fFFl9KK0+1ae82kw3bvaJxCeQTQIZOIOw9nnxJ/9eMiRVU/SGmSFH96pF0/Mhe5YfIAM
 Nd5pxzsfdKTCoHOlu/TXN6EK8ulKBl8eeoNT0+RUQQQZ93yvhVWwJi4caNVTL8Lztw6j
 oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771859203; x=1772464003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xY/wcur34uQA1AvHGkhB/JcgrRWsHx7BxLZBZEOFWao=;
 b=v6iCK/HY/sG32mEVAw1s2l5lyV47HzplkUTiVSXikHDLBW9hbPFutRbpuom9T5nKXl
 QrHdF9JV8fOnjg1i3lyPJCyl88xR8jNNg1bTIUi6/1Z/ApMfJvqPOVUu9bMCCaIMo7bx
 qQtfdHXYoBwajRKRjobTGBt4dEyadbWF6Et08wUQr80i367gYYyMEekVFJkVfCAbw8QZ
 4pjIoBXgNFg5XcADCe8t4BNnu51YX/WiGXZ29BJ5d+06blRcrR3fM5DrHYJNIUPSEnf+
 KURAxjdlJuMUp6n+zNLZsD+oDs4Hp34VHXdR+wJANaJ5UY+WJWomLK7m8WOc1QivnaTo
 t3lg==
X-Gm-Message-State: AOJu0YxVmQflMhVW09t1I0N1XkrbJlY2BfBuiNA+E1L+dbVtZcxYUmvH
 na8sxKNNzj5AX6t+HibWjsTp2wfXx+IgH7N2UJpgTSEqyW6wN9a6zjltDUVcspZHQxFCh4P6Gdp
 EHVu0rM7A4NEro365InoobWi0ovucMffuU5/G1gRCm8eNs4bFw+4mztXz
X-Gm-Gg: AZuq6aJ0gUMFQCERgnQTasyK7T+BKgmUAe5jb4UQtZY/C686Z40WoH09+TfqUA3B6OJ
 4v77rh+mZFz54Xr3DrPFyKv5GDnXg2K7Iq87tS0i0jQXmExCghAP6l7Kxq9c1/PHzQL6uCr2ESh
 NGiceoSDlC4qTv3A8mJLDKLjsJ7KiLZL0ENjhVQ8khp+hSzlnrV5q+WAhNIG36rVWLsTganCahn
 z81ZMeZ6BKiy5CaD1SMVxJorQf07pcLKpdZ4VbG2MQkjFkA3ci2POROC5APCKJtzVMSDdy46a7s
 NIW2i/U0YIZzQ3BwD6lXv5q3WkQAzP2P+LDAyvxBHBTI3W1e4QpIzbJn7z1k3r2pSUmT3ZtLM5C
 H7byNx79xGro3xwkKfQ==
X-Received: by 2002:a05:600c:5486:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-483a95dea69mr128431775e9.22.1771859202658; 
 Mon, 23 Feb 2026 07:06:42 -0800 (PST)
X-Received: by 2002:a05:600c:5486:b0:483:709e:f239 with SMTP id
 5b1f17b1804b1-483a95dea69mr128431045e9.22.1771859202091; 
 Mon, 23 Feb 2026 07:06:42 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a82d8c50sm78972825e9.6.2026.02.23.07.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 07:06:41 -0800 (PST)
Date: Mon, 23 Feb 2026 10:06:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 00/13] Add more commands to scripts/ghes_inject.py
Message-ID: <20260223100423-mutt-send-email-mst@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
 <20260220130241-mutt-send-email-mst@kernel.org>
 <20260223123940.2b668dfa@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223123940.2b668dfa@localhost>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Feb 23, 2026 at 12:39:40PM +0100, Mauro Carvalho Chehab wrote:
> On Fri, 20 Feb 2026 13:03:01 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jan 23, 2026 at 02:35:14PM +0100, Mauro Carvalho Chehab wrote:
> > > Now that we have the basic stuff merged on QEMU, add more
> > > commands to scripts/ghes_inject.py. After this patch, this
> > > tool will support the following commands:
> > > 
> > >     arm                 Inject an ARM processor error CPER, compatible with
> > >                         UEFI 2.9A Errata.
> > >     pcie-bus            Inject a PCIe bus error CPER
> > >     fuzzy-test (fuzzy)  Inject fuzzy test CPER packets
> > >     raw-error (raw)     Inject CPER records from previously recorded ones.
> > > 
> > > Where arm is a pre-existing one.
> > > 
> > > The pcie-bus command injects a PCIe bus error - currently not supported
> > > on Linux (GUID: c5753963-3b84-4095-bf78-eddad3f9c9dd).
> > > 
> > > The fuzzy-test command allows injecting one or more CPER records
> > > for all GUID types supported on UEFI 2.11, with its contents being
> > > either zero or random, and with the payload size that can also be
> > > random.
> > > 
> > > The raw-error command allow reproducing a CPER from a text file.
> > > It is helpful in conjunction with fuzzy-test to re-test the OSPM
> > > after some fixes.
> > > 
> > > Besides the commands, a new helper logic was added at
> > > scripts/ghes_decode.py: when the tool is called with the
> > > --debug command line argument, it will translate the injected
> > > record, allowing to compare what it was injected with what
> > > the OSPM/userspace tools would interpret.
> > > 
> > > The first 6 patches on this series improve the qmp_helper
> > > logic to support the new functionality.
> > > 
> > > The next 6 patches add the extra functionality to ghes_inject.
> > > 
> > > The final patch improves its help message when called without
> > > a command.  
> > 
> > 
> > Pls run checkpatch on this and make sure the output is clean.
> > Thanks!
> 
> There are 3 warnings there due to the usage of the old SPDX "GPL2.0"
> which is identical to "GPL2.0-only", but were deprecated on SPDX 3.0.
> I'll fix those. 
> 
> The remaining ones are mainly due to long strings, or, on two
> cases, related to very long class and/or method names that should be
> passed as long name parmeters, like here (*):
> 
>         parser = subparsers.add_parser("raw-error",  aliases=['raw'],
>                                        help=self.HELP, description=self.DESC,
>                                        formatter_class=argparse.RawTextHelpFormatter)
> 
> I'll be fixing the ones that won't require mangling strings nor
> use some tricks that would otherwise make the source code for,
> IMO, no good reason.
> 
> (*) on this specific case, the "fix" would be to create an
>     "alias" class:
> 
> 	class Formatter(argparse.RawTextHelpFormatter):
> 	   pass
> 
>     Just to make checkpatch happy. IMHO not worth it.


Agreed.

> 
> ---
> 
> On a side note, IMHO checkpatch should be using a better default for
> Python, setting max columns max requirement to be 120 columns and
> ignoring or relaxing such limits on triple-quoted strings like here:
> 
> 	ERROR: line over 90 characters
> 	#83: FILE: scripts/arm_processor_error.py:83:
> 	+[Hardware Error]:     bus error, operation type: Generic read (type of instruction or data request cannot be determined)
> 
> (this is part of a comment there describing the Linux Kernel
> output for an ARM Processor Error - we should not enforce any
> max column limit there)


Linux switched to 100 for everything and I think we should, too.

> 
> > 
> > > ---
> > > 
> > > v2:
> > >   - the bus error injection is for PCI/PCI-X, not PCIe, so
> > >     the command was renamed;
> > >   - added notes that not all CXL types may occur in practice;
> > >   - removed a field from common_fields at DecodeGhesEntry
> > >     decode class and make it more robust;
> > >   - some cleanups at patch description.
> > > 
> > > Mauro Carvalho Chehab (13):
> > >   scripts/qmp_helper: add a return code to send_cper
> > >   scripts/qmp_helper: add missing CXL UEFI GUID
> > >   scripts/qmp_helper: add support for FRU Memory Poison
> > >   scripts/qmp_helper: make send_cper() more generic
> > >   scripts/qmp_helper: fix raw_data logic
> > >   scripts/qmp_helper: add support for a timeout logic
> > >   scripts/ghes_inject: add a logic to decode CPER
> > >   scripts/ghes_inject: exit 1 if command was not sent
> > >   scripts/ghes_inject: add a handler for PCI/PCI-X bus error
> > >   scripts/ghes_inject: add support for fuzzy logic testing
> > >   scripts/ghes_inject: add a raw error inject command
> > >   scripts/ghes_inject: print help if no command specified
> > >   scripts/ghes_inject: improve help message
> > > 
> > >  MAINTAINERS                    |    4 +
> > >  scripts/arm_processor_error.py |    8 +-
> > >  scripts/fuzzy_error.py         |  208 ++++++
> > >  scripts/ghes_decode.py         | 1158 ++++++++++++++++++++++++++++++++
> > >  scripts/ghes_inject.py         |   30 +-
> > >  scripts/pci_bus_error.py       |  148 ++++
> > >  scripts/qmp_helper.py          |  164 ++++-
> > >  scripts/raw_error.py           |  175 +++++
> > >  8 files changed, 1857 insertions(+), 38 deletions(-)
> > >  create mode 100644 scripts/fuzzy_error.py
> > >  create mode 100644 scripts/ghes_decode.py
> > >  create mode 100644 scripts/pci_bus_error.py
> > >  create mode 100644 scripts/raw_error.py
> > > 
> > > -- 
> > > 2.52.  
> 
> 
> -- 
> Thanks,
> Mauro


