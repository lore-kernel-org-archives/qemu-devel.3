Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE56C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x53vp-0001Bj-NN; Fri, 11 Sep 2026 12:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x53vX-0001Ae-11
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:16:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x53vU-0006Ip-T5
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:16:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1aJP2127013; Fri, 11 Sep 2026 16:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+yNh47
 oGgxIKPiC/0lL9l4M8nCyv4kpB/s7uc1RDYS8=; b=RJWIXgvea7gJWE5G0u5ZxQ
 6B6Y4b+XFTGFmDPlSbM5Xm0IB23sFemtVRlQrPRU117t8mGlbUo6OS9NPmj+98K1
 hBMa8qz92oJM6uWIVnXM/eaR0Ksko4onhSfxQiQYW7vVf8A7sBro0M1pyoUAbzFn
 gKS7RDnmKyVHLu2vcwp7OvmnlaFd23gC4q+itjMFKlwXsyqsWwWLJSYXkK2pmWs5
 +pMUaZcSizoqG6KGMQVNBaNlpDMjY92G7qp5JnZnOzE0DXECvWrFaTyW8f5AER6N
 +VRYzTs9naEeKBPkFLFIBete5scV+uJsQPkX50Ovh/S+W+Y+M6fmyeCH+JpCSJzA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qvmsu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 16:16:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEo7Jf1834064; Fri, 11 Sep 2026 16:16:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvmhqbd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 16:16:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BGGORU53412310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 16:16:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A149A5805E;
 Fri, 11 Sep 2026 16:16:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 086A158051;
 Fri, 11 Sep 2026 16:16:24 +0000 (GMT)
Received: from [9.61.94.26] (unknown [9.61.94.26])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 16:16:23 +0000 (GMT)
Message-ID: <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
Date: Fri, 11 Sep 2026 12:16:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <20260904124604.2207440-103-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa4295b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=EUspDBNiAAAA:8
 a=wl9RqpJt35NfqXonl08A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: V3qiFixRyKesdcthTqdq8ttAlL640nEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfXwtHDuyRpfKkT
 yGQBuZ5yTKM6wEzblYsSuJE0bxSYL4ZUEYcyPNZ8cEmChJ+w68LVkmTaUgwWvGqIfVUuI4ZTGSP
 vdSQkIaAyHaLDqeiOzGB8EZ26sZnSSyeo2HAlTD+cMSZZMRVi4rKycoY7O86QbkfM80tiT34a07
 8wgEj7KJyNFMPIwNTyElBJJz/qG9kg7f8Fs2BtY/W1vtOF3GAVicsXlultVTUu+A3Hsd9ggHLgS
 SjdVWEBE8rR4qJbb/zdiZIDGRs00oNTLxECVKdm3yBUldq+ON0jCdj1aLKJVfsLqWDFDqVvjQTY
 RqRSNO2+DpkAMjq7Xz8zvFE85ex9f2AJV6YdbSMz+UFZ/jXC2+X1pSYWaPBeIRUh1ENjt3mJSXU
 73w0lnLBA5KgvpSbq/YDLjrZY80o5QsIvl5Rh2CzlR0c8NoxqtKBUxkbngVF1LgT53iSt9thXUj
 hL2X4vbpvOH4cdh2/Pw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyNCBTYWx0ZWRfXyeo+LT09qMn9
 X00zSML+ThD+YvwrE1e7YO/mdlVY1vfo42hNzz23eSCtlWCj70v18+SDld7r93Lxtpi0XSWj64g
 qNMdFnoY84D9q/t0rarEgs9Dq+AMdmM=
X-Proofpoint-GUID: V3qiFixRyKesdcthTqdq8ttAlL640nEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110224
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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



On 9/4/26 8:45 AM, Alex Bennée wrote:
> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> We have now implemented the same in meson directly, so no need to keep
> it on configure side. Also, we have no more Makefile consumers, so we
> don't need to export all those variables anymore.

(Thanks, Josh, for the bisect work that led to blaming this commit...)

...snip...

> @@ -1659,48 +1299,6 @@ fi
>   
>   echo "# Automatically generated by configure - do not modify" > Makefile.prereqs
>   
> -# Mac OS X ships with a broken assembler
> -if have_target i386-softmmu x86_64-softmmu && \
> -        test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
> -        test "$host_os" != "haiku" && \
> -        probe_target_compiler i386-softmmu; then
> -    subdirs="$subdirs pc-bios/optionrom"
> -    config_mak=pc-bios/optionrom/config.mak
> -    echo "# Automatically generated by configure - do not modify" > $config_mak
> -    echo "TOPSRC_DIR=$source_path" >> $config_mak
> -    write_target_makefile >> $config_mak
> -fi
> -
> -if have_target ppc-softmmu ppc64-softmmu && \
> -        probe_target_compiler ppc-softmmu; then
> -    subdirs="$subdirs pc-bios/vof"
> -    config_mak=pc-bios/vof/config.mak
> -    echo "# Automatically generated by configure - do not modify" > $config_mak
> -    echo "SRC_DIR=$source_path/pc-bios/vof" >> $config_mak
> -    write_target_makefile >> $config_mak
> -fi
> -
> -# Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
> -# (which is the lowest architecture level that Clang supports)
> -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
> -    GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
> -  write_c_skeleton
> -  do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
> -  has_z900=$?
> -  if [ $has_z900 = 0 ] || do_compiler "$target_cc" $target_cc_cflags -march=z10 -msoft-float -Werror -o $TMPO -c $TMPC; then
> -    if [ $has_z900 != 0 ]; then
> -      echo "WARNING: Your compiler does not support the z900!"
> -      echo "         The s390-ccw bios will only work with guest CPUs >= z10."
> -    fi
> -    subdirs="$subdirs pc-bios/s390-ccw"
> -    config_mak=pc-bios/s390-ccw/config-host.mak
> -    echo "# Automatically generated by configure - do not modify" > $config_mak
> -    echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
> -    echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_mak
> -    write_target_makefile >> $config_mak
> -  fi
> -fi
> -

Now we're unable to build the s390 bios used for boot (no idea about the 
state of the other items in pc-bios that were removed here too). Surely 
reverting this hunk (and its dependencies) won't be great based on the 
size of this pull request, so what's the preferred solution here?

Fearing the worst, I started converting to use meson directly (which is 
probably a noble goal anyway). I still don't have a workable image, as 
inheriting the common meson cc/ld flags exposes a bunch of other 
problems. Will keep poking, but I'd like to know if there's an 
easier/better option here?

Thanks,
Eric

