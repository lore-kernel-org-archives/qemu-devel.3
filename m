Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6408CE9A778
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:15:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50ek-0001T7-30; Tue, 24 Mar 2026 08:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w50ee-0001Sd-9N
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:14:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w50ec-0005sS-QD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774354477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6a77FYSkLHfh4LMVPybUiWBxSD+h3hygicTWQO9dato=;
 b=QUrRykeAmtvYu7RnNx1qONqNWkcVB/EhSvNAvUwZfBsQnQqe3FuzIQ8O6knfxGsvEm4GSN
 bFLN4dkNoIgQuSSNxP1QY4gu9wImPQOagJ5xPUCun8LGGaV+2jfOlArwYhg3dlGyViJ+3L
 KD429J6POKs8yh+C2lfiZSj7UknclR0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-UYAAwSZaP1mh0OOzaum4fg-1; Tue, 24 Mar 2026 08:14:35 -0400
X-MC-Unique: UYAAwSZaP1mh0OOzaum4fg-1
X-Mimecast-MFC-AGG-ID: UYAAwSZaP1mh0OOzaum4fg_1774354475
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b7ec737c1so1205185f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 05:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774354474; cv=none;
 d=google.com; s=arc-20240605;
 b=CMEQ2s02Jykj6e+xNwBCp7z3h6aYtDZBtOOZvc6fOAfXwUzSAe714Ja3VgeZgpjvkT
 7ezX/gSCJAWgXyjHYqV0dnm3j9aPpVhFunE7e5LosIT60sW4TH4Ag9TbhpZWoWvYqNSu
 QL1iSLni+dj9EGEm7+gTl4AiyChHUzgbdcTs8QrrGUZW0pVBkljkPPCQ+DZ8gra8NiGO
 oCoTc1Gy21x9SfBkNamXjSBmDEXUKzLrbOkumVfXlPxIuW6aX5IZFfL2e0V7+DlWzt2s
 ZpEZbrtTxABQ1/J1E54UL8FHsxRzCiJTOe480UMOuww4gMg0PoovJKgYMAp+B1gj+ttt
 H4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6a77FYSkLHfh4LMVPybUiWBxSD+h3hygicTWQO9dato=;
 fh=DEKJBWYHReeN9dOuWkZV2UHSlbxzJ3VUam5yYLUPFAc=;
 b=j3NJSBUtc8cgvmCtsaRPVOHRocehixw8F7qUw0EO8KuOcSTmRS/BXk39FU+tbyV/wN
 DSCcc7esmE7Cbf6zu1Q9RxfzphGRbQ+O+VoZagUiOwpI05AYwKkLg5CiM9+VOAoIlnOH
 8w4Lcmu5gFZD41IErgUENsARLFprfXe+pd26tO2x6ACIAZvtqO9Gpq/xCij7pbyOHFYL
 aIcSogR2ONN/xtEh3NgUTh0kguE4VokAXhe/kBw1+ovaoSCkHv4efu7E8QzPpxIcZ1U7
 WSYrEsY4jSn4d/GqZG/IfNelZ3+2yC6GR8tWYhYwUaCqh0VHt97XL7//FuFYrm31fSZn
 +ZZA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774354474; x=1774959274; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6a77FYSkLHfh4LMVPybUiWBxSD+h3hygicTWQO9dato=;
 b=ViEJMxNyR5LsPBXr6aOEA2Hp6aBe0C1xYnVL9ub9J7nrCytIOeIBR10nmkxNN/013e
 RJD1p5EUPX5QUU4tJBd7wPt/165vNygqjlFYLQbmJTbkv28oNaply1SomN4FBKzUaL/J
 vHYgpNJwiLWcfPSk3cmjKaSZCEEiqJQP4o3eaP+OeB/dZ7leS+hY5T1/ZkFjiNnWLj3D
 KDLoBbOIpPhRsFQ6hRnhDfGUAiOlG40iPncFYPIuEXl/ruhDEvx8TdTBqYlgFQ0QathQ
 toxAOP4SoUyuU3XV9wbiHjxKovIik0MsOedeB4tr92bjUf/mrHww9Od3O3Ijf4+ytgH3
 tLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774354474; x=1774959274;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6a77FYSkLHfh4LMVPybUiWBxSD+h3hygicTWQO9dato=;
 b=itkSuOKLO26Hd5pvOKFyAlTaXEc0BwagBaZb3SxrwPbWlZrwTsSwsn7rJBHTe/9xna
 vD/eKUsqzgQhbw0yob+zgHzr5D5xaPRMGURy9Z3pRGS4uV9MBJ+WhRE/5RNjYwJDumB9
 0bc00Iv5d3SJF7+X2npXgEOa66qAqxVU3AR6MERRNFv6pwJCO02vEu/fv5knlqY6FC4T
 TEt6axrN67Y0PeqX4wSbsR8skrGun/8JpEoqbqK9mEBf5k2IYYN4bkPciIzyB9XJlOb0
 vfdyQhnw1pqaCQHxQAgrRrJIQTkhK/mcwtjWpLuFAmZVYEKKhMBQBIWrFTufuq5GW/W6
 nTLA==
