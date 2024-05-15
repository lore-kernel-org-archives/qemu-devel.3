Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E28C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 16:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7HPg-0005Fm-69; Wed, 15 May 2024 12:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7HPe-0005FF-OU
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:23:30 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1s7HPd-0007ua-6p
 for qemu-devel@nongnu.org; Wed, 15 May 2024 12:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715790207;
 bh=zpzMGmc98/xu7wFEnAtX5VJu6LL/yqgLrXRPltoUDgQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SbHjbPNGmjDeCHXCPubWZRm85RCZ3vXkQN5RWW4+0ZkotVbq8dOyb+o73tp2Rr2nB
 1NjA/MHUXGueerWY1LmD2xyv3eKslSShO9KEdR1lpNqxAT47P7hfbASF5njhUWf29O
 3QVWRebzIPkpHF3P0SU0S7DtENXDeyrydrl/u0aZnohK85DvGgspWJLDol/0IbYgid
 hko57DEqdSlPR8ytSN4sFTPJaBYNim+RU//dOqOA45qaFErw9iV58pH3Ar2MWgcla4
 S4k2oNRHCImfJDqOm3HRhs66Z5QhTnkNHFqwePqrRtQs0S4jHstqp50ngwfQXo2lZS
 q2+nwdcbF8wdg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3CB33782157;
 Wed, 15 May 2024 16:23:25 +0000 (UTC)
Message-ID: <a3fb39fe-843d-4769-8b98-6d8a977bb903@collabora.com>
Date: Wed, 15 May 2024 19:23:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] virtio-gpu: Register capsets dynamically
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
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240511182251.1442078-1-dmitry.osipenko@collabora.com>
 <20240511182251.1442078-10-dmitry.osipenko@collabora.com>
 <f9291d63-dd25-49e2-8338-426f5b206861@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <f9291d63-dd25-49e2-8338-426f5b206861@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
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

On 5/13/24 12:20, Akihiko Odaki wrote:
...
>>   -int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g)
>> +static void virtio_gpu_virgl_add_capset(GArray *capset_ids, uint32_t
>> capset_id)
>> +{
>> +    g_array_append_val(capset_ids, capset_id);
>> +}
> 
> Is it worthwhile to have a function for this?

It's necessary to have it because g_array_append_val() is actually a macro that takes &capset_id ptr internally. 

I.e. g_array_append_val(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2) will fail to compile with:

/usr/include/glib-2.0/glib/garray.h:66:59: error: lvalue required as unary '&' operand
   66 | #define g_array_append_val(a,v)   g_array_append_vals (a, &(v), 1)

-- 
Best regards,
Dmitry


