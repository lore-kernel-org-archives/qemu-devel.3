Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCB1EBFD20
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDI9-0003uY-MG; Mon, 13 Apr 2026 05:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCDI6-0003uH-C7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:09:11 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCDI4-0006AM-PP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:09:10 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-650775f427eso3937033d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776071347; cv=none;
 d=google.com; s=arc-20240605;
 b=AS41ZkyKpI66NjjREjNTKBNtwdpHaKUGEjUSpixm/Nq+YDZKe0KTDSNXpCvvTMEKnp
 RnjcqKQPt5UxlLFgm4mxtUuWway6tkn/aF3LzW402rEdhFZJliOU4vZ5ptDQJmYow5Q7
 H/dmM5lqsXiAlJErR7ftbzjOC60rMDWdQuK/o2PFgz1fudF7uNTsgpigQvB9ZwqlGGW0
 iUaJ/74rSvl/ZDSRFH9nDHN5f11XYO9m9eeZgz/Mtw0k69CpLDrdlJDwTCmEW+BgzOyG
 YwP+8WubUFzcPt4bOY2zFUgxOY12ViCVHOtvfxV1qZ420HSJzViPTlnI/Xy3hmAxcroH
 b5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=f8ilX+gdAZ9g1XYXS1qMUyfc+GbkP+U+4MtaUgVSn78=;
 fh=oWasgPKpuhQcy1Ua24rQBXMxZ/CYqbGa8H3wcr48x0U=;
 b=KXC+Ss00y0WbqO71aN3SSxKfm2gk5IoE4WNZBoxbh3IZa5XPDJ4RdU0agilj7tdH8Q
 /CrlNtjaL7S9PQXN5x04rn7eQV2QI5rlE2cUlUFmtcQG8qMcGzfE7Qc8clQInS6M3m7L
 syFojJzn4D+SRgtCbiWnPqydeefS4D9Fcm16TfapXnE+gKFS0hKZVli9nt7XkV1ppEXD
 nTKTFgOLbjK7KfZPQmv52/2n4GzXuQbRpDE7tP4CTSMwIzIZbCzHoUQxpGup6vp55dQL
 11fYcuUB0hOZemePBgvAmqsusvaPbi5zwPKm592qGvkVfc+2OG7H1jLrKub3O6tyA4KB
 8W/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776071347; x=1776676147; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8ilX+gdAZ9g1XYXS1qMUyfc+GbkP+U+4MtaUgVSn78=;
 b=Oy7+SihL8fDQUVDhngiqLDQgxrDUX+nXn3CrDiCfLOXRirj8z33lneSuVT9/DZSzUE
 7F2IAC0ZYJ8WCJynPdZRzeL9C1s+ioOvj2eUV1mGMxtYPSADlQgdHLx/2UCn8X2ihwjS
 VlipAjQgG7RbPXxqViDELX92rE5uI/pbL6I4JzQunRJnyrtGLcJLDPxShpqxwYF7o8Gc
 kWI4sc649FUJspPcPmRtvYWavCyLZpJwScqxcxWgRexVpho6YRFUxaMSq+DIq8kopkYj
 u70YFn35yIajEUoPhtPz4HRqB+v/sTbSDsAZMqjg5GWDwR7mJ3s/obVTY+gGoWG7ffSj
 Hmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776071347; x=1776676147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8ilX+gdAZ9g1XYXS1qMUyfc+GbkP+U+4MtaUgVSn78=;
 b=ArwilRNAtQjbCKrDF7W4RGOMCwS+MmKRHLIcJZaIlHSl0+xlFzsK+p0UePZ0BP2AUL
 5n59Rcf7FyWTLijcvTDKaHp7G7lkYYfKRlGwg5VTp0xYS/ci76cENX7yNhyKMocinHCn
 ofc/Z4RECdVh8cH6hPuhW0If8vBolS7vI4sbtHRhMb8Z2W4H4sB4LLutu3T+tZUivqX8
 1hHV/0WkLCiy4yILxzafXoWbkmEZvbVRN+ExfaPOSFenwRXB8zcWnzkATYY1CY02HEkG
 aN+x30udOzhyPQACfHj8CN/ERWGemgCjhPy+GCo8PGnDAuY1LxNwdVbvvTDIgTWzWDRy
 Vjvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Mnp3ip92XEIU9tps8T2iUG7dcxTKkUdRlfX9UyzfqGy5AuIssG0ofBDrTYAMJG9oqgqU0qM8qCuBX@nongnu.org