X-Gm-Message-State: AOJu0Yx/0qwdneUL3BzsDPDYz5nQ52ZeWBoGaijb45NsjchKcOs+1cZQ
 kC7bkJ6+xCKASwOHdJHDjo8IL0/6DL+05wOeSrzwshNgT3YCfYhg0Y0guehdDjuug5IutTPGraG
 X6T/6G4tO9Yrd/x8ox4nWSRJLXhA+SsnFboKpq5AJrIh+n1HzB7Qmwb+DJYiD2T5Vk3iv0OAY29
 hYTxITUBli2q67/6KofgkN+4nNFaKvvlc=
X-Gm-Gg: ATEYQzyRq6cax8aZyb9PEBxpfCK0TQ8cjVsRS388YgXhNkqpjV9Miy/k/7Ta1kpi6c2
 Nz78u3gVick28glljwlI5ZRvL2caIsdH8m4jQElfJNsUlXlllKgd8QDjCL/qxZmXGkajHs2xEDF
 IAIYudAhtNsEg92uP4LKYkXvO0gCofSsg0DQigh36NmVnVPHDZzVCu+WJEE2Z5IYnSmvr6rIOUJ
 2D/HIxz0MuM1TZPkApZos7PQM0pIADJoNvDc+/5/ewuTDqILBpHD4s2D3Ewj9z7Um4CXDBOc76a
 kCZL
X-Received: by 2002:a05:6000:1446:b0:439:af96:29e4 with SMTP id
 ffacd0b85a97d-43b64291a36mr24748674f8f.54.1774354474371; 
 Tue, 24 Mar 2026 05:14:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1446:b0:439:af96:29e4 with SMTP id
 ffacd0b85a97d-43b64291a36mr24748599f8f.54.1774354473785; Tue, 24 Mar 2026
 05:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-17-pbonzini@redhat.com>
 <acJ_qqzYMKqvrShH@redhat.com>
In-Reply-To: <acJ_qqzYMKqvrShH@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 24 Mar 2026 13:14:21 +0100
X-Gm-Features: AQROBzALflLIjoD0RcUPQrxKmQdQNdljG4JEvsgLJpLahmYab83YX0hNqQokKQ8
Message-ID: <CABgObfbsicXGvZaZrr1nOCSfrNAqZBJp2VEoa8ovYbD0DGfy8Q@mail.gmail.com>
Subject: Re: [PULL 16/41] hw/i386: Remove linuxboot.bin
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 24, 2026 at 1:12=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Feb 12, 2026 at 03:42:18PM +0100, Paolo Bonzini wrote:
> > From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
> > All machines now use the linuxboot_dma.bin binary, so it's safe to
> > remove the non-DMA version (linuxboot.bin).
> >
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Link: https://lore.kernel.org/r/20260108033051.777361-16-zhao1.liu@inte=
l.com
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/i386/pc.c                  |   3 +-
> >  pc-bios/meson.build           |   1 -
> >  pc-bios/optionrom/Makefile    |   2 +-
> >  pc-bios/optionrom/linuxboot.S | 195 ----------------------------------
> >  4 files changed, 2 insertions(+), 199 deletions(-)
> >  delete mode 100644 pc-bios/optionrom/linuxboot.S
>
> The pre-built  pc-bios/linuxboot_dma.bin  still exists in the tree,
> shouldn't that have been deleted too ?

I think you mean pc-bios/linuxboot.bin - yeah, that one should go as well.

Paolo


