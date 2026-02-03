Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F4FE87847
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJFY-0000UZ-Eo; Tue, 03 Feb 2026 11:27:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJFG-0000Q6-3p
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnJFE-00039w-IB
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770136035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02EQFrh+B2y546oa54/YtDjTf0VTVuxTGdnclVcFeeU=;
 b=ErRZvBMkYHpWqSbeTOmNv2IM9+vx4+VSV5TWB6gwsNwUBdmatdFYh7HL7/VXhDp47lgefD
 12GOjXMQnDUPwRRpk5cv9gyNh0PncvAyKaAXtLcKbqKoVo+gmguNAoeYStd6XkxbruD1Ho
 wP/ci6dqCTgMjTAPLIwElDb8k7kuPDc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-Yuf0uDKxM66_NSaGs0NzWQ-1; Tue, 03 Feb 2026 11:27:12 -0500
X-MC-Unique: Yuf0uDKxM66_NSaGs0NzWQ-1
X-Mimecast-MFC-AGG-ID: Yuf0uDKxM66_NSaGs0NzWQ_1770136031
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso841205f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770136031; x=1770740831; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=02EQFrh+B2y546oa54/YtDjTf0VTVuxTGdnclVcFeeU=;
 b=AHfFPgM/FOVl2zbeFZ7p6uqzQkhq+b92O1xU43KYNL2IpQvje1eZWlgW0pLmTVU5xa
 ZiDXoKYGoZG91mJd4eZJebGZEabUu8jULQiqM1IbLOoLDyl7Y2nd5dff69PvHgbTBbf9
 sM4Xcu9urdoc514JnovNcg32mPNC2hit4cmvo6HzkFZ5atHPlLI39ZgLmCC2wd/1+M8p
 TUWAnxsL2mmUYqpK5hnyd7NJbnsGvDgIuBvxwdaBlrSag0q26B5dbhGTWAyQ+HVncLjb
 JDpmNb5GsER233HGODXnrlw+4JET9OH9TYpB7QrE6sU2rgCDrPbm98h5CkKOfyRR/xIj
 iNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770136031; x=1770740831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02EQFrh+B2y546oa54/YtDjTf0VTVuxTGdnclVcFeeU=;
 b=vFQfxtejVzStKPNyJtAlTJkYq8LxcIFF1/Lj1yxnPRhlS++SW73mn0dEbG3wowGkAP
 iQ2HEe6rTdMdamkRic84KImOg4An4W0s167EcRcAfJjBefrXnixbqlhW5ZIMmi5ezzsL
 YOzd3uChvuRBNW5zF6DtVz2Q30RWESOxbdeRPoAcVFci7VMpS34aHnGzxP0m3aCJJpOI
 PdvzItAMt9n2q10j9Ss/9msJ4Augz74jbI3a68xmWeH/L095Fuo6Y6efza0BfF3Cwa3Q
 q4y2n1gh0/KSk6jtAmDPg0Gu3lFzoTpG02Xgj8i2rsWZQSNKVC75AJxdHaqZtQjoAxcE
 h6cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl5aw8gsLi3mlSCXH2sYK/PrLTi3Nbc8rVU4DVsNakvA76Ah2hOF2U4fJ/d+db0/xBcwfV/iiJVsTH@nongnu.org
X-Gm-Message-State: AOJu0YwsMC0FtoqWeVP8E+j5pbrL/cu/IBbd9W1iDwtD5KCAXz8kb8E9
 u4biwSXWXFCC1VrlfF1tA7vEbkGl8K4M11p5E1JslQV57GNAGuRsia4GECGhBpfYX3ykeTV0XRc
 amr0EEzl68ytO1t3GEGRfIUo+N4hVBYp67j3iOv7OBhX/LWbXtbqAC5kI
X-Gm-Gg: AZuq6aKWyYTK2Q+Y2kfAgIX72sRogupwcow3lJSbzE9mOB/B0XN7j9wTZBcw+ObtxY9
 oWeElJrDCgnMXna8/4b3P4xYlRP2PHKc9bmfTtBGKBhd8hS38l5D3mIAE3C1XF8g6NFrh9uKiJl
 OZ4eSAzdKgx2EwJptHd3pRdk7cn87Mg+rB/W3O/XZa/V5fRpfyVLR3Xiv9DE+aUFoUTbm8WOcfw
 0W2c8pfBNoEbVuplYlBTWIKEUx8a+9ASdETnsAppv3XtZQuC0uu5cB6UP10kgL8+HzMom9Z9cWP
 l2gzV+RxAgiEswTmHQlzj+0OxEFAq2n6dtW3deELfUCcn0jet6M5XYZ5sAXJzcBUp5BZmUDS3iD
 m3zkHzRwThdhRHk8GBaHPuS6Bs2MbXoersQ==
