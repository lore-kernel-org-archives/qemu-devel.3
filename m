Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAB1C5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYf5-0004ak-Or; Fri, 06 Jun 2025 11:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uNYeX-0004JK-ON; Fri, 06 Jun 2025 11:06:46 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uNYeT-00067y-DA; Fri, 06 Jun 2025 11:06:40 -0400
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 556F6LtG013754
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 7 Jun 2025 00:06:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mLdeIBoUTvP7RARx5cbLlYotSPKc6vbCJqw+tA4RIbc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1749222382; v=1;
 b=maWk8xkIjccHgQqKJiZT+r7rTzadf8Exh8XI37oVhQ2GzB6mvKN+QP8S2NnzGTvw
 PiyEB52K5p0998UP30Ue1MYI8l0E4VjazxroBq/vTn8Peh5aDwdWQiL6CWYXnyDO
 P5DBhPK0hKIIBR86Jex+zq+seB0OHmtUiP/1BA+6Xm0Cj6Lv+2XO5q8hizGksC8N
 U6giqEZreo5FA8Bod5h7p584DUHsu5bHWE04dHX5FcBjagNCImDcwT55bneRZlZj
 PhmqDZMLpdZWzV0W/KvCgBdskUh3AsJZ/kgrQcHOoKUJZowuhj3CfxWc/Qx6tFf8
 sHdmIfDr9M0UJAS0E8/n3g==
Message-ID: <5db836df-048a-4f93-86d3-df9fd363d6c8@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 7 Jun 2025 00:06:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 09/17] hw/display: re-arrange memory region tracking
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-10-alex.bennee@linaro.org>
 <ee5115ab-b818-4746-8806-5056f3570011@rsg.ci.i.u-tokyo.ac.jp>
 <875xh95h5n.fsf@draig.linaro.org>
 <59bed3d3-f641-4b78-96bf-8fec25d74a35@rsg.ci.i.u-tokyo.ac.jp>
 <87o6v13y4k.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <87o6v13y4k.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/06/06 20:31, Alex Bennée wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> On 2025/06/06 18:54, Alex Bennée wrote:
>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>>
>>>> On 2025/06/06 1:26, Alex Bennée wrote:
>>>>> QOM objects can be embedded in other QOM objects and managed as part
>>>>> of their lifetime but this isn't the case for
>>>>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>>>>> need some other way of associating the wider data structure with the
>>>>> memory region.
>>>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>>>> to
>>>>> MemoryRegionOps for device type regions but is unused in the
>>>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>>>> reference and allow the final MemoryRegion object to be reaped when
>>>>> its reference count is cleared.
>>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>>>> Cc: qemu-stable@nongnu.org
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>
>>>>
>>>> I have told you that you should address all comments before sending a
>>>> series again a few times[1][2], but you haven't done that.
>>> I've given reasons. Thanks for your review but you don't get to
>>> veto.
>>>
>>>> I pointed out it has no effect (fixing or improving something) other
>>>> than adding a memory allocation, but you didn't make a reply to prove
>>>> otherwise.
>>> I explained the commit cover what it is doing.
>>
>> It still doesn't explain the motivation.
>>
> <snip>
> 
> It fixes the anti-pattern of embedding a QOM object into a non-QOM
> container. It enables in the following patches the lifetime of the MR to
> be covered controlled purely by its references and not be so tangled up
> with virglrenderers internals.

The "container" is just a memory allocation made by g_new0() and this 
patch doesn't change that.

I haven't reviewed "[PULL 10/17] virtio-gpu: refactor async blob 
unmapping" yet, but it apparently it doesn't depend on this patch.

The virglrenderer's internals are irrelevant; both 
virtio_gpu_virgl_hostmem_region and MemoryRegion are QEMU-specific 
structures.

Regards,
Akihiko Odaki

