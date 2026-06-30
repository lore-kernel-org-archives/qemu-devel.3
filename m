Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BC6C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 06:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weSCY-0005d9-SO; Tue, 30 Jun 2026 02:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1weSCX-0005cx-GW
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:44:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1weSCV-0007zI-By
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 02:44:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U5nWZf1077663; Tue, 30 Jun 2026 06:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C4uNaS
 0DffLtIgy9+weKZKfV0uW1fTAnN8QqqXT2S+Y=; b=oK+2bg35Px6fBA8jTZ3TGZ
 YuB8f9w22PdBVA2lTO+2p1FhwngWkpJnD8/zOU8q7H0ZU8P1Y+GzDCaT4O/pGTUn
 phLf+HBPCpOcD+hNwRKKMn/ZAatRIG4KUu9hVgVjogoE6973M4fTLLpokJAMftgx
 GDq2D9jmeqaB5B8GIkqq7+V23SSoMJYsrFly6vWYjf5NjMk8Ol9t9eIEx0pt+Vn7
 9Ny/CdhR4Q0Nr67VnbHrAH61i+tYiP3F/+vqsBuXLWdY/YrBAtakppyzwwamWewL
 SmjvNmSO8gglnbUEGVUAKArU0QuQxEEkoH8ZZWQLF/jk8/n3QAuqP7pyZCIFZV6g
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26q9vx8j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 06:44:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U6Ybh9004090;
 Tue, 30 Jun 2026 06:44:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g8qfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 06:44:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65U6i3Ex31326936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 06:44:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B178D58063;
 Tue, 30 Jun 2026 06:44:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32EFE58059;
 Tue, 30 Jun 2026 06:44:01 +0000 (GMT)
Received: from [9.124.209.153] (unknown [9.124.209.153])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jun 2026 06:44:00 +0000 (GMT)
Message-ID: <2f1df7a2-c5cf-4c4f-b151-c287ada5b0b4@linux.ibm.com>
Date: Tue, 30 Jun 2026 12:13:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Record maintainer/reviewer Git Lab handles
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260624122936.2706393-1-berrange@redhat.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260624122936.2706393-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfXxxAFf3wbHUyE
 SWi+2bzoJe8rCFERCapiDibjbdFm9Q3EmZAu4Br1WzE/ijslsotnd3zmg3Fe6u6thXSd6KBrYok
 cXeiBuRefEgFrn7XEig4o8xZpi67CLfzQINBTtoPCSjB1uoNBW/DsqSR8QbdjmDgEt3uxKoN8x2
 FDtA5HxAPX6WrjBWuoGtcgwuxk1SWq3kc1vcttb3K08eJ1SebDTtWUgBbsT4Zdd2B3CpDZj3WxZ
 YVByWMxlxglXdJvgRXANKdVbuNDnYaYMlSsr9FhhpgSLxQLVdxGRF5xjLdMwgxoG1tD/IPFa48Q
 b15vZg5wGyYXPOqj52bULf+nkCR1xC35xUz6E2UYVhlxxgoa9ENKTlc06gvXnEmst2nCLoMlzyd
 +PYUbs5f7WggmgUC7TjjQjClr3LEx8Ow1lKWgZdZIf0v1e4DJCvJ+xn/c3M3nKskwH0l4duEQ+7
 mAjjTdwgnnoEjAiVukQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA1MSBTYWx0ZWRfX2YJt+gCJzojU
 42IhEIakFrtiIm/EW4W+vup9ourGxCKPtEQgDWYHrF5M5fI9jdU8vQkzX4lgmzYX+lS8o2vJsA7
 K7DA9So9mYJmCDUPf05+D//XovlT3gU=
