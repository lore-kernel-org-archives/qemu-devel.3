Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D38DC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsJ0K-0000SO-6I; Fri, 07 Aug 2026 07:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wsJ0H-0000RW-Us
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:44:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1wsJ0F-0004ir-Mr
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 07:44:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84847482584so1446858b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 04:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786103082; cv=none;
 d=google.com; s=arc-20260327;
 b=UHhPb+hZYDU5pqmTOiB6hmgASNXcxDWz9airucxvxJgV8PYvvdRa603Kej7cf+6DsK
 gsmViRJ6XfrHE81+P1pDIrkqC4mWw3kgU3NbUdU2kS6swkrXiue965FhEI4/ClPTwpTw
 70bMOY/7vuLhgbQqvpo5weknnWrpSjHmw5atWmDuc+2/1GRCau9xO895n2r/4vb/Tnz3
 SE6nn5+bAjSnESLdFxPvfTtEp9zoJIOIAttPOrwMPOSWkdYXwL27V0sMSevEv+0PIOrj
 Jb5wY7JmrXhqnw0X0AG4zSeHCgTBzEf8CZouM2hq4ZgPwitEMrxAp+KrSnWkTArnJhOs
 givw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=41JPAIhraK3Uu+LUtgfOOoDoU3Q8qBRNdB7vcMAQWRs=;
 fh=Fz21MFsN8P1W39+QETQ4Es7KMS0K2QZ1EYGhfoyqQHY=;
 b=O3UuqQjmTeO/JN69T1C5cOUPN42PHdvw3rROzGblQpd0wfhb2IX5EXUhB/S6P7BdC4
 8zi3Lm8vdPFcFyF2K5YNeaO+g3O9ZByTDFo1wHVjkpPCC4HNZ9BeYrhShLktkBMKQuI8
 dy4JqVh+QEf8lrDpWtrx40uK7dqfxXV/jRoGjmCq9V7OTESdwcWO7puQvskrUiPly7hQ
 MiZPcDxahyr6IsC567ZEX2Ho+i/IDvMhGcjqkGEhPniSK3FPXI4hhUvymCPEaIPoLw1J
 nRN8S+j8T1K07issHR0GSxkNQHAmGk/TB+ecGn47DQKrOsBm1QDcqJ5zUFW8PJ3agiOh
 D9jg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786103082; x=1786707882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=41JPAIhraK3Uu+LUtgfOOoDoU3Q8qBRNdB7vcMAQWRs=;
 b=Rhtm8wwmtMDoQte/bMVLfzRLJ5U/lej5dxKZXV8wpnVIWKSTg4S4jL8xhnAVIJH5Dx
 W1EW81JuOOcjJd8+KoQAaetzophlHs1jo6v8jGJtAOeJ3a0O1dVLOpFMrrTmZlUUGoeT
 8vlQFNsllywWEcZdo3f2HkJFyRou/bkbnjYqAUhb3X7uRcZhB+8X5k2tFG5z133lKHWJ
 NDmVEd3V3TL49QsHzzYzRM92Lk3G5THcxoTIjFAULbiBFqzH0ilMhbt+Na+fbNpy+8dc
 kOliud2nuNqWrCNn5oOrIv75nNkeRQ8wowQOOSYvIm5ea3/U8Nma+GKC57KYVO1ZfZXd
 v0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786103082; x=1786707882;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=41JPAIhraK3Uu+LUtgfOOoDoU3Q8qBRNdB7vcMAQWRs=;
 b=RFazbw8vQ0Tax36r5Vfoo1am23Dd3PseOJQf3oOspkRnzi7pBhQb8dqM2rAlO8hPad
 sa0/LLp/bg+tewpyuJpVeM8S7caOsgKSWBAHe/TDIvSGUIpgcNTXtH+4xd9eqqaE6WBX
 skl9kb/6P1hSoiJxM5jNxvUNtrj/lYVw+cpY9qS1O8YDpXgyHsNakCK9Y9YbKN7DENEF
 wMRkM+wVQNp+11IgtCfrfJUn0yRHT5vLQC+jQq1U1Kw3EBZ6DOM/ft2KQ9f8Bx9kxlPY
 Ldgo1ujVDlWUsOphpQ06N7b5Hf8G5I4Ph52BN90af+CNmX7MhFwAM7JR3ZTJ1I/qlNxi
 c/nw==
X-Gm-Message-State: AOJu0YwCOhBgpCR13Lnny5/+9ZXdrpEaPx+wZOdJHffSR651BgqYbM/a
 0kI3pHJOg31IxkpQzDw7y2DlFnDlZMtb2NlecYTFMH0uYTVbb3vOsWNxlLqjHKed7JQ+jEt55aB
 +dH15dqJt7ZBjxiI+gc2Ez47AQf/lSXk=
