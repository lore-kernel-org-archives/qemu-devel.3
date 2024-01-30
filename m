Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8877FC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnvn-0008QR-PC; Tue, 30 Jan 2024 08:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUnvh-0008PF-0i
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:13:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUnvd-00021q-PR
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:13:31 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UDCEUR029440; Tue, 30 Jan 2024 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=4K3TbwvM1oyBp5/YdXkEoU9ZZscaYKBB1FX7NKgAsIY=;
 b=aRX7tBjTH64HIEG+Ml+nm3TTCfuB1XbYvV1DiKH77Q+MMasSiEGqgXByoFk5dd666un2
 WNKeLzoC0tgXegctCp8hpd3XxIZ/S7slsc8SNC7ySCmhpiVrKiGQBC8D5Cjj/ioJXsOK
 2tqHBWdF3XPoei71Uyw5z2hPkyFqyCCOzcRBqEA58+n1gv0xKAunW8bBZlT/ryWmt/Ru
 MNEj3V8/FGC3BaHvaNW8qtunsRznHAEQnLgZP98VM1kgTcaMdSXJkH7UBDeTvxKXStUz
 1YVURbGS7dIsh91bItfk9m+OfaDa4piOMxCi/TQve3tNwOnBxu/Mkci0zYqlRc42whqj Pg== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy1sp81c7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:13:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UCHMx6007168; Tue, 30 Jan 2024 13:13:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev26e0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:13:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UDDNQ661342164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 13:13:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84A6620049;
 Tue, 30 Jan 2024 13:13:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EA5C20040;
 Tue, 30 Jan 2024 13:13:23 +0000 (GMT)
Received: from black (unknown [9.155.200.166])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 13:13:23 +0000 (GMT)
Date: Tue, 30 Jan 2024 14:13:19 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 25/33] tests/tcg: Extend file in linux-madvise.c
Message-ID: <nh6ly2ton626edkc3nwcthrighpa3lopsdcmpk6wq4dbwrq5s7@3vpizdp2fpne>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-26-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102015808.132373-26-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FWdo_MFceeIUrv9QkUuMvt7iNUqZRMzB
X-Proofpoint-ORIG-GUID: FWdo_MFceeIUrv9QkUuMvt7iNUqZRMzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300097
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 02, 2024 at 12:58:00PM +1100, Richard Henderson wrote:
> When guest page size > host page size, this test can fail
> due to the SIGBUS protection hack.  Avoid this by making
> sure that the file size is at least one guest page.

Maybe also mention PAGE_PASSTHROUGH?

> Visible with alpha guest on x86_64 host.

I had to apply (very hacky):

--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -803,7 +803,7 @@ int main(int argc, char **argv, char **envp)
      * The most efficient setting is to match the host.
      */
     host_page_size = qemu_real_host_page_size();
-    set_preferred_target_page_bits(ctz32(host_page_size));
+    set_preferred_target_page_bits(ctz32(host_page_size) + 1);
     finalize_target_page_bits();

in order to see this. Is there a way to set the guest page size from
the command line?

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/multiarch/linux/linux-madvise.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

