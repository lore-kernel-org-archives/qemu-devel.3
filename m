Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C808DFD2D6A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:28:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwBQ-0000N4-VR; Tue, 10 Mar 2026 08:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzwBQ-0000Mv-1N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzwBN-0004mw-4f
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773145647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJfKQ4dXsqjvoihzvspqhioTrfp+CQNoN4jqg8Vgq44=;
 b=bVI8oyh3nSEMCKQqzdI8H2kIaWxYNEwDk3ONrqmtjQKw4WOpNEOCXrBqpJIf+T5Fzk2ibt
 03nnXf9E/uWjaju9VwEr/hCt9UIfj1IISHetokNQ0NIkYNESndmST62ccJs1E2/AILR8ci
 D9Z1v43/3Px37wGzDJr4O9S2si+c8tM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-bRFR489mMzKDiuNgHU2GoA-1; Tue,
 10 Mar 2026 08:27:24 -0400
X-MC-Unique: bRFR489mMzKDiuNgHU2GoA-1
X-Mimecast-MFC-AGG-ID: bRFR489mMzKDiuNgHU2GoA_1773145643
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90DC01800345; Tue, 10 Mar 2026 12:27:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5A751956095; Tue, 10 Mar 2026 12:27:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F35121E675A; Tue, 10 Mar 2026 13:27:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  berrange@redhat.com,
 mst@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH] qdev: Consolidate qdev_get_human_name() into
 qdev_get_printable_name()
