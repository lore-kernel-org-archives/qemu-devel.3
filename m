Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D98CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 04:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8WmA-0001x5-H1; Tue, 14 Oct 2025 00:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8Wm7-0001uU-MQ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:36:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v8Wm3-00009v-Sr
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 00:36:39 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59E4aJiQ027601
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 14 Oct 2025 13:36:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=4cULH85QF01K0eQfR1JPQGuRdq1d6VbPh6tjBoChAw0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1760416580; v=1;
 b=Uy5MbSHGLQ7w7xL5Jdg5Z3ms0oy3Q5JugVmvCcJU8sKukHSOFmjReJCYOzb5m5l/
 U7XsuOezio35Hx0Y03NSxkavoAF4mn+rFXQYdZ3cesvFeM9MvNZR+C7ko5eAE3G4
 uLOlE5ibUvlPFNrsXH1RdGU85loarJZJGcMoYhkKJSj3LfnFwDqCiVOznzXd8Qn0
 9D63Xw7KVJ7CkMkrDpsds+blNJLpCI6t1xdm+IgkEbwSaTiFKJDG8p238joFZBvP
 bQ9Cr1I3Uog/DuL7uR5m3OCKb6dIyb0Cv7Lqq64lgP2Rln+/yqPgFkLR62QptorH
 hTBd2OsX5bj5ukFofGYLpA==
Message-ID: <2d72c77c-6ea1-45e5-b23e-e1d64cb716fa@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 14 Oct 2025 13:36:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-2-vivek.kasireddy@intel.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251003234138.85820-2-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/04 8:35, Vivek Kasireddy wrote:
> There are cases when a blob resource's backing might get detached
> and re-attached again such as when the underlying object is getting
> migrated in the Guest. In these situations, we need to obtain a new
> dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().
 > > Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/virtio-gpu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index de35902213..70e8757128 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -937,6 +937,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU *g,
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           return;
>       }
> +
> +    if (res->blob_size && res->dmabuf_fd < 0) {

Checking res->dmabuf_fd should be unnecessary because it is always < 0 
when !res->iov && res->blob_size.

virtio_gpu_cleanup_mapping() is the function that sets res->iov to NULL, 
and it ensures res->dmabuf_fd < 0 by calling virtio_gpu_fini_udmabuf() 
when res->blob_size != 0.

