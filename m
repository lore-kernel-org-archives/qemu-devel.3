Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D5EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 07:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxJew-0002bv-WC; Fri, 21 Aug 2026 03:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wxJeu-0002SC-Ix; Fri, 21 Aug 2026 03:27:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wxJer-0006mu-KM; Fri, 21 Aug 2026 03:27:24 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67L7L9r4016626
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Aug 2026 16:21:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PrsqeCZo14bsILafP5HHdnaphT9v1lbdzWwjJUXM0xE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787296869; v=1;
 b=FTxA5mvOOEI7AhkX2w6BWNaVmWamog2Inu7DLYtOTZeH3+GNW4KguyOPHH/DsDzP
 fAiojAJGWnZOmQHUN1llA2z23FEm8qqCHv3AsrawF08uKo5aZWIHA1ZnV2Z9TAtU
 Y0KSe41Yz9UJtKxJ5599zdtCXZHQ9RrQF9g5Bv/S6gbgZYwn540QscEK84p+d8UT
 UBdy9xifdgtatT7nzBjVgstV6VuUKXQp37nq+BxZcpXEnz4iPyWS/5wpdL4m8onR
 yWSN9tZUV+vcP9yNAXn1NiZcfD3cGp94xJKQStlAhvHhu/eJ7qTNwt784ywc11W5
 /F4C5nDfdah9Fsx0j2vdoA==
Message-ID: <eca888c2-b760-4773-9b47-711328d16e22@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Aug 2026 16:21:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/13] hw/virtio/vhost-shadow-virtqueue: used
 callback
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-4-948aae960abb@gmail.com>
 <b6f79ec9-7842-47ff-b210-855036712547@rsg.ci.i.u-tokyo.ac.jp>
 <CA+spn3rouMQ=yG1m2fS=vm40c-zWWMZPK+yk0K_ip5iXzLZWow@mail.gmail.com>
 <5d8e3d91-de60-4747-88d1-e135e3c6e7c1@rsg.ci.i.u-tokyo.ac.jp>
 <CA+spn3o18uuZqfyGE+R2QGZ6KRoTJ9hmK7HyEQ6cg4wxN9QPsw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CA+spn3o18uuZqfyGE+R2QGZ6KRoTJ9hmK7HyEQ6cg4wxN9QPsw@mail.gmail.com>
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

On 2026/08/21 8:42, Connor Kite wrote:
> On Wed, Aug 19, 2026 at 10:15 PM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>>
>> Skipping event_notifier_set() only suppresses this guest interrupt, and
>> disabling SVQ notifications only suppresses backend call notifications;
>> it does not stop backend ring processing. The error should be propagated
>> with virtio_error().
>>
>> I looked into the virtqueue_fill() and virtqueue_flush() calls in the
>> existing error path. The virtqueue_fill() call detaches the element and
>> publishes it to the guest. Detaching the element is necessary and should
>> be done in the new error path too. On the other hand, publishing the
>> failed element is wrong and should not be done.
>>
>> virtqueue_flush(vq, i) is still required to publish and account for the
>> preceding successfully filled elements.
>>
>> Regards,
>> Akihiko Odaki
> 
> Thank you for the explanation!  I was not aware of virtio_error.  This
> error path will now follow the following order:
> 
>      if (r < 0) {
>          virtio_error(svq->vdev, "Vhost shadow virtqueue error while
> handling used element.\n");
>          virtqueue_detach_element(vq, elem, 0);
>          g_free(elem);

This must be removed. elem is declared g_autofree, so returning after an 
explicit free would free it twice.

>          virtqueue_flush(vq, i);

virtio_error() must come last. It sets vdev->broken, after which 
virtqueue_flush() takes its disabled-device shortcut and merely 
subtracts i; it does not publish the preceding used entries.

>          return;
>      }
> 
> One thing still seems a little strange here about how vq->inuse is
> modified by these operations.  The count provided to virtqueue_flush
> in the svq code is the number of elements that have been added.
> However, depending on which type of flush occurs, the value of
> vq->inuse is decreased by either this count (virtqueue_split_flush) or
> the number of descriptors in the flushed elements
> (virtqueue_packed_flush, virtqueue_ordered_flush).  Also, the
> virtqueue_detach_element always decrements vq->inuse by the number of
> descriptors.
> 
> I'm possibly just misunderstanding something, but this seems like
> vq->inuse could potentially end up in an incorrect state.  Maybe that
> doesn't matter in this case once virtio_error gets called...

The corresponding virtqueue_pop() function that increments vq->inuse 
also changes the count conditionally with the negotiated features, so I 
expect they are balanced.

Regards,
Akihiko Odaki

