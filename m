Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EDEC531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 08:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnuFk-0002bv-GB; Sun, 26 Jul 2026 04:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnuFZ-0002aB-Ej; Sun, 26 Jul 2026 04:30:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnuFV-0000sV-VY; Sun, 26 Jul 2026 04:30:21 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q8Tbj8033700
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 26 Jul 2026 17:29:37 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eaMYy3YOaqsRdJ5DdcF4RsKABxoEZJAP/dzLLdBqc44=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785054577; v=1;
 b=klv6+hs+UryjxdiAUDTjc5V/yv2vH9jS6OvszJdXTjpTadArE6W2T9Tu0xskw89m
 vMUqaFQuSf2JxA0VIZ2p8/MTeEQ6w/MTlZsRkGcylg/ZtQoiC7RFpXNIc667ow4O
 tAYoShhMi5XkLuy9iiCDzgQgs9et2qkxcJqT3kBSBmyREXOXs9PehJ8sJhYk1Zr/
 AN+yzn4NuggaM91HcZUcS/JprySpuB846RYsqT/yRHAB4DdVgfXLS4JNjZQERSLN
 l7mWwrFoCYzyfRFHvzUyqRkGPv3t7ZQN4+5eeblO+9t8sLxI2zA7waa1HHkBsH4C
 FFIBm3onY4HUom9DZ8Ip3w==
Message-ID: <f919e684-93ed-4eca-8ddc-785e69dd8add@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 17:29:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] Fix many -Werror=maybe-uninitialized
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
 <20260725-fix2-v1-3-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-3-5c9a6ce7b96a@redhat.com>
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
> When compiled with -Og, gcc produces many false-positives
> gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
> 
> We already use auto-var-init=zero, but better be explicit.

I'm kind of reluctant to describe it is more explicit and it is better. 
The variables causing the false positives do not contain a useful value 
until later assignments. Initializing them obscures the fact and 
suppresses useful warnings. This patch may serve as a workaround, but 
its scope should be minimized.

I think WITH_QEMU_LOCK_GUARD() should be fixed to explicitly tell that 
the block is unconditionally executed. Linux does so, for example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fcc22ac5baf06dd17193de44b60dbceea6461983
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/blkio.c                 |  4 ++--
>   block/qcow2.c                 |  2 +-
>   hw/cxl/cxl-host.c             |  2 +-
>   hw/scsi/scsi-disk.c           |  2 +-
>   hw/scsi/scsi-generic.c        |  4 ++--
>   hw/scsi/virtio-scsi.c         |  2 +-
>   io/net-listener.c             | 10 +++++-----
>   target/i386/cpu.c             |  3 ++-
>   target/i386/emulate/x86_mmu.c |  4 ++--
>   9 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index d2ba2a4d58dc..f7cb6e0b57d4 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -278,7 +278,7 @@ static bool blkio_completion_fd_poll(void *opaque)
>   {
>       BlockDriverState *bs = opaque;
>       BDRVBlkioState *s = bs->opaque;
> -    int ret;
> +    int ret = -1;
>   
>       /* Just in case we already fetched a completion */
>       if (s->poll_completion.user_data != NULL) {
> @@ -559,7 +559,7 @@ static bool blkio_register_buf(BlockDriverState *bs, void *host, size_t size,
>       BDRVBlkioState *s = bs->opaque;
>       struct blkio_mem_region region;
>       BlkioMemRegionResult region_result;
> -    int ret;
> +    int ret = -1;
>   
>       /*
>        * Mapping memory regions conflicts with RAM discard (virtio-mem) when
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 19271b10a49f..639593d737c8 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -838,7 +838,7 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
>   static void coroutine_fn cache_clean_timer(void *opaque)
>   {
>       BDRVQcow2State *s = opaque;
> -    uint64_t wait_ns;
> +    uint64_t wait_ns = 0;
>   
>       WITH_QEMU_LOCK_GUARD(&s->lock) {
>           wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 7e744312f1d8..eba13c9e7cba 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>       MemoryRegion *mr = NULL;
>       uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>       MemoryRegion *direct_mr;
> -    g_autofree char *direct_mr_name;
> +    g_autofree char *direct_mr_name = NULL;

This fixes a real issue, not a false positive. An early return can 
trigger a cleanup on an uninitialized variable.

Regards,
Akihiko Odaki

>       unsigned int idx = state->hdm_decoder_idx;
>   
>       if (ct3d->hostvmem) {
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index 1b0cce128c5e..82dc75cb7d10 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -3263,7 +3263,7 @@ static bool scsi_disk_pr_state_needed(void *opaque)
>   {
>       SCSIDiskState *s = opaque;
>       SCSIPRState *pr_state = &s->qdev.pr_state;
> -    bool ret;
> +    bool ret = false;
>   
>       if (!s->qdev.migrate_pr) {
>           return false;
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index 8999f3b72006..b044561ae2dd 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -553,8 +553,8 @@ bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp)
>       SCSIPRState *pr_state = &s->pr_state;
>       Error *local_err = NULL;
>       bool check_stale_key = true;
> -    uint64_t key;
> -    uint8_t resv_type;
> +    uint64_t key = 0;
> +    uint8_t resv_type = 0;
>   
>       /* Get the migrated PR state */
>       WITH_QEMU_LOCK_GUARD(&pr_state->mutex) {
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 6c7376801190..833f773d7f6c 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1093,7 +1093,7 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
>   
>   static void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
>   {
> -    bool events_dropped;
> +    bool events_dropped = false;
>   
>       WITH_QEMU_LOCK_GUARD(&s->event_lock) {
>           events_dropped = s->events_dropped;
> diff --git a/io/net-listener.c b/io/net-listener.c
> index 1fd0f6cb5ab8..8df19c35bd8f 100644
> --- a/io/net-listener.c
> +++ b/io/net-listener.c
> @@ -54,11 +54,11 @@ static gboolean qio_net_listener_channel_func(QIOChannel *ioc,
>                                                 gpointer opaque)
>   {
>       QIONetListener *listener = QIO_NET_LISTENER(opaque);
> -    QIOChannelSocket *sioc;
> -    QIONetListenerClientFunc io_func;
> -    gpointer io_data;
> -    GMainContext *context;
> -    AioContext *aio_context;
> +    QIOChannelSocket *sioc = NULL;
> +    QIONetListenerClientFunc io_func = NULL;
> +    gpointer io_data = NULL;
> +    GMainContext *context = NULL;
> +    AioContext *aio_context = NULL;
>   
>       sioc = qio_channel_socket_accept(QIO_CHANNEL_SOCKET(ioc),
>                                        NULL);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5805d33ab92d..e9759ab25077 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
>   static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>                                            Error **errp)
>   {
> -    const AVX10VersionDefinition *def;
> +    const AVX10VersionDefinition *def = NULL;
>       CPUX86State *env = &cpu->env;
>   
>       if (!version) {
> @@ -7758,6 +7758,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>           }
>       }
>   
> +    assert(def != NULL);
>       if (def->version < version) {
>           error_setg(errp, "avx10-version can be at most %d", def->version);
>           return false;
> diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> index 8d4371467fd7..c1cb385b3228 100644
> --- a/target/i386/emulate/x86_mmu.c
> +++ b/target/i386/emulate/x86_mmu.c
> @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
>       int largeness = 0;
>       target_ulong cr3 = x86_read_cr(cpu, 3);
>       uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
> -    MMUTranslateResult res;
> -
> +    MMUTranslateResult res = 0;
> +
>       memset(pt, 0, sizeof(*pt));
>       top_level = gpt_top_level(cpu, pae);
>   
> 


