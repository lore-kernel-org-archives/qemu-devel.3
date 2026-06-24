Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E5ECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 04:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFXR-00026r-Fz; Wed, 24 Jun 2026 00:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wcFXB-00021M-3K
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 00:48:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wcFX7-0002jX-EF
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 00:48:20 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-695f6438518so793687a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 21:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782276494; cv=none;
 d=google.com; s=arc-20240605;
 b=ItIsz9lNK9WYUYkU2LXgfpciU/5UuvoQL0PVsi2393Nl+w1ipf/Ojug2ePttPqtaVA
 XARSZnNYiEpVmWHqLUGTygbSS56XQEZ/1VSGQcuQ7+7lV2v2zKcN+rNtiKiHln/nGYMS
 SHPo+ZDmNf14AiaDtu5olfhD8pKSXTri+27k/WXXxzwRE1nmFILUGfU+vh6WdKGZ2D5J
 sWjYn7bmbyM1L4CaOaCYq3z5pFGrZp7Ym90JTZ5kDoEDSihElMOmPFCi84LPQlv/nYLT
 doVlZy6a/tNe7e70ZoUgjbS+x2G4Z4C6ga9jglJDMcbzDzNg7gWKBe7o3i7OYsHo9gSE
 ycKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ulod9j/kl+a9a3bALy47ILj6L+//WITgl4TnR77+1r4=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=gQp5cm9Np+H40QEyJM+alP3+KoRTr/NKeByibUTwWTXTYhrp3x8k2ufwddKpA/9R0s
 3zkIwid8mtGs7xRr73gqw88LfmcfCZ3SPc4UISbOw+bxrIPHcDnrGbUteFxpOQ3LgT9s
 X/hp0roUmSsJJ/7lQ1zABHt+e/mGQ3TTR6HUlkCLaRhXSlJFprmT3o0zsk1SmO7uiIet
 GRNGe43yRYb+98/kRxdUj93KWSuLPCEqY7N/far6ptYAQi3hel17pygkGBzk4R+Yqt5L
 PtRzUs8ZN5tCOFG4+a08fTgtiGBZSWVGU2cTTi684IxursuI+Q0RonIYTxsjUQqvX5/z
 OuVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782276494; x=1782881294; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ulod9j/kl+a9a3bALy47ILj6L+//WITgl4TnR77+1r4=;
 b=mEGdM3bz6Cgzaf4uJ7zeWUKmqfyAiGN8DndMtzPJdD5z8jbkxH8/puGOmquzgbDMWp
 tn4HWvbJn5p8MQappYzBew6pygj+7Iw+JlRax28AStIDlep/6z8CUvJiQcmBm9KSxGcb
 dIQq6/Vg2NXgx/KieTixfxwCfedFdPBQaLj19VSl9tG3hiMVI/Ei7vWeuTBO5wP4LEf8
 UZsWIy+cksFxCn5CsRrmq2/7vm0hO66lDeK+pMShhfXNlQ6ClYqpNHs6y6u/Fpu6c3cm
 z6Q6Z55MD3xlLZa4WPilfaZlw5asFKX5X2uSL8MZ+iG7ER1ZMHSQ+OmYiR3WRVbMHurg
 TYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782276494; x=1782881294;
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ulod9j/kl+a9a3bALy47ILj6L+//WITgl4TnR77+1r4=;
 b=Y2iXVhQ//MCVmeNY3vPnwtLz+mDcpdLsKh0ongUrHJo+bMGw7Y4sweIa/JPxmjPaLR
 WNaRTuf0ciMP8dODVyoq9w3i4hIhiP5a30J4MV/DerXY5BTVH2TPOuVfc2E8GFdHkC4w
 2uH7qaDoUXxJ958jv39ObbNre3KZeWhTD4LpaUs4meR5rPAZ2rRRop9/U1bUI4CIC3cZ
 8pl9PVZAoDOlQi3vZb7tOnPOs5J/mBQKGPLPMY8pSRonu5JNtzDGDqyN5yvfDW9aGtnF
 LuygaE4X4EgaSgoeQTFjTz6jxwtSbc64lqec6I8AMhefUO3tZOwVNYt4e+B7Dg2JI/Ll
 feFw==
X-Gm-Message-State: AOJu0YyZiMt+XkPLx6kUgm+8YV8+Jql2pPYPVk18QsxpVUGckFPWiQIC
 4IXpbM/waaXI2hmbbEzR+P+bn4zNpBBFo7sVbgDb6EwhPi8pIteYWw5OYa0OKWJo1ZBKqisjUEj
 4vluJg9HKBqv1ifSX6/mxjpbVqeH223uboQCuG3A=
X-Gm-Gg: AfdE7cnZM6ytcizJzpvJmGrZJAjeBlUF3DCuRA/Mn33kHgFW6wu5BTcTSphijxLouZX
 VenVK1Ids1yxkMpB75OmYRby3STl3fdkZfRCuIEnaUhDa/whbR5sVMcAnoTj2QIBhzIY3Dc+ZMf
 +wtTYhyGD/cCgu5p/1Ybz4Mh1pFpBuJeNuAQCfNLrzwBlw+0qMwktl28+pdV6nygk8wlL3n89R2
 6zRX74EWlzEDA74+wcqpHVL9khahctzmEGNYCfqP85Ebdz6l60oXatEaaG+IYZNaU2wCio1UJsX
 Hnd9J6I=