X-Gm-Message-State: AOJu0Yw43KjwjaNPpw9gO9fLXI80u1Wxc/hcbzDxC+RTQNESUx+5Ug+d
 j1WTwTd2iJh1Laeb7bOHGj66SbnVuHqO+U5fH+qBvGBbmMVpriOo6f79nXm/UUcFR0f/7xtTxnE
 qrPTTuyQtW1MdKa+qeLksXL3QuNGNRRvGcFEASHXs8g==
X-Gm-Gg: AeBDies5xX8La2PndJy1wz9x8frh2SEa1XjJClXfJPB381Q25Th3XILCN4oEM9vsbap
 LF2S64PyVHH5c5wrX7FFew1TBswnBJSPQGpTDkgfhKVSN3IN+oC0DmvPH0GeiD4ZA0knmonY1ZM
 sgv3owaLfsTK6s9L9VfHSVaREZUdKumZML4Ttou8O4nPes3QMr3GjCAaxdq6kab26n7DGnNq/D6
 1QNOTsKiMdCA2fNJiblKg1r2+zyq1/NT6xO2DAEh/hGJtBs3RkNxTYuf7oX1y3QqzESe22LhgGO
 NGYKqqspAWrXLPKIT439ReXra67outO+AJTveJyqpvm3PGLsmKCKvujr+x36NULGk0I=
X-Received: by 2002:a53:b1ce:0:b0:64e:a7d4:473a with SMTP id
 956f58d0204a3-65198c356e7mr8118513d50.67.1776071347088; Mon, 13 Apr 2026
 02:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
 <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
 <abkPy4Xzf6YT6g5Y@sirius.home.kraxel.org>
 <CAFEAcA-dTkoKs0tgF+VV0PayFbDcmH_t64P6AOT18ShwEKTW_g@mail.gmail.com>
 <adyZm41cp_nZHPYj@sirius.home.kraxel.org>
In-Reply-To: <adyZm41cp_nZHPYj@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 10:08:53 +0100
X-Gm-Features: AQROBzC7EEDvSlCe2iUcRzrsWd7HluxJeV69VGH7eYYSFlAF3QoGTZlHxDouMsM
Message-ID: <CAFEAcA-pZCrti_==m2u-Kq55dmqBcs8S=Ztns8moBxSe2fV+ug@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Luigi Leonardi <leonardi@redhat.com>, 
 qemu-devel@nongnu.org, Oliver Steffen <osteffen@redhat.com>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Mon, 13 Apr 2026 at 10:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > I'd like to have something more convenient than that to turn on firmware
> > > debug logging.
> > >
> > > On x86 we have a dedicated device for firmware logging (isa-debugcon),
> > > so logging can be easily enabled on the qemu command line by adding that
> > > device.
> > >
> > > So the idea here is to have a dt property added to serial port to
> > > setup firmware logging, so we have something roughly comparable to the
> > > x86 functionality ...
> >
> > My rough rule of thumb for DT properties is "if it is a binding
> > officially documented in the binding specs in the kernel with
> > the relevant semantics, then OK"; but not ad-hoc bootloader
> > specific stuff (we have turned down requests from u-boot for that
> > in the past).
> >
> > Would using the fw_cfg mechanism work here? That's intended for
> > passing configuration info (and "how verbose should debug be"
> > seems like configuration info), and we already have a command
> > line interface for it:
> >  -fw_cfg name=edk2/debug-level,string=1
> > (or whatever).
>
> I'd very much prefer to use device tree.  A device property is maybe
> not the best choice.  There is this /chosen node though which is
> already used to pass around guest configuration information (kernel
> command line for example).  Maybe we can add properties there?

Sure, if you can get consensus on a device tree binding for
it and get that documented in the kernel's Documentation/devicetree
then we can implement something.

But fw-cfg seems to me to be a much better fit, and it has
the advantage that it requires no changes to QEMU at all.

-- PMM

