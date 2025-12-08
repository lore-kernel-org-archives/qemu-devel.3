Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE67D2CE17
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 00:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSPMG-0003sR-V2; Sun, 07 Dec 2025 19:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vSPMB-0003rl-AE
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 19:44:03 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vSPM9-0005Zz-GN
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 19:44:03 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765154620; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PIAaw7MONE6HnfvEjDOG5Nmkzi21z01ElVp9TOEasz91c0grEsLDI5PxsETu3954MVjnC1DrPGIwRQZpco325p13NT7YGYFrvF+sj5TpIV5vq3Pzgmg073bhqi0plqzh9Kgu0zoS7Zt1y/UN7ukvq+ew4q4c53ZIFDmuo8RhLD0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765154620;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0VdyBqnnbIoT5yBpzNt8xf5Ak9z6SzwPPZLq2FR9GF4=; 
 b=jtLTNb87cIm9dEQ32Dxntxutx+1qebpZgcQDu94Gt5UwA+Fzs9GnR7D3mp9y0Y8AyzH+fNkUa7HHYayt4kip+jjaWL2iukxCqHKSxfCjIKdYMjm49fLWxiEaZjGLy4R2EjHnXDsUb7HHYftDU9h4vzrdsqGBnGCfostnj/tH18E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765154620; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=0VdyBqnnbIoT5yBpzNt8xf5Ak9z6SzwPPZLq2FR9GF4=;
 b=i4YbqigmfFw5VaIEHhwh/z35HVNrlT/4KSPdX8TSF9JxYmpWPw8RVA4AkSGbHZQm
 sdesO+kNcFaLtJnR3eFKoEEQnFIMka4vUksOkOaicHbgxG1cgEIH3YqGwnIFLpNkiOq
 hjzcR7z6rMVwR3Gbe+hWLfkMrGxxRJbzQ9BgrWOY=
Received: by mx.zohomail.com with SMTPS id 1765154616828770.4577245508021;
 Sun, 7 Dec 2025 16:43:36 -0800 (PST)
Message-ID: <26c7fc40-7f4e-4872-8c25-5af9701e815d@collabora.com>
Date: Mon, 8 Dec 2025 03:43:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 4/7] virtio-gpu: Make
 virtio_gpu_virgl_unmap_resource_blob() return -1 on error
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yiwei Zhang <zzyiwei@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Robert Beckett <bob.beckett@collabora.com>
References: <20251125023517.177714-1-dmitry.osipenko@collabora.com>
 <20251125023517.177714-5-dmitry.osipenko@collabora.com>
 <87qztm71qe.fsf@draig.linaro.org>
 <4f9d28c9-fae4-405c-80bc-c3bd8e21acbd@collabora.com>
 <ee99e19b-0ab5-48b6-b12d-aa0bb5fe1420@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ee99e19b-0ab5-48b6-b12d-aa0bb5fe1420@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 12/5/25 07:08, Akihiko Odaki wrote:
> On 2025/11/26 0:49, Dmitry Osipenko wrote:
>> On 11/25/25 15:09, Alex Bennée wrote:
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>
>>>> Make virtio_gpu_virgl_unmap_resource_blob() return -1 for more
>>>> consistency
>>>> of error propagation style in the code, adhering to QEMU's devel/style
>>>> recommendations and preparing code for further code changes
>>>> utilizing this
>>>> function.
>>> I'm not so sure of that. If the function is a pass/fail then we tend to
>>> prefer using bools in newer code. If you need richer internal error
>>> reporting then start using your errno defines. If this is user visible
>>> (i.e. during configuration) then we can make more of Error* and friends.
>>
>> The current code is a mix of all variants. Will be good to stick with
>> one.
>>
>> Akihiko, what are your thoughts on the best option for the errors
>> handling? Would you also prefer bools?
> 
> Sorry, I missed this.
> 
> I'm for bools. It allows compilers to enforce having either of two
> values, whose semantics is defined in include/qapi/error.h "true on
> success / false on failure"; it says functions should also have "Error
> **errp" but I think the semantics of bool can be applied for those
> without the parameter.
> 
> If you are still not sure or there are disagreements, I think it is
> better to ask Markus Armbruster, who maintains the error reporting
> facility shared for the whole codebase.

Thanks for the reply. The bools are fine with me. I removed patches
changing the error handling in a next version of this patchset as they
are a bit controversial and not essential for this series.

-- 
Best regards,
Dmitry

