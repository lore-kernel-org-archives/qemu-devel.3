Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AF8CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 21:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRrv-0007KW-VN; Tue, 19 May 2026 17:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wPRrt-0007Jg-GW
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:20:49 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wPRrr-0006F4-U5
 for qemu-devel@nongnu.org; Tue, 19 May 2026 17:20:49 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so3916989a91.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779225645; cv=none;
 d=google.com; s=arc-20240605;
 b=gNmNFDNJS1gKqMzNSaPgczDcAKO4tVGn+k4cwfZw1ZL5CzSrBS64dXaikGH5AAvuXL
 FHa0jcA9oMJFcfgkdUL5wogM7pqKQfqjQFb+ZUbzR39FS84QHaLGaLnuqihvP7+OFrxq
 t59lwfHotjbx8avsFyrYWLbe+yNdiHpT0G5riZnrNwiSECtRq84Vhnuim9ZuKkR+NKdM
 H2fMvY+QdRB36n4zPwZ478100364gfK3zUqSNk19iw5AAgeWxSVctIIbCA3r+pwhneAD
 5dNXJri3dSo/IKA652WfGW5R0CSK6z1vHOEfaSwsHrVk9r5WVNvAaKawNK/1IpYXC7NN
 7Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AagRj1XK37Fm2tpkQ5rho9UXN2bVuqz6pvWn3B6t3UU=;
 fh=JHCSgk5nUIBLfegyCTJiljVyawZpZQ3tJgiYQEAS8Lc=;
 b=jCcs7lYk4xZ+96pJgrZDBj3nZujI/mP+eRSfWomjGRNJkzti9PSRRSwqifgXAry8hr
 d/Bx9EeGDP1/1cxRmhZP5m4qcRFrdswsNGlu9/Ugw8mS06UmaKzbOFwP2RYQFsTBxb3D
 lwdo/ehEA7MF2rt6eZfeN0VHGO0f6/XyoVll2Ctc4XQmPefAdD4mNJZsKSNLvh7Cd/LX
 +s1mO8jO3CnjR5MXmPt1tgALKtwodZ+bJV2OrI/Y1aHMZamSrAbK02gsxbwzg0Hl+9v5
 KoXpYQJSQ1PPfC8IESNtnypO1vJeGsAJa6tiFJyejVKP4oP682YJmQlk4uj5vuQdHLGV
 L1wA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779225645; x=1779830445; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AagRj1XK37Fm2tpkQ5rho9UXN2bVuqz6pvWn3B6t3UU=;
 b=UMclVHgj8ioZmdPpoQl4s5FwwJP/xcYj/eQutaRLGJNer4pOpa70v6NQau4tgs19+d
 fQtrh3MpHCQ6AffZ+jTQ7ByUvepalyrUPJSK92nUazSm9nThJyO3664fJC6c3F5JAL4B
 Haxefrc1WnitXgK3liWRUw9iS63gt3XFDqhzF0i3uj4fhG4EzjyPR/IybluUA486XP++
 AsUP5vslCODCfJwZ85ePYfIZXU8Okde/qKl+Td0xrxRkMK3IPV9RtUqfQT9vQYTRHlpm
 jLUCO7k3xVHa13RsBwmRWM8m9GSLSy5J0E2B3RxbtFNiIFBRq7S66FIwIrJAEjABCxP4
 1L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779225645; x=1779830445;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AagRj1XK37Fm2tpkQ5rho9UXN2bVuqz6pvWn3B6t3UU=;
 b=OB0ZNV8xlUhzSbQKGtUAH68AtR8Kw8RDsmqbW3XjO+Kumo3O82jAPb1RgInmg3lPu9
 uQSTXx72KGxwCZ2dzzmWGv2FGrT6HB0AkgxGyQujE2eFjafSBU7OYMAWdtwa0VD6gi/d
 xCLY+Mfq9Mv5c/3eU1cBRdZuVZBXMETA1wAODn7Ctc3Xl6mTIKX42bkrtRXqSNy9NBfn
 ALDjSBVi1v/U3AM/67AuJIR2PM+jaxA6ICbHNb4FptNOWxeMAy4JS+n7GuqrYhRTe7OK
 3AZZTT9FBpenAMFrv4HfWYhH23atmF/jyMEZNQE5I9rGVqL2eWMSldYWgcxjjMeCtF32
 ZiJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9g0uAkNcvMDRRjhF5Ne6eFllTpOalmg0QLDWDVHcFoxirBr1VDSCSRFHy9OrwC6RZcBQPjNhEu6hrU@nongnu.org
X-Gm-Message-State: AOJu0YwahHs5xqVmnII3zczcxbUJxHToVRCHosW1tohQZ9WaGiLw/NPK
 OBHvV0pln/zOhi3xqSKMRshUz4UHjhjwAV2E1W/dUZ9+BOMpo4sKLi8jvlea5FxOargtcpX/0VE
 HsxJx42LXhWray2LLrVwAYbPo+usNzfg=
