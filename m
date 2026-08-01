Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3022FC5516F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 08:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq4mM-0000Wm-Ns; Sat, 01 Aug 2026 04:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq4mL-0000We-76
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 04:09:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq4mH-0005Nb-Kc
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 04:09:08 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67188sv3053259
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 1 Aug 2026 17:08:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=gSOBSt3Od8CRRqi1DeYkgAPxErvFNPSk7+LXYNwppqE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785571734; v=1;
 b=sKpUO6sqpHiGAy8vFep/0IIGVKDp+aRZ1sx7d66FfHyVvFUThMU1zzqDP9ieIREa
 5Id7s0zu8MyTsQiuASLfJM85GufGI6e5xO5uGVGN1NIeg+X6qWHalyxcz+rwpaq6
 S0+7BqezPUAdqQR1RiL1notOehPtV6fbH2rKNXqN5/uSYbVLTcEneSbqMkBQQ1kc
 oBi2L9uftB1icBfhD0QeX+9hPP7toYIDl0mdKU/ptOsYOkQ3DJ0t8vFu7uHxEhFn
 zF5bYYv6OUWYFst5+Vccxw+k4EC+om4DmPNZhfhvQtXGKs8VBPiFpkVvuKpHmxJJ
 eimfLeHZjxxcHSC9fwKMtw==
Message-ID: <b1bf6321-533c-4add-8b68-648600ed80f4@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 1 Aug 2026 17:08:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/display/virtio-gpu: fix offset wraparound in
 scanout_blob_to_fb
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260725122734.1775774-1-marcandre.lureau@redhat.com>
 <0d321266-8d73-4cb3-80c8-c5b05a34d2e2@rsg.ci.i.u-tokyo.ac.jp>
 <CAJ+F1C+_zoQFnR8oXfTSTOv5HfQUkYLk3cWhve1B=2Xi0VbWQQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+_zoQFnR8oXfTSTOv5HfQUkYLk3cWhve1B=2Xi0VbWQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/28 5:24, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 11:03 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/07/25 21:27, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
>>> guest-controlled offsets[0], r.x, r.y and stride using uint32_t
>>> arithmetic. When the sum exceeds UINT32_MAX, silent wraparound lets
>>> the guest steer the scanout to an arbitrary in-bounds region of the
>>> blob instead of the intended rectangle.
>>>
>>> Compute the offset in uint64_t, reject values exceeding UINT32_MAX
>>> (the width of fb->offset), and only store into fb->offset once both
>>> range checks pass.
>>
>> The calculation of offset can still overflow uint64_t. All supported
>> formats use four bytes per pixel, so
>> the maximum mathematical value is:
>>
>>       UINT32_MAX + 4 * UINT32_MAX + UINT32_MAX * UINT32_MAX
>>
>> which exceeds UINT64_MAX.
> 
> The code rejects stride > INT_MAX, that should make the sum maximum
> below UINT64_MAX

You are right. Commit 9c724426f519
("hw/display/virtio-gpu: reject strides exceeding INT_MAX") has landed,
so the offset calculation can no longer overflow uint64_t:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

> 
>>
>> This is reachable through virgl_cmd_set_scanout_blob(), whose
>> rectangle checks use wrapping uint32_t additions. For example:
>>
>>       width = height = 16
>>       stride = r.y = blob_size = UINT32_MAX
>>       r.x = 0x7fffffff
>>       r.width = 0x80000001
>>       r.height = 1
>>       offsets[0] = 3
>>
>> Both rectangle sums wrap to zero, while the mathematical offset is
>> exactly 2^64. Consequently, offset becomes zero, fbend becomes
>> M, and both bounds checks pass. The non-virgl caller retroactively
>> rejects this geometry. The virgl caller fails to reject it.
> 
> That's a separate fix though, open a security issue?

I do not think a security issue is needed. The remaining wrapping 
rectangle bug can still cause QEMU to abort on invalid scanout 
dimensions. Since triggering it requires guest kernel privileges, it
should be fixed separately as a hardening bug.

Regards,
Akihiko Odaki

> 
>>
>>>
>>> Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
>>> Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
>>> ("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")
>>
>> Please remove Based-on: from the patch message when sending a pull
>> request. You can put the tag in the footer. For example:
>>
>> https://patchew.org/QEMU/20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp/
>>
>> Regards,
>> Akihiko Odaki
>>
>>> Reported-by: Cyber_black <Cyberblackk@proton.me>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>> ---
>>> v2:
>>>    - no OOB, dropping CVE, make commit message adjustments
>>> ---
>>>    hw/display/virtio-gpu.c | 14 ++++++++------
>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index b21ac8dace08..bc45cfb194f0 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -785,7 +785,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>>>                                       struct virtio_gpu_set_scanout_blob *ss,
>>>                                       uint64_t blob_size)
>>>    {
>>> -    uint64_t fbend;
>>> +    uint64_t fbend, offset;
>>>        uint32_t bytes_pp;
>>>
>>>        fb->format = virtio_gpu_get_pixman_format(ss->format);
>>> @@ -815,18 +815,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
>>>            return false;
>>>        }
>>>
>>> -    fb->offset = ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->stride;
>>> +    offset = (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp +
>>> +             (uint64_t)ss->r.y * fb->stride;
>>>
>>> -    fbend = fb->offset;
>>> -    fbend += (uint64_t) fb->stride * ss->r.height;
>>> +    fbend = offset + (uint64_t)fb->stride * ss->r.height;
>>>
>>> -    if (fbend > blob_size) {
>>> +    if (offset > UINT32_MAX || fbend > blob_size) {
>>>            qemu_log_mask(LOG_GUEST_ERROR,
>>> -                      "%s: fb end out of range\n",
>>> +                      "%s: invalid fb bounds\n",
>>>                          __func__);
>>>            return false;
>>>        }
>>>
>>> +    fb->offset = offset;
>>> +
>>>        return true;
>>>    }
>>>
>>
>>


