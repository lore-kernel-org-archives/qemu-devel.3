Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7522CC56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws0Tq-0004sc-J6; Thu, 06 Aug 2026 11:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ws0Tm-0004sE-BJ; Thu, 06 Aug 2026 11:57:58 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ws0Tj-0006ye-1u; Thu, 06 Aug 2026 11:57:58 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 676FusjA003499
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Aug 2026 00:56:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jKtWHgb9iw0wJzY2NL5PuVmLGrV+j2bXleDjb2S8IiE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1786031815; v=1;
 b=DhXJvv9+/WKLV9yGm5mF7kmSAF0piMqTk+mti/UD0EtjIuIVqJgDTIlVYkCRO+1v
 UppWYa71TpyB5zKL4r54ESaXg6ObbQM60kbr2RfAU4ZpD9ey0wg+m3RMQFXBaibJ
 C2yqKdStL+W5UzgAax9ilw1mokGs0bMb2LBP1gBeY0pE+DKGZiwCKEtxm65jvRp5
 KrxkKL/DPDUla6YL/Aq5XN3xCMh4RY+k5T7O5LsCeqaL7+aRP6C6A2bH/oDEAjlk
 g6V/qHBvHImTudQWdXQHeZdXV4fihhh4HetF7SWwt4q9CEhNUgFI77N1niirxykR
 wHm841BieO42k+CdaQ+acw==
Message-ID: <64e6116e-5729-490d-b945-b11310dec709@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 7 Aug 2026 00:56:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/15] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
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
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-9-6b97c439eb28@gmail.com>
 <f9125d0a-3258-46f4-93f6-0761a4acdc66@rsg.ci.i.u-tokyo.ac.jp>
 <CA+spn3pLJvQCyfUvK4WvjvfJnGYBKr-i302HvBeVm9Y3t6sR8Q@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CA+spn3pLJvQCyfUvK4WvjvfJnGYBKr-i302HvBeVm9Y3t6sR8Q@mail.gmail.com>
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

On 2026/08/07 0:29, Connor Kite wrote:
> On Fri, Jul 24, 2026 at 5:19 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> ...
>>
>> Nit: please remove the whitespace between (void *) and svq->base_addr.
>>
> 
> Removing the whitespace!
> 
>>> +        svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
>>> +        svq->vring.used = (void *)((char *)svq->base_addr +
>>> +                          vhost_svq_driver_area_size(svq));
>>> +    }
>>
>> Unmapping svq here can lead to use-after-unmapping because the ring is
>> not stopped yet. do_vhost_dev_stop() calls do_vhost_virtqueue_stop()
>> only after calling hdev->vhost_ops->vhost_dev_start(hdev, false).
>>
> 
> I am afraid I don't quite understand, as this patch does not introduce
> any unmapping.
> Was this comment meant for a different patch?

Yes, sorry, this comment was meant for "[PATCH RFC 14/15] 
hw/virtio/vhost-user: handle data movement with shadow vqs".

vhost_user_dev_start(dev, false) calls vhost_user_svqs_stop(), which 
calls vhost_svq_stop() and unmaps the shadow vring. However, 
do_vhost_dev_stop() calls do_vhost_virtqueue_stop() only after the 
callback returns. The backend vring therefore remains active until 
VHOST_USER_GET_VRING_BASE, so it may still access the unmapped memory.

Regards,
Akihiko Odaki

