Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7BFC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcEe-0002m8-Lr; Tue, 14 Jul 2026 08:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wjcEb-0002lf-Qa
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:27:37 -0400
Received: from sender4-op-o11.zoho.com ([136.143.188.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1wjcEZ-0004qV-FK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:27:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1784032038; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XrGknWSlCT/oKVVNrxscq/o6dkhXMhZzuvF3R7ZaAD0TfA2WMQSYGs9wWzDAfZa0vIPS53yNZ3+VyR0iZxYePuwRp/hzOHn3mQocsG8tF5Uz8NsMkI2wI3tJ/mHWQ2cOwv9a5GKP3E6yQe2cZrk3IF1EZrxJouBycq9PwNhRfLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784032038;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oOdH9LoOupZMpMZ9LBs87vrCbvCVqZPBqxyVe7bsEwI=; 
 b=k5pNhGu+unruKGAMjVQxNgVlkbCkk7Uul0EK3I7WYEK0MU+s38E7VDMRqfPGFuQeM4huirITuyjuaTCpIB1bkwQdrhsT4bTlwsd7OYAGppGsGZv6r/HGmlXo8PUuS/n9sOwHgTGt8DBVF3XwtQ3lr5PoqhA8wkzA5osr2uamZ5s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784032038; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=oOdH9LoOupZMpMZ9LBs87vrCbvCVqZPBqxyVe7bsEwI=;
 b=K6aGSQ3x+ZVcwhlGmrwJ7y/6zwU6povN25hF5Rnflvs7730EtTsdkG7Lhqs21s9h
 qIgVRONoS0VPU6ddMehJIEFq32jxbWF6ukoZB+mgWzcDVIQ4YMDIwVN0GF/gVTbx6fd
 EJWWm61JWz2aoIcW1yS/0embmgM0dNyGDt5rssOs=
Received: by mx.zohomail.com with SMTPS id 1784032036269316.86138990018605;
 Tue, 14 Jul 2026 05:27:16 -0700 (PDT)
Message-ID: <1f4d45f7-b60f-46e5-9295-5251908989bf@collabora.com>
Date: Tue, 14 Jul 2026 15:27:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: fix dmabuf_fd leak on remap failure
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260713125622.111513-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.11;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-op-o11.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/13/26 15:56, marcandre.lureau@redhat.com wrote:
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
> ---
>  hw/display/virtio-gpu-udmabuf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index d5ac1cfca0e..5f08c855dde 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -143,6 +143,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>          }
>          virtio_gpu_remap_udmabuf(res);
>          if (!res->remapped) {
> +            virtio_gpu_destroy_udmabuf(res);
>              return;
>          }
>          pdata = res->remapped;

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

