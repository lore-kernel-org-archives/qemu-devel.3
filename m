Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12F6EF99F5
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5yJ-0000qo-Qx; Fri, 13 Feb 2026 22:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vr5yC-0000ok-C8
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:05:20 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vr5yA-0000Zi-Pe
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:05:20 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8fb6ad3243so160164766b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 19:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771038317; cv=none;
 d=google.com; s=arc-20240605;
 b=afUchyZQguBzPaw0+lnNln5T4dE2QhVRf5dlDWvzKgGOiCFpg2/qwP0suimzPO204L
 0vGPHcyK9UnF8Kjf41jCpIa+tA4RnMxOV9XDZssw19CQGordJrCuxnFAZocU4C2vFO0r
 BgaonKdCr/II+aiPHycDPyC8hl4IRBhTpBLPQ6ufFCbWFjtDKZvoflbBHChSfiQQIXzv
 HISejEkhrD6uQqLMddFpODBDn6ilXuHGMT8jmoFxj8HsnxlV7UqJh2/p42tR0axiLVkw
 vp92NB0wT+jdC/2dK7eVKspUYvx3zwjdqv+rz+HesNXJJ/c0eHQpF0S/Q1DE1F5ESdJQ
 baJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nm3jJS4jUsvrJJdfrBT2BEWd/9Ktwe/piMl9eJajs8M=;
 fh=jStUEheBxcMHYHSMDqpFm4kZ8DSIxwhDW4jCHn7dUzk=;
 b=fqYhDZUAaE6iqQKn69oamhawfpZAJtB8ISeVQ/EN+7Ulv2h0+ow9Q+r7yi+CLDFu0A
 bh4XztqvQP8opj/ZQQ9U7+eRaEXNyfD5lt6L56ySOb+2puk+FqmgPXCUTZOF0XO2OmTr
 IBZMAIU4bskshmw66udxyHZXD+WSm09+qMX2IgpVkJ+g8+zJW8xGFNISpqE1DEcpj1/n
 agVUmabdS+tMaDg7gqvkETrIXogXOBPGvbdfsGeCOh0cPQdg/RUfj096eTmXkTyL7lxB
 g0WHt0mZs9UA0z9hJ2L3amPhaYzRg81oMkssqgNHVesJWl1+HlCJl7lNpcxMrMGRSUB9
 FfaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771038317; x=1771643117; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nm3jJS4jUsvrJJdfrBT2BEWd/9Ktwe/piMl9eJajs8M=;
 b=aX0dqAlidvhMS0uQMKlz3gFgnf7WT5h2W/Wdk8Hs+ir+syEcR1dugdY6H0O9ZJOGnC
 +M1mD2XLunYDdKWzrJS25FSXY+H7OXsgNFtl9KHbNXtTSVUXTMsJmlzS0AIOwo/8l2RG
 zqPhHIW/ftNjG35n9fgtLc2HagQ4F9u8m1sI2Uo8XM5yx8FziT2/hjGOKnra1XXLOOaB
 KrG+iGIebk22vW6J73PtOLyPZEtBES5dthk/l7Zkj1uOdbbwcZgJz+1dUmlpKf5zmAKz
 cIP2gJ3BwT5MlAYtJ2UQ8ljQSaG6AFGdGZ2ibpFDi0ivyNSPsvTJnCuCnhdnuJhwvbKP
 ScFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771038317; x=1771643117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nm3jJS4jUsvrJJdfrBT2BEWd/9Ktwe/piMl9eJajs8M=;
 b=uU+aLb9cES61LDl3IeWLNz4ygtx7wC4xDMziHhKiY7HHJv3gRRIRrwhFIgAF2vMXlV
 vR9F/Z/SmWMkIlC1WmE3baBikgelNBHo9DxdX09q8x2tHgdHAZImr+qUNz8dRhJCPkqK
 iW9vgOqGIVArsnXOrlpvHQY+OngleQ92Jzo6F/vOWjDsKADGvlU5FkMr9JgdgKFVpTna
 wC6x75PPokO9f6+BrsxOjhaAO/4W6oLs1EQfrS/giBEUaLpqPajm6oFMgZ6de++pP6D+
 cQMhCbWrTozKmBDlJObSyKXHU+RKlUwFdH4E3W5S+iHTdivWWjBm7D7dyHpwKhWQAAjF
 Rh7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQBVQ/wK4ezWxBp+GHFBxHB3XfQelmz79fdD/mIeOtjVe/5KYVeiMx/haDrQj5inVYcSclbXWXoaDG@nongnu.org
