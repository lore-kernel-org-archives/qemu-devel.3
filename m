Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5061AC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFoT-0001tr-LW; Thu, 16 Jul 2026 02:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkFoS-0001tg-AE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:43:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkFoQ-0003lz-4A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 02:43:16 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66G6h5ab000769
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 16 Jul 2026 15:43:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=MiYUCREVmBSmRggQjmnkZ9U7/+YoSC0Bi2Yvk3546Fk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784184185; v=1;
 b=Qqef+Zjo7a1QKAFuzu84UvG6EN2fqUlQJe9V5OautBZFtXxjlhAQi6ZRWuZVdWRa
 1zs0RsYZH1+szhtUC+aO/MTPPnubKgNZyI0k5hHHt2dSYLV1RfZsLN60dsLUqQe0
 daxA/tkwebXh53OfyIueWzPUEPmx6Xw797Z2vnguym4gC12t/syAsQMCBfx3jc2F
 JmAzPD2Kh2ETel3S6ZH/mei+vB2jsNmNPu5THHOtfxELLnhu2GwqQ0DPZpm0dMlC
 /lg2MPPTksrrbHhc2MDbNeDkFEtYZmmkvLR0TDOFc5DKempacgjS0tatBrFuf8kK
 VSTfEd+tTTU9GCo5pJV1XA==
Message-ID: <28efc558-36a9-4e07-a7a7-ab606c7542e5@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 16 Jul 2026 15:43:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/07/13 21:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When virtio_gpu_create_udmabuf() succeeds but virtio_gpu_remap_udmabuf()
> fails (mmap returns MAP_FAILED), virtio_gpu_init_udmabuf() returns early
> without closing the dmabuf fd. Since res->blob is never set in this
> path, later cleanup via virtio_gpu_cleanup_mapping() skips
> virtio_gpu_fini_udmabuf() entirely, leaking the file descriptor.
> 
> Call virtio_gpu_destroy_udmabuf() before the early return to close
> the fd. This function already handles partial state correctly: it
> skips the munmap when res->remapped is NULL and closes the fd when
> res->dmabuf_fd >= 0.
> 
> Fixes: 9b60cdf98723 ("virtio-gpu: Add udmabuf helpers")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