X-Proofpoint-GUID: DBtC0oWASXFP3t-x5N9BrpX27xlQF9T1
X-Proofpoint-ORIG-GUID: DBtC0oWASXFP3t-x5N9BrpX27xlQF9T1
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a4365b5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=REwzQqOBAAAA:8 a=1CHiq-5-n_LSPZHAcfIA:9 a=b6BAcytWedqvE-_s:21
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=8XF_WGNd4qQvm41dh321:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1011 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300051
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 6/24/26 17:59, Daniel P. Berrangé wrote:
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
> This simplifies that by including the GitLab handle alongside
> the email addresses:
>
> The GitLab account handle -> real name mapping is stored in
> separate files .gitlab-map-auto & .gitlab-map-manual to avoid
> redundancy in the MAINTAINERS file. The former file is
> auto-generated and catches 99% of the mappings, the latter is
> for manual fixups.
>
> With this series applied as is, we get the following stats
>
> $ ./scripts/gitlab-map-check
> Missing GitLab handle: Akihiko Odaki
> Missing GitLab handle: Albert Esteve
> Missing GitLab handle: Alberto Garcia
> Missing GitLab handle: Alejandro Jimenez
> Missing GitLab handle: Aleksandar Rikalo
> Missing GitLab handle: Alessandro Di Federico
> Missing GitLab handle: Alexandre Iooss
> Missing GitLab handle: Alexandre Ratchov
> Missing GitLab handle: Alexey Kardashevskiy
> Missing GitLab handle: Amit Shah
> Missing GitLab handle: Andrew Jeffery
> Missing GitLab handle: Anthony PERARD
> Missing GitLab handle: Anton Johansson
> Missing GitLab handle: Antony Pavlov
> Missing GitLab handle: Ari Sundholm
> Missing GitLab handle: Artyom Tarasenko
> Missing GitLab handle: Aurelien Jarno
> Missing GitLab handle: BALATON Zoltan
> Missing GitLab handle: Ben Chaney
> Missing GitLab handle: Bernhard Beschow
> Missing GitLab handle: Bibo Mao
> Missing GitLab handle: Brad Smith
> Missing GitLab handle: Canokeys.org
> Missing GitLab handle: Chao Liu
> Missing GitLab handle: Chinmay Rath
Hi Danilel, my GitLab account ^, is at :
https://gitlab.com/rathc

Should I be reaching out to any specific Maintainer or Owner to add me 
to the GitLab project ?

