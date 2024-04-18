Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F77DC05023
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTZ4-0003Me-23; Thu, 18 Apr 2024 11:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rxTZ1-0003LH-Nr
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:40 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1rxTZ0-0004ta-1Q
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1713453631;
 bh=EiAuudDgstcvn9E/vSNNH/dpfPFMZhFN6EpCRvLSr0I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z6ncbRCXYomdTrNqDBQEd76Ofz+pDnJdNvXbefEmgcFBY1UfswYj8vUjU7DJ2bxpR
 swO7zkvWQh57farc3NZEqpwGCaAkSu5qHncRfe3QIEUAqZnP2Ogyyz0Rjk7JOiw7CT
 7MDZyyfv7G4mSGvkbkQUIbLgdgGDqb3I2K68sc+zYBtA02Nx2iAktVh2l+f+oNqNNV
 p4yuWwu6N+FlHZ6ddcamH8rU9epcWup+KIOtIQ/9t5pkrM92EejvhxnfdEME1VygUY
 36S6XW2bO0ozmkkp70mjae4ihA3nmOPEHlYlxV67WlQu/i1Qpn9vdFnFS30QWZEykp
 j1zKprcrJlP8Q==
Received: from [IPV6:fd00::1:f0c8] (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 943663782117;
 Thu, 18 Apr 2024 15:20:29 +0000 (UTC)
Message-ID: <2858607a-9ac4-4be9-a2fd-515c8e5d9884@collabora.com>
Date: Thu, 18 Apr 2024 18:20:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] virtio-gpu: Handle resource blob commands
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <20240411102002.240536-8-dmitry.osipenko@collabora.com>
 <29a55f63-593e-46d0-8dfe-f55e2b2de7ac@daynix.com>
 <918fb26b-72e9-446a-841b-810eb983dabe@collabora.com>
 <83e4454f-98d5-4e7d-b8d0-46d3d52442b1@daynix.com>
 <68c33b13-83ea-4ea4-b219-43a930a6ad10@collabora.com>
 <1fc1d55d-7eb7-49f4-9ed1-f52fe34cc876@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <1fc1d55d-7eb7-49f4-9ed1-f52fe34cc876@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/15/24 13:05, Akihiko Odaki wrote:
...
>> Do you have example of a legit use-case where hostmem MR could outlive
>> resource mapping?
> 
> MR outliving after memory_region_del_subregion() is not a use-case, but
> a situation that occurs due to the limitation of the memory subsystem.
> It is not easy to answer how often such a situation happens.
> 
>>
>> Turning it into a error condition is much more reasonable to do than to
>> to worry about edge case that nobody cares about, which can't be tested
>> easily and that not trivial to support, IMO.
>>
> I'm not sure what you mean by turning into an error condition. I doubt
> it's possible to emit errors when someone touches an unmapped region.

My idea was about failing in virtio_gpu_virgl_unmap_resource_blob()
where we could check whether MR has external reference and fail if it has.

> Reproducing this issue is not easy as it's often cases for
> use-after-free bugs, but fixing it is not that complicated in my opinion
> since you already have an implementation which asynchronously unmaps the
> region in v6. I write my suggestions to fix problems in v6:
> 
> - Remove ref member in virgl_gpu_resource, vres_get_ref(),
> vres_put_ref(), and virgl_resource_unmap().
> 
> - Change virtio_gpu_virgl_process_cmd(),
> virgl_cmd_resource_unmap_blob(), and virgl_cmd_resource_unref() to
> return a bool, which tells if the command was processed or suspended.
> 
> - In virtio_gpu_process_cmdq(), break if the command was suspended.
> 
> - In virgl_resource_blob_async_unmap(), call virtio_gpu_gl_block(g, false).
> 
> - In virgl_cmd_resource_unmap_blob() and virgl_cmd_resource_unref(),
> call memory_region_del_subregion() and virtio_gpu_gl_block(g, true), and
> tell that the command was suspended if the reference counter of
> MemoryRegion > 0. Free and unmap the MR otherwise.

Your suggestion works, I'll proceed with it in v8.

Thanks for the review

-- 
Best regards,
Dmitry


