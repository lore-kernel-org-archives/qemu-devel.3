Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9C8C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 05:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0BOg-0000bg-4O; Sat, 29 Aug 2026 01:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x0BOd-0000bF-T8
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 01:14:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x0BOb-0004Mg-FR
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 01:14:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67T5EJJM076480
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 29 Aug 2026 14:14:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4ewm7FtpAJaDk8RA3CtxzBuY/ArTMLlj363/skvO5hk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787980459; v=1;
 b=dwBaUe9zUZE3QDjdSX+1ZmwxxMpWth+kGHXAVR7ZVGhjaZRADtjFp+VLQkkB+aN5
 NoNIxAQnSmdH3E2FOHPuiH+Mrv2XnQhyiOE7b8CeIyBtnhMcC05eJARpFcSgRkP5
 5nqZbyXrmWA8KKqtXcKaLEF/5cS0TRrJWzViPkRjVm+uxe0SRDozL7QJUegV7BbV
 yRzUe+AHybsY1quyE9Vn6NSK6qm+aHY7SfnrfSeULUnl/zC0IVJYyrGCR2ziF+Xr
 FLz1xhbj4aQO3LaHOOAsShR4e/z2zD0QcxtuS2WRn7Ws2VRz4+07WirbSO7gwHWr
 KaED76QGnVo/VJwMa8WWjQ==
Message-ID: <e2f322dc-05d3-412d-80a5-b423464e66b5@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 29 Aug 2026 14:14:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/console: fix use-after-free in qemu_console_set_cursor
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
 <ao_5WNBxRiZycEeb@redhat.com>
 <CAJ+F1CL-4kx18mUC4Jk7-cARiVX0Cq3qSFt5Ct-qM2EBA9dyUw@mail.gmail.com>
 <apARs-59eJramFr9@redhat.com>
 <CAJ+F1CL3y68B40P+2RcB5G5-GVjfP3JnTLdcRECRAFsk1KEdhg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1CL3y68B40P+2RcB5G5-GVjfP3JnTLdcRECRAFsk1KEdhg@mail.gmail.com>
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

On 2026/08/27 19:36, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Aug 27, 2026 at 2:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Thu, Aug 27, 2026 at 01:58:14PM +0400, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Thu, Aug 27, 2026 at 12:47 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>
>>>> On Thu, Aug 27, 2026 at 11:06:47AM +0400, marcandre.lureau@redhat.com wrote:
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> When the new cursor is the same object as the one already held by
>>>>> the console and the refcount is 1, cursor_unref frees it before
>>>>> cursor_ref can increment the count.
>>>>>
>>>>> Ref the incoming cursor before unreffing the old one so the
>>>>> refcount goes 1-2-1 instead of 1-0 (freed) then use-after-free.
>>>>
>>>> I don't see where/how this can happen.  The caller of
>>>> qemu_console_set_cursor should own its own reference
>>>> on 'cursor'. So on entry to this method, 'cursor'
>>>> should have a ref of 2 if it is the same as the
>>>> current con->cursor.
>>>>
>>>> if anything the behaviour you describe sounds like a
>>>> bug in a caller not holding its own reference.
>>>
>>> You are right, I thought virtio-gpu kept a weak pointer, but it should
>>> have a strong ref, so we should never reach 0. I can't explain the
>>> crash I observed then.
>>
>> Is there a bug report for this or crash scenario info ?
> 
> No, I just had this report from ASAN when testing -display dbus with
> virtio-gpu. Pretty regular test.

dbus_cursor_define() looks suspici

 > @data is not modified by this function and must remain valid with an
 > unchanging value until such a time as @notify is called with
 > @user_data.  ous; it exposes mutable cursor pixels through a 
zero-copy GVariant and arranges for cursor_unref() to run when that 
variant is destroyed.

The documentation of g_dbus_connection_add_filter() says "filters are 
run in a dedicated message handling thread", but QEMUCursor::refcount 
uses unsynchronized ++/--, which may explain your ASAN crash.

Meanwhile, virtio-gpu repeatedly mutates the same cursor, which violates 
g_variant_new_from_data()’s requirement that its bytes remain unchanged 
until notification. Its documentation says "if the contents of @data 
change before that time then the result is undefined."

Regards,
Akihiko Odaki

> 
>> Something wrong with the 'cursor' object stored in virtio_gpu_scanout ?
>> I notice in the VMState:
>>
>>          VMSTATE_UINT32(cursor.resource_id, struct virtio_gpu_scanout),
>>          VMSTATE_UINT32(cursor.hot_x, struct virtio_gpu_scanout),
>>          VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
>>          VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
>>          VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
>>
>> what is restoring the "refcount" to "1" when vmstate is loaded ?
> 
> cursor != current_cursor (allocated with update_cursor on post_load)