X-Gm-Gg: AR+sD12uYqd+fkzccLfk+uQik9RWD5fZJ43x5OyDsaPcwklMJ2ohxqYDgBheey5y8Ax
 /UgCj0Fz/VvIJVOrz2s5mdiRj3YPdONQ3SOOSSf88anF1lfOezwU6GmDRRjiuh5S0tw5HX7N0yA
 2KUdSVM3mqiYAGPQZOpzfcRqkO+MxVa+uGC6yiOk1Kuv4EKNFjhlb5nvrkxRf+ZDNKs1xdZXcWL
 spsgmPklbC8Fttstd85dFLyMgNEqyLwLCw1x9wdOch8EOpE4NTUHuTk9XpX3K/H86ioh4cktIiX
 lljb0qcjmK8LnU2xWNsOhbPunf2YevZugF4xoyKaftoiBXFyKGDQpiXPlFlMuNM4Krt7vhgR/Ti
 zHpNXOAaLAuIFwVsh7+U6n+iEt389PXdSvRE=
X-Received: by 2002:a05:6a00:f8a:b0:847:9dd7:2683 with SMTP id
 d2e1a72fcca58-84f41df42ccmr16861398b3a.9.1786103081720; Fri, 07 Aug 2026
 04:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260708221615.346155-1-faithilikerun@gmail.com>
 <anXCGzwqXVhkA3Yf@ryzen>
In-Reply-To: <anXCGzwqXVhkA3Yf@ryzen>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 7 Aug 2026 13:44:14 +0200
X-Gm-Features: AUfX_mw-U8wUg2kqCgkmebrmh0M3wZbsQzMa4t4AsmTh3t1wyF-crJdNqcYLo8o
Message-ID: <CAAAx-8Lk=i8oNYZe8GkegWrWvscfJ_NkAK2TGcPm52Pimuw=zQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/6] Add full zoned storage emulation to the qcow2
 driver
To: Niklas Cassel <cassel@kernel.org>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=faithilikerun@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 7, 2026 at 1:31=E2=80=AFPM Niklas Cassel <cassel@kernel.org> wr=
ote:
>
> On Thu, Jul 09, 2026 at 12:16:09AM +0200, Sam Li wrote:
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
>
> Hello Sam,
>
>
> I ran: fio test suite, zonefs test suite, blktests, and zbd-state-test
> (WD internal test suite), on the following backends:
>
> 1) QEMU qcow2 (this series):
> $ lsblk -z
> NAME ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
> vda  host-managed    256M     140         0        16       4K       512B
>
> 2) zloop:
> https://docs.kernel.org/admin-guide/blockdev/zoned_loop.html
> $ lsblk -z
> NAME ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
> vda  host-managed    256M     140         0        16       1M         4K
>
> 3) A real HM-SMR device:
> $ lsblk -z
> NAME ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
> sda  host-managed    256M  111760         0       128      32M         4K
>
>
>
>
> fio test suite: looks good.
>
> zonefs test suite: looks good.
>
> blktests: same amount of test cases pass.
> Only major difference I can see is for the following test cases:
>
> QEMU qcow2:
> zbd/004 =3D> vda (write split across sequential zones)         [passed]
>     runtime    ...  148.769s
>
>
> zloop:
> zbd/004 =3D> vda (write split across sequential zones)         [passed]
>     runtime    ...  47.446s
>
>
> real dev:
> zbd/004 =3D> sda (write split across sequential zones)         [passed]
>     runtime    ...  27.616s
>
>
> QEMU qcow2 seems significantly slower than zloop for this test case.
>
> Perhaps not something to worry about, but the difference compared to
> zloop is big enough to raise my eyebrows :)

Hi Niklas,

Thanks for running the tests and sharing your thoughts. A possible
reason for QEMU qcow being way slower than zloop might be the write
dependency of writes (qcow2 metadata, zoned metadata, data) for crash
consistency. I'll look into it to see the real problem behind this
when I have some free time.

>
>
> zbd-state-test:
> Show a test case for QEMU qcow2 that fails, but passes on zloop and a
> real device.
>
> You can use e.g. blkzone
> or libzbd:
> https://github.com/westerndigitalcorporation/libzbd
> to perform zone operations.
>
> I guess you could also use iotests for this test case.
>
> 021: OPEN_ZONE full to full... [Failed]
>             =3D> Expected zone condition fu
>                Got oe
>
> Test case seem to do:
> 1) Finds a zone in zone state empty.
> 2) Fills the zone (using dd), zone is now in zone state full.
> 3) Tries to explicitly open the zone (this zone transition is not legal),
>    and the open command should fail.
> 4) Checks the zone state of the zone, should still be zone state full.
>
> I guess the problem with the QEMU qcow2 code is that it actually changes
> the zone state to explicit open in step 3), while it should fail the open
> command and keep the zone in zone state full.
>
> If you look at e.g. null_blk: null_open_zone(), it also fails to open a
> full zone.

Ah, right. That=E2=80=99s a state transition I missed. Thanks for catching =
that.

Best regards,
Sam

