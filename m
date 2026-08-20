Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C6AC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 22:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxB4I-0005l9-6d; Thu, 20 Aug 2026 18:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB49-0005kW-Gh
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:16:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wxB47-0007rS-Hg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 18:16:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KK7ZGg250333
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2MPXZ7D/e9PSjB3nPi1GNR2NWNs0UUc/omjZdZZ+H+g=; b=dSCKNBwAcJL0Ez3z
 1voo0IbEN5qRuHQP0Y0cHn8+DmrJIso1Lt9DyiMB9crcZ2XD9niS6rooHI4Qpnxz
 3LS5PlwA5xFYNY+uFrCVDtBQSQyG07QJRpllMlwRdb3EzOoiF9SuciN/6gzaFeIW
 XdtjUDe9fa5r1qdtGizQi2aIWhmpWuC97PFrGudo6XU17nFIPm4CP070YMnCGvPK
 e3sp1Lg8XHVG0GMDAsRiTNK2Fucf1N2wdkXIIDNjEe+EF0XJiXZSJtaWUErHpZ1R
 CB5Ucs1d/II50e6W/okFMrg2oTJykvMaZ+rNlvn0AlMQigXTWRzYkYjxM78tFyiY
 v4eyAQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49btug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 22:16:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so521727a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 15:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787264208; x=1787869008; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2MPXZ7D/e9PSjB3nPi1GNR2NWNs0UUc/omjZdZZ+H+g=;
 b=j3kK61arGsaU18QmXUmnvOOtK7Pkeua0/q8YqcB7uax69yH4YP61XeLA4/hFYfG/vB
 eObqF8sq1HPQGTyYV+UjxGh7NQ+TQ0BzYIfWlD0dnB62Df8qMHB3R3exoIMKk4xjuXrD
 XA3eJmhCps9b4KIgihxMe/P9ehqrTxdueDlXiDaTkL4GvdUHqC+Zx6ZZcBrn+RDVu2yq
 YzZUUIs1SFpZHPzMFQ4LUIlzI3Fh50QHELY2feqTbhuQ0KfbD3N5N2VAmVTEtArInFUq
 GO5XlV3HHIyhDSJz2x2oZottuj2IVcPYnopDVGu60o7LMsZcb77tS64/05junpOIpvq/
 /UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787264208; x=1787869008;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2MPXZ7D/e9PSjB3nPi1GNR2NWNs0UUc/omjZdZZ+H+g=;
 b=RfBqlSmFWte5HJn3DRrhXCQOqJlTMbyCC1+m+RS5KkewTVDmqDDiw9lK/FKsu+qTs3
 CNbW5SRdt5HJYvv5J/5Y9OEaH4TWa850IQ2RzghVFUOrQh13n29qcf5aXsYySubBB47Z
 6UExDqeir0uBlwtoknaPx0GVrumc99zYGfqewk44i3n440gKi/1VeZ44PjtdruOUQjGA
 zrffLbN6Sv28uEtpvmBQAKJTq1w9fQm2eLmi/AhrzMhqy3ZQfsjgvIRII4YT6R4PfRhs
 hEqAJIWenKUFqGOO8ZX4mWEKMskO5Ipp+NR+Hh9xswi1JYywy9l6mF9L0lUIRNVhC3UP
 mUMQ==
X-Gm-Message-State: AFuF++kInmdT081V7Itvwisr4w81oh/Tqp4Q15U2U2QpyHHmQI8waKOM
 gGfPUFxNI8HrJErWvg/0X6mGBFjw2PlI6JsSH00p+45FGfyIoLbRTaMpHDD2gKfBbzZae9zmIas
 UBAvqiYSXRzYkCh7NY7ZxuC3zlj+OgQ3P/QpRGjWGTuAchEB+kil9/i3VvQ==
