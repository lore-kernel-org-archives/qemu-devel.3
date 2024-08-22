Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D886DC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh7dQ-0000R8-74; Thu, 22 Aug 2024 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sh7dO-0000LT-U4
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:13:50 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sh7dM-00051I-0O
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 09:13:50 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f04b4abdcso976942e87.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724332425; x=1724937225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UG3JvRTEc0x5xDWPY6B090cCklwAGz/GlZmibGO3yos=;
 b=rTLsWqUOfHLLXxIavkV/ZXVUjdRIL+yfcDPd29+VZ9a0J/DvJTeTeHwxAGOD0xXL+E
 sfaB8VpD3b2r/MmuMg5CsrNz54m6PPW0/Fau2/oZ4UvZb3mmxGF7mh4OAzHNUHrK6VWu
 GoxAM5fR1yRd9RtU0LdU1mLYSkE4LECUiKwngxFxC7cV5/M8uxlKJrqQwBk7PXgmQYUQ
 5XwGt7Ll/izqH5MPdndQa6e27Zdj3ui+ARGAAW/Cr2iEp5cStt2HAvtZIQjf5UPqYYR7
 MM7x434oCtVEns9nxX0Lev5WJTNvc6/ioiwX/4LQa1AnTwBxTCiS7U5L0/zQleq0o6HQ
 TBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724332425; x=1724937225;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UG3JvRTEc0x5xDWPY6B090cCklwAGz/GlZmibGO3yos=;
 b=kHKu/LM1e42BGDglJoFin6ixIUAPMGD0Z3K3QB7tM4l7LF9I60vtTWlGEWqS4XS0aG
 chl/JhLtKbX7F11lxL91VQq9TNxCjSwM4H+yZ6MX9yB67O7hH9HjpwC+LRtQUFOenO4/
 zfoQY66EOxvZkDG/RCYu40OZCORqqaeeUMsusN339ZR/K+vAReJwntIeuFQ4gfil1z2p
 jwKigdkBvdDTl5f22HFaH5SijT+VfNbpxDJQOCsmNmwT3FTFipKPavOop/GFHFeRkSL1
 XPhj89Usq8fpVo2xIvYhcO04S76yE3VYkxyD6isCcMkXgJST7YsNJjOArYWDMPk+PfM8
 IBpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVBPLeirONvf0eA5w1Aj7jgunCSrezLUhLDOw73mR8QKP+a0N+TPYiBTBD2dR0w9/0KReCFH47UsXT@nongnu.org
X-Gm-Message-State: AOJu0YyrNPnl9H/usEnNPNjYA5sjknoGAZVjb30XmXcNBUMw0c1uD93p
 OPOcyMke50+OLEt++6bbjc4qjU7eQFWSVJtbYL6ze7FMc0YOxppV379qb5CoHW4=
X-Google-Smtp-Source: AGHT+IEUF6z3w2PFkheM2DXHZ2ZLVB5JfqyviaJFW+37Mf7BcXif/IAVbM6gZGZ50EFDo6SsiFvo5g==
X-Received: by 2002:a05:6512:2385:b0:52e:76e8:e18e with SMTP id
 2adb3069b0e04-5334fadd850mr1186351e87.7.1724332423984; 
 Thu, 22 Aug 2024 06:13:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f4f437bsm117902366b.197.2024.08.22.06.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:13:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 54A555F8D5;
 Thu, 22 Aug 2024 14:13:42 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Huang Rui <ray.huang@amd.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?rc-Andr=C3=A9?=
 Lureau <marcandre.lureau@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Stefano
 Stabellini <sstabellini@kernel.org>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,  Gert
 Wollny <gert.wollny@collabora.com>,  qemu-devel@nongnu.org,  Gurchetan
 Singh <gurchetansingh@chromium.org>,  ernunes@redhat.com,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  Honglei Huang
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  Chen Jiqian
 <Jiqian.Chen@amd.com>,  Yiwei Zhang <zzyiwei@chromium.org>
