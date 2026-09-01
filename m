Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448ACC624D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OTk-0001Fu-Gz; Tue, 01 Sep 2026 09:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x1OTQ-0000zi-Gk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:24:25 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x1OTN-0008Sk-Ga
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:24:24 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-92e68aec5f7so45031485a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788269060; cv=none;
 d=google.com; s=arc-20260327;
 b=lotDaPVD9Kvhqn9iP+Htg4tbxv6+KbecwtUGEQq+jWt7uPrVJUvklVWpxNuC1NYnsa
 1wPVMbtl7JWLKzmtBLTm/lVbcf2vuNmZ1oIN7HpZ03AdgchlO4dX6iPFZGojR3A3r5HN
 PplkBXJEBX3d3ob92D0EYarDt/GXD5XHzqjoCXZHvbmo8dGedpQ+YjkFixqf4nC3O32X
 5bmbuEwQX5EMxGrgJS1Z9qUFR/mRpYojMN/+TiFjRATjTaUH1pJsIqWUYuOTSdEX2b2P
 0tyoOvxbQ8QXhpXc2Gh9n8R85Ex00jrik5JRHLy/z6TGqz3pwzC1MB/Yam+bGSN02LOH
 zsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jFHMMfU/AABciGdqX2FL1/tNVxxbuj4u342GE4yPMbU=;
 fh=G53S9XEToP2DyVd8XZNGLTSGh8fHoRs6BuIsIvHfAJY=;
 b=f4eQby8bCENjIr4og4w0Je8Wb8xF5Pn6OViJZvTIhzvpCbDeV4R5xWDjW+ijjnZoBd
 xuwumEVf9rKJYs0UeSQe0datLwigiImvDGUtMMxsdgHGZ4Qmi4tKwWoqiOg45RB13c0B
 LqMooPodXUybFfGoAQHh9O1lelQ7uai1BKlMT82Gheqb48EswfrbQ0pjZTX4zotjTlbI
 0gtL58cUd5oLlWVBgdu22OgBZLLGVrnXwx0Q7nkwgV0BWPW0A/F32YDT9LJAlPlkENVz
 rwtkBdlkS8oVLU+7RQyN9ke8zOfPF1SEkmxRh02QqySZbh8A2wAHeBeKNwUWYe7gacrX
 ptfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788269060; x=1788873860; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jFHMMfU/AABciGdqX2FL1/tNVxxbuj4u342GE4yPMbU=;
 b=r5Lyr3kHIbO1ZT7OUPGkolDzudSWaq1/mF/TvD7Uuh4pjMo0MmLzl1hmfKQPlUL/om
 jtDuQnbSYgSKVN+FaChPbl3qi9x57K2q5S8rGZPYWWXnluG7qMDMWJ1nxqsEIcWvYUQK
 xvNzcJUZEUoR2R091BZKCdi/J+kD/LkKuHsgICuX+K6QBXEZr/v/g+NRkFdhTExHfsCb
 GP5LWwk/cFir+dNlp9xVmllBbq0193LzyO/a92NfxUV/VoqeYCOlEORt7hR56xNzVKjQ
 dnyGaOuBYs17zKnol6IzzPGbOypmge5PE28N+2NqZQ53zpvlduNWPNwHu6rLle90bPgC
 5n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788269060; x=1788873860;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jFHMMfU/AABciGdqX2FL1/tNVxxbuj4u342GE4yPMbU=;
 b=fYhScTwP02reGt0OvEHxzHqwKkDhsIkWlPiTaWFflHTocC7hs1ovQi1IhBm7oIysOO
 YkmfJoy4yKLQJkrsDj3FbY+dF6HVstgxNcvcwKUFMnRhz8bQ7gx5TNWyIorESDtjQzQp
 BxcTJvsuyZpCg+NM+8JfwtgRoknP9EvIUgRY53ZdK/k4yROkcKGGsGUQwff54bLrnvEW
 5XQlw+Nf1wY2Pb1D8Pv0lu49ZApkQ2TWFjwID83v9dyGkufsEnHnO5TQol8qEj3OWQQW
 O5YxD+XPq/tzRHMMpZl4jrgVp4K8bxQVanU7Khj3ZQ7m6xTCFXeqCvyivO5m6Q3MlVKh
 wxww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJZLwdd1C71Gtp4CeTKPifvbQFwoFDOc3tPKUbxYZuORnjnqxPtw25H8uZ68mcA21h9fNbRp24A4Is@nongnu.org
X-Gm-Message-State: AFuF++mn3jS37K89jGcGmEezOAGcCV8m6W3N+pWJUvk7ziSJEQI1Zi/+
 24/Qq9BaHmrn+yeZoTBNpFi3alKGeNaCMJBSuGqZq6dcv/XvzfWd2wzvszUcAfzQjnv7PhzIX/m
 qCUJqQAqcszKt1BdRGrkHbQtElLhgAxvKw2tHsRE=
