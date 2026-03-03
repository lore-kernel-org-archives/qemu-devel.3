Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E8FEDA693
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSGI-0001qi-R5; Tue, 03 Mar 2026 11:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1vxSG8-0001oA-Ue
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:06:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lleonard@redhat.com>)
 id 1vxSG6-0001nG-VT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772553963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z71x+CDENzxlE8M1Y36YRGBpBi30v8SvKseYkMfbzEE=;
 b=J+WpwdDa1PWZdtTDXamHq+WduRP2s68HL+PDcGqGZ0VkLrotGcP9P+qKr2CA/Tanr1fU1Y
 6D0AQAXRi01Ns1+CSkXcO/rM/Q46+9i8W7o0d6GcJ5Mrq9J9wt8bSKNKf5It3LhwnvCDVj
 wiYPaHdj2HpH2s/Feh2vfALLrxE+wVE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-wWuX-NnIOv--oaYyHleakw-1; Tue, 03 Mar 2026 11:06:02 -0500
X-MC-Unique: wWuX-NnIOv--oaYyHleakw-1
X-Mimecast-MFC-AGG-ID: wWuX-NnIOv--oaYyHleakw_1772553962
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7986c067508so91468517b3.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772553961; cv=none;
 d=google.com; s=arc-20240605;
 b=M1ehlp59XyISkdFgx/l65AevbLBiyO9HSoj5w8zMoa/5jRwcGgiSuIBP53kfM7MepP
 KoiSXuoUoR9RU5B2ijpx0vlaQgFlBrXX+8N1++zo4ubJ0YvSNDPAWgqIaxsmAxky5Bei
 kva0Em9224Y0B3tzvUcYMdqM3DfG6TIas/omN6sGr6bg4SXsi0/o0TNS+9HzHEKV3cSI
 EaSlMUFtNAZE739LSFOGJMehh8GmNyW4UA3DIQ6MRDesqPqxOeJEB2h5ugV9Nc8TAq+C
 tqPrhmRyYcgBJcMFb5fhwGQiN5dy8QLndK731h9/8V/tjCxk7VWUMM/25XAg2H/bE+5m
 qBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=z71x+CDENzxlE8M1Y36YRGBpBi30v8SvKseYkMfbzEE=;
 fh=M+PQ/mPxrlNcwBcpzJhQbIZh5naQ1mTAie8kXWVAj2k=;
 b=B34RxWq1OLHazi3/Uc7+mOCDDUznr405qkv5AO+dgFyPVDKGbMc2br1HWvm9VQs6VM
 jDynbrDVT2ofZVsPrALdk8KXoWZ7YdFdRYnHf/DyQmHKAqjCaAqidyOGc4+yRf58Jwn8
 H3EiS/dyEmVFDJK9xUUpPHbNZp2Qp1nvyvof8eSscRHRNLsTHM4E0eRUw3px/v+5zpW7
 H0ND/IQiIlClc6BduP3CSVbv3NxGBDdfR/JkpcZG3UbGZ2eAS1EDdy1IuU9iQ3aip9tx
 GFnN9JHtJs8oxNVRiUkBJJv3mTNmdrJiylU7S8ydubBIJlBaNZdbdGmo2xVnjTOkuTwM
 962Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772553961; x=1773158761; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z71x+CDENzxlE8M1Y36YRGBpBi30v8SvKseYkMfbzEE=;
 b=JoUe8rWnfduzrsWrXl09yJEbvz/u/EXFabypUUM7ZVe1hpnahig345J/7EH+EYqSCQ
 2wSobsHOpJpRyTaXOjNjL0rIfviStlY6pKWe1IyEueE2LMQRXNxu5O38zDp//Y2WD4TQ
 oA41TqBOabDjaDz8zZCMqDGLF82nYYWVW3xgupM16OZlfOz1qWjMHp4+k4+pii40evtD
 /YtpXurqGzrgUoB0SutJ1jRq1jgUPPFdnSHRhFVHolXEYg0UTRYLh8QM0Pr9J8g9tsfU
 ltZp2jrFUx59qk2m/q/bJbOj+KE/LPx20zzZ/OVxrKPZGGiyMepmxFH4MukuxS0V5Wgm
 jAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772553961; x=1773158761;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z71x+CDENzxlE8M1Y36YRGBpBi30v8SvKseYkMfbzEE=;
 b=dpELoaq1sLQ8O2R9tcIs3pO0/qv81g+9cBItdvptNfUnyNd8Ahzy/FKbcyaZ5zke4T
 FZEpkCUtY6DwSXQhjpGICUG8eQ/luZOBvtiWm9o8ZdG1gezQCM9V4ypQQXyRN7MqUs+7
 +eCm6HNM5ZsT+oiu/wapt+oumSJnjXKG7c56hLEK3cQSEkqkQgf61HKKTdqNbYF0mQyJ
 LtdT6mUKB4UW+smFShFs0sQ2OSM2t+DDGhWQ6wDvlLKqEVP811TzHNQ88vKYpx1eoVZ2
 CSN0pP/Y/1kWf0t4//Dyt0RJFooSEURxxtixotSsRPMihefuI7mojfgaa5NdvZLZQ/cJ
 7HFA==