X-Gm-Gg: AR+sD10Hm+hewKRwNFr3o+stx0W/52qqb6uDnnhADWMQrU199ZeIIaADnNUy656eSac
 on4eKxEAwEByvaNK9XVezD0xZ1qrgk0EYlv5qkhQ3/z31YMaW7gL2ZudLOZoseRSnNYF4YIQ17s
 dIsg3V/ndCy2yMR3XjbmO1adiIB2FCwiiob2t5cIQ2/bLwbd1LVouYEA8cK0KAXh5ReqEyJLyiJ
 TOUl8pnf2ZX6hfViil9tP7oYyp1Degc1rTMHfm0cnsN3Cyvpe/lN75/OlL0U56EGWr+RaTTH9WI
 2itingca8nrkl/OWLCXodIZAkSju/EpPbyovPEun3gXPjqjTYrXttwBtfmJLaTM45kqhkftxQbC
 IDpeqk/6UN5phD9JAjDYabQPbvC2XruTSEa8aNheFPE0PHQdGgd7eofLZlo62kR9sgDIS
X-Received: by 2002:a17:90b:3d85:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-395c33ef91bmr3208102a91.1.1787264207252; 
 Thu, 20 Aug 2026 15:16:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3d85:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-395c33ef91bmr3207926a91.1.1787264206226; 
 Thu, 20 Aug 2026 15:16:46 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ae14162sm18727395c88.9.2026.08.20.15.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 15:16:45 -0700 (PDT)
Message-ID: <0a4c3e34-574a-484c-8617-3af587f080fa@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 15:16:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 00/28] hw/arm/smmuv3: Support Secure state for SMMUv3
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>,
 Chao Liu <chao.liu@processmission.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfXxezsLeWEjoZm
 0cVhOpPKBpgEMzKg/lTmXV4F/JmLXw+1RLGRUxNE139Y75CvOgtui4ZHYruuTeEZ4+Bzhwjulo9
 vokqn+LQ8HpYGD08uOxj2tmKpuAvpc0=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a877cd1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=fgrLqfBXAAAA:8 a=KKAkSRfTAAAA:8 a=ZYi_vuD_AAAA:8
 a=ehYRL7wMAAAA:20 a=EUspDBNiAAAA:8 a=uVuSfXj6EEEykST30esA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=_Ge82aPy-h_wFa7gWU4u:22 a=cvBusfyB2V15izCimMoJ:22 a=BPQQxL4JNPAPRa8Tzepp:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: J-YN_QbCGjIzLWQErbdcYcyaTCGnMCqA