X-Gm-Gg: AYBFou2aWUsZVkH/lAUugZDlJIMSwWCaiZ7ZFj0dt0cQKtSMoeqQG9dIjSN4++/vq/i
 TFDZiG+1mMiZtFMwpDr7AoSe9czGGfaWyiRapn6c/4+jP2heclO/IDeqMiaZB3l4FaHmhb9wYD1
 PUzt/SyrWqE7hyLIJ+fTGqhlrX/yMfex83XmfW0GyXT5IIvcqc8pPuacrB0oPuJ5N4mRa+Vkhb0
 mNGwB2K4nMrqo+hciEAi6vphe1y4ksG/acI65G9FwstwWF10uwb3LwndFHOZxM3rXO9VxihMmKv
 u7m9lvzBCS8RQjMLhlaeeUeCtULDsSeeV+zPVn8HCQkF
X-Received: by 2002:a05:6214:2687:b0:90e:8f1a:1bde with SMTP id
 6a1803df08f44-90e8f1a1c1bmr85936996d6.1.1788269059991; Tue, 01 Sep 2026
 06:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
 <20260805124519.30054-4-danielpaziyski@gmail.com>
 <20260901071543-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260901071543-mutt-send-email-mst@kernel.org>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Tue, 1 Sep 2026 15:24:08 +0200
X-Gm-Features: AcwNN1XhKXZ6JRpRE4pXBxZcp6RDvzJ-sEs2antG91DybmPkxT5Rm4ys13E006Q
Message-ID: <CANukVxvZMPp_1ZkZzmrE1pSAryW7DWpBOOWV5=QUmnQf3LH48Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] pcie_sriov: register user created virtual function
 before realizing it
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-stable@nongnu.org, 
 Jesper Devantier <foss@defmacro.it>, "open list:nvme" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 1 Sept 2026 at 13:19, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 05, 2026 at 02:45:18PM +0200, Daniel Paziyski wrote:
