Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760FDC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 22:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHVLr-00059F-Iv; Tue, 20 May 2025 18:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1uHVLk-00058E-SQ; Tue, 20 May 2025 18:22:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1uHVLh-00042n-2C; Tue, 20 May 2025 18:22:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KIoiCc023106;
 Tue, 20 May 2025 22:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9p09lx
 +xxbHsNO/bXtu8ToIhAFds31gXqfLJZrp+Zys=; b=clcib5BzFCwRIG9wOrbQ8d
 TRGdg9JgaCPrXjOKZuI/CIVl1JTuitNpvGhd4suFFZW9F2/HJ4fgw8aH3mYY6BQB
 ERk+jD5/btw91Tb/9q9cZndvO27ARrJwq5S5Xeije78Zmg+gf9QC3k5fA/3F2sLc
 aG4jhx+Dv0w8E1Q3D6+4RMmTYU+a8yP9OUeqbrlaLmgWtV36LD3VJYXaE/46iFsW
 ICLf4Q3TD/pPrimtQFtrxloweEeFtnutCsukHVaV1s+YKE55s/2btNKy/VYxsyIh
 xfqifwAQtAD8ljriMgQEM8WGPLMzSV3txwaNnL3uiJtoyXO2WSe3UW1XmYntQ4uQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ryc88un0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 22:21:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54KMLgQu007504;
 Tue, 20 May 2025 22:21:42 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ryc88umv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 22:21:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KKOXi3031996;
 Tue, 20 May 2025 22:21:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmq192u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 22:21:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54KMLepL29754034
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 22:21:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBC0B58058;
 Tue, 20 May 2025 22:21:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E22B458059;
 Tue, 20 May 2025 22:21:37 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 May 2025 22:21:37 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 20 May 2025 23:21:37 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>, Tyrone Ting
 <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Kyle Evans
 <kevans@freebsd.org>, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, Alexandre Iooss
 <erdnaxe@crans.org>, Laurent Vivier <lvivier@redhat.com>, Daniel Henrique
 Barboza <danielhb413@gmail.com>, Warner Losh <imp@bsdimp.com>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-rust@nongnu.org, qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 11/17] gdbstub: Try unlinking the unix socket before
 binding
In-Reply-To: <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-12-alex.bennee@linaro.org>
 <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru>
Message-ID: <56e0a35b5c53b416db130c414cd0f3d6@linux.ibm.com>
X-Sender: iii@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XaCJzJ55 c=1 sm=1 tr=0 ts=682d0077 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=dwixPFO5EDRWQakTH6kA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QJsZVEz1xESpOME9ciwkwrUVa51ecEg8
X-Proofpoint-ORIG-GUID: vjLgG9uT6KzjuiWAx3FmejLsrItBt8S7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE3OSBTYWx0ZWRfX8YoPQ28a7zAS
 CbItkAD0cvQsjLQmlffpmzla3j+JN2Vn2028nFIMAQT0COKRNgoAWu/ju0BZnDZFxWDqAfu8Iaj
 cP3KlFb/TlArfEx2uVH93g8aS1g68STHinNeGAGvz3ky+3p78REG9tf6//EjMJVBwF1+N+FAJ07
 6DnkDviEHi7beZ9kVxfUv5OasyzWm3wg4+Fpi+6d8YQMPQJvBPgzuKwXtGefeFgmUUVmHP+pdp7
 DMabT8ty6Xvbou658amxDMjxhKLDR05eKq1D4+xMexhQUXPOWiKaN8AfRLtwEVDmZmyfQYCnygC
 /rZeZxpOndKHOJDhIT0D5lCos8KEhJwgD8CrZNhNbhIgNP8f2OwpXAnfTFRiua6etaVbQ7cw2Q8
 2HbLgjwbPhkjIQ1/1Jq7Whwqvj2+KNgZjxqYKBzClbAXBTsASQC/G05mZ2ar7EhnLSLl5GS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_10,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505200179
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

On 2025-05-20 15:50, Michael Tokarev wrote:
> 07.02.2025 18:31, Alex Bennée wrote:
>> From: Ilya Leoshkevich <iii@linux.ibm.com>
>> 
>> In case an emulated process execve()s another emulated process, bind()
>> will fail, because the socket already exists. So try deleting it. Use
>> the existing unix_listen() function which does this. Link qemu-user
>> with qemu-sockets.c and add the monitor_get_fd() stub.
>> 
>> Note that it is not possible to handle this in do_execv(): deleting
>> gdbserver_user_state.socket_path before safe_execve() is not correct,
>> because the latter may fail, and afterwards we may lose control.
> 
> Please note: this is linux-user stuff, which is usually linked 
> statically.
> By linking it with qemu-sockets, we basically broke static linking, 
> because
> qemu-sockets uses getaddrinfo() &Co.  The previous code, I think, was 
> there
> for a reason, - to avoid this linkage.
> 
> How do you think about reverting this one and addressing the original
> problem without using qemu-sockets?
> 
> Alternatively, it might be possible to split qemu-sockets.c into 
> unix-related
> stuff and generic stuff.
> 
> Thanks,
> 
> /mjt

I can split it.

However, wasn't it already broken in this regard?
With fccb744f41c69fec6fd92225fe907c6e69de5d44^ I get:

[2/2] Linking target qemu-s390x
/usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function 
`g_get_user_database_entry':
(.text+0xeb): warning: Using 'getpwnam_r' in statically linked 
applications requires at runtime the shared libraries from the glibc 
version used for linking
/usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically 
linked applications requires at runtime the shared libraries from the 
glibc version used for linking
/usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically 
linked applications requires at runtime the shared libraries from the 
glibc version used for linking

This comes from glib, but the ultimate result is still the same.

Also, what are the symptoms of the breakage? IIUC as long as execution
does not reach getaddrinfo(), which it in this case should not, because
it is used only on inet paths, there should not be any issues, right?

In any case, the new warning is annoying and I better fix it for this
reason alone.