X-Proofpoint-GUID: J-YN_QbCGjIzLWQErbdcYcyaTCGnMCqA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2NiBTYWx0ZWRfXwJrWeWpDGQSq
 eFDDYeHLBb6yAMHCuIdQRW1ZIapySGAoabSeDlkLIvsfNMdxIPRtp3yT9wXdO9L0o2hltJmwj5J
 uGF/Pzb0LD5fR5AnHoAZRV5lkzbG4Wym4d3Ne5yTWUHRkC4ns9g7i7MsFUTnKhPL9SqOk1Ev5Tv
 KpbYhyULvzUmuuLbvoYERhQWKwfpzsg7ipwXxP2Hf6VJrkReCN0rZEOB0cthGqZ4LND1fuYOdhD
 zUisJ4H4TWKbCBUBcdQb2HXpg+zcIHQHSQt0yrO0zrgmUEsDN7F2LpJMjj4sbD7ea/sZBCKyWp5
 FPa89NDAcmDDorIS7qspp2Lur9UtJkT5zKkL6cGOCreW8oD31gqhmvCjR2t0zkvL5lYdssHW2TX
 9HlJ3XvD9irQlAh/XeFksK4ilpJjKS8qX3W5S7hq0hxMWane+mgpcsF8W5xQUt8CIS3NdMxvb1Y
 uTX0o1+SIaPH5IuBeCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200166
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/13/2026 9:15 AM, Tao Tang wrote:
> Hi all,
> 
> This is v5 of the Secure SMMUv3 series.
> 
> Many thanks to everyone who reviewed the earlier versions. This version contains
> 28 commits in total. Only one patch touches hw/pci (patch #23); the remaining
> patches are confined to the Arm SMMUv3 model. Also some patches in v4 have been
> merged into the mainline QEMU tree, so the v5 series is now smaller than v4.
> 
> Secure Stage 2 is not implemented. Secure STEs which enable Stage 2 are
> rejected with C_BAD_STE. Realm and Root programming interfaces are outside the
> scope of this series.
> 
> Commits layout:
> ---------------
> The commits are roughly grouped as follows:
> 1. (#23, hw/pci only) Add a PCIDevice "sec-sid" property so boards can mark a
>   device's SEC_SID (system integration knob).
> 2. (#1-2, #24-27) Core data-structure and plumbing refactors.
> 3. (#3-8) Introduce SEC_SID through caches, notifiers, and helpers.
> 4. (#9-12) Page table walk related updates (e.g. NSCFG/PTE helpers).
> 5. (#13-15) EVTQ/CMDQ handling and invalidation paths.
> 6. (#16-22) MMIO/register access checks and architectural corner cases.
> 7. (#28) A temporary [NOT-MERGE] commit used with Hafnium to exercise
>   secure-bank register access.
> 
> 
> Main updates:
> -------------
> - (#23, hw/pci only) Add a "sec-sid" property to PCIDevice and consume it from
>   the SMMU in #24 to select the security context and validate capabilities.
> 
>   @Michael: could you please review the hw/pci change
>   ("hw/pci: Add sec-sid property to PCIDevice") and confirm this kind of
>   system-integration property is acceptable for the PCI subtree?
> 
>   For context, I previously posted this as a standalone patch [1]:
>   [1] https://lore.kernel.org/qemu-devel/20251211102729.227376-1-tangtao1634@phytium.com.cn/
> 
>   The commit in this v5 series is an updated version based on Pierrick's
>   feedback (notably switching sec-sid to a string property). We also discussed
>   the need for this knob as a prerequisite for accurately modelling SMMU secure
>   state here [2]:
> 
>   [2] https://lore.kernel.org/qemu-devel/4870b7df-4cb3-457e-9a18-87f3558adf09@linaro.org/
> 
>   We do need a stable way for boards to statically mark devices that may issue
>   Secure transactions.
> 
> other updates:
> - Drop the CR0 and CFGI_CD fixes which are already upstream.
> - Select MemTxAttrs and AddressSpace on demand from SEC_SID and keep the
>   programming-interface namespace in the configuration and IOTLB keys.
> - Route CMDQ, EventQ, IRQ and GERROR handling through the originating
>   programming-interface bank.
> - Tighten MMIO RAZ/WI, writability and reserved-bit handling.
> - Reject unsupported non-NS IOMMU notifier registration.
> - Make secure-impl an on/off/auto property, resolve auto from the Secure
>   AddressSpace, and require Stage 1 support when enabled.
> 
> 
> Testing notes:
> --------------
> - Testing MMIO accesses
>   The branch currently contains one commit explicitly marked [NOT-MERGE]. It is
>   only used to cooperate with Hafnium to exercise and validate secure-bank
>   register read/write paths in a small, reproducible setup as described in [3]:
>   [3] https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/
> 
>   This commit is not intended for upstream and will be dropped before posting
>   the final mergeable series.
> 
>   For reference, the Hafnium test logs show the SMMU being initialized
>   successfully:
> 
>   INFO: Loading VM id 0x8001: op-tee.
>   INFO: Loaded with 4 vCPUs, entry at 0xe300000.
>   INFO: Hafnium initialisation completed
>

If anyone wants to reproduce it, you can file a precompiled archive
(with optee + hafnium):

$ wget
https://github.com/p-b-o/qemu-linux-stack/releases/download/build/optee-secure-smmu-10674a1.tar.xz
$ tar xvf optee-secure-smmu*
$ ./run.sh ./build/qemu-system-aarch64
 With current master branch:
INFO: Initializing Hafnium (SPMC)
...
ERROR: SMMUv3 does not implement secure state
ERROR: SMMUv3: Failed to initialize driver
Panic: Could not initialize IOMMUs.

With this series applied:
INFO: Initializing Hafnium (SPMC)
...
INFO: Arm SMMUv3 initialized
...
INFO: Loading VM id 0x8001: op-tee.
INFO: Loaded with 4 vCPUs, entry at 0xe300000.
INFO: Hafnium initialisation completed

Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

