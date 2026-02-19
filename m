Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123F0E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8WD-0005sk-NS; Thu, 19 Feb 2026 13:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vt8WC-0005sC-L3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:12:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1vt8W9-0003GN-L2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771524767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SFqHHdZ+40AqTiBEJKKrNPJWy5iXisoXEggwxCMUKeM=;
 b=FqQf0EkiycqNy5VxFdvFXnfx3rqZRLEvRGhmrO1i0HWvzn/z9+tc9XQ+4MFsgtfm6f724e
 kkfdO66exxu7nmIfJzhbjz4MWZ0usOKgfZtuQ7wEsNvo25s9rPPEFyLQMtjLw5GSk+rLf5
 qh/22isXbB6YfJaeW1HP52hLJxglHRc=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-fzePAq6TPGGqu6rXrEsRcw-1; Thu, 19 Feb 2026 13:12:46 -0500
X-MC-Unique: fzePAq6TPGGqu6rXrEsRcw-1
X-Mimecast-MFC-AGG-ID: fzePAq6TPGGqu6rXrEsRcw_1771524765
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-40ee3b0ca58so10294337fac.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 10:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771524765; cv=none;
 d=google.com; s=arc-20240605;
 b=UirkvveDDGCHMVWT4dyHFzjajcV4axrHS1WyS9EB/Wo2GkBcwB7vI16gOW7U2rG/DM
 qKkZUTfvFro+cm0pyBlWyKxxbDJPhJPa//kocMUJC6o3jsWrICiR7xmYo3E3LkWBBLzt
 euRUKBofhg/NwBCdd+UOorosJ4rT3dcvyxaCH9wpmMWj+4r+KENB53+Cr3tYH6DmPEPT
 xrjnuk/3FNG3SeMpel9BOCis4ypai8PkwogDhzZWm+sqEzmrPnUu0MW+fj2ijyyUOPTj
 vZnRFs/7LpY4zmTW9KPcxs26un3sSqvyv23b0MgjZAVWkjcfzUt2CsuH+cOSKy6RitWW
 OITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SFqHHdZ+40AqTiBEJKKrNPJWy5iXisoXEggwxCMUKeM=;
 fh=Y0ZyvydcxOPbaC4pimDZtDanVoBureR4Mclz7RjfapA=;
 b=cGJCfSoDwfHIJAloDVur2RULnRBrDnLKLgmRplhW17NX16DsTaoBcz1IEYReYYVei9
 9qIzGJoiCYny2hfnEPvL6tjY8Gw2X4YOFagREKpHNduRrg6a/wkXGsAws/S1/PbgDK2H
 WMZep6aGpG7+LLFzJt3FlZmS8V3MI8Yo+cdlEiWt4myvrmAI8EUq/T9MMk5wWtnFyy2g
 xPADMHcbLIlLoYnxdjvpQeit83CvMt+4cMpEkyxqwuXNkW8wBPTucVS4ZngzXKIPbs2F
 hPdyRPC+niiIxIHafFg3F+77A+vZNdoGU8rlNmL94HCu5WIYAH+TYh7n5NEKcMS1vcj4
 TZIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771524765; x=1772129565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFqHHdZ+40AqTiBEJKKrNPJWy5iXisoXEggwxCMUKeM=;
 b=FTY+Do0sa9bS9MUipJSgrNz1QjhGQ/ajKzaYbEuGXqXFItKy4R2R9B96n9rlSC51V5
 uJiK9br8bZJa/sKSUtKqMoYQ49I0s6aRIZt09OkIh3sqBpf36YM1Ft4YOeE8p6ICtlie
 D+vUNU5XM0YLRmhsFQUrJ0ch1/hR+KQUXNVQNwY7o5kMbrgnDuig3DW3xBa831jmSjVH
 Whpnh656wWlSPH0wbiQPtnssTmmedBN0GIUKnhokXJXaaplslP0XSlly5K2+xYHlmNxC
 gaMssirvY5Y3aUntRzez8cjaM0nXukeYidjpEDtv7SKgHd7s9750OHrsKUgRc/MWpjkY
 nNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771524765; x=1772129565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SFqHHdZ+40AqTiBEJKKrNPJWy5iXisoXEggwxCMUKeM=;
 b=TeeBb2+BjHV8Uccb9U3ZGhpnfwQ3rP8Svs3B/f3NIhclNkhLCkbG8gP/SzQ+QUCyHq
 YHBmR7vP92Zhydm6+4RdH4XT7D4FUANX0h/an8dqhYP2rRfleoAHx5bOlXCkeKObbyRf
 veZ+4KZvLS8ARimgu+hyoyjMJwjpotg8LATqiOwID02DpS0QZY4KbmLcrBY6V2daM6Vc
 LH70f7mT8FSfa+Vjdfqw0KF47ObhLGx83cKBOM2Kwuv4hNMth7fiwRZMg2e0CcExGCmw
 86fuDdPP+HaB+ogSth7VgMNvCdbG5uTy33x+V6p1XCP9vseH9X7Ky+gNuq0PC7I2S03J
 H5hg==
