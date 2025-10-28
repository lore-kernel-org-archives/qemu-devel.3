Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327F0CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmWi-0006MQ-Jj; Tue, 28 Oct 2025 12:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDmWc-0006Kx-Vg
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:26:23 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDmWT-0002WE-FX
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:26:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3117780D47;
 Tue, 28 Oct 2025 19:26:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:582::1:19] (unknown
 [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2Qg7Ot1Iu0U0-XEXNkrUD; Tue, 28 Oct 2025 19:26:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761668763;
 bh=FuE1uMbjVKnu1hb4rDzTeTnCg5KPeTPUkq6ix2OQ3Jo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=L/hA9bYz0BIfETh6PPsO09/H3rJLFBZg5O7EMOFaMpSMkUX9lTjqYh9ur9nYPXi+V
 CrFvvenkJWCh8YWsgMyolFMCQ12u77DFgemCnqbMF91ZrBG+BPBmWdyhgzUkTaZuMj
 IYojk8ZbilL83K5K0LVnky7IqSsytsaIjNHrvu+M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <25bfee38-9119-4512-9288-08c46a59acdc@yandex-team.ru>
Date: Tue, 28 Oct 2025 19:26:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
To: Peter Xu <peterx@redhat.com>
Cc: armenon@redhat.com, Markus Armbruster <armbru@redhat.com>,
 stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
 <87o6psocib.fsf@pond.sub.org>
 <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
 <aP-eHzbAtvNp3N3d@armenon-kvm.bengluru.csb>
 <591eebe5-0445-4b16-8f2e-280602ab480b@yandex-team.ru>
 <aQDdRn8t0B8oE3gf@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aQDdRn8t0B8oE3gf@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28.10.25 18:12, Peter Xu wrote:
> On Mon, Oct 27, 2025 at 08:06:04PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Understand.. So we don't know, does any caller use this ENOMEM, or not. And want to save
>> a chance for bulk conversion.
>>
>> And blind bulk conversion of all -errno to simple true/false may break something, we
>> don't know.
>>
>> Reasonable. Thanks for the explanation.
> 
> Taking vmstate_load_state() as example: most of its callers should
> ultimately route back to the top of vmstate_load_state() that migration
> code invokes.
> 
> AFAIU, migration itself doesn't care much so far on the retval, but only
> succeeded or not, plus the errp as a bonus.  There's one thing exception
> that I remember but it was removed in commit fd037a656aca..  So now I
> cannot find anything relies on that.
> 
> Here's a list of all current vmstate_load_state() callers:
> 
> *** hw/display/virtio-gpu.c:
> virtio_gpu_load[1358]          ret = vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &err);
> 
> *** hw/pci/pci.c:
> pci_device_load[943]           ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> 
> *** hw/s390x/virtio-ccw.c:
> virtio_ccw_load_config[1146]   ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
> 
> *** hw/scsi/spapr_vscsi.c:
> vscsi_load_request[657]        rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
> 
> Until here, it's invoked in a get() callback of VMStateInfo.  Ultimately,
> it goes back to migration's vmstate_load_state() invokation.
> 
> *** hw/vfio/pci.c:
> vfio_pci_load_config[2840]     ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> 
> This is special as it's part of load_state().  However it's the same, it
> routes back to vmstate_load() instead (where vmstate_load_state()
> ultimately also routes there).  So looks safe too.
> 
> *** hw/virtio/virtio-mmio.c:
> virtio_mmio_load_extra_state[630] ret = vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &local_err);
> 
> *** hw/virtio/virtio-pci.c:
> virtio_pci_load_extra_state[205] ret = vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &local_err);
> 
> *** hw/virtio/virtio.c:
> virtio_load[3394]              ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
> virtio_load[3402]              ret = vmstate_load_state(f, &vmstate_virtio, vdev, 1, &local_err);
> 
> More get() users.  Same.
> 
> *** migration/cpr.c:
> cpr_state_load[266]            ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1, errp);
> 
> This is special, ignoring retval but using error_abort.  New one, safe.
> 
> *** migration/savevm.c:
> vmstate_load[978]              return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
> qemu_loadvm_state_header[2885] ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
> 
> This is the migration core invokations.  Safe.
> 
> *** migration/vmstate-types.c:
> get_tmp[562]                   ret = vmstate_load_state(f, vmsd, tmp, version_id, &local_err);
> get_qtailq[670]                ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
> get_gtree[833]                 ret = vmstate_load_state(f, key_vmsd, key, version_id, &local_err);
> get_gtree[840]                 ret = vmstate_load_state(f, val_vmsd, val, version_id, &local_err);
> get_qlist[921]                 ret = vmstate_load_state(f, vmsd, elm, version_id, &local_err);
> 
> These are special get() for special VMSD fields.  Safe.
> 
> *** migration/vmstate.c:
> vmstate_load_state[208]        ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> vmstate_load_state[212]        ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
> vmstate_subsection_load[652]   ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
> 
> Same migration core invokations. Safe.
> 
> *** tests/unit/test-vmstate.c:
> load_vmstate_one[123]          ret = vmstate_load_state(f, desc, obj, version, &local_err);
> test_load_v1[377]              ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 1, &local_err);
> test_load_v2[408]              ret = vmstate_load_state(loading, &vmstate_versioned, &obj, 2, &local_err);
> test_load_noskip[512]          ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
> test_load_skip[541]            ret = vmstate_load_state(loading, &vmstate_skipping, &obj, 2, &local_err);
> test_load_q[815]               ret = vmstate_load_state(fload, &vmstate_q, &tgt, 1, &local_err);
> test_gtree_load_domain[1174]   ret = vmstate_load_state(fload, &vmstate_domain, dest_domain, 1,
> test_gtree_load_iommu[1294]    ret = vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1, &local_err);
> test_load_qlist[1434]          ret = vmstate_load_state(fload, &vmstate_container, dest_container, 1,
> 
> Test code only.  Safe.
> 
> *** ui/vdagent.c:
> get_cbinfo[1013]               ret = vmstate_load_state(f, &vmstate_cbinfo_array, &cbinfo, 0,
> 
> Yet another get().  Safe.
> 
> So.. even if I'm not sure if a bulk conversion could happen or not (the
> get() users above would be very tricky because get() doesn't allow errp so
> far.. unless we introduce that too), but other than that, afaict,
> vmstate_load_state() callers do not yet care about retvals.
> 

Uhh, great analysis! With it, we can proceed with my patch. And may be, just change return value of vmstate_load_state to bool? To avoid analyzing it again in future.

-- 
Best regards,
Vladimir

