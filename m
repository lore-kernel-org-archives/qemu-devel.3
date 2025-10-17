Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FBDCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 18:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9oxa-0002ON-Qo; Fri, 17 Oct 2025 14:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9oxV-0002O3-0G; Fri, 17 Oct 2025 14:13:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9oxO-0006r2-8C; Fri, 17 Oct 2025 14:13:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HDcTRb001444;
 Fri, 17 Oct 2025 18:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=2XIPW68tCzsEnBieEeo99+dw8vO4R0
 DtCfu3qUt40ew=; b=JsYYn5BqpOHYK0wYGLy89W6wTGJmI6K7WfbaZmy0uJzx4x
 6G3Yn8UOb2dZJzuNU9+c2OTsKvYoU7O0zCrgFYUJ2D7l9WOCdBKHhhEYk/0ks1Bf
 2wF5FDHwuPLWIflNcNEmjcGDcnbNuXq148p2y0yOLO3CkGvuqJ93JDTchvaYVSYj
 e+HnIy64BgXDiCamtiAiThxDWATllQi2VWpG4TrXoCcmP3gOhfSFWDZreLyNO1kA
 Hd3bUCPIlIE3LO7iVEqFTPAAwftIaQPmfSx30QbP2C0OOm+egW4bb9yzG86Jh9Js
 Mii/Iu0/KNeyqjSf6F0/qq0gNM7XkAomC7aQeCgw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8fb0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:13:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HI6HHi024791;
 Fri, 17 Oct 2025 18:13:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8fb0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:13:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59HI88Wp018823;
 Fri, 17 Oct 2025 18:13:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn6ttd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 18:13:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HIDTIh55902552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 18:13:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0D672004D;
 Fri, 17 Oct 2025 18:13:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49CC720040;
 Fri, 17 Oct 2025 18:13:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.220.85])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 18:13:25 +0000 (GMT)
Date: Fri, 17 Oct 2025 23:43:23 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 4/8] hw/ppc: Preserve memory regions registered for
 fadump
Message-ID: <5wyqyl4rgvro52s6xxkygd32azntsooqhoyknvyd5afkqrdpwd@ol7hymxsmodl>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-5-adityag@linux.ibm.com>
 <e032c9c2-1df3-40db-9d74-4a115f612da4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e032c9c2-1df3-40db-9d74-4a115f612da4@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tj_NTMDVog6pKxwR_6hOPJnILh3-Qoq_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX4rNw7nBcz0D+
 uLuGH4tNg1MjCw/jy0EnG/pJb1dylcSjGkNu7xlbgdjhIqzz4FLipAa+VVmNL+c3NR/18YxOvnZ
 lsK6UCFTyXxzu40tkmV4ReShaJRsh6pucG/gNeatm0PTBFePjwrhOkYnW8SMmdLUHw4l6oZ/3vT
 3dg0vtnuZRkHAvbppXc+VxleMHTzEermP+Wyjf8ObTaBoT6aXjBa5ohAKAlieFcatKaAaMTqsPT
 ATpGZcV5OVwGe+vl+yNf+AWgUQ/0neZRS6d8RgQfiO7XFTZfN0ufe0GiyXhB2B5D0MsRe3yFRKy
 Wm7Oh5dLVnKGRxvYAyBrbuugpRMUCT8Yi1fb84H5reTlowFY9MTF9SQHXMlDDEoBmnmn+iw69Qg
 sXNnoSFzg0zd+Cbmt2TziNLRqO4WCg==
X-Proofpoint-GUID: yAw7Bemu84JdKt8Y8RNJ1BhM4O3exH1T
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f2874f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HVEMHGV9u8Dng3hu1ysA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 25/10/17 06:36PM, Sourabh Jain wrote:
> 
> 
> On 23/03/25 23:10, Aditya Gupta wrote:
> > <...snip...>
> > +    /*
> > +     * Optimisation: Skip copy if source and destination are same
> > +     * (eg. param area)
> > +     */
> > +    if (src_addr != dest_addr) {
> > +        /*
> > +         * Using 'g_try_malloc' as the source length is coming from kernel,
> > +         * which can be invalid/huge, due to which allocation can fail
> > +         */
> > +        copy_buffer = g_try_malloc(src_len + 1);
> 
> The region size could be in GBs. I think it is better to do it in chunks.

Sure Sourabh, will do in chunks of 32MB in v5.

> 
> And don't we need to free the copy_buffer?

No, since I declare it as 'g_autofree', so it's freed automatically at
all exits.

> 
> > +        if (copy_buffer == NULL) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                "FADump: Failed allocating memory (size: %ld) for copying"
> > +                " reserved memory regions\n", src_len);
> > +
> > +            return false;
> > +        }
> > +
> > +        /* Copy the source region to destination */
> > +        io_result = address_space_read(default_as, src_addr, attrs,
> > +                copy_buffer, src_len);
> > +        if ((io_result & MEMTX_DECODE_ERROR) ||
> > +            (io_result & MEMTX_ACCESS_ERROR)) {
> > +            /*
> > +             * Invalid source address is not an hardware error, instead
> > +             * wrong parameter from the kernel.
> > +             * Return true to let caller know to continue reading other
> > +             * sections
> > +             */
> > +            region->error_flags = FADUMP_ERROR_INVALID_SOURCE_ADDR;
> > +            region->bytes_dumped = 0;
> > +            return true;
> > +        } else if (io_result != MEMTX_OK) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                "FADump: Failed to read source region in section: %d\n",
> > +                region->source_data_type);
> > +
> > +            return false;
> > +        }
> > +
> > +        io_result = address_space_write(default_as, dest_addr, attrs,
> > +                copy_buffer, src_len);
> > +        if ((io_result & MEMTX_DECODE_ERROR) ||
> > +            (io_result & MEMTX_ACCESS_ERROR)) {
> > +            /*
> > +             * Invalid destination address is not an hardware error,
> > +             * instead wrong parameter from the kernel.
> > +             * Return true to let caller know to continue reading other
> > +             * sections
> 
> Logging MEMTX_DECODE_ERROR would help identify kernel bugs. I think
> we should log this for both read and write.

Makes sense. Will do.

> 
> > +             */
> > +            region->error_flags = FADUMP_ERROR_INVALID_DEST_ADDR;
> > +            region->bytes_dumped = 0;
> 
> Seems like caller is already setting bytes_dump to 0. But even if you wanna
> do here.
> How about setting region->bytes_dumped = 0 early to avoid setting at
> multiple
> places?
> 
> In cases you need to free the copy_buffer I recommend having an exit label
> in this function.

As we declare it as 'g_autofree', 'g_free' will automatically get
invoked when the variable goes out of scope.

> 
> > +            return true;
> > +        } else if (io_result != MEMTX_OK) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                "FADump: Failed to write destination in section: %d\n",
> > +                region->source_data_type);
> > +
> > +            return false;
> > +        }
> > +    }
> > +
> > <...snip...>
> > +            fdm->rgn[i].error_flags =
> > +                cpu_to_be16(FADUMP_ERROR_INVALID_DATA_TYPE);
> > +        }
> > +    }
> > +
> > +    return true;
> 
> This function only returns true. Since caller has some action when this
> function
> returns false I am considering there is something wrong in this function.
> 
> If this suppose to return true always then lets not have return at all.

Agreed return type is of no use as of this patch. The return type being
bool is needed when CPU register saving is implemented, where we return
false, signalling a HW error that we failed to save registers.

Thanks,
- Aditya G


