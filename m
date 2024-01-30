Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A5EC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 13:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUnyr-0001Yg-K7; Tue, 30 Jan 2024 08:16:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUnyp-0001YD-3A
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:16:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rUnyn-0002cd-7i
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 08:16:46 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UDCwxL025508; Tue, 30 Jan 2024 13:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Pupspro2xSFBq7xvLRbsWXYXKi3p1E+RHGH6K4ecu2c=;
 b=Q2TPjvxBSxFCVvJRnFIuc/raK0HEO5c5v7TxjSksL65wRWRoAMK2kL4qZXFHA/95kK3w
 juGUmh6IEA8q6p4B1Bi3v8wvzDxI/82UXDR6xHDQPKY1Vg6bkh+fCUjx3fVk4dMBnhNc
 MAM6Hn9umIeEi1LWIfHG5Q+4hRbyg7wwee6zknkkP/AV9Iq0f/WbAQ7svbW8PWJw7eTf
 JOweMsemj6B9ZQzvc23yuywXxuwZh44TqLZzOvXaZ6/BiWpPna3FWdhxWcIPlH13XnSC
 OWNqBTh6ZAlxzIYJqlU3ZqZBqCEPoVypUS3D+IiH5aSITEm+9wGCWjzffJMdvawAAFK9 Mw== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy1sx838j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:16:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40UBkjIs007179; Tue, 30 Jan 2024 13:16:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwev26ehf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jan 2024 13:16:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40UDGd6727919024
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jan 2024 13:16:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE17F20043;
 Tue, 30 Jan 2024 13:16:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93F4F2004D;
 Tue, 30 Jan 2024 13:16:39 +0000 (GMT)
Received: from black (unknown [9.155.200.166])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 30 Jan 2024 13:16:39 +0000 (GMT)
Date: Tue, 30 Jan 2024 14:16:36 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>
Subject: Re: [PATCH v3 26/33] *-user: Deprecate and disable -p pagesize
Message-ID: <r6og7ehj5ioy2stuiscmx3klvcxutdne3kukblb4wxrpbvwjqe@7fctqy6qgwxj>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-27-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102015808.132373-27-richard.henderson@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LSgGtGhDGazFYvn987uDq5qiw1su0AmM
X-Proofpoint-ORIG-GUID: LSgGtGhDGazFYvn987uDq5qiw1su0AmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=691
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300097
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, Jan 02, 2024 at 12:58:01PM +1100, Richard Henderson wrote:
> This option controls the host page size.  From the mis-usage in
> our own testsuite, this is easily confused with guest page size.
> 
> The only thing that occurs when changing the host page size is
> that stuff breaks, because one cannot actually change the host
> page size.  Therefore reject all but the no-op setting as part
> of the deprecation process.
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/about/deprecated.rst |  7 +++++++
>  docs/user/main.rst        |  3 ---
>  bsd-user/main.c           |  9 +++++----
>  linux-user/main.c         | 11 ++++++-----
>  4 files changed, 18 insertions(+), 12 deletions(-)

[...]

> diff --git a/linux-user/main.c b/linux-user/main.c
> index 5f217cc2a8..9ba4dc5872 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -332,10 +332,11 @@ static void handle_arg_ld_prefix(const char *arg)
>  
>  static void handle_arg_pagesize(const char *arg)
>  {
> -    qemu_host_page_size = atoi(arg);
> -    if (qemu_host_page_size == 0 ||
> -        (qemu_host_page_size & (qemu_host_page_size - 1)) != 0) {
> -        fprintf(stderr, "page size must be a power of two\n");
> +    unsigned size, want = qemu_real_host_page_size();
> +
> +    if (qemu_strtoui(arg, NULL, 10, &size) || size != want) {
> +        error_report("Deprecated page size option cannot "
> +                     "change host page size (%u)", want);
>          exit(EXIT_FAILURE);

I wonder if this should rather be a warning for one release?

[...]

