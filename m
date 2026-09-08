Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8245C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xZa-0002iz-4W; Tue, 08 Sep 2026 11:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3xZX-0002iW-Ok; Tue, 08 Sep 2026 11:17:19 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1x3xZW-0000ci-0M; Tue, 08 Sep 2026 11:17:19 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwDXGYX4JqBqZtYAAA--.1530S2;
 Tue, 08 Sep 2026 23:17:12 +0800 (CST)
Received: from [192.168.2.9] (unknown [113.246.117.164])
 by mail (Coremail) with SMTP id AQAAf8DwSnP2JqBq_VrRAA--.30995S2;
 Tue, 08 Sep 2026 23:17:10 +0800 (CST)
Message-ID: <597ee3ff-924b-4975-8dd1-4a354d6c0eb2@phytium.com.cn>
Date: Tue, 8 Sep 2026 23:17:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 15/28] hw/arm/smmu: Make CMDQ invalidation security-state
 aware
To: eric.auger@redhat.com, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162512.2807281-5-tangtao1634@phytium.com.cn>
 <be147db5-71df-46f5-b245-78af15b945fc@redhat.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <be147db5-71df-46f5-b245-78af15b945fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwSnP2JqBq_VrRAA--.30995S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAMBWqfEMkHogACsD
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr4xuw4UJw4fCF1UZw1fWFg_yoW8CrW8pF
 WakrZ0k3ykGFs2y3W8Aw48Wa4xu393CrW3C398W34Syrn8XFyvqrW7K343KFZ3XF17uF17
 Xay2qFsrZ3yDA3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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


On 8/28/2026 4:54 PM, Eric Auger wrote:
> Hi Tao,
>
> On 8/13/26 6:25 PM, Tao Tang wrote:
>> Refactor CMDQ invalidation paths to carry security state and apply cache
>> invalidation per sec_sid instead of globally. Add separate helpers for
>> invalidating all entries and for invalidating entries belonging to one
>> valid sec_sid.
>>
>> In smmuv3, propagate the command queue sec_sid and command SSec through
>> CFGI and TLBI handling, and gate VMID use on the stage-2 capability of
>> the selected command queue, including SMMU_S_IDR1.SEL2 for a Secure
>> Command queue.
>>
>> Keep acceleration and IOMMU notifier propagation Non-secure-only.
>> Commands targeting a programming interface other than Non-secure do not
>> reach the accelerated backend or Non-secure notifiers, while Non-secure
>> stage-1 CMD_TLBI_NH_ALL remains forwarded to the host.
>>
>> Include the command queue SEC_SID and target SEC_SID in the relevant
>> invalidation tracepoints.
> Could you split this patch so that the review becomes easier? The code
> diff is huge and to me there are several functional aspects that can be
> dealt with separately. For instance I see it handles invalidation for
> both iotlb and cache hash tables. I have the feeling this could be
> easily split, no?
>
> Also we have changes to accel install_ste* smmuv3_accel_issue_inv_cmd
> that look quite unrelated? Also shouldn't they enforce NS is used in
> accel mode? I would put that in a separate patch anyway.
>
> smmuv3_inv_notifiers_all() intro could be also handled in a separate patch.

Hi Eric,

I'll split this roughly as follows:

- Limit accel commands to Non-secure targets
- Limit IOMMU notifier invalidation to Non-secure targets
- Make configuration cache invalidation security-aware
- Make CMDQ TLB invalidation security-aware

Thanks for the suggestion.
Tao


