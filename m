Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0236C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 04:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqQ6D-0008Gm-90; Tue, 17 Sep 2024 00:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sqQ6B-0008FN-88; Tue, 17 Sep 2024 00:45:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sqQ66-0006G0-QI; Tue, 17 Sep 2024 00:45:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48GIUxhm031850;
 Tue, 17 Sep 2024 04:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=pp1; bh=
 L+ioge3hHilHAMEc3xSLEFinwBZjrpPAdbBE4tt0rdQ=; b=Ok5pVjNKWmBxELA+
 ttLLt7WpDdWpWyuEcCMYk/J2+cKMeOIkWBv+SX5FtydQl0tDaBmmIhV8E8AZlRfv
 CBRDPDY/7X1emM2bFo8Z/N36MfeohshrklmKhoDLmwEmpQLOdM2MF7H5hzcfLG9r
 ngbx3wJLbEzv4fIhZfVNCGMtx2R07VH6Tx6EfboOGVeOC98x1GZOZT83nT0iqaB/
 24orpIsqF+/TXSapP5lUxABpUeReFdPLVNbCEox7dcsq0IWcgSn8snZNyd4zB+/t
 hKUWZZopEESFXocmV26R/tE0hC/zuSWo/drBhphBkcVjtH0nv/H8AD6sBiSu6rJ2
 Ume+sQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj5u16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:45:52 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48H4jpgL015634;
 Tue, 17 Sep 2024 04:45:51 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3uj5u12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:45:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48H0fDL6001915;
 Tue, 17 Sep 2024 04:45:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nmtukbew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 04:45:50 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48H4jorJ41615734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 04:45:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C35258056;
 Tue, 17 Sep 2024 04:45:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 407A95805A;
 Tue, 17 Sep 2024 04:45:48 +0000 (GMT)
Received: from [9.109.242.165] (unknown [9.109.242.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Sep 2024 04:45:47 +0000 (GMT)
Message-ID: <811bc24f-f3d7-4794-a94b-b4cb5df15b97@linux.ibm.com>
Date: Tue, 17 Sep 2024 10:15:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix inequality check in do_lstxv_X
To: Fabiano Rosas <farosas@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, qemu-stable@nongnu.org
References: <20240913043827.914457-1-harshpb@linux.ibm.com>
 <87r09n23hn.fsf@suse.de>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87r09n23hn.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y5GwyNa01DGgbw6SF5e-eJ6themzrKa8
X-Proofpoint-GUID: GVmoEShkdhXm22VV8npaKWU7DdO0xJG8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_01,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170030
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Fabiano,

On 9/13/24 17:02, Fabiano Rosas wrote:
> Harsh Prateek Bora <harshpb@linux.ibm.com> writes:
> 
>> This fix was earlier introduced for do_lstxv_D form with 2cc0e449d173
>> however got missed for _X form. This patch fixes the same.
>>
>> Cc: qemu-stable@nongnu.org
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Fixes: 70426b5bb738 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   target/ppc/translate/vsx-impl.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
>> index 40a87ddc4a..a869f30e86 100644
>> --- a/target/ppc/translate/vsx-impl.c.inc
>> +++ b/target/ppc/translate/vsx-impl.c.inc
>> @@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext *ctx, arg_PLS_D *a,
>>   
>>   static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
>>   {
>> -    if (paired || a->rt >= 32) {
>> +    if (paired || a->rt < 32) {
>>           REQUIRE_VSX(ctx);
>>       } else {
>>           REQUIRE_VECTOR(ctx);
> 
> Hi Harsh,
> 
> Seems I was quicker than you =)
> 
> https://lore.kernel.org/r/20240911141651.6914-1-farosas@suse.de
> 
> I'll give my RB and leave up to the maintainers which patch to take:
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks, I missed looking at your patch earlier.
I would vote for your patch though.

regards,
Harsh