>> There are two ways of creating virtual functions: by using the sriov-pf device
>> parameter (this way, creating a user created VF and binding it to a PF), or
>> by using a device specific parameter, where the device manually creates a given
>> amount of VFs.
>>
>> When a PCI device is realized, the device specific realize function is called
>> first, and then the pcie_sriov_register_device function is called, which checks
>> whether the device that has been created is a user created VF, and if it is the
>> case and the device allows this kind of VFs, it inserts it into a hashmap, with
>> the key being the ID of the PF, and the items being arrays of VFs.
>>
>> User created VFs are instantiated independently, and later, when the PF calls
>> pcie_sriov_pf_init_from_user_created_vfs, it discovers its VFs from the hashmap
>> mentioned previously, and sets up in their PCIDevice.ex.sriov_pf structure
>> the pointer to the PF. This means that, during realization, VFs have no access
>> to the PF.
>>
>> Device created VFs are instantiated during or after PF realization using the
>> pcie_sriov_pf_init function, which sets up for the VFs the pointer to the PF
>> before their realization, so when they're realized, they can access the PF
>> with no issues.
>>
>> The problem here is that pcie_sriov_register_device is called after the
>> realization, and not before. This means that when a user created VF is created
>> for a device which does not support user created VFs, but supports device
>> created VFs, the realize function will notice that a VF is being created, and
>> may try to access the PF, causing a null pointer dereference fault.
>>
>> Fix this by placing the user created VF check and registering before the
>> realization. This way, incorrectly created user created VFs will be noticed,
>> and device creation will be aborted.
>>
>> Additionally, remove from the pcie_sriov_register_device function the top
>> check. It seems that this check is done to error out if the PF failed for some
>> reason to initialize its list of user created VFs. However, in such situations,
>> the pcie_sriov_pf_init_from_user_created_vfs function will error during
>> realization, and it will be caught before the check is done at all. Moreover,
>> since now pcie_sriov_register_device is called before realization, the check
>> will always fail for PFs with user created VFs, because the list will be
>> populated during realization.
>>
>> The rest of the function though, correctly errors out if a user created VF
>> is created for an unsupported device type, if a VF is created for a non-PCIe
>> device, or if the PF is already instantiated, with now the advantage being
>> that the check is done before the VF instantiation.
>>
>> When instantiating a user created VF for a NVME controller:
>>
>> Command line:
>>
>>     qemu-system-x86_64 -device nvme-subsys,id=subsys0 \
>>     -device nvme,id=vctrl0,sriov-pf=ctrl0,subsys=subsys0 \
>>     -device nvme,id=ctrl0,subsys=subsys0,serial=s
>>
>> ASAN splat:
>>
>> ../hw/nvme/ctrl.c:9613:28: runtime error: member access within null pointer of type 'struct NvmeCtrl'
>> AddressSanitizer:DEADLYSIGNAL
>> =================================================================
>> ==91050==ERROR: AddressSanitizer: SEGV on unknown address 0x000000001cf0 (pc 0x7f79a8573dcd bp 0x7ffd622c1bc0 sp 0x7ffd622c1b68 T0)
>> ==91050==The signal is caused by a READ memory access.
>>     #0 0x7f79a8573dcd  (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>>     #1 0x5644c6c0266e in nvme_realize ../hw/nvme/ctrl.c:9613
>>     #2 0x5644c6c67213 in pci_qdev_realize ../hw/pci/pci.c:2316
>>     #3 0x5644c7a2cfc1 in device_set_realized ../hw/core/qdev.c:514
>>     #4 0x5644c7a4f767 in property_set_bool ../qom/object.c:2484
>>     #5 0x5644c7a48d0b in object_property_set ../qom/object.c:1548
>>     #6 0x5644c7a568a5 in object_property_set_qobject ../qom/qom-qobject.c:28
>>     #7 0x5644c7a49385 in object_property_set_bool ../qom/object.c:1618
>>     #8 0x5644c7a2aeb0 in qdev_realize ../hw/core/qdev.c:277
>>     #9 0x5644c735f29f in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
>>     #10 0x5644c735f3ab in qdev_device_add ../system/qdev-monitor.c:758
>>     #11 0x5644c72b1901 in device_init_func ../system/vl.c:1217
>>     #12 0x5644c829d4a3 in qemu_opts_foreach ../util/qemu-option.c:1148
>>     #13 0x5644c72bc33e in qemu_create_cli_devices ../system/vl.c:2762
>>     #14 0x5644c72bcaa1 in qmp_x_exit_preconfig ../system/vl.c:2822
>>     #15 0x5644c72c3241 in qemu_init ../system/vl.c:3862
>>     #16 0x5644c801abf8 in main ../system/main.c:71
>>     #17 0x7f79a8427780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>>     #18 0x7f79a84278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>>     #19 0x5644c5f0a1f4 in _start (BuildId: 8483f952216d9e345c3744300d0aefa38feb50d7)
>>
>> ==91050==Register values:
>> rax = 0x00007e49988640f0  rbx = 0x00007e49988640f0  rcx = 0x00000fc9b3104828  rdx = 0x0000000000000058
>> rdi = 0x00007e49988640f0  rsi = 0x0000000000001cf0  rbp = 0x00007ffd622c1bc0  rsp = 0x00007ffd622c1b68
>>  r8 = 0x00000fc9b3104829   r9 = 0x00000fc9b3104828  r10 = 0x00000fc9b310481e  r11 = 0x00000fc9b310481e
>> r12 = 0x0000000000001cf0  r13 = 0x00000f6f32e78578  r14 = 0x00000000ffffffff  r15 = 0x00007ffd622c1c10
>> AddressSanitizer can not provide additional info.
>> SUMMARY: AddressSanitizer: SEGV (/usr/lib/libc.so.6+0x173dcd) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
>> ==91050==ABORTING
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 19e55471d4e8 ("pcie_sriov: Allow user to create SR-IOV device")
>> Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
>> ---
>>  hw/pci/pci.c        | 11 ++++++-----
>>  hw/pci/pcie_sriov.c |  6 ------
>>  2 files changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index d3191609e2..a5b4482bb6 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2312,20 +2312,21 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>      if (pci_dev == NULL)
>>          return;
>>
>> +    if (!pcie_sriov_register_device(pci_dev, errp)) {
>> +        do_pci_unregister_device(pci_dev);
>
>
> This skips acpi-index rollback which pci_qdev_unrealize currently does.
> Needs generic PCI cleanup.

I see. pci_qdev_unrealize unregisters the device's acpi-index after calling
do_pci_unregister_device. What do you think if I moved the snippet for
unregistering the acpi-index to a new function, and then call it in
do_pci_unregister_device?

Moreover, this would fix the fact that in do_pci_register_device and outside of
it the acpi-index is not released in case of failure, since this new function
could then be called if necessary, if do_pci_unregister_device is not called.

Additionally, while I'm at it, why don't I move pcie_sriov_unregister_device to
do_pci_unregister_device? This way, I avoid calling it explicitly in
pci_qdev_realize, which is necessary now because user created VFs are registered
before realization.

Regards,
Daniel

>
>
>> +        return;
>> +    }
>> +
>>      if (pc->realize) {
>>          pc->realize(pci_dev, &local_err);
>>          if (local_err) {
>>              error_propagate(errp, local_err);
>> +            pcie_sriov_unregister_device(pci_dev);
>>              do_pci_unregister_device(pci_dev);
>>              return;
>>          }
>>      }
>>
>> -    if (!pcie_sriov_register_device(pci_dev, errp)) {
>> -        pci_qdev_unrealize(DEVICE(pci_dev));
>> -        return;
>> -    }
>> -
>>      /*
>>       * A PCIe Downstream Port that do not have ARI Forwarding enabled must
>>       * associate only Device 0 with the device attached to the bus
>> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
>> index c41ac95bee..69930c7b8c 100644
>> --- a/hw/pci/pcie_sriov.c
>> +++ b/hw/pci/pcie_sriov.c
>> @@ -357,12 +357,6 @@ int16_t pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev,
>>
>>  bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
>>  {
>> -    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
>> -        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
>> -        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
>> -        return false;
>> -    }
>> -
>>      if (dev->sriov_pf) {
>>          PCIDevice *pci_pf;
>>          GPtrArray *pf;
>> --
>> 2.55.0
>