X-Gm-Gg: Acq92OE0GTZetVPulQuaZmBw3tEuWum1DrSsdC/2pULoJI/BUXZdo3C0EuLLwUyDH02
 qvg8Su+Yhmif8wS/orHrjkulFwbvgmn/GXmnqPsp7HIm3KN7zXa94V5Z/n4d19qK0xDIXoe6kcZ
 kivTiS4lTnQykNZ/QJahUMTlmFvmO/o3pfNUfLCWyTI0TJxyWNdLbGBPkrHfZkhkeJXLZ+EWXGG
 OEbnScE3VH0+Wqxio9lH2op+/gwfOUp+rHgL0uJeFEiFMaySG6cUTh1pyCi3VFtig+SwUVzbkXf
 XrFVL3ZRkHfhI71EA+T/BPqpy2t7cW7pvuGJJ9L6fmZXpz6hGhGMvmqkGUf0nObJGNIE35PGCUC
 ebLsc1Jj0
X-Received: by 2002:a17:90b:5290:b0:368:a297:bd38 with SMTP id
 98e67ed59e1d1-36951a044b5mr20473331a91.7.1779225645516; Tue, 19 May 2026
 14:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260510175059.311814-1-faithilikerun@gmail.com>
 <20260510175059.311814-3-faithilikerun@gmail.com>
 <20260514194906.GC1535937@fedora>
 <CAAAx-8K+12SGZqzpLGsxjsr6iGAHwQu-TUXe6Z6rtZA27OpjrQ@mail.gmail.com>
 <20260519154911.GB119642@fedora>
In-Reply-To: <20260519154911.GB119642@fedora>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 19 May 2026 23:20:18 +0200
X-Gm-Features: AVHnY4Ijk31CFkYYx7pL-KDiafipPKQk2Fi82ceVL8-yoWL3lu9e82NMkKY_Gcc
Message-ID: <CAAAx-8Jooodx88LTJvVjHQYKj-SgkCxXkMTi1=ZdR3v3cpUvUg@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] qcow2: add configurations for zoned format
 extension
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: dlemoal@kernel.org, qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, dmitry.fomichev@wdc.com, 
 Kevin Wolf <kwolf@redhat.com>, cassel@kernel.org,
 Markus Armbruster <armbru@redhat.com>, 
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, hare@suse.de,
 Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x102c.google.com
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

On Tue, May 19, 2026 at 5:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, May 18, 2026 at 12:21:55AM +0200, Sam Li wrote:
> > On Thu, May 14, 2026 at 9:49=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > > On Sun, May 10, 2026 at 07:50:57PM +0200, Sam Li wrote:
> > > > +         48 - 55:  zonedmeta_offset
> > > > +                   The offset of zoned metadata structure in the c=
ontained
> > > > +                   image, in bytes.
> > >
> > > Do you want to say anything about the order in which metadata is
> > > persisted to disk when zones used? I guess the data is written into t=
he
> > > image file first, then the non-zoned qcow2 L1/L2/refcount metadata is
> > > updated, and finally the write pointer is written. Write pointers are
> > > not guaranteed to be updated on disk until the write request followed=
 by
> > > a flush request are both completed.
> >
> > The current ordering is not like that. The write pointer is written
> > persistently first, then the data writes and the non-zoned qcow2
> > L1/L2/refcount metadata updates. On IO failure, the corresponding
> > write pointer is re-read from disk. As noted in the previous comment,
> > the wp must be updated when issuing the IO, under the assumption that
> > the write IO will succeed.
> >
> > The ordering has been settled this way since v7 to deal with
> > concurrent zone append writes. If the wp was only updated after data
> > I/O, two concurrent appends would both have read the same wp and tried
> > to write to the same position.
> >
> > >
> > > (The idea is that the data must be visible in the qcow2 file before i=
t
> > > is safe to update the write pointer. Otherwise a power failure would
> > > leave the file in an inconsistent state where the write pointer has
> > > advanced but the data was not written.)
> >
> > The crash-consistency is a concern...
>
> Yes, I'm thinking about crash-consistency. The ordering you described
> can result in qcow2 images where the write pointer is ahead of the
> actually written data after a power failure or maybe a QEMU crash.
>
> QEMU's block layer must follow the same data integrity behavior that
> real devices guarantee.

I may have found a solution to deal with both cases. The fix is to
update wp in memory instead of flushing it before qcow2 metadata and
data writes. The zone append write path would become:

On submission:

1) wp_lock()
2) Check write alignment
3) wp_update (in memory)
4) wp_unlock()
5) Issue write

And on completion:
1) If no error: wp_flush with locks and return success
2) else, wp_lock()
3) read_wp (from disk) and use the read wp value as the current wp
4) wp_unlock()
5) return IO error

Sam

>
> Damien: Do real zoned block devices guarantee that the updated write
> pointer is persisted only after appended data has written been
> persisted?
>
> Stefan