Thanks,
Chinmay
> Missing GitLab handle: Christoph Muellner
> Missing GitLab handle: Clément Chigot
> Missing GitLab handle: Clément Mathieu--Drif
> Missing GitLab handle: Collin Walling
> Missing GitLab handle: Corey Minyard
> Missing GitLab handle: Darren Kenny
> Missing GitLab handle: Denis V. Lunev
> Missing GitLab handle: Dmitry Fleytman
> Missing GitLab handle: Dmitry Osipenko
> Missing GitLab handle: Dorjoy Chowdhury
> Missing GitLab handle: Doru Blânzeanu
> Missing GitLab handle: Edgar E. Iglesias
> Missing GitLab handle: Elena Ufimtseva
> Missing GitLab handle: Eric Auger
> Missing GitLab handle: Eric Farman
> Missing GitLab handle: Eugenio Pérez
> Missing GitLab handle: Farhan Ali
> Missing GitLab handle: Felipe Balbi
> Missing GitLab handle: Francisco Iglesias
> Missing GitLab handle: Frederic Konrad
> Missing GitLab handle: Gaurav Sharma
> Missing GitLab handle: Gautam Gala
> Missing GitLab handle: Gautam Menghani
> Missing GitLab handle: Giuseppe Lettieri
> Missing GitLab handle: Glenn Miles
> Missing GitLab handle: Gonglei
> Missing GitLab handle: Haixu Cui
> Missing GitLab handle: Halil Pasic
> Missing GitLab handle: Hao Wu
> Missing GitLab handle: Hari Bathini
> Missing GitLab handle: Hendrik Brueckner
> Missing GitLab handle: Hervé Poussineau
> Missing GitLab handle: Hongren (Zenithal) Zheng
> Missing GitLab handle: Huacai Chen
> Missing GitLab handle: Hyman Huang
> Missing GitLab handle: Ilya Dryomov
> Missing GitLab handle: Ilya Leoshkevich
> Missing GitLab handle: Ilya Maximets
> Missing GitLab handle: Jagannathan Raman
> Missing GitLab handle: Jamin Lin
> Missing GitLab handle: Jan Kiszka
> Missing GitLab handle: Jared Rossi
> Missing GitLab handle: Jason Herne
> Missing GitLab handle: Jean-Christophe Dubois
> Missing GitLab handle: Jesper Devantier
> Missing GitLab handle: Jeuk Kim
> Missing GitLab handle: Jiaxun Yang
> Missing GitLab handle: Jiri Pirko
> Missing GitLab handle: Jiri Slaby
> Missing GitLab handle: Joe Komlodi
> Missing GitLab handle: Joel Stanley
> Missing GitLab handle: John Levon
> Missing GitLab handle: Jonathan Cameron
> Missing GitLab handle: Kane Chen
> Missing GitLab handle: Kashyap Chamarthy
> Missing GitLab handle: Keith Busch
> Missing GitLab handle: Kohei Tokunaga
> Missing GitLab handle: Kuan-Wei Chiu
> Missing GitLab handle: Kyle Evans
> Missing GitLab handle: Leif Lindholm
> Missing GitLab handle: Liu Zhiwei
> Missing GitLab handle: LIU Zhiwei
> Missing GitLab handle: Li-Wen Hsu
> Missing GitLab handle: Li Zhijian
> Missing GitLab handle: Luc Michel
> Missing GitLab handle: Lukas Straub
> Missing GitLab handle: Maciej S. Szmigiero
> Missing GitLab handle: Mads Ynddal
> Missing GitLab handle: Magnus Kulke
> Missing GitLab handle: Maksim Davydov
> Missing GitLab handle: Marcelo Tosatti
> Missing GitLab handle: Mark Kanda
> Missing GitLab handle: Markus Armbruster
> Missing GitLab handle: Mathieu Poirier
> Missing GitLab handle: Matthew Rosato
> Missing GitLab handle: Mauro Carvalho Chehab
> Missing GitLab handle: Max Filippov
> Missing GitLab handle: Michael Rolnik
> Missing GitLab handle: Milan Zamazal
> Missing GitLab handle: Nabih Estefan
> Missing GitLab handle: Niek Linnenbank
> Missing GitLab handle: Ninad Palsule
> Missing GitLab handle: Palmer Dabbelt
> Missing GitLab handle: Patrick Leis
> Missing GitLab handle: Paul Durrant
> Missing GitLab handle: Pavel Pisa
> Missing GitLab handle: Pedro Barbuda
> Missing GitLab handle: Peter Lieven
> Missing GitLab handle: Peter Xu
> Missing GitLab handle: Phil Dennis-Jordan
> Missing GitLab handle: Philipp Tomsich
> Missing GitLab handle: Ran Wang
> Missing GitLab handle: Raphael Norwitz
> Missing GitLab handle: Reinoud Zandijk
> Missing GitLab handle: Richard W.M. Jones
> Missing GitLab handle: Roman Bolshakov
> Missing GitLab handle: Sai Pavan Boddu
> Missing GitLab handle: Sairaj Kodilkar
> Missing GitLab handle: Samuel Tardieu
> Missing GitLab handle: Samuel Thibault
> Missing GitLab handle: Sergio Lopez
> Missing GitLab handle: Song Gao
> Missing GitLab handle: Sourabh
> Missing GitLab handle: Sourabh Jain
> Missing GitLab handle: Sriram Yagnaraman
> Missing GitLab handle: Stafford Horne
> Missing GitLab handle: Stefano Stabellini
> Missing GitLab handle: Steven Lee
> Missing GitLab handle: Strahinja Jankovic
> Missing GitLab handle: Subbaraya Sundeep
> Missing GitLab handle: Sunil V L
> Missing GitLab handle: Sven Schnelle
> Missing GitLab handle: Tao Tang
> Missing GitLab handle: Thanos Makatos
> Missing GitLab handle: Titus Rwantare
> Missing GitLab handle: Tomita Moeko
> Missing GitLab handle: Tony Krowiak
> Missing GitLab handle: Troy Lee
> Missing GitLab handle: Tyrone Ting
> Missing GitLab handle: Vikram Garhwal
> Missing GitLab handle: Viktor Prutyanov
> Missing GitLab handle: Vincenzo Maffione
> Missing GitLab handle: Viresh Kumar
> Missing GitLab handle: WANG Xuerui
> Missing GitLab handle: Wei Liu
> Missing GitLab handle: Weiwei Li
> Missing GitLab handle: Xie Yongji
> Missing GitLab handle: Yi Liu
> Missing GitLab handle: Yonggang Luo
> Missing GitLab handle: Yoshinori Sato
> Missing GitLab handle: Yuri Benditovich
> Missing GitLab handle: Zhang Chen
> Missing GitLab handle: Zhao Liu
> Missing GitLab handle: zhenwei pi
> Missing GitLab handle: Zhenzhong Duan
> Missing GitLab handle: Zhuoying Cai
> GitLab handles missing: 161 / present: 57
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
> Changed in v2:
>
>   - Don't store data in MAINTAINERS file, use a separate mapping
>   - Don't require a --gitlab flag to get_maintainer.pl, always
>     show the handle
>   - Add scripts for updating & analysing the mappings
>
> Daniel P. Berrangé (2):
>    gitlab: introduce files mapping GitLab accounts to real names
>    get_maintainer: add ability to report Git Lab handle
>
>   .gitlab-map-auto          | 83 +++++++++++++++++++++++++++++++++++++++
>   .gitlab-map-manual        | 18 +++++++++
>   scripts/get_maintainer.pl | 42 ++++++++++++++++++--
>   scripts/gitlab-map-check  | 23 +++++++++++
>   scripts/gitlab-map-update | 44 +++++++++++++++++++++
>   5 files changed, 206 insertions(+), 4 deletions(-)
>   create mode 100644 .gitlab-map-auto
>   create mode 100644 .gitlab-map-manual
>   create mode 100755 scripts/gitlab-map-check
>   create mode 100755 scripts/gitlab-map-update
>