Subject: Re: [PATCH v16 00/13] Support blob memory and venus on qemu
In-Reply-To: <20240701164449-mutt-send-email-mst@kernel.org> (Michael S.
 Tsirkin's message of "Mon, 1 Jul 2024 16:45:39 -0400")
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240701164449-mutt-send-email-mst@kernel.org>
Date: Thu, 22 Aug 2024 14:13:42 +0100
Message-ID: <877cc8n1ix.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sun, Jun 23, 2024 at 06:23:30PM +0300, Dmitry Osipenko wrote:
>> Hello,
>>=20
>> This series enables Vulkan Venus context support on virtio-gpu.
>>=20
>> All virglrender and almost all Linux kernel prerequisite changes
>> needed by Venus are already in upstream. For kernel there is a pending
>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>> using TTM [1], othewrwise hostmem blob mapping will fail with a KVM error
>> from Qemu.
>
>
> I'd like to see a Tested-by from Alex Benn=C3=A9e for this -
> he's been testing v14 last as far as I could see.

I've posted it on the top. Broadly x86 and Arm work on my x86 host. So
far my Arm host only runs the x86 image with the AMD card OK.

I've updated my test images so you can try them:

  https://fileserver.linaro.org/s/ce5jXBFinPxtEdx

See the notes on the readme on how to run.

>
>
>> [1] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google=
.com/
>>=20
>> You'll need to use recent Mesa version containing patch that removes
>> dependency on cross-device feature from Venus that isn't supported by
>> Qemu [2].
>>=20
>> [2] https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e269=
87befae78b6ccbb7ae242b
>>=20
>> Example Qemu cmdline that enables Venus:
>>=20
>>   qemu-system-x86_64 -device virtio-vga-gl,hostmem=3D4G,blob=3Dtrue,venu=
s=3Dtrue \
>>       -machine q35,accel=3Dkvm,memory-backend=3Dmem1 \
>>       -object memory-backend-memfd,id=3Dmem1,size=3D8G -m 8G
>>=20
>>=20
>> Changes from V15 to V16
>>=20
>> - Fixed resource_get_info() change made in v15 that was squshed into a
>>   wrong patch. Squashed set_scanout_blob patch into the blob-commands pa=
tch,
>>   otherwise we'll need to revert back ordering of blob patches to older =
v7
>>   variant.
>>=20
>> - Changed hostmem mapping state to boolean, suggested by Akihiko Odaki.
>>=20
>> - Documented Venus in virtio-gpu doc. Amended "Support Venus context" pa=
tch
>>   with the doc addition. Suggested by Akihiko Odaki.
>>=20
>> Changes from V14 to V15
>>=20
>> - Dropped hostmem mapping state that got unused in v14, suggested by
>>   Akihiko Odaki.
>>=20
>> - Moved resource_get_info() from set_scanout_blob() to create_blob(),
>>   suggested by Akihiko Odaki.
>>=20
>> - Fixed unitilized variable in create_blob(), spotted by Alex Benn=C3=A9=
e.
>>=20
>> Changes from V13 to V14
>>=20
>> - Fixed erronous fall-through in renderer_state's switch-case that was
>>   spotted by Marc-Andr=C3=A9 Lureau.
>>=20
>> - Reworked HOSTMEM_MR_FINISH_UNMAPPING handling as was suggested by
>>   Akihiko Odaki. Now it shares the same code path with HOSTMEM_MR_MAPPED.
>>=20
>> - Made use of g_autofree in virgl_cmd_resource_create_blob() as was
>>   suggested by Akihiko Odaki.
>>=20
>> - Removed virtio_gpu_virgl_deinit() and moved all deinit code to
>>   virtio_gpu_gl_device_unrealize() as was suggested by Marc-Andr=C3=A9 L=
ureau.
>>=20
>> - Replaced HAVE_FEATURE in mseon.build with virglrenderer's VERSION_MAJOR
>>   check as was suggested by Marc-Andr=C3=A9 Lureau.
>>=20
>> - Added trace event for cmd-suspension as was suggested by Marc-Andr=C3=
=A9 Lureau.
>>=20
>> - Added patch to replace in-flight printf's with trace events as was
>>   suggested by Marc-Andr=C3=A9 Lureau
>>=20
>> Changes from V12 to V13
>>=20
>> - Replaced `res->async_unmap_in_progress` flag with a mapping state,
>>   moved it to the virtio_gpu_virgl_hostmem_region like was suggested
>>   by Akihiko Odaki.
>>=20
>> - Renamed blob_unmap function and added back cmd_suspended argument
>>   to it. Suggested by Akihiko Odaki.
>>=20
>> - Reordered VirtIOGPUGL refactoring patches to minimize code changes
>>   like was suggested by Akihiko Odaki.
>>=20
>> - Replaced gl->renderer_inited with gl->renderer_state, like was suggest=
ed
>>   by Alex Benn=C3=A9e.
>>=20
>> - Added gl->renderer state resetting to gl_device_unrealize(), for
>>   consistency. Suggested by Alex Benn=C3=A9e.
>>=20
>> - Added rb's from Alex and Manos.
>>=20
>> - Fixed compiling with !HAVE_VIRGL_RESOURCE_BLOB.
>>=20
>> Changes from V11 to V12
>>=20
>> - Fixed virgl_cmd_resource_create_blob() error handling. Now it doesn't
>>   corrupt resource list and releases resource properly on error. Thanks
>>   to Akihiko Odaki for spotting the bug.
>>=20
>> - Added new patch that handles virtio_gpu_virgl_init() failure gracefull=
y,
>>   fixing Qemu crash. Besides fixing the crash, it allows to implement
>>   a cleaner virtio_gpu_virgl_deinit().
>>=20
>> - virtio_gpu_virgl_deinit() now assumes that previously virgl was
>>   initialized successfully when it was inited at all. Suggested by
>>   Akihiko Odaki.
>>=20
>> - Fixed missed freeing of print_stats timer in virtio_gpu_virgl_deinit()
>>=20
>> - Added back blob unmapping or RESOURCE_UNREF that was requested
>>   by Akihiko Odaki. Added comment to the code explaining how
>>   async unmapping works. Added back `res->async_unmap_in_progress`
>>   flag and added comment telling why it's needed.
>>=20
>> - Moved cmdq_resume_bh to VirtIOGPUGL and made coding style changes
>>   suggested by Akihiko Odaki.
>>=20
>> - Added patches that move fence_poll and print_stats timers to VirtIOGPU=
GL
>>   for consistency with cmdq_resume_bh.
>>=20
>> Changes from V10 to V11
>>=20
>> - Replaced cmd_resume bool in struct ctrl_command with
>>   "cmd->finished + !VIRTIO_GPU_FLAG_FENCE" checking as was requested
>>   by Akihiko Odaki.
>>=20
>> - Reworked virgl_cmd_resource_unmap/unref_blob() to avoid re-adding
>>   the 'async_unmap_in_progress' flag that was dropped in v9:
>>=20
>>     1. virgl_cmd_resource_[un]map_blob() now doesn't check itself whether
>>        resource was previously mapped and lets virglrenderer to do the
>>        checking.
>>=20
>>     2. error returned by virgl_renderer_resource_unmap() is now handled
>>        and reported properly, previously the error wasn't checked. The
>>        virgl_renderer_resource_unmap() fails if resource wasn't mapped.
>>=20
>>     3. virgl_cmd_resource_unref_blob() now doesn't allow to unref resour=
ce
>>        that is mapped, it's a error condition if guest didn't unmap reso=
urce
>>        before doing the unref. Previously unref was implicitly unmapping
>>        resource.
>>=20
>> Changes from V9 to V10
>>=20
>> - Dropped 'async_unmap_in_progress' variable and switched to use
>>   aio_bh_new() isntead of oneshot variant in the "blob commands" patch.
>>=20
>> - Further improved error messages by printing error code when actual err=
or
>>   occurrs and using ERR_UNSPEC instead of ERR_ENOMEM when we don't really
>>   know if it was ENOMEM for sure.
>>=20
>> - Added vdc->unrealize for the virtio GL device and freed virgl data.
>>=20
>> - Dropped UUID and doc/migration patches. UUID feature isn't needed
>>   anymore, instead we changed Mesa Venus driver to not require UUID.
>>=20
>> - Renamed virtio-gpu-gl "vulkan" property name back to "venus".
>>=20
>> Changes from V8 to V9
>>=20
>> - Added resuming of cmdq processing when hostmem MR is freed,
>>   as was suggested by Akihiko Odaki.
>>=20
>> - Added more error messages, suggested by Akihiko Odaki
>>=20
>> - Dropped superfluous 'res->async_unmap_completed', suggested
>>   by Akihiko Odaki.
>>=20
>> - Kept using cmd->suspended flag. Akihiko Odaki suggested to make
>>   virtio_gpu_virgl_process_cmd() return false if cmd processing is
>>   suspended, but it's not easy to implement due to ubiquitous
>>   VIRTIO_GPU_FILL_CMD() macros that returns void, requiring to change
>>   all the virtio-gpu processing code.
>>=20
>> - Added back virtio_gpu_virgl_resource as was requested by Akihiko Odaki,
>>   though I'm not convinced it's really needed.
>>=20
>> - Switched to use GArray, renamed capset2_max_ver/size vars and moved
>>   "vulkan" property definition to the virtio-gpu-gl device in the Venus
>>   patch, like was suggested by Akihiko Odaki.
>>=20
>> - Moved UUID to virtio_gpu_virgl_resource and dropped UUID save/restore
>>   since it will require bumping VM version and virgl device isn't mirata=
ble
>>   anyways.
>>=20
>> - Fixed exposing UUID feature with Rutabaga
>>=20
>> - Dropped linux-headers update patch because headers were already updated
>>   in Qemu/staging.
>>=20
>> - Added patch that updates virtio migration doc with a note about virtio=
-gpu
>>   migration specifics, suggested by Akihiko Odaki.
>>=20
>> - Addressed coding style issue noticed by Akihiko Odaki
>>=20
>> Changes from V7 to V8
>>=20
>> - Supported suspension of virtio-gpu commands processing and made
>>   unmapping of hostmem region asynchronous by blocking/suspending
>>   cmd processing until region is unmapped. Suggested by Akihiko Odaki.
>>=20
>> - Fixed arm64 building of x86 targets using updated linux-headers.
>>   Corrected the update script. Thanks to Rob Clark for reporting
>>   the issue.
>>=20
>> - Added new patch that makes registration of virgl capsets dynamic.
>>   Requested by Antonio Caggiano and Pierre-Eric Pelloux-Prayer.
>>=20
>> - Venus capset now isn't advertised if Vulkan is disabled with vulkan=3D=
false
>>=20
>> Changes from V6 to V7
>>=20
>> - Used scripts/update-linux-headers.sh to update Qemu headers based
>>   on Linux v6.8-rc3 that adds Venus capset definition to virtio-gpu
>>   protocol, was requested by Peter Maydel
>>=20
>> - Added r-bs that were given to v6 patches. Corrected missing s-o-bs
>>=20
>> - Dropped context_init Qemu's virtio-gpu device configuration flag,
>>   was suggested by Marc-Andr=C3=A9 Lureau
>>=20
>> - Added missing error condition checks spotted by Marc-Andr=C3=A9 Lureau
>>   and Akihiko Odaki, and few more
>>=20
>> - Returned back res->mr referencing to memory_region_init_ram_ptr() like
>>   was suggested by Akihiko Odaki. Incorporated fix suggested by Pierre-E=
ric
>>   to specify the MR name
>>=20
>> - Dropped the virgl_gpu_resource wrapper, cleaned up and simplified
>>   patch that adds blob-cmd support
>>=20
>> - Fixed improper blob resource removal from resource list on resource_un=
ref
>>   that was spotted by Akihiko Odaki
>>=20
>> - Change order of the blob patches, was suggested by Akihiko Odaki.
>>   The cmd_set_scanout_blob support is enabled first
>>=20
>> - Factored out patch that adds resource management support to virtio-gpu=
-gl,
>>   was requested by Marc-Andr=C3=A9 Lureau
>>=20
>> - Simplified and improved the UUID support patch, dropped the hash table
>>   as we don't need it for now. Moved QemuUUID to virtio_gpu_simple_resou=
rce.
>>   This all was suggested by Akihiko Odaki and Marc-Andr=C3=A9 Lureau
>>=20
>> - Dropped console_has_gl() check, suggested by Akihiko Odaki
>>=20
>> - Reworked Meson cheking of libvirglrender features, made new features
>>   available based on virglrender pkgconfig version instead of checking
>>   symbols in header. This should fix build error using older virglrender
>>   version, reported by Alex Benn=C3=A9e
>>=20
>> - Made enabling of Venus context configrable via new virtio-gpu device
>>   "vulkan=3Dtrue" flag, suggested by Marc-Andr=C3=A9 Lureau. The flag is=
 disabled
>>   by default because it requires blob and hostmem options to be enabled
>>   and configured
>>=20
>> Changes from V5 to V6
>>=20
>> - Move macros configurations under virgl.found() and rename
>>   HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS.
>>=20
>> - Handle the case while context_init is disabled.
>>=20
>> - Enable context_init by default.
>>=20
>> - Move virtio_gpu_virgl_resource_unmap() into
>>   virgl_cmd_resource_unmap_blob().
>>=20
>> - Introduce new struct virgl_gpu_resource to store virgl specific member=
s.
>>=20
>> - Remove erro handling of g_new0, because glib will abort() on OOM.
>>=20
>> - Set resource uuid as option.
>>=20
>> - Implement optional subsection of vmstate_virtio_gpu_resource_uuid_state
>>   for virtio live migration.
>>=20
>> - Use g_int_hash/g_int_equal instead of the default
>>=20
>> - Add scanout_blob function for virtio-gpu-virgl
>>=20
>> - Resolve the memory leak on virtio-gpu-virgl
>>=20
>> - Remove the unstable API flags check because virglrenderer is already 1=
.0
>>=20
>> - Squash the render server flag support into "Initialize Venus"
>>=20
>> Changes from V4 (virtio gpu V4) to V5
>>=20
>> - Inverted patch 5 and 6 because we should configure
>>   HAVE_VIRGL_CONTEXT_INIT firstly.
>>=20
>> - Validate owner of memory region to avoid slowing down DMA.
>>=20
>> - Use memory_region_init_ram_ptr() instead of
>>   memory_region_init_ram_device_ptr().
>>=20
>> - Adjust sequence to allocate gpu resource before virglrender resource
>>   creation
>>=20
>> - Add virtio migration handling for uuid.
>>=20
>> - Send kernel patch to define VIRTIO_GPU_CAPSET_VENUS.
>>   https://lore.kernel.org/lkml/20230915105918.3763061-1-ray.huang@amd.co=
m/
>>=20
>> - Add meson check to make sure unstable APIs defined from 0.9.0.
>>=20
>> Changes from V1 to V2 (virtio gpu V4)
>>=20
>> - Remove unused #include "hw/virtio/virtio-iommu.h"
>>=20
>> - Add a local function, called virgl_resource_destroy(), that is used
>>   to release a vgpu resource on error paths and in resource_unref.
>>=20
>> - Remove virtio_gpu_virgl_resource_unmap from
>>   virtio_gpu_cleanup_mapping(),
>>   since this function won't be called on blob resources and also because
>>   blob resources are unmapped via virgl_cmd_resource_unmap_blob().
>>=20
>> - In virgl_cmd_resource_create_blob(), do proper cleanup in error paths
>>   and move QTAILQ_INSERT_HEAD(&g->reslist, res, next) after the resource
>>   has been fully initialized.
>>=20
>> - Memory region has a different life-cycle from virtio gpu resources
>>   i.e. cannot be released synchronously along with the vgpu resource.
>>   So, here the field "region" was changed to a pointer and is allocated
>>   dynamically when the blob is mapped.
>>   Also, since the pointer can be used to indicate whether the blob
>>   is mapped, the explicite field "mapped" was removed.
>>=20
>> - In virgl_cmd_resource_map_blob(), add check on the value of
>>   res->region, to prevent beeing called twice on the same resource.
>>=20
>> - Add a patch to enable automatic deallocation of memory regions to reso=
lve
>>   use-after-free memory corruption with a reference.
>>=20
>>=20
>> Antonio Caggiano (1):
>>   virtio-gpu: Support Venus context
>>=20
>> Dmitry Osipenko (8):
>>   virtio-gpu: Use trace events for tracking number of in-flight fences
>>   virtio-gpu: Move fence_poll timer to VirtIOGPUGL
>>   virtio-gpu: Move print_stats timer to VirtIOGPUGL
>>   virtio-gpu: Handle virtio_gpu_virgl_init() failure
>>   virtio-gpu: Unrealize GL device
>>   virtio-gpu: Use pkgconfig version to decide which virgl features are
>>     available
>>   virtio-gpu: Don't require udmabuf when blobs and virgl are enabled
>>   virtio-gpu: Support suspension of commands processing
>>=20
>> Huang Rui (2):
>>   virtio-gpu: Support context-init feature with virglrenderer
>>   virtio-gpu: Add virgl resource management
>>=20
>> Pierre-Eric Pelloux-Prayer (1):
>>   virtio-gpu: Register capsets dynamically
>>=20
>> Robert Beckett (1):
>>   virtio-gpu: Handle resource blob commands
>>=20
>>  docs/system/devices/virtio-gpu.rst |  11 +
>>  hw/display/trace-events            |   3 +
>>  hw/display/virtio-gpu-gl.c         |  62 ++-
>>  hw/display/virtio-gpu-virgl.c      | 585 +++++++++++++++++++++++++++--
>>  hw/display/virtio-gpu.c            |  44 ++-
>>  include/hw/virtio/virtio-gpu.h     |  32 +-
>>  meson.build                        |   5 +-
>>  7 files changed, 685 insertions(+), 57 deletions(-)
>>=20
>> --=20
>> 2.45.2

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