X-Gm-Message-State: AOJu0Yyc8T5QPwM5G+KilUdvf3D3PXGgijGL1fK+kHPyaCteInQQmmwu
 G5ZfS5/2Re95C3kLDcXE4jtTgWod2vUj48bc6REx+HbwcdEZqSxreqbUSEbI6E13+mtuovZZFWg
 F7Cg+cf2x/HQxAc5as7IuiYa2M/+3PFI=
X-Gm-Gg: AZuq6aJaTAkDo1a4RDHuCW8dVK5mbaDZ+93QDYVAyVqIkC3F3hDUOoWt91MRvZfL4ja
 X22GTuWsRu1CClXBzSEP5AD118ftt0YD/MNVvSZeODBAEl1J9dWCHOYKmy48fT1s4mR/8zwXj5Z
 ybkbsn12VmTUv9EuoTyzfsDqlGzyFpCYxCuXfo3hm4RmApTamq16yt1lq0pHj2pdeKNd3eluU++
 wQFziDMiHhQJOPDgvYvwgjsYXSB55r0DHd6hbPwPqpJEYzP8OXsIcRltN5QluCpM6wFxD9nOOA8
 Pggw7o2Z
X-Received: by 2002:a17:907:6eab:b0:b8e:796a:fd5c with SMTP id
 a640c23a62f3a-b8fb438cbf2mr229072366b.27.1771038316438; Fri, 13 Feb 2026
 19:05:16 -0800 (PST)
MIME-Version: 1.0
References: <20260213071042.3733239-1-lulu@redhat.com>
In-Reply-To: <20260213071042.3733239-1-lulu@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sat, 14 Feb 2026 11:04:40 +0800
X-Gm-Features: AZwV_Qj8bJHoKQLqLh7_g3iKKwZukGyeGGV0J1QmQfISGrp076cqKnKw3sSoqxw
Message-ID: <CAK3tnvLBSB=sKKwjMai5Pw_AGq8sLzuaQkEoonJ-AaHgn3EwVw@mail.gmail.com>
Subject: Re: [RFC 0/5] net/filter-redirector: Add AF_PACKET support for
 vhost-net
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, lizhijian@fujitsu.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x635.google.com
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

On Fri, Feb 13, 2026 at 3:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> This series extends filter-redirector to support vhost-net backends by
> introducing AF_PACKET based packet capture and injection.
>

Very happy to see this series~

> TODO
> =3D=3D=3D=3D=3D=3D=3D=3D
> This series introduces basic support for filter-redirector, enabling
> simple mirroring of VM1's ingress traffic to VM2's mirror port.
> Additional functionality including filter_buffer and other filter feature=
s
> will be added in following versions.
>
> Example Usage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Primary VM (mirror incoming packets to secondary via chardev socket):
>
>   -netdev tap,id=3Dnet0,vhost=3Don,...
>   -chardev socket,id=3Dmirror0,host=3D...,port=3D...,server=3Don,wait=3Do=
ff
>   -object filter-redirector,id=3Dvm1redir,netdev=3Dnet0,in_netdev=3Dnet0,=
outdev=3Dmirror0
>
> Secondary VM (receive mirrored packets):
>
>   -chardev socket,id=3Dred0,host=3D...,port=3D...,reconnect-ms=3D1000
>   -object filter-redirector,id=3Dvm2redir,netdev=3Dnet0,indev=3Dred0,out_=
netdev=3Dnet0

Whether the receive side need the same setup the  "-netdev
tap,id=3Dnet0,vhost=3Don" or not?

Thanks
Chen

>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> - Tested with vhost=3Don/off TAP netdev on x86_64
>
> Cindy Lu (5):
>   net/filter: Allow redirector on vhost backends
>   net/filter-redirector: add in/out_netdev properties
>   net/filter-redirector: Add AF_PACKET sockets initialization
>   net/filter-redirector: add AF_PACKET redirect datapath
>   qapi: add in/out_netdev to filter-redirector
>
>  net/filter-mirror.c | 460 +++++++++++++++++++++++++++++++++++++++++---
>  net/filter.c        |   6 +-
>  qapi/qom.json       |  19 +-
>  3 files changed, 459 insertions(+), 26 deletions(-)
>
> --
> 2.52.0
>

