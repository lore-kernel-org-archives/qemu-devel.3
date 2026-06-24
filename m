Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EB3CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 04:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFPv-0007p9-4q; Wed, 24 Jun 2026 00:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wcFPs-0007ol-13
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 00:40:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wcFPq-0000G1-BX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 00:40:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1mGX73722893; Wed, 24 Jun 2026 04:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=/oIjDY
 NNaZvDDl6icqJ1xZKhXuyopSu4MptZGnpU2Gg=; b=SPExRW+XhP1vzT6hRRRuvR
 k05l020Zma7CW038umpROKjT4GnFxly9v/3NIzLZF019XS11VWq8+yVbNz8rtISb
 xiT1UISs+Awe7qFZ26NaoJ+ehxAbM6zCJuubrWZeKS//wDMBp2A3UGEAIkEoGPr6
 n+EqGT4JNlPSYnQ7tRTnEwhOHn6HUYI8XHq1uG5iVZEV6YjvosU54a5P4T1pPkmm
 oNx3NvGpvOWhA8cvjs/ELPXNmfqrGb63c1IlIjVHhjU+IR5NzeGy3mEa5MFFgrt3
 yzNAj+uev8ve8xamtoQAUp+k2cz1nvegpvM1EKn1LdN24KY/x88quLJHA1FTWqHQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4j9bk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 04:40:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O4Yo8C014610;
 Wed, 24 Jun 2026 04:40:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qf2q0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 04:40:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65O4ed7549938828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 04:40:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B90420043;
 Wed, 24 Jun 2026 04:40:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B123020040;
 Wed, 24 Jun 2026 04:40:38 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.124.222.29])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2026 04:40:38 +0000 (GMT)
Date: Wed, 24 Jun 2026 10:10:31 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
Message-ID: <ajtfv23SCmpcJC0v@Gautams-MacBook-Pro.local>
References: <20260622113152.1710585-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3b5fca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=REwzQqOBAAAA:8
 a=p0WdMEafAAAA:8 a=-MzK42hLolsIQTy2MDcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=8XF_WGNd4qQvm41dh321:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDAzMiBTYWx0ZWRfXwLop/1+B9W6u
 OdF1BOWC80JpFmkiapGqApfNuau2XRWyhkflkPH24L3GtpKmyIPGEUhboOKtAFghtjJB5QswgBQ
 Ox0sLEEHlEJr3+13T064UOk+VeveWKTe3hpENFt7s/VX8Fo5EJottXhxjjQSiRRhfXORXlfiU6U
 f7x1glWYta1DZNZgPgW0SpAyVBqjpAUA6xFH9hkPpWBh2MVwBtMWiqGaQWpMhoJ+P/mmGklvoPN
 3raqOZE8o0gdTvfrGmfp2Xlylvm1EA7LSL2cOR5oteUZdQ3Pe/XJzq/okVlWfwe+6qoPgYiosHc
 g4zNYypntuP34euH9/9P3YXeMoLj6MerA/dNMAmGJ14YJsI0hzz+kFUXF9uxUo0ns2T7Ppm5kSq
 beQkeom77Ytbo+l6erhXrLQrMUq/Vw==
X-Proofpoint-GUID: djsugqdP3b-cWbq8s6eE3k8vwWTwHXd5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDAzMiBTYWx0ZWRfX5LD3QTmTCm/5
 aidLoNaOHRoH0IC8xntITml+FnWIl3lBN63NVMeNYZumzzo9s/4WL1ZfGC/LaLtO6ILsiKf16MF
 7ucrEVepggLJpDLSWrJQrsCL09K98LY=
X-Proofpoint-ORIG-GUID: djsugqdP3b-cWbq8s6eE3k8vwWTwHXd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Jun 22, 2026 at 12:31:49PM +0100, Daniel P. Berrangé wrote:
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

My gitlab handle is : gitlab.com/gautammenghani

Thanks,
Gautam

