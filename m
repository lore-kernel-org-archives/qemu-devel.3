Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC775CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 20:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUVSO-0001EW-SS; Tue, 02 Jun 2026 16:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUVSN-0001Dw-EJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:11:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wUVSL-0000N5-FD
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 16:11:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8419ab3a297so3839874b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 13:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780431080; cv=none;
 d=google.com; s=arc-20240605;
 b=QLIc6bsxpLiVKdWfTyEfbAgqu/b1rc/mUpiguNXHdp8MwT8hFgym0czeXTrchtfb3r
 BZVTAe1DGRDJdc8+XI3zFLN8otUOgmfP06jg61v/76rYq+jB+gyJ8rB3xNbaI2J/ySMj
 xCZik8Kzl1vbP+uyZxrvqL/zLOZ4wkbkV+3mGXTo5g+pMz3quHsgu8Lbp6KjnCjotXO4
 438VTJDpcdnejGq0wI6wl5mWPwTrodL8SLSfy0uy3KRlVf//M630llfDI7tSpFMT4b4f
 towFsQzYjtFTaBCEsKO+6lyNh2LGRVV47dp0WfaItYbNLXqK9RNu/n9/rkSzq130pXw6
 RkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=J9IoDhqjhV5OHFPDOisUwCeNZFZeYMIKTrz1fuyRlTg=;
 fh=3DUQ8Ro0rOsWR3j4ZmpBArjVBN8Ppp2wDZa9Ls8Aa6s=;
 b=DsT5CJeaTJ8NF8TnbMJy1iRIo9MAVkPDHMf1ziX26GisQpBULE0zZqFxT2PVJlP2Xa
 ISyrXzju+40LkRbfz65biRI9xQ91w+ghETFb88T9wZNcODZqugk06wYIBCF5rr4eafll
 3T60P9dvk/YkiOC6zjKMIm/mWjlNBkHJfbgXxS7MnebqYhl0HS8lPSufC2x2eabdOJXA
 gY3j7kglwlhfffsXRaLjY2uhm64+TKvmp7dOZhWrfJVavcrn2yWHBYwnnr8dIFnoNsz7
 kvBslhli2dIY6wM4uT2qe4sQgLYmuBrVuKCC+u3902JxeJ4eBcEv4HGm0oys/fVeshJx
 l5rg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780431080; x=1781035880; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9IoDhqjhV5OHFPDOisUwCeNZFZeYMIKTrz1fuyRlTg=;
 b=NFfy/Hl4PzoduwQnufRXtur1YXrlbEXu3MFX4dMIaojg/RPd3TB8UnpSOavleR65S6
 EeCS7BkYdW8qll9Z2+b93UoUA7HOZepYcj5BmJ+PmEaJTnh/WSbsuinxIZdw7JR19MFI
 95xl0Rmha7q1gnPcppECvpH5iOZPwIDxTO9aONocUM3KUfqSzsTvc8ynj51k80/PYNPV
 wR1UQ/cIpW+jSJx/OgmBN7CvMkIS6p5EfHJh3ZjfMf5fKwmaoKVUAtadwA7JaE2T2ShC
 P/pBiQ7FHIvtrf4QtU8IMTs31vOgCt3vPhL7aomcr9wavAq3qWdOg8hYFsGGGHe23NWo
 Nbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780431080; x=1781035880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J9IoDhqjhV5OHFPDOisUwCeNZFZeYMIKTrz1fuyRlTg=;
 b=ZeMTb32es2z3ZErA694QsuGCKVFxr8kk0cQxyjOzg/AKBwrlU7ee7CUeXSoCV4pSrH
 Bi/rMNOlgO5UmQOGn1eD1ANRqqx6pbYiAYupHIbTmCdHm+L8rsgxgVXTTZD8R0q/Ojsd
 k0guA7p/1Q4FFQXeSlljO5OvJ+6VcBt7iKYk4p1W0C2WQXAnr8YAxS9pNsv8jf+hP5XQ
 2qHuhL01icHoq3W7S1L+byghdFY+j0Wm+H9sSrWpzT3lzVDi6ibHY3W3l6nBMNMvonwA
 C+9x7CKFl4ictHOogubJFvn1XCu/nmfe2HcoAg7Onigb80MPgCzDOS31DD4cxzzTdWda
 YYUA==
