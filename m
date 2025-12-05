Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEE7D2CE1A
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 04:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRN8U-0004jm-41; Thu, 04 Dec 2025 23:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vRN8O-0004j4-EK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 23:09:32 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vRN8L-0006fS-Pe
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 23:09:32 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5B548sSF031610
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 5 Dec 2025 13:08:55 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=aQ+Sn/fA22RiV+QkvUkpimlDNeo/k8qcfKPw94C7GB4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1764907735; v=1;
 b=UZhnBmvMNgnLJ5RnbAd+fc23mZvgJTucNQJ8Jo2jv9/iPX5hno5ns0CK/QBZZBlV
 3BTUjKA1FK4KRCP2BxYpO85a2s83/403/Y4cziodTSxZYXNqiQ0lLPs/dUpKJ1UZ
 vFZeonPtFPijOJi8BqMA5Zs1iePakfvTz9S+SSPgBMlKazUtniCyaxg78k9XFykh
 1LOt/NQe4kG4jCnUiQOyvR+gAvABYut1XdDOAe6eXJmprLEHvmMEj0NVAFZtddNg
 pY/GLRGQx1LlTkowOsK70SQjBswedHQFNZmkunKihs3NTQCcZgK8D8R85svUXT6M
 dRC3Ovj3jqL/RC2MnImZFg==
Message-ID: <ee99e19b-0ab5-48b6-b12d-aa0bb5fe1420@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 5 Dec 2025 13:08:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/7] virtio-gpu: Make
 virtio_gpu_virgl_unmap_resource_blob() return -1 on error
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yiwei Zhang <zzyiwei@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>,
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>,
 Rob Clark <robdclark@gmail.com>, Robert Beckett <bob.beckett@collabora.com>
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-5-dmitry.osipenko@collabora.com>
 <87qztm71qe.fsf@draig.linaro.org>
 <4f9d28c9-fae4-405c-80bc-c3bd8e21acbd@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4f9d28c9-fae4-405c-80bc-c3bd8e21acbd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/11/26 0:49, Dmitry Osipenko wrote:
> On 11/25/25 15:09, Alex Bennée wrote:
>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>
>>> Make virtio_gpu_virgl_unmap_resource_blob() return -1 for more consistency
>>> of error propagation style in the code, adhering to QEMU's devel/style
>>> recommendations and preparing code for further code changes utilizing this
>>> function.
>> I'm not so sure of that. If the function is a pass/fail then we tend to
>> prefer using bools in newer code. If you need richer internal error
>> reporting then start using your errno defines. If this is user visible
>> (i.e. during configuration) then we can make more of Error* and friends.
> 
> The current code is a mix of all variants. Will be good to stick with one.
> 
> Akihiko, what are your thoughts on the best option for the errors
> handling? Would you also prefer bools?

Sorry, I missed this.

I'm for bools. It allows compilers to enforce having either of two 
values, whose semantics is defined in include/qapi/error.h "true on 
success / false on failure"; it says functions should also have "Error 
**errp" but I think the semantics of bool can be applied for those 
without the parameter.

If you are still not sure or there are disagreements, I think it is 
better to ask Markus Armbruster, who maintains the error reporting 
facility shared for the whole codebase.

Regards,
Akihiko Odaki