In-Reply-To: <20260308160040.354186-2-alessandro@0x65c.net> (Alessandro
 Ratti's message of "Sun, 8 Mar 2026 17:00:41 +0100")
References: <20260308160040.354186-2-alessandro@0x65c.net>
Date: Tue, 10 Mar 2026 13:27:20 +0100
Message-ID: <87jyvjamzb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> Hello,
>
> This patch consolidates qdev_get_human_name() and qdev_get_printable_name()
> into a single function, as suggested by Peter Maydell here [1]
>
> This patch is based on Peter's recent series and should be applied after [2]:
> - "hw/qdev: Document qdev_get_dev_path()"  
> - "hw: Make qdev_get_printable_name() consistently return freeable string"

Use

  Based-on: <20260307155046.3940197-1-peter.maydell@linaro.org>

so that tools like patchew can apply patches without human intervention.

> Thank you for your time and consideration.
>
> Best regards
> Alessandro
>
> [1]: https://lore.kernel.org/qemu-devel/aNLIHOwcGB47qbUY@redhat.com/T/#m89da9b4e30b7c84713ca4b6c323514c72897e649
> [2]: https://lore.kernel.org/qemu-devel/20260307155046.3940197-1-peter.maydell@linaro.org/T/#m962127cb58192e0b2095039cb2fb79145f2a7388
>
> ---

git-am uses part above the --- line as commit message.  That's clearly
not what you intended.

To fix it, put your introduction ...


> Remove qdev_get_human_name() and use qdev_get_printable_name() for all
> device identification in error messages.

I think qdev_get_human_name() is the nicer name of the two.  Matter of
taste.

> Both functions now behave similarly, with qdev_get_printable_name()

Both functions?  You remove one!

> preferring bus-specific paths (e.g., PCI addresses) when available
> before falling back to QOM canonical paths. This provides better
> context in error messages while maintaining the same level of detail.
>
> Error messages will now show device identifiers in this priority:
> 1. User-specified device IDs (e.g., -device virtio-blk,id=foo)
> 2. Bus-specific identifiers (e.g., PCI addresses like 0000:00:04.0)
> 3. QOM canonical paths as a last resort
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---

... here instead.  Or simply use a cover letter.

>  hw/block/block.c       |  5 ++---
>  hw/core/qdev.c         | 19 ++++++++-----------
>  include/hw/core/qdev.h | 13 -------------
>  3 files changed, 10 insertions(+), 27 deletions(-)
>
> diff --git a/hw/block/block.c b/hw/block/block.c
> index f187fa025d..84e5298e2f 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -65,7 +65,6 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
>  {
>      int64_t blk_len;
>      int ret;
> -    g_autofree char *dev_id = NULL;
>  
>      if (cpr_is_incoming()) {
>          return true;
> @@ -78,7 +77,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
>          return false;
>      }
>      if (blk_len != size) {
> -        dev_id = qdev_get_human_name(dev);
> +        g_autofree const char *dev_id = qdev_get_printable_name(dev);
>          error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
>                     " bytes, %s block backend provides %" PRIu64 " bytes",
>                     object_get_typename(OBJECT(dev)), dev_id, size,

I believe this plugs a memory leak.  Separate patch, please, with

  Fixes: 954b33daee83 (hw/block/block.c: improve confusing blk_check_size_and_read_all() error)

> @@ -95,7 +94,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, DeviceState *dev,
>      assert(size <= BDRV_REQUEST_MAX_BYTES);
>      ret = blk_pread_nonzeroes(blk, size, buf);
>      if (ret < 0) {
> -        dev_id = qdev_get_human_name(dev);
> +        g_autofree const char *dev_id = qdev_get_printable_name(dev);
>          error_setg_errno(errp, -ret, "can't read %s block backend"
>                           " for %s device '%s'",
>                           blk_name(blk), object_get_typename(OBJECT(dev)),

Likewise.

> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index e48616b2c6..9ee98a0c39 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -434,10 +434,15 @@ const char *qdev_get_printable_name(DeviceState *vdev)
   const char *qdev_get_printable_name(DeviceState *vdev)

Nitpick: @vdev is an unusual identifier.  Please use @dev like the code
nearby.

   {
       /*
        * Return device ID if explicity set
        * (e.g. -device virtio-blk-pci,id=foo)
        * This allows users to correlate errors with their custom device
        * names.
        */

I doubt this comment is worth its keep.

       if (vdev->id) {
           return g_strdup(vdev->id);
       }
       /*
        * Fall back to the canonical QOM device path (eg. ID for PCI
        * devices).

This comment is mostly nonsense: there's no such thing as a "canonical
QOM device path".  There's a canonical QOM path (the path from root to
object in the QOM composition tree), but qdev_get_dev_path() doesn't
return it.

        * This ensures the device is still uniquely and meaningfully
        * identified.
        */
       const char *path = qdev_get_dev_path(vdev);
       if (path) {
           return path;

This returns a "name" in a bus-specific format if the device is plugged
into a bus that provides the get_dev_path() method.  Many buses do.

For instance, the PCI bus's method is pcibus_get_dev_path().  It appears
to return a path of the form

    Domain:00:Slot.Function:Slot.Function....:Slot.Function.

which is commonly just a PCI address.

Intepreting the value can be difficult: we have some twenty
.get_dev_path() methods, and each of them can format however it wants.
I need to guess the format to make sense of the value.

Could we do something like "<bus> device <dev-path>"?  E.g.

    PCI device 0000:00:00.0

>      }
>  
>      /*
> -     * Final fallback: if all else fails, return a placeholder string.
> -     * This ensures the error message always contains a valid string.
> +     * Final fallback: return the canonical QOM path.
> +     * While verbose (e.g., /machine/peripheral-anon/device[0]), this
> +     * provides accurate device identification when neither a user-specified
> +     * ID nor a bus-specific path is available. Only falls back to
> +     * <unknown device> in the extremely rare case where even the QOM
> +     * path is unavailable.

This case isn't "extremely rare", it should never happen.
object_get_canonical_path(vdev) can only return null when @dev qom_path
can only be null when @vdev is not part of the QOM composition tree.

>       */
> -    return g_strdup("<unknown device>");
> +    char *qom_path = object_get_canonical_path(OBJECT(vdev));
> +    return qom_path ? qom_path : g_strdup("<unknown device>");

qom_path should never be null, and I wouldn't bother with a fallback.
This is not a demand.  If you want a fallback, consider something like

    g_strdup_printf("bad device %p").

This patch does two things: improve qdev_get_printable_name(), and
replace qdev_get_human_name().  Please split it.

>  }
>  
>  void qdev_add_unplug_blocker(DeviceState *dev, Error *reason)
> @@ -867,14 +872,6 @@ Object *machine_get_container(const char *name)
>      return container;
>  }
>  
> -char *qdev_get_human_name(DeviceState *dev)
> -{
> -    g_assert(dev != NULL);
> -
> -    return dev->id ?
> -           g_strdup(dev->id) : object_get_canonical_path(OBJECT(dev));
> -}
> -
>  static MachineInitPhase machine_phase;
>  
>  bool phase_check(MachineInitPhase phase)
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index f99a8979cc..09dafd3d59 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -1045,19 +1045,6 @@ void qdev_create_fake_machine(void);
>   */
>  Object *machine_get_container(const char *name);
>  
> -/**
> - * qdev_get_human_name() - Return a human-readable name for a device
> - * @dev: The device. Must be a valid and non-NULL pointer.
> - *
> - * .. note::
> - *    This function is intended for user friendly error messages.
> - *
> - * Returns: A newly allocated string containing the device id if not null,
> - * else the object canonical path.
> - *
> - * Use g_free() to free it.
> - */
> -char *qdev_get_human_name(DeviceState *dev);

Please add a similarly nice contract to qdev_get_printable_name().

>  
>  /* FIXME: make this a link<> */
>  bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp);