X-Gm-Message-State: AOJu0Yz9vKZz+xaYItLM2tWKBTwqiZZWr8AVZvHdsFmLVzhQ1/j5FwjZ
 mCQhoaEhffIoWbWHlwqWkr+1/dlhuUcXbZ2h42yfHwHTEsfvuPPc+LKzjamYeXOE8EleE5B5SUe
 4CeCPjXUE2XYqY4zo09IXOAF00y/eZK0=
X-Gm-Gg: Acq92OElqGC7J6krPWQiVxCU72kT7zXefhf2XrqHjFsSvdgitBhsoK2fm6XcdOIYg2o
 Cjy+DCCz9+TVjivG/SQ7+Did0ZtQxw/Kh/7c05bndxMHcmGCu783M8fobm10QUOMB7CiokyXf+h
 2Wanl7sCqDeaIX3rbxHcwDJC2REp/MHSBR+x44FjIP2nWQreZfF8DhAhsepXo/FacykdktdlAD4
 Im5V8+17+p3ZTKzwJE/UewirU6SEGnUnMlEXzPp47Cf7L6p89z62L/uqvqd2HCkQOQM4XQIjQX9
 WIYJdho5oEzd8V6TL9Y3UlyhPcPG+npvR9Z2lXzYfCUYtk3fiW51LCm3hn+TYzFdutvRV5gyKxd
 HsRGvcnT7
X-Received: by 2002:a05:6a00:6d45:20b0:842:8500:95f1 with SMTP id
 d2e1a72fcca58-84285009a23mr235672b3a.40.1780431079668; Tue, 02 Jun 2026
 13:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260601214405.252818-1-faithilikerun@gmail.com>
 <20260602200638.GB1043118@fedora>
In-Reply-To: <20260602200638.GB1043118@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 2 Jun 2026 22:10:53 +0200
X-Gm-Features: AVHnY4LXaOq99WKb92Gs8IEe2iJR7JUFt1LXkd8UUyQQa-XwzRp77eoVkgKJwyc
Message-ID: <CAAAx-8Li+26pkBNuZ2cTOvMi-9MCp=YxRis-H1udoOaT3wEs5Q@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] Add full zoned storage emulation to the qcow2
 driver
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 dmitry.fomichev@wdc.com, Hanna Reitz <hreitz@redhat.com>, hare@suse.de, 
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 cassel@kernel.org, dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Jun 2, 2026 at 10:06=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, Jun 01, 2026 at 11:44:00PM +0200, Sam Li wrote:
> > This patch series add a new extension - zoned format - to the
> > qcow2 driver, allowing full zoned storage emulation on a qcow2
> > image file. A user can attach such an image to a guest and have
> > it appear as a host-managed zoned block device.
> >
> > The zoned format is opt-in through a new qcow2 header extension
> > that pins the zone geometry. Behind the extension is a dedicated
> > zoned metadata region that stores one 8-byte write pointer (WP)
> > per zone. The extension is gated by an incompatible bit, so an
> > older qcow2 implementation cannot accidentally open the image.
> >
> > Each write pointer is routed through the write pointer cache,
> > a Qcow2Cache object. The write pointer cache is written to disk
> > after the qcow2 metadata is written, thus guaranteeing that
> > the write pointer is updated after the corresponding data is
> > written.
> >
> > Zone states are in memory. Read-only and offline states are
> > device-internal events, which are not modelled in qcow2
> > emulation for simplicity. The other zone states
> > (closed, empty, full) can be inferred from write poiner
> > values, presistent across QEMU reboots. The open states are
> > kept in memory using open zone lists.
> >
> > To create a qcow2 file with the zoned format:
> >
> >     qemu-img create -f qcow2 zbc.qcow2 \
> >         -o size=3D768M \
> >         -o zone.size=3D64M \
> >         -o zone.capacity=3D64M \
> >         -o zone.conventional_zones=3D0 \
> >         -o zone.max_append_bytes=3D4096 \
> >         -o zone.max_open_zones=3D6 \
> >         -o zone.max_active_zones=3D8 \
> >         -o zone.mode=3Dhost-managed
> >
> > Then attach it to a guest via the QEMU command line:
> >     -blockdev node-name=3Ddrive1,driver=3Dqcow2,\
> >               file.driver=3Dfile,file.filename=3Dzbc.qcow2 \
> >     -device virtio-blk-pci,drive=3Ddrive1 \
>
> Please run `make check-block-qcow` and ensure the tests pass. In some
> cases the test reference output may be outdated and you can simply copy
> the <test>.out.bad file over the <test>.out reference file.

Thanks, I will check this.

Sam