X-Received: by 2002:a05:6402:2712:b0:697:5efa:ef21 with SMTP id
 4fb4d7f45d1cf-697f3872bbfmr639198a12.9.1782276494026; Tue, 23 Jun 2026
 21:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260622113152.1710585-1-berrange@redhat.com>
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 24 Jun 2026 12:48:01 +0800
X-Gm-Features: AVVi8CdSaQAcYn-Y8iNqL2Rsw2PAhWhBL4kuxLT7k8DxP39FWxb7KwcqQoz0xck
Message-ID: <CAE2XoE83E0Kz0MJ_6nKFv8CHVMBDzQ_nZK4=XB-NWsYgJcZqbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000516c550654f89577"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000516c550654f89577
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:32=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:
>
> When triaging GitLab issues, whether regular bugs or security
> disclosures, we need to be able to assign suitable accounts.
>
> We can only assign Git Lab handles for accounts that are members
> of the QEMU group, or QEMU repository with the "Reporter" role
> or higher.
>
> Currently one needs to run 'get_maintainer.pl -f <file>' to get
> the maintainer / reviewer names & emails, and then look in the
> GitLab members page to see if there is a match.
>
> This simplifies that by adding a "--gitlab" option to the
> get_maintainer.pl script that will report the GitLab handle
> for maintainers / reviewers too.
>
> MAINTAINERS is then updated with all known accounts.
>
> Ignoring bot accounts, there are the following GitLab accounts
> for people whom are not in MAINTAINERS as a Reviewer/Maintainer:
>
>     Aihua Liang (aliang1)
>     Anthony Roberts (anthony-linaro)
>     Bastian Koppelmann (kbastian-qemu)
>     Eduardo Habkost (ehabkost)
>     Eldon (eldondev)
>     Emilio Cota (cota_)
>     Jim MacArthur (jmacarthur)
>     Joaquin de Andres (xcancerberox)
>     Juan Quintela (juan.quintela)
>     Paul Zimmerman (pauldzim)
>     Peter Krempa (pipo.sk)
>     Peter Krempa (work) (pkrempa)
>
> Much more significantly, there are the following people present
> in MAINTAINERS, whom are not members of the GitLab project:
>
>     Aditya Gupta <adityag-#-linux-#-ibm-#-com>
>     Akihiko Odaki <odaki-#-rsg-#-ci-#-i-#-u-tokyo-#-ac-#-jp>
>     Albert Esteve <aesteve-#-redhat-#-com>
>     Alberto Garcia <berto-#-igalia-#-com>
>     Alejandro Jimenez <alejandro-#-j-#-jimenez-#-oracle-#-com>
>     Aleksandar Rikalo <arikalo-#-gmail-#-com>
>     Alessandro Di Federico <ale-#-rev-#-ng>
>     Alexandre Iooss <erdnaxe-#-crans-#-org>
>     Alexandre Ratchov <alex-#-caoua-#-org>
>     Alexey Kardashevskiy <aik-#-ozlabs-#-ru>
>     Amit Shah <amit-#-kernel-#-org>
>     Andrew Jeffery <andrew-#-codeconstruct-#-com-#-au>
>     Anthony PERARD <anthony-#-xenproject-#-org>
>     Anton Johansson <anjo-#-rev-#-ng>
>     Antony Pavlov <antonynpavlov-#-gmail-#-com>
>     Ari Sundholm <ari-#-tuxera-#-com>
>     Artyom Tarasenko <atar4qemu-#-gmail-#-com>
>     Aurelien Jarno <aurelien-#-aurel32-#-net>
>     BALATON Zoltan <balaton-#-eik-#-bme-#-hu>
>     Ben Chaney <bchaney-#-akamai-#-com>
>     Bernhard Beschow <shentey-#-gmail-#-com>
>     Bibo Mao <maobibo-#-loongson-#-cn>
>     Brad Smith <brad-#-comstyle-#-com>
>     Canokeys.org <contact-#-canokeys-#-org>
>     Chao Liu <chao-#-liu-#-zevorn-#-gmail-#-com>
>     Chinmay Rath <rathc-#-linux-#-ibm-#-com>
>     Christoph Muellner <christoph-#-muellner-#-vrull-#-eu>
>     Cl=C3=A9ment Chigot <chigot-#-adacore-#-com>
>     Cl=C3=A9ment Mathieu--Drif <clement-#-mathieu--drif-#-bull-#-com>
>     Collin Walling <walling-#-linux-#-ibm-#-com>
>     Corey Minyard <cminyard-#-mvista-#-com>
>     Denis V. Lunev <den-#-openvz-#-org>
>     Dmitry Fleytman <dmitry-#-fleytman-#-gmail-#-com>
>     Dmitry Osipenko <dmitry-#-osipenko-#-collabora-#-com>
>     Dorjoy Chowdhury <dorjoychy111-#-gmail-#-com>
>     Doru Bl=C3=A2nzeanu <dblanzeanu-#-linux-#-microsoft-#-com>
>     Edgar E. Iglesias <edgar-#-iglesias-#-gmail-#-com>
>     Elena Ufimtseva <elena-#-ufimtseva-#-oracle-#-com>
>     Eric Auger <eric-#-auger-#-redhat-#-com>
>     Eric Farman <farman-#-linux-#-ibm-#-com>
>     Eugenio P=C3=A9rez <eperezma-#-redhat-#-com>
>     Farhan Ali <alifm-#-linux-#-ibm-#-com>
>     Felipe Balbi <balbi-#-kernel-#-org>
>     Francisco Iglesias <francisco-#-iglesias-#-amd-#-com>
>     Frederic Konrad <konrad-#-frederic-#-yahoo-#-fr>
>     Gaurav Sharma <gaurav-#-sharma_7-#-nxp-#-com>
>     Gautam Gala <ggala-#-linux-#-ibm-#-com>
>     Gautam Menghani <gautam-#-linux-#-ibm-#-com>
>     Giuseppe Lettieri <g-#-lettieri-#-iet-#-unipi-#-it>
>     Glenn Miles <milesg-#-linux-#-ibm-#-com>
>     Gonglei <arei-#-gonglei-#-huawei-#-com>
>     Haixu Cui <quic_haixcui-#-quicinc-#-com>
>     Halil Pasic <pasic-#-linux-#-ibm-#-com>
>     Hao Wu <wuhaotsh-#-google-#-com>
>     Hari Bathini <hbathini-#-linux-#-ibm-#-com>
>     Hendrik Brueckner <brueckner-#-linux-#-ibm-#-com>
>     Herv=C3=A9 Poussineau <hpoussin-#-reactos-#-org>
>     Hongren (Zenithal) Zheng <i-#-zenithal-#-me>
>     Huacai Chen <chenhuacai-#-kernel-#-org>
>     Hyman Huang <infra-#-ai-#-cloud-#-bitdeer-#-com>
>     Ilya Dryomov <idryomov-#-gmail-#-com>
>     Ilya Leoshkevich <iii-#-linux-#-ibm-#-com>
>     Ilya Maximets <i-#-maximets-#-ovn-#-org>
>     Jagannathan Raman <jag-#-raman-#-oracle-#-com>
>     Jamin Lin <jamin_lin-#-aspeedtech-#-com>
>     Jan Kiszka <jan-#-kiszka-#-web-#-de>
>     Jared Rossi <jrossi-#-linux-#-ibm-#-com>
>     Jason Herne <jjherne-#-linux-#-ibm-#-com>
>     Jean-Christophe Dubois <jcd-#-tribudubois-#-net>
>     Jesper Devantier <foss-#-defmacro-#-it>
>     Jeuk Kim <jeuk20-#-kim-#-samsung-#-com>
>     Jiaxun Yang <jiaxun-#-yang-#-flygoat-#-com>
>     Jiri Pirko <jiri-#-resnulli-#-us>
>     Jiri Slaby <jslaby-#-suse-#-cz>
>     Joe Komlodi <komlodi-#-google-#-com>
>     Joel Stanley <joel-#-jms-#-id-#-au>
>     John Levon <john-#-levon-#-nutanix-#-com>
>     Jonathan Cameron <jic23-#-kernel-#-org>
>     Kane Chen <kane_chen-#-aspeedtech-#-com>
>     Kashyap Chamarthy <kchamart-#-redhat-#-com>
>     Keith Busch <kbusch-#-kernel-#-org>
>     Kohei Tokunaga <ktokunaga-#-mail-#-gmail-#-com>
>     Kuan-Wei Chiu <visitorckw-#-gmail-#-com>
>     Kyle Evans <kevans-#-freebsd-#-org>
>     LIU Zhiwei <zhiwei_liu-#-linux-#-alibaba-#-com>
>     Leif Lindholm <leif-#-lindholm-#-oss-#-qualcomm-#-com>
>     Li Zhijian <lizhijian-#-fujitsu-#-com>
>     Li-Wen Hsu <lwhsu-#-freebsd-#-org>
>     Liu Zhiwei <zhiwei_liu-#-linux-#-alibaba-#-com>
>     Luc Michel <luc-#-lmichel-#-fr>
>     Lukas Straub <lukasstraub2-#-web-#-de>
>     Maciej S. Szmigiero <maciej-#-szmigiero-#-oracle-#-com>
>     Mads Ynddal <mads-#-ynddal-#-dk>
>     Magnus Kulke <magnuskulke-#-linux-#-microsoft-#-com>
>     Maksim Davydov <davydov-max-#-yandex-team-#-ru>
>     Marcelo Tosatti <mtosatti-#-redhat-#-com>
>     Mark Kanda <mark-#-kanda-#-oracle-#-com>
>     Markus Armbruster <armbru-#-redhat-#-com>
>     Mathieu Poirier <mathieu-#-poirier-#-linaro-#-org>
>     Matthew Rosato <mjrosato-#-linux-#-ibm-#-com>
>     Mauro Carvalho Chehab <mchehab+huawei-#-kernel-#-org>
>     Max Filippov <jcmvbkbc-#-gmail-#-com>
>     Michael Rolnik <mrolnik-#-gmail-#-com>
>     Milan Zamazal <mzamazal-#-redhat-#-com>
>     Nabih Estefan <nabihestefan-#-google-#-com>
>     Niek Linnenbank <nieklinnenbank-#-gmail-#-com>
>     Ninad Palsule <ninad-#-linux-#-ibm-#-com>
>     Palmer Dabbelt <palmer-#-dabbelt-#-com>
>     Patrick Leis <venture-#-google-#-com>
>     Paul Durrant <paul-#-xen-#-org>
>     Pavel Pisa <pisa-#-cmp-#-felk-#-cvut-#-cz>
>     Pedro Barbuda <pbarbuda-#-microsoft-#-com>
>     Peter Lieven <pl-#-dlhnet-#-de>
>     Peter Xu <peterx-#-redhat-#-com>
>     Phil Dennis-Jordan <phil-#-philjordan-#-eu>
>     Philipp Tomsich <philipp-#-tomsich-#-vrull-#-eu>
>     Ran Wang <wangran-#-bosc-#-ac-#-cn>
>     Raphael Norwitz <rnorwitz-#-nvidia-#-com>
>     Reinoud Zandijk <reinoud-#-netbsd-#-org>
>     Richard W.M. Jones <rjones-#-redhat-#-com>
>     Roman Bolshakov <rbolshakov-#-ddn-#-com>
>     Sai Pavan Boddu <sai-#-pavan-#-boddu-#-amd-#-com>
>     Sairaj Kodilkar <sarunkod-#-amd-#-com>
>     Samuel Tardieu <sam-#-rfc1149-#-net>
>     Samuel Thibault <samuel-#-thibault-#-ens-lyon-#-org>
>     Sergio Lopez <slp-#-redhat-#-com>
>     Song Gao <gaosong-#-loongson-#-cn>
>     Sourabh <sourabhjain-#-linux-#-ibm-#-com>
>     Sourabh Jain <sourabhjain-#-linux-#-ibm-#-com>
>     Sriram Yagnaraman <sriram-#-yagnaraman-#-ericsson-#-com>
>     Stafford Horne <shorne-#-gmail-#-com>
>     Stefano Stabellini <sstabellini-#-kernel-#-org>
>     Steven Lee <steven_lee-#-aspeedtech-#-com>
>     Strahinja Jankovic <strahinja-#-p-#-jankovic-#-gmail-#-com>
>     Subbaraya Sundeep <sundeep-#-lkml-#-gmail-#-com>
>     Sunil V L <sunilvl-#-ventanamicro-#-com>
>     Sven Schnelle <svens-#-stackframe-#-org>
>     Tao Tang <tangtao1634-#-phytium-#-com-#-cn>
>     Thanos Makatos <thanos-#-makatos-#-nutanix-#-com>
>     Titus Rwantare <titusr-#-google-#-com>
>     Tomita Moeko <tomitamoeko-#-gmail-#-com>
>     Tony Krowiak <akrowiak-#-linux-#-ibm-#-com>
>     Troy Lee <leetroy-#-gmail-#-com>
>     Tyrone Ting <kfting-#-nuvoton-#-com>
>     Vikram Garhwal <vikram-#-garhwal-#-bytedance-#-com>
>     Viktor Prutyanov <viktor-#-prutyanov-#-phystech-#-edu>
>     Vincenzo Maffione <v-#-maffione-#-gmail-#-com>
>     Viresh Kumar <viresh-#-kumar-#-linaro-#-org>
>     WANG Xuerui <git-#-xen0n-#-name>
>     Wei Liu <wei-#-liu-#-kernel-#-org>
>     Weiwei Li <liwei1518-#-gmail-#-com>
>     Xie Yongji <xieyongji-#-bytedance-#-com>
>     Yi Liu <yi-#-l-#-liu-#-intel-#-com>


