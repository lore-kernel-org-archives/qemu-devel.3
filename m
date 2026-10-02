Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19206CA5FE2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCg8p-0003rH-86; Fri, 02 Oct 2026 12:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCg8o-0003qs-1f
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:29:46 -0400
Received: from mail-ed2-x28.google.com ([2a00:1450:4864:33::28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xCg8k-0006Fp-GP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:29:45 -0400
Received: by mail-ed2-x28.google.com with SMTP id
 4fb4d7f45d1cf-6acbd4b7194so80995a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:29:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790958581; cv=none;
 d=google.com; s=arc-20260327;
 b=mHxC7EM9cxq1ndOA9mmA+OpPvoUYw+1svnC+qcorp5ktRfLmYLJSpkcnR+3yoNHUHA
 MOTnCQTLBEbrEt8j1NHVFbndxcFtObD3sTRbvC1ZQV8tcxT3ORKwqhfuGnYWjAXXdVG+
 U1hO2Rkvz1BAm0lEfC98Cl7dRyRBHoScZlsn9FicvexurwFYuaFAmQFDLBOwuwCeaXuS
 DR/AAiNirdb+NJdctw5N8Rpm+dtirC4Cgfw6PGMJuy0MWo+ov/st81aKcMu8NbTtlKcD
 Zrj/ftdw3GEvigAz15e8Nc3phUaWH65b1JUUuCIRYHvlB3KoYttDtFTZBvNSO9jFw3ar
 8R7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=8QYP4iqVL/Bo4aAk1Gz9BW7wk23FJZepzfTC9gF3h2A=;
 fh=HLkx8nKPxW0rHKvPmy1S5l4AfZCQGPzmXRnxDNV9u8c=;
 b=UrFmkokR7lfXWAKtLk/yRXL5ZsmuAMMPyCq1HFr/+DZEjMNIBxvViLTiHVF84Njci9
 7yoLuVecv1RCUU/x/0dFO9Av5gh7nEpRzj/mAaVxuBcsCJhQUpV/QWLdISLcTL57oj5i
 enjnZMj6WYICOt51AT/P2vc/R//GbQ7WhOTqnIcaMgsgrFyEhEzkMKAxmb25t1TJAAjf
 LcQD4wvMquqSanWcIS/P3TGzzF91jWYWTA/xbuJGRFxmCE0CTXDGXH3bTPhlkToaqyrf
 g+IMrtOv2eXiyTVxSflaxN7+D9I1lq8lvZBtjwNMewtranfOtMH3D8BcoVQrW2onFwYB
 jQXw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790958581; x=1791563381; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8QYP4iqVL/Bo4aAk1Gz9BW7wk23FJZepzfTC9gF3h2A=;
 b=bbOVa1imVwhgoG+dKFOqd4x7qeNO8/K6MuZEro3CNs0fP/lb7+NYAaR1l4q7QxWT6x
 k/BWMvLAzluu68Nyu3zZMk1IvQ8aCQMYA04q908xtetbzwZOaFE32xp0yNgQQHFQ6b8e
 2IWfGzIGyJy0Stx7XIxA1M/99Dhaqej0Pm5dtVEOX0Db7GHBZzofmUVOLxBLLt2unHSQ
 ddO/k7vJCxKhXlQqzZxSPaHPFqR85narWpnNBd3aGIFiltLkpFiCSIDU2p23DyEKPNnG
 BTa+lMuSUkyrDihXV0rjRTBGzd5qdo3rZtfpZiefciDtSWp8d5q1ABx0wIzicGAxrJeh
 eQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790958581; x=1791563381;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8QYP4iqVL/Bo4aAk1Gz9BW7wk23FJZepzfTC9gF3h2A=;
 b=ssrdgR2lXIC6xbX4tXqL0i7NCinkfD79cxrrxVNfUvVYYZbhqvAbYVrLasU/S8KAC/
 /irlMcmPRExt+VWq35v2IXYd5DzGVCJqC6kYarN+sVF0W2JGj/chtMxrQVl77sFtmAiC
 7uwZ0nr26so42DnVpRB/rnIhbicSw8pNdl1+ZeCxf8QhuD2d+tfQrb8HsXRb8MHkd7QT
 bszIn303DWNazM1Oj8adZkIB+7TSzGUB72j1S/o4uud6EG3NQ7S1rtAyHkjNpnlHj+wi
 I55WRZcowDKPC7EAsqPOEnGUq223IceLJXYD3uET78DZWh5w9Dwiz5ks6Eqg0VKjNPUS
 sGnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxggqhAw1UBmPzTGAdFqOg/CRK/KGubznU4h6DSCP529Znqi9dodm9wBoaTisR2I05BaZ28OxCFeVzk@nongnu.org
X-Gm-Message-State: AFq9FYIdViHrK1e286Wjywlo4S3s0/mIjIVdtJQDj+g9uSPFLSysteQa
 XXq5fya7d65RvHI7PGQLeFyVxoPlTmJfrnbI3nKZo/eNdszt+AL1vLBFYpUKI2GVgwTboQlii/l
 Mv+eSJri9Uf0Ta0bw4R7ggjAFyDBQzlc=
X-Gm-Gg: AYBFou2P5tINLTaAahq4Z0EMyTODA/AaaMA1NT7xUMZ5LDvFWur/YJp/8hniCOH5SAe
 RtW/DS2Qst1j5jbNQGz1HdwURtFmVVibz8cBKGe90UsB227TiiFiYf5B7+NfScFULO8pCq/mkhw
 OjTQ8EIcwXFwEmMLn393vBYgcmjomnlJGmB+iuQZKa7G550muE99y7PW2+X/JVCdpkcZDOOjRXU
 I0/wptg7lkktcLpUW91mS/ww9Fc+qQQ8dTkwWpscRRo10eNwtm5I46mlQQRBZnfLyNlNDAyAUmK
 pN2Mj1aSuBKm1S9JRWK9pJPWEZeNNmiM7GvWUD5WaY7+Ma2O+/uXd8s=
X-Received: by 2002:a05:6402:1d54:b0:6ab:d416:d47b with SMTP id
 4fb4d7f45d1cf-6af9e2cb052mr2303517a12.5.1790958580626; Fri, 02 Oct 2026
 09:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
 <ar6a_uDw9OeLng6c@redhat.com>
 <6bf4dad5-4fa2-4df1-b6b8-d594dbd3842c@oss.qualcomm.com>
 <ar6lw3jAcnVej6vK@redhat.com>
 <557262df-b8e7-49b5-a245-ae46b8885b30@oss.qualcomm.com>
 <CAE2XoE8MriyEEeRF3uDwWgnJWPHBieK_-pD1+k0tUjROWjDpWg@mail.gmail.com>
 <ar_ZGHRkxZKWULPB@redhat.com>
In-Reply-To: <ar_ZGHRkxZKWULPB@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 3 Oct 2026 00:29:28 +0800
X-Gm-Features: AclHuK8dxj7VXLLeD9dENyptJCP5kHxHIum98wknbPqV1I2WuJ6gPFrM8jeb5V8
Message-ID: <CAE2XoE_LAu0xv5-By=6+pQd2HN7rYVXsL94z6RA1XctexeYh=w@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>, 
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Stafford Horne <shorne@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Song Gao <17746591750@163.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::28;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x28.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 3, 2026 at 12:17=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Oct 02, 2026 at 10:00:24AM +0800, Yonggang Luo wrote:
> > On Fri, Oct 2, 2026 at 2:56=E2=80=AFAM Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> > >
> > > On 10/1/2026 11:26 AM, Daniel P. Berrang=C3=A9 wrote:
> > > > On Thu, Oct 01, 2026 at 11:08:17AM -0700, Pierrick Bouvier wrote:
> > > >> On 10/1/2026 10:40 AM, Daniel P. Berrang=C3=A9 wrote:
> > > >>> Even with the current per-target binaries there are countless
> > > >>> devices linked in which are incompatible / not usable with
> > > >>> certain machine types. A new multi-target binary with a union
> > > >>> of all devices will just be a bigger example of a scenario that
> > > >>> already has to be dealt with for today's binaries.
> > > >>>
> > > >>> So if we have that assumption that we don't need to do device
> > > >>> filtering, at that point, a --target option doesn't have as
> > > >>> big of a role to play. The machine type code knows what target(s)
> > > >>> it wants (1 or 2 targets depending on if there are 32 + 64 bit
> > > >>> varaints. The CPU model the user requests (if the CPU is not
> > > >>> hardcoded by the machine), determines 32 bit vs 64 bit.
> > > >>>
> > > >>
> > > >> How can we deduce this information (bitness or target for existing
> > > >> machines/cpus)?
> > > >
> > > > It would require that we introduce a new field in MachineClass
> > > > that returned that information about what target a machine is
> > > > associated with.
> > > >
> > > > I note the SysEmuTarget covers both 32-bit and 64-bit variants.
> > > >
> > > > It might be better use QEMU_ARCH which correlates directly to
> > > > the TCG targets, rather than the traditional binary target
> > > > names ?
> > > >
> > > > Likely the CPU class would also want to declare its list of
> > > > supported targets.
> > > >
> > >
> > > QEMU_ARCH only represents base architectures, and not variant, so
> > > SysEmuTarget is the right choice.
> > >
> > > So, we would need a list of SysEmuTarget for every cpu/machine that i=
s
> > > target specific, since one could be available for variants of base ar=
ch?
> >
> > For this, adding TargetInfo parameter to is_avaible callback will let u=
s get the
> > list of SysEmuTarget for every cpu/machine. As we can iterate on all Ta=
rgetInfo
> > then check if that TargetInfo is present for every cpu/machine.
> > And indeed for devices if you want. That's what my patches are already =
done.
> >
> > And also I have an idea about the set is_avaiable in an easy way. As
> > QOM basically
> > is a TREE, so for example x86_32 and x86_64 can share a same "i386"
> > base, all children's
> > is_avaiable inherent from parents is_avaiable, we can ensure every QOM
> > object have a
> > is_avaiable by update children is_avaiable from parents one.
> >
> > >
> > > @Yonggang: can you try to provide a RFC based on this, to see what it
> > > could look like? No need to cover all machines/cpus, just select one =
of
> > > machine+cpu, ideally with multiple SysEmuTarget (like virt and max cp=
u
> > > for aarch64), and let's iterate from this.
> > >
> > > @Daniel: how do we deal with machines available for all targets like
> > > null? We would need a way to ensure all machines/cpus are tagged
> > > correctly, in an independent way from "available for all", without
> > > having to repeat all existing SysEmuTarget.
> > >
> > > >> Also, how to deal with devices that are only available for some ta=
rgets,
> > > >> but not others, depending on various Kconfig knobs?
> > > >
> > > > IMHO just leave devices to raise an error when passed to '-device'
> > > > if not compatible with the requested machine.
> > > >
> > > > eg this example from x86 world:
> > > >
> > > >   $ qemu-system-x86_64 -M microvm -device xen-disk
> > > >   qemu-system-x86_64: -device xen-disk: No 'xen-bus' bus found for =
device 'xen-disk'
> > > >
> > > >   $ qemu-system-x86_64 -M isapc -device virtio-net-pci
> > > >   qemu-system-x86_64: -device virtio-net-pci: No 'PCI' bus found fo=
r device 'virtio-net-pci'
> > > >
> > > > Hopefully most devices have sane error reporting when they
> > > > find a dependancy they have is not satisfied by the machine,
> > > > but if some end up asserting with crashes that's not a
> > > > blocker. Those asserts can be turned into pretty error
> > > > messages at our leisure by whomever cares about improving
> > > > error diagnosis.
> > > >
> > >
> > > Fine for me. I am a bit skeptical this will be possible to catch all
> > > issues, but let's try!
> > >
> > > So, for existing binary: -M virt works as before.
> > >
> > > For new multi binary:
> > > $ qemu-system -M virt:
> > > Multiple machines were found, select one among:
> > > - aarch64-virt
> > > - riscv64-virt
> >
> > This would be very hard, that means QOM must be initialized. but we nee=
d
> > ensure the target is selected before the QOM init.
>
> We don't need to have initialized anything. We just need a single
> global variable, whose default initializer is true vs false, for
> for the separate vs multi-target binaries. That's just a pair of
> .o files with a single bool variable, that we choose between when
> linking.

Use functions have a better property that it won't be modified when
running as it's not data.
And using "extern bool multi_target;" is also fine.

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

