Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EEACD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWrQm-000841-MI; Tue, 09 Jun 2026 04:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1wWrQi-0007yu-0M
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:03:24 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1wWrQg-0006YC-8S
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 04:03:23 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A2FBF80A1A;
 Tue, 09 Jun 2026 10:03:17 +0200 (CEST)
Date: Tue, 09 Jun 2026 10:03:13 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260604134422.359214-1-kraxel@redhat.com>
 <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
In-Reply-To: <CAFEAcA9RnjQyxmBcBunrMq6EB=L=Oc4_aWQAYY8rVFr6mKWXog@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1780991819.o9da17rttt.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1780992152112
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=f.gruenbichler@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On June 8, 2026 4:19 pm, Peter Maydell wrote:
> On Thu, 4 Jun 2026 at 14:45, Gerd Hoffmann <kraxel@redhat.com> wrote:

> [..]
>=20
>> +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
>> +distro install media.
>=20
> I think the BOOT* names are a RedHat-ism -- my local Ubuntu box
> has "shimx64.efi".

Often, you'll have two copies:

$ESP/EFI/BOOT/BOOT*.efi

this is the "UEFI fallback boot mode" compatible copy, which the
firmware will use if you just select "boot from this disk/medium". Grub
calls this "removable".

$ESP/EFI/$VENDOR/shim*.efi

this is the regular copy that your distro will register with the
firmware via a boot entry, usually with the name (and maybe version) of
the distro as label.

>=20
> I think we could reasonably expand this to
> "in the ``EFI/BOOT/`` directory on distro install media.
> It might be named something like ``BOOTX64.EFI``, ``BOOTAA64.EFI``,
> ``shimx64.efi`` or `shimaa64.efi``, depending on your distro
> and guest architecture."

asking "efibootmgr -v" might also work. all of these only work if the
host system is set up to use secure boot via shim and..

> Do we need to warn the user to make sure they use e.g. a matched
> shim binary for the guest kernel they're trying to boot, or can
> anybody's shim binary boot anybody's guest kernel ?

the vendor cert(s) embedded in the shim need to match what was used to
sign the booted bootloader and kernel, and the/a signature on the shim
binary must in turn be trusted by the firmware. you cannot mix and
match, as that would defeat the purpose of those signatures ;)