X-Received: by 2002:a05:6000:40e0:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-43617c1d4b7mr2777f8f.2.1770136030792; 
 Tue, 03 Feb 2026 08:27:10 -0800 (PST)
X-Received: by 2002:a05:6000:40e0:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-43617c1d4b7mr2731f8f.2.1770136030271; 
 Tue, 03 Feb 2026 08:27:10 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1353f8bsm49497120f8f.39.2026.02.03.08.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 08:27:09 -0800 (PST)
Date: Tue, 3 Feb 2026 11:27:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Li Chen <me@linux.beauty>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
Message-ID: <20260203112450-mutt-send-email-mst@kernel.org>
References: <20251211102025.873506-1-me@linux.beauty>
 <20251211080811-mutt-send-email-mst@kernel.org>
 <19b104a617e.133b3feb891309.6986511857690603518@linux.beauty>
 <20251218161253.7f13038f@imammedo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218161253.7f13038f@imammedo>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Dec 18, 2025 at 04:12:53PM +0100, Igor Mammedov wrote:
> On Fri, 12 Dec 2025 10:01:08 +0800
> Li Chen <me@linux.beauty> wrote:
> 
> > Hi Michael,
> > 
> >  ---- On Thu, 11 Dec 2025 21:10:18 +0800  Michael S. Tsirkin <mst@redhat.com> wrote --- 
> >  > On Thu, Dec 11, 2025 at 06:20:25PM +0800, Li Chen wrote:  
> >  > > From: Li Chen <chenl311@chinatelecom.cn>
> >  > > 
> >  > > virt machines always instantiate a PL011/16550 UART at slot 0 and describe
> >  > > it in ACPI (DSDT and optional SPCR table). When the command line disables
> >  > > the serial backend (e.g. "-serial none"), the guest still sees the UART as
> >  > > a preferred console even though it is not usable.
> >  > > 
> >  > > Teach the virt ACPI code to omit the UART device and SPCR when there is no
> >  > > serial backend attached. This matches the hardware that the guest can
> >  > > actually use and avoids confusing firmware or OS code that relies on SPCR.
> >  > > 
> >  > > The bios-tables-test qtests rely on an ACPI UART node and SPCR entry for
> >  > > UEFI-based virt machines. To keep those tests working we create a UART
> >  > > with a "null" chardev backend instead. This preserves the ACPI tables
> >  > > while discarding the firmware's serial output so it does not corrupt the
> >  > > TAP stdout stream.
> >  > > 
> >  > > Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >  > > Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> >  > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>  
> >  > 
> >  > This bothers me:
> >  > won't this mean number of serial devices changes silently?  So for
> >  > example, if you install a guest, see that 1st serial device is broken,
> >  > configure it with 2nd one as a work around, now with your change there
> >  > is no second one so guest will be broken?
> >  > 
> >  > 
> >  > I seems safer to have compat machinery around and avoid
> >  > changing this for old machine types.  
> >  
> > Thanks for pointing this out, you’re right that changing the number of serial 
> > devices that the guest sees is risky for existing machine types.
> > 
> > For v7 I’m planning to take a more conservative approach and only gate SPCR
> > on the presence of a backend for the primary UART, while  keeping the ACPI
> > UART devices in DSDT unchanged. 
> > Concretely:
> > - virt ACPI DSDT will continue to unconditionally describe the UART(s) as before,
> >    so the guest-visible UART topology doesn’t change for existing virt-* machines.
> > - We only call spcr_setup() when there is a backend attached to UART0 (e.g. serial_hd(0) != NULL),
> >   so SPCR doesn’t point at a completely unusable console when the user passes -serial none.
> > 
> > In particular, for a command line like -serial none -serial pty, this means SPCR would not be present
> > (rather than silently switching it to UART1/pty). My reasoning is that, for existing virt machines,
> > SPCR is meant to describe “the board’s primary console (UART0)”, not “the first UART that happens
> > to have a host backend”, and changing that interpretation feels like it would need compat machinery
> > and a new machine type.
> > 
> > The qtests already force -serial null for the UEFI-based virt tests, so they will still exercise the SPCR path.
> > 
> > Would this behaviour be acceptable for you, or would you prefer that I go further and also add a compat
> > flag/new machine type where SPCR can follow “the first UART with a backend” while old virt-* machines
> > keep the current UART/SPCR semantics?
> 
> 
> all described above looks complicated.
> In ACPI tables we usually try to avoid compat settings, and do them only if we have to.
> 
> So question is how guest enumerates serial ports when
>    '-nodefaults' is used _and_ there is a second serial port configured (is it even possible?)
> check it with and without you patch please, to see what difference the patch makes.
> 
> > 
> > Regards,
> > Li​
> > 

Looks like this got stuck.  I think what Igor and me are saying is, do
not rush to do compat, just test what happens and document. If guests
survive fine, then it's fine.


