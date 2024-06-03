Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46249C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 05:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0JX-00013Z-D2; Mon, 03 Jun 2024 01:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sE0JW-00012g-DZ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:32:58 -0400
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sE0JU-0002nk-PR
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1717392773;
 bh=d3p3lRB8JfEMnCvcV1Imtog0nLtNVAqOAWlLSnGRBY8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZwNWQTH2eOCogYK46Yi9exQqt8aPYTXGn/4pyKcV06BGnDiF5MB+H45yYWLcbsfbV
 BcD+nkcMAXNJDDeHmNvvgs5oWcJdgqz8Ms6ScDJmE/GvmxxOJe1AKQbMwPkJW+k6gB
 7Vvn9PjBcLBMcMZg2jcXakul9WuT7gXx01tozQ6rlY7xy6fwD6QQ31vxcMVXg4433n
 IpcF/Ed7unahOD4CQaw+SD2TDZB/HWhTemwzN/KBkXpjjd0E10BT+9QKLxfdT6uyC/
 HW6BCqNq60QwnIqL+s9la2+LCJSQUdsB0I5ePPjJI4J3aY133kXJ+y97o2PeTOL2eC
 YL8O68KtcwT3A==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1CA837809CE;
 Mon,  3 Jun 2024 05:32:51 +0000 (UTC)
Message-ID: <4d75ecad-8205-4854-85f6-774db6b55404@collabora.com>
Date: Mon, 3 Jun 2024 08:32:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 11/13] virtio-gpu: Handle resource blob commands
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-12-dmitry.osipenko@collabora.com>
 <dba6eb97-e1d1-4694-bfb6-e72db95715dd@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <dba6eb97-e1d1-4694-bfb6-e72db95715dd@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=46.235.227.194;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/2/24 08:45, Akihiko Odaki wrote:
...
>> +    case HOSTMEM_MR_FINISH_UNMAPPING:
>> +        ret = virgl_renderer_resource_unmap(res->base.resource_id);
>> +        if (ret) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: failed to unmap virgl resource: %s\n",
>> +                          __func__, strerror(-ret));
>> +            return ret;
>> +        }
>> +        res->mr = NULL;
>> +        g_free(vmr);
>> +        break;
>> +    case HOSTMEM_MR_UNMAPPING:
>> +        *cmd_suspended = true;
> 
> This code path should be unreachable since the command processing is
> blocked while unmapping.

Will change to abort()

>> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>> sizeof(cblob),
>> +                                            cmd, &res->base.addrs,
>> +                                            &res->base.iov,
>> &res->base.iov_cnt);
>> +        if (!ret) {
>> +            g_free(res);
> 
> As noted for an earlier version:
>> Use g_autofree instead of writing duplicate g_free() calls. See
>> docs/devel/style.rst for details.

The g_autofree isn't appropriate for this code. It's intended to be used
if you allocate a tmp variable that should be freed in all code paths.
This is not the case here, the res variable isn't temporal and shall not
be freed on success.

-- 
Best regards,
Dmitry