>     Yonggang Luo <luoyonggang-#-gmail-#-com>
This is my gitlab account:
https://gitlab.com/lygstate


>     Yoshinori Sato <yoshinori-#-sato-#-nifty-#-com>
>     Yuri Benditovich <ybendito-#-redhat-#-com>
>     Zhang Chen <zhangckid-#-gmail-#-com>
>     Zhao Liu <zhao1-#-liu-#-intel-#-com>
>     Zhenzhong Duan <zhenzhong-#-duan-#-intel-#-com>
>     Zhuoying Cai <zycai-#-linux-#-ibm-#-com>
>     zhenwei pi <zhenwei-#-pi-#-linux-#-dev>
>
> Plenty of those will have GitLab accounts, but are simply not members
> of QEMU. Plenty more probably aren't registered with GitLab at all.
>
> Short of emailing all of those people directly, I don't see a good
> way to identify their GitLab accounts (if any), in order to invite
> them to the QEMU project. I don't want to blindly invite accounts
> which merely have the same name on GitLab as there's too much risk
> of getting a mis-match.
>
> Daniel P. Berrang=C3=A9 (3):
>   get_maintainer: add ability to report Git Lab handle
>   MAINTAINERS: record known Git Lab handles for all maintainers
>   MAINTAINERS: record known Git Lab handles for all reviewers
>
>  MAINTAINERS               | 396 ++++++++++++++++++++++++++++++++++++++
>  scripts/get_maintainer.pl |  17 +-
>  2 files changed, 411 insertions(+), 2 deletions(-)
>
> --
> 2.54.0
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000516c550654f89577
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Mon, Jun 22, 2026 at 7:32=E2=80=AFPM Daniel P. Berr=
ang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a=
>&gt; wrote:<br>&gt;<br>&gt; When triaging GitLab issues, whether regular b=
ugs or security<br>&gt; disclosures, we need to be able to assign suitable =
accounts.<br>&gt;<br>&gt; We can only assign Git Lab handles for accounts t=
hat are members<br>&gt; of the QEMU group, or QEMU repository with the &quo=
t;Reporter&quot; role<br>&gt; or higher.<br>&gt;<br>&gt; Currently one need=
s to run &#39;<a href=3D"http://get_maintainer.pl">get_maintainer.pl</a> -f=
 &lt;file&gt;&#39; to get<br>&gt; the maintainer / reviewer names &amp; ema=
