Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FFCEB28D2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 06:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voFgC-0002DG-KO; Fri, 06 Feb 2026 01:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1voFgA-0002D3-Kb; Fri, 06 Feb 2026 01:50:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1voFfz-00035P-T5; Fri, 06 Feb 2026 01:50:49 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615IHMW1007214;
 Fri, 6 Feb 2026 06:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FuQV8D
 CMWgcyMXVyEw1PhdffkIs/2kBoDbCz2++kr+0=; b=kBy5bhGX+gzUwEPIStySJn
 BG6Iiua9UzKV0biE/jzYFS0auqppUSS0FuJYAL8woDU4wmfmHMq0mm1yl8kmct6H
 Y3JYFYNqU79W/r93xTUqj+/+zMvjLxXXtS/rG/X+FpJtAyzGfhB306Qtv+p2IUDV
 9p4BeAM/L7BJMk4GvCb2SPbEM439MDxQQaQEI7QKsVHPL3gW0o68vy2xQz1l0HUN
 Jn0GYvdFXV2LTkxWasgNN4kDqqUAAP4RDFRxdro1ghcTKSvHjbin22PODhxq0XEZ
 Z5jGl0GobBaC8+Eygnvcf8ipH3ardmWnkuUit5gtbVXVAruc5dpqPjXOy8P5/lTA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6tdk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 06:50:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61641gwI027348;
 Fri, 6 Feb 2026 06:50:40 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs1mshp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Feb 2026 06:50:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6166oKNH57737674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Feb 2026 06:50:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6DC058043;
 Fri,  6 Feb 2026 06:50:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5494158061;
 Fri,  6 Feb 2026 06:50:39 +0000 (GMT)
