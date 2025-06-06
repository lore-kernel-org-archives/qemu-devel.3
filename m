Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB37EC61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNUMs-00076h-Rw; Fri, 06 Jun 2025 06:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uNUMk-0006rz-LL; Fri, 06 Jun 2025 06:32:04 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uNUMg-0003cf-Fe; Fri, 06 Jun 2025 06:32:02 -0400
Received: from [157.82.203.223] ([157.82.203.223]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 556AViXI099832
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Jun 2025 19:31:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=B3jZ6yJteua5tR2gDlua9AgfYUbM3qIIhcySSsnToeA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1749205905; v=1;
 b=nBzXlnv7kgmAKTSh8iXKck7k44K6HYqjs9Ndv7Yu3tKLmPV8hsm1L1NiKBMgfD2s
 pqMFmnbL4JhV2d5USLBdAJV2gUG7vZ3m+H4+1i5rLee8OZXp8IsJefad//4ejKle
 oF7Qpk4kjNgWEBPkQDxUvLqBVjJagwgO7SBcEKbWQJR9gR7MvjKnLHdie8M0rJvu
 vA0aoqgRZPj8896x7L1pcs4mShkxNlqvmq5kA+VUz03jxk2IRx+0928HFuETdn5v
 0i1pXW7C7KDFpBezRzYNW1HiAEgc2LH5H3F1cyrZ4sMZtYN2BvyepiLehQ9ZggP0
 pdBPzgDiwjo+ZJ9hSoAoGA==
Message-ID: <59bed3d3-f641-4b78-96bf-8fec25d74a35@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 6 Jun 2025 19:31:44 +0900
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <875xh95h5n.fsf@draig.linaro.org>
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

On 2025/06/06 18:54, Alex Bennée wrote:
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
> 
>> On 2025/06/06 1:26, Alex Bennée wrote:
>>> QOM objects can be embedded in other QOM objects and managed as part
>>> of their lifetime but this isn't the case for
>>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>>> need some other way of associating the wider data structure with the
>>> memory region.
>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>> to
>>> MemoryRegionOps for device type regions but is unused in the
>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>> reference and allow the final MemoryRegion object to be reaped when
>>> its reference count is cleared.
>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>
>>
>> I have told you that you should address all comments before sending a
>> series again a few times[1][2], but you haven't done that.
> 
> I've given reasons. Thanks for your review but you don't get to veto.
> 
>> I pointed out it has no effect (fixing or improving something) other
>> than adding a memory allocation, but you didn't make a reply to prove
>> otherwise.
> 
> I explained the commit cover what it is doing.

It still doesn't explain the motivation.

For example, "[PULL 01/17] tests/docker: expose $HOME/.cache/qemu as 
docker volume" does explain its motivation. It says:

 > If you want to run functional tests we should share .cache/qemu so we
 > don't force containers to continually re-download images.

So, with the patch, containers will no longer require continually 
re-downloading images, which is nice.

Back to this memory region patch, what does it contribute? What's nice 
with this patch?

> 
>>
>> I also pointed out it leaks memory and you asked for a test case[4],
>> but you made this pull request without giving me 24 hours to reply to
>> it.
> 
> You keep bringing up theoretical issues. We have passing test cases now
> and we have plenty of time to address any bugs we might discover. But
> holding onto these patches is slowing down other work getting in and I
> don't deem it a risk to merge as is.

Things that involve concurrency and memory safety will often become 
theoretical.

For example, I recently changed a concurrency algorithm with the 
following patch:
https://lore.kernel.org/qemu-devel/20250526-event-v4-0-5b784cc8e1de@daynix.com/

All reviews were theoretical and did not provide any test case. These 
reviews still matter and I replied them by providing my theory, which 
eventually materialized as a documentation patch:
https://lore.kernel.org/qemu-devel/b41eb6f4-96b8-47bf-90cf-e4918a613dcf@daynix.com/T/#m2603d613d8d8cbbe87b4dce63fd2663c58d52e55

> 
>>
>> The situation of "[PULL 03/17] tests/tcg: make aarch64 boot.S handle
>> different starting modes" is also similar. I added a comment about
>> symbol naming and you gave a reasoning, but I didn't get time to
>> review it either[5]. Besides, I also had a suggestion to make the code
>> shorter for the past version, but it is also dismissed.
>>
>> I also pointed out "[PULL 11/17] ui/gtk-gl-area: Remove extra draw
>> call in refresh" has an undressed comment[2][7].
>>
>> I would like to see improvements in how comments are addressed before
>> a series is resent.
> 
> No - I'm sorry you don't get to veto a pull request because it doesn't
> meet your particular standards.

The standards are not mine, but documented in:
docs/devel/submitting-a-patch.rst

> 
> I'm happy with the other review and level of testing of the patches to
> put it in a pull request. I held off the other well tested patch in the
> series out of an abundance of caution but will keep it in the
> virtio-gpu/next tree and re-post once I've done my next sweep for my
> maintainer trees.

A reviewer don't have a right to veto but the mentioned documentation 
says they can still get a submitter's counterargument when the submitter 
disagrees with them. Reviews should not be just silently ignored.

Regards,
Akihiko Odaki