ils, and then look in the<br>&gt; GitLab members page to see if there is a =
match.<br>&gt;<br>&gt; This simplifies that by adding a &quot;--gitlab&quot=
; option to the<br>&gt; <a href=3D"http://get_maintainer.pl">get_maintainer=
.pl</a> script that will report the GitLab handle<br>&gt; for maintainers /=
 reviewers too.<br>&gt;<br>&gt; MAINTAINERS is then updated with all known =
accounts.<br>&gt;<br>&gt; Ignoring bot accounts, there are the following Gi=
tLab accounts<br>&gt; for people whom are not in MAINTAINERS as a Reviewer/=
Maintainer:<br>&gt;<br>&gt; =C2=A0 =C2=A0 Aihua Liang (aliang1)<br>&gt; =C2=
=A0 =C2=A0 Anthony Roberts (anthony-linaro)<br>&gt; =C2=A0 =C2=A0 Bastian K=
oppelmann (kbastian-qemu)<br>&gt; =C2=A0 =C2=A0 Eduardo Habkost (ehabkost)<=
br>&gt; =C2=A0 =C2=A0 Eldon (eldondev)<br>&gt; =C2=A0 =C2=A0 Emilio Cota (c=
ota_)<br>&gt; =C2=A0 =C2=A0 Jim MacArthur (jmacarthur)<br>&gt; =C2=A0 =C2=
=A0 Joaquin de Andres (xcancerberox)<br>&gt; =C2=A0 =C2=A0 Juan Quintela (j=
uan.quintela)<br>&gt; =C2=A0 =C2=A0 Paul Zimmerman (pauldzim)<br>&gt; =C2=
=A0 =C2=A0 Peter Krempa (<a href=3D"http://pipo.sk">pipo.sk</a>)<br>&gt; =
=C2=A0 =C2=A0 Peter Krempa (work) (pkrempa)<br>&gt;<br>&gt; Much more signi=
ficantly, there are the following people present<br>&gt; in MAINTAINERS, wh=
om are not members of the GitLab project:<br>&gt;<br>&gt; =C2=A0 =C2=A0 Adi=
tya Gupta &lt;adityag-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Akihiko=
 Odaki &lt;odaki-#-rsg-#-ci-#-i-#-u-tokyo-#-ac-#-jp&gt;<br>&gt; =C2=A0 =C2=
