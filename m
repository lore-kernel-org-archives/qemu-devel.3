Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6836CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbdwe-0002Gf-58; Mon, 22 Jun 2026 08:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wbdwc-0002Fk-BP
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:40:06 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wbdwZ-0000hp-Nu
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:40:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D853775C5B;
 Mon, 22 Jun 2026 12:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782132000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUeXy0pEZ51cINROZ67eCsLImSn8q8kdB7QyuTbiI34=;
 b=bsUYSiTM0KTsPuQyDAD4bzqa0+hR5ELE9htsJlWxrpG8JWj/ZBzWXb2TYldF0BgDaw6m/f
 up3RqX6BDUOqEqaDiovaKcpiQuiUhbShW+SJxJG2dypH9HIr9UOGJvOf7JyNk1tfjxGdkR
 Tsx1/yWDFU0euAAXSUSnRtdtS6951g8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782132000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUeXy0pEZ51cINROZ67eCsLImSn8q8kdB7QyuTbiI34=;
 b=13NwQcbL96d0afI6b4T96IekeFolpw+1yaLi1mIBl8q5Y7+IfYNhoIyAeEJHdPsWD+KKXa
 ZIyOl2oJOht1GZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782131999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUeXy0pEZ51cINROZ67eCsLImSn8q8kdB7QyuTbiI34=;
 b=fla+L8HvM81eUkimgvqqFmDYbFRWVB1ddvXlXkH3GUBohhzLBrwjJR0PiHE0EqMWvbmul7
 akiudtwbpf9pMUpXyHXpjntKaFFOJfFvCdPAJ5hqRsGgKDC7Opoe6awxJ8DQWyNAp9mVZm
 fQ6yT6VHq7Ei0+NhLTMCngyLwk+apL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782131999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUeXy0pEZ51cINROZ67eCsLImSn8q8kdB7QyuTbiI34=;
 b=4VMfVvZClk0Aforjo2FO0cQuZtiWThYzQkE42u3EqloweZ/q78DHGx2JVIq1hRFa7i7XDW
 tc67XNz1d8myHjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76D59779A8;
 Mon, 22 Jun 2026 12:39:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pwz7ER8tOWrOcwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Jun 2026 12:39:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
References: <20260622113152.1710585-1-berrange@redhat.com>
Date: Mon, 22 Jun 2026 09:39:57 -0300
Message-ID: <87o6h2695u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

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

Acked-by: Fabiano Rosas <farosas@suse.de>

