Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748E3C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI72Y-0005Su-IV; Thu, 22 May 2025 10:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uI72W-0005Rq-DV
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:36:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1uI72Q-0001a5-Od
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:36:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M6Ibju008460;
 Thu, 22 May 2025 14:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fZyUrS
 AA//6zRVBI2fHz7ds7t8wYde7nHD1lyk8CAto=; b=iOqWfsDjaB0RwnsoiXzujh
 Ebhg2aZGGeRPxrhDesQ9H/nUakZrUqCueBhvRMSMrEKcPy0pNKNMJ9TWLW3UbiVw
 0OAOWKYOt0PBSbV4LXi/AqPKWqun8mZ5n+EM1btnc8gf9FUEMCUpQq56K7xcgq17
 yNHfqj/HjJP47w0Gf2fO8VMv2V7lAVaUKyigFTUPncpjoFXI5HGtVQZoCwlkkjd4
 vEi27m2XP7j81L5G9h3yy5PywCQ3ehqOahvfOGYMsh1tPfQbpQEw7W3rsdeq2NnN
 YTIyTjOAWPxAQIEUrJdsDVzK2W1a3a+AMtkGx6k1oIiEekL9N760JxkdxynGNNfA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sxhwaak9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 14:36:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54MDoAUh015480;
 Thu, 22 May 2025 14:36:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46rwnnhv0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 May 2025 14:36:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54MEajdI32244422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 May 2025 14:36:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62DE15805E;
 Thu, 22 May 2025 14:36:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20E0C58052;
 Thu, 22 May 2025 14:36:45 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 May 2025 14:36:45 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 22 May 2025 15:36:44 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Da?=
 =?UTF-8?Q?niel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH] util: split unix socket functions out of qemu-sockets
In-Reply-To: <20250520165706.3976971-1-alex.bennee@linaro.org>
References: <20250520165706.3976971-1-alex.bennee@linaro.org>
Message-ID: <659b49bc31ca4f3d9572f9d48e7d09b0@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE0OSBTYWx0ZWRfX2WncfrjihAOf
 GP45i7PsqV+Phm4fEDYSszMX0x3zOs40mVy9pp6Z/e5zavqnz0x4P0yz2mXkn0LjZsKcn7fogi6
 6iyQYe7WuB7Ve1/wnDvF3smVeszVFRM3+wP+mtpVr8hJRnwlAjvHYHyP92eS9rgTiSGeCT574u9
 7cmWij4GXkpvU/Rr/ZBFNm4EbUIRpV3PSr8EVoPtzmk7i9OjaRX87jqUFw4C4n4719aXxD0/j7x
 oH4KScE1QyKO8Jv+TFzjbuIsRBXHKc1qKONBzqx3FM65+CeXXE8lk7ox+IpcTVbHYLMIhD00XBB
 s839KnbcqlUCyFEkPSS0JVPBqDEsL/TokbevwjrDZ5p8NxvG8CEjOI50qpeeivLX9ZNn+MaU64R
 QMvztma3dN7UkwcMUonHpqYmX/JdTXdEbWikEIkoLMkloF45+8Sx+4JTqeq/YjhvmgOiNkWk
X-Proofpoint-GUID: TtsygdwzYtQlPmXFNoY2-Yw04YfMn_gW
X-Authority-Analysis: v=2.4 cv=O685vA9W c=1 sm=1 tr=0 ts=682f367e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=9qUTvQc-AAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=X0LHbmb94AnUssr0TkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-ORIG-GUID: TtsygdwzYtQlPmXFNoY2-Yw04YfMn_gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_07,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thanks for looking into this!

On 2025-05-20 17:57, Alex Bennée wrote:
> Since fccb744f41 (gdbstub: Try unlinking the unix socket before
> binding) we use the unix_listen() function from linux-user which
> causes complications when trying to build statically.

Should this be in Fixes: tag?

> Fix this by splitting the unix functions into its own file and doing
> the appropriate tweaks to the headers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/qemu/sockets.h |   1 +
>  util/socket-helpers.h  |  17 ++++
>  util/qemu-sockets.c    | 199 +--------------------------------------
>  util/unix-sockets.c    | 207 +++++++++++++++++++++++++++++++++++++++++
>  util/meson.build       |   5 +-
>  5 files changed, 231 insertions(+), 198 deletions(-)
>  create mode 100644 util/socket-helpers.h
>  create mode 100644 util/unix-sockets.c

[...]

> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1,5 +1,5 @@
>  /*
> - *  inet and unix socket functions for qemu
> + *  inet socket functions for qemu
>   *
>   *  (c) 2008 Gerd Hoffmann <kraxel@redhat.com>
>   *

Should we mention that static linking of this file is not supported?

With or without this:

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