=A0 Albert Esteve &lt;aesteve-#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Albe=
rto Garcia &lt;berto-#-igalia-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Alejandro Jim=
enez &lt;alejandro-#-j-#-jimenez-#-oracle-#-com&gt;<br>&gt; =C2=A0 =C2=A0 A=
leksandar Rikalo &lt;arikalo-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Alessa=
ndro Di Federico &lt;ale-#-rev-#-ng&gt;<br>&gt; =C2=A0 =C2=A0 Alexandre Ioo=
ss &lt;erdnaxe-#-crans-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Alexandre Ratchov &l=
t;alex-#-caoua-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Alexey Kardashevskiy &lt;aik=
-#-ozlabs-#-ru&gt;<br>&gt; =C2=A0 =C2=A0 Amit Shah &lt;amit-#-kernel-#-org&=
gt;<br>&gt; =C2=A0 =C2=A0 Andrew Jeffery &lt;andrew-#-codeconstruct-#-com-#=
-au&gt;<br>&gt; =C2=A0 =C2=A0 Anthony PERARD &lt;anthony-#-xenproject-#-org=
&gt;<br>&gt; =C2=A0 =C2=A0 Anton Johansson &lt;anjo-#-rev-#-ng&gt;<br>&gt; =
=C2=A0 =C2=A0 Antony Pavlov &lt;antonynpavlov-#-gmail-#-com&gt;<br>&gt; =C2=
=A0 =C2=A0 Ari Sundholm &lt;ari-#-tuxera-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Ar=
tyom Tarasenko &lt;atar4qemu-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Aureli=
en Jarno &lt;aurelien-#-aurel32-#-net&gt;<br>&gt; =C2=A0 =C2=A0 BALATON Zol=
tan &lt;balaton-#-eik-#-bme-#-hu&gt;<br>&gt; =C2=A0 =C2=A0 Ben Chaney &lt;b=
chaney-#-akamai-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Bernhard Beschow &lt;shente=
y-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Bibo Mao &lt;maobibo-#-loongson-#=
-cn&gt;<br>&gt; =C2=A0 =C2=A0 Brad Smith &lt;brad-#-comstyle-#-com&gt;<br>&=
gt; =C2=A0 =C2=A0 Canokeys.org &lt;contact-#-canokeys-#-org&gt;<br>&gt; =C2=
=A0 =C2=A0 Chao Liu &lt;chao-#-liu-#-zevorn-#-gmail-#-com&gt;<br>&gt; =C2=
=A0 =C2=A0 Chinmay Rath &lt;rathc-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =
=C2=A0 Christoph Muellner &lt;christoph-#-muellner-#-vrull-#-eu&gt;<br>&gt;=
 =C2=A0 =C2=A0 Cl=C3=A9ment Chigot &lt;chigot-#-adacore-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Cl=C3=A9ment Mathieu--Drif &lt;clement-#-mathieu--drif-#-bull=
