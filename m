Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E9CDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMt2-0001LL-Kj; Wed, 24 Jun 2026 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wcMt0-0001Kr-BL
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:39:22 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wcMsy-0005CY-7d
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:39:22 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30c6836fea9so605195eec.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782304758; x=1782909558; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9spGAdHYXNU0+5dfFOiB2U9qKXludlmPi9N8vbN2QTM=;
 b=K6kXSck7FSAlTDs6e9SnhtP4Ztgv1qUnNo64p/M/c2Kn7WBp8ikj0jYMkWBIszHTMw
 GV1oaGZ1dJgCnUOm21D3InvdRRmHaNR0AK8MUbjdFUHFBigewoxjLqTtWILXg2GPEWjZ
 xajSJWtBmsjjtqid+ndM6anmI8IGGsIEqDWOblr4w6NiI5mTCIj1p2Vrgc06MYC3rWEE
 hlfyIn4CWcafngr1lwlWmoRSDMcxV09XvzzL2ZwnbAoRoNYpoQK4qC83lYU6o59PQOrh
 nAPyMuUb+NtA89Y19BkbJ77pbaRSntmYRwgLE25QT1WwShipg0J+cI+4cBYO8VzMKdX7
 8T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304758; x=1782909558;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9spGAdHYXNU0+5dfFOiB2U9qKXludlmPi9N8vbN2QTM=;
 b=RnRkYH2qZnjl/fNvrVvNLis8xqbXDU1XsniF7DwE09IMNKEnpof305USel8twfZMqf
 0Xf2JyRi+ZKw4StbreFOckzatPLVhtUT+QaS+2N855EMbv1Z2uNoihek7C5StfbsByRW
 uwbFd6mKh2EXxqd4oBjM1iQ10MXxK6H45Oy1EjObQH4DEK8lNU9ubqJdgvOaD87iED8M
 IVqOY4Ty8XhM/oDuxWVS2LFgg9SZRE/x6dF29oCBnNM2cNx53BS2wvz5b6OoXuc0c8Lc
 XtfYtD54s9Snf06o4aqGrgtrACQIJnn+7QBBFyWLjrzPKr+e4OeyaCa7mgaXMHphp5dK
 aveA==
X-Gm-Message-State: AOJu0YyZdYNqIZ95G38gKSeq6mxhQzorw0SwRP5aWTfJbNP/BId07pob
 g9k2Jz1IYxuzK3n3BOYvSHq6chd94wzrsO7yyL1cyL4VlG7XEeNP7YFo
X-Gm-Gg: AfdE7cnBlC3HJ3+frYQ8B6pNdRrmjqJICirn4jzv2w78FZuH7Z+iKuYJK/XG/hSrZQP
 Fh3Bi8obSFUuvDWq/qZ5Vp9wVw8TZCy0326X5aR89GAIBrt28jSvJvI6Br3Gx6tH+/HM+OWFE52
 bhbVsvbKf3qmkbYaL5t55E4kodeJ77xAtcWJd61+IfqtxR4SoqwwxBDpTs27z1QxyGpqZWKwvr+
 +dbC7nxyjkpqo67PxTpAX3/FqQPVVZ+mxQ8YmVLeEw5J+fSNukWZym/Ab/7IMem3fFYvHjQf62I
 DheBy9soxJ7fvaop9gWO67gkMXKJlP8tc5ierK3aL4rJ3NnqyXXB46wqcQXZT/jnGbBUqzY2Siz
 2V93mzhNG9ZDHSZyKMTEhZVqoPxt3HqIISysm3TXLXf7D5k9vvCijuEwoxIxL/P3/mwkKKkVEDo
 IaN6zwLO4XBSWFS81hDEZKopvPywucQXbOPGIQ4ydeyD2fzxTX
X-Received: by 2002:a05:7300:80cc:b0:30c:1fb5:94b1 with SMTP id
 5a478bee46e88-30c5553657amr7679174eec.6.1782304757802; 
 Wed, 24 Jun 2026 05:39:17 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bde9335sm22681446eec.21.2026.06.24.05.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:39:17 -0700 (PDT)
Date: Wed, 24 Jun 2026 20:39:14 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
Message-ID: <ajvP1ZaHAcQs2WOa@ChaodeMacBook-Pro.local>
References: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Mon, Jun 22, 2026 at 12:31:49PM +0800, Daniel P. Berrangé wrote:
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
My GitLab account is gitlab.com/chao23.liu

Thanks,
Chao
>     Chinmay Rath <rathc-#-linux-#-ibm-#-com>
>     Christoph Muellner <christoph-#-muellner-#-vrull-#-eu>
>     Clément Chigot <chigot-#-adacore-#-com>
>     Clément Mathieu--Drif <clement-#-mathieu--drif-#-bull-#-com>
>     Collin Walling <walling-#-linux-#-ibm-#-com>
>     Corey Minyard <cminyard-#-mvista-#-com>
>     Denis V. Lunev <den-#-openvz-#-org>
>     Dmitry Fleytman <dmitry-#-fleytman-#-gmail-#-com>
>     Dmitry Osipenko <dmitry-#-osipenko-#-collabora-#-com>
>     Dorjoy Chowdhury <dorjoychy111-#-gmail-#-com>
>     Doru Blânzeanu <dblanzeanu-#-linux-#-microsoft-#-com>
>     Edgar E. Iglesias <edgar-#-iglesias-#-gmail-#-com>
>     Elena Ufimtseva <elena-#-ufimtseva-#-oracle-#-com>
>     Eric Auger <eric-#-auger-#-redhat-#-com>
>     Eric Farman <farman-#-linux-#-ibm-#-com>
>     Eugenio Pérez <eperezma-#-redhat-#-com>
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
>     Hervé Poussineau <hpoussin-#-reactos-#-org>
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
> Daniel P. Berrangé (3):
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

