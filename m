Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41750E8536F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8gAI-000899-H0; Fri, 03 Apr 2026 11:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w8gAF-00086Z-4Z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:10:27 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w8gAC-0000Yl-N5
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:10:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2008:0:640:480d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4ED0EC01EF;
 Fri, 03 Apr 2026 18:10:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d4c::1:2b] (unknown
 [2a02:6bf:8080:d4c::1:2b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IAfmpX0K5mI0-fozubs6z; Fri, 03 Apr 2026 18:10:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1775229018;
 bh=Dszo96Rqq7VC7o7Rk/jNRIX+o5bL7rFVMwyU17OdRWc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=z00OG16WV+duzK27Jg5SzGCXbgUBGGfia81MCBSRgUL88UAeKQZJiG50WYwaK1NpH
 MH5+0LzP3XpoFvih2PA8/wKb4mafVihrvNZlg/+9YH+zerYb5ipYcFXnsjEvFHmxDt
 ZBUGS4/UCjjkzR0+koqqBZLh1lLOM/KdLbrSe25Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <70bdb32a-3a9c-4674-980d-1f94612c62ea@yandex-team.ru>
Date: Fri, 3 Apr 2026 18:10:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: fix wrong index for postcopy_client_bases
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael.norwitz@nutanix.com,
 swapnil.ingle@nutanix.com, peter.turschm@nutanix.com, cui@nutanix.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260403093411.1431802-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260403093411.1431802-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 03.04.26 12:34, Vladimir Sementsov-Ogievskiy wrote:
> u->postcopy_client_bases[i] corresponds to dev->mem->regions[i], not
> to u->shadow_regions[i]. So we should use j-index, following indexation
> of dev->mem->regions.
> 
> Fixes: f1aeb14b0809e313c7424 "Transmit vhost-user memory regions individually"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Hi all!
> 
> Honestly, I don't follow the logic of vhost-user postcopy, but I can't
> believe, that the same array should be used in different indexing
> semantics.
> 
>   hw/virtio/vhost-user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index a8907cca74e..91de08a5128 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -602,7 +602,7 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
>                       if (fd > 0) {
>                           u->region_rb_offset[j] = offset;
>                           u->region_rb[j] = mr->ram_block;
> -                        shadow_pcb[j] = u->postcopy_client_bases[i];
> +                        shadow_pcb[j] = u->postcopy_client_bases[j];
>                       } else {
>                           u->region_rb_offset[j] = 0;
>                           u->region_rb[j] = NULL;


Hmm, now I think, that postcopy + CONFIGURE_MEM_SLOTS is totally broken
both in protocol and in the code.

Look:

for VHOST_USER_SET_MEM_TABLE we have not in the spec:

.. Note::
    ``NEED_REPLY_MASK`` is not set in this case.  QEMU will then
    reply back to the list of mappings with an empty
    ``VHOST_USER_SET_MEM_TABLE`` as an acknowledgement; only upon
    reception of this message may the guest start accessing the memory
    and generating faults.


and in code we do in vhost_user_set_mem_table_postcopy():

         msg.hdr.size = sizeof(msg.payload.u64);
         msg.payload.u64 = 0; /* OK */
         ret = vhost_user_write(dev, &msg, NULL, 0);
         if (ret < 0) {
             return ret;
         }

Note, that msg.hdr.request is set to VHOST_USER_SET_MEM_TABLE by
vhost_user_fill_set_mem_table_msg() call.



But when CONFIGURE_MEM_SLOTS is negotiated we don't use VHOST_USER_SET_MEM_TABLE
message, instead we use VHOST_USER_REM_MEM_REG and VHOST_USER_ADD_MEM_REG.

for VHOST_USER_REM_MEM_REG we have nothing about postcopy in documentation,
and for VHOST_USER_ADD_MEM_REG we have only:

   In postcopy mode (see ``VHOST_USER_POSTCOPY_LISTEN``), the back-end
   replies with the bases of the memory mapped region to the front-end.
   For further details on postcopy, see ``VHOST_USER_SET_MEM_TABLE``.
   They apply to ``VHOST_USER_ADD_MEM_REG`` accordingly.

how should it work about "an acknowledgement"? Should QEMU send
an empty VHOST_USER_SET_MEM_TABLE ? And when?


Let's see what we have in code:

vhost_user_add_remove_regions() {

    if (nr_rem_reg) { send_remove_regions() }

    if (nr_add_reg) { send_add_regions() }

    ... and for postcopy:

    msg->hdr.size = sizeof(msg->payload.u64);
    msg->payload.u64 = 0; /* OK */

    ret = vhost_user_write(dev, msg, NULL, 0);
    if (ret < 0) {
        return ret;
    }


Note that:

1. We send only one acknowledgement, after sending several (or zero)
    ADD/REM requests.

2. We send an acknowledgement with request set to either VHOST_USER_ADD_MEM_REG,
    or VHOST_USER_REM_MEM_REG, or zero (if bot nr_rem_reg and nr_add_reg are zero).


I think, it far far away from documentation. And it can't be simply "fixed". If we
need postcopy for CONFIGURE_MEM_SLOTS case, the protocol extension to support it
should first be invented.


I think, it would be correct to abandon using postcopy together with CONFIGURE_MEM_SLOTS
for now, and document that behavior of server is actually unpredictable if use postcopy
commands together with CONFIGURE_MEM_SLOTS negotiated.

-- 
Best regards,
Vladimir