-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Collin Walling &lt;walling-#-linux-#-ibm-#=
-com&gt;<br>&gt; =C2=A0 =C2=A0 Corey Minyard &lt;cminyard-#-mvista-#-com&gt=
;<br>&gt; =C2=A0 =C2=A0 Denis V. Lunev &lt;den-#-openvz-#-org&gt;<br>&gt; =
=C2=A0 =C2=A0 Dmitry Fleytman &lt;dmitry-#-fleytman-#-gmail-#-com&gt;<br>&g=
t; =C2=A0 =C2=A0 Dmitry Osipenko &lt;dmitry-#-osipenko-#-collabora-#-com&gt=
;<br>&gt; =C2=A0 =C2=A0 Dorjoy Chowdhury &lt;dorjoychy111-#-gmail-#-com&gt;=
<br>&gt; =C2=A0 =C2=A0 Doru Bl=C3=A2nzeanu &lt;dblanzeanu-#-linux-#-microso=
ft-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Edgar E. Iglesias &lt;edgar-#-iglesias-#=
-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Elena Ufimtseva &lt;elena-#-ufimtsev=
a-#-oracle-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Eric Auger &lt;eric-#-auger-#-re=
dhat-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Eric Farman &lt;farman-#-linux-#-ibm-#=
-com&gt;<br>&gt; =C2=A0 =C2=A0 Eugenio P=C3=A9rez &lt;eperezma-#-redhat-#-c=
om&gt;<br>&gt; =C2=A0 =C2=A0 Farhan Ali &lt;alifm-#-linux-#-ibm-#-com&gt;<b=
r>&gt; =C2=A0 =C2=A0 Felipe Balbi &lt;balbi-#-kernel-#-org&gt;<br>&gt; =C2=
=A0 =C2=A0 Francisco Iglesias &lt;francisco-#-iglesias-#-amd-#-com&gt;<br>&=
gt; =C2=A0 =C2=A0 Frederic Konrad &lt;konrad-#-frederic-#-yahoo-#-fr&gt;<br=
>&gt; =C2=A0 =C2=A0 Gaurav Sharma &lt;gaurav-#-sharma_7-#-nxp-#-com&gt;<br>=
&gt; =C2=A0 =C2=A0 Gautam Gala &lt;ggala-#-linux-#-ibm-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Gautam Menghani &lt;gautam-#-linux-#-ibm-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Giuseppe Lettieri &lt;g-#-lettieri-#-iet-#-unipi-#-it&gt;<br>=
&gt; =C2=A0 =C2=A0 Glenn Miles &lt;milesg-#-linux-#-ibm-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Gonglei &lt;arei-#-gonglei-#-huawei-#-com&gt;<br>&gt; =C2=A0 =
=C2=A0 Haixu Cui &lt;quic_haixcui-#-quicinc-#-com&gt;<br>&gt; =C2=A0 =C2=A0=
 Halil Pasic &lt;pasic-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Hao Wu=
 &lt;wuhaotsh-#-google-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Hari Bathini &lt;hba=
thini-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Hendrik Brueckner &lt;b=
rueckner-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Herv=C3=A9 Poussinea=
u &lt;hpoussin-#-reactos-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Hongren (Zenithal)=
 Zheng &lt;i-#-zenithal-#-me&gt;<br>&gt; =C2=A0 =C2=A0 Huacai Chen &lt;chen=
huacai-#-kernel-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Hyman Huang &lt;infra-#-ai-=
#-cloud-#-bitdeer-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Ilya Dryomov &lt;idryomov=
-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Ilya Leoshkevich &lt;iii-#-linux-#=
-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Ilya Maximets &lt;i-#-maximets-#-ovn-#=
-org&gt;<br>&gt; =C2=A0 =C2=A0 Jagannathan Raman &lt;jag-#-raman-#-oracle-#=
-com&gt;<br>&gt; =C2=A0 =C2=A0 Jamin Lin &lt;jamin_lin-#-aspeedtech-#-com&g=
t;<br>&gt; =C2=A0 =C2=A0 Jan Kiszka &lt;jan-#-kiszka-#-web-#-de&gt;<br>&gt;=
 =C2=A0 =C2=A0 Jared Rossi &lt;jrossi-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=
=A0 =C2=A0 Jason Herne &lt;jjherne-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =
=C2=A0 Jean-Christophe Dubois &lt;jcd-#-tribudubois-#-net&gt;<br>&gt; =C2=
=A0 =C2=A0 Jesper Devantier &lt;foss-#-defmacro-#-it&gt;<br>&gt; =C2=A0 =C2=
=A0 Jeuk Kim &lt;jeuk20-#-kim-#-samsung-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Jia=
xun Yang &lt;jiaxun-#-yang-#-flygoat-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Jiri P=
irko &lt;jiri-#-resnulli-#-us&gt;<br>&gt; =C2=A0 =C2=A0 Jiri Slaby &lt;jsla=
by-#-suse-#-cz&gt;<br>&gt; =C2=A0 =C2=A0 Joe Komlodi &lt;komlodi-#-google-#=
-com&gt;<br>&gt; =C2=A0 =C2=A0 Joel Stanley &lt;joel-#-jms-#-id-#-au&gt;<br=
>&gt; =C2=A0 =C2=A0 John Levon &lt;john-#-levon-#-nutanix-#-com&gt;<br>&gt;=
 =C2=A0 =C2=A0 Jonathan Cameron &lt;jic23-#-kernel-#-org&gt;<br>&gt; =C2=A0=
 =C2=A0 Kane Chen &lt;kane_chen-#-aspeedtech-#-com&gt;<br>&gt; =C2=A0 =C2=
