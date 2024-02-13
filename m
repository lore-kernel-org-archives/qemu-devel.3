Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE82C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 14:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtpn-0007Br-EE; Tue, 13 Feb 2024 09:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rZohX-00086f-RX; Tue, 13 Feb 2024 04:03:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.vnet.ibm.com>)
 id 1rZohW-0001ZF-1L; Tue, 13 Feb 2024 04:03:39 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41D8vbRw001977; Tue, 13 Feb 2024 09:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/ibc3XYO895FcZOAm5aWMkz4jizIqU3yBbWFLxS61cA=;
 b=TpK2inqmkQBKYalbwF5jj4IqKWpbSN5rG29gwKl9cKaj+mcxUKbcuJOJRcjzEqR5kUF9
 nHB7GbdBbN1GsZZait1zebpIm6bDDpfYcVK6atkIvkyz2MTZSJN/ZsFmz9HDDDuwVEA2
 iE1w0dl74tsLBg2hsybJ+Nhwqddm6SuGLnUxr+0MMtjA/qfCTU5MIRbb0/sbt6+KhsxC
 37dCnl1JcwuzVnfl+a/DcdRIGRyw2bwE9b2QjK7UMdK5+3UnzF8x5gV/TScufABN/zgh
 28YhgbxLKvyIEpEFPRw2aVuF03HZEN/9qtZ/dvhoGY8tFavKLNMv5dfcxtEeMChPLWot WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w85car5ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 09:03:33 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41D8x8cl004777;
 Tue, 13 Feb 2024 09:03:33 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w85car5bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 09:03:33 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41D6kMM9009920; Tue, 13 Feb 2024 09:03:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p62nv7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Feb 2024 09:03:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41D93Rh131916512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 13 Feb 2024 09:03:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87D8E2004E;
 Tue, 13 Feb 2024 09:03:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EBCB20040;
 Tue, 13 Feb 2024 09:03:26 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 13 Feb 2024 09:03:25 +0000 (GMT)
Message-ID: <29d66265-c613-42ef-9a1c-77a295f9bb7c@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2024 14:33:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Move add and subf type fixed-point
 arithmetic instructions to decodetree
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com
Cc: harshpb@linux.ibm.com, sbhat@linux.ibm.com
References: <20240209113532.580983-1-rathc@linux.ibm.com>
 <f07f918e-d7b4-41bd-88eb-ddb2bd96dd73@linaro.org>
From: Chinmay Rath <rathc@linux.vnet.ibm.com>
In-Reply-To: <f07f918e-d7b4-41bd-88eb-ddb2bd96dd73@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: P5xfT9zpdHVmUIKVxBd6LSw53NmVG1kf
X-Proofpoint-ORIG-GUID: nQvFy593lrQ24Fmda82RCr-5sizXf9yF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=798 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130070
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=rathc@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 13 Feb 2024 09:32:27 -0500
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

Hi Richard,

On 2/13/24 03:51, Richard Henderson wrote:
> On 2/9/24 01:35, Chinmay Rath wrote:
>> +&Z23_tab_cy     rt ra rb cy
>> +@Z23_tab_cy     ...... rt:5 ra:5 rb:5 cy:2 ........ . &Z23_tab_cy
> ...
>> +ADDEX           011111 ..... ..... ..... .. 10101010 -  @Z23_tab_cy
> ...
>> +static bool trans_ADDEX(DisasContext *ctx, arg_Z23_tab_cy *a)
>> +{
>> +    gen_op_arith_add(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], 
>> cpu_gpr[a->rb],
>> +                     cpu_ov, cpu_ov32, true, true, false, false);
>> +    return true;
>> +}
>
> CY != 0 is reserved.
>
> While you could diagnose this in trans_ADDEX, it seems cleaner to 
> simply match 00 in the CY field until a future ISA defines something 
> else.  All that is required is a comment in the decodetree entry.
>
> # Z23-form, with CY=0; all other values for CY are reserved.
> # This works out the same as X-form.
> ADDEX    011111 ..... ..... ..... 00 10101010 -   @X
>
Thanks for your review comments.

I shall update as suggested in v2.

Regards,

Chinmay

>
> r~