Received: from [9.61.249.62] (unknown [9.61.249.62])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Feb 2026 06:50:39 +0000 (GMT)
Message-ID: <b507e8c4-47c8-44fb-a7fc-6239e029cd56@linux.ibm.com>
Date: Fri, 6 Feb 2026 00:50:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260119181630.GA834718@fedora>
 <eb9693ae-6aae-4599-8c8c-22268357d2c0@linux.ibm.com>
 <20260203211222.GB449076@fedora>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260203211222.GB449076@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6bCWRtzKpeOjOhNYJVxZgIIRXGHMcd2q
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69858f41 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=p0WdMEafAAAA:8
 a=ffmRC70N9jPPMEwvakIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6bCWRtzKpeOjOhNYJVxZgIIRXGHMcd2q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAzNiBTYWx0ZWRfX6af2JbN7tniz
 CLMK3VANZ9mgRc8atxTOTeXDfQvzRFofN6RoCjuOsSm7axDPu01aqeht2Bw2ikab/JOR9TK7JRf
 LHZSIIGw4H7xKDrRbPj/D6JMNxxSJ4/0Sj5Qw2jHS5gXlIMXraNsVuWxhw1cW11UAh3hkxWHtqV
 d0PDyjUh2LwkB0U5bm2OqPOyWGO9s8hwYvJnCw7cTuAWsZ0A7t7rFS6G1cTxPVbPdpLiDxsTyaL
 6fmncqFLDbKXK+8XkEh7ZjhNaD9V0tOzQcmM52gvfVRVk56awEt87G0hrBGHRBzvSZYEP2SnUxL
 z8e7AjbQBKj/qyLUGQL02HerfGPKxeklPr0MecdOgD4sIXpOSt5UeWhwBT8bYMpvenc/2syOezN
 tZGyP8b1r/kt2kq8ygvm21zL5MdJipg6x+x6s31v6ekg/8+HGjpcWXz2MCh/9JD+bRqwHR0T2MI
 tn4PSPfxFJRQgx47esA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_01,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060036
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/3/2026 3:12 PM, Stefan Hajnoczi wrote:
> On Fri, Jan 23, 2026 at 01:15:04PM -0600, JAEHOON KIM wrote:
>> On 1/19/2026 12:16 PM, Stefan Hajnoczi wrote:
>>> On Tue, Jan 13, 2026 at 11:48:21AM -0600, Jaehoon Kim wrote:
>>>> We evaluated the patches on an s390x host with a single guest using 16
>>>> virtio block devices backed by FCP multipath devices in a separate-disk
>>>> setup, with the I/O scheduler set to 'none' in both host and guest.
>>>>
>>>> The fio workload included sequential and random read/write with varying
>>>> numbers of jobs (1,4,8,16) and io_depth of 8. The tests were conducted
>>>> with single and dual iothreads, using the newly introduced poll-weight
>>>> parameter to measure their impact on CPU cost and throughput.
>>>>
>>>> Compared to the baseline, across four FIO workload patterns (sequential
>>>> R/W, random R/W), and averaged over FIO job counts of 1, 4, 8, and 16,
>>>> throughput decreased slightly (-3% to -8% for one iothread, -2% to -5%
>>>> for two iothreads), while CPU usage on the s390x host dropped
>>>> significantly (-10% to -25% and -7% to -12%, respectively).
>>> Hi Jaehoon,
>>> I would like to run the same fio benchmarks on a local NVMe drive (<10us
>>> request latency) to see how that type of hardware configuration is
>>> affected. Are the scripts and fio job files available somewhere?
>>>
>>> Thanks,
>>> Stefan
>> Thank you for your reply.
>> The fio scripts are not available in a location you can access, but there is nothing particularly special in the settings.
>> I’m sharing below the methodology and test setup used by our performance team.
>>
>> Guest Setup
>> ----------------------
>> - 12 vCPUs, 4 GiB memory
>> - 16 virtio disks based on the FCP multipath devices in the host
>>
>> FIO test parameters
>> -----------------------
>> - FIO Version: fio-3.33
>> - Filesize: 2G
>> - Blocksize: 8K / 128K
>> - Direct I/O: 1
>> - FIO I/O Engine: libaio
>> - NUMJOB List: 1, 4, 8, 16
>> - IODEPTH: 8
>> - Runtime (s): 150
>>
>> Two FIO samples for random read
>> --------------------------------
>> fio --direct=1 --name=test --numjobs=16 --filename=base.0.0:base.1.0:base.2.0:base.3.0:base.4.0:base.5.0:base.6.0:base.7.0:base.8.0:base.9.0:base.10.0:base.11.0:base.12.0:base.13.0:base.14.0:base.15.0 --size=32G  --time_based --runtime=4m --readwrite=randread --ioengine=libaio --iodepth=8 --bs=8k
>> fio --direct=1 --name=test --numjobs=4  --filename=subw1/base.0.0:subw4/base.3.0:subw8/base.7.0:subw12/base.11.0:subw16/base.15.0                                                                        --size=8G   --time_based --runtime=4m --readwrite=randread --ioengine=libaio --iodepth=8 --bs=8k
>>
>>
>> additional notes
>> ----------------
>> - Each file is placed on a separate disk device mounted under subw<n> as specified in --filename=....
>> - We execute one warmup run, then two measurement runs and calculate the average
> Hi Jaehoon,
> I ran fio benchmarks on an Intel Optane SSD DC P4800X Series drive (<10
> microsecond latency). This is with just 1 drive.
>
> The 8 KiB block size results show something similar to what you
> reported: there are IOPS (or throughput) regressions and CPU utilization
> improvements.
>
> Although the CPU improvements are welcome, I think the default behavior
> should only be changed if the IOPS regressions can be brought below 5%.
>
> The regressions seem to happen regardless of whether 1 or 2 IOThreads
> are configured. CPU utilization is different (98% vs 78%) depending on
> the number of IOThreads, so the regressions happen across a range of CPU
> utilizations.
>
> The 128 KiB block size results are not interesting because the drive
> already saturates at numjobs=1. This is expected since the drive cannot
> go much above ~2 GiB/s throughput.
>
> You can find the Ansible playbook, libvirt domain XML, fio
> command-lines, and the fio/sar data here:
>
> https://gitlab.com/stefanha/virt-playbooks/-/tree/aio-polling-efficiency
>
> Please let me know if you'd like me to rerun the benchmark with new
> patches or a configuration change.
>
> Do you want to have a video call to discuss your work and how to get the
> patches merged?
>
> Host
> ----
> CPU: Intel Xeon Silver 4214 CPU @ 2.20GHz
> RAM: 32 GiB
>
> Guest
> -----
> vCPUs: 8
> RAM: 4 GiB
> Disk: 1 virtio-blk aio=native cache=none
>
> IOPS
> ----
> rw        bs   numjobs iothreads iops   diff
> randread  8k   1       1         163417 -7.8%
> randread  8k   1       2         165041 -2.4%
> randread  8k   4       1         221508 -0.64%
> randread  8k   4       2         251298 0.008%
> randread  8k   8       1         222128 -0.51%
> randread  8k   8       2         249489 -2.6%
> randread  8k   16      1         230535 -0.18%
> randread  8k   16      2         246732 -0.22%
> randread  128k 1       1          17616 -0.11%
> randread  128k 1       2          17678 0.027%
> randread  128k 4       1          17536 -0.27%
> randread  128k 4       2          17610 -0.031%
> randread  128k 8       1          17369 -0.42%
> randread  128k 8       2          17433 -0.071%
> randread  128k 16      1          17215 -0.61%
> randread  128k 16      2          17269 -0.22%
> randwrite 8k   1       1         156597 -3.1%
> randwrite 8k   1       2         157720 -3.8%
> randwrite 8k   4       1         218448 -0.5%
> randwrite 8k   4       2         247075 -5.1%
> randwrite 8k   8       1         220866 -0.75%
> randwrite 8k   8       2         260935 -0.011%
> randwrite 8k   16      1         230913 0.23%
> randwrite 8k   16      2         261125 -0.01%
> randwrite 128k 1       1          16009 0.094%
> randwrite 128k 1       2          16070 0.035%
> randwrite 128k 4       1          16073 -0.62%
> randwrite 128k 4       2          16131 0.059%
> randwrite 128k 8       1          16106 0.092%
> randwrite 128k 8       2          16153 0.048%
> randwrite 128k 16      1          16102 -0.0091%
> randwrite 128k 16      2          16160 0.048%
>
> IOThread CPU usage
> ------------------
> iothreads before  after
> 1         98.7    95.81
> 2         78.43   66.13
>
> Stefan

Hello Stefan,

Thank you very much for your effort in running these benchmarks.
The results show a pattern very similar to what our performance team
observed.

I fully agree with the 5% threshold for the default behavior.
However, we need an approach that balances the current performance
oriented polling scheme with CPU efficiency.

I found that relying on grow/shrink parameters was too limited to
achieve these results. This is why I've adjusted the process using a
weight-based grow/shrink approach to ensure the polling window remains
robust against jitter. Specifically, it avoids abrupt resets to zero
by implementing a gradual shrink rather than an immediate reset, even
when device latency exceeds the threshold.

As seen in both your results and our team's measurements, this may lead
to a bit of a performance trade-off, but it provides a reasonable
balance for CPU-sensitive environment.

Thank you for suggesting the video call and I am also looking forward to
hearing your thoughts. I'm on US Central Time. Except for Tuesday, I can
adjust my schedule to a time that works for you.

Please let me know your preferred time.

Regards,
Jaehoon Kim