=A0 Kashyap Chamarthy &lt;kchamart-#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=A0=
 Keith Busch &lt;kbusch-#-kernel-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Kohei Toku=
naga &lt;ktokunaga-#-mail-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Kuan-Wei =
Chiu &lt;visitorckw-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Kyle Evans &lt;=
kevans-#-freebsd-#-org&gt;<br>&gt; =C2=A0 =C2=A0 LIU Zhiwei &lt;zhiwei_liu-=
#-linux-#-alibaba-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Leif Lindholm &lt;leif-#-=
lindholm-#-oss-#-qualcomm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Li Zhijian &lt;li=
zhijian-#-fujitsu-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Li-Wen Hsu &lt;lwhsu-#-fr=
eebsd-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Liu Zhiwei &lt;zhiwei_liu-#-linux-#-a=
libaba-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Luc Michel &lt;luc-#-lmichel-#-fr&gt=
;<br>&gt; =C2=A0 =C2=A0 Lukas Straub &lt;lukasstraub2-#-web-#-de&gt;<br>&gt=
; =C2=A0 =C2=A0 Maciej S. Szmigiero &lt;maciej-#-szmigiero-#-oracle-#-com&g=
t;<br>&gt; =C2=A0 =C2=A0 Mads Ynddal &lt;mads-#-ynddal-#-dk&gt;<br>&gt; =C2=
=A0 =C2=A0 Magnus Kulke &lt;magnuskulke-#-linux-#-microsoft-#-com&gt;<br>&g=
t; =C2=A0 =C2=A0 Maksim Davydov &lt;davydov-max-#-yandex-team-#-ru&gt;<br>&=
gt; =C2=A0 =C2=A0 Marcelo Tosatti &lt;mtosatti-#-redhat-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Mark Kanda &lt;mark-#-kanda-#-oracle-#-com&gt;<br>&gt; =C2=A0=
 =C2=A0 Markus Armbruster &lt;armbru-#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=
=A0 Mathieu Poirier &lt;mathieu-#-poirier-#-linaro-#-org&gt;<br>&gt; =C2=A0=
 =C2=A0 Matthew Rosato &lt;mjrosato-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =
=C2=A0 Mauro Carvalho Chehab &lt;mchehab+huawei-#-kernel-#-org&gt;<br>&gt; =
=C2=A0 =C2=A0 Max Filippov &lt;jcmvbkbc-#-gmail-#-com&gt;<br>&gt; =C2=A0 =
=C2=A0 Michael Rolnik &lt;mrolnik-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 M=
ilan Zamazal &lt;mzamazal-#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Nabih Es=
tefan &lt;nabihestefan-#-google-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Niek Linnen=
bank &lt;nieklinnenbank-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Ninad Palsu=
le &lt;ninad-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Palmer Dabbelt &=
lt;palmer-#-dabbelt-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Patrick Leis &lt;ventur=
e-#-google-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Paul Durrant &lt;paul-#-xen-#-or=
g&gt;<br>&gt; =C2=A0 =C2=A0 Pavel Pisa &lt;pisa-#-cmp-#-felk-#-cvut-#-cz&gt=
;<br>&gt; =C2=A0 =C2=A0 Pedro Barbuda &lt;pbarbuda-#-microsoft-#-com&gt;<br=
>&gt; =C2=A0 =C2=A0 Peter Lieven &lt;pl-#-dlhnet-#-de&gt;<br>&gt; =C2=A0 =
=C2=A0 Peter Xu &lt;peterx-#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Phil De=
nnis-Jordan &lt;phil-#-philjordan-#-eu&gt;<br>&gt; =C2=A0 =C2=A0 Philipp To=
msich &lt;philipp-#-tomsich-#-vrull-#-eu&gt;<br>&gt; =C2=A0 =C2=A0 Ran Wang=
 &lt;wangran-#-bosc-#-ac-#-cn&gt;<br>&gt; =C2=A0 =C2=A0 Raphael Norwitz &lt=
;rnorwitz-#-nvidia-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Reinoud Zandijk &lt;rein=
oud-#-netbsd-#-org&gt;<br>&gt; =C2=A0 =C2=A0 Richard W.M. Jones &lt;rjones-=
#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Roman Bolshakov &lt;rbolshakov-#-d=
dn-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Sai Pavan Boddu &lt;sai-#-pavan-#-boddu-=
#-amd-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Sairaj Kodilkar &lt;sarunkod-#-amd-#-=
com&gt;<br>&gt; =C2=A0 =C2=A0 Samuel Tardieu &lt;sam-#-rfc1149-#-net&gt;<br=
>&gt; =C2=A0 =C2=A0 Samuel Thibault &lt;samuel-#-thibault-#-ens-lyon-#-org&=
gt;<br>&gt; =C2=A0 =C2=A0 Sergio Lopez &lt;slp-#-redhat-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Song Gao &lt;gaosong-#-loongson-#-cn&gt;<br>&gt; =C2=A0 =C2=
=A0 Sourabh &lt;sourabhjain-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 S=
ourabh Jain &lt;sourabhjain-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 S=
riram Yagnaraman &lt;sriram-#-yagnaraman-#-ericsson-#-com&gt;<br>&gt; =C2=
=A0 =C2=A0 Stafford Horne &lt;shorne-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=
=A0 Stefano Stabellini &lt;sstabellini-#-kernel-#-org&gt;<br>&gt; =C2=A0 =
=C2=A0 Steven Lee &lt;steven_lee-#-aspeedtech-#-com&gt;<br>&gt; =C2=A0 =C2=
=A0 Strahinja Jankovic &lt;strahinja-#-p-#-jankovic-#-gmail-#-com&gt;<br>&g=
t; =C2=A0 =C2=A0 Subbaraya Sundeep &lt;sundeep-#-lkml-#-gmail-#-com&gt;<br>=
&gt; =C2=A0 =C2=A0 Sunil V L &lt;sunilvl-#-ventanamicro-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Sven Schnelle &lt;svens-#-stackframe-#-org&gt;<br>&gt; =C2=A0=
 =C2=A0 Tao Tang &lt;tangtao1634-#-phytium-#-com-#-cn&gt;<br>&gt; =C2=A0 =
