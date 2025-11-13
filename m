Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA6ECCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJOUo-0001RB-Vo; Wed, 12 Nov 2025 22:59:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vJOUQ-0001GT-L4
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:59:26 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vJOUO-0002q5-NR
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:59:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763006338; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=W/H5kebajx7qlVJ6v2aYd7NuL/Sye2hCG+siK3fnDahu/6kSonxh8IJAYyoicGcZfCOWGVjSuE7ruoiSp3iMB3x8B6BS+FKH4ylmFMxMmj1T4NYSgx0kGDRFTgR76kg7h3IgHeSdORFhT13zuWWYAxkem+FwYLV6oMvyDawthPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763006338;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=A6sM6Vvl8J9vS3utB4GCO4McAGsz7HmVbeEYidPe1do=; 
 b=XjeklQGB4iD3qZsgHrQlZJfv6rXo8DJSLP8FGSA88JI1XbDnPrkgONRwVasiDV5UcJW0XinQc8EUG0t1q99GjgNhEJ2n0dVt+lGCpXo2HHc834orXyWMeRmlBVF7HoYCU98OhfCkEkGnKbOgLhBZKxF1usSCkiQGUDG4D6KjIXY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763006338; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=A6sM6Vvl8J9vS3utB4GCO4McAGsz7HmVbeEYidPe1do=;
 b=UbcDJ7uoiCVzyieNNjOaisW+xKMJ5BuNhS3OM2Wua83sCHTyrKggp1KixnKfu3d8
 tKelWlTEuiVnNojFvPXWetgX0G1Atv9MLWapRPlJoh4VmoR3715sGxFGTsudjkFtwdE
 R7b+myFzZcWCqoymELnqj99qXvFIlES48BEXkv3w=
Received: by mx.zohomail.com with SMTPS id 1763006336367533.089763036403;
 Wed, 12 Nov 2025 19:58:56 -0800 (PST)
Message-ID: <488e973e-7e4f-447a-b007-635e8974036c@collabora.com>
Date: Thu, 13 Nov 2025 06:58:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 04/10] virtio-gpu: Support asynchronous fencing
To: Yiwei Zhang <zzyiwei@gmail.com>
Cc: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-5-dmitry.osipenko@collabora.com>
 <CAJ+hS_h4gwe+yaUrcQ5ibdEAFqya=SOb4KLT5HmgG_ZGtJnMSQ@mail.gmail.com>
 <CAJ+hS_gPoaSc-VfoOENgyHZRhFAkUzizoGHm3xJz2trb0jsZAg@mail.gmail.com>
 <f2c322f2-c111-455d-a8b5-17162effac09@collabora.com>
 <CAJ+hS_g4kXwpfd4Xc41nLrii8LciJDGgqQ18xheZudjJq4Fu8A@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJ+hS_g4kXwpfd4Xc41nLrii8LciJDGgqQ18xheZudjJq4Fu8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/12/25 03:44, Yiwei Zhang wrote:
...
>>> Friendly ping. My early comments here might have been missed ; )
>>
>> I indeed missed that first part of the comment, thanks.
>>
>> Could you please give a code sample of your suggestion?
>>
>> The `if (f->ring_idx >= 0)` is a sanity-check for that we're not getting
>> a fence that has ring_idx without a set RING_IDX flag. All other fences
>> are processed by that fence-handling loop.
>>
>> --
>> Best regards,
>> Dmitry
> 
> QEMU creates ctx0 fences without seeing the RING_IDX flag, and I think
> that sanity check is a bit redundant. So I was suggesting below for
> simplicity:
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index ccba1d8ee4..12c1e1764c 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -1117,9 +1117,6 @@ static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>                  if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
>                      continue;
>                  }
> -            } else if (f->ring_idx >= 0) {
> -                /* ctx0 GL-query fences don't have ring info */
> -                continue;
>              }
>              virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
>              QTAILQ_REMOVE(&g->fenceq, cmd, next);
> @@ -1137,7 +1134,7 @@ static void virtio_gpu_virgl_async_fence_bh(void *opaque)
> 
>  static void
>  virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
> -                                  int64_t ring_idx, uint64_t fence_id)
> +                                  uint32_t ring_idx, uint64_t fence_id)
>  {
>      struct virtio_gpu_virgl_context_fence *f;
>      VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> @@ -1156,7 +1153,7 @@ static void virgl_write_async_fence(void
> *opaque, uint32_t fence)
>  {
>      VirtIOGPU *g = opaque;
> 
> -    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
> +    virtio_gpu_virgl_push_async_fence(g, 0, UINT32_MAX, fence);
>  }
> 
>  static void virgl_write_async_context_fence(void *opaque, uint32_t ctx_id,
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index a4963508a4..cd576c9e0d 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -238,7 +238,7 @@ struct VirtIOGPUClass {
> 
>  struct virtio_gpu_virgl_context_fence {
>      uint32_t ctx_id;
> -    int64_t ring_idx;
> +    uint32_t ring_idx;
>      uint64_t fence_id;
>      QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
>  };

Should work, thanks.

-- 
Best regards,
Dmitry

