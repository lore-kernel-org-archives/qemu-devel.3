Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE164C531F9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 07:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wntLP-0000do-4u; Sun, 26 Jul 2026 03:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wntLK-0000YQ-Ox; Sun, 26 Jul 2026 03:32:14 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wntLF-0003AQ-IP; Sun, 26 Jul 2026 03:32:13 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q7VGDO015572
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 16:31:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=BNlYYOgHbLVXUDxrvxzaZs1qSsKTFjBZovszZv2GWkI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785051076; v=1;
 b=WHrt++18jB4TsCd63UCUijMYw40y9fUbv8Sn0XH4IyufzE0N78M3dMxZBcLwJwx2
 DF1tckUw7/iOg59c/KT9j3Q2w+oclMHZGS9hHRydYPMKEFvA2fWpbvGzw1EUzzTs
 lFSQcKHoOvON7A9mOEwKCr9ODbH/rroKtD06CCW7wOg2oXyqmTSPV1b5n7n1sXRj
 zBGOVSSDDUCraunp5nbx4rHdMZZoPVPvTZrImpwMG+vOhR9qyCNMv1olyKGwd9bo
 zENkYSZC18KymbQ1+FdQJ9CzVP5eVPyHLP8Tu3+2NYlwvYP6faARf62wQ5XDo9kt
 ctJ7IF7eUhApk1ot7Kwd/Q==
Message-ID: <7716c428-d479-4fd4-beec-bafbf5f3b439@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 16:31:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] qdev-monitor: drain RCU callbacks in
 qdev_device_add_from_qdict
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
 <20260725-fix2-v1-7-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-7-5c9a6ce7b96a@redhat.com>
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
> qmp_device_add() and hmp_device_add() drain pending RCU callbacks after
> a failed device_add, since some bus teardown (e.g. bus_remove_child())
> is deferred to call_rcu(). -device on the command line reaches the same
> qdev_device_add_from_qdict() with errp pointing at error_fatal, whose
> ERRP_GUARD() exits before control returns to the caller, so the caller's
> drain_call_rcu() never runs.
> 
> Move the drain into qdev_device_add_from_qdict()'s own err_del_dev path
> so it always runs, and drop the now-redundant calls in qmp_device_add()
> and hmp_device_add().

It is reachable from virtio-net failover during guest feature 
negotiation. MMIO dispatch holds an RCU read lock at 
address_space_write(). If deferred primary creation fails, 
drain_call_rcu() waits for a grace period while its own thread remains a 
reader, deadlocking the VM.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/qdev-monitor.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 00fed791cce1..884d407d60d4 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -746,6 +746,16 @@ err_del_dev:
>       object_unparent(OBJECT(dev));
>       object_unref(OBJECT(dev));
>   
> +    /*
> +     * Drain all pending RCU callbacks. This is done because some bus
> +     * related operations can delay a device removal (in this case this
> +     * can happen if device is added and then removed due to a
> +     * configuration error) to a RCU callback, but a caller might expect
> +     * the failed device to be fully torn down once this function
> +     * returns.
> +     */
> +    drain_call_rcu();
> +
>       return NULL;
>   }
>   
> @@ -870,18 +880,6 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>       DeviceState *dev;
>   
>       dev = qdev_device_add_from_qdict(qdict, true, errp);
> -    if (!dev) {
> -        /*
> -         * Drain all pending RCU callbacks. This is done because
> -         * some bus related operations can delay a device removal
> -         * (in this case this can happen if device is added and then
> -         * removed due to a configuration error)
> -         * to a RCU callback, but user might expect that this interface
> -         * will finish its job completely once qmp command returns result
> -         * to the user
> -         */
> -        drain_call_rcu();
> -    }
>       object_unref(OBJECT(dev));
>   }
>   
> @@ -1017,17 +1015,6 @@ void hmp_device_add(Monitor *mon, const QDict *qdict)
>       }
>       dev = qdev_device_add(opts, &err);
>       if (!dev) {
> -        /*
> -         * Drain all pending RCU callbacks. This is done because
> -         * some bus related operations can delay a device removal
> -         * (in this case this can happen if device is added and then
> -         * removed due to a configuration error)
> -         * to a RCU callback, but user might expect that this interface
> -         * will finish its job completely once qmp command returns result
> -         * to the user
> -         */
> -        drain_call_rcu();
> -
>           qemu_opts_del(opts);
>       }
>       object_unref(dev);
> 


