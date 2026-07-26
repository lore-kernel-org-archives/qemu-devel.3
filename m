Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F83AC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 08:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnudu-00079h-6w; Sun, 26 Jul 2026 04:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnudr-00079T-SR; Sun, 26 Jul 2026 04:55:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnudp-0002zy-0C; Sun, 26 Jul 2026 04:55:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q8spD6041554
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 17:54:51 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zLiyvFbK0EZfPQhzcGaxWTV73bEQVJG8/gJeaWqLKas=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785056091; v=1;
 b=tdXf8xzTF4jl9mgPvb+xLc5UE+wFmGPZQKm1LIbowW7Ot/9MY3LCFVFQDCPgRCSR
 k8sGdP5gIf75509VfKMEW/UZZTp00rXCJcMOan6+s49TkvWgA1XGDzCBbvanzAwB
 Qp/swMScHMfGfZiOXBb7tXJp7pXq6B3ZkbdzwmL1S9nHqwTpcC9sHxI7hiG/ygKH
 IfyNH86QCFkSFsH2qTI37F4nRtNdsn/1My1lntFWKjw4mbLvtnzT7rlPiywo1NCG
 OkfNN5cYC7CmWVLvZc7MBCNETeXnRTc20MIv8xvYLw6ItY2FaEypQjFOL7XQlqxr
 oqXK4ATth/GUc4kBAYu48Q==
Message-ID: <e982d318-965f-4f0f-a709-37808e1149ca@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 17:54:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/core/machine: free machine->fdt in
 machine_finalize()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-5-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-5-5c9a6ce7b96a@redhat.com>
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

On 2026/07/25 23:00, Marc-André Lureau wrote:
> machine->fdt is a plain g_malloc0() buffer (see create_device_tree())
> that boards populate during MachineClass::init, but machine_finalize()
> never freed it, unlike the other boot-time buffers (dtb, dumpdtb,
> kernel_filename, ...). Free it for consistency.

This unfortunately converts an existing bug into double-free.

spapr_machine_reset() aliases machine->fdt to spapr->fdt_blob. 
spapr_dtb_pre_load() and h_update_dt() later free it via
spapr->fdt_blob, but does not update machine->fdt, making it dangling.

Leaving machine->fdt dangling is already a bug. 
do_client_architecture_support() explains that as follows:

     /*
      * Set the machine->fdt pointer again since we just freed
      * it above (by freeing spapr->fdt_blob). We set this
      * pointer to enable support for the 'dumpdtb' QMP/HMP
      * command.
      */
     MACHINE(spapr)->fdt = fdt;

This patch introduces another path to trigger the bug.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 805148678d57..2b24d711d76f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1301,6 +1301,7 @@ static void machine_finalize(Object *obj)
>       g_free(ms->kernel_cmdline);
>       g_free(ms->dtb);
>       g_free(ms->dumpdtb);
> +    g_free(ms->fdt);
>       g_free(ms->dt_compatible);
>       g_free(ms->firmware);
>       g_free(ms->device_memory);
> 