X-Gm-Message-State: AOJu0YxOywpfVSUv6P5FqrvUsOGYak/d56AQH98Nn6/nOJR2Wo3U2Uk2
 wnK9SJcmyn19t2CG6PHpRBmDXRL0D5hyH80ALTqBfkiRKl18M0F+L9HigXCWBaxgTEXdWCJGvs2
 iy03ymlXY4vSjzVpmmsdkAjM7jOcUG4FbVegrtKnpYTA5/Cnx73yWytTi63bMPymxf+zKOfURUx
 vnY8uagfjL7faUWMbPAMUlbh0KI6eJYIs=
X-Gm-Gg: AZuq6aJXOMr63/PILaGNkWYHy3AkZA6gJMXUB9L2Hh1hWpmQTALxXIYSet2W29Er3fu
 P8dNUHRUtjPPvbvMlT+n3F2fbu1aEeE9K/1F8nqUfULnRioX0rDj95NCToJTh4MLTwpzXUP48EB
 +X9CHvA/0FeudWEM2OnUwmIZSgbU2wBHRToD4uZlMTzrEyxueL//eFRBGk+fvQonGOxfMjNfT/f
 31vL/q26nBKVrWZA5TJv/fSwRYxtosUph+Qug==
X-Received: by 2002:a05:6820:1623:b0:662:fa38:ed4f with SMTP id
 006d021491bc7-67859a88085mr9561397eaf.23.1771524765494; 
 Thu, 19 Feb 2026 10:12:45 -0800 (PST)
X-Received: by 2002:a05:6820:1623:b0:662:fa38:ed4f with SMTP id
 006d021491bc7-67859a88085mr9561384eaf.23.1771524765082; Thu, 19 Feb 2026
 10:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20260211122759.125094-1-mbawa@redhat.com>
 <CAFEAcA_+eqfTy+7U9igTscue5SMURm3C9yUXvdFTon+ZgSJfAA@mail.gmail.com>
In-Reply-To: <CAFEAcA_+eqfTy+7U9igTscue5SMURm3C9yUXvdFTon+ZgSJfAA@mail.gmail.com>
From: Mohammadfaiz Bawa <mbawa@redhat.com>
Date: Thu, 19 Feb 2026 23:42:29 +0530
X-Gm-Features: AaiRm52G5dJSNFuqQIkAgCq8LBpmPNS1Cbs90FdPXda-2YLTX2bkbc_Yl0ex1Wg
Message-ID: <CAJg9KkwkT0CnnxwrmR4w422OY7ECMyGZFyQLO-Uj92wfSM9E=g@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org, 
 philmd@linaro.org, cohuck@redhat.com, eric.auger@redhat.com, 
 sebott@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Feb 19, 2026 at 12:32=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Wed, 11 Feb 2026 at 12:28, Mohammadfaiz Bawa <mbawa@redhat.com> wrote:
> >
> > Windows ARM64 guests detect virtio-mmio devices declared in ACPI
> > tables even when no backend is attached. This causes "Unknown
> > devices" (ACPI\LNRO0005) to appear in Device Manager.
> >
> > Until Windows fixes that by supporting, adding a new machine
> > property 'virtio-transports' to control the number of
> > virtio-mmio transports instantiated. The default remains
> > NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
> > Setting it to 0 allows users to disable virtio-mmio entirely.
> >
> > Usage: -machine virt,virtio-transports=3D0
> >
> > Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
>
> Applied to target-arm.next, thanks -- but please could you check
> up with the ACPI spec about whether it says anything about what
> to report for empty transports? If it says we should or if it's
> just vague we should probably match the x86 microvm behaviour
> of not showing empty transports, since they can never be
> hotplugged after startup. (This might need to be tied to
> a machine-version, not sure.) Maybe we should also not report
> them in the dtb?
>
> thanks
> -- PMM
>

[https://uefi.org/specs/ACPI/6.6/06_Device_Configuration.html#sta-device-st=
atus]

The ACPI 6.6 spec  (Section 6.3.7) doesn't explicitly forbid listing
empty devices, but without a _STA method OSPM assumes they are
present and functioning. A simple fix is to not list them at all,
matching x86 microvm's approach and applying the same filtering to both
ACPI and DTB.

Tying this to the machine-version is a good idea as it may be required for
backward compatibility.

Thanks,
Faiz