X-Gm-Message-State: AOJu0Yz4SBkX4ehJMgyTB/RfaUY1jOwttZwcg19CIEeyMC74T108Hslc
 p4NymqQ3vNLWltlnO1xtcRaWfdK3Kb+V/w6oHzjJ1augp9isDCPN1dbHu+x8dvSkT+zSx3yVAM5
 nhVI8m/KXSW/tq/S5p80kqveAd4k9tdX+Lns98UCvPCqjxs80KX7QDo44rsSuUoVr3g17AQe6wU
 GLxku1dtOtCfuIAwkHVuXXVjH359BQQmbF7+Afo8k=
X-Gm-Gg: ATEYQzyq5DnqaHzVTJNID1SFXO1GoAbY+POkh/MFVLha1ilXcQifJrzSt0VoRsi4d9W
 iq+gcR8QyS0IIwHxeEm1Q0Bp7Atv5QI25v3fmJ9y5CEfDRvtbbVlIK0os8h0DO7m7X3ajRPcW2X
 4yz4UdVNU9cwTtSA4Mi+AfUd6et+gR53cyIpy73E2fm+RTha1zYPjkm8idZb6Hore4FiFWy2qLv
 BvtPQY=
X-Received: by 2002:a05:690c:3587:b0:798:5a44:781a with SMTP id
 00721157ae682-798856080dbmr156553197b3.54.1772553961648; 
 Tue, 03 Mar 2026 08:06:01 -0800 (PST)
X-Received: by 2002:a05:690c:3587:b0:798:5a44:781a with SMTP id
 00721157ae682-798856080dbmr156552787b3.54.1772553961066; Tue, 03 Mar 2026
 08:06:01 -0800 (PST)
MIME-Version: 1.0
References: <CANo9s6=YV6Cyyn7m5LaGaD7U9i61OSZwMyiyLbmUk_xHO4s8vA@mail.gmail.com>
In-Reply-To: <CANo9s6=YV6Cyyn7m5LaGaD7U9i61OSZwMyiyLbmUk_xHO4s8vA@mail.gmail.com>
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 3 Mar 2026 17:05:49 +0100
X-Gm-Features: AaiRm531huwlUF6YkikQHTK-Ie2tTiqXEZJYt66iIaRQvSgEXdcAGJrZx0gYj3A
Message-ID: <CANo9s6m=2HzzM9uyr0-kG1e69hV_iMDXZ+0DCRsbzYF9zQ+Lvg@mail.gmail.com>
Subject: Re: Meson build fails with igvm enabled
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lleonard@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Tue, 3 Mar 2026 at 11:27, Luigi Leonardi <leonardi@redhat.com> wrote:
>
> Hi all,
>
> I found a problem when trying to build QEMU with igvm enabled:
> When igvm is not installed in a "canonical" path, the build system
> cannot find the library.
>
> To reproduce:
>
> build igvm (latest upstream, as there were some problems with pkg-config).
> PREFIX=$HOME/igvminst make -f igvm_c/Makefile install
>
> This would result in igvm being installed in $HOME/igvminst
>
> Then build QEMU
> PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$HOME/igvminst/lib64/pkgconfig/"
> ./configure --target-list=x86_64-softmmu --enable-igvm
>
> ninja -C build
>
> This fails with the following error:
>
> In file included from ../stubs/igvm.c:15:
> /root/qemu/include/system/igvm-internal.h:19:10: fatal error:
> igvm/igvm.h: No such file or directory
>    19 | #include <igvm/igvm.h>
>       |          ^~~~~~~~~~~~~
>
> IIUC the problem is that the stubs/igvm.c file uses the igvm header
> via the "igvm-internal.h", but the library is not added as a
> dependency in the meson config file.
>
> I tried this change to meson, but it doesn't seem to work.
>
> Not sure how to fix this.
>
> Thanks,
> Luigi
>

I found a possible solution:
stubs/igvm.c doesn't really require the igvm library. It just needs
the `QIgvm` structure.
Therefore we can just use a forward declaration.

I will soon send a patch.

Luigi