=C2=A0 Thanos Makatos &lt;thanos-#-makatos-#-nutanix-#-com&gt;<br>&gt; =C2=
=A0 =C2=A0 Titus Rwantare &lt;titusr-#-google-#-com&gt;<br>&gt; =C2=A0 =C2=
=A0 Tomita Moeko &lt;tomitamoeko-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 To=
ny Krowiak &lt;akrowiak-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Troy =
Lee &lt;leetroy-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Tyrone Ting &lt;kft=
ing-#-nuvoton-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Vikram Garhwal &lt;vikram-#-g=
arhwal-#-bytedance-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Viktor Prutyanov &lt;vik=
tor-#-prutyanov-#-phystech-#-edu&gt;<br>&gt; =C2=A0 =C2=A0 Vincenzo Maffion=
e &lt;v-#-maffione-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Viresh Kumar &lt=
;viresh-#-kumar-#-linaro-#-org&gt;<br>&gt; =C2=A0 =C2=A0 WANG Xuerui &lt;gi=
t-#-xen0n-#-name&gt;<br>&gt; =C2=A0 =C2=A0 Wei Liu &lt;wei-#-liu-#-kernel-#=
-org&gt;<br>&gt; =C2=A0 =C2=A0 Weiwei Li &lt;liwei1518-#-gmail-#-com&gt;<br=
>&gt; =C2=A0 =C2=A0 Xie Yongji &lt;xieyongji-#-bytedance-#-com&gt;<br>&gt; =
=C2=A0 =C2=A0 Yi Liu &lt;yi-#-l-#-liu-#-intel-#-com&gt;<br><br><br><div>&gt=
; =C2=A0 =C2=A0 Yonggang Luo &lt;luoyonggang-#-gmail-#-com&gt;<div>This is =
my gitlab account:</div><div><a href=3D"https://gitlab.com/lygstate">https:=
//gitlab.com/lygstate</a><br></div><div><br></div><div><br>&gt; =C2=A0 =C2=
=A0 Yoshinori Sato &lt;yoshinori-#-sato-#-nifty-#-com&gt;<br>&gt; =C2=A0 =
=C2=A0 Yuri Benditovich &lt;ybendito-#-redhat-#-com&gt;<br>&gt; =C2=A0 =C2=
=A0 Zhang Chen &lt;zhangckid-#-gmail-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Zhao L=
iu &lt;zhao1-#-liu-#-intel-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Zhenzhong Duan &=
lt;zhenzhong-#-duan-#-intel-#-com&gt;<br>&gt; =C2=A0 =C2=A0 Zhuoying Cai &l=
t;zycai-#-linux-#-ibm-#-com&gt;<br>&gt; =C2=A0 =C2=A0 zhenwei pi &lt;zhenwe=
i-#-pi-#-linux-#-dev&gt;<br>&gt;<br>&gt; Plenty of those will have GitLab a=
ccounts, but are simply not members<br>&gt; of QEMU. Plenty more probably a=
ren&#39;t registered with GitLab at all.<br>&gt;<br>&gt; Short of emailing =
all of those people directly, I don&#39;t see a good<br>&gt; way to identif=
y their GitLab accounts (if any), in order to invite<br>&gt; them to the QE=
MU project. I don&#39;t want to blindly invite accounts<br>&gt; which merel=
y have the same name on GitLab as there&#39;s too much risk<br>&gt; of gett=
ing a mis-match.<br>&gt;<br>&gt; Daniel P. Berrang=C3=A9 (3):<br>&gt; =C2=
=A0 get_maintainer: add ability to report Git Lab handle<br>&gt; =C2=A0 MAI=
NTAINERS: record known Git Lab handles for all maintainers<br>&gt; =C2=A0 M=
AINTAINERS: record known Git Lab handles for all reviewers<br>&gt;<br>&gt; =
=C2=A0MAINTAINERS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 396 ++=
++++++++++++++++++++++++++++++++++++<br>&gt; =C2=A0scripts/<a href=3D"http:=
//get_maintainer.pl">get_maintainer.pl</a> | =C2=A017 +-<br>&gt; =C2=A02 fi=
les changed, 411 insertions(+), 2 deletions(-)<br>&gt;<br>&gt; --<br>&gt; 2=
.54.0<br>&gt;<br>&gt;<br><br><br>-- <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div></div>

--000000000000516c550654f89577--

